Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EFEC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0273924679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgAOKBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:01:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46650 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729531AbgAOKBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:01:31 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irfUM-0000Lk-5Y; Wed, 15 Jan 2020 11:01:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C8B711C007F;
        Wed, 15 Jan 2020 11:01:25 +0100 (CET)
Date:   Wed, 15 Jan 2020 10:01:25 -0000
From:   "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] tick/sched: Annotate lockless access to
 last_jiffies_update
Cc:     syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191205045619.204946-1-edumazet@google.com>
References: <20191205045619.204946-1-edumazet@google.com>
MIME-Version: 1.0
Message-ID: <157908248558.396.7267259557005986547.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     de95a991bb72e009f47e0c4bbc90fc5f594588d5
Gitweb:        https://git.kernel.org/tip/de95a991bb72e009f47e0c4bbc90fc5f594588d5
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Wed, 04 Dec 2019 20:56:19 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2020 10:54:12 +01:00

tick/sched: Annotate lockless access to last_jiffies_update

syzbot (KCSAN) reported a data-race in tick_do_update_jiffies64():

BUG: KCSAN: data-race in tick_do_update_jiffies64 / tick_do_update_jiffies64

write to 0xffffffff8603d008 of 8 bytes by interrupt on cpu 1:
 tick_do_update_jiffies64+0x100/0x250 kernel/time/tick-sched.c:73
 tick_sched_do_timer+0xd4/0xe0 kernel/time/tick-sched.c:138
 tick_sched_timer+0x43/0xe0 kernel/time/tick-sched.c:1292
 __run_hrtimer kernel/time/hrtimer.c:1514 [inline]
 __hrtimer_run_queues+0x274/0x5f0 kernel/time/hrtimer.c:1576
 hrtimer_interrupt+0x22a/0x480 kernel/time/hrtimer.c:1638
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1110 [inline]
 smp_apic_timer_interrupt+0xdc/0x280 arch/x86/kernel/apic/apic.c:1135
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
 arch_local_irq_restore arch/x86/include/asm/paravirt.h:756 [inline]
 kcsan_setup_watchpoint+0x1d4/0x460 kernel/kcsan/core.c:436
 check_access kernel/kcsan/core.c:466 [inline]
 __tsan_read1 kernel/kcsan/core.c:593 [inline]
 __tsan_read1+0xc2/0x100 kernel/kcsan/core.c:593
 kallsyms_expand_symbol.constprop.0+0x70/0x160 kernel/kallsyms.c:79
 kallsyms_lookup_name+0x7f/0x120 kernel/kallsyms.c:170
 insert_report_filterlist kernel/kcsan/debugfs.c:155 [inline]
 debugfs_write+0x14b/0x2d0 kernel/kcsan/debugfs.c:256
 full_proxy_write+0xbd/0x100 fs/debugfs/file.c:225
 __vfs_write+0x67/0xc0 fs/read_write.c:494
 vfs_write fs/read_write.c:558 [inline]
 vfs_write+0x18a/0x390 fs/read_write.c:542
 ksys_write+0xd5/0x1b0 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x4c/0x60 fs/read_write.c:620
 do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffffffff8603d008 of 8 bytes by task 0 on cpu 0:
 tick_do_update_jiffies64+0x2b/0x250 kernel/time/tick-sched.c:62
 tick_nohz_update_jiffies kernel/time/tick-sched.c:505 [inline]
 tick_nohz_irq_enter kernel/time/tick-sched.c:1257 [inline]
 tick_irq_enter+0x139/0x1c0 kernel/time/tick-sched.c:1274
 irq_enter+0x4f/0x60 kernel/softirq.c:354
 entering_irq arch/x86/include/asm/apic.h:517 [inline]
 entering_ack_irq arch/x86/include/asm/apic.h:523 [inline]
 smp_apic_timer_interrupt+0x55/0x280 arch/x86/kernel/apic/apic.c:1133
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:830
 native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:60
 arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:571
 default_idle_call+0x1e/0x40 kernel/sched/idle.c:94
 cpuidle_idle_call kernel/sched/idle.c:154 [inline]
 do_idle+0x1af/0x280 kernel/sched/idle.c:263
 cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
 rest_init+0xec/0xf6 init/main.c:452
 arch_call_rest_init+0x17/0x37
 start_kernel+0x838/0x85e init/main.c:786
 x86_64_start_reservations+0x29/0x2b arch/x86/kernel/head64.c:490
 x86_64_start_kernel+0x72/0x76 arch/x86/kernel/head64.c:471
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011

Use READ_ONCE() and WRITE_ONCE() to annotate this expected race.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191205045619.204946-1-edumazet@google.com

---
 kernel/time/tick-sched.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8b192e6..a792d21 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -58,8 +58,9 @@ static void tick_do_update_jiffies64(ktime_t now)
 
 	/*
 	 * Do a quick check without holding jiffies_lock:
+	 * The READ_ONCE() pairs with two updates done later in this function.
 	 */
-	delta = ktime_sub(now, last_jiffies_update);
+	delta = ktime_sub(now, READ_ONCE(last_jiffies_update));
 	if (delta < tick_period)
 		return;
 
@@ -70,8 +71,9 @@ static void tick_do_update_jiffies64(ktime_t now)
 	if (delta >= tick_period) {
 
 		delta = ktime_sub(delta, tick_period);
-		last_jiffies_update = ktime_add(last_jiffies_update,
-						tick_period);
+		/* Pairs with the lockless read in this function. */
+		WRITE_ONCE(last_jiffies_update,
+			   ktime_add(last_jiffies_update, tick_period));
 
 		/* Slow path for long timeouts */
 		if (unlikely(delta >= tick_period)) {
@@ -79,8 +81,10 @@ static void tick_do_update_jiffies64(ktime_t now)
 
 			ticks = ktime_divns(delta, incr);
 
-			last_jiffies_update = ktime_add_ns(last_jiffies_update,
-							   incr * ticks);
+			/* Pairs with the lockless read in this function. */
+			WRITE_ONCE(last_jiffies_update,
+				   ktime_add_ns(last_jiffies_update,
+						incr * ticks));
 		}
 		do_timer(++ticks);
 
