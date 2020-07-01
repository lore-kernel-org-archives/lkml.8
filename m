Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808F0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA582077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="T/EQ68wX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgGAX2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 19:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgGAX2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 19:28:50 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030C6C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 16:28:49 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id m8so7634177qvk.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 16:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w/6vsbQ9eQ9SYZyjzJjo7q2++dtmL7y8qUp3o/IY01o=;
        b=T/EQ68wXN+j3TU28ZuKOoUhjEFIYaXWHzb4njqW0NqGdPOBA5aEudroRUdiJ8FrnLm
         sY65BzCM/yuanryZ58uxsKIUzrwSqwtjuf2VsEFWNQSv/AmVYIZooAHnTVRGBhP4I1Na
         ElhVC000WZYrhABgmHLOgVP6TzoVIFGNCtZBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w/6vsbQ9eQ9SYZyjzJjo7q2++dtmL7y8qUp3o/IY01o=;
        b=IlvNAipApPa4QrLXYIFVXb7gNqN8HR5EnY2/WcrUP29kWYSz+A7uZPvlx4mHPLPCS6
         8nXpqS40wq21EsNADwBPkWMel0hPyv81SzZqH9W3H/7PuSZgsgFCOR4JoAiNMtIrWfov
         nCXt92gXY6o8ZBp3NDzF2esPrOmj0Mv6q/+jHQ+nn+HBFlVfvjYeTb/sMz3BY5cK0SzO
         F/Vm01cbDgLpRl0dDhvG/kvGkRofUTb0+i28x05eTdEbjhCs/m5XLai/hYId7oNFXW5h
         hxExl057Hm6WPaCt39j/V+du/sx772bCyy2wKpZArInLg62EU7971E7a/Kuq1JuIBF0k
         EHuw==
X-Gm-Message-State: AOAM532At4ps3Ex9+qmAIu+1zvYuLJx5Temv0GoWtugK9EHvWRdcT4hq
        /FipQNdyFim16EeKfzNcbyCHZQ==
X-Google-Smtp-Source: ABdhPJySc8UKTCwLa3Lxp62I5q63tLwLgEuWArRfWcNItmojl1J1bW93G7TvXwlgr0hD/mXteORW/w==
X-Received: by 2002:a0c:a992:: with SMTP id a18mr18028116qvb.211.1593646129011;
        Wed, 01 Jul 2020 16:28:49 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id c7sm7780636qta.95.2020.07.01.16.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 16:28:48 -0700 (PDT)
Date:   Wed, 1 Jul 2020 19:28:47 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        mingo@kernel.org, fweisbec@gmail.com, keescook@chromium.org,
        kerrnel@google.com, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineethrp@gmail.com,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>, paulmck@kernel.org
Subject: Re: [RFC PATCH 06/16] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200701232847.GA439212@google.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
 <ed924e2cb450a4cce4a1b5a2c44d29e968467154.1593530334.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed924e2cb450a4cce4a1b5a2c44d29e968467154.1593530334.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 09:32:27PM +0000, Vineeth Remanan Pillai wrote:
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

Hi Peter, Tim, all, the below patch fixes the hotplug issue described in the
below patch's Link tag. Patch description below describes the issues fixed
and it applies on top of this patch.

------8<----------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] sched: Fix CPU hotplug causing crashes in task selection logic

The selection logic does not run correctly if the current CPU is not in the
cpu_smt_mask (which it is not because the CPU is offlined when the stopper
finishes running and needs to switch to idle).  There are also other issues
fixed by the patch I think such as: if some other sibling set core_pick to
something, however the selection logic on current cpu resets it before
selecting. In this case, we need to run the task selection logic again to
make sure it picks something if there is something to run. It might end up
picking the wrong task.  Yet another issue was, if the stopper thread is an
unconstrained pick, then rq->core_pick is set. The next time task selection
logic runs when stopper needs to switch to idle, the current CPU is not in
the smt_mask. This causes the previous ->core_pick to be picked again which
happens to be the unconstrained task! so the stopper keeps getting selected
forever.

That and there are a few more safe guards and checks around checking/setting
rq->core_pick. To test it, I ran rcutorture and made it tag all torture
threads. Then ran it in hotplug mode (hotplugging every 200ms) and it hit the
issue. Now it runs for an hour or so without issue. (Torture testing debug
changes: https://bit.ly/38htfqK ).

Various fixes were tried causing varying degrees of crashes.  Finally I found
that it is easiest to just add current CPU to the smt_mask's copy always.
This is so that task selection logic always runs on the current CPU which
called schedule().

Link: lore.kernel.org/r/20200414133559.GT20730@hirez.programming.kicks-ass.net
Reported-by: Tim Chen <tim.c.chen@linux.intel.com>
Reported-by: Vineeth Pillai <vpillai@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ede86fb37b4e8..a5604aa292e66 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4307,7 +4307,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	struct task_struct *next, *max = NULL;
 	const struct sched_class *class;
-	const struct cpumask *smt_mask;
+	struct cpumask select_mask;
 	int i, j, cpu, occ = 0;
 	bool need_sync;
 
@@ -4334,7 +4334,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	finish_prev_task(rq, prev, rf);
 
 	cpu = cpu_of(rq);
-	smt_mask = cpu_smt_mask(cpu);
+	/* Make a copy of cpu_smt_mask as we should not set that. */
+	cpumask_copy(&select_mask, cpu_smt_mask(cpu));
+
+	/*
+	 * Always make sure current CPU is added to smt_mask so that below
+	 * selection logic runs on it.
+	 */
+	cpumask_set_cpu(cpu, &select_mask);
 
 	/*
 	 * core->core_task_seq, core->core_pick_seq, rq->core_sched_seq
@@ -4351,7 +4358,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	/* reset state */
 	rq->core->core_cookie = 0UL;
-	for_each_cpu(i, smt_mask) {
+	for_each_cpu(i, &select_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
 		rq_i->core_pick = NULL;
@@ -4371,7 +4378,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 */
 	for_each_class(class) {
 again:
-		for_each_cpu_wrap(i, smt_mask, cpu) {
+		for_each_cpu_wrap(i, &select_mask, cpu) {
 			struct rq *rq_i = cpu_rq(i);
 			struct task_struct *p;
 
@@ -4402,6 +4409,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 */
 			if (i == cpu && !need_sync && !p->core_cookie) {
 				next = p;
+				rq_i->core_pick = next;
+				rq_i->core_sched_seq = rq_i->core->core_pick_seq;
 				goto done;
 			}
 
@@ -4427,7 +4436,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 				max = p;
 
 				if (old_max) {
-					for_each_cpu(j, smt_mask) {
+					for_each_cpu(j, &select_mask) {
 						if (j == i)
 							continue;
 
@@ -4452,6 +4461,10 @@ next_class:;
 
 	rq->core->core_pick_seq = rq->core->core_task_seq;
 	next = rq->core_pick;
+
+	/* Something should have been selected for current CPU */
+	WARN_ON_ONCE(!next);
+
 	rq->core_sched_seq = rq->core->core_pick_seq;
 
 	/*
@@ -4462,7 +4475,7 @@ next_class:;
 	 * their task. This ensures there is no inter-sibling overlap between
 	 * non-matching user state.
 	 */
-	for_each_cpu(i, smt_mask) {
+	for_each_cpu(i, &select_mask) {
 		struct rq *rq_i = cpu_rq(i);
 
 		WARN_ON_ONCE(!rq_i->core_pick);
@@ -4483,6 +4496,16 @@ next_class:;
 	}
 
 done:
+	/*
+	 * If we reset a sibling's core_pick, make sure that we picked a task
+	 * for it, this is because we might have reset it though it was set to
+	 * something by another selector. In this case we cannot leave it as
+	 * NULL and should have found something for it.
+	 */
+	for_each_cpu(i, &select_mask) {
+		WARN_ON_ONCE(!cpu_rq(i)->core_pick);
+	}
+
 	set_next_task(rq, next);
 	return next;
 }
-- 
2.27.0.212.ge8ba1cc988-goog

