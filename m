Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9354C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39DD2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592329884;
	bh=U4TW4tjDEIugqVBaJQg1uDW5QSgEOItFCRKBNssmCe4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=TqjzywqSPgFbOHEli0ldu6cSOi80EYEXtsQzDjutR38VgUP1wkyc5gMaq3I1vqjO2
	 7R9KMLoi0pqWbk3dBmHeAsd92xHivIf443WopIEivztmKxi2j1eBOkn9xXn/YIXw0R
	 1l/6AqEWv91wYUkPaDUSor4yhFqpbXkmI/e7kIEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731294AbgFPRvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:51:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbgFPRvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:51:22 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61B6820776;
        Tue, 16 Jun 2020 17:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592329881;
        bh=U4TW4tjDEIugqVBaJQg1uDW5QSgEOItFCRKBNssmCe4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CTSzQ0hsPhz8H/DImIMyOTrV3KyBIMSO2PLB1z/n7wBQCuZzmBlWuIoBf6Uopw73t
         bNPn1tywKwRh46Rv1SHPo2rw8SfQolz29w8bfD9zW9LOmM+Im4M4XQPn4uBqcLaLUD
         nZ9QgLPfZNdiX1Dg3/NOhlXP+L/0DtXyOxi4P2QY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 45CC1352264F; Tue, 16 Jun 2020 10:51:21 -0700 (PDT)
Date:   Tue, 16 Jun 2020 10:51:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, frederic@kernel.org
Subject: Re: [PATCH 0/6] sched: TTWU, IPI, and assorted stuff
Message-ID: <20200616175121.GD2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200615125654.678940605@infradead.org>
 <20200615162330.GF2723@paulmck-ThinkPad-P72>
 <20200615164048.GC2531@hirez.programming.kicks-ass.net>
 <20200615172149.GJ2723@paulmck-ThinkPad-P72>
 <20200615191158.GK2531@hirez.programming.kicks-ass.net>
 <20200616170410.GL2554@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616170410.GL2554@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 07:04:10PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 15, 2020 at 09:11:58PM +0200, Peter Zijlstra wrote:
> > On Mon, Jun 15, 2020 at 10:21:49AM -0700, Paul E. McKenney wrote:
> > > On Mon, Jun 15, 2020 at 06:40:48PM +0200, Peter Zijlstra wrote:
> > 
> > > > Thanks! I've got 16*TREE03 running since this morning, so far so nothing :/
> > > > (FWIW that's 16/9 times overcommit, idle time fluctuates around 10%).
> > > 
> > > My large system as large remote memory latencies, as in the better part
> > > of a microsecond.  My small system is old (Haswell).  So, just to grasp
> > > at the obvious straw, do you have access to a multisocket Haswell system?
> > 
> > I've been running this on a 4 socket haswell ex.
> 
> Today, with patch 1 commented out, after ~5h20 I finally managed to trigger a splat.
> 
> Let me go stare at it, see if it wants to yield it sekrets

This splat looks very very familiar, so good show!  ;-)

							Thanx, Paul

> [19324.742887] BUG: kernel NULL pointer dereference, address: 0000000000000150
> [19324.744075] #PF: supervisor read access in kernel mode
> [19324.744919] #PF: error_code(0x0000) - not-present page
> [19324.745786] PGD 0 P4D 0
> [19324.746215] Oops: 0000 [#1] PREEMPT SMP PTI
> [19324.746948] CPU: 10 PID: 76 Comm: ksoftirqd/10 Tainted: G        W         5.8.0-rc1+ #8
> [19324.748080] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
> [19324.749372] RIP: 0010:check_preempt_wakeup+0xad/0x1a0
> [19324.750218] Code: d0 39 d0 7d 2c 83 ea 01 48 8b 9b 48 01 00 00 39 d0 75 f2 48 39 bb 50 01 00 00 74 1e 48 8b ad 48 01 00 00 48 8b 9b 48 01 00 00 <48> 8b bd 50 01 00 00 48 39 bb 50 01 00 00 75 e2 48 85 ff 74 dd e8
> [19324.753364] RSP: 0000:ffffb3cb40320f50 EFLAGS: 00010087
> [19324.754255] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffb400bce0
> [19324.755465] RDX: 0000000000000000 RSI: ffff93c1dbed5b00 RDI: ffff93c1df4a8380
> [19324.756682] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff93c1df2e83b0
> [19324.757848] R10: 0000000000000001 R11: 0000000000000335 R12: 0000000000000001
> [19324.758453] smpboot: CPU 11 is now offline
> [19324.759099] R13: ffff93c1dcf48000 R14: ffff93c1df4a8340 R15: ffff93c1df4a8340
> [19324.761167] FS:  0000000000000000(0000) GS:ffff93c1df480000(0000) knlGS:0000000000000000
> [19324.762559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [19324.763527] CR2: 0000000000000150 CR3: 000000001e40a000 CR4: 00000000000006e0
> [19324.764726] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [19324.765929] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [19324.767100] Call Trace:
> [19324.767516]  <IRQ>
> [19324.767875]  check_preempt_curr+0x62/0x90
> [19324.768586]  ttwu_do_wakeup.constprop.0+0xf/0x100
> [19324.769407]  sched_ttwu_pending+0xa9/0xe0
> [19324.770077]  __sysvec_call_function_single+0x28/0xe0
> [19324.770926]  asm_call_on_stack+0x12/0x20
> [19324.771594]  </IRQ>
> [19324.771951]  sysvec_call_function_single+0x94/0xd0
> [19324.772596]  asm_sysvec_call_function_single+0x12/0x20
> [19324.773254] RIP: 0010:_raw_spin_unlock_irqrestore+0x5/0x30
> [19324.774169] Code: e4 49 ff c3 90 c6 07 00 bf 01 00 00 00 e8 23 2d 53 ff 65 8b 05 cc 32 4b 4c 85 c0 74 01 c3 e8 b9 e4 49 ff c3 90 c6 07 00 56 9d <bf> 01 00 00 00 e8 01 2d 53 ff 65 8b 05 aa 32 4b 4c 85 c0 74 01 c3
> [19324.777267] RSP: 0000:ffffb3cb4030bd58 EFLAGS: 00000287
> [19324.777956] RAX: 0000000000000001 RBX: ffff93c1dbed5b00 RCX: ffff93c1dcd63400
> [19324.779015] RDX: 0000000000000000 RSI: 0000000000000287 RDI: ffff93c1dbed6284
> [19324.780067] RBP: 000000000000000a R08: 00001193646cd91c R09: ffff93c1df49c008
> [19324.781192] R10: ffffb3cb4030bdf8 R11: 000000000000032e R12: 0000000000000000
> [19324.782386] R13: 0000000000000287 R14: ffff93c1dbed6284 R15: ffff93c1df2e8340
> [19324.783565]  try_to_wake_up+0x232/0x530
> [19324.784057]  ? trace_raw_output_hrtimer_start+0x70/0x70
> [19324.784977]  call_timer_fn+0x28/0x150
> [19324.785606]  ? trace_raw_output_hrtimer_start+0x70/0x70
> [19324.786486]  run_timer_softirq+0x182/0x250
> [19324.787191]  ? set_next_entity+0x8b/0x1a0
> [19324.787867]  ? _raw_spin_unlock_irq+0xe/0x20
> [19324.788597]  ? finish_task_switch+0x7b/0x230
> [19324.789338]  __do_softirq+0xfc/0x32b
> [19324.789961]  ? smpboot_register_percpu_thread+0xd0/0xd0
> [19324.790904]  run_ksoftirqd+0x21/0x30
> [19324.791510]  smpboot_thread_fn+0x195/0x230
> [19324.792203]  kthread+0x13d/0x160
> [19324.792731]  ? kthread_create_worker_on_cpu+0x60/0x60
> [19324.793576]  ret_from_fork+0x22/0x30
> [19324.794186] Modules linked in:
> [19324.794729] CR2: 0000000000000150
> [19324.795303] ------------[ cut here ]------------
> [19324.795304] WARNING: CPU: 10 PID: 76 at kernel/smp.c:138 __smp_call_single_queue+0x40/0x50
> [19324.795305] Modules linked in:
> [19324.795306] CPU: 10 PID: 76 Comm: ksoftirqd/10 Not tainted 5.8.0-rc1+ #8
> [19324.795307] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/2014
> [19324.795307] RIP: 0010:__smp_call_single_queue+0x40/0x50
> [19324.795308] Code: c2 40 91 02 00 4c 89 e6 4c 89 e7 48 03 14 c5 e0 56 2d b4 e8 b2 3a 2f 00 84 c0 75 04 5d 41 5c c3 89 ef 5d 41 5c e9 40 af f9 ff <0f> 0b eb cd 66 66 2e 0f 1f 84 00 00 00 00 00 90 41 54 49 89 f4 55
> [19324.795309] RSP: 0000:ffffb3cb4030bd18 EFLAGS: 00010046
> [19324.795310] RAX: 000000000000000a RBX: 0000000000000000 RCX: 00000000ffffffff
> [19324.795310] RDX: 00000000000090aa RSI: ffffffffb420bc3f RDI: ffffffffb4232e3e
> [19324.795311] RBP: 000000000000000a R08: 00001193646cd91c R09: ffff93c1df49c008
> [19324.795312] R10: ffffb3cb4030bdf8 R11: 000000000000032e R12: ffff93c1dbed5b30
> [19324.795312] R13: ffff93c1df4a8340 R14: 000000000000000a R15: ffff93c1df2e8340
> [19324.795313] FS:  0000000000000000(0000) GS:ffff93c1df480000(0000) knlGS:0000000000000000
> [19324.795313] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [19324.795314] CR2: 00000000ffffffff CR3: 000000001e40a000 CR4: 00000000000006e0
> [19324.795315] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [19324.795315] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [19324.795316] Call Trace:
> [19324.795316]  ttwu_queue_wakelist+0xa4/0xc0
> [19324.795316]  try_to_wake_up+0x432/0x530
> [19324.795317]  ? trace_raw_output_hrtimer_start+0x70/0x70
> [19324.795317]  call_timer_fn+0x28/0x150
> [19324.795318]  ? trace_raw_output_hrtimer_start+0x70/0x70
> [19324.795318]  run_timer_softirq+0x182/0x250
> [19324.795319]  ? set_next_entity+0x8b/0x1a0
> [19324.795319]  ? _raw_spin_unlock_irq+0xe/0x20
> [19324.795319]  ? finish_task_switch+0x7b/0x230
> [19324.795320]  __do_softirq+0xfc/0x32b
> [19324.795320]  ? smpboot_register_percpu_thread+0xd0/0xd0
> [19324.795321]  run_ksoftirqd+0x21/0x30
> [19324.795321]  smpboot_thread_fn+0x195/0x230
> [19324.795321]  kthread+0x13d/0x160
> [19324.795322]  ? kthread_create_worker_on_cpu+0x60/0x60
> [19324.795322]  ret_from_fork+0x22/0x30
> [19324.795323] ---[ end trace 851fe1f1f7a85d8b ]---
> [19324.828475] ---[ end trace 851fe1f1f7a85d8c ]---
> [19324.829250] RIP: 0010:check_preempt_wakeup+0xad/0x1a0
> [19324.830107] Code: d0 39 d0 7d 2c 83 ea 01 48 8b 9b 48 01 00 00 39 d0 75 f2 48 39 bb 50 01 00 00 74 1e 48 8b ad 48 01 00 00 48 8b 9b 48 01 00 00 <48> 8b bd 50 01 00 00 48 39 bb 50 01 00 00 75 e2 48 85 ff 74 dd e8
> [19324.833208] RSP: 0000:ffffb3cb40320f50 EFLAGS: 00010087
> [19324.834098] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffb400bce0
> [19324.835272] RDX: 0000000000000000 RSI: ffff93c1dbed5b00 RDI: ffff93c1df4a8380
> [19324.836466] RBP: 0000000000000000 R08: 0000000000000000 R09: ffff93c1df2e83b0
> [19324.837669] R10: 0000000000000001 R11: 0000000000000335 R12: 0000000000000001
> [19324.838867] R13: ffff93c1dcf48000 R14: ffff93c1df4a8340 R15: ffff93c1df4a8340
> [19324.840019] FS:  0000000000000000(0000) GS:ffff93c1df480000(0000) knlGS:0000000000000000
> [19324.841316] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [19324.842242] CR2: 0000000000000150 CR3: 000000001e40a000 CR4: 00000000000006e0
> [19324.843406] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [19324.844568] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [19324.845710] Kernel panic - not syncing: Fatal exception in interrupt
> [19324.846998] Kernel Offset: 0x32000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> [19324.848713] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
