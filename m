Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ACDC5ACBF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5212520738
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584037048;
	bh=Hl5xchzWnTmUmJDA9ylXI+yCA+nRbbckYmskZgrnRG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pBtiH9ZBKSZCnap8klt2fXUEuI97r0lfYugFzM4RXCCq/C6lWVm9pe4QaCJx+/nPX
	 O9JyXZ8n1KMem4Tbtge9o7SKCl3HjfGfaP4KIrlwXN7faehuUnD1gB5VVGaebVIfOk
	 8pSUFIKtF4u4gfDqBm7ZELt9w6OKlVlMPJAwkvS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgCLSR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgCLSRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:17:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E66082076F;
        Thu, 12 Mar 2020 18:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584037030;
        bh=Hl5xchzWnTmUmJDA9ylXI+yCA+nRbbckYmskZgrnRG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qC5DF7z0y4f/jmGQDreWy2Z1OJVFJ303SKxwPfcWUItpoIRoqJ5fEyVFxjnIPmcED
         1TnC1WekgWrL/+WSDfLkIdzgcsElHNqv8Muwc23hx5C+6ThXTX6RL+nb6ar0ojBldg
         JoaCHndtBtOTFQAIT2fI4wlea7c6chVlledi/fOQ=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC tip/core/rcu 16/16] rcu-tasks: Add stall warnings for RCU Tasks Trace
Date:   Thu, 12 Mar 2020 11:17:02 -0700
Message-Id: <20200312181702.8443-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200312181618.GA21271@paulmck-ThinkPad-P72>
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds RCU CPU stall warnings for RCU Tasks Trace.  These
dump out any tasks blocking the current grace period, as well as any
CPUs that have not responded to an IPI request.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 5d7bd48..8cffc1c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -788,8 +788,9 @@ static void rcu_tasks_trace_postscan(void)
 
 /* Do one scan of the holdout list. */
 static void check_all_holdout_tasks_trace(struct list_head *hop,
-					  bool ndrpt, bool *frptp)
+					  bool needreport, bool *firstreport)
 {
+	int cpu;
 	struct task_struct *g, *t;
 
 	list_for_each_entry_safe(t, g, hop, trc_holdout_list) {
@@ -799,9 +800,32 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 			trc_wait_for_one_reader(t, hop);
 
 		// If check succeeded, remove this task from the list.
-		if (READ_ONCE(t->trc_reader_checked))
+		if (READ_ONCE(t->trc_reader_checked)) {
 			trc_del_holdout(t);
+			continue;
+		} else if (!needreport) {
+			continue;
+		}
+		if (*firstreport) {
+			pr_err("INFO: rcu_tasks_trace detected stalls on tasks:\n");
+			*firstreport = false;
+		}
+		cpu = task_cpu(t);
+		pr_alert("%p: %c%c%c nesting: %d%c cpu: %d\n",
+			 t,
+			 ".I"[READ_ONCE(t->trc_ipi_to_cpu) > 0],
+			 ".i"[is_idle_task(t)],
+			 "N."[cpu < 0 || !tick_nohz_full_cpu(cpu)],
+			 t->trc_reader_nesting,
+			 " N"[!!t->trc_reader_need_end],
+			 cpu);
+		sched_show_task(t);
 	}
+	if (!needreport)
+		return;
+	for_each_possible_cpu(cpu)
+		if (per_cpu(trc_ipi_to_cpu, cpu))
+			pr_alert("\tIPI outstanding to CPU %d\n", cpu);
 }
 
 /* Wait for grace period to complete and provide ordering. */
-- 
2.9.5

