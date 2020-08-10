Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE810C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6CB222B49
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597086905;
	bh=Ut+U0EnmHql932ucX5JMyLLVtVGUtPjEuJCYWDW8BeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mMm6rzHiJwFy269Ggy9on1/Qpc1m2/zdF3ZNmGlv4zX9EBs6feKCQ2nn+tevNT3K5
	 TerMx3xlL8YcppSiDn/uuEI27LMg9pOaVd1iRxufI6PT/6MwxOl9G7aPb84Jl8rd//
	 7Ygr1Qyvg0szIM7D3U5vsdgz0dVLuU7NgA7EyTV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgHJTPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730118AbgHJTO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:14:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70D6822D06;
        Mon, 10 Aug 2020 19:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597086896;
        bh=Ut+U0EnmHql932ucX5JMyLLVtVGUtPjEuJCYWDW8BeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcSQaLV+Ei3AfDuWn8IT+rZ7UUxBkQFGt4Fqbj5sODJEUpcmdzEMo99Qg+z8ZQv/d
         n0LcOBChjbg1IAo4db2Dx0QHHBTFZp+dGdXE1vd0yClQ38AvcpzMl0GS/uda25obDR
         mz/RtUDt3/nT2I2KcAwDV9u5FZpL+d+aEJb8/h/c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 08/16] mm/mmap.c: Add cond_resched() for exit_mmap() CPU stalls
Date:   Mon, 10 Aug 2020 15:14:35 -0400
Message-Id: <20200810191443.3795581-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191443.3795581-1-sashal@kernel.org>
References: <20200810191443.3795581-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 0a3b3c253a1eb2c7fe7f34086d46660c909abeb3 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index a24e424770012..135cccce41f88 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2954,6 +2954,7 @@ void exit_mmap(struct mm_struct *mm)
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
 		vma = remove_vma(vma);
+		cond_resched();
 	}
 	vm_unacct_memory(nr_accounted);
 }
-- 
2.25.1

