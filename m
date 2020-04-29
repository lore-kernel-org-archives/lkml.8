Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAEAC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5731520737
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 00:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588118544;
	bh=cS8SdVduNXsmh6TxpFoqhg955eV4Ko0RSkkswKrFHwI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=IK+nhG8YESm+8p6GsSBiizQpQoPbuavEUn+HZd6nW+DeoAY5gi2zr0v8w/iwTiXbH
	 FH3Phv+9Q2asr8uMh/ylpMeH6DYaqDvhMCdQ5XOkApXxuorF93XZpbsR/+fyvpoIpR
	 MsqpzNaPwgissv+uRboeLWX/ITV+NKiKVJPW9go4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgD2ACX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 20:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgD2ACX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 20:02:23 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E286620737;
        Wed, 29 Apr 2020 00:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588118541;
        bh=cS8SdVduNXsmh6TxpFoqhg955eV4Ko0RSkkswKrFHwI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TkTDpm6rmx/xRofbL6FLiB4+lllonAHgbrfFuvY0a44VcymDy7VBvePAmi5Ke/NK+
         4zUTnrbwKBuReFxoyY2pxAbDGD/sXftrd/DKSOD9KDctzeVSY3Shqtku7UXK8f+GYH
         K13SsM4yFPeqWn752W4i7M71cj4ThxbcWqpmTIQY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BB5EC35226B0; Tue, 28 Apr 2020 17:02:21 -0700 (PDT)
Date:   Tue, 28 Apr 2020 17:02:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sal Carrasco <scarrasco@linode.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Introduction Email and RCU CPU Stalls
Message-ID: <20200429000221.GA22991@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAL1oa3sbpn0+sbov-Jvhr1k1eo3wRzi70iNVFb4qQX4N08K-GA@mail.gmail.com>
 <20200425000234.GD17661@paulmck-ThinkPad-P72>
 <CAL1oa3tcPOTrZTCDrbtcsx3nWaddwgik=-7gaTTx581tSiWuJQ@mail.gmail.com>
 <20200428235048.GX7560@paulmck-ThinkPad-P72>
 <20200428235207.GA22595@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200428235207.GA22595@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 04:52:07PM -0700, Paul E. McKenney wrote:
> On Tue, Apr 28, 2020 at 04:50:48PM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 28, 2020 at 06:21:30PM -0400, Sal Carrasco wrote:
> > > Hi Paul,
> > > 
> > > As for the stalls, we've seen them either be self-detected or detected by
> > > another CPU on the system. We've also seen stalls in various
> > > situations where we remove ebtables out of the equation which I think
> > > validates your theory that get_counters() is an innocent bystander. I've
> > > added a different trace from the same server which completely locks up once
> > > we hit this issue. As for using BPF or some other observability tool,
> > > unfortunately the system locks up completely so we are unable to access it
> > > to perform any type of analysis. This brings up my next question, in your
> > > experience have you seen a situation like this before where seemingly 1 cpu
> > > stalls and then the system completely locks up after that?
> > > 
> > > - Sal
> > 
> > This one looks like IOMMU lock contention.  There was a patch set by
> > Shaohua Li intended to address this, but I don't see any sign that this
> > patch was accepted.  It might be worthwhile trying Shaohua's patch
> > series and seeing if it helps.  I would suggest talking to Shaohua,
> > but https://lwn.net/Articles/775861/...
> 
> And this time with a URL for that patch series...
> 
> https://lists.linuxfoundation.org/pipermail/iommu/2016-January/015337.html

And it appears that an alternative was accepted into the kernel:

22e2f9fa63b0 ("iommu/vt-d: Use per-cpu IOVA caching")

It seems to have been applied to v4.7, but only for Intel IOMMUs.

							Thanx, Paul

> > > ========== New stall traces ==========
> > > 
> > > [Thu Apr 23 17:00:17 2020] br0: port 81(tap.20217676_0) entered blocking
> > > state
> > > [Thu Apr 23 17:00:17 2020] br0: port 81(tap.20217676_0) entered forwarding
> > > state
> > > [Thu Apr 23 17:01:42 2020] hrtimer: interrupt took 9631 ns
> > > [Thu Apr 23 19:04:25 2020] ------------[ cut here ]------------
> > > [Thu Apr 23 19:04:25 2020] NETDEV WATCHDOG: eth1 (mlx5_core): transmit
> > > queue 41 timed out
> > > [Thu Apr 23 19:04:25 2020] WARNING: CPU: 76 PID: 0 at
> > > net/sched/sch_generic.c:443 dev_watchdog+0x22f/0x240
> > > [Thu Apr 23 19:04:25 2020] Modules linked in: vhost_net vhost cls_u32
> > > sch_ingress act_police nft_objref nft_counter nft_limit nf_tables_set
> > > xt_multiport xt_set ip_set nf_conntrack_netlink xt_CT xt_conntrack tun
> > > nft_ct nf_tables nf_conntrack_bridge nf_conntrack nf_defrag_ipv6
> > > nf_defrag_ipv4 8021q mrp bonding amd64_edac_mod kvm_amd kvm irqbypass
> > > crct10dif_pclmul crc32_pclmul mlx5_core crc32c_intel evdev fuse autofs4
> > > [Thu Apr 23 19:04:25 2020] CPU: 76 PID: 0 Comm: swapper/76 Not tainted
> > > 5.5.9-1 #1
> > > [Thu Apr 23 19:04:25 2020] Hardware name: Supermicro Super
> > > Server/H11DSi-NT, BIOS 1.1 04/13/2018
> > > [Thu Apr 23 19:04:25 2020] RIP: 0010:dev_watchdog+0x22f/0x240
> > > [Thu Apr 23 19:04:25 2020] Code: c0 75 e4 eb 98 4c 89 ef c6 05 f3 19 eb 00
> > > 01 e8 17 7a fb ff 89 d9 48 89 c2 4c 89 ee 48 c7 c7 48 d3 61 8e 31 c0 e8 a1
> > > ec 5b ff <0f> 0b e9 75 ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
> > > [Thu Apr 23 19:04:25 2020] RSP: 0018:ffffb4b30d658ea0 EFLAGS: 00010286
> > > [Thu Apr 23 19:04:25 2020] RAX: 000000000000003e RBX: 0000000000000029 RCX:
> > > 0000000000000000
> > > [Thu Apr 23 19:04:25 2020] RDX: ffff8f252fd27480 RSI: ffff8f252fd18a18 RDI:
> > > ffff8f252fd18a18
> > > [Thu Apr 23 19:04:25 2020] RBP: ffff8f3521800440 R08: 0000000000000000 R09:
> > > 0000000000000b09
> > > [Thu Apr 23 19:04:25 2020] R10: 000006ff5a468c40 R11: 0000000000000000 R12:
> > > 00000000000001f8
> > > [Thu Apr 23 19:04:25 2020] R13: ffff8f3521800000 R14: 000000010070d200 R15:
> > > 0000000000000000
> > > [Thu Apr 23 19:04:25 2020] FS:  0000000000000000(0000)
> > > GS:ffff8f252fd00000(0000) knlGS:0000000000000000
> > > [Thu Apr 23 19:04:25 2020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [Thu Apr 23 19:04:25 2020] CR2: 00007f652ae64e98 CR3: 00000073ef80a000 CR4:
> > > 00000000003406e0
> > > [Thu Apr 23 19:04:25 2020] Call Trace:
> > > [Thu Apr 23 19:04:25 2020]  <IRQ>
> > > [Thu Apr 23 19:04:25 2020]  ? dev_deactivate_queue.constprop.60+0x90/0x90
> > > [Thu Apr 23 19:04:25 2020]  call_timer_fn+0x2d/0x140
> > > [Thu Apr 23 19:04:25 2020]  run_timer_softirq+0x16a/0x1e0
> > > [Thu Apr 23 19:04:25 2020]  ? timerqueue_add+0x5e/0x70
> > > [Thu Apr 23 19:04:25 2020]  ? enqueue_hrtimer+0x3a/0x90
> > > [Thu Apr 23 19:04:25 2020]  ? __hrtimer_run_queues+0x11c/0x260
> > > [Thu Apr 23 19:04:25 2020]  __do_softirq+0x117/0x2d0
> > > [Thu Apr 23 19:04:25 2020]  irq_exit+0x5a/0x60
> > > [Thu Apr 23 19:04:25 2020]  smp_apic_timer_interrupt+0x74/0x140
> > > [Thu Apr 23 19:04:25 2020]  apic_timer_interrupt+0xf/0x20
> > > [Thu Apr 23 19:04:25 2020]  </IRQ>
> > > [Thu Apr 23 19:04:25 2020] RIP: 0010:cpuidle_enter_state+0xc5/0x3d0
> > > [Thu Apr 23 19:04:25 2020] Code: c7 0f 1f 44 00 00 31 ff e8 d8 f1 69 ff 80
> > > 7c 24 0f 00 74 12 9c 58 f6 c4 02 0f 85 db 02 00 00 31 ff e8 bf 5d 6f ff fb
> > > 45 85 f6 <0f> 88 8e 02 00 00 49 63 d6 4c 2b 7c 24 10 48 8d 04 52 48 8d 04 82
> > > [Thu Apr 23 19:04:25 2020] RSP: 0018:ffffb4b30c76fe90 EFLAGS: 00000202
> > > ORIG_RAX: ffffffffffffff13
> > > [Thu Apr 23 19:04:25 2020] RAX: ffff8f252fd2a0c0 RBX: ffff8f152781b000 RCX:
> > > 000000000000001f
> > > [Thu Apr 23 19:04:25 2020] RDX: 0000000000000000 RSI: 00000fa78ce9df82 RDI:
> > > 0000000000000000
> > > [Thu Apr 23 19:04:25 2020] RBP: ffffffff8e8fdc00 R08: ffffffe1dd14beda R09:
> > > 000001d1a94a2000
> > > [Thu Apr 23 19:04:25 2020] R10: 0000000000000140 R11: 0000000000000032 R12:
> > > 000000000000004c
> > > [Thu Apr 23 19:04:25 2020] R13: 000000000000004c R14: 0000000000000002 R15:
> > > 000006ff8cdebd0d
> > > [Thu Apr 23 19:04:25 2020]  cpuidle_enter+0x2f/0x40
> > > [Thu Apr 23 19:04:25 2020]  do_idle+0x10c/0x1d0
> > > [Thu Apr 23 19:04:25 2020]  cpu_startup_entry+0x19/0x20
> > > [Thu Apr 23 19:04:25 2020]  secondary_startup_64+0xa4/0xb0
> > > [Thu Apr 23 19:04:25 2020] ---[ end trace 51079cc92cafa850 ]---
> > > [Thu Apr 23 19:04:25 2020] mlx5_core 0000:13:00.1 eth1: TX timeout detected
> > > [Thu Apr 23 19:04:25 2020] mlx5_core 0000:13:00.1 eth1: TX timeout on
> > > queue: 41, SQ: 0xb24, CQ: 0xda2, SQ Cons: 0x4b6 SQ Prod: 0x4bd, usecs since
> > > last trans: 19370000
> > > [Thu Apr 23 19:04:25 2020] mlx5_core 0000:13:00.1 eth1: EQ 0x30: Cons =
> > > 0x3b055, irqn = 0x136
> > > [Thu Apr 23 19:04:44 2020] rcu: INFO: rcu_sched detected stalls on
> > > CPUs/tasks:
> > > [Thu Apr 23 19:04:44 2020] rcu: 107-....: (1 GPs behind)
> > > idle=c66/1/0x4000000000000002 softirq=7423822/7423854 fqs=11724
> > > [Thu Apr 23 19:04:44 2020] (detected by 44, t=60015 jiffies, g=796105,
> > > q=3217349)
> > > [Thu Apr 23 19:04:44 2020] Sending NMI from CPU 44 to CPUs 107:
> > > [Thu Apr 23 19:04:44 2020] NMI backtrace for cpu 107
> > > [Thu Apr 23 19:04:44 2020] CPU: 107 PID: 29507 Comm: qemu-system-x86
> > > Tainted: G        W         5.5.9-1 #1
> > > [Thu Apr 23 19:04:44 2020] Hardware name: Supermicro Super
> > > Server/H11DSi-NT, BIOS 1.1 04/13/2018
> > > [Thu Apr 23 19:04:44 2020] RIP: 0010:queued_spin_lock_slowpath+0x118/0x1c0
> > > [Thu Apr 23 19:04:44 2020] Code: c1 e8 12 48 c1 ee 0c 83 e8 01 83 e6 30 48
> > > 98 48 81 c6 80 ad 02 00 48 03 34 c5 80 b7 62 8e 48 89 16 8b 42 08 85 c0 75
> > > 09 f3 90 <8b> 42 08 85 c0 74 f7 48 8b 32 48 85 f6 74 07 0f 0d 0e eb 02 f3 90
> > > [Thu Apr 23 19:04:44 2020] RSP: 0018:ffffb4b30dbace18 EFLAGS: 00000046
> > > [Thu Apr 23 19:04:44 2020] RAX: 0000000000000000 RBX: 0000000000000086 RCX:
> > > 0000000001b00000
> > > [Thu Apr 23 19:04:44 2020] RDX: ffff8f652fcead80 RSI: ffff8f252fcaad80 RDI:
> > > ffff8f652ca76808
> > > [Thu Apr 23 19:04:44 2020] RBP: 0007fffffffdf2c0 R08: 0000000001b00000 R09:
> > > ffffffff8d726d00
> > > [Thu Apr 23 19:04:44 2020] R10: ffff8f415a03b2c0 R11: 0000000000000001 R12:
> > > ffff8f652ca76808
> > > [Thu Apr 23 19:04:44 2020] R13: 0000000000087bdb R14: 0000000000000048 R15:
> > > 0000000000000286
> > > [Thu Apr 23 19:04:44 2020] FS:  00007f4749ed6f00(0000)
> > > GS:ffff8f652fcc0000(0000) knlGS:ffff9d49afa40000
> > > [Thu Apr 23 19:04:44 2020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [Thu Apr 23 19:04:44 2020] CR2: 000055bac3c0c5d0 CR3: 0000007fb7de6000 CR4:
> > > 00000000003406e0
> > > [Thu Apr 23 19:04:44 2020] Call Trace:
> > > [Thu Apr 23 19:04:44 2020]  <IRQ>
> > > [Thu Apr 23 19:04:44 2020]  _raw_spin_lock_irqsave+0x27/0x30
> > > [Thu Apr 23 19:04:44 2020]  find_iova+0x14/0x40
> > > [Thu Apr 23 19:04:44 2020]  free_iova+0xe/0x30
> > > [Thu Apr 23 19:04:44 2020]  fq_ring_free+0x99/0xd0
> > > [Thu Apr 23 19:04:44 2020]  fq_flush_timeout+0x61/0x90
> > > [Thu Apr 23 19:04:44 2020]  ? fq_ring_free+0xd0/0xd0
> > > [Thu Apr 23 19:04:44 2020]  call_timer_fn+0x2d/0x140
> > > [Thu Apr 23 19:04:44 2020]  run_timer_softirq+0x16a/0x1e0
> > > [Thu Apr 23 19:04:44 2020]  ? timerqueue_add+0x5e/0x70
> > > [Thu Apr 23 19:04:44 2020]  ? enqueue_hrtimer+0x3a/0x90
> > > [Thu Apr 23 19:04:44 2020]  ? __hrtimer_run_queues+0x11c/0x260
> > > [Thu Apr 23 19:04:44 2020]  __do_softirq+0x117/0x2d0
> > > [Thu Apr 23 19:04:44 2020]  irq_exit+0x5a/0x60
> > > [Thu Apr 23 19:04:44 2020]  smp_apic_timer_interrupt+0x74/0x140
> > > [Thu Apr 23 19:04:44 2020]  apic_timer_interrupt+0xf/0x20
> > > [Thu Apr 23 19:04:44 2020]  </IRQ>
> > > [Thu Apr 23 19:04:44 2020] RIP: 0010:kvm_arch_vcpu_ioctl_run+0xbea/0x1c80
> > > [kvm]
> > > [Thu Apr 23 19:04:44 2020] Code: 24 00 00 48 8b 05 ce 01 07 00 4c 89 ef 48
> > > 8b 80 d0 02 00 00 e8 a7 c0 ad cd 65 4c 89 2d 57 65 b0 3f fb 49 83 85 d8 00
> > > 00 00 01 <fa> 65 48 8b 04 25 00 7d 01 00 65 48 c7 05 38 65 b0 3f 00 00 00 00
> > > [Thu Apr 23 19:04:44 2020] RSP: 0018:ffffb4b36d747d20 EFLAGS: 00000206
> > > ORIG_RAX: ffffffffffffff13
> > > [Thu Apr 23 19:04:44 2020] RAX: ffffffffc0750850 RBX: 00000f926c809262 RCX:
> > > ffff8f84b6c98000
> > > [Thu Apr 23 19:04:44 2020] RDX: 00000f9200000000 RSI: ffffff69cb05ade0 RDI:
> > > ffff8f84b6c98000
> > > [Thu Apr 23 19:04:44 2020] RBP: ffffb4b36d747dc0 R08: 0000000000000010 R09:
> > > 0000000000000010
> > > [Thu Apr 23 19:04:44 2020] R10: ffffb4b36d747d20 R11: 0000000000000000 R12:
> > > 0000000000000001
> > > [Thu Apr 23 19:04:44 2020] R13: ffff8f84b6c98000 R14: 0000000000000001 R15:
> > > ffff8f84b6c98038
> > > [Thu Apr 23 19:04:44 2020]  ? svm_pku_supported+0x10/0x10 [kvm_amd]
> > > [Thu Apr 23 19:04:44 2020]  ? kvm_vcpu_ioctl+0x405/0x590 [kvm]
> > > [Thu Apr 23 19:04:44 2020]  kvm_vcpu_ioctl+0x405/0x590 [kvm]
> > > [Thu Apr 23 19:04:44 2020]  ? __handle_mm_fault+0xae6/0x1340
> > > [Thu Apr 23 19:04:44 2020]  ? __fpu__restore_sig+0x17f/0x5a0
> > > [Thu Apr 23 19:04:44 2020]  do_vfs_ioctl+0x8e/0x620
> > > [Thu Apr 23 19:04:44 2020]  ? __x64_sys_futex+0x7c/0x170
> > > [Thu Apr 23 19:04:44 2020]  ksys_ioctl+0x5e/0x90
> > > [Thu Apr 23 19:04:44 2020]  __x64_sys_ioctl+0x16/0x20
> > > [Thu Apr 23 19:04:44 2020]  do_syscall_64+0x54/0x280
> > > [Thu Apr 23 19:04:44 2020]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > [Thu Apr 23 19:04:44 2020] RIP: 0033:0x7f64d84951c7
> > > [Thu Apr 23 19:04:44 2020] Code: 44 00 00 48 8b 05 c1 3c 2c 00 64 c7 00 26
> > > 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00
> > > 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 91 3c 2c 00 f7 d8 64 89 01 48
> > > [Thu Apr 23 19:04:44 2020] RSP: 002b:00007f64cb467448 EFLAGS: 00000246
> > > ORIG_RAX: 0000000000000010
> > > [Thu Apr 23 19:04:44 2020] RAX: ffffffffffffffda RBX: 000000000000ae80 RCX:
> > > 00007f64d84951c7
> > > [Thu Apr 23 19:04:44 2020] RDX: 0000000000000000 RSI: 000000000000ae80 RDI:
> > > 000000000000001a
> > > [Thu Apr 23 19:04:44 2020] RBP: 0000559004f19980 R08: 0000559004dbf3a0 R09:
> > > 0000559004f19980
> > > [Thu Apr 23 19:04:44 2020] R10: 0000000000000005 R11: 0000000000000246 R12:
> > > 0000000000000000
> > > [Thu Apr 23 19:04:44 2020] R13: 0000000000000001 R14: 00007f64db764000 R15:
> > > 0000559004f19980
> > > ______________________________________
> > > *Salvador Carrasco*  |  Manager of Systems Operations  |  Linode
> > > w: linode.com  |  e: scarrasco@linode.com
> > > p: 609-380-7100 ext.1310 <(609)%20380-7100>
> > > 
> > > 
> > > On Fri, Apr 24, 2020 at 8:02 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > > Hello, Sal,
> > > >
> > > > I will reply to this CCing LKML, but dropping your last paragraph.
> > > >
> > > > I really do appreciate the offer, especially given there might well come
> > > > a time when that sort of arrangement is quite attractive to me, but I
> > > > am currently fortunate enough to be able to prioritize other people who
> > > > might be having similar issues over compensation, charitable or otherwise.
> > > >
> > > >                                                         Thanx, Paul
> > > >
> > > > On Fri, Apr 24, 2020 at 03:05:27PM -0400, Sal Carrasco wrote:
> > > > > Hi Paul,
> > > > >
> > > > > I love your talks and all of the work that you’ve done around RCU CPU
> > > > stall
> > > > > warnings. I recently watched a youtube video where you talk about
> > > > decoding
> > > > > these inscrutable warnings (https://youtu.be/23_GOr8Sz-E) - they really
> > > > are
> > > > > inscrutable. It was really insightful and it is because of this video
> > > > that
> > > > > I am reaching out to you today.
> > > > >
> > > > > My name is Sal Carrasco and I work for Linode(linode.com) as a part of
> > > > the
> > > > > Systems Engineering team. We’re a cloud hosting company that provides a
> > > > > variety of infrastructure products with our main one being our compute
> > > > > product which are Linux vms.
> > > > >
> > > > > The reason that I am reaching out to you is because in your talk you
> > > > > encourage people to reach out if they encounter these RCU stall warnings.
> > > > > Therefore, I was wondering if you’d be willing to give us some of your
> > > > time
> > > > > to help decipher what we’re currently seeing across our fleet. We’ve
> > > > > submitted a Kernel mailing list post with some relevant information (
> > > > > https://lkml.org/lkml/2020/4/8/980) but no response yet. Also we’ve been
> > > > > able to reliably trigger a NETDEV WATCHDOG followed by a WARNING on
> > > > servers
> > > > > using AMD Epyc processors. After the warnings some combination of [NMIs,
> > > > > stuck kworkers, network device timeouts, rcu stalls] happens, and, in 99%
> > > > > of cases, the system descends into madness and needs to be rebooted.
> > > > >
> > > > > We’d really appreciate any help you can provide as this is a huge thorn
> > > > in
> > > > > our sides. Additionally, I’ve provided some potentially relevant
> > > > debugging
> > > > > information below for context. I know you’re probably busy so we'd be
> > > > happy
> > > > > to pay a consulting fee or donate to a charity of your choosing for your
> > > > > time. If you are interested in helping please let me know.
> > > > >
> > > > > Thanks,
> > > > > Sal
> > > > >
> > > > > ---------- Debugging information --------
> > > > >
> > > > > We’ve encountered this on servers using AMD processors with any
> > > > combination
> > > > > of the following kernels: 4.14.x, 4.19.x, 5.4.x, 5.5.9, 5.6.1.
> > > > >
> > > > > Steps to reproduce:
> > > > >
> > > > > Host loaded with VMs running the following in a loop:
> > > > > fio --name=randrw --rw=randrw --direct=1 --ioengine=libaio --bs=16k
> > > > > --numjobs=8 --rwmixread=90 --size=1G --runtime=600
> > > > > VMs running  playing back a pcap of outbound udp traffic in a loop:
> > > > > timeout 600000 tcpreplay -t -i eth0 --loop 100000 /converted.pcap
> > > > > On the host, in a loop:
> > > > > stress-ng --cpu 120 --io 120 --hdd 5 --timeout 600
> > > > >
> > > > > The host will stall within a few hours.
> > > > >
> > > > > Example kernel output once the machine begins to stall:
> > > > >
> > > > > [ 6755.833166] ------------[ cut here ]------------
> > > > > [ 6755.836716] NETDEV WATCHDOG: eth1 (mlx5_core): transmit queue 19 timed
> > > > > out
> > > > > [ 6755.843728] WARNING: CPU: 15 PID: 30568 at net/sched/sch_generic.c:443
> > > > > dev_watchdog+0x22f/0x240
> > > > > [ 6755.851487] Modules linked in: cls_u32 sch_ingress act_police xt_u32
> > > > > xt_physdev ebt_set xt_multiport xt_set nf_conntrack_netlink xt_CT
> > > > > xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 tun ebt_comment
> > > > > ebt_limit ebt_arp ebt_ip6 ebt_ip ip_set_hash_net ip_set ip6table_raw
> > > > > ip6table_mangle ip6_tables iptable_raw iptable_filter ip_tables bpfilter
> > > > > ebtable_nat 8021q mrp bonding amd64_edac_mod kvm_amd kvm irqbypass
> > > > > crct10dif_pclmul crc32_pclmul mlx5_core crc32c_intel evdev fuse autofs4
> > > > > [ 6755.893442] CPU: 15 PID: 30568 Comm: qemu-system-x86 Not tainted
> > > > 5.5.9-1
> > > > > #1
> > > > > [ 6755.899410] Hardware name: Supermicro Super Server/H11DSi-NT, BIOS 1.1
> > > > > 04/13/2018
> > > > > [ 6755.905729] RIP: 0010:dev_watchdog+0x22f/0x240
> > > > > [ 6755.908994] Code: c0 75 e4 eb 98 4c 89 ef c6 05 f3 19 eb 00 01 e8 17
> > > > 7a
> > > > > fb ff 89 d9 48 89 c2 4c 89 ee 48 c7 c7 48 d3 61 92 31 c0 e8 a1 ec 5b ff
> > > > > <0f> 0b e9 75 ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
> > > > > [ 6755.926764] RSP: 0018:ffff8df80cbacec0 EFLAGS: 00010282
> > > > > [ 6755.930823] RAX: 000000000000003e RBX: 0000000000000013 RCX:
> > > > > 0000000000000000
> > > > > [ 6755.936789] RDX: ffff8b3dafbe7480 RSI: ffff8b3dafbd8a18 RDI:
> > > > > ffff8b3dafbd8a18
> > > > > [ 6755.942753] RBP: ffff8b3d99d80440 R08: 0000000000000000 R09:
> > > > > 0000000000000a4a
> > > > > [ 6755.948717] R10: ffff8df81a243c40 R11: 0000000000000000 R12:
> > > > > 00000000000001f8
> > > > > [ 6755.954680] R13: ffff8b3d99d80000 R14: 0000000100628200 R15:
> > > > > 0000000000000000
> > > > > [ 6755.960643] FS:  00007f2ef5387000(0000) GS:ffff8b3dafbc0000(0000)
> > > > > knlGS:0000000000000000
> > > > > [ 6755.967570] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > [ 6755.972283] CR2: 00007fffbd746d28 CR3: 0000001f119cc000 CR4:
> > > > > 00000000003406e0
> > > > > [ 6755.978403] Call Trace:
> > > > > [ 6755.979673]  <IRQ>
> > > > > [ 6755.980510]  ? dev_deactivate_queue.constprop.60+0x90/0x90
> > > > > [ 6755.984829]  call_timer_fn+0x2d/0x140
> > > > > [ 6755.987443]  run_timer_softirq+0x16a/0x1e0
> > > > > [ 6755.990438]  ? __hrtimer_run_queues+0x11c/0x260
> > > > > [ 6755.993800]  ? ktime_get+0x38/0x90
> > > > > [ 6755.996028]  __do_softirq+0x117/0x2d0
> > > > > [ 6755.998514]  do_softirq_own_stack+0x2a/0x40
> > > > > [ 6756.001524]  </IRQ>
> > > > > [ 6756.002469]  do_softirq.part.20+0x2b/0x30
> > > > > [ 6756.005439]  __local_bh_enable_ip+0x59/0x60
> > > > > [ 6756.008490]  tun_get_user+0xe87/0xfd0 [tun]
> > > > > [ 6756.011511]  tun_chr_write_iter+0x4d/0x70 [tun]
> > > > > [ 6756.014874]  do_iter_readv_writev+0x177/0x1b0
> > > > > [ 6756.018061]  do_iter_write+0x87/0x1b0
> > > > > [ 6756.020557]  vfs_writev+0x83/0x100
> > > > > [ 6756.022790]  ? do_vfs_ioctl+0x8e/0x620
> > > > > [ 6756.025408]  ? do_writev+0x51/0xe0
> > > > > [ 6756.027637]  ? ksys_ioctl+0x6f/0x90
> > > > > [ 6756.029948]  do_writev+0x51/0xe0
> > > > > [ 6756.032003]  do_syscall_64+0x54/0x280
> > > > > [ 6756.034505]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > > [ 6756.038406] RIP: 0033:0x7f2ef20a72f0
> > > > > [ 6756.040811] Code: 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 09 39 01 00
> > > > 48
> > > > > 63 54 24 1c 41 89 c0 48 8b 74 24 10 48 63 7c 24 08 b8 14 00 00 00 0f 05
> > > > > <48> 3d 00 f0 ff ff 77 17 44 89 c7 48 89 44 24 08 e8 3b 39 01 00 48
> > > > > [ 6756.058563] RSP: 002b:00007fffbd748e20 EFLAGS: 00000293 ORIG_RAX:
> > > > > 0000000000000014
> > > > > [ 6756.064967] RAX: ffffffffffffffda RBX: 000055a3ce26ecd0 RCX:
> > > > > 00007f2ef20a72f0
> > > > > [ 6756.070940] RDX: 0000000000000001 RSI: 000055a3ce259e38 RDI:
> > > > > 0000000000000012
> > > > > [ 6756.076909] RBP: 000055a3ce26ecd0 R08: 0000000000000000 R09:
> > > > > 000055a3cd0715c0
> > > > > [ 6756.082881] R10: 0000000000000001 R11: 0000000000000293 R12:
> > > > > 0000000000000001
> > > > > [ 6756.088848] R13: 000055a3ce259e38 R14: 000055a3ce259e38 R15:
> > > > > 0000000000000001
> > > > > [ 6756.094813] ---[ end trace a91e624ca8f4292c ]---
> > > > > [ 6756.098429] mlx5_core 0000:13:00.1 eth1: TX timeout detected
> > > > > [ 6756.102952] mlx5_core 0000:13:00.1 eth1: TX timeout on queue: 19, SQ:
> > > > > 0xab6, CQ: 0xd4a, SQ Cons: 0x3fd7 SQ Prod: 0x3fe6, usecs since last
> > > > trans:
> > > > > 27541000
> > > > > [ 6756.115632] mlx5_core 0000:13:00.1 eth1: EQ 0x1a: Cons = 0x9c0e, irqn
> > > > =
> > > > > 0x120
> > > > > [ 6775.300229] rcu: INFO: rcu_sched self-detected stall on CPU
> > > > > [ 6775.304787] rcu: 85-....: (59999 ticks this GP)
> > > > > idle=ca2/1/0x4000000000000002 softirq=7985603/7985603 fqs=14090
> > > > > [ 6775.313959] (t=60013 jiffies g=687873 q=106209)
> > > > > [ 6775.317527] NMI backtrace for cpu 85
> > > > > [ 6775.319932] CPU: 85 PID: 23160 Comm: ebtables Tainted: G        W
> > > > >   5.5.9-1 #1
> > > > > [ 6775.326520] Hardware name: Supermicro Super Server/H11DSi-NT, BIOS 1.1
> > > > > 04/13/2018
> > > > > [ 6775.332839] Call Trace:
> > > > > [ 6775.334112]  <IRQ>
> > > > > [ 6775.334957]  dump_stack+0x50/0x6b
> > > > > [ 6775.337099]  nmi_cpu_backtrace+0x90/0xa0
> > > > > [ 6775.339848]  ? lapic_can_unplug_cpu+0xa0/0xa0
> > > > > [ 6775.343038]  nmi_trigger_cpumask_backtrace+0x6f/0x100
> > > > > [ 6775.346926]  rcu_dump_cpu_stacks+0x8f/0xbf
> > > > > [ 6775.349849]  rcu_sched_clock_irq+0x517/0x790
> > > > > [ 6775.352947]  ? tick_init_highres+0x20/0x20
> > > > > [ 6775.355875]  update_process_times+0x24/0x50
> > > > > [ 6775.358891]  tick_sched_timer+0x51/0x160
> > > > > [ 6775.361654]  __hrtimer_run_queues+0xec/0x260
> > > > > [ 6775.364764]  hrtimer_interrupt+0x122/0x270
> > > > > [ 6775.367689]  ? rcu_irq_enter+0x35/0x110
> > > > > [ 6775.370498]  smp_apic_timer_interrupt+0x6a/0x140
> > > > > [ 6775.373951]  apic_timer_interrupt+0xf/0x20
> > > > > [ 6775.376887]  </IRQ>
> > > > > [ 6775.377810] RIP: 0010:queued_write_lock_slowpath+0x51/0x80
> > > > > [ 6775.382133] Code: ff 00 00 00 f0 0f b1 13 85 c0 74 32 f0 81 03 00 01
> > > > 00
> > > > > 00 ba ff 00 00 00 b9 00 01 00 00 8b 03 3d 00 01 00 00 74 0b f3 90 8b 03
> > > > > <3d> 00 01 00 00 75 f5 89 c8 f0 0f b1 13 3d 00 01 00 00 75 df c6 43
> > > > > [ 6775.399890] RSP: 0018:ffff8df85fc9bc70 EFLAGS: 00000206 ORIG_RAX:
> > > > > ffffffffffffff13
> > > > > [ 6775.406369] RAX: 0000000000003b00 RBX: ffff8b3d8743b39c RCX:
> > > > > 0000000000000100
> > > > > [ 6775.412419] RDX: 00000000000000ff RSI: ffff8df824d4c000 RDI:
> > > > > ffff8b3d8743b3a0
> > > > > [ 6775.418504] RBP: ffff8b3d8743b39c R08: 000ffffffffff000 R09:
> > > > > 0000000000000000
> > > > > [ 6775.424528] R10: ffff8df824d4c000 R11: 000000000000000a R12:
> > > > > ffff8df824d42000
> > > > > [ 6775.430505] R13: 00000000000009f3 R14: ffff8df8f73d5080 R15:
> > > > > 00000000013ea8d0
> > > > > [ 6775.436513]  copy_counters_to_user.part.13+0x3d/0xa0
> > > > > [ 6775.440364]  copy_everything_to_user+0x4ca/0x510
> > > > > [ 6775.443813]  do_ebt_get_ctl+0x9a/0x1b0
> > > > > [ 6775.446487]  ? mem_cgroup_commit_charge+0x4a/0xa0
> > > > > [ 6775.450027]  nf_getsockopt+0x48/0x60
> > > > > [ 6775.452496]  ip_getsockopt+0x6d/0xb0
> > > > > [ 6775.454906]  __sys_getsockopt+0x8d/0x100
> > > > > [ 6775.457662]  __x64_sys_getsockopt+0x20/0x30
> > > > > [ 6775.460673]  do_syscall_64+0x54/0x280
> > > > > [ 6775.463172]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > > [ 6775.467056] RIP: 0033:0x7f35e1d9f40a
> > > > > [ 6775.469520] Code: 48 8b 0d 81 ba 2b 00 f7 d8 64 89 01 48 83 c8 ff c3
> > > > 66
> > > > > 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 37 00 00 00 0f 05
> > > > > <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4e ba 2b 00 f7 d8 64 89 01 48
> > > > > [ 6775.487403] RSP: 002b:00007fff5491c5e8 EFLAGS: 00000217 ORIG_RAX:
> > > > > 0000000000000037
> > > > > [ 6775.493810] RAX: ffffffffffffffda RBX: 00007fff5491c630 RCX:
> > > > > 00007f35e1d9f40a
> > > > > [ 6775.499781] RDX: 0000000000000081 RSI: 0000000000000000 RDI:
> > > > > 0000000000000003
> > > > > [ 6775.505750] RBP: 0000000000000000 R08: 00007fff5491c6ac R09:
> > > > > 0000000000000000
> > > > > [ 6775.511720] R10: 00007fff5491c630 R11: 0000000000000217 R12:
> > > > > 00007f35e509a648
> > > > > [ 6775.517695] R13: 00007fff5491c6ac R14: 0000000000000000 R15:
> > > > > 0000000000000000
> > > > >
> > > > > ______________________________________
> > > > > *Salvador Carrasco*  |  Manager of Systems Operations  |  Linode
> > > > > w: linode.com  |  e: scarrasco@linode.com
> > > > > p: 609-380-7100 ext.1310 <(609)%20380-7100>
> > > >
