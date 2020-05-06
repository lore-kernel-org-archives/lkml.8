Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BC0C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED124206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgEFIUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:20:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:8281 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbgEFIT5 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:19:57 -0400
IronPort-SDR: NZ8P64XlD+kYF27usswiXNnphp66f8bbhv1wJNdiATuon6FiPPp+YnCrif5E74VPvczE19jFUU
 4YZFgtJM7uDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 01:19:56 -0700
IronPort-SDR: jfT4IrRly8gK0qfRYGh7zoa2bXakxRPAT+XKrcQ28m+5qRZ8ZhPrUhpD5XMTa+JFHFD7WMA4T0
 F21EZm5P440g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,358,1583222400"; 
   d="scan'208";a="249705053"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.255.29.46]) ([10.255.29.46])
  by fmsmga007.fm.intel.com with ESMTP; 06 May 2020 01:19:52 -0700
Subject: Re: [PATCH v2 1/2] perf evsel: Create counts for collecting summary
 data
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200502020705.19295-1-yao.jin@linux.intel.com>
 <20200502020705.19295-2-yao.jin@linux.intel.com>
 <20200504235059.GG1916255@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <52f68553-e880-4da7-90d5-6bf5ebb6a5a7@linux.intel.com>
Date:   Wed, 6 May 2020 16:19:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504235059.GG1916255@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/5/2020 7:50 AM, Jiri Olsa wrote:
> On Sat, May 02, 2020 at 10:07:04AM +0800, Jin Yao wrote:
>> It would be useful to support the overall statistics for perf-stat
>> interval mode. For example, report the summary at the end of
>> "perf-stat -I" output.
>>
>> But since perf-stat can support many aggregation modes, such as
>> --per-thread, --per-socket, -M and etc, we need a solution which
>> doesn't bring much complexity.
>>
>> The idea is to create new 'evsel->summary_counts' which sums up the
>> counts delta per interval. Before reporting the summary, we copy the
>> data from evsel->summary_counts to evsel->counts, and next we just
>> follow current code.
>>
>>   v2:
>>   ---
>>   Rebase to perf/core branch
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/evsel.c | 10 ++++++++--
>>   tools/perf/util/evsel.h |  1 +
>>   tools/perf/util/stat.c  | 20 ++++++++++++++++++++
>>   3 files changed, 29 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index a75bcb95bf23..abc503dd6eda 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -1280,22 +1280,28 @@ void evsel__delete(struct evsel *evsel)
>>   void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
>>   			   struct perf_counts_values *count)
>>   {
>> -	struct perf_counts_values tmp;
>> +	struct perf_counts_values tmp, *summary;
>>   
>> -	if (!evsel->prev_raw_counts)
>> +	if (!evsel->prev_raw_counts || !evsel->summary_counts)
>>   		return;
>>   
>>   	if (cpu == -1) {
>>   		tmp = evsel->prev_raw_counts->aggr;
>>   		evsel->prev_raw_counts->aggr = *count;
>> +		summary = &evsel->summary_counts->aggr;
>>   	} else {
>>   		tmp = *perf_counts(evsel->prev_raw_counts, cpu, thread);
>>   		*perf_counts(evsel->prev_raw_counts, cpu, thread) = *count;
>> +		summary = perf_counts(evsel->summary_counts, cpu, thread);
> 
> shouldn't this be enough?
> 
> 		perf_counts(evsel->summary_counts, cpu, thread) = *count
> 
> without the code below.. and similar for aggr case
> however I still wonder if we should count this in
> perf_stat_process_counter and only for interval mode
>

Actually I have an easier way, which just resets the prev_raw counters. For example,

@@ -724,6 +727,12 @@ static int __run_perf_stat(int argc, const char **argv, int 
run_idx)

         update_stats(&walltime_nsecs_stats, t1 - t0);

+       if (interval) {
+               stat_config.interval = 0;
+               stat_config.summary = true;
+               perf_evlist__reset_prev_raw_counts(evsel_list);
+       }
+
         /*
          * Closing a group leader splits the group, and as we only disable
          * group leaders, results in remaining events becoming enabled. To

But if we just directly copy from current counts, the summary result looks a bit 
confused.

For example,

root@kbl-ppc:/# perf stat -e cycles -I1000 --interval-count 2
#           time             counts unit events
      1.000402302          2,943,521      cycles
      2.001333982          2,146,165      cycles

  Performance counter stats for 'system wide':

          5,880,031      cycles

        2.002805025 seconds time elapsed

2,943,521 + 2,146,165 != 5,880,031

That's because the counter is still enabled after interval printing. So at the 
time of printing summary, the counts are sightly increased. User may be confused 
for the summary result (why it's not equal to the sum of interval values?).

>>   	}
>>   
>>   	count->val = count->val - tmp.val;
>>   	count->ena = count->ena - tmp.ena;
>>   	count->run = count->run - tmp.run;
>> +
>> +	summary->val += count->val;
>> +	summary->ena += count->ena;
>> +	summary->run += count->run;
>>   }
>>   
>>   void perf_counts_values__scale(struct perf_counts_values *count,
>> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
>> index 783246bf8d0d..430639c99d04 100644
>> --- a/tools/perf/util/evsel.h
>> +++ b/tools/perf/util/evsel.h
>> @@ -46,6 +46,7 @@ struct evsel {
>>   	char			*filter;
>>   	struct perf_counts	*counts;
>>   	struct perf_counts	*prev_raw_counts;
>> +	struct perf_counts	*summary_counts;
> 
> 'sum_counts' might be better
> 

That's OK. :)

Thanks
Jin Yao

> jirka
> 
>>   	int			idx;
>>   	unsigned long		max_events;
>>   	unsigned long		nr_events_printed;
>> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
>> index 774468341851..c3fd008b4e84 100644
>> --- a/tools/perf/util/stat.c
> 
> SNIP
> 
