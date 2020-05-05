Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FFAC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B3720675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbgEEOS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730144AbgEEOQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB618C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:37 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyMv-0002EZ-0E; Tue, 05 May 2020 16:16:21 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 8BB0FFFC8D;
        Tue,  5 May 2020 16:16:20 +0200 (CEST)
Message-Id: <20200505135341.730586321@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:53:41 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 5 00/31] x86/entry: Entry/exception code rework,
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#PF/interrupts/system vectors

Folks!

This is the fifth part of the rework series. Part 4 can be found here:

 https://lore.kernel.org/r/20200505134926.578885807@linutronix.de

The series has a total of 138 patches and is split into 5 parts. The base
for this 5th series is:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v4-part-4

The fifth part, i.e. the full series is available from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v4-part-5
 
This part contains the modifications for interrupts and exceptions and the
final cleanups:

 - Conversion of the pagefault handler including conditional RCU entry
   handling which is also utilized for the optimized handling of the
   rescheduling IPI.

 - Conversion of interrupt and system vector handling to utilize the
   exception and traps entry code instead of having a completely separate
   implementation for no reason.

 - Moving the interrupt stack switching into C code to simplify the
   ordering vs. the entry mechanics.

 - Final cleanup and removal of all the ASM IRQ tracing maze.

At the end this removes 750 lines of ASM and macro maze.

The objtool check for the noinstr.text correctness is not yet added to the
build machinery and has to be invoked manually for now:

   objtool check -fal vmlinux.o

The checking only works for builtin code as objtool cannot do a combined
analysis of vmlinux.o and a module.o

Known issues:

   There is an issue with the framepointer based unwinder. objtool
   complains about inconsistent stack state, and the actual unwinding
   accross a stack boundary contains the '?' markers. This is due to the
   stack switching in C inline ASM. The problem is halfways understood and
   worked on. This does not affect the rest of the series and will be fixed
   in the next days. With ORC both objtool and the actual unwinding works
   correctly.

Thanks,

	tglx

8<----------
 arch/x86/include/asm/acrn.h                |   11 
 arch/x86/include/asm/entry_arch.h          |   56 --
 b/arch/x86/entry/calling.h                 |   25 -
 b/arch/x86/entry/common.c                  |  203 +++++++++-
 b/arch/x86/entry/entry_32.S                |  260 +------------
 b/arch/x86/entry/entry_64.S                |  543 +----------------------------
 b/arch/x86/entry/thunk_64.S                |    9 
 b/arch/x86/hyperv/hv_init.c                |    9 
 b/arch/x86/include/asm/apic.h              |   33 -
 b/arch/x86/include/asm/hw_irq.h            |   22 -
 b/arch/x86/include/asm/idtentry.h          |  248 +++++++++++++
 b/arch/x86/include/asm/irq.h               |    6 
 b/arch/x86/include/asm/irq_stack.h         |   91 ++++
 b/arch/x86/include/asm/irq_work.h          |    1 
 b/arch/x86/include/asm/irqflags.h          |   10 
 b/arch/x86/include/asm/mshyperv.h          |   13 
 b/arch/x86/include/asm/trace/common.h      |    4 
 b/arch/x86/include/asm/trace/irq_vectors.h |   17 
 b/arch/x86/include/asm/traps.h             |   21 -
 b/arch/x86/include/asm/uv/uv_bau.h         |    8 
 b/arch/x86/kernel/apic/apic.c              |   39 +-
 b/arch/x86/kernel/apic/msi.c               |    3 
 b/arch/x86/kernel/apic/vector.c            |    5 
 b/arch/x86/kernel/cpu/acrn.c               |    9 
 b/arch/x86/kernel/cpu/mce/amd.c            |    5 
 b/arch/x86/kernel/cpu/mce/therm_throt.c    |    5 
 b/arch/x86/kernel/cpu/mce/threshold.c      |    5 
 b/arch/x86/kernel/cpu/mshyperv.c           |   22 -
 b/arch/x86/kernel/head_64.S                |    7 
 b/arch/x86/kernel/idt.c                    |   42 +-
 b/arch/x86/kernel/irq.c                    |   46 --
 b/arch/x86/kernel/irq_64.c                 |   54 ++
 b/arch/x86/kernel/irq_work.c               |    6 
 b/arch/x86/kernel/kvm.c                    |   14 
 b/arch/x86/kernel/nmi.c                    |   11 
 b/arch/x86/kernel/smp.c                    |   59 +--
 b/arch/x86/kernel/tracepoint.c             |   17 
 b/arch/x86/mm/fault.c                      |   69 ++-
 b/arch/x86/platform/uv/tlb_uv.c            |    2 
 b/arch/x86/xen/enlighten_hvm.c             |   12 
 b/arch/x86/xen/enlighten_pv.c              |    2 
 b/arch/x86/xen/setup.c                     |    4 
 b/arch/x86/xen/smp_pv.c                    |    3 
 b/arch/x86/xen/xen-asm_32.S                |   12 
 b/arch/x86/xen/xen-asm_64.S                |    4 
 b/arch/x86/xen/xen-ops.h                   |    1 
 b/drivers/xen/events/events_base.c         |    6 
 b/drivers/xen/preempt.c                    |    2 
 b/include/linux/hardirq.h                  |   31 +
 b/include/xen/events.h                     |    7 
 b/include/xen/xen-ops.h                    |    4 
 b/kernel/softirq.c                         |   35 +
 52 files changed, 920 insertions(+), 1213 deletions(-)


