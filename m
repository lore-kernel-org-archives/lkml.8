Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A69C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE4E22CAF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUxBZ1Ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgHGJve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:51:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38334 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728209AbgHGJv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596793885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/HF9RVTQ+ZTIh7ud0STiu49WCNPHw9YdlpSFuMKv58=;
        b=GUxBZ1UbxP72qFOWl/Yd90zbe78sFS+sFKgFD2KIj07QJg8f5subPsFD+TKIHikkysjjZF
        PPGYHBekTxXslSUUqjRccsupO717LgLG92QeO3tciwebmS0Xe+zsGN5mlTh+BEBOKB0nLI
        v8qMf1vvvCmH3Cn5SWyrWMqRTUpNRQs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-bMfRzUQaOsOm1ihVUYf_Ag-1; Fri, 07 Aug 2020 05:51:22 -0400
X-MC-Unique: bMfRzUQaOsOm1ihVUYf_Ag-1
Received: by mail-wm1-f70.google.com with SMTP id s4so453489wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 02:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/HF9RVTQ+ZTIh7ud0STiu49WCNPHw9YdlpSFuMKv58=;
        b=j6amQdJsh2O5g3LhmmhiFcIE7y+8qx3HOqgT0WPnzOCW73uyQKOyU1/35WIQTvUARr
         +2qFk4RXlOdHLP9M4Ua3EWcKohCRfoCgUDK+IqPmU4ReJs6agW1WlethBhxlPl5AsqMd
         EsbFA/lCqPnDUohMnfIPbTJ3lghdLT2Hev+NmPsrpStnD3wv7bBG/Qm3J8GwkAZV25Ir
         ML31js7RxnqKN231rGqyvzsYpzKEaqvnvjd+JP1nbtzVqKigp45sIU+Vc/etB6h1rwAr
         hZqsxw0wHEfeawOcrdyCfu75d8RFWJSDJAtxgntiyOjLoQaYUeGlbvp6SgPTAe2ea3g8
         f7Ig==
X-Gm-Message-State: AOAM533E/S8KSknl4EMNzOdksc/jjkyGqaO7KuA9zUfl5nP9pA9vyH+I
        dOBAHNZIQ0TN3ioccMunVit1Qt9jdDCO3NJnjur/rSz0MyXE/iZbt1nkLAJ5KBMErMQ7kQp3+TT
        gRxgUWkOMGEFndaV+n+bpZECI
X-Received: by 2002:adf:eb89:: with SMTP id t9mr11182825wrn.65.1596793880896;
        Fri, 07 Aug 2020 02:51:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVWq6bepkCG4H0mARF8/cqSTRwKYKa0bwk+v75Q1KrkoLYz1ALxZjp2ycz7XCelnea3DAEGA==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr11182803wrn.65.1596793880638;
        Fri, 07 Aug 2020 02:51:20 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.36.84])
        by smtp.gmail.com with ESMTPSA id h14sm9388396wml.30.2020.08.07.02.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 02:51:19 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: [RFC PATCH v2 1/6] sched: Unify runtime accounting across classes
Date:   Fri,  7 Aug 2020 11:50:46 +0200
Message-Id: <20200807095051.385985-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807095051.385985-1-juri.lelli@redhat.com>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

All classes use sched_entity::exec_start to track runtime and have
copies of the exact same code around to compute runtime.

Collapse all that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h    |  2 +-
 kernel/sched/deadline.c  | 17 +++-----------
 kernel/sched/fair.c      | 50 +++++++++++++++++++++++++++++++---------
 kernel/sched/rt.c        | 17 +++-----------
 kernel/sched/sched.h     |  2 ++
 kernel/sched/stop_task.c | 16 +------------
 6 files changed, 49 insertions(+), 55 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a6bf77c346876..f7b9ba04970bc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -424,7 +424,7 @@ struct sched_statistics {
 
 	u64				block_start;
 	u64				block_max;
-	u64				exec_max;
+	s64				exec_max;
 	u64				slice_max;
 
 	u64				nr_migrations_cold;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3862a28cd05d0..2ece83b5991f5 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1221,9 +1221,8 @@ static void update_curr_dl(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_dl_entity *dl_se = &curr->dl;
-	u64 delta_exec, scaled_delta_exec;
+	s64 delta_exec, scaled_delta_exec;
 	int cpu = cpu_of(rq);
-	u64 now;
 
 	if (!dl_task(curr) || !on_dl_rq(dl_se))
 		return;
@@ -1236,23 +1235,13 @@ static void update_curr_dl(struct rq *rq)
 	 * natural solution, but the full ramifications of this
 	 * approach need further study.
 	 */
-	now = rq_clock_task(rq);
-	delta_exec = now - curr->se.exec_start;
-	if (unlikely((s64)delta_exec <= 0)) {
+	delta_exec = update_curr_common(rq);
+	if (unlikely(delta_exec <= 0)) {
 		if (unlikely(dl_se->dl_yielded))
 			goto throttle;
 		return;
 	}
 
-	schedstat_set(curr->se.statistics.exec_max,
-		      max(curr->se.statistics.exec_max, delta_exec));
-
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
-	curr->se.exec_start = now;
-	cgroup_account_cputime(curr, delta_exec);
-
 	if (dl_entity_is_special(dl_se))
 		return;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2ba8f230feb9a..10a230d85104a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -836,30 +836,58 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq, int force)
 }
 #endif /* CONFIG_SMP */
 
+static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
+{
+	u64 now = rq_clock_task(rq);
+	s64 delta_exec;
+
+	delta_exec = now - curr->exec_start;
+	if (unlikely(delta_exec <= 0))
+		return delta_exec;
+
+	curr->exec_start = now;
+	curr->sum_exec_runtime += delta_exec;
+
+	schedstat_set(curr->statistics.exec_max,
+		      max(delta_exec, curr->statistics.exec_max));
+
+	return delta_exec;
+}
+
+/*
+ * Used by other classes to account runtime.
+ */
+s64 update_curr_common(struct rq *rq)
+{
+	struct task_struct *curr = rq->curr;
+	s64 delta_exec;
+
+	delta_exec = update_curr_se(rq, &curr->se);
+	if (unlikely(delta_exec <= 0))
+		return delta_exec;
+
+	account_group_exec_runtime(curr, delta_exec);
+	cgroup_account_cputime(curr, delta_exec);
+
+	return delta_exec;
+}
+
 /*
  * Update the current task's runtime statistics.
  */
 static void update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
-	u64 now = rq_clock_task(rq_of(cfs_rq));
-	u64 delta_exec;
+	s64 delta_exec;
 
 	if (unlikely(!curr))
 		return;
 
-	delta_exec = now - curr->exec_start;
-	if (unlikely((s64)delta_exec <= 0))
+	delta_exec = update_curr_se(rq_of(cfs_rq), curr);
+	if (unlikely(delta_exec <= 0))
 		return;
 
-	curr->exec_start = now;
-
-	schedstat_set(curr->statistics.exec_max,
-		      max(delta_exec, curr->statistics.exec_max));
-
-	curr->sum_exec_runtime += delta_exec;
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
-
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
 	update_min_vruntime(cfs_rq);
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f215eea6a9661..196171fbf5978 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -997,26 +997,15 @@ static void update_curr_rt(struct rq *rq)
 {
 	struct task_struct *curr = rq->curr;
 	struct sched_rt_entity *rt_se = &curr->rt;
-	u64 delta_exec;
-	u64 now;
+	s64 delta_exec;
 
 	if (curr->sched_class != &rt_sched_class)
 		return;
 
-	now = rq_clock_task(rq);
-	delta_exec = now - curr->se.exec_start;
-	if (unlikely((s64)delta_exec <= 0))
+	delta_exec = update_curr_common(rq);
+	if (unlikely(delta_exec < 0))
 		return;
 
-	schedstat_set(curr->se.statistics.exec_max,
-		      max(curr->se.statistics.exec_max, delta_exec));
-
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
-	curr->se.exec_start = now;
-	cgroup_account_cputime(curr, delta_exec);
-
 	if (!rt_bandwidth_enabled())
 		return;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3fd283892761d..963c16fc27500 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1769,6 +1769,8 @@ extern const u32		sched_prio_to_wmult[40];
 
 #define RETRY_TASK		((void *)-1UL)
 
+extern s64 update_curr_common(struct rq *rq);
+
 struct sched_class {
 
 #ifdef CONFIG_UCLAMP_TASK
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 394bc8126a1e5..1eb1e336e18e7 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -62,21 +62,7 @@ static void yield_task_stop(struct rq *rq)
 
 static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 {
-	struct task_struct *curr = rq->curr;
-	u64 delta_exec;
-
-	delta_exec = rq_clock_task(rq) - curr->se.exec_start;
-	if (unlikely((s64)delta_exec < 0))
-		delta_exec = 0;
-
-	schedstat_set(curr->se.statistics.exec_max,
-			max(curr->se.statistics.exec_max, delta_exec));
-
-	curr->se.sum_exec_runtime += delta_exec;
-	account_group_exec_runtime(curr, delta_exec);
-
-	curr->se.exec_start = rq_clock_task(rq);
-	cgroup_account_cputime(curr, delta_exec);
+	update_curr_common(rq);
 }
 
 /*
-- 
2.26.2

