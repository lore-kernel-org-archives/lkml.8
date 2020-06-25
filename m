Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C290C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 335742076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404105AbgFYLAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:00:12 -0400
Received: from foss.arm.com ([217.140.110.172]:60942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404042AbgFYLAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:00:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D03F61FB;
        Thu, 25 Jun 2020 04:00:10 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BC913F73C;
        Thu, 25 Jun 2020 04:00:09 -0700 (PDT)
Date:   Thu, 25 Jun 2020 12:00:06 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200625110006.q3iepcrh2uh4oizv@e107158-lin.cambridge.arm.com>
References: <20200624172605.26715-1-qais.yousef@arm.com>
 <20200624172605.26715-3-qais.yousef@arm.com>
 <jhj5zbgroct.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jhj5zbgroct.mognet@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin

On 06/25/20 01:16, Valentin Schneider wrote:
> 
> Hi Qais,
> 
> On 24/06/20 18:26, Qais Yousef wrote:
> [...]
> > ---
> >
> > This takes a different approach to PSI which introduces a config option
> >
> > ```
> >       CONFIG_PSI_DEFAULT_DISABLED
> >
> >         Require boot parameter to enable pressure stall information
> >         tracking (NEW)
> >
> >       boot param psi
> > ```
> >
> > via commit e0c274472d5d "psi: make disabling/enabling easier for vendor kernels"
> >
> > uclamp has a clearer points of entry when userspace would like to use it so we
> > can automatically flip the switch if the kernel is running on a userspace that
> > wants to user utilclamp without any extra userspace visible switches.
> >
> > I wanted to make this dependent on schedutil being the governor too, but beside
> > the complexity, uclamp is used for capacity awareness. We could certainly
> > construct a more complex condition, but I'm not sure it's worth it. Open to
> > hear more opinions and points of views on this :)
> >
> 
> I think the toggling conditions are good as they are. However, speaking of
> schedutil, doesn't this patch break the RT frequency boost? Mind you it
> might be too late for me to be thinking about this stuff.

Good catch. I did test RT, but I just realized the RT test ran after it
enabled uclamp again. So I missed the case when it wasn't enabled.

> 
> In schedutil_cpu_util(), when uclamp isn't compiled it, we have an explicit
> 'goto max'. When uclamp *is* compiled in, that's taken care of by the
> "natural" RT uclamp aggregation... Which doesn't happen until we flip the
> static key. 
> 
> It's yucky, but if you declare the key in the internal sched header, you
> could reuse it in the existing 'goto max' (or sysctl value, when we make
> that tweakable) path. 

Not sure if this is the best way forward. I need to think about it.
While I am not keen on enabling in kernel users of util clamp, but there was
already an attempt to do so. This approach will not allow us to implement
something in the future for that. Which maybe is what we want..

> 
> >
> >  kernel/sched/core.c | 54 +++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 50 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 235b2cae00a0..44e03d4fd19d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -794,6 +794,25 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
> >  /* All clamps are required to be less or equal than these values */
> >  static struct uclamp_se uclamp_default[UCLAMP_CNT];
> >  
> > +/*
> > + * This static key is used to reduce the uclamp overhead in the fast path. It
> > + * only disables the call to uclamp_rq_{inc, dec}() in enqueue/dequeue_task().
> > + *
> > + * This allows users to continue to enable uclamp in their kernel config with
> > + * minimum uclamp overhead in the fast path.
> > + *
> > + * As soon as userspace modifies any of the uclamp knobs, the static key is
> > + * enabled, since we have an actual users that make use of uclamp
> > + * functionality.
> > + *
> > + * The knobs that would enable this static key are:
> > + *
> > + *   * A task modifying its uclamp value with sched_setattr().
> 
> That one makes it not just userspace, right? While the sched_setattr()
> stuff is expected to be unexported, it isn't ATM and we may expect some
> modules to ask for a uclamp API eventually.

This has already come up with another thread [1]. I think in-kernel users
shouldn't go through this path. I will propose something to give stronger
guarantees in this regard.

> > -	if (update_root_tg)
> > +	if (update_root_tg) {
> >  		uclamp_update_root_tg();
> > +		static_branch_enable(&sched_uclamp_used);
> 
> I don't think it matters ATM, but shouldn't we flip that *before* updating
> the TG's to avoid any future surprises? 

What sort of surprises are you thinking of?

Thanks

--
Qais Yousef

[1] https://lore.kernel.org/lkml/20200624175236.nblndmg6dfq2vr2u@e107158-lin.cambridge.arm.com/
