const express = require('express');
const Joi = require('joi');
const app = express();
const cors = require('cors');
const queries = require('./data/queries');

app.use(cors())
app.use(express.json());

app.get('/', (req, res) => {
    res.send('Codegems Insights REST API');
});

app.get('/api/moods', (req,res)=> {
    queries.getAll('demo_mood').then(moods => {
        res.json(moods);
    });
});

app.get('/api/inspirations', (req,res)=> {
    queries.getAll('demo_insight').then(insights => {
        res.json(insights);
    });
});

app.get('/api/persons', (req,res)=> {
    queries.getAll('demo_person').then(persons => {
        res.json(persons);
    });
});

app.get('/api/survey/campaign/:surveyId/:userId', (req, res) => {
    queries.getAllSurveyCampaign(req.params.surveyId,req.params.userId).then((campaignList) => {
        if (campaignList) {
            res.json(campaignList);
        } else {
            return res.sendStatus(401);
        }
    });
});

app.post('/api/survey/campaign', (req, res)=> {
    queries.createInsight(req.body).then((status) => {
        res.json(status);
    })
});

app.post('/api/insight', (req, res)=> {

    const { error , data} = validateInsight(req.body);

    if (error) {
        res.status(422).json({
            status: 'error',
            message: 'Invalid request data',
            data: data
        });
    } else {
        res.json({
            status: 'success',
            message: 'Insight created successfully',
            data: Object.assign({id}, data)
        });
    }

});

function validateInsight(insight) {
    console.log(insight);

    const schema = Joi.object({
        insightList: Joi.array().required(),
        moodList: Joi.array().required(),
        insightPerson: Joi.string().optional(),
        insightNote: Joi.string().optional()
    });

    return schema.validate(insight);

}

const port = process.env.PORT || 3090;
app.listen(port, () => console.log(`Listening on port ${port}..`));