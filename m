Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBB3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D1B207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 22:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591311287;
	bh=7q7+q2EB8/oGtqNvN6F18VZlf6ZGDNy9D9rQzI7t+gQ=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=q7/fdvBG272DhcwcsamO2yLDExQkLMTU6gNX87APqavf0OxBt185bqn+LcgzW2kQG
	 Rv9bfDWpD0W5L4VQjtcsSnkuL9mghWezMHU7xidJtNPkYNSVRitS8m83AicQemo+CS
	 yoDJG7yrGKZX/gd3kl/Yr9VomRDycFe6p4d+OZrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgFDWyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 18:54:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbgFDWyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 18:54:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6142074B;
        Thu,  4 Jun 2020 22:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591311285;
        bh=7q7+q2EB8/oGtqNvN6F18VZlf6ZGDNy9D9rQzI7t+gQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=QrPg6faGTl446YsicZUdCoegFO4DY5wx58XXNXe90dutx7p7l7xL8WiMmV91jxtif
         KfNCKLJBDkIg4gY6wZcqxcdyImmHgS5L2NXhGj9voMBPIX0dIJIS/+Mpzzn1F35ZqR
         QG3TnVJQz3CNP9w4oHIobXgM7C+xVvBmFA7hKD4A=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7113135209CD; Thu,  4 Jun 2020 15:54:45 -0700 (PDT)
Date:   Thu, 4 Jun 2020 15:54:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: BUG: kernel NULL pointer dereference from check_preempt_wakeup()
Message-ID: <20200604225445.GA32319@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I get the splat below at a rate of roughly two per thirty hours when
running rcutorture scenario TREE03 on x86 at the June 3rd mainline commit:

cb8e59cc8720 ("Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next")

Running 140 hours of this same scenario at the following June 2nd mainline
commit shows no errors:

d9afbb350990 ("Merge branch 'next-general' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security")

I have started a bisection, but it is likely to take several days to
complete.  I am looking at ways of speeding this up, but in the meantime,
I figured that I should check to see if others are also encountering this.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

BUG: kernel NULL pointer dereference, address: 0000000000000150
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 9 PID: 196 Comm: rcu_torture_rea Not tainted 5.7.0+ #3923
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
RIP: 0010:check_preempt_wakeup+0xb1/0x180
Code: 83 ea 01 48 8b 9b 48 01 00 00 39 d0 75 f2 48 39 bb 50 01 00 00 75 05 48 85 ff 75 29 48 8b ad 48 01 00 00 48 8b 9b 48 01 00 00 <48> 8b bd 50 01 00 00 48 39 bb 50 01 00 00 0f 95 c2 48 85 ff 0f 94
RSP: 0018:ffffaccdc02ecd38 EFLAGS: 00010006
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffafa0bc20
RDX: 0000000000000000 RSI: ffff946b5df50000 RDI: ffff946b5f469340
RBP: 0000000000000000 R08: ffff946b5df80d00 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: ffff946b5f469300
R13: 0000000000000001 R14: ffff946b5df80d00 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff946b5f440000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000150 CR3: 0000000016e0a000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 check_preempt_curr+0x5d/0x90
 ttwu_do_wakeup.isra.93+0xf/0x100
 sched_ttwu_pending+0x66/0x90
 smp_call_function_single_interrupt+0x2d/0xf0
 call_function_single_interrupt+0xf/0x20
RIP: 0010:_raw_spin_unlock_irqrestore+0x5/0x30
Code: 81 4e ff c3 90 c6 07 00 fb bf 01 00 00 00 e8 62 b0 57 ff 65 8b 05 f3 e0 af 50 85 c0 74 01 c3 e8 a1 81 4e ff c3 c6 07 00 56 9d <bf> 01 00 00 00 e8 41 b0 57 ff 65 8b 05 d2 e0 af 50 85 c0 74 01 c3
RSP: 0018:ffffaccdc02ece80 EFLAGS: 00000287 ORIG_RAX: ffffffffffffff04
RAX: 0000000000000001 RBX: ffff946b5df50000 RCX: ffff946b5ed62700
RDX: 00000000000000fb RSI: 0000000000000287 RDI: ffff946b5df50784
RBP: 0000000000000009 R08: 0000166489fdaf46 R09: ffff946b5f45cf28
R10: ffffaccdc02ecf18 R11: ffffaccdc06a3c40 R12: 0000000000000000
R13: ffff946b5df50784 R14: 0000000000000287 R15: ffff946b5f5e9300
 ? call_function_single_interrupt+0xa/0x20
 try_to_wake_up+0x205/0x510
 ? trace_raw_output_hrtimer_start+0x70/0x70
 ? trace_raw_output_hrtimer_start+0x70/0x70
 call_timer_fn+0x28/0x150
 run_timer_softirq+0x17b/0x220
 ? kvm_clock_read+0x14/0x30
 ? ktime_get+0x31/0x90
 ? hpet_assign_irq+0x90/0x90
 ? lapic_next_event+0x17/0x20
 __do_softirq+0xf7/0x322
 do_softirq_own_stack+0x2a/0x40
 </IRQ>
 do_softirq.part.15+0x32/0x40
 __local_bh_enable_ip+0x6b/0x80
 rcutorture_one_extend+0x1a1/0x2e0
 rcu_torture_one_read+0x186/0x3a0
 ? rcu_torture_one_read+0x3a0/0x3a0
 rcu_torture_reader+0x9d/0x1d0
 ? rcu_torture_stats+0x50/0x50
 kthread+0x134/0x160
 ? kthread_create_on_node+0x60/0x60
 ret_from_fork+0x22/0x30
Modules linked in:
CR2: 0000000000000150
---[ end trace 04d9c8a56ef5df54 ]---
RIP: 0010:check_preempt_wakeup+0xb1/0x180
Code: 83 ea 01 48 8b 9b 48 01 00 00 39 d0 75 f2 48 39 bb 50 01 00 00 75 05 48 85 ff 75 29 48 8b ad 48 01 00 00 48 8b 9b 48 01 00 00 <48> 8b bd 50 01 00 00 48 39 bb 50 01 00 00 0f 95 c2 48 85 ff 0f 94
RSP: 0018:ffffaccdc02ecd38 EFLAGS: 00010006
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffafa0bc20
RDX: 0000000000000000 RSI: ffff946b5df50000 RDI: ffff946b5f469340
RBP: 0000000000000000 R08: ffff946b5df80d00 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: ffff946b5f469300
R13: 0000000000000001 R14: ffff946b5df80d00 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff946b5f440000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000150 CR3: 0000000016e0a000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: 0x2da00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
