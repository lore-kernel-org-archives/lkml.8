Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D40C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114AC20873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbgBNK1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 05:27:02 -0500
Received: from foss.arm.com ([217.140.110.172]:59472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbgBNK1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 05:27:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BD2B328;
        Fri, 14 Feb 2020 02:27:01 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 477673F6CF;
        Fri, 14 Feb 2020 02:26:58 -0800 (PST)
Subject: Re: [Patch v9 7/8] sched/fair: Enable tuning of decay period
To:     Thara Gopinath <thara.gopinath@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
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
 <cc83634f-b3af-6024-7f89-9b231b153070@arm.com> <5E3DE7CC.3060300@linaro.org>
 <c7f299bb-5302-9bfb-2356-61b4c856bd2e@arm.com> <5E455533.3000600@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <549ab3ab-f344-a915-7c6a-b0ffa808c354@arm.com>
Date:   Fri, 14 Feb 2020 11:26:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5E455533.3000600@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2020 14:54, Thara Gopinath wrote:
> On 02/10/2020 06:59 AM, Dietmar Eggemann wrote:
>> On 07/02/2020 23:42, Thara Gopinath wrote:
>>> On 02/04/2020 03:39 AM, Dietmar Eggemann wrote:
>>>> On 03/02/2020 16:55, Peter Zijlstra wrote:
>>>>> On Mon, Feb 03, 2020 at 07:07:57AM -0500, Thara Gopinath wrote:
>>>>>> On 01/28/2020 06:56 PM, Randy Dunlap wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 1/28/20 2:36 PM, Thara Gopinath wrote:

[...]

>> is really not saying from which review comment the individual changes in
>> the function name are coming from. And I don't see an answer to Ionela's
>> email saying that her proposal will manifest in a particular part of
>> this change.
> Hi Dietmar,
> 
> Like I said, don't want to argue on name. It is trivial for me. I have
> v10 prepped with the name change. Will send it out shortly.

Thanks.

[...]

>> Cpu-invariant accounting can't be guarded with a kernel CONFIG switch.
>> Frequency-invariant accounting could be with CONFIG_CPU_FREQ but this is
>> enabled by default by Arm64 defconfig.
>> Thermal pressure (accounting) (CONFIG_HAVE_SCHED_THERMAL_PRESSURE) is
>> disabled by default so why should a per-cpu thermal_pressure be
>> maintained on such a system (CONFIG_CPU_THERMAL=y by default)?
> 
> I agree that there is no need for per-cpu thermal pressure to be
> maintained if no averaging is happening in the scheduler, today. I don't
> know if there will ever be an use for it.

All arch_scale_FOO() functions follow the approach to force the arch
(currently x86, arm, arm64) to do

#define arch_scale_FOO BAR

to enable the FOO functionality.

There is no direct link between consumer and provider here.

 consumer (sched) -> arch <- provider (arch, counters, CPUfreq, CPU
                                       cooling, etc.)

So IMHO, FOO=thermal_pressure should follow this design pattern too.

'thermal_pressure' would be the only one which can be disabled by a
kernel config switch at the consumer side.
IMHO, it doesn't make sense to have the provider operating in this case.

> My issue has to do with using a config option meant for internal
> scheduler code being used else where. To me, once this happens, the
> entire work done to separate out reading and writing of instantaneous
> thermal pressure to arch_topology makes no sense. We could have kept it
> in scheduler itself.

You might see thermal_pressure more on the level of irq_load or
[rt/dl]_rq_load and that could be why we have a different opinion here?

Now rt_rq_load and dl_rq_load are scheduler internal providers and
irq_load is driven by 'irq_delta + steal' time (which is much closer to
the scheduler than thermal for instance).

My assumption is that we don't want a direct link between the scheduler
and e.g. a provider 'thermal'.

> Another way I think about this whole thermal pressure framework  is that
> it is the job of cooling device or cpufreq or any other entity to update
> a throttle in maximum pressure to the scheduler. It should be
> independent of what scheduler does with it. Scheduler can choose to
> ignore it
