Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E45C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F8C620809
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389272AbgEMP0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:26:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2205 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731638AbgEMP0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:26:37 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 9CF1E36D2772B07885EB;
        Wed, 13 May 2020 16:26:35 +0100 (IST)
Received: from [127.0.0.1] (10.210.165.35) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 13 May
 2020 16:26:33 +0100
Subject: Re: [PATCH 2/2] perf test: Improve pmu event metric testing
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Stephane Eranian <eranian@google.com>
References: <20200513062236.854-1-irogers@google.com>
 <20200513062236.854-2-irogers@google.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ac88604a-56c2-b632-57c2-3bee316dcea7@huawei.com>
Date:   Wed, 13 May 2020 16:25:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200513062236.854-2-irogers@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.165.35]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2020 07:22, Ian Rogers wrote:
> Break pmu-events test into 2 and add a test to verify that all pmu metric
> expressions simply parse. Try to parse all metric ids/events, failing if
> metrics for the current architecture fail to parse.
> 
> Tested on power9, skylakex, haswell, broadwell, westmere, sandybridge and
> ivybridge with the patch set in place.
> May fail on other architectures if metrics are invalid. In particular s390
> is untested, but its expressions are trivial. The event encodings could
> be wrong. The other untested architectures with expressions are power8,
> cascadelakex, tremontx, skylake, jaketown, ivytown and variants of
> haswell and broadwell. For these the expression encoding is valid but
> the event encodings may not be.
> 

Out of interest, if we could move the validation of metrics to jevents, 
how much functionality would we still have here?

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/tests/builtin-test.c |   5 +
>   tools/perf/tests/pmu-events.c   | 158 ++++++++++++++++++++++++++++++--
>   tools/perf/tests/tests.h        |   2 +
>   3 files changed, 159 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 3471ec52ea11..8147c17c71ab 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -75,6 +75,11 @@ static struct test generic_tests[] = {
>   	{
>   		.desc = "PMU events",
>   		.func = test__pmu_events,
> +		.subtest = {
> +			.get_nr		= test__pmu_events_subtest_get_nr,
> +			.get_desc	= test__pmu_events_subtest_get_desc,
> +		},
> +
>   	},
>   	{
>   		.desc = "DSO data read",
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index d64261da8bf7..c18b9ce8cace 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -8,6 +8,10 @@
>   #include <linux/zalloc.h>
>   #include "debug.h"
>   #include "../pmu-events/pmu-events.h"
> +#include "util/evlist.h"
> +#include "util/expr.h"
> +#include "util/parse-events.h"
> +#include <ctype.h>
>   
>   struct perf_pmu_test_event {
>   	struct pmu_event event;
> @@ -144,7 +148,7 @@ static struct pmu_events_map *__test_pmu_get_events_map(void)
>   }
>   
>   /* Verify generated events from pmu-events.c is as expected */
> -static int __test_pmu_event_table(void)
> +static int test_pmu_event_table(void)
>   {
>   	struct pmu_events_map *map = __test_pmu_get_events_map();
>   	struct pmu_event *table;
> @@ -347,14 +351,11 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
>   	return res;
>   }
>   
> -int test__pmu_events(struct test *test __maybe_unused,
> -		     int subtest __maybe_unused)
> +
> +static int test_aliases(void)
>   {
>   	struct perf_pmu *pmu = NULL;
>   
> -	if (__test_pmu_event_table())
> -		return -1;
> -
>   	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
>   		int count = 0;
>   
> @@ -377,3 +378,148 @@ int test__pmu_events(struct test *test __maybe_unused,
>   
>   	return 0;
>   }
> +
> +static bool is_number(const char *str)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < strlen(str); i++) {
> +		if (!isdigit(str[i]) && str[i] != '.')
> +			return false;
> +	}
> +	return true;
> +}

if there is no helper already for this, is this really the best place to 
put it? Maybe others will need it in future.

> +
> +static int check_parse_id(const char *id, bool same_cpu, struct pmu_event *pe)
> +{
> +	struct parse_events_error error;
> +	struct evlist *evlist;
> +	int ret;
> +
> +	/* Numbers are always valid. */
> +	if (is_number(id))
> +		return 0;
> +
> +	evlist = evlist__new();
> +	memset(&error, 0, sizeof(error));
> +	ret = parse_events(evlist, id, &error);
> +	if (ret && same_cpu) {
> +		fprintf(stderr,
> +			"\nWARNING: Parse event failed metric '%s' id '%s' expr '%s'\n",
> +			pe->metric_name, id, pe->metric_expr);
> +		fprintf(stderr, "Error string '%s' help '%s'\n",
> +			error.str, error.help);

do you really need to spill lines like this?

> +	} else if (ret) {
> +		pr_debug3("Parse event failed, but for an event that may not be supported by this CPU.\nid '%s' metric '%s' expr '%s'\n",
> +			id, pe->metric_name, pe->metric_expr);
> +	}
> +	evlist__delete(evlist);
> +	free(error.str);
> +	free(error.help);
> +	free(error.first_str);
> +	free(error.first_help);
> +	/* TODO: too many metrics are broken to fail on this test currently. */
> +	return 0;
> +}
> +
> +static int test_parsing(void)
> +{
> +	struct pmu_events_map *cpus_map = perf_pmu__find_map(NULL);
> +	struct pmu_events_map *map;
> +	struct pmu_event *pe;
> +	int i, j, k;
> +	const char **ids;
> +	int idnum;
> +	int ret = 0;
> +	struct expr_parse_ctx ctx;
> +	double result;
> +
> +	i = 0;
> +	for (;;) {
> +		map = &pmu_events_map[i++];
> +		if (!map->table) {
> +			map = NULL;
> +			break;
> +		}
> +		j = 0;
> +		for (;;) {
> +			pe = &map->table[j++];
> +			if (!pe->name && !pe->metric_group && !pe->metric_name)
> +				break;
> +			if (!pe->metric_expr)
> +				continue;

we could probably make a for_each_metric_helper(), as this code seems 
duplicated a few times (like metricgroup__add_netric())

> +			if (expr__find_other(pe->metric_expr, NULL,
> +						&ids, &idnum, 0) < 0) {
> +				pr_debug("Parse other failed for map %s %s %s\n",
> +					map->cpuid, map->version, map->type);
> +				pr_debug("On metric %s\n", pe->metric_name);
> +				pr_debug("On expression %s\n", pe->metric_expr);
> +				ret++;
> +				continue;
> +			}
> +			expr__ctx_init(&ctx);
> +
> +			/*
> +			 * Add all ids with a made up value. The value may
> +			 * trigger divide by zero when subtracted and so try to
> +			 * make them unique.
> +			 */
> +			for (k = 0; k < idnum; k++)
> +				expr__add_id(&ctx, ids[k], k + 1);
> +
> +			for (k = 0; k < idnum; k++) {
> +				if (check_parse_id(ids[k], map == cpus_map, pe))
> +					ret++;
> +			}
> +
> +			if (expr__parse(&result, &ctx, pe->metric_expr, 0)) {
> +				pr_debug("Parse failed for map %s %s %s\n",
> +					map->cpuid, map->version, map->type);
> +				pr_debug("On metric %s\n", pe->metric_name);
> +				pr_debug("On expression %s\n", pe->metric_expr);

this code could be factored out a lot, see about 20 lines above

> +				ret++;
> +			}
> +			for (k = 0; k < idnum; k++)
> +				zfree(&ids[k]);
> +			free(ids);
> +		}
> +	}
> +	return ret;
> +}
> +
> +static const struct {
> +	int (*func)(void);
> +	const char *desc;
> +} pmu_events_testcase_table[] = {
> +	{
> +		.func = test_pmu_event_table,
> +		.desc = "PMU event table sanity",
> +	},
> +	{
> +		.func = test_aliases,
> +		.desc = "PMU event map aliases",
> +	},
> +	{
> +		.func = test_parsing,
> +		.desc = "Parsing of PMU event table metrics",
> +	},
> +};

I assume "perf test 10" will run all testcases, right?

> +
> +const char *test__pmu_events_subtest_get_desc(int i)
> +{
> +	if (i < 0 || i >= (int)ARRAY_SIZE(pmu_events_testcase_table))
> +		return NULL;
> +	return pmu_events_testcase_table[i].desc;
> +}
> +
> +int test__pmu_events_subtest_get_nr(void)
> +{
> +	return (int)ARRAY_SIZE(pmu_events_testcase_table);
> +}
> +
> +int test__pmu_events(struct test *test __maybe_unused, int i)
> +{
> +	if (i < 0 || i >= (int)ARRAY_SIZE(pmu_events_testcase_table))
> +		return TEST_FAIL;
> +	return pmu_events_testcase_table[i].func();
> +}
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index d6d4ac34eeb7..8e316c30ed3c 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -50,6 +50,8 @@ int test__perf_evsel__tp_sched_test(struct test *test, int subtest);
>   int test__syscall_openat_tp_fields(struct test *test, int subtest);
>   int test__pmu(struct test *test, int subtest);
>   int test__pmu_events(struct test *test, int subtest);
> +const char *test__pmu_events_subtest_get_desc(int subtest);
> +int test__pmu_events_subtest_get_nr(void);
>   int test__attr(struct test *test, int subtest);
>   int test__dso_data(struct test *test, int subtest);
>   int test__dso_data_cache(struct test *test, int subtest);
> 

