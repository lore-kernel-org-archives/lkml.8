Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A36C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BE024656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBSJI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:08:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:60612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgBSJI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:08:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DC0A8AF33;
        Wed, 19 Feb 2020 09:08:25 +0000 (UTC)
Date:   Wed, 19 Feb 2020 09:08:22 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, hdanton@sina.com
Subject: Re: [PATCH v2 4/5] sched/pelt: Add a new runnable average signal
Message-ID: <20200219090822.GH3420@suse.de>
References: <20200214152729.6059-1-vincent.guittot@linaro.org>
 <20200214152729.6059-5-vincent.guittot@linaro.org>
 <4cda8dc3-f6bb-2896-c899-65eadd5c839d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <4cda8dc3-f6bb-2896-c899-65eadd5c839d@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 09:19:16PM +0000, Valentin Schneider wrote:
> On 14/02/2020 15:27, Vincent Guittot wrote:
> > Now that runnable_load_avg has been removed, we can replace it by a new
> > signal that will highlight the runnable pressure on a cfs_rq. This signal
> > track the waiting time of tasks on rq and can help to better define the
> > state of rqs.
> > 
> > At now, only util_avg is used to define the state of a rq:
> >   A rq with more that around 80% of utilization and more than 1 tasks is
> >   considered as overloaded.
> > 
> > But the util_avg signal of a rq can become temporaly low after that a task
> > migrated onto another rq which can bias the classification of the rq.
> > 
> > When tasks compete for the same rq, their runnable average signal will be
> > higher than util_avg as it will include the waiting time and we can use
> > this signal to better classify cfs_rqs.
> > 
> > The new runnable_avg will track the runnable time of a task which simply
> > adds the waiting time to the running time. The runnable _avg of cfs_rq
> > will be the /Sum of se's runnable_avg and the runnable_avg of group entity
> > will follow the one of the rq similarly to util_avg.
> > 
> 
> I did a bit of playing around with tracepoints and it seems to be behaving
> fine. For instance, if I spawn 12 always runnable tasks (sysbench --test=cpu)
> on my Juno (6 CPUs), I get to a system-wide runnable value (\Sum cpu_runnable())
> of about 12K. I've only eyeballed them, but migration of the signal values
> seem fine too.
> 
> I have a slight worry that the rq-wide runnable signal might be too easy to
> inflate, since we aggregate for *all* runnable tasks, and that may not play
> well with your group_is_overloaded() change (despite having the imbalance_pct
> on the "right" side).
> 
> In any case I'll need to convince myself of it with some messing around, and
> this concerns patch 5 more than patch 4. So FWIW for this one:
> 
> Tested-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> I also have one (two) more nit(s) below.
> 

Thanks.

> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> > diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> > @@ -227,14 +231,14 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
> >  	 * Step 1: accumulate *_sum since last_update_time. If we haven't
> >  	 * crossed period boundaries, finish.
> >  	 */
> > -	if (!accumulate_sum(delta, sa, load, running))
> > +	if (!accumulate_sum(delta, sa, load, runnable, running))
> >  		return 0;
> >  
> >  	return 1;
> >  }
> >  
> >  static __always_inline void
> > -___update_load_avg(struct sched_avg *sa, unsigned long load)
> > +___update_load_avg(struct sched_avg *sa, unsigned long load, unsigned long runnable)
> >  {
> >  	u32 divider = LOAD_AVG_MAX - 1024 + sa->period_contrib;
> >  
> > @@ -242,6 +246,7 @@ ___update_load_avg(struct sched_avg *sa, unsigned long load)
> >  	 * Step 2: update *_avg.
> >  	 */
> >  	sa->load_avg = div_u64(load * sa->load_sum, divider);
> > +	sa->runnable_avg =	div _u64(runnable * sa->runnable_sum, divider);
>                           ^^^^^^        ^^^^^^^^
>                             a)             b)
> a) That's a tab
> 

Fixed and I'll post a v4 of my own series with Vincent's included.

> b) The value being passed is always 1, do we really need it to expose it as a
>    parameter?

This does appear to be an oversight but I'm not familiar enough with
pelt to be sure.

___update_load_avg() is called when sum of the load has changed because
a pelt period has passed and it has lost sight and does not care if an
individual sched entity is runnable or not. The parameter was added by
this patch but I cannot find any useful meaning for it.

Vincent, what was your thinking here? Should the parameter be removed?

-- 
Mel Gorman
SUSE Labs
