Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B589AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C58A2065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qcyKhjDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgEOKjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgEOKjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:39:32 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EA9C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d6gJlIUI0ETFP+NUvnbl5RO+OQG2do57lk8eV+Mz+RA=; b=qcyKhjDTftf9MxoT0KvGbOrVbA
        0n5smoKJH7vHqh12ZimmdH6szzk4CPSBXN7QIqYPK5sDypKhGFojNLv9w+QONdTujIs4uvEABI0gy
        Djxa7HDnJfi6MTNM2tjAbLSd0ToobfVYMMLAbnRg6C+2MRsqb+oQvi78gC4JUmc1T4qeI8dqLtNcn
        B+69XOLbh029kwDNZuVO3sTSZqDLiNwOHWSG1C8U55Fz8ZNT6MDuEJoiUzYf0ytxqnavndz2MvXCr
        EUogQ7R5xgPuZqFSzP/g5iNES+5e/vRXwdi1MwIhAQUO+rZcoCYvSKYD3eOCl/WDSwEenGcI8idwK
        KYcqNtbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZXjy-00052d-31; Fri, 15 May 2020 10:38:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 12DE73007CD;
        Fri, 15 May 2020 12:38:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D892B20267E65; Fri, 15 May 2020 12:38:44 +0200 (CEST)
Date:   Fri, 15 May 2020 12:38:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Aaron Lu <aaron.lwe@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH updated v2] sched/fair: core wide cfs task priority
 comparison
Message-ID: <20200515103844.GG2978@hirez.programming.kicks-ass.net>
References: <20200420080759.GA224731@ziqianlu-desktop.localdomain>
 <CANaguZDP3nyBdjLeeCZGoUoYk6Lf0HUv19N2Qxo4CpZfrjPZHA@mail.gmail.com>
 <20200421025131.GA227300@aaronlu-desktop>
 <20200424142443.GA263207@aaronlu-desktop>
 <20200506143506.GH5298@hirez.programming.kicks-ass.net>
 <20200508084419.GA120223@aaronlu-desktop>
 <20200508090925.GV5298@hirez.programming.kicks-ass.net>
 <20200508123457.GA122180@aaronlu-desktop>
 <20200514130248.GD2940@hirez.programming.kicks-ass.net>
 <CANaguZD_ZknCrnUA8TYs4rc0TLJZ9J2_FcWmW5cxEMWDTdL6hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANaguZD_ZknCrnUA8TYs4rc0TLJZ9J2_FcWmW5cxEMWDTdL6hg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 06:51:27PM -0400, Vineeth Remanan Pillai wrote:
> On Thu, May 14, 2020 at 9:02 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > A little something like so, this syncs min_vruntime when we switch to
> > single queue mode. This is very much SMT2 only, I got my head in twist
> > when thikning about more siblings, I'll have to try again later.
> >
> Thanks for the quick patch! :-)
> 
> For SMT-n, would it work if sync vruntime if atleast one sibling is
> forced idle? Since force_idle is for all the rqs, I think it would
> be correct to sync the vruntime if atleast one cpu is forced idle.

It's complicated ;-)

So this sync is basically a relative reset of S to 0.

So with 2 queues, when one goes idle, we drop them both to 0 and one
then increases due to not being idle, and the idle one builds up lag to
get re-elected. So far so simple, right?

When there's 3, we can have the situation where 2 run and one is idle,
we sync to 0 and let the idle one build up lag to get re-election. Now
suppose another one also drops idle. At this point dropping all to 0
again would destroy the built-up lag from the queue that was already
idle, not good.

So instead of syncing everything, we can:

  less := !((s64)(s_a - s_b) <= 0)

  (v_a - S_a) - (v_b - S_b) == v_a - v_b - S_a + S_b
                            == v_a - (v_b - S_a + S_b)

IOW, we can recast the (lag) comparison to a one-sided difference.
So if then, instead of syncing the whole queue, sync the idle queue
against the active queue with S_a + S_b at the point where we sync.

(XXX consider the implication of living in a cyclic group: N / 2^n N)

This gives us means of syncing single queues against the active queue,
and for already idle queues to preseve their build-up lag.

Of course, then we get the situation where there's 2 active and one
going idle, who do we pick to sync against? Theory would have us sync
against the combined S, but as we've already demonstated, there is no
such thing in infeasible weight scenarios.

One thing I've considered; and this is where that core_active rudiment
came from, is having active queues sync up between themselves after
every tick. This limits the observed divergence due to the work
conservance.

On top of that, we can improve upon things by moving away from our
horrible (10) hack and moving to (9) and employing (13) here.

Anyway, I got partway through that in the past days, but then my head
hurt. I'll consider it some more :-)

> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > -               if (is_idle_task(rq_i->core_pick) && rq_i->nr_running)
> > -                       rq_i->core_forceidle = true;
> > +               if (is_idle_task(rq_i->core_pick)) {
> > +                       if (rq_i->nr_running)
> > +                               rq_i->core_forceidle = true;
> > +               } else {
> > +                       new_active++;
> I think we need to reset new_active on restarting the selection.

But this loop is after selection has been done; we don't modify
new_active during selection.

> > +               /*
> > +                * We just dropped into single-rq mode, increment the sequence
> > +                * count to trigger the vruntime sync.
> > +                */
> > +               rq->core->core_sync_seq++;
> > +       }
> > +       rq->core->core_active = new_active;
> core_active seems to be unused.

Correct; that's rudiments from an SMT-n attempt.

> > +bool cfs_prio_less(struct task_struct *a, struct task_struct *b)
> > +{
> > +       struct sched_entity *se_a = &a->se, *se_b = &b->se;
> > +       struct cfs_rq *cfs_rq_a, *cfa_rq_b;
> > +       u64 vruntime_a, vruntime_b;
> > +
> > +       while (!is_same_tg(se_a, se_b)) {
> > +               int se_a_depth = se_a->depth;
> > +               int se_b_depth = se_b->depth;
> > +
> > +               if (se_a_depth <= se_b_depth)
> > +                       se_b = parent_entity(se_b);
> > +               if (se_a_depth >= se_b_depth)
> > +                       se_a = parent_entity(se_a);
> > +       }
> > +
> > +       cfs_rq_a = cfs_rq_of(se_a);
> > +       cfs_rq_b = cfs_rq_of(se_b);
> > +
> > +       vruntime_a = se_a->vruntime - cfs_rq_a->core_vruntime;
> > +       vruntime_b = se_b->vruntime - cfs_rq_b->core_vruntime;
> Should we be using core_vruntime conditionally? should it be min_vruntime for
> default comparisons and core_vruntime during force_idle?

At the very least it should be min_vruntime when cfs_rq_a == cfs_rq_b,
ie. when we're on the same CPU.

For the other case I was considering that tick based active sync, but
never got that finished and admittedly it all looks a bit weird. But I
figured I'd send it out so we can at least advance the discussion.

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -469,7 +469,7 @@ bool cfs_prio_less(struct task_struct *a
 {
 	struct sched_entity *se_a = &a->se, *se_b = &b->se;
 	struct cfs_rq *cfs_rq_a, *cfa_rq_b;
-	u64 vruntime_a, vruntime_b;
+	u64 s_a, s_b, S_a, S_b;
 
 	while (!is_same_tg(se_a, se_b)) {
 		int se_a_depth = se_a->depth;
@@ -484,10 +484,16 @@ bool cfs_prio_less(struct task_struct *a
 	cfs_rq_a = cfs_rq_of(se_a);
 	cfs_rq_b = cfs_rq_of(se_b);
 
-	vruntime_a = se_a->vruntime - cfs_rq_a->core_vruntime;
-	vruntime_b = se_b->vruntime - cfs_rq_b->core_vruntime;
+	S_a = cfs_rq_a->core_vruntime;
+	S_b = cfs_rq_b->core_vruntime;
 
-	return !((s64)(vruntime_a - vruntime_b) <= 0);
+	if (cfs_rq_a == cfs_rq_b)
+		S_a = S_b = cfs_rq_a->min_vruntime;
+
+	s_a = se_a->vruntime - S_a;
+	s_b = se_b->vruntime - S_b;
+
+	return !((s64)(s_a - s_b) <= 0);
 }
 
 static __always_inline
