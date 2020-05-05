Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4DFC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3626820836
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729552AbgEEOOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729324AbgEEOOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:14:15 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4DCC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:14:15 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyKV-0000jt-LI; Tue, 05 May 2020 16:13:51 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 192C0FFC8D;
        Tue,  5 May 2020 16:13:51 +0200 (CEST)
Message-Id: <20200505134101.048523500@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:32 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V4 part 1 30/36] lockdep: Always inline lockdep_{off,on}()
References: <20200505131602.633487962@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

These functions are called {early,late} in nmi_{enter,exit} and should
not be traced or probed. They are also puny, so 'inline' them.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/lockdep.h  |   23 +++++++++++++++++++++--
 kernel/locking/lockdep.c |   19 -------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -308,8 +308,27 @@ extern void lockdep_set_selftest_task(st
 
 extern void lockdep_init_task(struct task_struct *task);
 
-extern void lockdep_off(void);
-extern void lockdep_on(void);
+/*
+ * Split the recrursion counter in two to readily detect 'off' vs recursion.
+ */
+#define LOCKDEP_RECURSION_BITS	16
+#define LOCKDEP_OFF		(1U << LOCKDEP_RECURSION_BITS)
+#define LOCKDEP_RECURSION_MASK	(LOCKDEP_OFF - 1)
+
+/*
+ * lockdep_{off,on}() are macros to avoid tracing and kprobes; not inlines due
+ * to header dependencies.
+ */
+
+#define lockdep_off()					\
+do {							\
+	current->lockdep_recursion += LOCKDEP_OFF;	\
+} while (0)
+
+#define lockdep_on()					\
+do {							\
+	current->lockdep_recursion -= LOCKDEP_OFF;	\
+} while (0)
 
 extern void lockdep_register_key(struct lock_class_key *key);
 extern void lockdep_unregister_key(struct lock_class_key *key);
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -393,25 +393,6 @@ void lockdep_init_task(struct task_struc
 	task->lockdep_recursion = 0;
 }
 
-/*
- * Split the recrursion counter in two to readily detect 'off' vs recursion.
- */
-#define LOCKDEP_RECURSION_BITS	16
-#define LOCKDEP_OFF		(1U << LOCKDEP_RECURSION_BITS)
-#define LOCKDEP_RECURSION_MASK	(LOCKDEP_OFF - 1)
-
-void lockdep_off(void)
-{
-	current->lockdep_recursion += LOCKDEP_OFF;
-}
-EXPORT_SYMBOL(lockdep_off);
-
-void lockdep_on(void)
-{
-	current->lockdep_recursion -= LOCKDEP_OFF;
-}
-EXPORT_SYMBOL(lockdep_on);
-
 static inline void lockdep_recursion_finish(void)
 {
 	if (WARN_ON_ONCE(--current->lockdep_recursion))

