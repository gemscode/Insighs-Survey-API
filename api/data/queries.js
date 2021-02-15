const knex = require('./db');

module.exports = {
	getAll(table) {
		return knex(table);
	},

	async getAllSurveyCampaign(surveyId,userId) {
		let campaignList = await knex('demo_survey_campaign').where('survey_id', surveyId).andWhere('user_id', userId);

		try {
			return campaignList;
		} catch (e) {
			console.error(e);
			return {error: "Something wrong happened ..."}
		}
	},

	async getMood(moodId) {
		let getMood = await knex('demo_mood').where('id', moodId);
		let mood = getMood[0];
		try {
			return mood;
		} catch (e) {
			console.error(e);
			return {error: "Something wrong happened ..."}
		}
	},

	async createInsight(insight) {
		try {
			let status = await knex.transaction(trx => {
				return knex.raw(
					'Call ins_survey_campaign(?)',
					[insight]
				)
			});
			console.log(status)
			return status;
		} catch (e) {
			console.error(e);
			return {error: "Something wrong happened ..."}
		}
	},
}
