Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EA8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627D620720
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGBQZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:25:48 -0400
Received: from foss.arm.com ([217.140.110.172]:40712 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgGBQZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:25:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E17621FB;
        Thu,  2 Jul 2020 09:25:47 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E07CC3F71E;
        Thu,  2 Jul 2020 09:25:46 -0700 (PDT)
References: <20200701190656.10126-1-valentin.schneider@arm.com> <20200701190656.10126-3-valentin.schneider@arm.com> <20200702121536.GA765585@google.com> <jhjk0zm7zv8.mognet@arm.com> <20200702154514.GA1072702@google.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com
Subject: Re: [PATCH v3 2/7] sched/topology: Define and assign sched_domain flag metadata
In-reply-to: <20200702154514.GA1072702@google.com>
Date:   Thu, 02 Jul 2020 17:25:41 +0100
Message-ID: <jhjfta9994q.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/07/20 16:45, Quentin Perret wrote:
> On Thursday 02 Jul 2020 at 15:31:07 (+0100), Valentin Schneider wrote:
>> There an "interesting" quirk of asym_cpu_capacity_level() in that it does
>> something slightly different than what it says on the tin: it detects
>> the lowest topology level where *the biggest* CPU capacity is visible by
>> all CPUs. That works just fine on big.LITTLE, but there are questionable
>> DynamIQ topologies that could hit some issues.
>>
>> Consider:
>>
>> DIE [                   ]
>> MC  [             ][    ] <- sd_asym_cpucapacity
>>      0   1   2   3  4  5
>>      L   L   B   B  B  B
>>
>> asym_cpu_capacity_level() would pick MC as the asymmetric topology level,
>> and you can argue either way: it should be DIE, because that's where CPUs 4
>> and 5 can see a LITTLE, or it should be MC, at least for CPUs 0-3 because
>> there they see all CPU capacities.
>
> Right, I am not looking forward to these topologies...

I'll try my best to prevent those from seeing the light of day, but you
know how this works...

>> Say there are two clusters in the system, one with a lone big CPU and the
>> other with a mix of big and LITTLE CPUs:
>>
>> DIE [                ]
>> MC  [             ][ ]
>>      0   1   2   3  4
>>      L   L   B   B  B
>>
>> asym_cpu_capacity_level() will figure out that the MC level is the one
>> where all CPUs can see a CPU of max capacity, and we will thus set
>> SD_ASYM_CPUCAPACITY at MC level for all CPUs.
>>
>> That lone big CPU will degenerate its MC domain, since it would be alone in
>> there, and will end up with just a DIE domain. Since the flag was only set
>> at MC, this CPU ends up not seeing any SD with the flag set, which is
>> broken.
>
> +1
>
>> Rather than clearing dflags at every topology level, clear it before
>> entering the topology level loop. This will properly propagate upwards
>> flags that are set starting from a certain level.
>
> I'm feeling a bit nervous about that asymmetry -- in your example
> select_idle_capacity() on, say, CPU3 will see less CPUs than on CPU4.
> So, you might get fun side-effects where all task migrated to CPUs 0-3
> will be 'stuck' there while CPU 4 stays mostly idle.
>

It's actually pretty close to what happens with the LLC domain on SMP -
select_idle_sibling() doesn't look outside of it. The wake_affine() stuff
might steer the task towards a different LLC, but that's about it for
wakeups. We rely on load balancing (fork/exec, newidle, nohz and periodic)
to spread this further - and we would here too.

It gets "funny" for EAS when we aren't overutilized and thus can't rely on
load balancing; at least misfit ought to still work. It *is* a weird
topology, for sure.

> I have a few ideas to avoid that (e.g. looking at the rd span in
> select_idle_capacity() instead of sd_asym_cpucapacity) but all this is
> theoretical, so I'm happy to wait for a real platform to be released
> before we worry too much about it.
>
> In the meantime:
>
> Reviewed-by: Quentin Perret <qperret@google.com>

Thanks!
