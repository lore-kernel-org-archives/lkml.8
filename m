Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD06C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF40220825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="eVWY0WF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgH1Twz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbgH1TwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:52:24 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D34EC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:21 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so468232qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xQUePnH0mOCv7A7lKIP5Oe8fJ0Y0AZ9WMemjWACOJB4=;
        b=eVWY0WF2SGqqOmmiPRTwOAXImaBKiCTuVxrDldGFKWamnDkQDKvU7MvzXomauGgg40
         7w4YjK7EpHb0d+FV5py5OWE+WEwD5sR8zy8buQz9fqhiFQyUpU3y0yMqnx2TnNl0xHTe
         BmsLUg1LSnTZHhc8DbU9wtArBFxvbivxTHVgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xQUePnH0mOCv7A7lKIP5Oe8fJ0Y0AZ9WMemjWACOJB4=;
        b=iiuY856bf+HavLdKQsDSlQRhe/EHskTNi4JLaU80xYJ916l7vwE/3pIFSRtYXIlXBz
         /bdNIeum3Ea87L/T2acVdnv6Yer5cMhVJAk4Msjf5UpTC2Hjifds4JxD6yWHLzV/hyAO
         bCKfFfkbRwWrECGMFBBEjtI7vd0uWpIBWsSiQQLmuT2zbL/rmB53TS7GiPgEFEw8zPsu
         +T1WRa7ECKvP90/ZnpRxNe+8gZ0wlLyg7+tU7ndRZmUU5LDDSBi774IUeCPs++YqxFVj
         I9864VpscpkTndaOtVrtlDMz5oMkkB0dfi0c75Do/3vVBfgTGz3S04aTeB3WHB580ilE
         nSYQ==
X-Gm-Message-State: AOAM531QGnoMh8DfgmPfRf/30J517FXL67hPjQxYco144jkaaBK+NLU6
        ROIJg+r9D0QYUtVYj8PK/RQR9g==
X-Google-Smtp-Source: ABdhPJzZtkgnuHntBX8o5CGlIePAsrxM/ZFh3sKQoUF0OLNFdP7wErqJ5/c8KZCuIniLf/hRkpN/Cw==
X-Received: by 2002:aed:26a1:: with SMTP id q30mr3189419qtd.25.1598644340168;
        Fri, 28 Aug 2020 12:52:20 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:52:19 -0700 (PDT)
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
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
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
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>
Subject: [RFC PATCH v7 02/23] sched: Introduce sched_class::pick_task()
Date:   Fri, 28 Aug 2020 15:51:03 -0400
Message-Id: <1ab71fed89b743882111027e2d6303c479bebd9d.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
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
index c588a06057dc..6389aff32558 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1824,7 +1824,7 @@ static struct sched_dl_entity *pick_next_dl_entity(struct rq *rq,
 	return rb_entry(left, struct sched_dl_entity, rb_node);
 }
 
-static struct task_struct *pick_next_task_dl(struct rq *rq)
+static struct task_struct *pick_task_dl(struct rq *rq)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -1836,7 +1836,18 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
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
 
@@ -2493,6 +2504,7 @@ const struct sched_class dl_sched_class
 
 #ifdef CONFIG_SMP
 	.balance		= balance_dl,
+	.pick_task		= pick_task_dl,
 	.select_task_rq		= select_task_rq_dl,
 	.migrate_task_rq	= migrate_task_rq_dl,
 	.set_cpus_allowed       = set_cpus_allowed_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9be6cf92cc3d..1a1bf726264a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4446,7 +4446,7 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	 * Avoid running the skip buddy, if running something else can
 	 * be done without getting too unfair.
 	 */
-	if (cfs_rq->skip == se) {
+	if (cfs_rq->skip && cfs_rq->skip == se) {
 		struct sched_entity *second;
 
 		if (se == curr) {
@@ -4464,13 +4464,13 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
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
@@ -6970,6 +6970,35 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
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
@@ -11152,6 +11181,7 @@ const struct sched_class fair_sched_class
 
 #ifdef CONFIG_SMP
 	.balance		= balance_fair,
+	.pick_task		= pick_task_fair,
 	.select_task_rq		= select_task_rq_fair,
 	.migrate_task_rq	= migrate_task_rq_fair,
 
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 5c33beb1a525..8c41b023dd14 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -408,6 +408,13 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
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
@@ -475,6 +482,7 @@ const struct sched_class idle_sched_class
 
 #ifdef CONFIG_SMP
 	.balance		= balance_idle,
+	.pick_task		= pick_task_idle,
 	.select_task_rq		= select_task_rq_idle,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e57fca05b660..a5851c775270 100644
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
 
@@ -2443,6 +2452,7 @@ const struct sched_class rt_sched_class
 
 #ifdef CONFIG_SMP
 	.balance		= balance_rt,
+	.pick_task		= pick_task_rt,
 	.select_task_rq		= select_task_rq_rt,
 	.set_cpus_allowed       = set_cpus_allowed_common,
 	.rq_online              = rq_online_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9145be83d80b..293d031480d8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1793,6 +1793,9 @@ struct sched_class {
 
 #ifdef CONFIG_SMP
 	int (*balance)(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
+
+	struct task_struct * (*pick_task)(struct rq *rq);
+
 	int  (*select_task_rq)(struct task_struct *p, int task_cpu, int sd_flag, int flags);
 	void (*migrate_task_rq)(struct task_struct *p, int new_cpu);
 
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 394bc8126a1e..8f92915dd95e 100644
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
@@ -124,6 +132,7 @@ const struct sched_class stop_sched_class
 
 #ifdef CONFIG_SMP
 	.balance		= balance_stop,
+	.pick_task		= pick_task_stop,
 	.select_task_rq		= select_task_rq_stop,
 	.set_cpus_allowed	= set_cpus_allowed_common,
 #endif
-- 
2.17.1

