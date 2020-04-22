Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E101C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A9F02071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgDVAxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:53:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:52610 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgDVAxs (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:53:48 -0400
IronPort-SDR: 7dy2JvWpSVUnipmZirNjRuinsIr13PI5HXN9SZrWje7eOt5YbmvQwwVePIpBP+0k9B3BqZtHut
 6wSgUruCwJHQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 17:53:47 -0700
IronPort-SDR: B5XHrYzTIV+K7fiT2gaOztkRTRE7Tzlbhu9HW0fYL9AjyaLmanclAIdADlWtQZYFuKd+jCMfUA
 UW3R121cLdJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,412,1580803200"; 
   d="scan'208";a="365519277"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.151]) ([10.238.4.151])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2020 17:53:41 -0700
Subject: Re: [PATCH v2] perf stat: Improve runtime stat for interval mode
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200420145417.6864-1-yao.jin@linux.intel.com>
 <20200421135329.GA9110@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <b5724589-f653-f125-a227-b374ec575688@linux.intel.com>
Date:   Wed, 22 Apr 2020 08:53:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421135329.GA9110@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 4/21/2020 9:53 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Apr 20, 2020 at 10:54:17PM +0800, Jin Yao escreveu:
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
>>          if (config->interval)
>>                  init_stats(ps->res_stats);
>> }
>>
>> So for interval, the rt_stat should be reset either.
> 
>                                s/either/too/g right?
> 

Yes, should use "too" here. :)

> And please try and find what was the cset that introduced the problem,
> so that we can have a Fixes: line and the stable series can pick it, ok?
 >
> - Arnaldo
>

I have tried to find the patch which introduced this issue.

51fd2df1e882 ("perf stat: Fix interval output values").

This patch zeros stats for interval mode. I just think it should reset 
rt_stat too.

But I really don't know if it's fair to this patch so I don't add it in 
my patch description.

Thanks
Jin Yao

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
>> Now the second 'insn per cycle' and CPI are calculated by the counts
>> generated in this interval.
>>
>>   v2:
>>   ---
>>   Use just existing perf_stat__reset_shadow_per_stat(&rt_stat).
>>   We don't need to define new function perf_stat__reset_rt_stat.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/Documentation/perf-stat.txt | 2 ++
>>   tools/perf/builtin-stat.c              | 1 +
>>   2 files changed, 3 insertions(+)
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
>> index 9207b6c45475..3f050d85c277 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -359,6 +359,7 @@ static void process_interval(void)
>>   	clock_gettime(CLOCK_MONOTONIC, &ts);
>>   	diff_timespec(&rs, &ts, &ref_time);
>>   
>> +	perf_stat__reset_shadow_per_stat(&rt_stat);
>>   	read_counters(&rs);
>>   
>>   	if (STAT_RECORD) {
>> -- 
>> 2.17.1
>>
> 
