Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07444C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C1720716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgA2MKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:10:08 -0500
Received: from foss.arm.com ([217.140.110.172]:40284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgA2MKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:10:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B5CB1FB;
        Wed, 29 Jan 2020 04:10:07 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C1093F67D;
        Wed, 29 Jan 2020 04:10:06 -0800 (PST)
Subject: Re: [PATCH v3 1/3] sched/fair: Add asymmetric CPU capacity wakeup
 scan
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, qperret@google.com,
        adharmap@codeaurora.org
References: <20200126200934.18712-1-valentin.schneider@arm.com>
 <20200126200934.18712-2-valentin.schneider@arm.com>
 <20200128062245.GA27398@codeaurora.org>
 <1ed322d6-0325-ecac-cc68-326a14b8c1dd@arm.com>
 <1aa14491-517e-92d2-08b0-568338d75812@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <f5eb1fa8-2b0e-19ed-fa74-a16bfa50dc17@arm.com>
Date:   Wed, 29 Jan 2020 12:10:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1aa14491-517e-92d2-08b0-568338d75812@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/2020 10:38, Dietmar Eggemann wrote:
> On 28/01/2020 12:30, Valentin Schneider wrote:
>> Hi Pavan,
>>
>> On 28/01/2020 06:22, Pavan Kondeti wrote:
>>> Hi Valentin,
>>>
>>> On Sun, Jan 26, 2020 at 08:09:32PM +0000, Valentin Schneider wrote:
> 
> [...]
> 
>>>> +
>>>> +	if (!static_branch_unlikely(&sched_asym_cpucapacity))
>>>> +		return -1;
> 
> We do need this one to bail out quickly on non CPU asym systems. (1)
> 
>>>> +	sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
>>>> +	if (!sd)
>>>> +		return -1;
> 
> And I assume we can't return target here because of exclusive cpusets
> which can form symmetric CPU capacities islands on a CPU asymmetric
> system? (2)
> 

Precisely, the "canonical" check for asymmetry is static key + SD pointer.
In terms of functionality we could "just" check sd_asym_cpucapacity (it can't
be set without having the static key set, though the reverse isn't true),
but we *want* to use the static key here to make SMP people happy.

>> That's not the case anymore, so indeed we may be able to bail out of
>> select_idle_sibling() right after select_idle_capacity() (or after the
>> prev / recent_used_cpu checks). Our only requirement here is that sd_llc
>> remains a subset of sd_asym_cpucapacity.
> 
> How do you distinguish '-1' in (1), (2) and 'best_cpu = -1' (3)?
> 
> In (1) and (2) you want to check if target is idle (or sched_idle) but
> in (3) you probably only want to check 'recent_used_cpu'?
> 

Right, when we come back from select_idle_capacity(), and we did go through
the CPU loop, but we still returned -1, it means all CPUs in sd_asym_cpucapacity
were not idle. This includes 'target' of course, so we shouldn't need to
check it again. 

In those cases we might still not have evaluated 'prev' or 'recent_used_cpu'.
It's somewhat of a last ditch attempt to find an idle CPU, and they'll only
help when they aren't in sd_asym_cpucapacity. I'm actually curious as to how
much the 'recent_used_cpu' thing helps, I've never paid it much attention.

So yeah my options are (for asym CPU capacity topologies):
a) just bail out after select_idle_capacity()
b) try to squeeze out a bit more out of select_idle_sibling() by also doing
  the 'prev' & 'recent_used_cpu' checks.

a) is quite easy to implement; I can just inline the static key and sd checks
  in select_idle_sibling() and return unconditionally once I'm past those
  checks.

b) is more intrusive and I don't have a clear picture yet as to how much it
  will really bring to the table.

I'll think about it and try to play around with both of these.
