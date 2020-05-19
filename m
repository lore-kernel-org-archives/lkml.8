Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC6CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A3FB205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgESVqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgESVqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:46:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C86C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:46:49 -0700 (PDT)
Received: from [5.158.153.53] (helo=debian-buster-darwi.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <a.darwish@linutronix.de>)
        id 1jbA48-0002eg-JX; Tue, 19 May 2020 23:46:24 +0200
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: [PATCH v1 07/25] lockdep: Add preemption disabled assertion API
Date:   Tue, 19 May 2020 23:45:29 +0200
Message-Id: <20200519214547.352050-8-a.darwish@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519214547.352050-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asserting that preemption is disabled is a critical sanity check.
Developers are usually reluctant to add such a check in a fastpath, as
reading the preemption count can be costly.

Extend the lockdep API with a preemption disabled assertion. If lockdep
is disabled, or if the underlying architecture does not support kernel
preemption, this assert has no runtime overhead.

Since the lockdep assertion references sched.h task_struct current,
define it at lockdep.c instead of lockdep.h. This unbinds a potential
circular header dependency chain for call-sites, defined inlined, at
other header files already included and needed by sched.h.

Mark the exported assertion symbol with NOKPROBE_SYMBOL. Lockdep
functions can be involved in breakpoint handling and probing on those
functions can cause a breakpoint recursion.

References: f54bb2ec02c8 ("locking/lockdep: Add IRQs disabled/enabled assertion APIs: ...")
References: 2f43c6022d84 ("kprobes: Prohibit probing on lockdep functions")
Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
---
 include/linux/lockdep.h  |  9 +++++++++
 kernel/locking/lockdep.c | 15 +++++++++++++++
 lib/Kconfig.debug        |  1 +
 3 files changed, 25 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 206774ac6946..54c929ea5b98 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -702,6 +702,14 @@ do {									\
 			  "Not in hardirq as expected\n");		\
 	} while (0)
 
+/*
+ * Don't define this assertion here to avoid a call-site's header file
+ * dependency on sched.h task_struct current. This is needed by call
+ * sites that are inline defined at header files already included by
+ * sched.h.
+ */
+void lockdep_assert_preemption_disabled(void);
+
 #else
 # define might_lock(lock) do { } while (0)
 # define might_lock_read(lock) do { } while (0)
@@ -709,6 +717,7 @@ do {									\
 # define lockdep_assert_irqs_enabled() do { } while (0)
 # define lockdep_assert_irqs_disabled() do { } while (0)
 # define lockdep_assert_in_irq() do { } while (0)
+# define lockdep_assert_preemption_disabled() do { } while (0)
 #endif
 
 #ifdef CONFIG_PROVE_RAW_LOCK_NESTING
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ac10db66cc63..4dae65bc65c2 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5857,3 +5857,18 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 	dump_stack();
 }
 EXPORT_SYMBOL_GPL(lockdep_rcu_suspicious);
+
+#ifdef CONFIG_PROVE_LOCKING
+
+void lockdep_assert_preemption_disabled(void)
+{
+	WARN_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&
+		  debug_locks				&&
+		  !current->lockdep_recursion		&&
+		  (preempt_count() == 0 && current->hardirqs_enabled),
+		  "preemption not disabled as expected\n");
+}
+EXPORT_SYMBOL_GPL(lockdep_assert_preemption_disabled);
+NOKPROBE_SYMBOL(lockdep_assert_preemption_disabled);
+
+#endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 21d9c5f6e7ec..34d9d8896003 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1062,6 +1062,7 @@ config PROVE_LOCKING
 	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
 	select DEBUG_LOCK_ALLOC
+	select PREEMPT_COUNT if !ARCH_NO_PREEMPT
 	select TRACE_IRQFLAGS
 	default n
 	help
-- 
2.20.1

