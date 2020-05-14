Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86472C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6853E206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgENFmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:42:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:10425 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgENFmn (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:42:43 -0400
IronPort-SDR: EUY/BswfeJ81nd++VR5ijp8dedOgvFGOAALjGPWttLPDmErHHfAqI7SJVV1yWcIg2hhLxXQQ+f
 K0VeNMtoQkAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 22:42:42 -0700
IronPort-SDR: BQmsbEjZdLp1JvC1+Op9yxVpMzl+fTxdEDE6llVztubbIqgDKg+LQJdP3LD9eLjLmAPm2aFQfM
 7L0IcEttWWpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="372130212"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2020 22:42:40 -0700
Subject: Re: [PATCH v4 3/4] perf stat: Copy counts from prev_raw_counts to
 evsel->counts
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200508075817.10588-1-yao.jin@linux.intel.com>
 <20200508075817.10588-4-yao.jin@linux.intel.com>
 <20200513153133.GN3158213@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <7df7c652-fb34-66c0-e2f2-6a5585afd621@linux.intel.com>
Date:   Thu, 14 May 2020 13:42:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513153133.GN3158213@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/13/2020 11:31 PM, Jiri Olsa wrote:
> On Fri, May 08, 2020 at 03:58:16PM +0800, Jin Yao wrote:
>> It would be useful to support the overall statistics for perf-stat
>> interval mode. For example, report the summary at the end of
>> "perf-stat -I" output.
>>
>> But since perf-stat can support many aggregation modes, such as
>> --per-thread, --per-socket, -M and etc, we need a solution which
>> doesn't bring much complexity.
>>
>> The idea is to use 'evsel->prev_raw_counts' which is updated in
>> each interval and it's saved with the latest counts. Before reporting
>> the summary, we copy the counts from evsel->prev_raw_counts to
>> evsel->counts, and next we just follow non-interval processing.
>>
>> In evsel__compute_deltas, this patch saves counts to the member
>> [cpu0,thread0] of perf_counts for AGGR_GLOBAL.
>>
>> That's because after copying evsel->prev_raw_counts to evsel->counts,
>> perf_counts(evsel->counts, cpu, thread) are all 0 for AGGR_GLOBAL.
>> Once we go to process_counter_maps again, all members of perf_counts
>> are 0.
>>
>> So this patch uses a trick that saves the previous aggr value to
>> the member [cpu0,thread0] of perf_counts, then aggr calculation
>> in process_counter_values can work correctly.
>>
>>   v4:
>>   ---
>>   Change the commit message.
>>   No functional change.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/evsel.c |  1 +
>>   tools/perf/util/stat.c  | 24 ++++++++++++++++++++++++
>>   tools/perf/util/stat.h  |  1 +
>>   3 files changed, 26 insertions(+)
>>
>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>> index 28683b0eb738..6fae1ec28886 100644
>> --- a/tools/perf/util/evsel.c
>> +++ b/tools/perf/util/evsel.c
>> @@ -1283,6 +1283,7 @@ void evsel__compute_deltas(struct evsel *evsel, int cpu, int thread,
>>   	if (cpu == -1) {
>>   		tmp = evsel->prev_raw_counts->aggr;
>>   		evsel->prev_raw_counts->aggr = *count;
>> +		*perf_counts(evsel->prev_raw_counts, 0, 0) = *count;
> 
> ok, I think I understand that now.. it's only for AGGR_GLOBAL mode,
> because the perf_stat_process_counter will create aggr values from
> per cpu values
> 
> but why do we need to do that all the time? can't we just set it up
> before you zero prev_raw_counts in next patch?
> 
> 
>          if (interval) {
>                  stat_config.interval = 0;
>                  stat_config.summary = true;
>                  perf_evlist__copy_prev_raw_counts(evsel_list);
> 
> 	-> for AGGR_GLOBAL set the counts[0,0] to prev_raw_counts->aggr
> 
>                  perf_evlist__reset_prev_raw_counts(evsel_list);
>                  runtime_stat_reset(&stat_config);
>                  perf_stat__reset_shadow_per_stat(&rt_stat);
>          }
>


Yes, I think that's a good idea.

Now in v5, I create a new patch "perf stat: Save aggr value to first member of 
prev_raw_counts" to save aggr value to first member of prev_raw_counts for 
AGGR_GLOBAL. Then next, perf_stat_process_counter can create aggr values from 
per cpu values successfully.

Thanks
Jin Yao

> 
> thanks,
> jirka
> 
