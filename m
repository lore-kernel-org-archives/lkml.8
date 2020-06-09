Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7293DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30FF02074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591717221;
	bh=T/TYjogJbMVF+SfuNpq65E2vUlFFXy2vqnQJW+wYTdQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=VFD7nhEvSzh1LkEhH8WOGmWCakdygLnD8CyBktnm9p3K3QenGGZmLth3hcooYeN6U
	 nV0SJn3jD/tCUZ4+eGun8+eT6aQ80xmzxUnW1JewmVNE3DXbvt0RSUPnXsH+TouY0k
	 wyKSQ/GFLoa+p83DL6BVmggy8/IImMcpe6grYftE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbgFIPkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727945AbgFIPkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:40:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 631BA2072F;
        Tue,  9 Jun 2020 15:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591717216;
        bh=T/TYjogJbMVF+SfuNpq65E2vUlFFXy2vqnQJW+wYTdQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GljcwNCa9bklE1V8owluNg2y/eAdrXI2qXkeSmzzs1peHZkvI29RM513royYu1GWF
         YOBQT4NWqXsAzn4OGRWtio/toZd2sVGJKT/gcprRRP0aMKewmLMK7aVIu7cjFjq4gk
         bqlcciNZiH6mmP3nikqSsLY2nuMXU8Trk/PFZpPk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3ADD735229D0; Tue,  9 Jun 2020 08:40:16 -0700 (PDT)
Date:   Tue, 9 Jun 2020 08:40:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: BUG: kernel NULL pointer dereference from check_preempt_wakeup()
Message-ID: <20200609154016.GA17196@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200604225445.GA32319@paulmck-ThinkPad-P72>
 <20200605131451.GE2750@hirez.programming.kicks-ass.net>
 <20200605141607.GB4455@paulmck-ThinkPad-P72>
 <20200605184159.GA4062@paulmck-ThinkPad-P72>
 <20200606005126.GA21507@paulmck-ThinkPad-P72>
 <20200606172942.GA30594@paulmck-ThinkPad-P72>
 <20200607185732.GA18906@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607185732.GA18906@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 11:57:32AM -0700, Paul E. McKenney wrote:
> On Sat, Jun 06, 2020 at 10:29:42AM -0700, Paul E. McKenney wrote:
> > On Fri, Jun 05, 2020 at 05:51:26PM -0700, Paul E. McKenney wrote:
> > > On Fri, Jun 05, 2020 at 11:41:59AM -0700, Paul E. McKenney wrote:
> > > > On Fri, Jun 05, 2020 at 07:16:07AM -0700, Paul E. McKenney wrote:
> > > > 
> > > > And in case it is helpful, here is the output of "git bisect view",
> > > > which lists rather more commits than "git bisect run" claims, but there
> > > > are only a few scheduler commits below.  I don't see anything that
> > > > I can prove can cause this problem, but there are some that are at
> > > > least related to this code path.
> > > > 
> > > > Is there anything that is actually relevant?
> > > 
> > > And the run with the WARN and tracing did hit two failures, and the
> > > corresponding console logs are in the attached tarball.  Both of them
> > > triggered a warning as well as the failure.
> > 
> > And the current state of the bisection, for whatever it is worth.
> 
> The bisection finished, finally!
> 
> 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> 
> I don't see anything immediately obvious, but then again, I do not
> claim to understand this code.  If you have additional diagnostics,
> please let me know.

But lockdep just might have spotted something useful.
This was running the rcutorture SRCU-P scenario on
mainline commit abfbb29297c2 ("Merge tag 'rproc-v5.8' of
git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc").
Unlike TREE03, SRCU-P enables lockdep.

This splat features a couple of lockdep_assert_held() splats just before
the mysterious NULL pointer dereference.

						Thanx, Paul
------------------------------------------------------------------------

[16741.334139] ------------[ cut here ]------------
[16741.335393] WARNING: CPU: 2 PID: 159 at kernel/sched/sched.h:1132 update_curr+0xc6/0x390
[16741.336800] Modules linked in:
[16741.337426] CPU: 2 PID: 159 Comm: kworker/2:3 Not tainted 5.7.0+ #4
[16741.338315] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[16741.339516] Workqueue: rcu_gp process_srcu
[16741.340100] RIP: 0010:update_curr+0xc6/0x390
[16741.340710] Code: c0 00 00 00 48 89 83 c0 00 00 00 eb a7 4d 01 7c 24 20 eb a9 48 8d 78 18 be ff ff ff ff e8 52 92 b7 00 85 c0 0f 85 66 ff ff ff <0f> 0b e9 5f ff ff ff 4c 8d 6b 80 0f 1f 44 00 00 65 8b 05 53 51 b6
[16741.343660] RSP: 0000:ffff9d7180108c30 EFLAGS: 00010046
[16741.344504] RAX: 0000000000000000 RBX: ffff8ca19f3d44c0 RCX: ffff8ca19dd55b00
[16741.345511] RDX: 0000000000000000 RSI: ffff8ca19f42bfd8 RDI: ffff8ca19dd56470
[16741.346540] RBP: ffff9d7180108c58 R08: 000010012d27c58c R09: 0000000000000008
[16741.347554] R10: 0000000000000001 R11: 0000000000000000 R12: ffff8ca19f42c080
[16741.348561] R13: ffff8ca19f3d44c0 R14: ffff8ca19f42bfc0 R15: 0000000000000000
[16741.349567] FS:  0000000000000000(0000) GS:ffff8ca19f480000(0000) knlGS:0000000000000000
[16741.350704] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16741.351522] CR2: 00000000ffffffff CR3: 000000000f620000 CR4: 00000000000006e0
[16741.352547] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[16741.353580] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[16741.354597] Call Trace:
[16741.354947]  <IRQ>
[16741.355254]  enqueue_task_fair+0x25f/0xb60
[16741.355845]  activate_task+0x41/0xb0
[16741.356377]  ttwu_do_activate+0x49/0x80
[16741.356928]  sched_ttwu_pending+0x94/0xe0
[16741.357573]  smp_call_function_single_interrupt+0x44/0x1e0
[16741.358378]  call_function_single_interrupt+0xf/0x20
[16741.359076] RIP: 0010:_raw_spin_unlock_irqrestore+0x49/0x60
[16741.359873] Code: c7 02 75 1f 53 9d e8 d6 e2 53 ff bf 01 00 00 00 e8 ac 1c 47 ff 65 8b 05 7d 94 fe 7b 85 c0 74 0c 5b 5d c3 e8 c9 e1 53 ff 53 9d <eb> df e8 90 34 3d ff eb ed 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00
[16741.362526] RSP: 0000:ffff9d7180108e00 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff04
[16741.363590] RAX: 000000000c8b8f92 RBX: 0000000000000202 RCX: 0000000000000002
[16741.364625] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8402ea97
[16741.365778] RBP: ffff8ca19f3d4c38 R08: 0000000000000000 R09: 0000000000000000
[16741.366793] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[16741.367818] R13: ffff8ca19f3d4c38 R14: 0000000000000202 R15: ffff8ca19f42bfc0
[16741.368850]  ? call_function_single_interrupt+0xa/0x20
[16741.369737]  ? _raw_spin_unlock_irqrestore+0x47/0x60
[16741.370590]  try_to_wake_up+0x25f/0x7e0
[16741.371137]  ? __next_timer_interrupt+0xc0/0xc0
[16741.371890]  call_timer_fn+0xa0/0x2f0
[16741.372586]  ? __next_timer_interrupt+0xc0/0xc0
[16741.373291]  run_timer_softirq+0x1cc/0x550
[16741.373911]  __do_softirq+0xe5/0x497
[16741.374443]  irq_exit+0xa9/0xc0
[16741.374894]  smp_apic_timer_interrupt+0xb7/0x280
[16741.375568]  apic_timer_interrupt+0xf/0x20
[16741.376150]  </IRQ>
[16741.376474] RIP: 0010:preempt_count_sub+0x25/0x90
[16741.377145] Code: 00 00 00 00 00 8b 0d 82 8a 92 02 85 c9 75 1b 65 8b 15 c7 77 b7 7c 89 d1 81 e1 ff ff ff 7f 39 cf 7f 12 81 ff fe 00 00 00 76 33 <f7> df 65 01 3d aa 77 b7 7c c3 e8 cc 61 b8 00 85 c0 74 f6 8b 15 42
[16741.379836] RSP: 0000:ffff9d71802abd78 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
[16741.380926] RAX: 000000000000132e RBX: 000020026cf2624c RCX: 0000000000000001
[16741.381973] RDX: 0000000080000001 RSI: 0000000000000000 RDI: 0000000000000001
[16741.383011] RBP: 000020026cf24f1e R08: 0000000000000000 R09: 0000000000000007
[16741.384055] R10: ffff9d71802abde0 R11: 0000000000000001 R12: 0000000000002905
[16741.385098] R13: 0000000000000002 R14: 00000000ffffffff R15: ffffffff85e0cf20
[16741.386173]  delay_tsc+0x66/0xb0
[16741.386668]  try_check_zero+0xbd/0xe0
[16741.387212]  process_srcu+0x163/0x4f0
[16741.387775]  process_one_work+0x2aa/0x610
[16741.388373]  ? worker_thread+0xa2/0x3c0
[16741.388947]  worker_thread+0x28/0x3c0
[16741.389493]  ? process_one_work+0x610/0x610
[16741.390100]  kthread+0x134/0x160
[16741.390574]  ? kthread_create_on_node+0x60/0x60
[16741.391238]  ret_from_fork+0x27/0x40
[16741.391769] irq event stamp: 210472851
[16741.392334] hardirqs last  enabled at (210472850): [<ffffffff8402ea97>] _raw_spin_unlock_irqrestore+0x47/0x60
[16741.393802] hardirqs last disabled at (210472851): [<ffffffff83401f16>] trace_hardirqs_off_thunk+0x1a/0x1c
[16741.395215] softirqs last  enabled at (210472444): [<ffffffff84400393>] __do_softirq+0x393/0x497
[16741.396530] softirqs last disabled at (210472845): [<ffffffff83475259>] irq_exit+0xa9/0xc0
[16741.397750] ---[ end trace f4a25b323e5f0d37 ]---
[16741.398471] ------------[ cut here ]------------
[16741.399154] WARNING: CPU: 2 PID: 159 at kernel/sched/pelt.h:139 update_load_avg+0x4fd/0x770
[16741.400404] Modules linked in:
[16741.400842] CPU: 2 PID: 159 Comm: kworker/2:3 Tainted: G        W         5.7.0+ #4
[16741.401939] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[16741.403141] Workqueue: rcu_gp process_srcu
[16741.403740] RIP: 0010:update_load_avg+0x4fd/0x770
[16741.404418] Code: 00 41 bc 01 00 00 00 48 89 93 90 00 00 00 e9 7e fb ff ff 49 8d 7c 24 18 be ff ff ff ff e8 db 7f b7 00 85 c0 0f 85 2f fb ff ff <0f> 0b e9 28 fb ff ff 65 8b 05 e5 3e b6 7c 89 c0 48 0f a3 05 83 62
[16741.407138] RSP: 0000:ffff9d7180108c18 EFLAGS: 00010046
[16741.408149] RAX: 0000000000000000 RBX: ffff8ca19f42c080 RCX: ffff8ca19dd55b00
[16741.409184] RDX: 0000000000000000 RSI: ffff8ca19f42bfd8 RDI: ffff8ca19dd56470
[16741.410216] RBP: ffff8ca19f3d44c0 R08: 0000000000000000 R09: 0000000000000008
[16741.411239] R10: ffff8ca19dd563d0 R11: 0000000000000001 R12: ffff8ca19f42bfc0
[16741.412261] R13: 0000000000000005 R14: 0000000000000009 R15: 0000000000000000
[16741.413310] FS:  0000000000000000(0000) GS:ffff8ca19f480000(0000) knlGS:0000000000000000
[16741.414468] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16741.415304] CR2: 00000000ffffffff CR3: 000000000f620000 CR4: 00000000000006e0
[16741.416321] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[16741.417347] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[16741.418367] Call Trace:
[16741.418725]  <IRQ>
[16741.419021]  ? update_curr+0x196/0x390
[16741.419578]  enqueue_task_fair+0xc9/0xb60
[16741.420150]  activate_task+0x41/0xb0
[16741.420672]  ttwu_do_activate+0x49/0x80
[16741.421219]  sched_ttwu_pending+0x94/0xe0
[16741.421821]  smp_call_function_single_interrupt+0x44/0x1e0
[16741.422617]  call_function_single_interrupt+0xf/0x20
[16741.423357] RIP: 0010:_raw_spin_unlock_irqrestore+0x49/0x60
[16741.424142] Code: c7 02 75 1f 53 9d e8 d6 e2 53 ff bf 01 00 00 00 e8 ac 1c 47 ff 65 8b 05 7d 94 fe 7b 85 c0 74 0c 5b 5d c3 e8 c9 e1 53 ff 53 9d <eb> df e8 90 34 3d ff eb ed 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00
[16741.426809] RSP: 0000:ffff9d7180108e00 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff04
[16741.427886] RAX: 000000000c8b8f92 RBX: 0000000000000202 RCX: 0000000000000002
[16741.428913] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8402ea97
[16741.429939] RBP: ffff8ca19f3d4c38 R08: 0000000000000000 R09: 0000000000000000
[16741.432061] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[16741.433126] R13: ffff8ca19f3d4c38 R14: 0000000000000202 R15: ffff8ca19f42bfc0
[16741.434161]  ? call_function_single_interrupt+0xa/0x20
[16741.434930]  ? _raw_spin_unlock_irqrestore+0x47/0x60
[16741.435651]  try_to_wake_up+0x25f/0x7e0
[16741.436197]  ? __next_timer_interrupt+0xc0/0xc0
[16741.436880]  call_timer_fn+0xa0/0x2f0
[16741.437435]  ? __next_timer_interrupt+0xc0/0xc0
[16741.438098]  run_timer_softirq+0x1cc/0x550
[16741.438712]  __do_softirq+0xe5/0x497
[16741.439283]  irq_exit+0xa9/0xc0
[16741.439750]  smp_apic_timer_interrupt+0xb7/0x280
[16741.440420]  apic_timer_interrupt+0xf/0x20
[16741.441001]  </IRQ>
[16741.441333] RIP: 0010:preempt_count_sub+0x25/0x90
[16741.442021] Code: 00 00 00 00 00 8b 0d 82 8a 92 02 85 c9 75 1b 65 8b 15 c7 77 b7 7c 89 d1 81 e1 ff ff ff 7f 39 cf 7f 12 81 ff fe 00 00 00 76 33 <f7> df 65 01 3d aa 77 b7 7c c3 e8 cc 61 b8 00 85 c0 74 f6 8b 15 42
[16741.444725] RSP: 0000:ffff9d71802abd78 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
[16741.445854] RAX: 000000000000132e RBX: 000020026cf2624c RCX: 0000000000000001
[16741.446895] RDX: 0000000080000001 RSI: 0000000000000000 RDI: 0000000000000001
[16741.447939] RBP: 000020026cf24f1e R08: 0000000000000000 R09: 0000000000000007
[16741.448964] R10: ffff9d71802abde0 R11: 0000000000000001 R12: 0000000000002905
[16741.449995] R13: 0000000000000002 R14: 00000000ffffffff R15: ffffffff85e0cf20
[16741.451055]  delay_tsc+0x66/0xb0
[16741.451547]  try_check_zero+0xbd/0xe0
[16741.452096]  process_srcu+0x163/0x4f0
[16741.452661]  process_one_work+0x2aa/0x610
[16741.453465]  ? worker_thread+0xa2/0x3c0
[16741.454026]  worker_thread+0x28/0x3c0
[16741.454568]  ? process_one_work+0x610/0x610
[16741.455162]  kthread+0x134/0x160
[16741.455634]  ? kthread_create_on_node+0x60/0x60
[16741.456284]  ret_from_fork+0x27/0x40
[16741.456800] irq event stamp: 210472851
[16741.457359] hardirqs last  enabled at (210472850): [<ffffffff8402ea97>] _raw_spin_unlock_irqrestore+0x47/0x60
[16741.458760] hardirqs last disabled at (210472851): [<ffffffff83401f16>] trace_hardirqs_off_thunk+0x1a/0x1c
[16741.460124] softirqs last  enabled at (210472444): [<ffffffff84400393>] __do_softirq+0x393/0x497
[16741.461382] softirqs last disabled at (210472845): [<ffffffff83475259>] irq_exit+0xa9/0xc0
[16741.462563] ---[ end trace f4a25b323e5f0d38 ]---
[16741.463252] BUG: kernel NULL pointer dereference, address: 0000000000000150
[16741.464279] #PF: supervisor read access in kernel mode
[16741.465010] #PF: error_code(0x0000) - not-present page
[16741.465753] PGD 0 P4D 0 
[16741.466127] Oops: 0000 [#1] PREEMPT SMP PTI
[16741.466762] CPU: 2 PID: 159 Comm: kworker/2:3 Tainted: G        W         5.7.0+ #4
[16741.467851] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[16741.469064] Workqueue: rcu_gp process_srcu
[16741.469653] RIP: 0010:check_preempt_wakeup+0xb1/0x180
[16741.470396] Code: 83 ea 01 48 8b 9b 48 01 00 00 39 d0 75 f2 48 39 bb 50 01 00 00 75 05 48 85 ff 75 29 48 8b ad 48 01 00 00 48 8b 9b 48 01 00 00 <48> 8b bd 50 01 00 00 48 39 bb 50 01 00 00 0f 95 c2 48 85 ff 0f 94
[16741.473057] RSP: 0000:ffff9d7180108c98 EFLAGS: 00010087
[16741.473817] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8460bc20
[16741.474835] RDX: 0000000000000000 RSI: ffff8ca19f3d4440 RDI: ffff8ca19f4ac080
[16741.475912] RBP: 0000000000000000 R08: ffff8ca19dd55b00 R09: 000000000000000f
[16741.477233] R10: 0000000000000000 R11: 000000000000007b R12: ffff8ca19f4abfc0
[16741.478541] R13: 0000000000000001 R14: ffff8ca19dd55b00 R15: 0000000000000000
[16741.479625] FS:  0000000000000000(0000) GS:ffff8ca19f480000(0000) knlGS:0000000000000000
[16741.480923] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16741.481760] CR2: 0000000000000150 CR3: 000000000f620000 CR4: 00000000000006e0
[16741.482778] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[16741.483794] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[16741.484803] Call Trace:
[16741.485156]  <IRQ>
[16741.485466]  check_preempt_curr+0x67/0xb0
[16741.486039]  ttwu_do_wakeup+0x14/0x1d0
[16741.486595]  sched_ttwu_pending+0x94/0xe0
[16741.487168]  smp_call_function_single_interrupt+0x44/0x1e0
[16741.487954]  call_function_single_interrupt+0xf/0x20
[16741.488669] RIP: 0010:_raw_spin_unlock_irqrestore+0x49/0x60
[16741.489462] Code: c7 02 75 1f 53 9d e8 d6 e2 53 ff bf 01 00 00 00 e8 ac 1c 47 ff 65 8b 05 7d 94 fe 7b 85 c0 74 0c 5b 5d c3 e8 c9 e1 53 ff 53 9d <eb> df e8 90 34 3d ff eb ed 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00
[16741.492112] RSP: 0000:ffff9d7180108e00 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff04
[16741.493261] RAX: 000000000c8b8f92 RBX: 0000000000000202 RCX: 0000000000000002
[16741.494443] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8402ea97
[16741.495586] RBP: ffff8ca19f3d4c38 R08: 0000000000000000 R09: 0000000000000000
[16741.496617] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
[16741.497632] R13: ffff8ca19f3d4c38 R14: 0000000000000202 R15: ffff8ca19f42bfc0
[16741.499111]  ? call_function_single_interrupt+0xa/0x20
[16741.499851]  ? _raw_spin_unlock_irqrestore+0x47/0x60
[16741.500586]  try_to_wake_up+0x25f/0x7e0
[16741.501144]  ? __next_timer_interrupt+0xc0/0xc0
[16741.501795]  call_timer_fn+0xa0/0x2f0
[16741.502331]  ? __next_timer_interrupt+0xc0/0xc0
[16741.502982]  run_timer_softirq+0x1cc/0x550
[16741.503573]  __do_softirq+0xe5/0x497
[16741.504083]  irq_exit+0xa9/0xc0
[16741.504545]  smp_apic_timer_interrupt+0xb7/0x280
[16741.505232]  apic_timer_interrupt+0xf/0x20
[16741.505816]  </IRQ>
[16741.506119] RIP: 0010:preempt_count_sub+0x25/0x90
[16741.506792] Code: 00 00 00 00 00 8b 0d 82 8a 92 02 85 c9 75 1b 65 8b 15 c7 77 b7 7c 89 d1 81 e1 ff ff ff 7f 39 cf 7f 12 81 ff fe 00 00 00 76 33 <f7> df 65 01 3d aa 77 b7 7c c3 e8 cc 61 b8 00 85 c0 74 f6 8b 15 42
[16741.509429] RSP: 0000:ffff9d71802abd78 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
[16741.510501] RAX: 000000000000132e RBX: 000020026cf2624c RCX: 0000000000000001
[16741.511527] RDX: 0000000080000001 RSI: 0000000000000000 RDI: 0000000000000001
[16741.512535] RBP: 000020026cf24f1e R08: 0000000000000000 R09: 0000000000000007
[16741.513552] R10: ffff9d71802abde0 R11: 0000000000000001 R12: 0000000000002905
[16741.514567] R13: 0000000000000002 R14: 00000000ffffffff R15: ffffffff85e0cf20
[16741.515597]  delay_tsc+0x66/0xb0
[16741.516060]  try_check_zero+0xbd/0xe0
[16741.516594]  process_srcu+0x163/0x4f0
[16741.517125]  process_one_work+0x2aa/0x610
[16741.517722]  ? worker_thread+0xa2/0x3c0
[16741.518276]  worker_thread+0x28/0x3c0
[16741.518803]  ? process_one_work+0x610/0x610
[16741.519404]  kthread+0x134/0x160
[16741.519879]  ? kthread_create_on_node+0x60/0x60
[16741.520543]  ret_from_fork+0x27/0x40
[16741.521049] Modules linked in:
[16741.521498] CR2: 0000000000000150
[16741.521987] ---[ end trace f4a25b323e5f0d39 ]---
[16741.521992] BUG: kernel NULL pointer dereference, address: 0000000000000050
[16741.522671] RIP: 0010:check_preempt_wakeup+0xb1/0x180
[16741.523794] #PF: supervisor read access in kernel mode
[16741.524786] Code: 83 ea 01 48 8b 9b 48 01 00 00 39 d0 75 f2 48 39 bb 50 01 00 00 75 05 48 85 ff 75 29 48 8b ad 48 01 00 00 48 8b 9b 48 01 00 00 <48> 8b bd 50 01 00 00 48 39 bb 50 01 00 00 0f 95 c2 48 85 ff 0f 94
[16741.524793] RSP: 0000:ffff9d7180108c98 EFLAGS: 00010087
[16741.525651] #PF: error_code(0x0000) - not-present page
[16741.525656] PGD 800000001dcac067 P4D 800000001dcac067 PUD 1dcab067 PMD 0 
[16741.528889] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8460bc20
[16741.529728] Oops: 0000 [#2] PREEMPT SMP PTI
[16741.530480] RDX: 0000000000000000 RSI: ffff8ca19f3d4440 RDI: ffff8ca19f4ac080
[16741.531517] CPU: 0 PID: 100 Comm: rcu_torture_rea Tainted: G      D W         5.7.0+ #4
[16741.532543] RBP: 0000000000000000 R08: ffff8ca19dd55b00 R09: 000000000000000f
[16741.533250] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
[16741.534321] R10: 0000000000000000 R11: 000000000000007b R12: ffff8ca19f4abfc0
[16741.534327] R13: 0000000000000001 R14: ffff8ca19dd55b00 R15: 0000000000000000
[16741.535640] RIP: 0010:task_tick_fair+0x162/0x350
[16741.537114] FS:  0000000000000000(0000) GS:ffff8ca19f480000(0000) knlGS:0000000000000000
[16741.537120] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16741.538410] Code: 39 d0 0f 82 b5 00 00 00 8b 0d 7e 7a 7b 01 48 39 ca 0f 82 f5 fe ff ff 48 8b 4d 38 48 8d 51 f0 48 85 c9 48 8b 4b 50 49 0f 44 d6 <48> 2b 4a 50 0f 88 d8 fe ff ff 48 39 c8 0f 83 cf fe ff ff 48 8b bd
[16741.539443] CR2: 0000000000000150 CR3: 000000000f620000 CR4: 00000000000006e0
[16741.539450] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[16741.540570] RSP: 0000:ffff9d7180003e60 EFLAGS: 00010046
[16741.541273] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[16741.541279] Kernel panic - not syncing: Fatal exception in interrupt
[16741.542507] RAX: 000000000089543f RBX: ffff8ca19f3f9740 RCX: 00011b40ae682dc2
[16741.542514] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000112a880
[16741.552934] RBP: ffff8ca19f42c080 R08: 0000000000000000 R09: 000000000000001e
[16741.553957] R10: 000000007ffffff8 R11: 0000000000000000 R12: 0000000000000000
[16741.554991] R13: ffff8ca19f3f96c0 R14: 0000000000000000 R15: ffff8ca19f42bfc0
[16741.556037] FS:  0000000000000000(0000) GS:ffff8ca19f400000(0000) knlGS:0000000000000000
[16741.557490] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16741.558966] CR2: 0000000000000050 CR3: 000000001dca8000 CR4: 00000000000006f0
[16741.560940] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[16741.562231] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[16741.563261] Call Trace:
[16741.563618]  <IRQ>
[16741.563923]  scheduler_tick+0x84/0x110
[16741.564708]  ? tick_sched_do_timer+0x60/0x60
[16741.565373]  update_process_times+0x42/0x50
[16741.565988]  tick_sched_handle+0x34/0x40
[16741.566581]  tick_sched_timer+0x3e/0x80
[16741.567154]  __hrtimer_run_queues+0x1bb/0x4c0
[16741.567840]  hrtimer_interrupt+0x105/0x220
[16741.568452]  smp_apic_timer_interrupt+0x96/0x280
[16741.569119]  apic_timer_interrupt+0xf/0x20
[16741.569724]  </IRQ>
[16741.570073] RIP: 0010:srcu_torture_read_unlock+0x1/0x40
[16741.571018] Code: e9 84 db ff ff 0f 1f 40 00 48 8b 3d 41 99 77 01 e9 94 db ff ff 0f 1f 40 00 48 8b 3d 31 99 77 01 e9 04 c4 ff ff 0f 1f 40 00 55 <89> fd 83 e7 fe 53 48 8b 1d 1a 99 77 01 75 1f 48 8d bb 78 07 00 00
[16741.574075] RSP: 0000:ffff9d7180367c38 EFLAGS: 00000206 ORIG_RAX: ffffffffffffff13
[16741.575193] RAX: ffffffff834f32c0 RBX: 0000000000000000 RCX: 0000000000000000
[16741.576257] RDX: ffff9d7180367e80 RSI: 0000000000000000 RDI: 0000000000000000
[16741.577290] RBP: ffff9d7180367c88 R08: 0000000000000000 R09: 0000000000000000
[16741.578348] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000020
[16741.579381] R13: 0000000000000000 R14: ffff9d7180367cac R15: 00000000ffffffff
[16741.580414]  ? srcu_torture_completed+0x10/0x10
[16741.581072]  rcutorture_one_extend+0xf5/0x440
[16741.581714]  rcu_torture_one_read+0x192/0x440
[16741.582367]  ? rcu_torture_one_read+0x440/0x440
[16741.583019]  rcu_torture_reader+0x9d/0x1e0
[16741.583631]  ? rcu_busted_torture_deferred_free+0x10/0x10
[16741.584438]  kthread+0x134/0x160
[16741.584907]  ? kthread_create_on_node+0x60/0x60
[16741.585589]  ret_from_fork+0x27/0x40
[16741.586110] Modules linked in:
[16741.586579] CR2: 0000000000000050
[16741.587062] ---[ end trace f4a25b323e5f0d3a ]---
[16741.587736] RIP: 0010:check_preempt_wakeup+0xb1/0x180
[16741.588473] Code: 83 ea 01 48 8b 9b 48 01 00 00 39 d0 75 f2 48 39 bb 50 01 00 00 75 05 48 85 ff 75 29 48 8b ad 48 01 00 00 48 8b 9b 48 01 00 00 <48> 8b bd 50 01 00 00 48 39 bb 50 01 00 00 0f 95 c2 48 85 ff 0f 94
[16741.591229] RSP: 0000:ffff9d7180108c98 EFLAGS: 00010087
[16741.591978] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8460bc20
[16741.593011] RDX: 0000000000000000 RSI: ffff8ca19f3d4440 RDI: ffff8ca19f4ac080
[16741.594061] RBP: 0000000000000000 R08: ffff8ca19dd55b00 R09: 000000000000000f
[16741.595080] R10: 0000000000000000 R11: 000000000000007b R12: ffff8ca19f4abfc0
[16741.596106] R13: 0000000000000001 R14: ffff8ca19dd55b00 R15: 0000000000000000
[16741.597169] FS:  0000000000000000(0000) GS:ffff8ca19f400000(0000) knlGS:0000000000000000
[16741.598710] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[16741.599553] CR2: 0000000000000050 CR3: 000000001dca8000 CR4: 00000000000006f0
[16741.600665] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[16741.601758] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[16742.625568] Shutting down cpus with NMI
[16742.626374] Kernel Offset: 0x2400000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[16742.627968] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---
