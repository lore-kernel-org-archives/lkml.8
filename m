Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BF0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A66722BF3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UxLI31FW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iOPgoDTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbgGaJYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:24:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731981AbgGaJXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:42 -0400
Date:   Fri, 31 Jul 2020 09:23:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XKcDjqjHZyOxGmKCkMgX7OQbESulfd4mhAB4oHFRsj8=;
        b=UxLI31FWcBWZ0fTRpQXLwx7VnXkltTNJZeJRnOa5ZksTzxoD7ympcTPcIAjYsddVMLT1tU
        m22WW9uTAIpURkmGbXJL2JzLa1EZ7sDLKu3lvybt8fRhc6bVo8+YHvSFdXVtZb8Wop0oH/
        2eQAM1/1ZQ36p650KBXyCg9Xa1yjnTKt6ErkK6QDkV1aUlSmWA7HO/5Mnm9J+W+lbqO5Wr
        iXOwqkyIJk4yovgC475OcH03ZV1G10afsT0AwYmlzL/OBWHVcWx3w1DfPMVBByCZxAzthm
        86wP2zkkrwdd3+f5l5EcQyu4ac7MpD46Wfri/Z3hBCZHFbdiw1B3WitU6jNkEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187420;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XKcDjqjHZyOxGmKCkMgX7OQbESulfd4mhAB4oHFRsj8=;
        b=iOPgoDTRj9rxOs0wKQvA1T5hhvav9gzX0D22/Rj83Ny/kkac7xuO3sx/4GWFZxk0N7mo32
        eNudEzfn3kgW+pAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] mm/mmap.c: Add cond_resched() for exit_mmap() CPU stalls
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618742007.4006.11207886326021221931.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0a3b3c253a1eb2c7fe7f34086d46660c909abeb3
Gitweb:        https://git.kernel.org/tip/0a3b3c253a1eb2c7fe7f34086d46660c909abeb3
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 16 Apr 2020 16:46:10 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:49 -07:00

mm/mmap.c: Add cond_resched() for exit_mmap() CPU stalls

A large process running on a heavily loaded system can encounter the
following RCU CPU stall warning:

  rcu: INFO: rcu_sched self-detected stall on CPU
  rcu: 	3-....: (20998 ticks this GP) idle=4ea/1/0x4000000000000002 softirq=556558/556558 fqs=5190
  	(t=21013 jiffies g=1005461 q=132576)
  NMI backtrace for cpu 3
  CPU: 3 PID: 501900 Comm: aio-free-ring-w Kdump: loaded Not tainted 5.2.9-108_fbk12_rc3_3858_gb83b75af7909 #1
  Hardware name: Wiwynn   HoneyBadger/PantherPlus, BIOS HBM6.71 02/03/2016
  Call Trace:
   <IRQ>
   dump_stack+0x46/0x60
   nmi_cpu_backtrace.cold.3+0x13/0x50
   ? lapic_can_unplug_cpu.cold.27+0x34/0x34
   nmi_trigger_cpumask_backtrace+0xba/0xca
   rcu_dump_cpu_stacks+0x99/0xc7
   rcu_sched_clock_irq.cold.87+0x1aa/0x397
   ? tick_sched_do_timer+0x60/0x60
   update_process_times+0x28/0x60
   tick_sched_timer+0x37/0x70
   __hrtimer_run_queues+0xfe/0x270
   hrtimer_interrupt+0xf4/0x210
   smp_apic_timer_interrupt+0x5e/0x120
   apic_timer_interrupt+0xf/0x20
   </IRQ>
  RIP: 0010:kmem_cache_free+0x223/0x300
  Code: 88 00 00 00 0f 85 ca 00 00 00 41 8b 55 18 31 f6 f7 da 41 f6 45 0a 02 40 0f 94 c6 83 c6 05 9c 41 5e fa e8 a0 a7 01 00 41 56 9d <49> 8b 47 08 a8 03 0f 85 87 00 00 00 65 48 ff 08 e9 3d fe ff ff 65
  RSP: 0018:ffffc9000e8e3da8 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff13
  RAX: 0000000000020000 RBX: ffff88861b9de960 RCX: 0000000000000030
  RDX: fffffffffffe41e8 RSI: 000060777fe3a100 RDI: 000000000001be18
  RBP: ffffea00186e7780 R08: ffffffffffffffff R09: ffffffffffffffff
  R10: ffff88861b9dea28 R11: ffff88887ffde000 R12: ffffffff81230a1f
  R13: ffff888854684dc0 R14: 0000000000000206 R15: ffff8888547dbc00
   ? remove_vma+0x4f/0x60
   remove_vma+0x4f/0x60
   exit_mmap+0xd6/0x160
   mmput+0x4a/0x110
   do_exit+0x278/0xae0
   ? syscall_trace_enter+0x1d3/0x2b0
   ? handle_mm_fault+0xaa/0x1c0
   do_group_exit+0x3a/0xa0
   __x64_sys_exit_group+0x14/0x20
   do_syscall_64+0x42/0x100
   entry_SYSCALL_64_after_hwframe+0x44/0xa9

And on a PREEMPT=n kernel, the "while (vma)" loop in exit_mmap() can run
for a very long time given a large process.  This commit therefore adds
a cond_resched() to this loop, providing RCU any needed quiescent states.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 mm/mmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 59a4682..972f839 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3159,6 +3159,7 @@ void exit_mmap(struct mm_struct *mm)
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
 		vma = remove_vma(vma);
+		cond_resched();
 	}
 	vm_unacct_memory(nr_accounted);
 }
