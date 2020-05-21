Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E84C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254ED20823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wSg8zAEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbgEUXO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 19:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730658AbgEUXO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:14:28 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F2DC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 16:14:28 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id l1so6941900qtp.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 16:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p3Hdvcd+xHhyt3NoKuQ6ayw1V2hWUZczEPhgChE6r2I=;
        b=wSg8zAEchboHGRWoQA3FX2iSGBAIm5t/5PTrQb+91NK0EumvVgmfXPYgbbwXFkbms/
         5ZAsqxfVF5QXxsvyEJr37KsuHJed4LPiCe8TgfggMT8IZ+b+EJbG0UD2ZgXD9G5LZ16B
         EA5WK3B4nmESt6f911z3u6/JGYsUUg+JWSQHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p3Hdvcd+xHhyt3NoKuQ6ayw1V2hWUZczEPhgChE6r2I=;
        b=c4xJfWBD/czP84ALDkeD1r8p2kAwszQjEZPAm3qAhxTFXYNN5LDXDgXgwVXvyXA/pu
         tE9V5ZVtfRZslngD8CKEZNVJXmDQUPNDHEM3/G1uIQCqBwaCydbqFN1JMLOYLAc0Pipl
         DEig6NMcCpuZnLBlWYYUDL6V/Pbx7yCiSudLr9sUGOat/Blpwwz3kTdIQjCQxP8tz9vS
         ExnXJY3fIc1u85/OEHYQni2tKvK6aPMp0fg3OVmU0qfjpDcYd9Em76DZCB7s+7hPKrcV
         JxTANX1/pIGhGiIZ1+Nzv7ZMF21DzY10fxzGP18Vy96Y7ovbQ2mWVyPxgT1mLdFpWE29
         kbFw==
X-Gm-Message-State: AOAM531yiug8U9TkoTCOoNCQCG6zlpYlqSDLTxWItkDW+jVhlGkOxE6W
        43Puc+gqQR7YEPOIbW2D49xWGg==
X-Google-Smtp-Source: ABdhPJxJff2pAhRPlAtAedctQOlW84ZeULOKdkxEH0+PB6+f/MD33UJ/AdplDsupnvfRp+KDgnCGaA==
X-Received: by 2002:ac8:2492:: with SMTP id s18mr5923786qts.81.1590102867666;
        Thu, 21 May 2020 16:14:27 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u39sm6793217qtc.8.2020.05.21.16.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 16:14:27 -0700 (PDT)
Date:   Thu, 21 May 2020 19:14:26 -0400
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
Message-ID: <20200521231426.GA246288@google.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 04:59:57PM +0000, vpillai wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Instead of only selecting a local task, select a task for all SMT
> siblings for every reschedule on the core (irrespective which logical
> CPU does the reschedule).
> 
> There could be races in core scheduler where a CPU is trying to pick
> a task for its sibling in core scheduler, when that CPU has just been
> offlined.  We should not schedule any tasks on the CPU in this case.
> Return an idle task in pick_next_task for this situation.
> 
> NOTE: there is still potential for siblings rivalry.
> NOTE: this is far too complicated; but thus far I've failed to
>       simplify it further.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
> Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
> Signed-off-by: Aaron Lu <aaron.lu@linux.alibaba.com>
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/core.c  | 274 ++++++++++++++++++++++++++++++++++++++++++-
>  kernel/sched/fair.c  |  40 +++++++
>  kernel/sched/sched.h |   6 +-
>  3 files changed, 318 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 445f0d519336..9a1bd236044e 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4253,7 +4253,7 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
>   * Pick up the highest-prio task:
>   */
>  static inline struct task_struct *
> -pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> +__pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  {
>  	const struct sched_class *class;
>  	struct task_struct *p;
> @@ -4309,6 +4309,273 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  	BUG();
>  }
>  
> +#ifdef CONFIG_SCHED_CORE
> +
> +static inline bool cookie_equals(struct task_struct *a, unsigned long cookie)
> +{
> +	return is_idle_task(a) || (a->core_cookie == cookie);
> +}
> +
> +static inline bool cookie_match(struct task_struct *a, struct task_struct *b)
> +{
> +	if (is_idle_task(a) || is_idle_task(b))
> +		return true;
> +
> +	return a->core_cookie == b->core_cookie;
> +}
> +
> +// XXX fairness/fwd progress conditions
> +/*
> + * Returns
> + * - NULL if there is no runnable task for this class.
> + * - the highest priority task for this runqueue if it matches
> + *   rq->core->core_cookie or its priority is greater than max.
> + * - Else returns idle_task.
> + */
> +static struct task_struct *
> +pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *max)
> +{
> +	struct task_struct *class_pick, *cookie_pick;
> +	unsigned long cookie = rq->core->core_cookie;
> +
> +	class_pick = class->pick_task(rq);
> +	if (!class_pick)
> +		return NULL;
> +
> +	if (!cookie) {
> +		/*
> +		 * If class_pick is tagged, return it only if it has
> +		 * higher priority than max.
> +		 */
> +		if (max && class_pick->core_cookie &&
> +		    prio_less(class_pick, max))
> +			return idle_sched_class.pick_task(rq);
> +
> +		return class_pick;
> +	}
> +
> +	/*
> +	 * If class_pick is idle or matches cookie, return early.
> +	 */
> +	if (cookie_equals(class_pick, cookie))
> +		return class_pick;
> +
> +	cookie_pick = sched_core_find(rq, cookie);
> +
> +	/*
> +	 * If class > max && class > cookie, it is the highest priority task on
> +	 * the core (so far) and it must be selected, otherwise we must go with
> +	 * the cookie pick in order to satisfy the constraint.
> +	 */
> +	if (prio_less(cookie_pick, class_pick) &&
> +	    (!max || prio_less(max, class_pick)))
> +		return class_pick;
> +
> +	return cookie_pick;
> +}

I've been hating on this pick_task() routine for a while now :-). If we add
the task to the tag tree as Peter suggested at OSPM for that other issue
Vineeth found, it seems it could be simpler.

This has just been near a compiler so far but how about:

---8<-----------------------

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 005d7f7323e2d..81e23252b6c99 100644
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
 
@@ -4563,36 +4560,32 @@ pick_task(struct rq *rq, const struct sched_class *class, struct task_struct *ma
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
-
+	if (!max)
 		return class_pick;
-	}
 
-	/*
-	 * If class_pick is idle or matches cookie, return early.
-	 */
+	/* Make sure the current max's cookie is core->core_cookie */
+	WARN_ON_ONCE(max->core_cookie != cookie);
+
+	/* If class_pick is idle or matches cookie, play nice. */
 	if (cookie_equals(class_pick, cookie))
 		return class_pick;
 
-	cookie_pick = sched_core_find(rq, cookie);
+	/* If class_pick is highest prio, trump max. */
+	if (prio_less(max, class_pick)) {
+
+		/* .. but not before checking if cookie trumps class. */
+		cookie_pick = sched_core_find(rq, cookie);
+		if (prio_less(class_pick, cookie_pick))
+			return cookie_pick;
 
-	/*
-	 * If class > max && class > cookie, it is the highest priority task on
-	 * the core (so far) and it must be selected, otherwise we must go with
-	 * the cookie pick in order to satisfy the constraint.
-	 */
-	if (prio_less(cookie_pick, class_pick) &&
-	    (!max || prio_less(max, class_pick)))
 		return class_pick;
+	}
 
-	return cookie_pick;
+	/*
+	 * We get here if class_pick was incompatible with max
+	 * and lower prio than max. So we have nothing.
+	 */
+	return idle_sched_class.pick_task(rq);
 }
 
 static struct task_struct *
