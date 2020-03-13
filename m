Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E70C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9837206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 11:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgCMLIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 07:08:54 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2557 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726414AbgCMLIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:08:54 -0400
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 6141CF2CCE4FF1646C0B;
        Fri, 13 Mar 2020 11:08:52 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 13 Mar 2020 11:08:51 +0000
Received: from [127.0.0.1] (10.47.7.187) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 13 Mar
 2020 11:08:50 +0000
Subject: Re: [PATCH 6/6] perf test: Add pmu-events test
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <will@kernel.org>, <ak@linux.intel.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <james.clark@arm.com>, <qiangqing.zhang@nxp.com>
References: <1583406486-154841-1-git-send-email-john.garry@huawei.com>
 <1583406486-154841-7-git-send-email-john.garry@huawei.com>
 <20200309084924.GA65888@krava>
 <82c3fbfe-4ddc-db7d-c17f-29ca6f11e60c@huawei.com>
 <20200309152635.GD67774@krava>
 <6691dd26-7c53-26f0-b583-131707ede608@huawei.com>
 <20200313103259.GC389625@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f9f35a45-1793-889a-8d9e-014f4aaf5fa3@huawei.com>
Date:   Fri, 13 Mar 2020 11:08:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200313103259.GC389625@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.7.187]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi jirka,

>>>
>>>     - so we actualy have the parsed json events in C structs and we can go
>>>       through them and check it contains fields with strings that we expect
>>
>> No, we use pme_test_cpu[] to generate the event aliases for a PMU, and
>> verify that the aliases are as expected.
>>
>>>
>>>     - you go through all detected pmus and check if the tests events we
>>>       generated are matching some of the events from these pmus,
>>
>> Not exactly.
>>
>>>       and that's where I'm lost ;-) why?
>>
>> So consider the "cpu" HW PMU. During normal operation, we create the event
>> aliases for this PMU in pmu_lookup()->pmu_add_cpu_aliases(). This step looks
>> up a map of cpu events for that CPUID, and then creates the event aliases
>> for that PMU from that map.
>>
>> I want the test to recreate this and verify that the events from the test
>> JSONs will have event aliases created properly.
> 
> aah ok, my first objective was to have some way to test pmu-events
> changes we plan to do and their affect to generated pmu-event.c

Since the format of the test events table is slightly different to 
regular event tables, I wasn't sure on the value there. But I could add it.

For that, I could modify how we generate pmu-events.c as to not have a 
separate special test table, but add the test events as a special entry 
in pmu_events_map[], with some fake test cpuid. That could be better if 
we want to verify the generated test event table.

> 
> you want to test the code paths after that.. perfect
> 
>>
>> So in the test when we scan the PMUs and find "cpu" HW PMU, we create a test
>> PMU with the same name, create the event aliases from pme_test_cpu[] for
>> that test PMU, and then verify that the event aliases created are as
>> expected. Then the test PMU is deleted.
>>
>> So overall the test covers:
>> a. jevents code to generate the struct pmu_event []
>> b. util/pmu.c code to create the event aliases for a given PMU
>>
>> Note: the test does not (yet) cover matching of events declared in the HW
>> PMU sysfs folder. I'm talking about these, for example:
> 
> ok
> 

I'm going to look at what I can do here. I just worry it will make 
things more arch specific and make the test brittle.

>>
>> $ ls /sys/bus/event_source/devices/cpu/events/
>> branch-instructions  cache-references  el-abort     el-start ref-cycles
>> ...
>>
>>>
>>>>
>>>>>
>>>>> or as I'm thinking about that now, would it be enough
>>>>> to check pme_test_cpu array to have string that we
>>>>> expect?
>>>>
>>>> Right, I might change this.
>>>>
>>>> So currently we iterate the PMU aliases to ensure that we have a matching
>>>> event in pme_test_cpu[]. It may be better to iterate the events in
>>>> pme_test_cpu[] to ensure that we have an alias.
>>>
>>> that's what I described above.. I dont understand the connection/value
>>> of this tests
>>>
>>>>
>>>> The problem here is uncore PMUs. They have the "Unit" field, which is used
>>>> for matching the PMU. So we cannot ensure test events from uncore.json will
>>>> always have an event alias created per PMU. But maybe I could use
>>>> pmu_uncore_alias_match() to check if the test event matches in this case.
>>>
>>> hum I guess I don't follow all the details.. but some more explanation
>>> of the test would be great
>>
>> Let's just concentrate on core PMU ATM :)

So just going back to the uncore events now, since they have the "Unit" 
property to match to specific uncore PMUs, we need to test them slightly 
differently to core PMUs. But I have improved the testing for that now.

Thanks,
John
