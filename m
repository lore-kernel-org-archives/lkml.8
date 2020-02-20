Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1395C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6C2206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dn4hLPZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgBTOQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:16:04 -0500
Received: from mail-wr1-f74.google.com ([209.85.221.74]:55100 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgBTOQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:16:04 -0500
Received: by mail-wr1-f74.google.com with SMTP id s13so1787738wrb.21
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 06:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KvrVRvnTainfLUNEVicj5vB+FMWhRD8P5T9JfeiRjxw=;
        b=Dn4hLPZzP4Wq+3lQKKQDzCrXFsLroOr2keN+yERs6KPoFLjyLqYD9MyCCNxPx6gPq3
         1YffiJE8nHIyAJ3zk5A52BJ+9jwupFPXaSNowIRuI3SHBncKdRaUUfHD51x5o6d3IvUt
         sSqvak99GeOt5ydDAsT8V5MkH09/XfcpE/xdpKF3bgLKdjGFUXFQ2CATGLBfAitSJpjU
         Uq8Vjt6WPB/SHhir+wAFH2p8YuQBf1w2BJx3Y4aUscSuQVDyl8Cp5m0fQuXp84uCIJxD
         2oz9kBiLHoJqLETVJ/nPs9KHUIfyLujXC34c5ZOp+EbWRoU5Q0s/AsS0Jh9BiC7hSU1k
         4KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KvrVRvnTainfLUNEVicj5vB+FMWhRD8P5T9JfeiRjxw=;
        b=iZX7ucZcUFBXrNTeVDLSSUJILDODR6Ge9kkJXdfuFGeIKTip51KAUHMCQR5wcNFvDC
         Qa6jaiKoI2fzmvxcME8Rvq68mOp8143pBIBRsNk9GxLyE2z5aczLOHl7CZGJsZjFeoeJ
         Pzf0pyTHYLQ3dbeFYF6g/y56iKiIAAhmHisZyvxKY/L1VrvStZdINkbRw9Ykw6iUMLM0
         4qwt1atsGWW/nvKuvPtWY7xfyiT47BTlwlf1PXoz4K85C6P/NzPG+w63iE/pbSP8YDPn
         rPkne5S/MXcxofqG0z/T0JMawPuCYD/oagjNyJ8wBr0DTowqXIQkwEjYwcPLuoM9C8Hy
         1Y4w==
X-Gm-Message-State: APjAAAXXIcSWdlckHs77HyD2WEN3e1yrQ0+PTn4V3oZUD+AbDzQH0Lcl
        AmJACWOCkagYB0I8vUWc1gP8487JGA==
X-Google-Smtp-Source: APXvYqyndiE2Em6oOXX0sfHnwiPxmpukYQXNV9O1aK2cKl3XVtom1sjmQen61bnVokyLg/fsSIvm3DV7Mg==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr40898485wro.234.1582208159510;
 Thu, 20 Feb 2020 06:15:59 -0800 (PST)
Date:   Thu, 20 Feb 2020 15:15:51 +0100
Message-Id: <20200220141551.166537-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] kcsan: Add option to allow watcher interruptions
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add option to allow interrupts while a watchpoint is set up. This can be
enabled either via CONFIG_KCSAN_INTERRUPT_WATCHER or via the boot
parameter 'kcsan.interrupt_watcher=1'.

Note that, currently not all safe per-CPU access primitives and patterns
are accounted for, which could result in false positives. For example,
asm-generic/percpu.h uses plain operations, which by default are
instrumented. On interrupts and subsequent accesses to the same
variable, KCSAN would currently report a data race with this option.

Therefore, this option should currently remain disabled by default, but
may be enabled for specific test scenarios.

Signed-off-by: Marco Elver <elver@google.com>
---

As an example, the first data race that this found:

write to 0xffff88806b3324b8 of 4 bytes by interrupt on cpu 0:
 rcu_preempt_read_enter kernel/rcu/tree_plugin.h:353 [inline]
 __rcu_read_lock+0x3c/0x50 kernel/rcu/tree_plugin.h:373
 rcu_read_lock include/linux/rcupdate.h:599 [inline]
 cpuacct_charge+0x36/0x80 kernel/sched/cpuacct.c:347
 cgroup_account_cputime include/linux/cgroup.h:773 [inline]
 update_curr+0xe2/0x1d0 kernel/sched/fair.c:860
 enqueue_entity+0x130/0x5d0 kernel/sched/fair.c:4005
 enqueue_task_fair+0xb0/0x420 kernel/sched/fair.c:5260
 enqueue_task kernel/sched/core.c:1302 [inline]
 activate_task+0x6d/0x110 kernel/sched/core.c:1324
 ttwu_do_activate.isra.0+0x40/0x60 kernel/sched/core.c:2266
 ttwu_queue kernel/sched/core.c:2411 [inline]
 try_to_wake_up+0x3be/0x6c0 kernel/sched/core.c:2645
 wake_up_process+0x10/0x20 kernel/sched/core.c:2669
 hrtimer_wakeup+0x4c/0x60 kernel/time/hrtimer.c:1769
 __run_hrtimer kernel/time/hrtimer.c:1517 [inline]
 __hrtimer_run_queues+0x274/0x5f0 kernel/time/hrtimer.c:1579
 hrtimer_interrupt+0x22d/0x490 kernel/time/hrtimer.c:1641
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1119 [inline]
 smp_apic_timer_interrupt+0xdc/0x280 arch/x86/kernel/apic/apic.c:1144
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
 delay_tsc+0x38/0xc0 arch/x86/lib/delay.c:68                   <--- interrupt while delayed
 __delay arch/x86/lib/delay.c:161 [inline]
 __const_udelay+0x33/0x40 arch/x86/lib/delay.c:175
 __udelay+0x10/0x20 arch/x86/lib/delay.c:181
 kcsan_setup_watchpoint+0x17f/0x400 kernel/kcsan/core.c:428
 check_access kernel/kcsan/core.c:550 [inline]
 __tsan_read4+0xc6/0x100 kernel/kcsan/core.c:685               <--- Enter KCSAN runtime
 rcu_preempt_read_enter kernel/rcu/tree_plugin.h:353 [inline]  <---+
 __rcu_read_lock+0x2a/0x50 kernel/rcu/tree_plugin.h:373            |
 rcu_read_lock include/linux/rcupdate.h:599 [inline]               |
 lock_page_memcg+0x31/0x110 mm/memcontrol.c:1972                   |
                                                                   |
read to 0xffff88806b3324b8 of 4 bytes by task 6131 on cpu 0:       |
 rcu_preempt_read_enter kernel/rcu/tree_plugin.h:353 [inline]  ----+
 __rcu_read_lock+0x2a/0x50 kernel/rcu/tree_plugin.h:373
 rcu_read_lock include/linux/rcupdate.h:599 [inline]
 lock_page_memcg+0x31/0x110 mm/memcontrol.c:1972

The writer is doing 'current->rcu_read_lock_nesting++'. The read is as
vulnerable to compiler optimizations and would therefore conclude this
is a valid data race.
---
 kernel/kcsan/core.c | 30 ++++++++----------------------
 lib/Kconfig.kcsan   | 11 +++++++++++
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 589b1e7f0f253..43eb5f850c68e 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -21,6 +21,7 @@ static bool kcsan_early_enable = IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE);
 static unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
 static unsigned int kcsan_udelay_interrupt = CONFIG_KCSAN_UDELAY_INTERRUPT;
 static long kcsan_skip_watch = CONFIG_KCSAN_SKIP_WATCH;
+static bool kcsan_interrupt_watcher = IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER);
 
 #ifdef MODULE_PARAM_PREFIX
 #undef MODULE_PARAM_PREFIX
@@ -30,6 +31,7 @@ module_param_named(early_enable, kcsan_early_enable, bool, 0);
 module_param_named(udelay_task, kcsan_udelay_task, uint, 0644);
 module_param_named(udelay_interrupt, kcsan_udelay_interrupt, uint, 0644);
 module_param_named(skip_watch, kcsan_skip_watch, long, 0644);
+module_param_named(interrupt_watcher, kcsan_interrupt_watcher, bool, 0444);
 
 bool kcsan_enabled;
 
@@ -354,7 +356,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	unsigned long access_mask;
 	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
 	unsigned long ua_flags = user_access_save();
-	unsigned long irq_flags;
+	unsigned long irq_flags = 0;
 
 	/*
 	 * Always reset kcsan_skip counter in slow-path to avoid underflow; see
@@ -370,26 +372,9 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 		goto out;
 	}
 
-	/*
-	 * Disable interrupts & preemptions to avoid another thread on the same
-	 * CPU accessing memory locations for the set up watchpoint; this is to
-	 * avoid reporting races to e.g. CPU-local data.
-	 *
-	 * An alternative would be adding the source CPU to the watchpoint
-	 * encoding, and checking that watchpoint-CPU != this-CPU. There are
-	 * several problems with this:
-	 *   1. we should avoid stealing more bits from the watchpoint encoding
-	 *      as it would affect accuracy, as well as increase performance
-	 *      overhead in the fast-path;
-	 *   2. if we are preempted, but there *is* a genuine data race, we
-	 *      would *not* report it -- since this is the common case (vs.
-	 *      CPU-local data accesses), it makes more sense (from a data race
-	 *      detection point of view) to simply disable preemptions to ensure
-	 *      as many tasks as possible run on other CPUs.
-	 *
-	 * Use raw versions, to avoid lockdep recursion via IRQ flags tracing.
-	 */
-	raw_local_irq_save(irq_flags);
+	if (!kcsan_interrupt_watcher)
+		/* Use raw to avoid lockdep recursion via IRQ flags tracing. */
+		raw_local_irq_save(irq_flags);
 
 	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
 	if (watchpoint == NULL) {
@@ -524,7 +509,8 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 
 	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
 out_unlock:
-	raw_local_irq_restore(irq_flags);
+	if (!kcsan_interrupt_watcher)
+		raw_local_irq_restore(irq_flags);
 out:
 	user_access_restore(ua_flags);
 }
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index ba9268076cfbc..0f1447ff8f558 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -101,6 +101,17 @@ config KCSAN_SKIP_WATCH_RANDOMIZE
 	  KCSAN_WATCH_SKIP. If false, the chosen value is always
 	  KCSAN_WATCH_SKIP.
 
+config KCSAN_INTERRUPT_WATCHER
+	bool "Interruptible watchers"
+	help
+	  If enabled, a task that set up a watchpoint may be interrupted while
+	  delayed. This option will allow KCSAN to detect races between
+	  interrupted tasks and other threads of execution on the same CPU.
+
+	  Currently disabled by default, because not all safe per-CPU access
+	  primitives and patterns may be accounted for, and therefore could
+	  result in false positives.
+
 config KCSAN_REPORT_ONCE_IN_MS
 	int "Duration in milliseconds, in which any given race is only reported once"
 	default 3000
-- 
2.25.0.265.gbab2e86ba0-goog

