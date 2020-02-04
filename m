Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA72C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 08:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6A12051A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 08:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgBDIjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 03:39:24 -0500
Received: from foss.arm.com ([217.140.110.172]:34400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgBDIjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 03:39:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8084130E;
        Tue,  4 Feb 2020 00:39:23 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 743BE3F6CF;
        Tue,  4 Feb 2020 00:39:20 -0800 (PST)
Subject: Re: [Patch v9 7/8] sched/fair: Enable tuning of decay period
To:     Peter Zijlstra <peterz@infradead.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, mingo@redhat.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        rui.zhang@intel.com, qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rostedt@goodmis.org, will@kernel.org,
        catalin.marinas@arm.com, sudeep.holla@arm.com,
        juri.lelli@redhat.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com
References: <1580250967-4386-1-git-send-email-thara.gopinath@linaro.org>
 <1580250967-4386-8-git-send-email-thara.gopinath@linaro.org>
 <4eb10687-1a62-cee3-7285-3f50cc023071@infradead.org>
 <5E380D1D.7020500@linaro.org>
 <20200203155549.GL14914@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <cc83634f-b3af-6024-7f89-9b231b153070@arm.com>
Date:   Tue, 4 Feb 2020 09:39:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203155549.GL14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2020 16:55, Peter Zijlstra wrote:
> On Mon, Feb 03, 2020 at 07:07:57AM -0500, Thara Gopinath wrote:
>> On 01/28/2020 06:56 PM, Randy Dunlap wrote:
>>> Hi,
>>>
>>> On 1/28/20 2:36 PM, Thara Gopinath wrote:
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>> index e35b28e..be4147b 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -4376,6 +4376,11 @@
>>>>  			incurs a small amount of overhead in the scheduler
>>>>  			but is useful for debugging and performance tuning.
>>>>  
>>>> +	sched_thermal_decay_shift=
>>>> +			[KNL, SMP] Set decay shift for thermal pressure signal.
>>>> +			Format: integer between 0 and 10
>>>> +			Default is 0.
>>>> +
>>>
>>> That tells an admin [or any reader] almost nothing about this kernel parameter
>>> or what it does.  And nothing about what unit the value is in.
>>> Does the value 0 disable this feature?
>>
>> Thanks for the review. 0 does not disable "thermal pressure" feature. 0
>> means the default decay period for averaging PELT signals (which is
>> usually 32 but configurable) will also be applied for thermal pressure
>> signal. A shift will shift the default decay period.
>>
>> You are right. It needs more explanation here. I will fix it and send v10.
> 
> Or just send an update for this patch? I'm thinking most of this is
> looking good.

I do agree. IMHO, there are just two little things outstanding:

(1) arch_scale_thermal_pressure() instead  of
    arch_cpu_thermal_pressure() in v8 4/7

(2) guarding of thermal pressure code in Arm's arch_topology driver  w/
    CONFIG_HAVE_SCHED_THERMAL_PRESSURE plus disabling it by default for
    Arm64.
