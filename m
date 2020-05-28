Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5176BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3E5207F9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590682318;
	bh=wow4AwZ0y6jmRsE8Pejh7pngrZjzlsMrue88hod8TzI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=sy/O8ECsdFV17prrP0TLR9XPiMICkfKHaG63bsyDoo8qRTjSwyJzAkHaI70bWVcSC
	 anrKhYk7dmVMu8l2Zvs4mGtTfT7uYKQ9glhafImpZLnWXwbhoPCBQ0VQp6JSMfcsRd
	 gSlL/qpS8CP0YFWbFwI6Lx5vzoL6Un20z7w7p09c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404916AbgE1QLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 12:11:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404861AbgE1QLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:11:44 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD18F2071A;
        Thu, 28 May 2020 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590682303;
        bh=wow4AwZ0y6jmRsE8Pejh7pngrZjzlsMrue88hod8TzI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xvsjf0TmRtzl3nMOMdmZURRQbtrfzx5DeT+5Hucl7tN25Xhs4eGF1SgvjsnOprN2y
         QhlheOBYm2vErm29TDU6RCXABuyrJPBvJPiZiGY9Rmh1yYzsHatc0NfxsGzlCGcs0a
         X8ku4VXfKL+KJ0vIxdRzYCbtM4e4Ve827qKp00Ac=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BF24835228F0; Thu, 28 May 2020 09:11:43 -0700 (PDT)
Date:   Thu, 28 May 2020 09:11:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+3ae5eaae0809ee311e75@syzkaller.appspotmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>, bp@alien8.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com, x86@kernel.org
Subject: Re: WARNING: suspicious RCU usage in idtentry_exit
Message-ID: <20200528161143.GF2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <000000000000840d4d05a6850c73@google.com>
 <87wo4wnpzb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo4wnpzb.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 03:33:44PM +0200, Thomas Gleixner wrote:
> syzbot <syzbot+3ae5eaae0809ee311e75@syzkaller.appspotmail.com> writes:
> 
> + Paolo, Paul
> 
> > syzbot found the following crash on:
> >
> > HEAD commit:    7b4cb0a4 Add linux-next specific files for 20200525
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13356016100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=47b0740d89299c10
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3ae5eaae0809ee311e75
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+3ae5eaae0809ee311e75@syzkaller.appspotmail.com
> >
> > =============================
> > WARNING: suspicious RCU usage
> > 5.7.0-rc7-next-20200525-syzkaller #0 Not tainted
> > -----------------------------
> > kernel/rcu/tree.c:715 RCU dynticks_nesting counter underflow/zero!!

So the nesting counter overflowed or got clobbered to either zero
or some negative number.  The usual cause of this is a misnesting of
rcu_nmi_enter() and rcu_nmi_exit().

If this were reproducible, I would suggest tracking this down by enabling
the rcu_dyntick trace event.  :-/

> > other info that might help us debug this:
> >
> >
> > RCU used illegally from idle CPU!

This might indicate that the aforementioned mismatch was having invoked
rcu_nmi_exit() in an exception that never invoked rcu_nmi_enter().
In this case, the lack of the rcu_nmi_enter() would leave the CPU
looking idle to RCU, and then the call to rcu_nmi_exit() would result in
a negative counter.  But I would have expected a pair of earlier splats
from rcu_nmi_exit() in that case:

	WARN_ON_ONCE(rdp->dynticks_nesting <= 0);
	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());

So another hypothesis is that neither rcu_nmi_enter() nor rcu_nmi_exit()
were invoked, leaving the ->dynticks_nesting counter at the value zero,
in turn causing rcu_irq_exit_preempt() to complain.

> > rcu_scheduler_active = 2, debug_locks = 1
> > RCU used illegally from extended quiescent state!

Huh.  This is a bit repetitive, isn't it?  I just queued a patch to say this
only once.  </distraction>

> > no locks held by syz-executor.5/24641.
> >
> > stack backtrace:
> > CPU: 1 PID: 24641 Comm: syz-executor.5 Not tainted 5.7.0-rc7-next-20200525-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x18f/0x20d lib/dump_stack.c:118
> >  rcu_irq_exit_preempt+0x1fa/0x250 kernel/rcu/tree.c:715
> >  idtentry_exit+0x9e/0xc0 arch/x86/entry/common.c:583
> >  exc_general_protection+0x23d/0x520 arch/x86/kernel/traps.c:506
> >  asm_exc_general_protection+0x1e/0x30 arch/x86/include/asm/idtentry.h:353
> > RIP: 0010:kvm_fastop_exception+0xb68/0xfe8
> > Code: f2 ff ff ff 48 31 db e9 fb c9 2a f9 b8 f2 ff ff ff 48 31 f6 e9 ff c9 2a f9 31 c0 e9 ec 2c 2b f9 b8 fb ff ff ff e9 13 a9 31 f9 <b9> fb ff ff ff 31 c0 31 d2 e9 33 a9 31 f9 31 db e9 2a 0b 42 f9 31
> > RSP: 0018:ffffc90004a87a30 EFLAGS: 00010212
> > RAX: 0000000000040000 RBX: ffff88809cca4080 RCX: 0000000000000122
> > RDX: 00000000000063ff RSI: ffffc90004a87a98 RDI: 0000000000000122
> > RBP: 0000000000000122 R08: ffff888058486480 R09: fffffbfff131f481
> > R10: ffffffff898fa403 R11: fffffbfff131f480 R12: 0000000000000122
> > R13: 0000000000000078 R14: 0000000000000006 R15: ffffffff88244b5c
> >  paravirt_read_msr_safe arch/x86/include/asm/paravirt.h:178 [inline]
> >  vmx_create_vcpu+0x184/0x2b40 arch/x86/kvm/vmx/vmx.c:6827
> >  kvm_arch_vcpu_create+0x6a8/0xb30 arch/x86/kvm/x86.c:9427
> >  kvm_vm_ioctl_create_vcpu arch/x86/kvm/../../../virt/kvm/kvm_main.c:3043 [inline]
> >  kvm_vm_ioctl+0x15b7/0x2460 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3603
> >  vfs_ioctl fs/ioctl.c:48 [inline]
> >  ksys_ioctl+0x11a/0x180 fs/ioctl.c:753
> >  __do_sys_ioctl fs/ioctl.c:762 [inline]
> >  __se_sys_ioctl fs/ioctl.c:760 [inline]
> >  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:760
> >  do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:353
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > RIP: 0033:0x45ca29
> > Code: 0d b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007f2c93b11c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00000000004e73c0 RCX: 000000000045ca29
> > RDX: 0000000000000000 RSI: 000000000000ae41 RDI: 0000000000000004
> > RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> > R13: 0000000000000396 R14: 00000000004c62c6 R15: 00007f2c93b126d4
> 
> Weird. I have no idea how that thing is an EQS here.

No argument on the "Weird" part!  ;-)

Is this a NO_HZ_FULL=y kernel?  If so, one possibility is that the call
to rcu_user_exit() went missing somehow.  If not, then RCU should have
been watching userspace execution.

Again, the only thing I can think of (should this prove to be
reproducible) is the rcu_dyntick trace event.

							Thanx, Paul
