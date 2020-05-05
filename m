Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38A6C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92F620675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgEEONs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729327AbgEEONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:13:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132E0C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:13:45 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyJu-0000HO-HQ; Tue, 05 May 2020 16:13:14 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 9ABE6FFC8D;
        Tue,  5 May 2020 16:13:13 +0200 (CEST)
Message-Id: <20200505131602.633487962@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:16:02 +0200
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
Subject: [patch V4 part 1 00/36] x86/entry: Entry/exception code rework,
 preparatory patches
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks!

This is the hopefully final version of the rework of the entry and
exception code to ensure that instrumentation cannot touch the fragile
parts of the hardware induced entry and exception code trainwreck. It
further ensures correctness vs. RCU and moves quite some code out of the
assembly code into C.

V3 can befound here:

 https://lore.kernel.org/r/20200320175956.033706968@linutronix.de

The protection against instrumentation is based on moving the fragile code
parts into a special text section: .noinstr.text which is excluded from any
form of instrumentation

The correctness is validated via objtool extensions. The necessary updates
to objtool are available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool/core

The series has a total of 138 patches and is split into 5 parts. It's based
on v5.7-rc3 with the objtool/core and the locking/kcsan branches of the tip
tree merged on top. The base tree is available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-base

The full series with all parts applied is available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v4-part-5

The first part, i.e. this series is available from:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry-v4-part-1

This part contains preparatory patches and fixes of various sorts which
have been either developed in course of this project or have been collected
from previous versions and related discussions about the whole entry
vs. RCU vs. instrumentation correctness problem.

 - Prevention of breakpoints in the entry code
 - Splitting the scheduler IPI
 - Correct ordering of user space exit work
 - Cleanup and restriction of the async page fault handling
 - Kprobes support for noinstr sections in built-in and modules code
 - The introduction of noinstr.text section
 - Preparatory work in tracing, lockdep and RCU
 - The nmi_enter() consolidation
 - Atomic fallback interaction

The largest patch of this series is the atomic fallback rework which is
necessary to address the interaction with KCSAN and pending work from Will
Deacon in that area. The header file is autogenerated, but actually
included in tree because regenerating on every build is too expensive.

The objtool check for the noinstr.text correctness is not yet added to the
build machinery and has to be invoked manually for now:

   objtool check -fal vmlinux.o

The checking only works for builtin code as objtool cannot do a combined
analysis of vmlinux.o and a module.o

Thanks,

	tglx

8<----------
 Documentation/trace/ftrace-design.rst        |    8 
 arch/arm64/include/asm/atomic.h              |    6 
 arch/arm64/include/asm/hardirq.h             |   78 
 arch/arm64/kernel/sdei.c                     |   14 
 arch/arm64/kernel/traps.c                    |    8 
 arch/powerpc/kernel/traps.c                  |   22 
 arch/sh/Kconfig                              |    1 
 arch/sh/kernel/traps.c                       |   12 
 arch/x86/entry/Makefile                      |    8 
 arch/x86/entry/common.c                      |    8 
 arch/x86/entry/entry_32.S                    |    8 
 arch/x86/entry/entry_64.S                    |    6 
 arch/x86/entry/thunk_64.S                    |    5 
 arch/x86/include/asm/atomic.h                |   17 
 arch/x86/include/asm/atomic64_32.h           |    9 
 arch/x86/include/asm/atomic64_64.h           |   15 
 arch/x86/include/asm/bug.h                   |    3 
 arch/x86/include/asm/irqflags.h              |   24 
 arch/x86/include/asm/kvm_para.h              |   23 
 arch/x86/include/asm/paravirt.h              |    2 
 arch/x86/include/asm/traps.h                 |    5 
 arch/x86/include/asm/x86_init.h              |    2 
 arch/x86/kernel/cpu/mce/core.c               |   65 
 arch/x86/kernel/cpu/mce/p5.c                 |    5 
 arch/x86/kernel/cpu/mce/winchip.c            |    5 
 arch/x86/kernel/hw_breakpoint.c              |   25 
 arch/x86/kernel/kvm.c                        |  158 -
 arch/x86/kernel/traps.c                      |  117 -
 arch/x86/kernel/tsc.c                        |    4 
 arch/x86/kernel/x86_init.c                   |    1 
 arch/x86/kvm/mmu/mmu.c                       |    2 
 arch/x86/mm/fault.c                          |   19 
 include/asm-generic/bug.h                    |    9 
 include/asm-generic/sections.h               |    3 
 include/asm-generic/vmlinux.lds.h            |    4 
 include/linux/atomic-arch-fallback.h         | 2291 +++++++++++++++++++++++++++
 include/linux/atomic-fallback.h              |    8 
 include/linux/atomic.h                       |   11 
 include/linux/compiler.h                     |   25 
 include/linux/compiler_types.h               |    4 
 include/linux/ftrace_irq.h                   |   15 
 include/linux/hardirq.h                      |   18 
 include/linux/irqflags.h                     |    6 
 include/linux/lockdep.h                      |   23 
 include/linux/module.h                       |    8 
 include/linux/preempt.h                      |    4 
 include/linux/sched.h                        |   17 
 kernel/kprobes.c                             |   85 -
 kernel/locking/lockdep.c                     |   89 -
 kernel/module.c                              |   10 
 kernel/panic.c                               |    4 
 kernel/printk/internal.h                     |    8 
 kernel/printk/printk_safe.c                  |    9 
 kernel/rcu/tree.c                            |  139 -
 kernel/rcu/tree_plugin.h                     |    4 
 kernel/rcu/update.c                          |    7 
 kernel/sched/core.c                          |   66 
 kernel/sched/fair.c                          |    5 
 kernel/sched/sched.h                         |    6 
 kernel/trace/Kconfig                         |   10 
 kernel/trace/trace_clock.c                   |    3 
 kernel/trace/trace_hwlat.c                   |    2 
 kernel/trace/trace_preemptirq.c              |   39 
 lib/debug_locks.c                            |    2 
 samples/kprobes/kprobe_example.c             |    6 
 samples/kprobes/kretprobe_example.c          |    2 
 scripts/atomic/fallbacks/acquire             |    4 
 scripts/atomic/fallbacks/add_negative        |    6 
 scripts/atomic/fallbacks/add_unless          |    6 
 scripts/atomic/fallbacks/andnot              |    4 
 scripts/atomic/fallbacks/dec                 |    4 
 scripts/atomic/fallbacks/dec_and_test        |    6 
 scripts/atomic/fallbacks/dec_if_positive     |    6 
 scripts/atomic/fallbacks/dec_unless_positive |    6 
 scripts/atomic/fallbacks/fence               |    4 
 scripts/atomic/fallbacks/fetch_add_unless    |    8 
 scripts/atomic/fallbacks/inc                 |    4 
 scripts/atomic/fallbacks/inc_and_test        |    6 
 scripts/atomic/fallbacks/inc_not_zero        |    6 
 scripts/atomic/fallbacks/inc_unless_negative |    6 
 scripts/atomic/fallbacks/read_acquire        |    2 
 scripts/atomic/fallbacks/release             |    4 
 scripts/atomic/fallbacks/set_release         |    2 
 scripts/atomic/fallbacks/sub_and_test        |    6 
 scripts/atomic/fallbacks/try_cmpxchg         |    4 
 scripts/atomic/gen-atomic-fallback.sh        |   29 
 scripts/atomic/gen-atomics.sh                |    5 
 scripts/mod/modpost.c                        |    2 
 88 files changed, 3146 insertions(+), 611 deletions(-)
