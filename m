Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168E1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AF7214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgA1QPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:15:16 -0500
Received: from foss.arm.com ([217.140.110.172]:60062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgA1QPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:15:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E0791FB;
        Tue, 28 Jan 2020 08:15:15 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF54A3F68E;
        Tue, 28 Jan 2020 08:15:13 -0800 (PST)
Subject: Re: [Patch v8 1/7] sched/pelt: Add support to track thermal pressure
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-2-git-send-email-thara.gopinath@linaro.org>
 <20200116151724.GR2827@hirez.programming.kicks-ass.net>
 <e5ecad29-11d8-e7ff-27ff-b63ca44fdcd3@arm.com> <5E2B405A.7040405@linaro.org>
 <6232d91d-2603-06ca-0e7c-66ec2a137759@arm.com> <5E3037F3.30507@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <26e7d02f-3ecf-5769-424f-62fb98fe3ec2@arm.com>
Date:   Tue, 28 Jan 2020 17:15:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5E3037F3.30507@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2020 14:32, Thara Gopinath wrote:
> On 01/27/2020 04:28 AM, Dietmar Eggemann wrote:
>> On 24/01/2020 20:07, Thara Gopinath wrote:
>>> On 01/23/2020 02:15 PM, Dietmar Eggemann wrote:
>>>> On 16/01/2020 16:17, Peter Zijlstra wrote:
>>>>> On Tue, Jan 14, 2020 at 02:57:33PM -0500, Thara Gopinath wrote:
>>
>> [...]
>>
>>>>>> +#ifdef CONFIG_HAVE_SCHED_THERMAL_PRESSURE
>>>>
>>>> I assume your plan is to enable this for Arm and Arm64? Otherwise the
>>>> code in 3/7 should also be guarded by this.
>>>
>>> Yes. I think it should be enabled for arm and arm64. I can submit a
>>> patch after this series is accepted to enable it.
>>> Nevertheless , I don't understand why is patch 3/7 tied with this.
>>> This portion is the averaging of thermal pressure. Patch 3/7 is to store
>>> and retrieve the instantaneous value.
>>
>> 3/7 is the code which overwrites the scheduler default
>> arch_cpu_thermal_pressure() [include/linux/sched/topology.h]. I see it
>> more of the engine to drive  thermal pressure tracking in the scheduler.
>>
>> So all the code in 3/7 only makes sense if HAVE_SCHED_THERMAL_PRESSURE
>> is selected by the arch. IMHO, 3/7 and enabling it for Arm/Arm64 should
>> go in together.
> Hi Dietmar,
> I will have to respectfully disagree here. We explicitly separated out
> this stuff (updating and reading of instantaneous thermal pressure)from
> scheduler. To me putting all this under HAVE_SCHED_THERMAL_PRESSURE is
> equivalent to keeping this stuff in scheduler specific code. But I will
> provide a patch enabling the option HAVE_SCHED_THERMAL_PRESSURE in
> arm64/defconfig. arm is trickier though as it has a bunch of SoC
> defconfigs. I will leave it out for now .

If you enable HAVE_SCHED_THERMAL_PRESSURE for Arm64 w/ this patch-set
then I don't see any disagreement here.
