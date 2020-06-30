Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B84C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F0322072D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="EaqM02cZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgF3Vdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgF3VdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:33:25 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EA9C03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:25 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u9so5402091pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Cr71jjQ/0KHbNw4r32FwzsU3ycONNJB1pF/DSmi83z0=;
        b=EaqM02cZrOujI1gzsLoc0k0YlRiXcoYxCps/8WpIo7sKejMqezwjkOvx78jbgxdk4J
         wiiPtUdd1lZNCjDRBRBDX2c6NIt0q8Rjm2AWxHQJRXNTWpZ1SxrFC5f58nitz5yCeqcS
         CmScyNKVK6jGnKdCTSL7w28vtoi02qhbNemZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Cr71jjQ/0KHbNw4r32FwzsU3ycONNJB1pF/DSmi83z0=;
        b=jYxXbzjbNkwaORN2yjraOSupaF6FKDuxGATZNcsoB6AIl99+xRS1Dn/05qms2uUEIo
         +HI5lP2Pgez3rhzClpanfbMftuk7v4ZzCss/3HuoqyONJt7wCC795Q0Zee6MbKicgkqG
         dCv9rgVSKZiktNklC8U64k7t/fIW1V8m7HQcLzfqXIuKjn+F4Xg/M+UTFXz+AEesR15U
         ikICyxJwnJKU5UXuTbg+MZGeR72aU2Y/xa2ArYWhCxUwIh1O0iSNA6rEIx35LmCiFNi1
         o9DuGBJZtX+BmP8jx+OCCNBq70akmKK9RwKr6RwTCqbHBkqpX6NXc42uAyJAM7K7VXKu
         qNSg==
X-Gm-Message-State: AOAM532sdcS5oI1Y7MbMgixNEMZeWrh4Gdri1Ys339kD626TCbymcULm
        nk4T9wjH8lV60oTyWntqM+PUlQ==
X-Google-Smtp-Source: ABdhPJxlIm2dz57cLMb/j0Vv1TLP0inL1eeWkABgZqfZD1Q68vmjtFb6q4xjXhDvomWF0hRU3GHxyQ==
X-Received: by 2002:a17:90a:1748:: with SMTP id 8mr19269341pjm.131.1593552805041;
        Tue, 30 Jun 2020 14:33:25 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id b191sm3611103pga.13.2020.06.30.14.33.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 14:33:24 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        vineethrp@gmail.com, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Aaron Lu <ziqian.lzq@antfin.com>
Subject: [RFC PATCH 08/16] sched/fair: wrapper for cfs_rq->min_vruntime
Date:   Tue, 30 Jun 2020 21:32:29 +0000
Message-Id: <1d25a94f2ffc6d7ea1373d0e9ad44bc30781f255.1593530334.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Lu <aaron.lu@linux.alibaba.com>

Add a wrapper function cfs_rq_min_vruntime(cfs_rq) to
return cfs_rq->min_vruntime.

It will be used in the following patch, no functionality
change.

Signed-off-by: Aaron Lu <ziqian.lzq@antfin.com>
---
 kernel/sched/fair.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 49fb93296e35..61d19e573443 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -462,6 +462,11 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
 #endif	/* CONFIG_FAIR_GROUP_SCHED */
 
+static inline u64 cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->min_vruntime;
+}
+
 static __always_inline
 void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
 
@@ -498,7 +503,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 	struct sched_entity *curr = cfs_rq->curr;
 	struct rb_node *leftmost = rb_first_cached(&cfs_rq->tasks_timeline);
 
-	u64 vruntime = cfs_rq->min_vruntime;
+	u64 vruntime = cfs_rq_min_vruntime(cfs_rq);
 
 	if (curr) {
 		if (curr->on_rq)
@@ -518,7 +523,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 	}
 
 	/* ensure we never gain time by being placed backwards. */
-	cfs_rq->min_vruntime = max_vruntime(cfs_rq->min_vruntime, vruntime);
+	cfs_rq->min_vruntime = max_vruntime(cfs_rq_min_vruntime(cfs_rq), vruntime);
 #ifndef CONFIG_64BIT
 	smp_wmb();
 	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
@@ -4026,7 +4031,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
 static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 #ifdef CONFIG_SCHED_DEBUG
-	s64 d = se->vruntime - cfs_rq->min_vruntime;
+	s64 d = se->vruntime - cfs_rq_min_vruntime(cfs_rq);
 
 	if (d < 0)
 		d = -d;
@@ -4039,7 +4044,7 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
-	u64 vruntime = cfs_rq->min_vruntime;
+	u64 vruntime = cfs_rq_min_vruntime(cfs_rq);
 
 	/*
 	 * The 'current' period is already promised to the current tasks,
@@ -4133,7 +4138,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * update_curr().
 	 */
 	if (renorm && curr)
-		se->vruntime += cfs_rq->min_vruntime;
+		se->vruntime += cfs_rq_min_vruntime(cfs_rq);
 
 	update_curr(cfs_rq);
 
@@ -4144,7 +4149,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * fairness detriment of existing tasks.
 	 */
 	if (renorm && !curr)
-		se->vruntime += cfs_rq->min_vruntime;
+		se->vruntime += cfs_rq_min_vruntime(cfs_rq);
 
 	/*
 	 * When enqueuing a sched_entity, we must:
@@ -4263,7 +4268,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * can move min_vruntime forward still more.
 	 */
 	if (!(flags & DEQUEUE_SLEEP))
-		se->vruntime -= cfs_rq->min_vruntime;
+		se->vruntime -= cfs_rq_min_vruntime(cfs_rq);
 
 	/* return excess runtime on last dequeue */
 	return_cfs_rq_runtime(cfs_rq);
@@ -6700,7 +6705,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 			min_vruntime = cfs_rq->min_vruntime;
 		} while (min_vruntime != min_vruntime_copy);
 #else
-		min_vruntime = cfs_rq->min_vruntime;
+		min_vruntime = cfs_rq_min_vruntime(cfs_rq);
 #endif
 
 		se->vruntime -= min_vruntime;
@@ -10709,7 +10714,7 @@ static void task_fork_fair(struct task_struct *p)
 		resched_curr(rq);
 	}
 
-	se->vruntime -= cfs_rq->min_vruntime;
+	se->vruntime -= cfs_rq_min_vruntime(cfs_rq);
 	rq_unlock(rq, &rf);
 }
 
@@ -10832,7 +10837,7 @@ static void detach_task_cfs_rq(struct task_struct *p)
 		 * cause 'unlimited' sleep bonus.
 		 */
 		place_entity(cfs_rq, se, 0);
-		se->vruntime -= cfs_rq->min_vruntime;
+		se->vruntime -= cfs_rq_min_vruntime(cfs_rq);
 	}
 
 	detach_entity_cfs_rq(se);
@@ -10846,7 +10851,7 @@ static void attach_task_cfs_rq(struct task_struct *p)
 	attach_entity_cfs_rq(se);
 
 	if (!vruntime_normalized(p))
-		se->vruntime += cfs_rq->min_vruntime;
+		se->vruntime += cfs_rq_min_vruntime(cfs_rq);
 }
 
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
-- 
2.17.1

