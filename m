Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46F9C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21A720739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbgCTM6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:58:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35678 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgCTM6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:58:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFHEO-0003qC-Tw; Fri, 20 Mar 2020 13:58:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 818E21C22BE;
        Fri, 20 Mar 2020 13:58:32 +0100 (CET)
Date:   Fri, 20 Mar 2020 12:58:32 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Teach lockdep about "USED" <- "IN-NMI"
 inversions
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200221134215.090538203@infradead.org>
References: <20200221134215.090538203@infradead.org>
MIME-Version: 1.0
Message-ID: <158470911222.28353.8162149870972354694.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f6f48e18040402136874a6a71611e081b4d0788a
Gitweb:        https://git.kernel.org/tip/f6f48e18040402136874a6a71611e081b4d0788a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 20 Feb 2020 09:45:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Mar 2020 13:06:25 +01:00

lockdep: Teach lockdep about "USED" <- "IN-NMI" inversions

nmi_enter() does lockdep_off() and hence lockdep ignores everything.

And NMI context makes it impossible to do full IN-NMI tracking like we
do IN-HARDIRQ, that could result in graph_lock recursion.

However, since look_up_lock_class() is lockless, we can find the class
of a lock that has prior use and detect IN-NMI after USED, just not
USED after IN-NMI.

NOTE: By shifting the lockdep_off() recursion count to bit-16, we can
easily differentiate between actual recursion and off.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Link: https://lkml.kernel.org/r/20200221134215.090538203@infradead.org
---
 kernel/locking/lockdep.c | 62 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 47e3acb..4c3b1cc 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -393,15 +393,22 @@ void lockdep_init_task(struct task_struct *task)
 	task->lockdep_recursion = 0;
 }
 
+/*
+ * Split the recrursion counter in two to readily detect 'off' vs recursion.
+ */
+#define LOCKDEP_RECURSION_BITS	16
+#define LOCKDEP_OFF		(1U << LOCKDEP_RECURSION_BITS)
+#define LOCKDEP_RECURSION_MASK	(LOCKDEP_OFF - 1)
+
 void lockdep_off(void)
 {
-	current->lockdep_recursion++;
+	current->lockdep_recursion += LOCKDEP_OFF;
 }
 EXPORT_SYMBOL(lockdep_off);
 
 void lockdep_on(void)
 {
-	current->lockdep_recursion--;
+	current->lockdep_recursion -= LOCKDEP_OFF;
 }
 EXPORT_SYMBOL(lockdep_on);
 
@@ -597,6 +604,7 @@ static const char *usage_str[] =
 #include "lockdep_states.h"
 #undef LOCKDEP_STATE
 	[LOCK_USED] = "INITIAL USE",
+	[LOCK_USAGE_STATES] = "IN-NMI",
 };
 #endif
 
@@ -809,6 +817,7 @@ static int count_matching_names(struct lock_class *new_class)
 	return count + 1;
 }
 
+/* used from NMI context -- must be lockless */
 static inline struct lock_class *
 look_up_lock_class(const struct lockdep_map *lock, unsigned int subclass)
 {
@@ -4720,6 +4729,36 @@ void lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 }
 EXPORT_SYMBOL_GPL(lock_downgrade);
 
+/* NMI context !!! */
+static void verify_lock_unused(struct lockdep_map *lock, struct held_lock *hlock, int subclass)
+{
+#ifdef CONFIG_PROVE_LOCKING
+	struct lock_class *class = look_up_lock_class(lock, subclass);
+
+	/* if it doesn't have a class (yet), it certainly hasn't been used yet */
+	if (!class)
+		return;
+
+	if (!(class->usage_mask & LOCK_USED))
+		return;
+
+	hlock->class_idx = class - lock_classes;
+
+	print_usage_bug(current, hlock, LOCK_USED, LOCK_USAGE_STATES);
+#endif
+}
+
+static bool lockdep_nmi(void)
+{
+	if (current->lockdep_recursion & LOCKDEP_RECURSION_MASK)
+		return false;
+
+	if (!in_nmi())
+		return false;
+
+	return true;
+}
+
 /*
  * We are not always called with irqs disabled - do that here,
  * and also avoid lockdep recursion:
@@ -4730,8 +4769,25 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 {
 	unsigned long flags;
 
-	if (unlikely(current->lockdep_recursion))
+	if (unlikely(current->lockdep_recursion)) {
+		/* XXX allow trylock from NMI ?!? */
+		if (lockdep_nmi() && !trylock) {
+			struct held_lock hlock;
+
+			hlock.acquire_ip = ip;
+			hlock.instance = lock;
+			hlock.nest_lock = nest_lock;
+			hlock.irq_context = 2; // XXX
+			hlock.trylock = trylock;
+			hlock.read = read;
+			hlock.check = check;
+			hlock.hardirqs_off = true;
+			hlock.references = 0;
+
+			verify_lock_unused(lock, &hlock, subclass);
+		}
 		return;
+	}
 
 	raw_local_irq_save(flags);
 	check_flags(flags);
