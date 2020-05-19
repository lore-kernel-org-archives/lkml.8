Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56A7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA45020849
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgESTxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgESTwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:52:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84FAC08C5C0;
        Tue, 19 May 2020 12:52:50 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8I4-0007rj-Tz; Tue, 19 May 2020 21:52:41 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7A1D71C0178;
        Tue, 19 May 2020 21:52:35 +0200 (CEST)
Date:   Tue, 19 May 2020 19:52:35 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] lockdep: Always inline lockdep_{off,on}()
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134101.048523500@linutronix.de>
References: <20200505134101.048523500@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991795538.17951.10475786862594383063.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e616cb8daadf637175af4fe53138a94c190c4816
Gitweb:        https://git.kernel.org/tip/e616cb8daadf637175af4fe53138a94c190c4816
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 24 Feb 2020 22:14:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:51:18 +02:00

lockdep: Always inline lockdep_{off,on}()

These functions are called {early,late} in nmi_{enter,exit} and should
not be traced or probed. They are also puny, so 'inline' them.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Link: https://lkml.kernel.org/r/20200505134101.048523500@linutronix.de


---
 include/linux/lockdep.h  | 23 +++++++++++++++++++++--
 kernel/locking/lockdep.c | 19 -------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 206774a..8fce5c9 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -308,8 +308,27 @@ extern void lockdep_set_selftest_task(struct task_struct *task);
 
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
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index ac10db6..6f1c8cb 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -393,25 +393,6 @@ void lockdep_init_task(struct task_struct *task)
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
