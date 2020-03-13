Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D91C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E402B20724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgCMRr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:47:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47718 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgCMRrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:47:22 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jCoP1-00017r-Bs; Fri, 13 Mar 2020 18:47:19 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/9] sched/swait: Prepare usage in completions
Date:   Fri, 13 Mar 2020 18:46:56 +0100
Message-Id: <20200313174701.148376-5-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313174701.148376-1-bigeasy@linutronix.de>
References: <20200313174701.148376-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

As a preparation to use simple wait queues for completions:

  - Provide swake_up_all_locked() to support complete_all()
  - Make __prepare_to_swait() public available

This is done to enable the usage of complete() within truly atomic contexts
on a PREEMPT_RT enabled kernel.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/sched.h | 3 +++
 kernel/sched/swait.c | 8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9ea647835fd6f..fdc77e7963242 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2492,3 +2492,6 @@ static inline bool is_per_cpu_kthread(struct task_str=
uct *p)
 	return true;
 }
 #endif
+
+void swake_up_all_locked(struct swait_queue_head *q);
+void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wa=
it);
diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
index e83a3f8449f65..c528f238c68d6 100644
--- a/kernel/sched/swait.c
+++ b/kernel/sched/swait.c
@@ -32,6 +32,12 @@ void swake_up_locked(struct swait_queue_head *q)
 }
 EXPORT_SYMBOL(swake_up_locked);
=20
+void swake_up_all_locked(struct swait_queue_head *q)
+{
+	while (!list_empty(&q->task_list))
+		swake_up_locked(q);
+}
+
 void swake_up_one(struct swait_queue_head *q)
 {
 	unsigned long flags;
@@ -69,7 +75,7 @@ void swake_up_all(struct swait_queue_head *q)
 }
 EXPORT_SYMBOL(swake_up_all);
=20
-static void __prepare_to_swait(struct swait_queue_head *q, struct swait_qu=
eue *wait)
+void __prepare_to_swait(struct swait_queue_head *q, struct swait_queue *wa=
it)
 {
 	wait->task =3D current;
 	if (list_empty(&wait->task_list))
--=20
2.25.1

