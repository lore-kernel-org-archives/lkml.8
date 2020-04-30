Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3904FC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC7F2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgD3Nip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:38:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:61389 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726577AbgD3Nin (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:38:43 -0400
IronPort-SDR: dmFKBRsR31GHjEZ8oxOiFdca9trLAZtmCh2QHh+F51wMQA64hZGEWLi0h6U/gWplXrH4KaRc8w
 cPMiElNAU7fA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 06:38:42 -0700
IronPort-SDR: yZoYA8Yk7lCOe409WCst2FaaUWobRCyqWOOakOowW74bp1U/EyP54g3hGjBzGnxoFfsr1dWWt0
 cYhsjce1nJig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,336,1583222400"; 
   d="scan'208";a="368146857"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.254.213.153]) ([10.254.213.153])
  by fmsmga001.fm.intel.com with ESMTP; 30 Apr 2020 06:38:35 -0700
Subject: Re: [PATCH] perf parse-events: Use strcmp to compare the PMU name
To:     John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        "irogers@google.com" <irogers@google.com>
References: <20200430003618.17002-1-yao.jin@linux.intel.com>
 <20200430084529.GC1681583@krava>
 <66b84e3f-f7d8-bb65-616e-d159a509a439@huawei.com>
 <20200430111551.GC1694693@krava>
 <0195184b-0b43-f2fd-8d80-3b70d3f5a950@huawei.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <8685d584-1d28-4648-8d85-2ea637f3c695@linux.intel.com>
Date:   Thu, 30 Apr 2020 21:38:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0195184b-0b43-f2fd-8d80-3b70d3f5a950@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John, Jiri,

On 4/30/2020 7:48 PM, John Garry wrote:
> On 30/04/2020 12:15, Jiri Olsa wrote:
> 
> +
> 
>> On Thu, Apr 30, 2020 at 09:54:18AM +0100, John Garry wrote:
>>> On 30/04/2020 09:45, Jiri Olsa wrote:
>>>> On Thu, Apr 30, 2020 at 08:36:18AM +0800, Jin Yao wrote:
>>>>> A big uncore event group is split into multiple small groups which
>>>>> only include the uncore events from the same PMU. This has been
>>>>> supported in the commit 3cdc5c2cb924a ("perf parse-events: Handle
>>>>> uncore event aliases in small groups properly").
>>>>>
>>>>> If the event's PMU name starts to repeat, it must be a new event.
>>>>> That can be used to distinguish the leader from other members.
>>>>> But now it only compares the pointer of pmu_name
>>>>> (leader->pmu_name == evsel->pmu_name).
>>>>>
>>>>> If we use "perf stat -M LLC_MISSES.PCIE_WRITE -a" on cascadelakex,
>>>>> the event list is:
>>>>>
>>>>> evsel->name                    evsel->pmu_name
>>>>> ---------------------------------------------------------------
>>>>> unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_4 (as leader)
>>>>> unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_2
>>>>> unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_0
>>>>> unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_5
>>>>> unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_3
>>>>> unc_iio_data_req_of_cpu.mem_write.part0        uncore_iio_1
>>>>> unc_iio_data_req_of_cpu.mem_write.part1        uncore_iio_4
>>>>> ......
>>>>>
>>>>> For the event "unc_iio_data_req_of_cpu.mem_write.part1" with
>>>>> "uncore_iio_4", it should be the event from PMU "uncore_iio_4".
>>>>> It's not a new leader for this PMU.
>>>>>
>>>>> But if we use "(leader->pmu_name == evsel->pmu_name)", the check
>>>>> would be failed and the event is stored to leaders[] as a new
>>>>> PMU leader.
>>>>>
>>>>> So this patch uses strcmp to compare the PMU name between events.
>>>>>
>>>>> Fixes: 3cdc5c2cb924a ("perf parse-events: Handle uncore event aliases in 
>>>>> small groups properly")
>>>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>>>
>>>> looks good, any chance we could have automated test
>>>> for this uncore leader setup logic? like maybe the way
>>>> John did the pmu-events tests? like test will trigger
>>>> only when there's the pmu/events in the system
>>>>
>>>> Acked-by: Jiri Olsa <jolsa@redhat.com>
>>>>
>>>> thanks,
>>>> jirka
>>>
>>> Hi jirka,
>>>
>>> JFYI, this is effectively the same patch as I mentioned to you, which was a
>>> fix for the same WARN:
>>>
>>> https://lore.kernel.org/linux-arm-kernel/1587120084-18990-2-git-send-email-john.garry@huawei.com/ 
>>>
>>>
>>> but I found that it "fixed" d4953f7ef1a2 ("perf parse-events: Fix 3 use
>>> after frees found with clang ASANutil/parse-events.c"), based on bisect
>>> breakage
>>
>> hum right.. sorry I did not recalled that, there's
>> also the warn removal in here, could you guys also
>> plz sync on the fixes clauses?
> 
> I just thought that it fixes d4953f7ef1a2, as I found that the pointer equality 
> fails from that commit. I assume the parse-events code was sound before then (in 
> that regard). That's all I know :)
> 
> Thanks!
> 

For 3cdc5c2cb924a, I just think it should use strcmp for pmu_name comparison 
rather than using pointer. But I'm OK to add d4953f7ef1a2 in fixes clauses. :)

Thanks
Jin Yao

>>
>> thanks,
>> jirka
>>
>>>
>>> cheers
>>>
>>>>
>>>>
>>>>> ---
>>>>>    tools/perf/util/parse-events.c | 5 ++---
>>>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>>>>> index 10107747b361..786eddb6a097 100644
>>>>> --- a/tools/perf/util/parse-events.c
>>>>> +++ b/tools/perf/util/parse-events.c
>>>>> @@ -1629,12 +1629,11 @@ parse_events__set_leader_for_uncore_aliase(char 
>>>>> *name, struct list_head *list,
>>>>>             * event. That can be used to distinguish the leader from
>>>>>             * other members, even they have the same event name.
>>>>>             */
>>>>> -        if ((leader != evsel) && (leader->pmu_name == evsel->pmu_name)) {
>>>>> +        if ((leader != evsel) &&
>>>>> +            !strcmp(leader->pmu_name, evsel->pmu_name)) {
>>>>>                is_leader = false;
>>>>>                continue;
>>>>>            }
>>>>> -        /* The name is always alias name */
>>>>> -        WARN_ON(strcmp(leader->name, evsel->name));
>>>>>            /* Store the leader event for each PMU */
>>>>>            leaders[nr_pmu++] = (uintptr_t) evsel;
>>>>> -- 
>>>>> 2.17.1
>>>>>
>>>>
>>>> .
>>>>
>>>
>>
>> .
>>
> 
