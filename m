Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA27C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3BD2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgCXJLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:11:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43812 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgCXJLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:11:15 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfaY-0007ar-Lu; Tue, 24 Mar 2020 10:11:11 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 64ECD1C0494;
        Tue, 24 Mar 2020 10:11:02 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:11:02 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Make KCSAN compatible with lockdep
Cc:     Qian Cai <cai@lca.pw>, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504106206.28353.16599171054625932884.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     f1bc96210c6a6b853b4b2eec808141956e8fbc5d
Gitweb:        https://git.kernel.org/tip/f1bc96210c6a6b853b4b2eec808141956e8fbc5d
Author:        Marco Elver <elver@google.com>
AuthorDate:    Wed, 15 Jan 2020 17:25:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 21 Mar 2020 09:41:16 +01:00

kcsan: Make KCSAN compatible with lockdep

We must avoid any recursion into lockdep if KCSAN is enabled on utilities
used by lockdep. One manifestation of this is corruption of lockdep's
IRQ trace state (if TRACE_IRQFLAGS), resulting in spurious warnings
(see below).  This commit fixes this by:

1. Using raw_local_irq{save,restore} in kcsan_setup_watchpoint().
2. Disabling lockdep in kcsan_report().

Tested with:

  CONFIG_LOCKDEP=y
  CONFIG_DEBUG_LOCKDEP=y
  CONFIG_TRACE_IRQFLAGS=y

This fix eliminates spurious warnings such as the following one:

    WARNING: CPU: 0 PID: 2 at kernel/locking/lockdep.c:4406 check_flags.part.0+0x101/0x220
    Modules linked in:
    CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.5.0-rc1+ #11
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
    RIP: 0010:check_flags.part.0+0x101/0x220
    <snip>
    Call Trace:
     lock_is_held_type+0x69/0x150
     freezer_fork+0x20b/0x370
     cgroup_post_fork+0x2c9/0x5c0
     copy_process+0x2675/0x3b40
     _do_fork+0xbe/0xa30
     ? _raw_spin_unlock_irqrestore+0x40/0x50
     ? match_held_lock+0x56/0x250
     ? kthread_park+0xf0/0xf0
     kernel_thread+0xa6/0xd0
     ? kthread_park+0xf0/0xf0
     kthreadd+0x321/0x3d0
     ? kthread_create_on_cpu+0x130/0x130
     ret_from_fork+0x3a/0x50
    irq event stamp: 64
    hardirqs last  enabled at (63): [<ffffffff9a7995d0>] _raw_spin_unlock_irqrestore+0x40/0x50
    hardirqs last disabled at (64): [<ffffffff992a96d2>] kcsan_setup_watchpoint+0x92/0x460
    softirqs last  enabled at (32): [<ffffffff990489b8>] fpu__copy+0xe8/0x470
    softirqs last disabled at (30): [<ffffffff99048939>] fpu__copy+0x69/0x470

Reported-by: Qian Cai <cai@lca.pw>
Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Alexander Potapenko <glider@google.com>
Tested-by: Qian Cai <cai@lca.pw>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/kcsan/core.c     |  6 ++++--
 kernel/kcsan/report.c   | 11 +++++++++++
 kernel/locking/Makefile |  3 +++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 87bf857..64b30f7 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -336,8 +336,10 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 *      CPU-local data accesses), it makes more sense (from a data race
 	 *      detection point of view) to simply disable preemptions to ensure
 	 *      as many tasks as possible run on other CPUs.
+	 *
+	 * Use raw versions, to avoid lockdep recursion via IRQ flags tracing.
 	 */
-	local_irq_save(irq_flags);
+	raw_local_irq_save(irq_flags);
 
 	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
 	if (watchpoint == NULL) {
@@ -429,7 +431,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 
 	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
 out_unlock:
-	local_irq_restore(irq_flags);
+	raw_local_irq_restore(irq_flags);
 out:
 	user_access_restore(ua_flags);
 }
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index b5b4fee..33bdf8b 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -2,6 +2,7 @@
 
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
+#include <linux/lockdep.h>
 #include <linux/preempt.h>
 #include <linux/printk.h>
 #include <linux/sched.h>
@@ -410,6 +411,14 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 {
 	unsigned long flags = 0;
 
+	/*
+	 * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
+	 * we do not turn off lockdep here; this could happen due to recursion
+	 * into lockdep via KCSAN if we detect a data race in utilities used by
+	 * lockdep.
+	 */
+	lockdep_off();
+
 	kcsan_disable_current();
 	if (prepare_report(&flags, ptr, size, access_type, cpu_id, type)) {
 		if (print_report(ptr, size, access_type, value_change, cpu_id, type) && panic_on_warn)
@@ -418,4 +427,6 @@ void kcsan_report(const volatile void *ptr, size_t size, int access_type,
 		release_report(&flags, type);
 	}
 	kcsan_enable_current();
+
+	lockdep_on();
 }
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 45452fa..6d11cfb 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -5,6 +5,9 @@ KCOV_INSTRUMENT		:= n
 
 obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
 
+# Avoid recursion lockdep -> KCSAN -> ... -> lockdep.
+KCSAN_SANITIZE_lockdep.o := n
+
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_lockdep_proc.o = $(CC_FLAGS_FTRACE)
