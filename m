Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510E3C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C73D20637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780771;
	bh=f6MknPqTnSgqIQA4Ugas/2n0Z0E4QRssBfssOC191vc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sWTozAiganGX4MNj/IpRYhuUWAWWxYOi8MjzHRp8o9Ui/VClSN8fkhb8EBwbqFfPx
	 RxwwIlq5b5zDfJQ9iIIf00jA/gZ7n9C0e/+QmT8dqLDVVgHa9gR85NygV7O2+gqafR
	 MSsGDv9F+vzoHx2lGMqi9W6/Fa23HWSJl/0vDqCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgCITGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727466AbgCITEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:04:24 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3A0A227BF;
        Mon,  9 Mar 2020 19:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780663;
        bh=f6MknPqTnSgqIQA4Ugas/2n0Z0E4QRssBfssOC191vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n1FhMvHwY4JXV5uPFobiBB7+prpPnm4k+S3qGgGNPMSn07goyLj8sNhpJNytIQ233
         1RIU1t9HyGblBzRz83xM0T3B5p4iv2AO1V/dJMT7EoMdY96sU9lVjhX4Nh375nIQoe
         fHzcbcr3dx1YR5sdGfTcDi2O1aNbcuipm9GQRxvI=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 04/32] kcsan: Make KCSAN compatible with lockdep
Date:   Mon,  9 Mar 2020 12:03:52 -0700
Message-Id: <20200309190420.6100-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200309190359.GA5822@paulmck-ThinkPad-P72>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

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
-- 
2.9.5

