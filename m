Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53572C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37BF420727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgENNo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:44:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:10632 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgENNo4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:44:56 -0400
IronPort-SDR: PhvGVwElh4R+kU4ItTvBd4aNwsYZ3JoN1oyZk6aYRL3fMCWNRxlZVG1yoJ3ysWf7mzokcf4Luh
 Ox+XNqzFvJtQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 06:44:55 -0700
IronPort-SDR: mx54nfpiWUd1dviUVhZ5ABosByxREm8wGxC+DCRsHbIOM0ivoyVvu4cERj9sCi6PoHv+FlmOKC
 EHGiQWE0Ctiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="280859330"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.254.211.6]) ([10.254.211.6])
  by orsmga002.jf.intel.com with ESMTP; 14 May 2020 06:44:51 -0700
Subject: Re: [PATCH v5 0/5] perf stat: Support overall statistics for interval
 mode
To:     kajoljain <kjain@linux.ibm.com>, acme@kernel.org, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200514053638.3736-1-yao.jin@linux.intel.com>
 <104037dd-5e2e-a6fd-51ae-2e0a1cc2860a@linux.ibm.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <db78366c-f1a2-8e7e-f70b-c6a410ab55ba@linux.intel.com>
Date:   Thu, 14 May 2020 21:44:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <104037dd-5e2e-a6fd-51ae-2e0a1cc2860a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kajoljain,

On 5/14/2020 5:53 PM, kajoljain wrote:
> 
> 
> On 5/14/20 11:06 AM, Jin Yao wrote:
>> Currently perf-stat supports to print counts at regular interval (-I),
>> but it's not very easy for user to get the overall statistics.
>>
>> With this patchset, it supports to report the summary at the end of
>> interval output.
>>
>> For example,
>>
>>   root@kbl-ppc:~# perf stat -e cycles -I1000 --interval-count 2
>>   #           time             counts unit events
>>        1.000412064          2,281,114      cycles
>>        2.001383658          2,547,880      cycles
>>
>>    Performance counter stats for 'system wide':
>>
>>            4,828,994      cycles
>>
>>          2.002860349 seconds time elapsed
>>
>>   root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
>>   #           time             counts unit events
>>        1.000389902          1,536,093      cycles
>>        1.000389902            420,226      instructions              #    0.27  insn per cycle
>>        2.001433453          2,213,952      cycles
>>        2.001433453            735,465      instructions              #    0.33  insn per cycle
>>
>>    Performance counter stats for 'system wide':
>>
>>            3,750,045      cycles
>>            1,155,691      instructions              #    0.31  insn per cycle
>>
>>          2.003023361 seconds time elapsed
>>
>>   root@kbl-ppc:~# perf stat -M CPI,IPC -I1000 --interval-count 2
>>   #           time             counts unit events
>>        1.000435121            905,303      inst_retired.any          #      2.9 CPI
>>        1.000435121          2,663,333      cycles
>>        1.000435121            914,702      inst_retired.any          #      0.3 IPC
>>        1.000435121          2,676,559      cpu_clk_unhalted.thread
>>        2.001615941          1,951,092      inst_retired.any          #      1.8 CPI
>>        2.001615941          3,551,357      cycles
>>        2.001615941          1,950,837      inst_retired.any          #      0.5 IPC
>>        2.001615941          3,551,044      cpu_clk_unhalted.thread
>>
>>    Performance counter stats for 'system wide':
>>
>>            2,856,395      inst_retired.any          #      2.2 CPI
>>            6,214,690      cycles
>>            2,865,539      inst_retired.any          #      0.5 IPC
>>            6,227,603      cpu_clk_unhalted.thread
>>
>>          2.003403078 seconds time elapsed
> 
> Hi Jin,
> 	Reporting the summary will be great for understanding overall stats. So, Before the
> patch where we are reseting rt_stat before read_counters to make sure, whatever printing
> in final aggregate is as per counts on that interval,
> 

Yes, I had similar thoughts, so I posted following patch.

https://lore.kernel.org/lkml/20200420145417.6864-1-yao.jin@linux.intel.com/

> we used to update stats->means and other info as described in
> 
> RFC: https://lkml.org/lkml/2020/3/24/158
> 

I've checked your patch but sorry I'm also not very sure if it's the expected 
behavior.

> Now, stats->means is same as counts which we are using in generic_metric function. Is this expected behavior?
> I am not sure, if data like stats->means and all suppose to update per interval or we are using it somewhere else.
> 

I just think it's easy to understand, that is the metric calculated by the 
counts per interval.

> So, As we call update_stats for each event and for each interval, can we somehow use that
> to print overall stats maybe by adding some var in `struct stats` to keep count of total counts for that event.
> Please let me know if my understanding is fine.
> 

Adding var in 'struct stats' looks not enough (or more complicated), because 
perf-stat also needs to report some counts according to different aggregation 
modes (not only the metric). I just think copying total counts to current counts 
is a easy way because we can reuse most of existing non-interval processing code.

Thanks
Jin Yao

> Thanks,
> Kajol Jain
> 
> 
>   
>>
>>   v5:
>>   ---
>>   1. Create new patch "perf stat: Save aggr value to first member
>>      of prev_raw_counts".
>>
>>   2. Call perf_evlist__save_aggr_prev_raw_counts to save aggr value
>>      to first member of prev_raw_counts for AGGR_GLOBAL. Then next,
>>      perf_stat_process_counter can create aggr values from per cpu
>>      values.
>>
>>   Following patches are impacted in v5:
>>      perf stat: Copy counts from prev_raw_counts to evsel->counts
>>      perf stat: Save aggr value to first member of prev_raw_counts
>>      perf stat: Report summary for interval mode
>>
>>   v4:
>>   ---
>>   1. Create runtime_stat_reset.
>>
>>   2. Zero the aggr in perf_counts__reset and use it to reset
>>      prev_raw_counts.
>>
>>   3. Move affinity setup and read_counter_cpu to a new function
>>      read_affinity_counters. It's only called when stat_config.summary
>>      is not set.
>>
>>   v3:
>>   ---
>>   1. 'perf stat: Fix wrong per-thread runtime stat for interval mode'
>>      is a new patch which fixes an existing issue found in test.
>>
>>   2. We use the prev_raw_counts for summary counts. Drop the summary_counts in v2.
>>
>>   3. Fix some issues.
>>
>>   v2:
>>   ---
>>   Rebase to perf/core branch
>>
>> Jin Yao (5):
>>    perf stat: Fix wrong per-thread runtime stat for interval mode
>>    perf counts: Reset prev_raw_counts counts
>>    perf stat: Copy counts from prev_raw_counts to evsel->counts
>>    perf stat: Save aggr value to first member of prev_raw_counts
>>    perf stat: Report summary for interval mode
>>
>>   tools/perf/builtin-stat.c | 101 ++++++++++++++++++++++++++------------
>>   tools/perf/util/counts.c  |   4 +-
>>   tools/perf/util/counts.h  |   1 +
>>   tools/perf/util/stat.c    |  43 +++++++++++++---
>>   tools/perf/util/stat.h    |   3 ++
>>   5 files changed, 113 insertions(+), 39 deletions(-)
>>
