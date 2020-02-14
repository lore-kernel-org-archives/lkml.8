Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD98AC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918AD222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgBNGGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:06:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:45221 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgBNGGk (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:06:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 22:06:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,439,1574150400"; 
   d="scan'208";a="406892782"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.249.160.130]) ([10.249.160.130])
  by orsmga005.jf.intel.com with ESMTP; 13 Feb 2020 22:06:35 -0800
Subject: Re: [PATCH v3] perf stat: Show percore counts in per CPU output
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20200213071555.17239-1-yao.jin@linux.intel.com>
 <54bea6fe-26a1-a08c-7a61-ac5f5d43ad8c@linux.ibm.com>
 <b2139560-f123-61bb-3ea2-0033b3f892a3@linux.intel.com>
 <8a80b138-77c1-682a-340e-f32d6779d446@linux.ibm.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <533549d7-8acb-d4c6-aac1-360ad6ca87df@linux.intel.com>
Date:   Fri, 14 Feb 2020 14:06:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <8a80b138-77c1-682a-340e-f32d6779d446@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/2020 1:16 PM, Ravi Bangoria wrote:
> 
> 
> On 2/13/20 8:40 PM, Jin, Yao wrote:
>>
>>
>> On 2/13/2020 9:20 PM, Ravi Bangoria wrote:
>>> Hi Jin,
>>>
>>> On 2/13/20 12:45 PM, Jin Yao wrote:
>>>> With this patch, for example,
>>>>
>>>>   # perf stat -e cpu/event=cpu-cycles,percore/ -a -A 
>>>> --percore-show-thread  -- sleep 1
>>>>
>>>>    Performance counter stats for 'system wide':
>>>>
>>>>   CPU0               2,453,061      cpu/event=cpu-cycles,percore/
>>>>   CPU1               1,823,921      cpu/event=cpu-cycles,percore/
>>>>   CPU2               1,383,166      cpu/event=cpu-cycles,percore/
>>>>   CPU3               1,102,652      cpu/event=cpu-cycles,percore/
>>>>   CPU4               2,453,061      cpu/event=cpu-cycles,percore/
>>>>   CPU5               1,823,921      cpu/event=cpu-cycles,percore/
>>>>   CPU6               1,383,166      cpu/event=cpu-cycles,percore/
>>>>   CPU7               1,102,652      cpu/event=cpu-cycles,percore/
>>>>
>>>> We can see counts are duplicated in CPU pairs
>>>> (CPU0/CPU4, CPU1/CPU5, CPU2/CPU6, CPU3/CPU7).
>>>>
>>>
>>> I was trying this patch and I am getting bit weird results when any cpu
>>> is offline. Ex,
>>>
>>>    $ lscpu | grep list
>>>    On-line CPU(s) list:             0-4,6,7
>>>    Off-line CPU(s) list:            5
>>>
>>>    $ sudo ./perf stat -e cpu/event=cpu-cycles,percore/ -a -A 
>>> --percore-show-thread -vv -- sleep 1
>>>      ...
>>>    cpu/event=cpu-cycles,percore/: 0: 23746491 1001189836 1001189836
>>>    cpu/event=cpu-cycles,percore/: 1: 19802666 1001291299 1001291299
>>>    cpu/event=cpu-cycles,percore/: 2: 24211983 1001394318 1001394318
>>>    cpu/event=cpu-cycles,percore/: 3: 54051396 1001516816 1001516816
>>>    cpu/event=cpu-cycles,percore/: 4: 6378825 1001064048 1001064048
>>>    cpu/event=cpu-cycles,percore/: 5: 21299840 1001166297 1001166297
>>>    cpu/event=cpu-cycles,percore/: 6: 13075410 1001274535 1001274535
>>>     Performance counter stats for 'system wide':
>>>    CPU0              30,125,316      cpu/event=cpu-cycles,percore/
>>>    CPU1              19,802,666      cpu/event=cpu-cycles,percore/
>>>    CPU2              45,511,823      cpu/event=cpu-cycles,percore/
>>>    CPU3              67,126,806      cpu/event=cpu-cycles,percore/
>>>    CPU4              30,125,316      cpu/event=cpu-cycles,percore/
>>>    CPU7              67,126,806      cpu/event=cpu-cycles,percore/
>>>    CPU0              30,125,316      cpu/event=cpu-cycles,percore/
>>>           1.001918764 seconds time elapsed
>>>
>>> I see proper result without --percore-show-thread:
>>>
>>>    $ sudo ./perf stat -e cpu/event=cpu-cycles,percore/ -a -A -vv -- 
>>> sleep 1
>>>      ...
>>>    cpu/event=cpu-cycles,percore/: 0: 11676414 1001190709 1001190709
>>>    cpu/event=cpu-cycles,percore/: 1: 39119617 1001291459 1001291459
>>>    cpu/event=cpu-cycles,percore/: 2: 41821512 1001391158 1001391158
>>>    cpu/event=cpu-cycles,percore/: 3: 46853730 1001492799 1001492799
>>>    cpu/event=cpu-cycles,percore/: 4: 14448274 1001095948 1001095948
>>>    cpu/event=cpu-cycles,percore/: 5: 42238217 1001191187 1001191187
>>>    cpu/event=cpu-cycles,percore/: 6: 33129641 1001292072 1001292072
>>>     Performance counter stats for 'system wide':
>>>    S0-D0-C0             26,124,688      cpu/event=cpu-cycles,percore/
>>>    S0-D0-C1             39,119,617      cpu/event=cpu-cycles,percore/
>>>    S0-D0-C2             84,059,729      cpu/event=cpu-cycles,percore/
>>>    S0-D0-C3             79,983,371      cpu/event=cpu-cycles,percore/
>>>           1.001961563 seconds time elapsed
>>>
>>> [...]
>>>
>>
>> Thanks so much for reporting this issue!
>>
>> It looks I should use the cpu idx in print_percore_thread. I can't use 
>> the cpu value. I have a fix:
>>
>> diff --git a/tools/perf/util/stat-display.c 
>> b/tools/perf/util/stat-display.c
>> index 7eb3643a97ae..d89cb0da90f8 100644
>> --- a/tools/perf/util/stat-display.c
>> +++ b/tools/perf/util/stat-display.c
>> @@ -1149,13 +1149,11 @@ static void print_footer(struct 
>> perf_stat_config *config)
>>   static void print_percore_thread(struct perf_stat_config *config,
>>                                   struct evsel *counter, char *prefix)
>>   {
>> -       int cpu, s, s2, id;
>> +       int s, s2, id;
>>          bool first = true;
>>
>>          for (int i = 0; i < perf_evsel__nr_cpus(counter); i++) {
>> -               cpu = perf_cpu_map__cpu(evsel__cpus(counter), i);
>> -               s2 = config->aggr_get_id(config, evsel__cpus(counter), 
>> cpu);
>> -
>> +               s2 = config->aggr_get_id(config, evsel__cpus(counter), 
>> i);
>>                  for (s = 0; s < config->aggr_map->nr; s++) {
>>                          id = config->aggr_map->map[s];
>>                          if (s2 == id)
>> @@ -1164,7 +1162,7 @@ static void print_percore_thread(struct 
>> perf_stat_config *config,
>>
>>                  print_counter_aggrdata(config, counter, s,
>>                                         prefix, false,
>> -                                      &first, cpu);
>> +                                      &first, i);
>>          }
>>   }
> 
> LGTM.
> 
> Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> 
> Ravi
> 

Thanks for testing this fix! I will post v4.

Thanks
Jin Yao
