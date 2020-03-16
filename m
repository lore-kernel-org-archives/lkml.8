Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C82C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF3B20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="fskKj2fn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbgCPTNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:13:50 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35615 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732413AbgCPTNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 15:13:49 -0400
Received: by mail-qk1-f195.google.com with SMTP id d8so28256556qka.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 12:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=khwS4toKf6D+DVV7MNME1Tx0UEPy+NTQSpLO/dCP8hg=;
        b=fskKj2fnyAqGP5sXUZVY11JWJAFy/swvEwszQx9S2O5xcibUiW25SdUiEzks/+MHII
         TfOllR0qH841Vwq6JydD2OolpB36o1u5sve0UOzbLKDGbZMWj6HkBV07wBX16BeQSzxZ
         g9slUVHbYyICdyCGiL9hXTGsjR3WKJJPifFXxFFUTdH8Ml4zvJgsVnWhCGSmphDAgUAU
         EHRZF3f98FKq46UG+eHB36sysYaUZPpytN9TasCw+jQIItHsYtiYbc//hPRn84LJkruk
         xgA98z3f3FyuGIOmfiFMln8cZocfrv3HnqNx59Ort6AKRftVnq1b6jiBpcwPEsIRdRLA
         HDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=khwS4toKf6D+DVV7MNME1Tx0UEPy+NTQSpLO/dCP8hg=;
        b=dLxSg+nY3p2MglcTMP4IQD7CTKP3RXE5q8NU/mkcCfDS2IdIzka4og/xpWxz8oxuSD
         Zsd/10ZCvOkHJFuaWyoRIWpOOasDmf2eQrNxokrWnGZJr8GiSXmec1HDEciPWyLuAl/E
         uqtl+dZi8KkPYzEVzdEaZ0jV4g/RAsYOdbomMnlaciiw7iwyFUABY/Q7wHyyPoqxJCMp
         Kj5DQtLuBD7LxMl9wsXG0zNDZvJP8AjLDi7SHf+JPutwKuepIFMhMZzEM/BBtim0WPy1
         M23ZTrshmj1e1UDIIIKnrcNLBPegKMVa3kf3oX6yXf3g+t9J29uRhQnwJa8LiyvOS2sU
         lweA==
X-Gm-Message-State: ANhLgQ00W6FM6TBnbPKO3ikgF/XiZ9MKP3txRk8NVkpldVUS3iXgWhcH
        /4u3FkWeYrd7qQtugXFLdVGfTA==
X-Google-Smtp-Source: ADFU+vtzo7fFFZ7eZBPyAoRx0vsgSz8fWwGa2RHrVVI0bZpnMZ4GPpFDg2+xEmXTjtQKXSb64JqnkA==
X-Received: by 2002:a05:620a:1192:: with SMTP id b18mr1203027qkk.334.1584386026761;
        Mon, 16 Mar 2020 12:13:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f40d])
        by smtp.gmail.com with ESMTPSA id r46sm453498qtb.87.2020.03.16.12.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 12:13:46 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/3] psi: optimize switching tasks inside shared cgroups
Date:   Mon, 16 Mar 2020 15:13:32 -0400
Message-Id: <20200316191333.115523-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316191333.115523-1-hannes@cmpxchg.org>
References: <20200316191333.115523-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching tasks running on a CPU, the psi state of a cgroup
containing both of these tasks does not change. Right now, we don't
exploit that, and can perform many unnecessary state changes in nested
hierarchies, especially when most activity comes from one leaf cgroup.

This patch implements an optimization where we only update cgroups
whose state actually changes during a task switch. These are all
cgroups that contain one task but not the other, up to the first
shared ancestor. When both tasks are in the same group, we don't need
to update anything at all.

We can identify the first shared ancestor by walking the groups of the
incoming task until we see TSK_ONCPU set on the local CPU; that's the
first group that also contains the outgoing task.

The new psi_task_switch() is similar to psi_task_change(). To allow
code reuse, move the task flag maintenance code into a new function
and the poll/avg worker wakeups into the shared psi_group_change().

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/psi.h  |  2 +
 kernel/sched/psi.c   | 87 ++++++++++++++++++++++++++++++++++----------
 kernel/sched/stats.h |  9 +----
 3 files changed, 70 insertions(+), 28 deletions(-)

diff --git a/include/linux/psi.h b/include/linux/psi.h
index 7b3de7321219..7361023f3fdd 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -17,6 +17,8 @@ extern struct psi_group psi_system;
 void psi_init(void);
 
 void psi_task_change(struct task_struct *task, int clear, int set);
+void psi_task_switch(struct task_struct *prev, struct task_struct *next,
+		     bool sleep);
 
 void psi_memstall_tick(struct task_struct *task, int cpu);
 void psi_memstall_enter(unsigned long *flags);
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 50128297a4f9..955a124bae81 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -669,13 +669,14 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
 		groupc->times[PSI_NONIDLE] += delta;
 }
 
-static u32 psi_group_change(struct psi_group *group, int cpu,
-			    unsigned int clear, unsigned int set)
+static void psi_group_change(struct psi_group *group, int cpu,
+			     unsigned int clear, unsigned int set,
+			     bool wake_clock)
 {
 	struct psi_group_cpu *groupc;
+	u32 state_mask = 0;
 	unsigned int t, m;
 	enum psi_states s;
-	u32 state_mask = 0;
 
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
@@ -717,7 +718,11 @@ static u32 psi_group_change(struct psi_group *group, int cpu,
 
 	write_seqcount_end(&groupc->seq);
 
-	return state_mask;
+	if (state_mask & group->poll_states)
+		psi_schedule_poll_work(group, 1);
+
+	if (wake_clock && !delayed_work_pending(&group->avgs_work))
+		schedule_delayed_work(&group->avgs_work, PSI_FREQ);
 }
 
 static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
@@ -744,27 +749,32 @@ static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
 	return &psi_system;
 }
 
-void psi_task_change(struct task_struct *task, int clear, int set)
+static void psi_flags_change(struct task_struct *task, int clear, int set)
 {
-	int cpu = task_cpu(task);
-	struct psi_group *group;
-	bool wake_clock = true;
-	void *iter = NULL;
-
-	if (!task->pid)
-		return;
-
 	if (((task->psi_flags & set) ||
 	     (task->psi_flags & clear) != clear) &&
 	    !psi_bug) {
 		printk_deferred(KERN_ERR "psi: inconsistent task state! task=%d:%s cpu=%d psi_flags=%x clear=%x set=%x\n",
-				task->pid, task->comm, cpu,
+				task->pid, task->comm, task_cpu(task),
 				task->psi_flags, clear, set);
 		psi_bug = 1;
 	}
 
 	task->psi_flags &= ~clear;
 	task->psi_flags |= set;
+}
+
+void psi_task_change(struct task_struct *task, int clear, int set)
+{
+	int cpu = task_cpu(task);
+	struct psi_group *group;
+	bool wake_clock = true;
+	void *iter = NULL;
+
+	if (!task->pid)
+		return;
+
+	psi_flags_change(task, clear, set);
 
 	/*
 	 * Periodic aggregation shuts off if there is a period of no
@@ -777,14 +787,51 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 		     wq_worker_last_func(task) == psi_avgs_work))
 		wake_clock = false;
 
-	while ((group = iterate_groups(task, &iter))) {
-		u32 state_mask = psi_group_change(group, cpu, clear, set);
+	while ((group = iterate_groups(task, &iter)))
+		psi_group_change(group, cpu, clear, set, wake_clock);
+}
+
+void psi_task_switch(struct task_struct *prev, struct task_struct *next,
+		     bool sleep)
+{
+	struct psi_group *group, *common = NULL;
+	int cpu = task_cpu(prev);
+	void *iter;
+
+	if (next->pid) {
+		psi_flags_change(next, 0, TSK_ONCPU);
+		/*
+		 * When moving state between tasks, the group that
+		 * contains them both does not change: we can stop
+		 * updating the tree once we reach the first common
+		 * ancestor. Iterate @next's ancestors until we
+		 * encounter @prev's state.
+		 */
+		iter = NULL;
+		while ((group = iterate_groups(next, &iter))) {
+			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
+				common = group;
+				break;
+			}
+
+			psi_group_change(group, cpu, 0, TSK_ONCPU, true);
+		}
+	}
+
+	/*
+	 * If this is a voluntary sleep, dequeue will have taken care
+	 * of the outgoing TSK_ONCPU alongside TSK_RUNNING already. We
+	 * only need to deal with it during preemption.
+	 */
+	if (sleep)
+		return;
 
-		if (state_mask & group->poll_states)
-			psi_schedule_poll_work(group, 1);
+	if (prev->pid) {
+		psi_flags_change(prev, TSK_ONCPU, 0);
 
-		if (wake_clock && !delayed_work_pending(&group->avgs_work))
-			schedule_delayed_work(&group->avgs_work, PSI_FREQ);
+		iter = NULL;
+		while ((group = iterate_groups(prev, &iter)) && group != common)
+			psi_group_change(group, cpu, TSK_ONCPU, 0, true);
 	}
 }
 
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 6ff0ac1a803f..1339f5bfe513 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -141,14 +141,7 @@ static inline void psi_sched_switch(struct task_struct *prev,
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	/*
-	 * Clear the TSK_ONCPU state if the task was preempted. If
-	 * it's a voluntary sleep, dequeue will have taken care of it.
-	 */
-	if (!sleep)
-		psi_task_change(prev, TSK_ONCPU, 0);
-
-	psi_task_change(next, 0, TSK_ONCPU);
+	psi_task_switch(prev, next, sleep);
 }
 
 static inline void psi_task_tick(struct rq *rq)
-- 
2.25.1

