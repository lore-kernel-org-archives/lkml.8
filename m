Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F151C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C472082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390554AbgFXLIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:08:04 -0400
Received: from foss.arm.com ([217.140.110.172]:34894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbgFXLIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:08:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EABF1F1;
        Wed, 24 Jun 2020 04:08:03 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D6E53F6CF;
        Wed, 24 Jun 2020 04:08:01 -0700 (PDT)
Date:   Wed, 24 Jun 2020 12:07:59 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200624110758.oewxkpdk5fzxwxod@e107158-lin.cambridge.arm.com>
References: <20200619172011.5810-1-qais.yousef@arm.com>
 <20200619172011.5810-3-qais.yousef@arm.com>
 <87pn9oor2t.derkling@matbug.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pn9oor2t.derkling@matbug.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/20 09:34, Patrick Bellasi wrote:
> 
> On Fri, Jun 19, 2020 at 19:20:11 +0200, Qais Yousef <qais.yousef@arm.com> wrote...
> 
> [...]
> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 4265861e13e9..9ab22f699613 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -793,6 +793,25 @@ unsigned int sysctl_sched_uclamp_util_max = SCHED_CAPACITY_SCALE;
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
> > + * disabled, since we have an actual users that make use of uclamp
> > + * functionality.
> > + *
> > + * The knobs that would disable this static key are:
> > + *
> > + *   * A task modifying its uclamp value with sched_setattr().
> > + *   * An admin modifying the sysctl_sched_uclamp_{min, max} via procfs.
> > + *   * An admin modifying the cgroup cpu.uclamp.{min, max}
> > + */
> > +static DEFINE_STATIC_KEY_TRUE(sched_uclamp_unused);
> 
> I would personally prefer a non negated semantic.
> 
> Why not using 'sched_uclamp_enabled'?

This was already discussed and already changed to sched_uclamp_used which
I will post in v3, which is already ready.

> 
> > +
> >  /* Integer rounded range for each bucket */
> >  #define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
> >  
> > @@ -993,9 +1012,16 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
> >  	lockdep_assert_held(&rq->lock);
> >  
> >  	bucket = &uc_rq->bucket[uc_se->bucket_id];
> > -	SCHED_WARN_ON(!bucket->tasks);
> > -	if (likely(bucket->tasks))
> > -		bucket->tasks--;
> > +
> > +	/*
> > +	 * This could happen if sched_uclamp_unused was disabled while the
> > +	 * current task was running, hence we could end up with unbalanced call
> > +	 * to uclamp_rq_dec_id().
> > +	 */
> > +	if (unlikely(!bucket->tasks))
> > +		return;
> > +
> > +	bucket->tasks--;
> 
> Since above you are not really changing the logic, why changing the
> code?

The logic has changed. We return immediately now.

> 
> The SCHED_WARN_ON/if(likely) is a defensive programming thing.
> I understand that SCHED_WARN_ON() can now be misleading because of the
> unbalanced calls but... why not just removing it?

Do you think we need to execute the rest of the code if bucket->tasks is 0? It
would be good to know if there's a corner case you're worried about. AFAIU if
it is 0, this means there's nothing to do.

> 
> Maybe also adding in the comment, but I don't see valid reasons to
> change the code if the functionality is not changing.

If it means a lot to you, I could put it back as it was. I just don't see why
we can't return immediately instead.

> 
> 
> >  	uc_se->active = false;
> >  
> >  	/*
> > @@ -1031,6 +1057,13 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> >  {
> >  	enum uclamp_id clamp_id;
> >  
> > +	/*
> > +	 * Avoid any overhead until uclamp is actually used by the userspace.
> > +	 * Including the potential JMP if we use static_branch_unlikely()
> 
> The comment above (about unlikely) seems not to match the code?

It does. The comment says if we use unlikely() when uclamp is not used we'll
incur an extra jump/branch. Hence we use likely to avoid this potential
overhead.

> 
> > +	 */
> > +	if (static_branch_likely(&sched_uclamp_unused))
> > +		return;
> 
> Moreover, something like:
> 
>        if (static_key_false(&sched_uclamp_enabled))
>                 return;
> 
> is not just good enough?

Aren't they both good enough?

Use of static_key_false() is deprecated AFAICS.

> 
> > +
> >  	if (unlikely(!p->sched_class->uclamp_enabled))
> >  		return;
> 
> Since we already have these per sched_class gates, I'm wondering if it
> could make sense to just re-purpose them.
> 
> Problem with the static key is that if just one RT task opts in, CFS
> will still pay the overheads, and vice versa too.
> 
> So, an alternative approach could be to opt in sched classes on-demand.

I'll defer to Peter here.

Re-purposing the sched_class->uclamp_enable means we can't use a static key and
we'll potentially still incur a cache penalty in there even if uclamp is not
used. Based on RT sysctl discussion, this won't be okay if we can do better.

> 
> The above if(unlikely) is not exactly has a static key true, but I
> assume we agree the overheads we are tacking are nothing compared to
> that check, aren't they?

I'm not sure we can agree on that. The overhead seems to be system specific. On
juno-r2 it seemed I$, but on 2 sockets systems it seems the D$. So I can't say
for sure no one will care. The current approach gives stronger guarantees.

Thanks

--
Qais Yousef
