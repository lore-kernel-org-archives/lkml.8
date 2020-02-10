Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F632C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FED92080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbgBJMAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:00:03 -0500
Received: from foss.arm.com ([217.140.110.172]:59292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbgBJMAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:00:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6627E1FB;
        Mon, 10 Feb 2020 04:00:02 -0800 (PST)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C3BF3F6CF;
        Mon, 10 Feb 2020 03:59:59 -0800 (PST)
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c7f299bb-5302-9bfb-2356-61b4c856bd2e@arm.com>
Date:   Mon, 10 Feb 2020 12:59:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5E3DE7CC.3060300@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2020 23:42, Thara Gopinath wrote:
> On 02/04/2020 03:39 AM, Dietmar Eggemann wrote:
>> On 03/02/2020 16:55, Peter Zijlstra wrote:
>>> On Mon, Feb 03, 2020 at 07:07:57AM -0500, Thara Gopinath wrote:
>>>> On 01/28/2020 06:56 PM, Randy Dunlap wrote:
>>>>> Hi,
>>>>>
>>>>> On 1/28/20 2:36 PM, Thara Gopinath wrote:

[...]

>> I do agree. IMHO, there are just two little things outstanding:
>>
>> (1) arch_scale_thermal_pressure() instead  of
>>     arch_cpu_thermal_pressure() in v8 4/7
> 
> The "scale_" part was discussed in v6. Ionela had suggested that having
> "scale" is not suited for this function because "thermal pressure" is
> not exactly scaled but subtracted. I actually agree with that.
> 
> https://lore.kernel.org/lkml/20191223175005.GA31446@arm.com/
> 
> Having said that if everyone feel the same about naming of this
> function, I can change it one last time.

I'm still in favor for this. And Vincent seems to be OK as well:

https://lore.kernel.org/r/CAKfTPtBzoLnvAJ7sjPogMYS=WwBbdzWO07Kj=KDFVpO4=Su5ow@mail.gmail.com

The 'v6->v7' change note:

- Renamed arch_scale_thermal_capacity to arch_cpu_thermal_pressure
  as per review comments from Peter, Dietmar and Ionela.

is really not saying from which review comment the individual changes in
the function name are coming from. And I don't see an answer to Ionela's
email saying that her proposal will manifest in a particular part of
this change.

>> (2) guarding of thermal pressure code in Arm's arch_topology driver  w/
>>     CONFIG_HAVE_SCHED_THERMAL_PRESSURE plus disabling it by default for
>>     Arm64.
> It was enabled by default as per your suggestion in v9.
> 
> The patch can be dropped.
> 
> I don't understand the need to guard arch_topology with
> CONFIG_HAVE_SCHED_THERMAL_PRESSURE. CONFIG_HAVE_SCHED_THERMAL_PRESSURE
> is for scheduler to enable/disable averaging of thermal pressure. We
> wanted to separate updating and retrieving of instantaneous thermal
> pressure from scheduler. Guarding it with
> CONFIG_HAVE_SCHED_THERMAL_PRESSURE is to me equivalent to putting back
> this whole code in the scheduler framework. I am against it. I also do
> not see other arch_ functions guarded similarly.

Cpu-invariant accounting can't be guarded with a kernel CONFIG switch.
Frequency-invariant accounting could be with CONFIG_CPU_FREQ but this is
enabled by default by Arm64 defconfig.
Thermal pressure (accounting) (CONFIG_HAVE_SCHED_THERMAL_PRESSURE) is
disabled by default so why should a per-cpu thermal_pressure be
maintained on such a system (CONFIG_CPU_THERMAL=y by default)?
