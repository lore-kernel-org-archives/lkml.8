Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4A0C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAB320715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 15:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBJPow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:44:52 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2401 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726796AbgBJPow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:44:52 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 4D502DA62C9806B46650;
        Mon, 10 Feb 2020 15:44:50 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 10 Feb 2020 15:44:50 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 10 Feb
 2020 15:44:49 +0000
Subject: Re: [PATCH RFC 4/7] perf pmu: Rename uncore symbols to include system
 PMUs
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <suzuki.poulose@arm.com>,
        <james.clark@arm.com>, <zhangshaokun@hisilicon.com>,
        <robin.murphy@arm.com>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <1579876505-113251-5-git-send-email-john.garry@huawei.com>
 <20200210120715.GC1907700@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <fac99c40-dace-3e2e-c8f4-b2afed8b7c61@huawei.com>
Date:   Mon, 10 Feb 2020 15:44:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200210120715.GC1907700@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2020 12:07, Jiri Olsa wrote:
> On Fri, Jan 24, 2020 at 10:35:02PM +0800, John Garry wrote:
> 
> SNIP
> 
>>   		/* Only split the uncore group which members use alias */
>> -		if (!evsel->use_uncore_alias)
>> +		if (!evsel->use_uncore_or_system_alias)
>>   			goto out;
>>   
>>   		/* The events must be from the same uncore block */
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 8b99fd312aae..569aba4cec89 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -623,7 +623,7 @@ static struct perf_cpu_map *pmu_cpumask(const char *name)
>>   	return NULL;
>>   }
>>   
>> -static bool pmu_is_uncore(const char *name)
>> +static bool pmu_is_uncore_or_sys(const char *name)
> 

Hi jirka,

> so we detect uncore PMU by checking for cpumask file
> 

For PMUs which could be considered "system" PMUs, they also have a 
cpumask, like the PMU I use as motivation for this series:

root@(none)$ pwd
/sys/bus/event_source/devices/smmuv3_pmcg_100020
root@(none)$ ls -l
total 0
-r--r--r--    1 root     root          4096 Feb 10 14:50 cpumask
drwxr-xr-x    2 root     root             0 Feb 10 14:50 events
drwxr-xr-x    2 root     root             0 Feb 10 14:50 format
-rw-r--r--    1 root     root          4096 Feb 10 14:50 
perf_event_mux_interval_ms
drwxr-xr-x    2 root     root             0 Feb 10 14:50 power
lrwxrwxrwx    1 root     root             0 Feb 10 14:50 subsystem -> 
../../bus/event_source
-r--r--r--    1 root     root          4096 Feb 10 14:50 type
-rw-r--r--    1 root     root          4096 Feb 10 14:50 uevent


Other PMU drivers which I have checked in drivers/perf also have the same.

Indeed I see no way to differentiate whether a PMU is an uncore or 
system. So that is why I change the name to cover both. Maybe there is a 
better name than the verbose pmu_is_uncore_or_sys().

> I don't see the connection here with the sysid or '_sys' checking,
> that's just telling which ID to use when looking for an alias, no?

So the connection is that in perf_pmu__find_map(), for a given PMU, the 
matching is now extended from only core or uncore PMUs to also these 
system PMUs. And I use the sysid to find an aliasing table for any 
system PMUs present.

> shouldn't that be separated?

Yes, I now think that this would be a better option. So currently I am 
combining it and it causes a problem, like I have noted in patch #5:

struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
{
[SNIP]
	sysid = perf_pmu__getsysid();

   /*
   * Match sysid as first perference for uncore/sys PMUs.
   *
   * x86 uncore events match by cpuid, but we would not have 	map->socid
* set for that arch (so any matching here would fail for that).
*/
if (pmu && pmu_is_uncore_or_sys(pmu->name) &&
    !is_arm_pmu_core(pmu->name) && sysid) {


Thanks,
John

