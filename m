Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233A5C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5DE224654
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="arqxrRo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbgCDRAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:00:43 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36812 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388355AbgCDRAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:00:17 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so1898738qto.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=h1GH+76TwcdeB8gyOGGpP+hPF6EPEqc5BR+0YK2ci0E=;
        b=arqxrRo6iBQZYgD4el5BzHEJo+btFpwG7TPO73V+yyhugzEwjIJazuU18qpVQrfdKt
         qbEvLKHL0FIPzlwzxvGlBJX2WeXxRfo/903ppr+HYushvdJ6CE3a3RQ7cT0QFk64XFL/
         Z/xMzQN7PSgmlY0duOLTQS5++GHbV/6YpiD60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=h1GH+76TwcdeB8gyOGGpP+hPF6EPEqc5BR+0YK2ci0E=;
        b=jOTSMep8VT8YemKlx+p50MiGzWNmytEXF/YnAZJVHkxCe1OmcvgyDnPUznIT5rXHQW
         vPqHMqpXkonz9sAtgp2sNXdaw8WeJcUG3Hi1GsOr0c2ch37MmgsiD/hgZfd3cPjFhalc
         EjCRdljBtCUGg2rlj3l70WtelAvmeNG4mxcVqASPpiWck2AUesTns0q/o/iFqHh5wpRC
         dS/sJd26ermRoKC0mlhcLxJASExeDMlelnv7W36jqNE2gRyNJ3+ulC6j1p1ug0eSvKgo
         B11tnXO9tpOehlh+CsqtdX0bApgYy9qGY/3yH7UEwfW7AYLhscnEe7MTVB6j1ao8gFe5
         OO0w==
X-Gm-Message-State: ANhLgQ3YF//BJ2PRQrFBYzAJkQGTKdSV2x1FB9Ojj6jTAJTh1ABfqYcl
        OO1cb4bULDGwW1kDizV/oAoBxw==
X-Google-Smtp-Source: ADFU+vuSmur9XymYU9ZfyJF2rGmUrkB0z20ondtw3YDszMPU+JzrKFRMuZV0BBg3UtvPC+mQkqE5+g==
X-Received: by 2002:ac8:4616:: with SMTP id p22mr3264006qtn.64.1583341215460;
        Wed, 04 Mar 2020 09:00:15 -0800 (PST)
Received: from s2r5node9 ([162.243.188.99])
        by smtp.gmail.com with ESMTPSA id k50sm14675628qtc.90.2020.03.04.09.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:00:15 -0800 (PST)
From:   vpillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        Aaron Lu <ziqian.lzq@antfin.com>
Subject: [RFC PATCH 08/13] sched/fair: wrapper for cfs_rq->min_vruntime
Date:   Wed,  4 Mar 2020 16:59:58 +0000
Message-Id: <b5b7f6f6122144b5f608a1a0398be4be9dadacab.1583332765.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
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
index 8432de767730..d99ea6ee7af2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -449,6 +449,11 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
 #endif	/* CONFIG_FAIR_GROUP_SCHED */
 
+static inline u64 cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->min_vruntime;
+}
+
 static __always_inline
 void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
 
@@ -485,7 +490,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 	struct sched_entity *curr = cfs_rq->curr;
 	struct rb_node *leftmost = rb_first_cached(&cfs_rq->tasks_timeline);
 
-	u64 vruntime = cfs_rq->min_vruntime;
+	u64 vruntime = cfs_rq_min_vruntime(cfs_rq);
 
 	if (curr) {
 		if (curr->on_rq)
@@ -505,7 +510,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 	}
 
 	/* ensure we never gain time by being placed backwards. */
-	cfs_rq->min_vruntime = max_vruntime(cfs_rq->min_vruntime, vruntime);
+	cfs_rq->min_vruntime = max_vruntime(cfs_rq_min_vruntime(cfs_rq), vruntime);
 #ifndef CONFIG_64BIT
 	smp_wmb();
 	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
@@ -3833,7 +3838,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
 static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 #ifdef CONFIG_SCHED_DEBUG
-	s64 d = se->vruntime - cfs_rq->min_vruntime;
+	s64 d = se->vruntime - cfs_rq_min_vruntime(cfs_rq);
 
 	if (d < 0)
 		d = -d;
@@ -3846,7 +3851,7 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
-	u64 vruntime = cfs_rq->min_vruntime;
+	u64 vruntime = cfs_rq_min_vruntime(cfs_rq);
 
 	/*
 	 * The 'current' period is already promised to the current tasks,
@@ -3939,7 +3944,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * update_curr().
 	 */
 	if (renorm && curr)
-		se->vruntime += cfs_rq->min_vruntime;
+		se->vruntime += cfs_rq_min_vruntime(cfs_rq);
 
 	update_curr(cfs_rq);
 
@@ -3950,7 +3955,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * fairness detriment of existing tasks.
 	 */
 	if (renorm && !curr)
-		se->vruntime += cfs_rq->min_vruntime;
+		se->vruntime += cfs_rq_min_vruntime(cfs_rq);
 
 	/*
 	 * When enqueuing a sched_entity, we must:
@@ -4063,7 +4068,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * can move min_vruntime forward still more.
 	 */
 	if (!(flags & DEQUEUE_SLEEP))
-		se->vruntime -= cfs_rq->min_vruntime;
+		se->vruntime -= cfs_rq_min_vruntime(cfs_rq);
 
 	/* return excess runtime on last dequeue */
 	return_cfs_rq_runtime(cfs_rq);
@@ -6396,7 +6401,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 			min_vruntime = cfs_rq->min_vruntime;
 		} while (min_vruntime != min_vruntime_copy);
 #else
-		min_vruntime = cfs_rq->min_vruntime;
+		min_vruntime = cfs_rq_min_vruntime(cfs_rq);
 #endif
 
 		se->vruntime -= min_vruntime;
@@ -10382,7 +10387,7 @@ static void task_fork_fair(struct task_struct *p)
 		resched_curr(rq);
 	}
 
-	se->vruntime -= cfs_rq->min_vruntime;
+	se->vruntime -= cfs_rq_min_vruntime(cfs_rq);
 	rq_unlock(rq, &rf);
 }
 
@@ -10502,7 +10507,7 @@ static void detach_task_cfs_rq(struct task_struct *p)
 		 * cause 'unlimited' sleep bonus.
 		 */
 		place_entity(cfs_rq, se, 0);
-		se->vruntime -= cfs_rq->min_vruntime;
+		se->vruntime -= cfs_rq_min_vruntime(cfs_rq);
 	}
 
 	detach_entity_cfs_rq(se);
@@ -10516,7 +10521,7 @@ static void attach_task_cfs_rq(struct task_struct *p)
 	attach_entity_cfs_rq(se);
 
 	if (!vruntime_normalized(p))
-		se->vruntime += cfs_rq->min_vruntime;
+		se->vruntime += cfs_rq_min_vruntime(cfs_rq);
 }
 
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
-- 
2.17.1

