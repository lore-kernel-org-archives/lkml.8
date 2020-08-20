Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D17C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC938208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgHTHxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:53:08 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2675 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbgHTHxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:53:07 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 30239E82965CF9773093;
        Thu, 20 Aug 2020 08:53:06 +0100 (IST)
Received: from [127.0.0.1] (10.47.0.147) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 20 Aug
 2020 08:53:05 +0100
Subject: Re: [PATCH] MAINTAINERS: Add entries for CoreSight and Arm SPE
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Will Deacon <will@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20200817193140.3659956-1-mathieu.poirier@linaro.org>
 <ede047ea-ad6a-1f7e-d597-b47bc87271c3@huawei.com>
 <CANLsYkw2aBJmrHV+8_bDUtgD-Jfvndqz2kOfNNcBBMM+vztkug@mail.gmail.com>
 <20200819173050.GA18091@willie-the-truck>
 <CANLsYkzn2yuhVzZD0p-C156qi28ukHQDa83F8pezESsptG4d1Q@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <691cdbfa-d266-ec2e-e687-3ce1ca3014d8@huawei.com>
Date:   Thu, 20 Aug 2020 08:50:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CANLsYkzn2yuhVzZD0p-C156qi28ukHQDa83F8pezESsptG4d1Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.0.147]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2020 20:26, Mathieu Poirier wrote:
> On Wed, 19 Aug 2020 at 11:30, Will Deacon <will@kernel.org> wrote:
>>
>> On Wed, Aug 19, 2020 at 11:01:38AM -0600, Mathieu Poirier wrote:
>>> On Tue, 18 Aug 2020 at 11:56, John Garry <john.garry@huawei.com> wrote:
>>>> On 17/08/2020 20:31, Mathieu Poirier wrote:
>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>> index 4e2698cc7e23..f9bb76baeec9 100644
>>>>> --- a/MAINTAINERS
>>>>> +++ b/MAINTAINERS
>>>>> @@ -13427,8 +13427,18 @@ F:   tools/perf/
>>>>>    PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS

Maybe "PERFORMANCE EVENTS SUBSYSTEM ARM64" would be more appropriate now.

>>>>>    R:  John Garry <john.garry@huawei.com>
>>>>>    R:  Will Deacon <will@kernel.org>
>>>>> +R:   Mathieu Poirier <mathieu.poirier@linaro.org>
>>>>> +R:   Leo Yan <leo.yan@linaro.org>
>>>>>    L:  linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>>>>    S:  Supported
>>>>> +F:   tools/build/feature/test-libopencsd.c
>>>>> +F:   tools/perf/arch/arm/util/auxtrace.c
>>>>> +F:   tools/perf/arch/arm/util/cs-etm.*
>>>>> +F:   tools/perf/arch/arm/util/pmu.c
>>>>> +F:   tools/perf/arch/arm64/util/arm-spe.c
>>>>> +F:   tools/perf/util/arm-spe.h
>>>>> +F:   tools/perf/util/cs-etm-decoder/*
>>>>> +F:   tools/perf/util/cs-etm.*
>>>>
>>>> But from the previous discussion, I thought that we wanted an entry to
>>>> cover all tools/perf/arch/arm64/ and other related folders. Or was it
>>>> just put all special interest parts (like SPE support) under one entry
>>>> and leave the other arm/arm64 parts to be caught by "PERFORMANCE EVENTS
>>>> SUBSYSTEM" entry?
>>>
>>> I do not have the time to maintain anything outside of coresight -
>>> listing individual files as I did removes any ambiguity on that front.
>>> I'm happy to add tools/perf/arch/arm and tools/perf/arch/arm64/ if you
>>> agree to maintain them.  In that case you will have to be more
>>> specific about the "other related folders" you are referring to above.

As Leo mentioned, I was thinking of tools/perf/util/arm-spe-decoder/

>>
>> None of us have time for this, hence why I think putting us all in one entry
>> with all of the files listed there makes the most sense; then people do
>> whatever they can and try to help each other out based on how much time they
>> have. I think that's much better than fine-grained maintainership where a
>> given file has a single point of failure.
> 
> Thanks for the clarification - just wanted to make sure I don't sign
> you guys up for something you didn't agree to.

And it's "R:" level, so none of the commitment associated with "M:". In 
addition - and maybe most important - the linux-arm-kernel list will (or 
should) be cc'ed.

> 
>>
>> So I think it should include:
>>
>>    tools/perf/arch/arm64/
>>    tools/pmu-events/arch/arm64/
>>
>> along with the SPE and Coresight files.
>>
>> Arnaldo would still handle the patches, so this is really about giving us a
>> chance to review incoming patches without having to fish them out from the
>> lists.
>>
>> Will
> .
> 

Cheers,
John

