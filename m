Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C582C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487A52465D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="AuEPgc4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbgCDRAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:00:48 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35389 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388333AbgCDRAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:00:11 -0500
Received: by mail-qt1-f196.google.com with SMTP id v15so1901766qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=dF5F37k3eAJY4EzLRT+ogSrkSEWzuWuSPFPIFXk7yLU=;
        b=AuEPgc4XB8gCdH4OSrC3SLQX+9igmmal9g5h3oo40xgv8x9kYo9lVO/I6qpQWqfoU6
         hnvu5eQ/uHmy+EVUZCGHofI8OugijE/3esn8WRzF5w67QD+fTKbHgMmQwmzMvDZx5WbD
         CFNlSMaBSVZ0LXU/DUuPL8xqrbnTNYH2hUUOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=dF5F37k3eAJY4EzLRT+ogSrkSEWzuWuSPFPIFXk7yLU=;
        b=j63j6RDD8d8VEWsphmDC0pdycVR6PknlRlYlGnJOkAoRKOWQlDpt4050YwNf9eQRLp
         gXRLK6pNMlXzxQxG79m5Au2sDzR8XBaXhxoixBgTshNBIn/ZsxDRLkT4C2/8Au4+uXvT
         67pMSNgi1v/i0/YcdTrgInaXOuSyxduMTPlPLn6apSPj3dRNKjFxGNdIeSUN3+8kB49z
         IbLDOXjVLv9WkyVk24n92cUjz3nI0Zf1tKqVayuHNsN99JnkOuYVg7geEKI6eqk81iOQ
         cvaT/vjD2BkpG6bit81m9Hw8FU3ZdFIqTwKcDt6QvSLcLgrlZLXoPhKwI71R4wN++UlZ
         EJ6g==
X-Gm-Message-State: ANhLgQ3dcLnzqDXa/3Cysb8ye4ZbIhrXUp4TpFCtM9u8Eh76BQFOFVOx
        TnezvNuBBjZodgR/JZz9u7CmKQ==
X-Google-Smtp-Source: ADFU+vtEWF216MFJ5iO3xgxjJCoTg+kxl+NwWiWzOSBXrJgIiNXvSKPsu3v/vFzfCs3ge7IXtuc+Nw==
X-Received: by 2002:ac8:2f8b:: with SMTP id l11mr3300875qta.65.1583341209097;
        Wed, 04 Mar 2020 09:00:09 -0800 (PST)
Received: from s2r5node9 ([162.243.188.99])
        by smtp.gmail.com with ESMTPSA id i64sm12345139qke.56.2020.03.04.09.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:00:08 -0800 (PST)
From:   vpillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH 02/13] sched: Introduce sched_class::pick_task()
Date:   Wed,  4 Mar 2020 16:59:52 +0000
Message-Id: <f3088b128915178ceef9c7e6003f2c69265cc71a.1583332765.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1583332764.git.vpillai@digitalocean.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Because sched_class::pick_next_task() also implies
sched_class::set_next_task() (and possibly put_prev_task() and
newidle_balance) it is not state invariant. This makes it unsuitable
for remote task selection.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vineeth Remanan Pillai <vpillai@digitalocean.com>
Signed-off-by: Julien Desfossez <jdesfossez@digitalocean.com>
---
 kernel/sched/deadline.c  | 16 ++++++++++++++--
 kernel/sched/fair.c      | 34 +++++++++++++++++++++++++++++++---
 kernel/sched/idle.c      |  6 ++++++
 kernel/sched/rt.c        | 14 ++++++++++++--
 kernel/sched/sched.h     |  3 +++
 kernel/sched/stop_task.c | 13 +++++++++++--
 6 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ded147f84382..ee7fd8611ee4 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1773,7 +1773,7 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
 	return rb_entry(left, struct sched_dl_entity, rb_node);
 }
 
-static struct task_struct *pick_next_task_dl(struct rq *rq)
+static struct task_struct *pick_task_dl(struct rq *rq)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -1785,7 +1785,18 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
 	dl_se = pick_next_dl_entity(rq, dl_rq);
 	BUG_ON(!dl_se);
 	p = dl_task_of(dl_se);
-	set_next_task_dl(rq, p, true);
+
+	return p;
+}
+
+static struct task_struct *pick_next_task_dl(struct rq *rq)
+{
+	struct task_struct *p;
+
+	p = pick_task_dl(rq);
+	if (p)
+		set_next_task_dl(rq, p, true);
+
 	return p;
 }
 
@@ -2442,6 +2453,7 @@ const struct sched_class dl_sched_class = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_dl,
+	.pick_task		= pick_task_dl,
 	.select_task_rq		= select_task_rq_dl,
 	.migrate_task_rq	= migrate_task_rq_dl,
 	.set_cpus_allowed       = set_cpus_allowed_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3b218753bf7a..5eaaf0c4d9ad 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4228,7 +4228,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	 * Avoid running the skip buddy, if running something else can
 	 * be done without getting too unfair.
 	 */
-	if (cfs_rq->skip == se) {
+	if (cfs_rq->skip && cfs_rq->skip == se) {
 		struct sched_entity *second;
 
 		if (se == curr) {
@@ -4246,13 +4246,13 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	/*
 	 * Prefer last buddy, try to return the CPU to a preempted task.
 	 */
-	if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
+	if (left && cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
 		se = cfs_rq->last;
 
 	/*
 	 * Someone really wants this to run. If it's not unfair, run it.
 	 */
-	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
+	if (left && cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
 		se = cfs_rq->next;
 
 	clear_buddies(cfs_rq, se);
@@ -6642,6 +6642,33 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 		set_last_buddy(se);
 }
 
+static struct task_struct *pick_task_fair(struct rq *rq)
+{
+	struct cfs_rq *cfs_rq = &rq->cfs;
+	struct sched_entity *se;
+
+	if (!cfs_rq->nr_running)
+		return NULL;
+
+	do {
+		struct sched_entity *curr = cfs_rq->curr;
+
+		se = pick_next_entity(cfs_rq, NULL);
+
+		if (curr) {
+			if (se && curr->on_rq)
+				update_curr(cfs_rq);
+
+			if (!se || entity_before(curr, se))
+				se = curr;
+		}
+
+		cfs_rq = group_cfs_rq(se);
+	} while (cfs_rq);
+
+	return task_of(se);
+}
+
 struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -10771,6 +10798,7 @@ const struct sched_class fair_sched_class = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_fair,
+	.pick_task		= pick_task_fair,
 	.select_task_rq		= select_task_rq_fair,
 	.migrate_task_rq	= migrate_task_rq_fair,
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f8653290de95..46c18e3dab13 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -397,6 +397,11 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 	schedstat_inc(rq->sched_goidle);
 }
 
+static struct task_struct *pick_task_idle(struct rq *rq)
+{
+	return rq->idle;
+}
+
 struct task_struct *pick_next_task_idle(struct rq *rq)
 {
 	struct task_struct *next = rq->idle;
@@ -469,6 +474,7 @@ const struct sched_class idle_sched_class = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_idle,
+	.pick_task		= pick_task_idle,
 	.select_task_rq		= select_task_rq_idle,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index fc7d6706b209..d044baedc617 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1567,7 +1567,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 	return rt_task_of(rt_se);
 }
 
-static struct task_struct *pick_next_task_rt(struct rq *rq)
+static struct task_struct *pick_task_rt(struct rq *rq)
 {
 	struct task_struct *p;
 
@@ -1575,7 +1575,16 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
 		return NULL;
 
 	p = _pick_next_task_rt(rq);
-	set_next_task_rt(rq, p, true);
+
+	return p;
+}
+
+static struct task_struct *pick_next_task_rt(struct rq *rq)
+{
+	struct task_struct *p = pick_task_rt(rq);
+	if (p)
+		set_next_task_rt(rq, p, true);
+
 	return p;
 }
 
@@ -2368,6 +2377,7 @@ const struct sched_class rt_sched_class = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_rt,
+	.pick_task		= pick_task_rt,
 	.select_task_rq		= select_task_rq_rt,
 	.set_cpus_allowed       = set_cpus_allowed_common,
 	.rq_online              = rq_online_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a306008a12f7..a8335e3078ab 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1724,6 +1724,9 @@ struct sched_class {
 
 #ifdef CONFIG_SMP
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
+
+	struct task_struct * (*pick_task)(struct rq *rq);
+
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 4c9e9975684f..0611348edb28 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -34,15 +34,23 @@ static void set_next_task_stop(struct rq *rq, struct task_struct *stop, bool fir
 	stop->se.exec_start = rq_clock_task(rq);
 }
 
-static struct task_struct *pick_next_task_stop(struct rq *rq)
+static struct task_struct *pick_task_stop(struct rq *rq)
 {
 	if (!sched_stop_runnable(rq))
 		return NULL;
 
-	set_next_task_stop(rq, rq->stop, true);
 	return rq->stop;
 }
 
+static struct task_struct *pick_next_task_stop(struct rq *rq)
+{
+	struct task_struct *p = pick_task_stop(rq);
+	if (p)
+		set_next_task_stop(rq, p, true);
+
+	return p;
+}
+
 static void
 enqueue_task_stop(struct rq *rq, struct task_struct *p, int flags)
 {
@@ -130,6 +138,7 @@ const struct sched_class stop_sched_class = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_stop,
+	.pick_task		= pick_task_stop,
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
-- 
2.17.1

