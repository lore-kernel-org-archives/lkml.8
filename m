Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5810C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F6721D56
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgCIQU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:20:56 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2528 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbgCIQU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:20:56 -0400
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id EBC0A4FD211C6CF58CF9;
        Mon,  9 Mar 2020 16:20:53 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml704-cah.china.huawei.com (10.201.108.45) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 9 Mar 2020 16:20:53 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 9 Mar 2020
 16:20:53 +0000
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
From:   John Garry <john.garry@huawei.com>
Message-ID: <6691dd26-7c53-26f0-b583-131707ede608@huawei.com>
Date:   Mon, 9 Mar 2020 16:20:52 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200309152635.GD67774@krava>
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

>>
>> The events in test_cpu_aliases[] or test_uncore_aliases[] are checked
>> against the events from pmu-events/arch/test/test_cpu/*.json
> 

Hi Jirka,

> I don't understand the benefit of this.. so IIUC:
> 
>    - jevents will go through arch/test and populate pmu-events/pmu-events.c
>      with:
>         struct pmu_event pme_test_cpu[] ...
>         struct pmu_events_map pmu_events_map_test ...

Right. And the idea is that pme_test_cpu[] can be used as generic set of 
events for testing on any arch/cpuid. (note: I'll just ignore uncore 
events for the moment)

> 
>    - so we actualy have the parsed json events in C structs and we can go
>      through them and check it contains fields with strings that we expect

No, we use pme_test_cpu[] to generate the event aliases for a PMU, and 
verify that the aliases are as expected.

> 
>    - you go through all detected pmus and check if the tests events we
>      generated are matching some of the events from these pmus,

Not exactly.

>      and that's where I'm lost ;-) why?

So consider the "cpu" HW PMU. During normal operation, we create the 
event aliases for this PMU in pmu_lookup()->pmu_add_cpu_aliases(). This 
step looks up a map of cpu events for that CPUID, and then creates the 
event aliases for that PMU from that map.

I want the test to recreate this and verify that the events from the 
test JSONs will have event aliases created properly.

So in the test when we scan the PMUs and find "cpu" HW PMU, we create a 
test PMU with the same name, create the event aliases from 
pme_test_cpu[] for that test PMU, and then verify that the event aliases 
created are as expected. Then the test PMU is deleted.

So overall the test covers:
a. jevents code to generate the struct pmu_event []
b. util/pmu.c code to create the event aliases for a given PMU

Note: the test does not (yet) cover matching of events declared in the 
HW PMU sysfs folder. I'm talking about these, for example:

$ ls /sys/bus/event_source/devices/cpu/events/
branch-instructions  cache-references  el-abort     el-start 
ref-cycles     ...

> 
>>
>>>
>>> or as I'm thinking about that now, would it be enough
>>> to check pme_test_cpu array to have string that we
>>> expect?
>>
>> Right, I might change this.
>>
>> So currently we iterate the PMU aliases to ensure that we have a matching
>> event in pme_test_cpu[]. It may be better to iterate the events in
>> pme_test_cpu[] to ensure that we have an alias.
> 
> that's what I described above.. I dont understand the connection/value
> of this tests
> 
>>
>> The problem here is uncore PMUs. They have the "Unit" field, which is used
>> for matching the PMU. So we cannot ensure test events from uncore.json will
>> always have an event alias created per PMU. But maybe I could use
>> pmu_uncore_alias_match() to check if the test event matches in this case.
> 
> hum I guess I don't follow all the details.. but some more explanation
> of the test would be great

Let's just concentrate on core PMU ATM :)

Thanks,
John
