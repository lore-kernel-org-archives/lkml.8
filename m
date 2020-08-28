Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF17FC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A3520897
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="abkUSm7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgH1TzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgH1Twl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:52:41 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8BFC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:40 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id p185so629959qkb.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=h7LRobPYJWXNTzvAyF+XR/mfRJwNUgz8Y0+z5m9InCY=;
        b=abkUSm7ZLwwlgYj3phmvuVj6joKhOSwWaziFG7HcxgHev+1mjTAqleCt+CthSA1BYC
         g1MhN3zPAXLpADnDESrtMPrMNaAXD4PJVEiGPTemd3XlqMVZb5Hm8sBk3X/tga9XKDFv
         YoUD/WPtjLHfwFZBkSNcd+CvUV2kxCpWD5rwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=h7LRobPYJWXNTzvAyF+XR/mfRJwNUgz8Y0+z5m9InCY=;
        b=Br9k2tdCAEGqtPXbyzoX+k/XtEOHxiWt46qUKSk0YLkadKsx0J6d7OVEM/VxGVs28k
         MyiVUOyGxu0ehIuhjQ95tZLfep7YQ8Mw9MgCe/g3NsLKaaYw3MqT+2d5WfC2Dp34+r8P
         uWTP1LiLjZqTvySeVZNIeCd8WnYTVS2/5q/Lu5iec1CC4+7NEIsg1WcOLTkafmdztGFD
         opjdqPKkxGKcDjEuRKx7esp6AMZemApB6cLmjXUpIPRhSKCzYb1xFyHdF9SPMavw+JU/
         bZSCGQz80Fnn81Nqm+EuoDtccnycqeZDmCRKGeblOipRaZpJ8mfRVwdoQ/DZCpuE/d8T
         pscQ==
X-Gm-Message-State: AOAM532SB6Vh1aklhP01+Q6ECT8S2fA8cBwDTst1hTtTqwkysTsraQDU
        HIVP8E6eN2t9stvvKDwYVAMVOA==
X-Google-Smtp-Source: ABdhPJwFUy1ZeLB3dHONODJ01CrEn/XkaCyD036JSFNW3e18X+FM2lEOXVScWza6gDCkZECXFpHgSQ==
X-Received: by 2002:a37:aa4d:: with SMTP id t74mr805352qke.296.1598644359792;
        Fri, 28 Aug 2020 12:52:39 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:52:38 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Aaron Lu <ziqian.lzq@antfin.com>
Subject: [RFC PATCH v7 10/23] sched/fair: wrapper for cfs_rq->min_vruntime
Date:   Fri, 28 Aug 2020 15:51:11 -0400
Message-Id: <28f2b5c0d372f90d0530c26061748495d1b9e27c.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
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
index 409edc736297..298d2c521c1e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -460,6 +460,11 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 
 #endif	/* CONFIG_FAIR_GROUP_SCHED */
 
+static inline u64 cfs_rq_min_vruntime(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->min_vruntime;
+}
+
 static __always_inline
 void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
 
@@ -496,7 +501,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 	struct sched_entity *curr = cfs_rq->curr;
 	struct rb_node *leftmost = rb_first_cached(&cfs_rq->tasks_timeline);
 
-	u64 vruntime = cfs_rq->min_vruntime;
+	u64 vruntime = cfs_rq_min_vruntime(cfs_rq);
 
 	if (curr) {
 		if (curr->on_rq)
@@ -516,7 +521,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 	}
 
 	/* ensure we never gain time by being placed backwards. */
-	cfs_rq->min_vruntime = max_vruntime(cfs_rq->min_vruntime, vruntime);
+	cfs_rq->min_vruntime = max_vruntime(cfs_rq_min_vruntime(cfs_rq), vruntime);
 #ifndef CONFIG_64BIT
 	smp_wmb();
 	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;
@@ -4044,7 +4049,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq) {}
 static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 #ifdef CONFIG_SCHED_DEBUG
-	s64 d = se->vruntime - cfs_rq->min_vruntime;
+	s64 d = se->vruntime - cfs_rq_min_vruntime(cfs_rq);
 
 	if (d < 0)
 		d = -d;
@@ -4057,7 +4062,7 @@ static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
-	u64 vruntime = cfs_rq->min_vruntime;
+	u64 vruntime = cfs_rq_min_vruntime(cfs_rq);
 
 	/*
 	 * The 'current' period is already promised to the current tasks,
@@ -4151,7 +4156,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * update_curr().
 	 */
 	if (renorm && curr)
-		se->vruntime += cfs_rq->min_vruntime;
+		se->vruntime += cfs_rq_min_vruntime(cfs_rq);
 
 	update_curr(cfs_rq);
 
@@ -4162,7 +4167,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * fairness detriment of existing tasks.
 	 */
 	if (renorm && !curr)
-		se->vruntime += cfs_rq->min_vruntime;
+		se->vruntime += cfs_rq_min_vruntime(cfs_rq);
 
 	/*
 	 * When enqueuing a sched_entity, we must:
@@ -4281,7 +4286,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 * can move min_vruntime forward still more.
 	 */
 	if (!(flags & DEQUEUE_SLEEP))
-		se->vruntime -= cfs_rq->min_vruntime;
+		se->vruntime -= cfs_rq_min_vruntime(cfs_rq);
 
 	/* return excess runtime on last dequeue */
 	return_cfs_rq_runtime(cfs_rq);
@@ -6717,7 +6722,7 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 			min_vruntime = cfs_rq->min_vruntime;
 		} while (min_vruntime != min_vruntime_copy);
 #else
-		min_vruntime = cfs_rq->min_vruntime;
+		min_vruntime = cfs_rq_min_vruntime(cfs_rq);
 #endif
 
 		se->vruntime -= min_vruntime;
@@ -10727,7 +10732,7 @@ static void task_fork_fair(struct task_struct *p)
 		resched_curr(rq);
 	}
 
-	se->vruntime -= cfs_rq->min_vruntime;
+	se->vruntime -= cfs_rq_min_vruntime(cfs_rq);
 	rq_unlock(rq, &rf);
 }
 
@@ -10850,7 +10855,7 @@ static void detach_task_cfs_rq(struct task_struct *p)
 		 * cause 'unlimited' sleep bonus.
 		 */
 		place_entity(cfs_rq, se, 0);
-		se->vruntime -= cfs_rq->min_vruntime;
+		se->vruntime -= cfs_rq_min_vruntime(cfs_rq);
 	}
 
 	detach_entity_cfs_rq(se);
@@ -10864,7 +10869,7 @@ static void attach_task_cfs_rq(struct task_struct *p)
 	attach_entity_cfs_rq(se);
 
 	if (!vruntime_normalized(p))
-		se->vruntime += cfs_rq->min_vruntime;
+		se->vruntime += cfs_rq_min_vruntime(cfs_rq);
 }
 
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
-- 
2.17.1

