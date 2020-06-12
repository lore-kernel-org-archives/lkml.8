Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D454FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 10:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8402074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 10:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgFMKtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 06:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgFMKs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 06:48:59 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDA2C08C5C1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 03:48:59 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jk3iZ-0007xB-CR; Sat, 13 Jun 2020 12:48:55 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id B836D100D1F;
        Sat, 13 Jun 2020 12:48:54 +0200 (CEST)
Date:   Fri, 12 Jun 2020 22:05:05 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT pull resend] x86/entry for v5.8
References: <159199950433.21782.7922990856385499228.tglx@nanos.tec.linutronix.de>
Message-ID: <159199950554.21782.7550706843970155617.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/entry branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2020-06-12

up to:  0bf3924bfabd: x86/entry: Force rcu_irq_enter() when in idle task

It has been rebased and distangled as requested and is now based on

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-06-11

which you merged yesterday.

The X86 entry, exception and interrupt code rework

This all started about 6 month ago with the attempt to move the Posix CPU
timer heavy lifting out of the timer interrupt code and just have lockless
quick checks in that code path. Trivial 5 patches.

This unearthed an inconsistency in the KVM handling of task work and the
review requested to move all of this into generic code so other
architectures can share.

Valid request and solved with another 25 patches but those unearthed
inconsistencies vs. RCU and instrumentation.

Digging into this made it obvious that there are quite some inconsistencies
vs. instrumentation in general. The int3 text poke handling in particular
was completely unprotected and with the batched update of trace events even
more likely to expose to endless int3 recursion.

In parallel the RCU implications of instrumenting fragile entry code came
up in several discussions.

The conclusion of the X86 maintainer team was to go all the way and make
the protection against any form of instrumentation of fragile and dangerous
code pathes enforcable and verifiable by tooling.

A first batch of preparatory work hit mainline with commit d5f744f9a2ac.

The (almost) full solution introduced a new code section '.noinstr.text'
into which all code which needs to be protected from instrumentation of all
sorts goes into. Any call into instrumentable code out of this section has
to be annotated. objtool has support to validate this. Kprobes now excludes
this section fully which also prevents BPF from fiddling with it and all
'noinstr' annotated functions also keep ftrace off. The section, kprobes
and objtool changes are already merged.

The major changes coming with this are:

    - Preparatory cleanups

    - Annotating of relevant functions to move them into the noinstr.text
      section or enforcing inlining by marking them __always_inline so the
      compiler cannot misplace or instrument them.

    - Splitting and simplifying the idtentry macro maze so that it is now
      clearly separated into simple exception entries and the more
      interesting ones which use interrupt stacks and have the paranoid
      handling vs. CR3 and GS.

    - Move quite some of the low level ASM functionality into C code:

       - enter_from and exit to user space handling. The ASM code now calls
         into C after doing the really necessary ASM handling and the return
	 path goes back out without bells and whistels in ASM.

       - exception entry/exit got the equivivalent treatment

       - move all IRQ tracepoints from ASM to C so they can be placed as
         appropriate which is especially important for the int3 recursion
         issue.

    - Consolidate the declaration and definition of entry points between 32
      and 64 bit. They share a common header and macros now.

    - Remove the extra device interrupt entry maze and just use the regular
      exception entry code.

    - All ASM entry points except NMI are now generated from the shared header
      file and the corresponding macros in the 32 and 64 bit entry ASM.

    - The C code entry points are consolidated as well with the help of
      DEFINE_IDTENTRY*() macros. This allows to ensure at one central point
      that all corresponding entry points share the same semantics. The
      actual function body for most entry points is in an instrumentable
      and sane state.

      There are special macros for the more sensitive entry points,
      e.g. INT3 and of course the nasty paranoid #NMI, #MCE, #DB and #DF.
      They allow to put the whole entry instrumentation and RCU handling
      into safe places instead of the previous pray that it is correct
      approach.

    - The INT3 text poke handling is now completely isolated and the
      recursion issue banned. Aside of the entry rework this required other
      isolation work, e.g. the ability to force inline bsearch.

    - Prevent #DB on fragile entry code, entry relevant memory and disable
      it on NMI, #MC entry, which allowed to get rid of the nested #DB IST
      stack shifting hackery.

    - A few other cleanups and enhancements which have been made possible
      through this and already merged changes, e.g. consolidating and
      further restricting the IDT code so the IDT table becomes RO after
      init which removes yet another popular attack vector

    - About 680 lines of ASM maze are gone.

There are a few open issues:

   - An escape out of the noinstr section in the MCE handler which needs
     some more thought but under the aspect that MCE is a complete
     trainwreck by design and the propability to survive it is low, this was
     not high on the priority list.

   - Paravirtualization

     When PV is enabled then objtool complains about a bunch of indirect
     calls out of the noinstr section. There are a few straight forward
     ways to fix this, but the other issues vs. general correctness were
     more pressing than parawitz.

   - KVM

     KVM is inconsistent as well. Patches have been posted, but they have
     not yet been commented on or picked up by the KVM folks.

   - IDLE

     Pretty much the same problems can be found in the low level idle code
     especially the parts where RCU stopped watching. This was beyond the
     scope of the more obvious and exposable problems and is on the todo
     list.

The lesson learned from this brain melting exercise to morph the evolved
code base into something which can be validated and understood is that once
again the violation of the most important engineering principle
"correctness first" has caused quite a few people to spend valuable time on
problems which could have been avoided in the first place. The "features
first" tinkering mindset really has to stop.

With that I want to say thanks to everyone involved in contributing to this
effort. Special thanks go to the following people (alphabetical order):

   Alexandre Chartre
   Andy Lutomirski
   Borislav Petkov
   Brian Gerst
   Frederic Weisbecker
   Josh Poimboeuf
   Juergen Gross
   Lai Jiangshan 
   Macro Elver
   Paolo Bonzini
   Paul McKenney
   Peter Zijlstra
   Vitaly Kuznetsov
   Will Deacon

Thanks,

	tglx

------------------>
Andy Lutomirski (2):
      x86/hw_breakpoint: Prevent data breakpoints on cpu_entry_area
      x86/entry: Treat BUG/WARN as NMI-like entries

Ingo Molnar (1):
      x86/entry: Fix allnoconfig build warning

Lai Jiangshan (7):
      x86/entry/64: Remove an unused label
      x86/entry/64: Remove unneeded kernel CR3 switching
      x86/idt: Remove address operator on function machine_check()
      x86/hw_breakpoint: Add within_area() to check data breakpoints
      x86/hw_breakpoint: Prevent data breakpoints on direct GDT
      x86/hw_breakpoint: Prevent data breakpoints on per_cpu cpu_tss_rw
      x86/hw_breakpoint: Prevent data breakpoints on user_pcid_flush_mask

Peter Zijlstra (22):
      x86/doublefault: Remove memmove() call
      x86/entry: Exclude low level entry code from sanitizing
      x86/entry: Make entry_64_compat.S objtool clean
      x86/int3: Avoid atomic instrumentation
      lib/bsearch: Provide __always_inline variant
      x86/int3: Inline bsearch()
      x86/traps: Split int3 handler up
      x86/db: Split out dr6/7 handling
      x86/entry: Introduce local_db_{save,restore}()
      x86/entry, nmi: Disable #DB
      x86/entry, mce: Disallow #DB during #MC
      x86/entry: Optimize local_db_save() for virt
      x86/entry: Remove debug IDT frobbing
      x86/entry: Remove DBn stacks
      x86/entry: Clarify irq_{enter,exit}_rcu()
      x86/entry: Rename trace_hardirqs_off_prepare()
      x86/entry: __always_inline debugreg for noinstr
      x86/entry: __always_inline irqflags for noinstr
      x86/entry: __always_inline arch_atomic_* for noinstr
      x86/entry: Re-order #DB handler to avoid *SAN instrumentation
      lockdep: __always_inline more for noinstr
      x86/entry: __always_inline CR2 for noinstr

Thomas Gleixner (106):
      x86/entry/64: Avoid pointless code when CONTEXT_TRACKING=n
      x86/entry: Remove the unused LOCKDEP_SYSEXIT cruft
      context_tracking: Ensure that the critical path cannot be instrumented
      lib/smp_processor_id: Move it into noinstr section
      bug: Annotate WARN/BUG/stackfail as noinstr safe
      x86/idt: Remove update_intr_gate()
      x86/entry/64: Move non entry code into .text section
      x86/entry/32: Move non entry code into .text section
      x86/entry: Mark enter_from_user_mode() noinstr
      x86/entry/common: Protect against instrumentation
      x86/entry: Move irq tracing on syscall entry to C-code
      x86/entry: Move irq flags tracing to prepare_exit_to_usermode()
      x86/speculation/mds: Mark mds_user_clear_cpu_buffers() __always_inline
      x86/traps: Mark fixup_bad_iret() noinstr
      x86/traps: Mark sync_regs() noinstr
      x86/entry: Disable interrupts for native_load_gs_index() in C code
      x86/entry/64: Use native swapgs in asm_load_gs_index()
      x86/traps: Make interrupt enable/disable symmetric in C code
      x86/traps: Split trap numbers out in a separate header
      x86/entry/64: Reorder idtentries
      x86/entry: Distangle idtentry
      x86/entry/64: Provide sane error entry/exit
      x86/entry/32: Provide macro to emit IDT entry stubs
      x86/idtentry: Provide macros to define/declare IDT entry points
      x86/entry/common: Provide idtentry_enter/exit()
      x86/traps: Prepare for using DEFINE_IDTENTRY
      x86/entry: Convert Divide Error to IDTENTRY
      x86/entry: Convert Overflow exception to IDTENTRY
      x86/entry: Convert Bounds exception to IDTENTRY
      x86/entry: Convert Invalid Opcode exception to IDTENTRY
      x86/entry: Convert Device not available exception to IDTENTRY
      x86/entry: Convert Coprocessor segment overrun exception to IDTENTRY
      x86/idtentry: Provide IDTENTRY_ERRORCODE
      x86/entry: Convert Invalid TSS exception to IDTENTRY
      x86/entry: Convert Segment not present exception to IDTENTRY
      x86/entry: Convert Stack segment exception to IDTENTRY
      x86/entry: Convert General protection exception to IDTENTRY
      x86/entry: Convert Spurious interrupt bug exception to IDTENTRY
      x86/entry: Convert Coprocessor error exception to IDTENTRY
      x86/entry: Convert Alignment check exception to IDTENTRY
      x86/entry: Convert SIMD coprocessor error exception to IDTENTRY
      x86/entry/32: Convert IRET exception to IDTENTRY_SW
      x86/int3: Ensure that poke_int3_handler() is not traced
      x86/idtentry: Provide IDTENTRY_RAW
      x86/entry: Convert INT3 exception to IDTENTRY_RAW
      x86/idtentry: Provide IDTENTRY_IST
      x86/mce: Move nmi_enter/exit() into the entry point
      x86/entry: Convert Machine Check to IDTENTRY_IST
      x86/mce: Use untraced rd/wrmsr in the MCE offline/crash check
      x86/idtentry: Provide IDTENTRY_XEN for XEN/PV
      x86/entry: Convert NMI to IDTENTRY_NMI
      x86/nmi: Protect NMI entry against instrumentation
      x86/entry: Convert Debug exception to IDTENTRY_DB
      x86/entry/64: Remove error code clearing from #DB and #MCE ASM stub
      x86/idtentry: Provide IDTRENTRY_NOIST variants for #DB and #MC
      x86/entry: Implement user mode C entry points for #DB and #MCE
      x86/traps: Restructure #DB handling
      x86/traps: Address objtool noinstr complaints in #DB
      x86/mce: Address objtools noinstr complaints
      x86/idtentry: Provide IDTENTRY_DF
      x86/entry: Convert double fault exception to IDTENTRY_DF
      nmi, tracing: Make hardware latency tracing noinstr safe
      x86/entry: Provide idtentry_entry/exit_cond_rcu()
      x86/entry: Provide idtentry_enter/exit_user()
      x86/idtentry: Switch to conditional RCU handling
      x86/entry: Clean up idtentry_enter/exit() leftovers
      genirq: Provide irq_enter/exit_rcu()
      genirq: Provide __irq_enter/exit_raw()
      x86/entry: Provide helpers for executing on the irqstack
      x86/entry/64: Move do_softirq_own_stack() to C
      x86/entry: Split out idtentry_exit_cond_resched()
      x86/entry: Switch XEN/PV hypercall entry to IDTENTRY
      x86/entry/64: Simplify idtentry_body
      x86/entry: Switch page fault exception to IDTENTRY_RAW
      x86/entry: Remove the transition leftovers
      x86/entry: Change exit path of xen_failsafe_callback
      x86/entry/64: Remove error_exit()
      x86/entry/32: Remove common_exception()
      x86/irq: Use generic irq_regs implementation
      x86/irq: Convey vector as argument and not in ptregs
      x86/irq: Rework handle_irq() for 64-bit
      x86/entry: Add IRQENTRY_IRQ macro
      x86/entry: Use idtentry for interrupts
      x86/entry: Provide IDTENTRY_SYSVEC
      x86/entry: Convert APIC interrupts to IDTENTRY_SYSVEC
      x86/entry: Convert SMP system vectors to IDTENTRY_SYSVEC
      x86/entry: Convert various system vectors
      x86/entry: Convert KVM vectors to IDTENTRY_SYSVEC*
      x86/entry: Convert various hypervisor vectors to IDTENTRY_SYSVEC
      x86/entry: Convert XEN hypercall vector to IDTENTRY_SYSVEC
      x86/entry: Convert reschedule interrupt to IDTENTRY_SYSVEC_SIMPLE
      x86/entry: Remove the apic/BUILD interrupt leftovers
      x86/entry/64: Remove IRQ stack switching ASM
      x86/entry: Make enter_from_user_mode() static
      x86/entry/32: Remove redundant irq disable code
      x86/entry/64: Remove TRACE_IRQS_*_DEBUG
      x86/entry: Move paranoid irq tracing out of ASM code
      x86/entry: Remove the TRACE_IRQS cruft
      x86/idt: Mark init only functions __init
      x86/idt: Add comments about early #PF handling
      x86/idt: Use proper constants for table size
      x86/idt: Cleanup trap_init()
      x86/idt: Consolidate idt functionality
      x86/entry: Unbreak __irqentry_text_start/end magic
      x86/entry: Make NMI use IDTENTRY_RAW
      x86/entry: Force rcu_irq_enter() when in idle task

Vitaly Kuznetsov (4):
      x86/xen: Split HVM vector callback setup and interrupt gate allocation
      x86/idt: Annotate alloc_intr_gate() with __init
      x86/idt: Keep spurious entries unset in system_vectors
      xen: Move xen_setup_callback_vector() definition to include/xen/hvm.h

 arch/x86/include/asm/acrn.h              |   11 
 arch/x86/include/asm/entry_arch.h        |   56 -
 arch/x86/include/asm/irq_regs.h          |   32 -
 arch/x86/Kconfig                         |    1 
 arch/x86/entry/Makefile                  |    8 
 arch/x86/entry/calling.h                 |   25 
 arch/x86/entry/common.c                  |  419 ++++++++++++--
 arch/x86/entry/entry_32.S                |  485 ++++------------
 arch/x86/entry/entry_64.S                |  840 +++++++----------------------
 arch/x86/entry/entry_64_compat.S         |   55 -
 arch/x86/entry/thunk_64.S                |   14 
 arch/x86/hyperv/hv_init.c                |    9 
 arch/x86/include/asm/apic.h              |   33 -
 arch/x86/include/asm/atomic.h            |   14 
 arch/x86/include/asm/bug.h               |    3 
 arch/x86/include/asm/cpu_entry_area.h    |   12 
 arch/x86/include/asm/debugreg.h          |   48 +
 arch/x86/include/asm/desc.h              |   52 -
 arch/x86/include/asm/hw_irq.h            |   22 
 arch/x86/include/asm/idtentry.h          |  652 ++++++++++++++++++++++
 arch/x86/include/asm/irq.h               |   15 
 arch/x86/include/asm/irq_stack.h         |   53 +
 arch/x86/include/asm/irq_work.h          |    1 
 arch/x86/include/asm/irqflags.h          |   54 -
 arch/x86/include/asm/kvm_para.h          |    2 
 arch/x86/include/asm/mce.h               |    2 
 arch/x86/include/asm/mshyperv.h          |   13 
 arch/x86/include/asm/nospec-branch.h     |    4 
 arch/x86/include/asm/processor.h         |    2 
 arch/x86/include/asm/ptrace.h            |    2 
 arch/x86/include/asm/special_insns.h     |   22 
 arch/x86/include/asm/text-patching.h     |   11 
 arch/x86/include/asm/trace/common.h      |    4 
 arch/x86/include/asm/trace/irq_vectors.h |   17 
 arch/x86/include/asm/trapnr.h            |   31 +
 arch/x86/include/asm/traps.h             |  118 ----
 arch/x86/include/asm/uv/uv_bau.h         |    8 
 arch/x86/kernel/alternative.c            |   25 
 arch/x86/kernel/apic/apic.c              |   39 -
 arch/x86/kernel/apic/msi.c               |    3 
 arch/x86/kernel/apic/vector.c            |    5 
 arch/x86/kernel/asm-offsets_64.c         |    3 
 arch/x86/kernel/cpu/acrn.c               |    9 
 arch/x86/kernel/cpu/common.c             |   19 
 arch/x86/kernel/cpu/mce/amd.c            |    5 
 arch/x86/kernel/cpu/mce/core.c           |  106 ++-
 arch/x86/kernel/cpu/mce/inject.c         |    4 
 arch/x86/kernel/cpu/mce/internal.h       |    2 
 arch/x86/kernel/cpu/mce/p5.c             |    8 
 arch/x86/kernel/cpu/mce/therm_throt.c    |    5 
 arch/x86/kernel/cpu/mce/threshold.c      |    5 
 arch/x86/kernel/cpu/mce/winchip.c        |    8 
 arch/x86/kernel/cpu/mshyperv.c           |   22 
 arch/x86/kernel/doublefault_32.c         |   10 
 arch/x86/kernel/dumpstack_64.c           |    7 
 arch/x86/kernel/ftrace_64.S              |    2 
 arch/x86/kernel/head_64.S                |    7 
 arch/x86/kernel/hw_breakpoint.c          |  100 +++
 arch/x86/kernel/idt.c                    |  226 ++++---
 arch/x86/kernel/irq.c                    |   66 --
 arch/x86/kernel/irq_32.c                 |    2 
 arch/x86/kernel/irq_64.c                 |    6 
 arch/x86/kernel/irq_work.c               |    6 
 arch/x86/kernel/kprobes/core.c           |    7 
 arch/x86/kernel/kprobes/opt.c            |    4 
 arch/x86/kernel/kvm.c                    |   15 
 arch/x86/kernel/nmi.c                    |   75 --
 arch/x86/kernel/smp.c                    |   37 -
 arch/x86/kernel/tracepoint.c             |   17 
 arch/x86/kernel/traps.c                  |  486 +++++++++++-----
 arch/x86/kernel/unwind_frame.c           |    8 
 arch/x86/kernel/vmlinux.lds.S            |    1 
 arch/x86/kvm/svm/svm.c                   |    2 
 arch/x86/kvm/vmx/nested.c                |    2 
 arch/x86/kvm/vmx/vmx.c                   |    2 
 arch/x86/mm/cpu_entry_area.c             |    1 
 arch/x86/mm/fault.c                      |   78 +-
 arch/x86/mm/pti.c                        |    4 
 arch/x86/platform/uv/tlb_uv.c            |    2 
 arch/x86/xen/enlighten_hvm.c             |   12 
 arch/x86/xen/enlighten_pv.c              |   52 +
 arch/x86/xen/setup.c                     |    4 
 arch/x86/xen/smp_pv.c                    |    3 
 arch/x86/xen/suspend_hvm.c               |    3 
 arch/x86/xen/xen-asm_32.S                |   14 
 arch/x86/xen/xen-asm_64.S                |   44 -
 arch/x86/xen/xen-ops.h                   |    2 
 drivers/xen/Makefile                     |    2 
 drivers/xen/events/events_base.c         |   32 -
 include/asm-generic/bug.h                |    9 
 include/linux/bsearch.h                  |   26 
 include/linux/context_tracking.h         |    6 
 include/linux/context_tracking_state.h   |    6 
 include/linux/debug_locks.h              |    2 
 include/linux/hardirq.h                  |   41 +
 include/linux/interrupt.h                |    8 
 include/linux/irqflags.h                 |    4 
 include/xen/events.h                     |    7 
 include/xen/hvm.h                        |    2 
 include/xen/interface/hvm/hvm_op.h       |    2 
 include/xen/xen-ops.h                    |   19 
 kernel/context_tracking.c                |   14 
 kernel/locking/lockdep.c                 |    4 
 kernel/panic.c                           |    4 
 kernel/softirq.c                         |   44 +
 kernel/time/timekeeping.c                |    2 
 kernel/trace/trace_preemptirq.c          |   10 
 lib/bsearch.c                            |   22 
 lib/smp_processor_id.c                   |   10 
 drivers/xen/preempt.c                    |   42 -
 110 files changed, 2656 insertions(+), 2387 deletions(-)

