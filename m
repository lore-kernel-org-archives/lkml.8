Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A020AC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7031121473
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgIGKbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:31:43 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2773 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728836AbgIGKbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:31:12 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id D8EF433B1587288A086;
        Mon,  7 Sep 2020 11:31:08 +0100 (IST)
Received: from [127.0.0.1] (10.47.2.208) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 7 Sep 2020
 11:31:07 +0100
Subject: Re: [PATCH 8/9] perf test: Free aliases for PMU event map aliases
 test
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
CC:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
References: <20200907034502.753230-1-namhyung@kernel.org>
 <20200907034502.753230-9-namhyung@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <78911dd7-8a93-0f1b-7805-1fad87ad6979@huawei.com>
Date:   Mon, 7 Sep 2020 11:28:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200907034502.753230-9-namhyung@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.2.208]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2020 04:45, Namhyung Kim wrote:
> The aliases were never released causing the following leaks:
> 
>    Indirect leak of 1224 byte(s) in 9 object(s) allocated from:
>      #0 0x7feefb830628 in malloc (/lib/x86_64-linux-gnu/libasan.so.5+0x107628)
>      #1 0x56332c8f1b62 in __perf_pmu__new_alias util/pmu.c:322
>      #2 0x56332c8f401f in pmu_add_cpu_aliases_map util/pmu.c:778
>      #3 0x56332c792ce9 in __test__pmu_event_aliases tests/pmu-events.c:295
>      #4 0x56332c792ce9 in test_aliases tests/pmu-events.c:367
>      #5 0x56332c76a09b in run_test tests/builtin-test.c:410
>      #6 0x56332c76a09b in test_and_print tests/builtin-test.c:440
>      #7 0x56332c76ce69 in __cmd_test tests/builtin-test.c:695
>      #8 0x56332c76ce69 in cmd_test tests/builtin-test.c:807
>      #9 0x56332c7d2214 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
>      #10 0x56332c6701a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
>      #11 0x56332c6701a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
>      #12 0x56332c6701a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
>      #13 0x7feefb359cc9 in __libc_start_main ../csu/libc-start.c:308
> 
> Cc: John Garry <john.garry@huawei.com>
> Fixes: 956a78356c24c ("perf test: Test pmu-events aliases")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>   tools/perf/tests/pmu-events.c | 5 +++++
>   tools/perf/util/pmu.c         | 2 +-
>   tools/perf/util/pmu.h         | 1 +
>   3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
> index eb19f9a0bc15..d3517a74d95e 100644
> --- a/tools/perf/tests/pmu-events.c
> +++ b/tools/perf/tests/pmu-events.c
> @@ -274,6 +274,7 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
>   	int res = 0;
>   	bool use_uncore_table;
>   	struct pmu_events_map *map = __test_pmu_get_events_map();
> +	struct perf_pmu_alias *a, *tmp;
>   
>   	if (!map)
>   		return -1;
> @@ -347,6 +348,10 @@ static int __test__pmu_event_aliases(char *pmu_name, int *count)
>   			  pmu_name, alias->name);
>   	}
>   
> +	list_for_each_entry_safe(a, tmp, &aliases, list) {
> +		list_del(&a->list);
> +		perf_pmu_free_alias(a);

This looks ok.

I also notice that we have other paths like this, where the allocated 
pmu (and aliases) are not freed for later error paths, it seems:

parse_events_add_pmu() -> perf_pmu_find() -> pmu_lookup() -> 
pmu_add_cpu_aliases().

I had a quick look at the rest of the series, and could not see if we 
fix up any of this.

Cheers,
john

> +	}
>   	free(pmu);
>   	return res;
>   }
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index f1688e1f6ed7..555cb3524c25 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -274,7 +274,7 @@ static void perf_pmu_update_alias(struct perf_pmu_alias *old,
>   }
>   
>   /* Delete an alias entry. */
> -static void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
> +void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
>   {
>   	zfree(&newalias->name);
>   	zfree(&newalias->desc);
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 44ccbdbb1c37..b63c4c5e335e 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -113,6 +113,7 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
>   
>   struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
>   bool pmu_uncore_alias_match(const char *pmu_name, const char *name);
> +void perf_pmu_free_alias(struct perf_pmu_alias *alias);
>   
>   int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
>   
> 

