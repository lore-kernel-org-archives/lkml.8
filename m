Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C84C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7560215A4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 20:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="sCh1p/sI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCJUVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 16:21:11 -0400
Received: from mail.efficios.com ([167.114.26.124]:46260 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgCJUVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 16:21:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id ACBBF272E37;
        Tue, 10 Mar 2020 16:21:09 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6QBRYl5TmVUS; Tue, 10 Mar 2020 16:21:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6C256272E36;
        Tue, 10 Mar 2020 16:21:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6C256272E36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583871667;
        bh=n360acFerpRQ3K2nmTTFfkxk9piJlk5016zKlRB/rOg=;
        h=From:To:Date:Message-Id;
        b=sCh1p/sIJsMNZ8qweim7YQUSfN1aA5wbiIaTnDUUZRASH1kV6/t+zFHdW+p5E5CmL
         ciUbBnE96BEoLKLgyQzy8dVj7N2L2cxKyB+N8YkEwPtMLPtX8QUwdBG+GykctRn2P8
         nwgQqDYeJRKVD9PsK+x4ps7n9vxhVXZCyR6/FnLqvP5wKi0pejWL1ARHHGOYlPX4vM
         xUSmey1zaBKrW18x1Df6iv3+R7kXPKlAWSbMxwRdUhJGEcPJSkLariZRV31HYEqdTt
         748Dr2fZNSUUuyAOpahf2nsvO3Og+BKlZ9bijkykt3rIuagdU0T/ka+hn4bbUdVKsd
         795bkRb4oUJUg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 52sGQ0iV__2c; Tue, 10 Mar 2020 16:21:07 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id E19A8272CE5;
        Tue, 10 Mar 2020 16:21:06 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] tracepoint: rcuidle: use rcu_is_watching() and tree-rcu
Date:   Tue, 10 Mar 2020 16:20:54 -0400
Message-Id: <20200310202054.5880-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use
SRCU") aimed at improving performance of rcuidle tracepoints by using
SRCU rather than temporarily enabling tree-rcu every time.

commit 865e63b04e9b ("tracing: Add back in rcu_irq_enter/exit_irqson()
for rcuidle tracepoints") adds back the high-overhead enabling of
tree-rcu because perf expects RCU to be watching when called from
rcuidle tracepoints.

It turns out that by using "rcu_is_watching()" and conditionally
calling the high-overhead rcu_irq_enter/exit_irqson(), the original
motivation for using SRCU in the first place disappears.

I suspect that the original benchmarks justifying the introduction
of SRCU to handle rcuidle tracepoints was caused by preempt/irq
tracepoints, which are typically invoked from contexts that have
RCU watching.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Joel Fernandes <joel@joelfernandes.org>
CC: "Paul E. McKenney" <paulmck@kernel.org>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Frederic Weisbecker <fweisbec@gmail.com>
CC: Ingo Molnar <mingo@kernel.org>
---
 include/linux/tracepoint.h | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 1fb11daa5c53..8e0e94fee29a 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -165,25 +165,22 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		void *it_func;						\
 		void *__data;						\
 		int __maybe_unused __idx = 0;				\
+		bool __exit_rcu = false;				\
 									\
 		if (!(cond))						\
 			return;						\
 									\
-		/* srcu can't be used from NMI */			\
-		WARN_ON_ONCE(rcuidle && in_nmi());			\
-									\
-		/* keep srcu and sched-rcu usage consistent */		\
-		preempt_disable_notrace();				\
-									\
 		/*							\
-		 * For rcuidle callers, use srcu since sched-rcu	\
-		 * doesn't work from the idle path.			\
+		 * For rcuidle callers, temporarily enable RCU if	\
+		 * it is not currently watching.			\
 		 */							\
-		if (rcuidle) {						\
-			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
+		if (rcuidle && !rcu_is_watching()) {			\
 			rcu_irq_enter_irqson();				\
+			__exit_rcu = true;				\
 		}							\
 									\
+		preempt_disable_notrace();				\
+									\
 		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
 									\
 		if (it_func_ptr) {					\
@@ -194,12 +191,10 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			} while ((++it_func_ptr)->func);		\
 		}							\
 									\
-		if (rcuidle) {						\
-			rcu_irq_exit_irqson();				\
-			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
-		}							\
-									\
 		preempt_enable_notrace();				\
+									\
+		if (__exit_rcu)						\
+			rcu_irq_exit_irqson();				\
 	} while (0)
 
 #ifndef MODULE
-- 
2.17.1

