Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006B6C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF46C205CB
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="P3cbT+5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgHOWBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgHOVvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:33 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCF3C06137B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:34 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p4so10241977qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jOuJJ23oEouPSGg3lZDZzJM6phxa5MifEp0ZsmuPH0A=;
        b=P3cbT+5ibY0DarOGRd8+2HzKTmoLWqb9/Qp47CMqSclIzbGT9hbhvUuTT/lH20T0vD
         pzf2wmWRPH4Nw5sPERqFv/fkMj3kSTmYwCpzfKaz+DbnAafQBQIE4etQbvbITbT7IA5Y
         7VOuQanq3Pq5EoJ5jgJoDluGf06TyjduSX2zM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jOuJJ23oEouPSGg3lZDZzJM6phxa5MifEp0ZsmuPH0A=;
        b=aFh43ZOtio3w7/GsmwWphjEjyelaCbtekcpC/wYVw2RhtM1LP10mrPgtijHthBiL+P
         ak3tu5FWrWgrfV+aIkWpzqPf816CBY+1fg/Fjotd+EvfXzgnfnShP3Od4TEm1t4YlbJq
         nxqHQs9CUCccbw5uE9TxztNcq1yrbJ6mDha7vIWSevQFqkkCwzQ4vPY6j8CNQMe/Bh9x
         r8Ye8Q1owm/LM0FboG+WVnmRsLrnmKXAlvWXT3L+Vfj09vyBDzjPifvJFW4/ntW55Mmr
         /ceDqyfUfPlKH7PG5erInoNEdPrTQEfDqcOcoZYzkh2UK0P85F/BiILKzNX4sBtiDr9J
         4eXA==
X-Gm-Message-State: AOAM532ozqjwkV94Ax0Lb2OFslAfycOlHrLxjfKpTpcUKjXhBL9jICVS
        Qbo3WFfeF+JcY55r/t185w0WgEb3maEDKg==
X-Google-Smtp-Source: ABdhPJyij8tgW3i5iZqmsC/3Zvp1hPrbEHSFfhIMEYnyV4Fj7iVBzrldWwJbpxlVXcBf17ot9llazQ==
X-Received: by 2002:a37:6583:: with SMTP id z125mr4698518qkb.297.1597461573799;
        Fri, 14 Aug 2020 20:19:33 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id p12sm10055199qkk.118.2020.08.14.20.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 20:19:33 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        fweisbec@gmail.com, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH RFC 10/12] sched/coresched: Make core_pick_seq per run-queue
Date:   Fri, 14 Aug 2020 23:19:06 -0400
Message-Id: <20200815031908.1015049-11-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200815031908.1015049-1-joel@joelfernandes.org>
References: <20200815031908.1015049-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <viremana@linux.microsoft.com>

core_pick_seq is a core wide counter to identify if a task pick has
been made for a CPU by its sibling. But during hotplug scenarios,
pick cannot be made for CPUs that are offline and when they come up,
they get tricked because the counter is incremented.

So, make core_pick_seq per run-queue.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c  | 19 ++++++++++---------
 kernel/sched/sched.h |  2 +-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3e9df8221c62..48a49168e57f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4623,9 +4623,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	 * pointers are all still valid), and we haven't scheduled the last
 	 * pick yet, do so now.
 	 */
-	if (rq->core->core_pick_seq == rq->core->core_task_seq &&
-	    rq->core->core_pick_seq != rq->core_sched_seq) {
-		WRITE_ONCE(rq->core_sched_seq, rq->core->core_pick_seq);
+	if (rq->core_pick_seq == rq->core->core_task_seq &&
+	    rq->core_pick_seq != rq->core_sched_seq) {
+		WRITE_ONCE(rq->core_sched_seq, rq->core_pick_seq);
 
 		next = rq->core_pick;
 		if (next != prev) {
@@ -4635,7 +4635,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 		trace_printk("pick pre selected (%u %u %u): %s/%d %lx\n",
 			     rq->core->core_task_seq,
-			     rq->core->core_pick_seq,
+			     rq->core_pick_seq,
 			     rq->core_sched_seq,
 			     next->comm, next->pid,
 			     next->core_cookie);
@@ -4649,7 +4649,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	smt_mask = cpu_smt_mask(cpu);
 
 	/*
-	 * core->core_task_seq, core->core_pick_seq, rq->core_sched_seq
+	 * core->core_task_seq, rq->core_pick_seq, rq->core_sched_seq
 	 *
 	 * @task_seq guards the task state ({en,de}queues)
 	 * @pick_seq is the @task_seq we did a selection on
@@ -4667,8 +4667,10 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		struct rq *rq_i = cpu_rq(i);
 
 		trace_printk("CPU %d is in smt_mask, resetting\n", i);
-
-		rq_i->core_pick = NULL;
+		if (rq_i->core_pick) {
+			WRITE_ONCE(rq_i->core_sched_seq, rq_i->core_pick_seq);
+			rq_i->core_pick = NULL;
+		}
 
 		if (rq_i->core_forceidle) {
 			need_sync = true;
@@ -4771,9 +4773,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 next_class:;
 	}
 
-	rq->core->core_pick_seq = rq->core->core_task_seq;
 	next = rq->core_pick;
-	rq->core_sched_seq = rq->core->core_pick_seq;
 
 	/* Something should have been selected for current CPU */
 	WARN_ON_ONCE(!next);
@@ -4801,6 +4801,7 @@ next_class:;
 			continue;
 
 		if (rq_i->curr != rq_i->core_pick) {
+			WRITE_ONCE(rq_i->core_pick_seq, rq->core->core_task_seq);
 			trace_printk("IPI(%d)\n", i);
 			resched_curr(rq_i);
 		}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2922e171a1f0..c7caece2df6e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1036,6 +1036,7 @@ struct rq {
 	/* per rq */
 	struct rq		*core;
 	struct task_struct	*core_pick;
+	unsigned int		core_pick_seq;
 	unsigned int		core_enabled;
 	unsigned int		core_sched_seq;
 	struct rb_root		core_tree;
@@ -1045,7 +1046,6 @@ struct rq {
 
 	/* shared state */
 	unsigned int		core_task_seq;
-	unsigned int		core_pick_seq;
 	unsigned long		core_cookie;
 	unsigned int		core_unsafe_nest;
 #endif
-- 
2.28.0.220.ged08abb693-goog

