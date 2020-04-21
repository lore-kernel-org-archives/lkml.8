Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBCAC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0CAF2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgDUNST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:18:19 -0400
Received: from foss.arm.com ([217.140.110.172]:34860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUNST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:18:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D76E31B;
        Tue, 21 Apr 2020 06:18:18 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FEAE3F68F;
        Tue, 21 Apr 2020 06:18:15 -0700 (PDT)
References: <20200414150556.10920-1-qais.yousef@arm.com> <jhjh7xlvqqe.mognet@arm.com> <20200421121305.ziu3dfqwo7cw6ymu@e107158-lin.cambridge.arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] sched/rt: Distribute tasks in find_lowest_rq()
In-reply-to: <20200421121305.ziu3dfqwo7cw6ymu@e107158-lin.cambridge.arm.com>
Date:   Tue, 21 Apr 2020 14:18:10 +0100
Message-ID: <jhjv9ltkmel.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/04/20 13:13, Qais Yousef wrote:
> On 04/14/20 19:58, Valentin Schneider wrote:
>>
>> I'm a bit wary about such blanket changes. I feel like most places impacted
>> by this change don't gain anything by using the random thing. In sched land
>> that would be:
>
> The API has always been clear that cpumask_any return a random cpu within the
> mask. And the fact it's a one liner with cpumask_first() directly visible,
> a user made the choice to stick to cpumask_any() indicates that that's what
> they wanted.
>
> Probably a lot of them they don't care what cpu is returned and happy with the
> random value. I don't see why it has to have an effect. Some could benefit,
> like my use case here. Or others truly don't care, then it's fine to return
> anything, as requested.
>

Exactly, *some* (which AFAICT is a minority) might benefit. So why should
all the others pay the price for a functionality they do not need?

I don't think your change would actually cause a splat somewhere; my point
is about changing existing behaviour without having a story for it. The
thing said 'pick a "random" cpu', sure, but it never did that, it always
picked the first.

I've pointed out two examples that want to be cpumask_first(), and I'm
absolutely certain there are more than these two out there. What if folks
ran some performance test and were completely fine with the _first()
behaviour? What tells you randomness won't degrade some cases?

IMO the correct procedure is to keep everything as it is and improve the
specific callsites that benefit from randomness. I get your point that
using cpumask_any() should be a good enough indicator of the latter, but I
don't think it can realistically be followed. To give my PoV, if in the
past someone had used a cpumask_any() where a cpumask_first() could do, I
would've acked it (disclaimer: super representative population of sample
size = 1).

Flipping the switch on everyone to then have a series of patches "oh this
one didn't need it", "this one neither", "I actually need this to be the
first" just feels sloppy.

> I CCed Marc who's the maintainer of this file who can clarify better if this
> really breaks anything.
>
> If any interrupt expects to be affined to a specific CPU then this must be
> described in DT/driver. I think the GIC controller is free to distribute them
> to any cpu otherwise if !force. Which is usually done by irq_balancer anyway
> in userspace, IIUC.
>
> I don't see how cpumask_any_and() break anything here too. I actually think it
> improves on things by better distribute the irqs on the system by default.
>

As you say, if someone wants smarter IRQ affinity they can do irq_balancer
and whatnot. The default kernel policy for now has been to shove everything
on the lowest-numbered CPU, and I see no valid reason to change that.
