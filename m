Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3CFC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F15206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgDUMNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:13:12 -0400
Received: from foss.arm.com ([217.140.110.172]:33898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgDUMNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:13:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDDB531B;
        Tue, 21 Apr 2020 05:13:10 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57E1A3F68F;
        Tue, 21 Apr 2020 05:13:08 -0700 (PDT)
Date:   Tue, 21 Apr 2020 13:13:05 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
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
Message-ID: <20200421121305.ziu3dfqwo7cw6ymu@e107158-lin.cambridge.arm.com>
References: <20200414150556.10920-1-qais.yousef@arm.com>
 <jhjh7xlvqqe.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jhjh7xlvqqe.mognet@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Rafael +Marc

(There's a question about a function that you maintain below, the context is
that cpumask_any() now truly returns a random cpu in the mask and there were
concern it might break something you maintain)

On 04/14/20 19:58, Valentin Schneider wrote:
> Hi,
> 
> On 14/04/20 16:05, Qais Yousef wrote:
> > Now that we have a proper function that returns a 'random' CPU in a mask [1]
> > utilize that in find_lowest_rq() to solve the thundering herd issue described
> > in this thread
> >
> >       https://lore.kernel.org/lkml/20200219140243.wfljmupcrwm2jelo@e107158-lin/
> >
> > But as a pre-amble, I noticed that the new cpumask_any_and_distribute() is
> > actually an alias for cpumask_any_and() which is documented as returning
> > a 'random' cpu but actually just does cpumask_first_and().
> >
> > The first 3 patches cleanup the API so that the whole family of
> > cpumask_any*() take advantage of the new 'random' behavior
> 
> I'm a bit wary about such blanket changes. I feel like most places impacted
> by this change don't gain anything by using the random thing. In sched land
> that would be:

The API has always been clear that cpumask_any return a random cpu within the
mask. And the fact it's a one liner with cpumask_first() directly visible,
a user made the choice to stick to cpumask_any() indicates that that's what
they wanted.

Probably a lot of them they don't care what cpu is returned and happy with the
random value. I don't see why it has to have an effect. Some could benefit,
like my use case here. Or others truly don't care, then it's fine to return
anything, as requested.

> 
> - The single cpumask_any() in core.c::select_task_rq()
> - Pretty much any function that wants a CPU id to dereference a
>   root_domain; there's some of them in deadline.c, topology.c
> 
> Looking some more into it, there's shadier things:
> 
> - cpufreq_offline() uses cpumask_any() to figure out the new policy
>   leader... That one should be cpumask_first()

I CCed Rafael who's the maintainer of this file who can speak better of what
should be expected.

I don't see why it _should_ be cpumask_first(). AFAICT any cpu can be the new
leader. So nothing breaks here.

> - gic_set_affinity() uses cpumask_any_and() (in the common case). If this
>   starts using randomness, you will stop affining e.g. all SPIs to CPU0
>   by default (!!!)

I CCed Marc who's the maintainer of this file who can clarify better if this
really breaks anything.

If any interrupt expects to be affined to a specific CPU then this must be
described in DT/driver. I think the GIC controller is free to distribute them
to any cpu otherwise if !force. Which is usually done by irq_balancer anyway
in userspace, IIUC.

I don't see how cpumask_any_and() break anything here too. I actually think it
improves on things by better distribute the irqs on the system by default.

Marc will know better for sure. It's been a long time I looked at irqchip code.

> - ... and there might be more

I can appreciate you have some concerns this might break something. But IMO
this will be isolated cases of bad copy/paste. I think the blanket conversion
of cpumask_any() to cpumask_first() is the bad one because it dishonours the
choice developers made to pick one over the other. As I mention above the doc
was clear it will return a random value and the oneliner gave a clear
alternative to the user if they missed the cpumask_first() API.

The name of the API is so descriptive anyway to think that most users got it
wrong. And I think it acts as a good natural documentation of the code.

> 
> I think people went with cpumask_any_* mostly because there is just
> cpumask_first() while there are more cpumask_any_* variants, and since
> those have been returning the first set CPU for over a decade people just
> went with it.

This is speculation. Unless we ask every developer we can't tell. Given the
clear documentation of cpumask_any() returns a random value, the natural
conclusion is that people want that or just truly don't care.

> 
> To move this forward, I would suggest renaming the current cpumask_any_*()
> into cpumask_first_*(), and THEN introduce the new pseudo-random
> ones. People are then free to hand-fix specific locations if it makes sense
> there, like you're doing for RT.

I strongly disagree with this. I'd rather keep the status-quo instead and just
use the new function in rt.c as it's currently named.

> 
> I think it's safe to say the vast majority of the current callers do not
> require randomness - the exceptions should mainly be scheduler / workqueues
> and the like.

It's hard to judge. As the API clearly says this returns a random value,
I think assuming that most users got it wrong is the unnatural way of
thinking. If there happened to be bad users, that's an isolated cases and bugs
that we can certainly be easily fixed.

Thanks

--
Qais Yousef

> 
> > and in patch
> > 4 I convert the cpumask_first_and() --> cpumask_any_and() in find_lowest_rq()
> > to allow to better distribute the RT tasks that wake up simultaneously.
> >
> > [1] https://lore.kernel.org/lkml/20200311010113.136465-1-joshdon@google.com/
> >
> > CC: Juri Lelli <juri.lelli@redhat.com>
> > CC: Vincent Guittot <vincent.guittot@linaro.org>
> > CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > CC: Steven Rostedt <rostedt@goodmis.org>
> > CC: Ben Segall <bsegall@google.com>
> > CC: Mel Gorman <mgorman@suse.de>
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: Yury Norov <yury.norov@gmail.com>
> > CC: Paul Turner <pjt@google.com>
> > CC: Alexey Dobriyan <adobriyan@gmail.com>
> > CC: Josh Don <joshdon@google.com>
> > CC: Pavan Kondeti <pkondeti@codeaurora.org>
> > CC: linux-kernel@vger.kernel.org
> >
> > Qais Yousef (4):
> >   cpumask: Rename cpumask_any_and_distribute
> >   cpumask: Make cpumask_any() truly random
> >   cpumask: Convert cpumask_any_but() to the new random function
> >   sched/rt: Better distribute tasks that wakeup simultaneously
> >
> >  include/linux/cpumask.h | 33 ++++++-----------
> >  kernel/sched/core.c     |  2 +-
> >  kernel/sched/rt.c       |  4 +-
> >  lib/cpumask.c           | 82 +++++++++++++++++++++++++++--------------
> >  4 files changed, 68 insertions(+), 53 deletions(-)
