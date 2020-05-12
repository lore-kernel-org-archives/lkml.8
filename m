Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65597C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 440A823129
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbgELWXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727971AbgELWXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:23:04 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10824C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:23:04 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jYdI2-0004b1-Vi; Wed, 13 May 2020 00:22:20 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 4120A1001FC;
        Wed, 13 May 2020 00:22:18 +0200 (CEST)
Message-Id: <20200512210059.056244513@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 12 May 2020 23:00:59 +0200
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V5 00/38] x86/entry: Entry/exception code rework - the leftovers
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks!

This is V5 of the rework series. V4 can be found here:

  https://lore.kernel.org/r/20200505135341.730586321@linutronix.de

Some of the non-x86 specific parts from part 1- 4 have been applied to the
relevant tip branches and I merged them all together to base the rest on.

I have applied most of the patches from part 1-4 on top after fixing up the
small review comments all over the place. The result can be found here:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-base-v5

I dropped:

  [patch V4 part 1 33/36] x86,tracing: Robustify ftrace_nmi_enter()
  [patch V4 part 2 10/18] x86/entry/64: Check IF in __preempt_enable_notrace()
  [patch V4 part 2 11/18] x86/entry/64: Mark ___preempt_schedule_notrace()

from V4 because Peter's attempt to sanitize ftrace_nmi_enter/exit() and the
underlying callchains turned out to be incomplete and cause the whole
__preempt_schedule_notrace() hackery which is caused by a gazillion of
preempt_disable_notrace() / preempt_enable_notrace() invocations in the
full call chain. I found a better way to do that and that's in part 5 now.

The remaining patches are mostly from part 5 of version 4 dealing with the
#PF, device interrupts and the system vectors.

The main differences to V4 part 5 are:

  - Provide nmi_enter/exit_notrace() which do not contain the
    ftrace_nmi_enter/exit() calls, use them in x86 and make the ftrace
    invocation explicit at a safe place.

  - A fix for the reworked SVM code

  - An optimization of asm_native_load_gs_index() which I found while
    staring at stuff in more detail

  - The removal of the x86 specific irq_regs implementation which was
    aside of two underscores in the variable name exactly the same thing
    as the generic variant.

  - Overhaul of the IRQ stack switching mechanics to avoid the objtool and
    unwinder nastiness of doing it in C inline ASM. As discussed here:

    https://lore.kernel.org/r/20200507161020.783541450@infradead.org

    We agreed on having the actual stack switch still in ASM and utilize it
    for device interrupts, soft interrupts and system vectors.

    This comes for the price of an indirect call, but the device interrupt
    handling has an indirect call and soft interrupts and most system
    vectors are indirect call laden already.

    There is a lightweight variant for the system vectors which do
    basically nothing, i.e. reschedule IPI and the KVM posted interrupt
    vectors. That variant runs on the interrupted stack and avoids the
    full entry/exit handling overhead by utilizing the conditional RCU
    variant of idtentry_enter/exit().

  - Addressing a few review comments.

The series is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v5-the-rest

Running the new objtool checks results in two warning types:

  - The MCE code has an issue in the non-instrumentable section which is
    still under investigation and discussion

  - When paravirt is enabled then there are a few complaints about
    invoking indirect calls (PVOPS) which leave the noinstr sections
    but they are halfways straight forward to fix.

Thanks,

	tglx

8<--------------

 arch/x86/include/asm/acrn.h                |   11 
 arch/x86/include/asm/entry_arch.h          |   56 --
 arch/x86/include/asm/irq_regs.h            |   32 -
 b/arch/x86/entry/calling.h                 |   25 -
 b/arch/x86/entry/common.c                  |  216 +++++++++-
 b/arch/x86/entry/entry_32.S                |  260 +-----------
 b/arch/x86/entry/entry_64.S                |  581 +++--------------------------
 b/arch/x86/entry/thunk_64.S                |    9 
 b/arch/x86/hyperv/hv_init.c                |    9 
 b/arch/x86/include/asm/apic.h              |   33 -
 b/arch/x86/include/asm/hw_irq.h            |   22 -
 b/arch/x86/include/asm/idtentry.h          |  262 ++++++++++++-
 b/arch/x86/include/asm/irq.h               |    6 
 b/arch/x86/include/asm/irq_stack.h         |   40 +
 b/arch/x86/include/asm/irq_work.h          |    1 
 b/arch/x86/include/asm/irqflags.h          |   10 
 b/arch/x86/include/asm/mshyperv.h          |   13 
 b/arch/x86/include/asm/trace/common.h      |    4 
 b/arch/x86/include/asm/trace/irq_vectors.h |   17 
 b/arch/x86/include/asm/traps.h             |   21 -
 b/arch/x86/include/asm/uv/uv_bau.h         |    8 
 b/arch/x86/kernel/apic/apic.c              |   39 -
 b/arch/x86/kernel/apic/msi.c               |    3 
 b/arch/x86/kernel/apic/vector.c            |    5 
 b/arch/x86/kernel/cpu/acrn.c               |    9 
 b/arch/x86/kernel/cpu/mce/amd.c            |    5 
 b/arch/x86/kernel/cpu/mce/core.c           |    4 
 b/arch/x86/kernel/cpu/mce/therm_throt.c    |    5 
 b/arch/x86/kernel/cpu/mce/threshold.c      |    5 
 b/arch/x86/kernel/cpu/mshyperv.c           |   22 -
 b/arch/x86/kernel/head_64.S                |    7 
 b/arch/x86/kernel/idt.c                    |   42 +-
 b/arch/x86/kernel/irq.c                    |   58 --
 b/arch/x86/kernel/irq_64.c                 |   17 
 b/arch/x86/kernel/irq_work.c               |    6 
 b/arch/x86/kernel/kvm.c                    |   14 
 b/arch/x86/kernel/nmi.c                    |    9 
 b/arch/x86/kernel/smp.c                    |   37 -
 b/arch/x86/kernel/tracepoint.c             |   17 
 b/arch/x86/kernel/traps.c                  |   10 
 b/arch/x86/kvm/svm/svm.c                   |    2 
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
 b/include/linux/hardirq.h                  |   51 ++
 b/include/linux/rcutiny.h                  |    1 
 b/include/linux/rcutree.h                  |    1 
 b/include/xen/events.h                     |    7 
 b/include/xen/xen-ops.h                    |    7 
 b/kernel/rcu/tree.c                        |    5 
 b/kernel/softirq.c                         |   35 +
 59 files changed, 906 insertions(+), 1270 deletions(-)

