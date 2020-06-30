Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FD1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0CB52065D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="SCiNXLZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgF3VdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgF3Vc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:32:58 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BCCC03E97A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:32:58 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p3so10562460pgh.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 14:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ZYTpuNqKkvEFghyl2AZ6/1W5/t3s/w6ggoK9VbDtyf8=;
        b=SCiNXLZLiKWQ0wMEefvjTbKDRnSGp+fbfrMh8OJS0MFDUQx0ND24Aoe4HWG2D5HS6h
         BnixkKSCENQcVA769dC60YYywZOj+Zcev09BTioEo+y02OswbNiyIQQj0cKdzISUk6Pg
         59RcpEGHLQZf6vWCAaonNDVU6+OdmBwlNZhy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ZYTpuNqKkvEFghyl2AZ6/1W5/t3s/w6ggoK9VbDtyf8=;
        b=fTH8YIOdANiCBzoP6zAloKaD3OkEP614mf5QOjCob6Vzxw1/smtBTc56ZTq+E0wwwH
         s3HhfbJ7QS+Kw6Q2DVK9/Bk2dRHv6c/JoTtu/wY2uKy6cOE6TDlAV6nPUhmge/6cfXmU
         xEpRK0UCiESFc9TsmKDLZGBJZ5xEP5Wq+yLrntFrc646Bgnk0XcHwQ4+OR0lNlwoJX92
         8JHGwjCzohOB4JaHMvjDuMB8qTmwpGf8mnjeWLkZR1qanVVyeN1rYlnO75Slhi/dfXXo
         ZUhwEp2hcGzrDJek0vYc91hFCRfFPdzVhvzcZayDME2vA+Ex8E2Jeg5F5O+gopEXYTxR
         /gCQ==
X-Gm-Message-State: AOAM533Lg5ST0xX3coCe2nOJNYzlWJ3Tq5qFDGR0jjgwBKBrDZru/5im
        X4FrQQhvUNxXZBifm/atZUdf2RiOC+Y=
X-Google-Smtp-Source: ABdhPJyDEcmrj7iFA+k1+JolMzKMztcuivx7ebsuym8sFm94Bdjza7PKh0ZBY6aQ5xhDJ/kaClIZcw==
X-Received: by 2002:a62:15d1:: with SMTP id 200mr19954291pfv.227.1593552777601;
        Tue, 30 Jun 2020 14:32:57 -0700 (PDT)
Received: from vpillai-dev.sfo2.internal.digitalocean.com ([138.68.32.68])
        by smtp.gmail.com with ESMTPSA id z11sm3626345pfg.169.2020.06.30.14.32.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jun 2020 14:32:57 -0700 (PDT)
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
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
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Subject: [RFC PATCH 02/16] sched: Introduce sched_class::pick_task()
Date:   Tue, 30 Jun 2020 21:32:23 +0000
Message-Id: <442920e5f17dd26dfff523c732bd011687a25f90.1593530334.git.vpillai@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
In-Reply-To: <cover.1593530334.git.vpillai@digitalocean.com>
References: <cover.1593530334.git.vpillai@digitalocean.com>
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
 kernel/sched/fair.c      | 36 +++++++++++++++++++++++++++++++++---
 kernel/sched/idle.c      |  8 ++++++++
 kernel/sched/rt.c        | 14 ++++++++++++--
 kernel/sched/sched.h     |  3 +++
 kernel/sched/stop_task.c | 13 +++++++++++--
 6 files changed, 81 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 34f95462b838..b56ef74d2d74 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1775,7 +1775,7 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
 	return rb_entry(left, struct sched_dl_entity, rb_node);
 }
 
-static struct task_struct *pick_next_task_dl(struct rq *rq)
+static struct task_struct *pick_task_dl(struct rq *rq)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -1787,7 +1787,18 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
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
 
@@ -2444,6 +2455,7 @@ const struct sched_class dl_sched_class = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_dl,
+	.pick_task		= pick_task_dl,
 	.select_task_rq		= select_task_rq_dl,
 	.migrate_task_rq	= migrate_task_rq_dl,
 	.set_cpus_allowed       = set_cpus_allowed_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 43ff0e5cf387..5e9f11c8256f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4428,7 +4428,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	 * Avoid running the skip buddy, if running something else can
 	 * be done without getting too unfair.
 	 */
-	if (cfs_rq->skip == se) {
+	if (cfs_rq->skip && cfs_rq->skip == se) {
 		struct sched_entity *second;
 
 		if (se == curr) {
@@ -4446,13 +4446,13 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
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
@@ -6953,6 +6953,35 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 		set_last_buddy(se);
 }
 
+#ifdef CONFIG_SMP
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
+#endif
+
 struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -11134,6 +11163,7 @@ const struct sched_class fair_sched_class = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_fair,
+	.pick_task		= pick_task_fair,
 	.select_task_rq		= select_task_rq_fair,
 	.migrate_task_rq	= migrate_task_rq_fair,
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 0106d34f1d8c..a8d40ffab097 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -397,6 +397,13 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 	schedstat_inc(rq->sched_goidle);
 }
 
+#ifdef CONFIG_SMP
+static struct task_struct *pick_task_idle(struct rq *rq)
+{
+	return rq->idle;
+}
+#endif
+
 struct task_struct *pick_next_task_idle(struct rq *rq)
 {
 	struct task_struct *next = rq->idle;
@@ -469,6 +476,7 @@ const struct sched_class idle_sched_class = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_idle,
+	.pick_task		= pick_task_idle,
 	.select_task_rq		= select_task_rq_idle,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index c054d9c07629..69c77370767d 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1624,7 +1624,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
 	return rt_task_of(rt_se);
 }
 
-static struct task_struct *pick_next_task_rt(struct rq *rq)
+static struct task_struct *pick_task_rt(struct rq *rq)
 {
 	struct task_struct *p;
 
@@ -1632,7 +1632,16 @@ static struct task_struct *pick_next_task_rt(struct rq *rq)
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
 
@@ -2443,6 +2452,7 @@ const struct sched_class rt_sched_class = {
 
 #ifdef CONFIG_SMP
 	.balance		= balance_rt,
+	.pick_task		= pick_task_rt,
 	.select_task_rq		= select_task_rq_rt,
 	.set_cpus_allowed       = set_cpus_allowed_common,
 	.rq_online              = rq_online_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b15feed95027..a63c3115d212 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1769,6 +1769,9 @@ struct sched_class {
 
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

