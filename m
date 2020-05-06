Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF4FC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3262B20870
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AeeYntQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgEFOfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgEFOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:35:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C4FC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wvkqkNt6wI2GrHuTjEwcyeZGIaIR46Oue31nUHMUQLg=; b=AeeYntQAHi6APIwmhx9ffr8yfE
        wDa4i6QM8dqYlWPFlUgoz+3/XK6w8nZV89/M/163099waF6MZsW2p8e5ofFSzX4/u7/3Iuh9fHZjK
        up05qIUm/EEeb572oowteW7gu1pVLZUU/sYUgkhpagB/1SWB8vNkLbp50Dqtq3Ra6iPQYzJg3LfY6
        Tx26Z+dDiRfpOvjgEHZqYffm9J9E2x+4F3yLq0dJMogtzpTB3+9XpEIKOOfgTTdBDT/blYiVkWB1D
        85wZWlHwbvJFkHgG+hcblYvK8LvDzgi3UP5xsve8wqO4KNImd05FBH2/4ej30ZiZ0j0c2knxTi2u6
        mlPbpTig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWL8g-0005ea-Fi; Wed, 06 May 2020 14:35:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A3A5301E02;
        Wed,  6 May 2020 16:35:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E288D2B74FC8B; Wed,  6 May 2020 16:35:06 +0200 (CEST)
Date:   Wed, 6 May 2020 16:35:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lwe@gmail.com>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
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
Message-ID: <20200506143506.GH5298@hirez.programming.kicks-ass.net>
References: <2f83d888890cec14be3a7aead0859dceebb4012f.1583332765.git.vpillai@digitalocean.com>
 <20200414135624.GU20730@hirez.programming.kicks-ass.net>
 <20200415033408.GA168322@ziqianlu-desktop.localdomain>
 <20200415040741.GA169001@ziqianlu-desktop.localdomain>
 <CANaguZAXsjD=X-bB7dvQZ3FSqLioiZU=YREHH_7JqiFsZCTxHA@mail.gmail.com>
 <20200417094045.GA197704@ziqianlu-desktop.localdomain>
 <20200420080759.GA224731@ziqianlu-desktop.localdomain>
 <CANaguZDP3nyBdjLeeCZGoUoYk6Lf0HUv19N2Qxo4CpZfrjPZHA@mail.gmail.com>
 <20200421025131.GA227300@aaronlu-desktop>
 <20200424142443.GA263207@aaronlu-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424142443.GA263207@aaronlu-desktop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry for being verbose; I've been procrastinating replying, and in
doing so the things I wanted to say kept growing.

On Fri, Apr 24, 2020 at 10:24:43PM +0800, Aaron Lu wrote:

> To make this work, the root level sched entities' vruntime of the two
> threads must be directly comparable. So one of the hyperthread's root
> cfs_rq's min_vruntime is chosen as the core wide one and all root level
> sched entities' vruntime is normalized against it.

> +/*
> + * This is called in stop machine context so no need to take the rq lock.
> + *
> + * Core scheduling is going to be enabled and the root level sched entities
> + * of both siblings will use cfs_rq->min_vruntime as the common cfs_rq
> + * min_vruntime, so it's necessary to normalize vruntime of existing root
> + * level sched entities in sibling_cfs_rq.
> + *
> + * Update of sibling_cfs_rq's min_vruntime isn't necessary as we will be
> + * only using cfs_rq->min_vruntime during the entire run of core scheduling.
> + */
> +void sched_core_normalize_se_vruntime(int cpu)
> +{
> +	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
> +	int i;
> +
> +	for_each_cpu(i, cpu_smt_mask(cpu)) {
> +		struct sched_entity *se, *next;
> +		struct cfs_rq *sibling_cfs_rq;
> +		s64 delta;
> +
> +		if (i == cpu)
> +			continue;
> +
> +		sibling_cfs_rq = &cpu_rq(i)->cfs;
> +		if (!sibling_cfs_rq->nr_running)
> +			continue;
> +
> +		delta = cfs_rq->min_vruntime - sibling_cfs_rq->min_vruntime;
> +		rbtree_postorder_for_each_entry_safe(se, next,
> +				&sibling_cfs_rq->tasks_timeline.rb_root,
> +				run_node) {
> +			se->vruntime += delta;
> +		}
> +	}
> +}

Aside from this being way to complicated for what it does -- you
could've saved the min_vruntime for each rq and compared them with
subtraction -- it is also terminally broken afaict.

Consider any infeasible weight scenario. Take for instance two tasks,
each bound to their respective sibling, one with weight 1 and one with
weight 2. Then the lower weight task will run ahead of the higher weight
task without bound.

This utterly destroys the concept of a shared time base.

Remember; all this is about a proportionally fair scheduling, where each
tasks receives:

             w_i
  dt_i = ---------- dt                                     (1)
	 \Sum_j w_j

which we do by tracking a virtual time, s_i:

         1
  s_i = --- d[t]_i                                         (2)
        w_i

Where d[t] is a delta of discrete time, while dt is an infinitesimal.
The immediate corrolary is that the ideal schedule S, where (2) to use
an infnitesimal delta, is:

          1
  S = ---------- dt                                        (3)
      \Sum_i w_i

From which we can define the lag, or deviation from the ideal, as:

  lag(i) = S - s_i                                         (4)

And since the one and only purpose is to approximate S, we get that:

  \Sum_i w_i lag(i) := 0                                   (5)

If this were not so, we no longer converge to S, and we can no longer
claim our scheduler has any of the properties we derive from S. This is
exactly what you did above, you broke it!


Let's continue for a while though; to see if there is anything useful to
be learned. We can combine (1)-(3) or (4)-(5) and express S in s_i:

      \Sum_i w_i s_i
  S = --------------                                       (6)
        \Sum_i w_i

Which gives us a way to compute S, given our s_i. Now, if you've read
our code, you know that we do not in fact do this, the reason for this
is two-fold. Firstly, computing S in that way requires a 64bit division
for every time we'd use it (see 12), and secondly, this only describes
the steady-state, it doesn't handle dynamics.

Anyway, in (6):  s_i -> x + (s_i - x), to get:

          \Sum_i w_i (s_i - x)
  S - x = --------------------                             (7)
               \Sum_i w_i

Which shows that S and s_i transform alike (which makes perfect sense
given that S is basically the (weighted) average of s_i).

Then:

  x -> s_min := min{s_i}                                   (8)

to obtain:

              \Sum_i w_i (s_i - s_min)
  S = s_min + ------------------------                     (9)
                    \Sum_i w_i

Which already looks familiar, and is the basis for our current
approximation:

  S ~= s_min                                              (10)

Now, obviously, (10) is absolute crap :-), but it sorta works.

So the thing to remember is that the above is strictly UP. It is
possible to generalize to multiple runqueues -- however it gets really
yuck when you have to add affinity support, as illustrated by our very
first counter-example.

XXX segue into the load-balance issues related to this:

  - how a negative lag task on a 'heavy' runqueue should not
    remain a negative lag task when migrated to a 'light' runqueue.

  - how we can compute and use the combined S in load-balancing to
    better handle infeasible weight scenarios.

Luckily I think we can avoid needing a full multi-queue variant for
core-scheduling (or load-balancing). The crucial observation is that we
only actually need this comparison in the presence of forced-idle; only
then do we need to tell if the stalled rq has higher priority over the
other.

[XXX assumes SMT2; better consider the more general case, I suspect
it'll work out because our comparison is always between 2 rqs and the
answer is only interesting if one of them is forced-idle]

And (under assumption of SMT2) when there is forced-idle, there is only
a single queue, so everything works like normal.

Let, for our runqueue 'k':

  T_k = \Sum_i w_i s_i
  W_k = \Sum_i w_i      ; for all i of k                  (11)

Then we can write (6) like:

        T_k
  S_k = ---                                               (12)
        W_k

From which immediately follows that:

          T_k + T_l
  S_k+l = ---------                                       (13)
          W_k + W_l

On which we can define a combined lag:

  lag_k+l(i) := S_k+l - s_i                               (14)

And that gives us the tools to compare tasks across a combined runqueue.


Combined this gives the following:

 a) when a runqueue enters force-idle, sync it against it's sibling rq(s)
    using (7); this only requires storing single 'time'-stamps.

 b) when comparing tasks between 2 runqueues of which one is forced-idle,
    compare the combined lag, per (14).

Now, of course cgroups (I so hate them) make this more interesting in
that a) seems to suggest we need to iterate all cgroup on a CPU at such
boundaries, but I think we can avoid that. The force-idle is for the
whole CPU, all it's rqs. So we can mark it in the root and lazily
propagate downward on demand.



