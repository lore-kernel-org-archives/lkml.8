Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E887CC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF79206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 05:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgDTF7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 01:59:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:45725 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgDTF7p (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 01:59:45 -0400
IronPort-SDR: fMmPfR19ScC9zSb9mnKkcRZU7FG4G9qKHIYgMjiZKqJKT2uxL/f3UKK8BIWa8ncMqCfgzYlZ51
 ctMFhXNrUfSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 22:59:45 -0700
IronPort-SDR: uT1v7V7Rcx6uAaoiD6cmuffkUv7dWjDLTPGLYvAHBhO2Z2XMEm14Slcprh7FpcUsf1wgMl9Vsd
 GL/o71cHVSTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; 
   d="scan'208";a="364904229"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga001.fm.intel.com with ESMTP; 19 Apr 2020 22:59:42 -0700
Subject: Re: [PATCH] perf stat: Improve runtime stat for interval mode
To:     kajoljain <kjain@linux.ibm.com>, acme@kernel.org, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200417005154.9024-1-yao.jin@linux.intel.com>
 <4950a109-ff2f-7199-c0f7-5b39ddc5afbb@linux.ibm.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ad03237f-8cd5-260c-3926-08214ac1de92@linux.intel.com>
Date:   Mon, 20 Apr 2020 13:59:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4950a109-ff2f-7199-c0f7-5b39ddc5afbb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/2020 1:48 PM, kajoljain wrote:
> 
> 
> On 4/17/20 6:21 AM, Jin Yao wrote:
>> For interval mode, the metric is printed after # if it exists. But
>> it's not calculated by the counts generated in this interval. See
>> following examples,
>>
>>   root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
>>   #           time             counts unit events
>>        1.000422803            764,809      inst_retired.any          #      2.9 CPI
>>        1.000422803          2,234,932      cycles
>>        2.001464585          1,960,061      inst_retired.any          #      1.6 CPI
>>        2.001464585          4,022,591      cycles
>>
>> The second CPI should not be 1.6 (4,022,591/1,960,061 is 2.1)
>>
>>   root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
>>   #           time             counts unit events
>>        1.000429493          2,869,311      cycles
>>        1.000429493            816,875      instructions              #    0.28  insn per cycle
>>        2.001516426          9,260,973      cycles
>>        2.001516426          5,250,634      instructions              #    0.87  insn per cycle
>>
>> The second 'insn per cycle' should not be 0.87 (5,250,634/9,260,973 is 0.57).
>>
>> The current code uses a global variable rt_stat for tracking and
>> updating the std dev of runtime stat. Unlike the counts, rt_stat is
>> not reset for interval. While the counts are reset for interval.
>>
>> perf_stat_process_counter()
>> {
>> 	if (config->interval)
>> 		init_stats(ps->res_stats);
>> }
>>
>> So for interval, the rt_stat should be reset either.
>>
>> This patch resets rt_stat before read_counters, so the runtime
>> stat is only calculated by the counts generated in this interval.
>>
>> With this patch,
>>
>>   root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
>>   #           time             counts unit events
>>        1.000420924          2,408,818      inst_retired.any          #      2.1 CPI
>>        1.000420924          5,010,111      cycles
>>        2.001448579          2,798,407      inst_retired.any          #      1.6 CPI
>>        2.001448579          4,599,861      cycles
>>
>>   root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
>>   #           time             counts unit events
>>        1.000428555          2,769,714      cycles
>>        1.000428555            774,462      instructions              #    0.28  insn per cycle
>>        2.001471562          3,595,904      cycles
>>        2.001471562          1,243,703      instructions              #    0.35  insn per cycle
>>
> 
> Hi Jin,
> 	Thanks for the patch. Was working on similar issue raised by Joakim Zhang.
> Here's link to my findings: https://lkml.org/lkml/2020/3/24/158
> 
> This patch solves the issue.
> 
> Acked-By: Kajol Jain <kjain@linux.ibm.com> and Tested-By: Kajol Jain <kjain@linux.ibm.com>
>   

Thanks for testing this patch. :)

Thanks
Jin Yao

>> Now the second 'insn per cycle' and CPI are calculated by the counts
>> generated in this interval.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/Documentation/perf-stat.txt | 2 ++
>>   tools/perf/builtin-stat.c              | 1 +
>>   tools/perf/util/stat-shadow.c          | 5 +++++
>>   tools/perf/util/stat.h                 | 1 +
>>   4 files changed, 9 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
>> index 4d56586b2fb9..3fb5028aef08 100644
>> --- a/tools/perf/Documentation/perf-stat.txt
>> +++ b/tools/perf/Documentation/perf-stat.txt
>> @@ -176,6 +176,8 @@ Print count deltas every N milliseconds (minimum: 1ms)
>>   The overhead percentage could be high in some cases, for instance with small, sub 100ms intervals.  Use with caution.
>>   	example: 'perf stat -I 1000 -e cycles -a sleep 5'
>>   
>> +If the metric exists, it is calculated by the counts generated in this interval and the metric is printed after #.
>> +
>>   --interval-count times::
>>   Print count deltas for fixed number of times.
>>   This option should be used together with "-I" option.
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index ec053dc1e35c..d5c326ff46d0 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -359,6 +359,7 @@ static void process_interval(void)
>>   	clock_gettime(CLOCK_MONOTONIC, &ts);
>>   	diff_timespec(&rs, &ts, &ref_time);
>>   
>> +	perf_stat__reset_rt_stat();
>>   	read_counters(&rs);
>>   
>>   	if (STAT_RECORD) {
>> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
>> index 1ad5c5be7e97..c8f5ca6c8749 100644
>> --- a/tools/perf/util/stat-shadow.c
>> +++ b/tools/perf/util/stat-shadow.c
>> @@ -186,6 +186,11 @@ void perf_stat__reset_shadow_stats(void)
>>   	memset(&walltime_nsecs_stats, 0, sizeof(walltime_nsecs_stats));
>>   }
>>   
>> +void perf_stat__reset_rt_stat(void)
>> +{
>> +	reset_stat(&rt_stat);
>> +}
>> +
>>   void perf_stat__reset_shadow_per_stat(struct runtime_stat *st)
>>   {
>>   	reset_stat(st);
>> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
>> index b4fdfaa7f2c0..2975494166dd 100644
>> --- a/tools/perf/util/stat.h
>> +++ b/tools/perf/util/stat.h
>> @@ -176,6 +176,7 @@ void runtime_stat__init(struct runtime_stat *st);
>>   void runtime_stat__exit(struct runtime_stat *st);
>>   void perf_stat__init_shadow_stats(void);
>>   void perf_stat__reset_shadow_stats(void);
>> +void perf_stat__reset_rt_stat(void);
>>   void perf_stat__reset_shadow_per_stat(struct runtime_stat *st);
>>   void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
>>   				    int cpu, struct runtime_stat *st);
>>
