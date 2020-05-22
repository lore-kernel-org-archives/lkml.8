Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A335C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72B522072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Gus1Vba7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgEVCgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 22:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgEVCgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 22:36:00 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA360C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 19:35:58 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x12so7232296qts.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 19:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W6j7To5aFqU165eD2dpI9gS0Sq4hB8ltmc/WMSYcomI=;
        b=Gus1Vba7CPAvZgLTYPedaje7s1aN5WY+c6jwsSEZqY1j2YppjDgbj7hKp/UUrjMEkH
         DJXm65KHujL8A8K83iLnzazwZLfar0VMx5ODPaGUFQT5gbo/tRGlyPStX/znZD7fefZ7
         YRHblqCDOFbbyHBwhoPFJ7VQ7nIxUFCaB/WtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W6j7To5aFqU165eD2dpI9gS0Sq4hB8ltmc/WMSYcomI=;
        b=NbTiH4Fk2mpcTQMMXNZ/m0rsAqriGig/T+MNivhWc4WB2QA+KC0x7Cv9WekNZ9JMW9
         japFCMneWzeoSC7o/lqr6BImaQ8qOCe7+EEKRA+7kkcVPuLIwBe1pIvrIuvJFfoA9LQa
         8lVBE0rTBFtL4yzfh08keHTz6fyC6oJYG8m/04ZnrtyYVR0rJUWDU79+AqfEku7NbsXX
         UWOtmh0PP5eDDlJb1kJ4U0cfs1fM0oqrN0j44asEYc4iAmgUq5xgYZ88xEDBe8kSFrOq
         A13PQc6j2xjBcqZqDlCX8HGwUkHRTXTr6a9yEUOxPlkUzluNuFxrtpVNOE2W9u01jqkv
         XqFg==
X-Gm-Message-State: AOAM530wN3M8UNUsNmAQ6wZAbV1pKKx0YTAYBMbpCUk7HPkmcWKpGaVD
        3BTDnw+kU8mX/zx7bNXQZr2fDw==
X-Google-Smtp-Source: ABdhPJzD0AHrGtmYwcQsFb2nPHXQU2ZFGg/y/J/Yo2GQ6eU76V9QADJzURcy3AlzkcpBF/vV5jqjWw==
X-Received: by 2002:ac8:4b5a:: with SMTP id e26mr13849611qts.166.1590114957178;
        Thu, 21 May 2020 19:35:57 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 23sm6189906qkf.68.2020.05.21.19.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 19:35:56 -0700 (PDT)
Date:   Thu, 21 May 2020 22:35:56 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     vpillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC PATCH 07/13] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200522023556.GE140701@google.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com>
 <20200521231426.GA246288@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521231426.GA246288@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 07:14:26PM -0400, Joel Fernandes wrote:
> On Wed, Mar 04, 2020 at 04:59:57PM +0000, vpillai wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Instead of only selecting a local task, select a task for all SMT
> > siblings for every reschedule on the core (irrespective which logical
> > CPU does the reschedule).
> > 
> > There could be races in core scheduler where a CPU is trying to pick
> > a task for its sibling in core scheduler, when that CPU has just been
> > offlined.  We should not schedule any tasks on the CPU in this case.
> > Return an idle task in pick_next_task for this situation.
> > 
> > NOTE: there is still potential for siblings rivalry.
> > NOTE: this is far too complicated; but thus far I've failed to
> >       simplify it further.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
> > Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
> > Signed-off-by: Aaron Lu <aaron.lu@linux.alibaba.com>
> > Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> > ---
> >  kernel/sched/core.c  | 274 ++++++++++++++++++++++++++++++++++++++++++-
> >  kernel/sched/fair.c  |  40 +++++++
> >  kernel/sched/sched.h |   6 +-
> >  3 files changed, 318 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 445f0d519336..9a1bd236044e 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4253,7 +4253,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
> >   * Pick up the highest-prio task:
> >   */
> >  static inline struct task_struct *
> > -pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> > +__pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  {
> >  	const struct sched_class *class;
> >  	struct task_struct *p;
> > @@ -4309,6 +4309,273 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >  	BUG();
> >  }
> >  
> > +#ifdef CONFIG_SCHED_CORE
> > +
> > +static inline bool cookie_equals(struct task_struct *a, unsigned long cookie)
> > +{
> > +	return is_idle_task(a) || (a->core_cookie == cookie);
> > +}
> > +
> > +static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
> > +{
> > +	if (is_idle_task(a) || is_idle_task(b))
> > +		return true;
> > +
> > +	return a->core_cookie == b->core_cookie;
> > +}
> > +
> > +// XXX fairness/fwd progress conditions
> > +/*
> > + * Returns
> > + * - NULL if there is no runnable task for this class.
> > + * - the highest priority task for this runqueue if it matches
> > + *   rq->core->core_cookie or its priority is greater than max.
> > + * - Else returns idle_task.
> > + */
> > +static struct task_struct *
> > +pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
> > +{
> > +	struct task_struct *class_pick, *cookie_pick;
> > +	unsigned long cookie = rq->core->core_cookie;
> > +
> > +	class_pick = class->pick_task(rq);
> > +	if (!class_pick)
> > +		return NULL;
> > +
> > +	if (!cookie) {
> > +		/*
> > +		 * If class_pick is tagged, return it only if it has
> > +		 * higher priority than max.
> > +		 */
> > +		if (max && class_pick->core_cookie &&
> > +		    prio_less(class_pick, max))
> > +			return idle_sched_class.pick_task(rq);
> > +
> > +		return class_pick;
> > +	}
> > +
> > +	/*
> > +	 * If class_pick is idle or matches cookie, return early.
> > +	 */
> > +	if (cookie_equals(class_pick, cookie))
> > +		return class_pick;
> > +
> > +	cookie_pick = sched_core_find(rq, cookie);
> > +
> > +	/*
> > +	 * If class > max && class > cookie, it is the highest priority task on
> > +	 * the core (so far) and it must be selected, otherwise we must go with
> > +	 * the cookie pick in order to satisfy the constraint.
> > +	 */
> > +	if (prio_less(cookie_pick, class_pick) &&
> > +	    (!max || prio_less(max, class_pick)))
> > +		return class_pick;
> > +
> > +	return cookie_pick;
> > +}
> 
> I've been hating on this pick_task() routine for a while now :-). If we add
> the task to the tag tree as Peter suggested at OSPM for that other issue
> Vineeth found, it seems it could be simpler.
> 
> This has just been near a compiler so far but how about:

Discussed a lot with Vineeth. Below is an improved version of the pick_task()
similification.

It also handles the following "bug" in the existing code as well that Vineeth
brought up in OSPM: Suppose 2 siblings of a core: rq 1 and rq 2.

In priority order (high to low), say we have the tasks:
A - untagged  (rq 1)
B - tagged    (rq 2)
C - untagged  (rq 2)

Say, B and C are in the same scheduling class.

When the pick_next_task() loop runs, it looks at rq 1 and max is A, A is
tenantively selected for rq 1. Then it looks at rq 2 and the class_pick is B.
But that's not compatible with A. So rq 2 gets forced idle.

In reality, rq 2 could have run C instead of idle. The fix is to add C to the
tag tree as Peter suggested in OSPM.

Updated diff below:

---8<-----------------------

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 005d7f7323e2d..625377f393ed3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -182,9 +182,6 @@ static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 
 	rq->core->core_task_seq++;
 
-	if (!p->core_cookie)
-		return;
-
 	node = &rq->core_tree.rb_node;
 	parent = *node;
 
@@ -215,7 +212,7 @@ static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
 
 void sched_core_add(struct rq *rq, struct task_struct *p)
 {
-	if (p->core_cookie && task_on_rq_queued(p))
+	if (task_on_rq_queued(p))
 		sched_core_enqueue(rq, p);
 }
 
@@ -4556,43 +4553,57 @@ void sched_core_irq_exit(void)
 static struct task_struct *
 pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
 {
-	struct task_struct *class_pick, *cookie_pick;
+	struct task_struct *class_pick, *cookie_pick, *rq_pick;
 	unsigned long cookie = rq->core->core_cookie;
 
 	class_pick = class->pick_task(rq);
 	if (!class_pick)
 		return NULL;
 
-	if (!cookie) {
-		/*
-		 * If class_pick is tagged, return it only if it has
-		 * higher priority than max.
-		 */
-		if (max && class_pick->core_cookie &&
-		    prio_less(class_pick, max))
-			return idle_sched_class.pick_task(rq);
+	if (!max)
+		return class_pick;
+
+	/* Make sure the current max's cookie is core->core_cookie */
+	WARN_ON_ONCE(max->core_cookie != cookie);
 
+	/* Try to play really nice: see if the class's cookie works. */
+	if (cookie_equals(class_pick, cookie))
 		return class_pick;
-	}
 
 	/*
-	 * If class_pick is idle or matches cookie, return early.
+	 * From here on, we must return class_pick, cookie_pick or idle.
+	 * Following are the cases:
+	 * 1 - lowest prio.
+	 * 3 - highest prio.
+	 *
+	 * max	class	cookie	outcome
+	 * 1	2	3	cookie
+	 * 1	3	2	class
+	 * 2	1	3	cookie
+	 * 2	3	1	class
+	 * 3	1	2	cookie
+	 * 3	2	1	cookie
+	 * 3	2	-	return idle (when no cookie task).
 	 */
-	if (cookie_equals(class_pick, cookie))
-		return class_pick;
 
+	/* First try to find the highest prio of (cookie, class and max). */
 	cookie_pick = sched_core_find(rq, cookie);
+	if (cookie_pick && prio_less(class_pick, cookie_pick))
+		rq_pick = cookie_pick;
+	else
+		rq_pick = class_pick;
+	if (prio_less(max, rq_pick))
+		return rq_pick;
+
+	/* If we max was greatest, then see if there was a cookie. */
+	if (cookie_pick)
+		return cookie_pick;
 
 	/*
-	 * If class > max && class > cookie, it is the highest priority task on
-	 * the core (so far) and it must be selected, otherwise we must go with
-	 * the cookie pick in order to satisfy the constraint.
+	 * We get here with if class_pick was incompatible with max
+	 * and lower prio than max. So we have nothing.
 	 */
-	if (prio_less(cookie_pick, class_pick) &&
-	    (!max || prio_less(max, class_pick)))
-		return class_pick;
-
-	return cookie_pick;
+	return idle_sched_class.pick_task(rq);
 }
 
 static struct task_struct *
