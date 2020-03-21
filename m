Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C61CC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1CC208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgCUPah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:30:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38870 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgCUPaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:35 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg50-0004wH-So; Sat, 21 Mar 2020 16:30:31 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DF2AB1C22E4;
        Sat, 21 Mar 2020 16:30:29 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:29 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] lockdep: Rename
 trace_{hard,soft}{irq_context,irqs_enabled}()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200320115859.178626842@infradead.org>
References: <20200320115859.178626842@infradead.org>
MIME-Version: 1.0
Message-ID: <158480462951.28353.3034432377742014275.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     ef996916e78e03d25e56c2d372e5e21fdb471882
Gitweb:        https://git.kernel.org/tip/ef996916e78e03d25e56c2d372e5e21fdb471882
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 20 Mar 2020 12:56:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:54 +01:00

lockdep: Rename trace_{hard,soft}{irq_context,irqs_enabled}()

Continue what commit:

  d820ac4c2fa8 ("locking: rename trace_softirq_[enter|exit] => lockdep_softirq_[enter|exit]")

started, rename these to avoid confusing them with tracepoints.

git grep -l "trace_\(soft\|hard\)\(irq_context\|irqs_enabled\)" | while read file;
do
	sed -ie 's/trace_\(soft\|hard\)\(irq_context\|irqs_enabled\)/lockdep_\1\2/g' $file;
done

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20200320115859.178626842@infradead.org

---
 include/linux/irqflags.h       | 16 ++++++++--------
 kernel/locking/lockdep.c       |  8 ++++----
 kernel/softirq.c               |  2 +-
 tools/include/linux/irqflags.h |  8 ++++----
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 7ca1f21..f4c3907 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -31,10 +31,10 @@
 #ifdef CONFIG_TRACE_IRQFLAGS
   extern void trace_hardirqs_on(void);
   extern void trace_hardirqs_off(void);
-# define trace_hardirq_context(p)	((p)->hardirq_context)
-# define trace_softirq_context(p)	((p)->softirq_context)
-# define trace_hardirqs_enabled(p)	((p)->hardirqs_enabled)
-# define trace_softirqs_enabled(p)	((p)->softirqs_enabled)
+# define lockdep_hardirq_context(p)	((p)->hardirq_context)
+# define lockdep_softirq_context(p)	((p)->softirq_context)
+# define lockdep_hardirqs_enabled(p)	((p)->hardirqs_enabled)
+# define lockdep_softirqs_enabled(p)	((p)->softirqs_enabled)
 # define lockdep_hardirq_enter()		\
 do {						\
 	current->hardirq_context++;		\
@@ -54,10 +54,10 @@ do {						\
 #else
 # define trace_hardirqs_on()		do { } while (0)
 # define trace_hardirqs_off()		do { } while (0)
-# define trace_hardirq_context(p)	0
-# define trace_softirq_context(p)	0
-# define trace_hardirqs_enabled(p)	0
-# define trace_softirqs_enabled(p)	0
+# define lockdep_hardirq_context(p)	0
+# define lockdep_softirq_context(p)	0
+# define lockdep_hardirqs_enabled(p)	0
+# define lockdep_softirqs_enabled(p)	0
 # define lockdep_hardirq_enter()	do { } while (0)
 # define lockdep_hardirq_exit()		do { } while (0)
 # define lockdep_softirq_enter()	do { } while (0)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 26ef412..4075e3e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3081,10 +3081,10 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 
 	pr_warn("%s/%d [HC%u[%lu]:SC%u[%lu]:HE%u:SE%u] takes:\n",
 		curr->comm, task_pid_nr(curr),
-		trace_hardirq_context(curr), hardirq_count() >> HARDIRQ_SHIFT,
-		trace_softirq_context(curr), softirq_count() >> SOFTIRQ_SHIFT,
-		trace_hardirqs_enabled(curr),
-		trace_softirqs_enabled(curr));
+		lockdep_hardirq_context(curr), hardirq_count() >> HARDIRQ_SHIFT,
+		lockdep_softirq_context(curr), softirq_count() >> SOFTIRQ_SHIFT,
+		lockdep_hardirqs_enabled(curr),
+		lockdep_softirqs_enabled(curr));
 	print_lock(this);
 
 	pr_warn("{%s} state was registered at:\n", usage_str[prev_bit]);
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 0112ca0..a47c6dd 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -224,7 +224,7 @@ static inline bool lockdep_softirq_start(void)
 {
 	bool in_hardirq = false;
 
-	if (trace_hardirq_context(current)) {
+	if (lockdep_hardirq_context(current)) {
 		in_hardirq = true;
 		lockdep_hardirq_exit();
 	}
diff --git a/tools/include/linux/irqflags.h b/tools/include/linux/irqflags.h
index ced6f64..67e01bb 100644
--- a/tools/include/linux/irqflags.h
+++ b/tools/include/linux/irqflags.h
@@ -2,10 +2,10 @@
 #ifndef _LIBLOCKDEP_LINUX_TRACE_IRQFLAGS_H_
 #define _LIBLOCKDEP_LINUX_TRACE_IRQFLAGS_H_
 
-# define trace_hardirq_context(p)	0
-# define trace_softirq_context(p)	0
-# define trace_hardirqs_enabled(p)	0
-# define trace_softirqs_enabled(p)	0
+# define lockdep_hardirq_context(p)	0
+# define lockdep_softirq_context(p)	0
+# define lockdep_hardirqs_enabled(p)	0
+# define lockdep_softirqs_enabled(p)	0
 # define lockdep_hardirq_enter()	do { } while (0)
 # define lockdep_hardirq_exit()		do { } while (0)
 # define lockdep_softirq_enter()	do { } while (0)
