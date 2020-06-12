Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D03C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C985120842
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgFLAcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 20:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgFLAc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 20:32:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5DCC03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 17:32:26 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jjXcH-00015Y-GS; Fri, 12 Jun 2020 02:32:19 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 03219100F5A;
        Fri, 12 Jun 2020 02:32:17 +0200 (CEST)
Date:   Fri, 12 Jun 2020 00:24:49 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [GIT pull V2] locking/kcsan for v5.8
References: <159192148730.1475.8112596092479045470.tglx@nanos.tec.linutronix.de>
Message-ID: <159192148975.1475.16272172258276079370.tglx@nanos.tec.linutronix.de>
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

please pull the latest locking/kcsan branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-kcsan-2020-06-11

up to:  1f44328ea24c: compiler_types.h, kasan: Use __SANITIZE_ADDRESS__ instead of CONFIG_KASAN to decide inlining

It has been rebased and distangled as you requested. It is based on

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-06-11

which came with the preceding pull request in this thread. The rebase was
checked by Marco and Will and held up in testing.

The Kernel Concurrency Sanitizer (KCSAN)

KCSAN is a dynamic race detector, which relies on compile-time
instrumentation, and uses a watchpoint-based sampling approach to detect
races.

The feature was under development for quite some time and has already found
legitimate bugs.

Unfortunately it comes with a limitation, which was only understood late in
the development cycle:

  It requires an up to date CLANG-11 compiler

CLANG-11 is not yet released (scheduled for June), but it's the only
compiler today which handles the kernel requirements and especially the
annotations of functions to exclude them from KCSAN instrumentation
correctly.

These annotations really need to work so that low level entry code and
especially int3 text poke handling can be completely isolated.

A detailed discussion of the requirements and compiler issues can be found
here:

  https://lore.kernel.org/lkml/CANpmjNMTsY_8241bS7=XAfqvZHFLrVEkv_uM4aDUWE_kh3Rvbw@mail.gmail.com/

We came to the conclusion that trying to work around compiler limitations
and bugs again would end up in a major trainwreck, so requiring a working
compiler seemed to be the best choice.

For Continous Integration purposes the compiler restriction is manageable
and that's where most xxSAN reports come from.

For a change this limitation might make GCC people actually look at their
bugs. Some issues with CSAN in GCC are 7 years old and one has been 'fixed'
3 years ago with a half baken solution which 'solved' the reported issue
but not the underlying problem.

The KCSAN developers also ponder to use a GCC plugin to become independent,
but that's not something which will show up in a few days.

Blocking KCSAN until wide spread compiler support is available is not a
really good alternative because the continuous growth of lockless
optimizations in the kernel demands proper tooling support.

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      ubsan, kcsan: Don't combine sanitizer with kcov on clang

Dave Young (1):
      x86/kexec: Do not reserve EFI setup_data in the kexec e820 table

Hans de Goede (2):
      x86/purgatory: Disable various profiling and sanitizing options
      x86/purgatory: Fail the build if purgatory.ro has missing symbols

Ingo Molnar (2):
      kcsan: Improve various small stylistic details
      Improve KCSAN documentation a bit

Jann Horn (1):
      x86/vdso: Enable sanitizers for vma.o

Marco Elver (67):
      kcsan: Add Kernel Concurrency Sanitizer infrastructure
      include/linux/compiler.h: Introduce data_race(expr) macro
      kcsan: Add Documentation entry in dev-tools
      objtool, kcsan: Add KCSAN runtime functions to whitelist
      build, kcsan: Add KCSAN build exceptions
      seqlock, kcsan: Add annotations for KCSAN
      seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
      locking/atomics, kcsan: Add KCSAN instrumentation
      x86, kcsan: Enable KCSAN for x86
      kcsan, ubsan: Make KCSAN+UBSAN work together
      asm-generic/atomic: Use __always_inline for pure wrappers
      asm-generic/atomic: Use __always_inline for fallback wrappers
      kcsan: Document static blacklisting options
      kcsan: Add __no_kcsan function attribute
      kcsan: Prefer __always_inline for fast-path
      kcsan: Show full access type in report
      kcsan: Rate-limit reporting per data races
      kcsan: Make KCSAN compatible with lockdep
      kcsan: Address missing case with KCSAN_REPORT_VALUE_CHANGE_ONLY
      include/linux: Add instrumented.h infrastructure
      asm-generic, atomic-instrumented: Use generic instrumented.h
      asm-generic, kcsan: Add KCSAN instrumentation for bitops
      iov_iter: Use generic instrumented.h
      copy_to_user, copy_from_user: Use generic instrumented.h
      kcsan: Add option to assume plain aligned writes up to word size are atomic
      kcsan: Clarify Kconfig option KCSAN_IGNORE_ATOMICS
      kcsan: Clean up the main KCSAN Kconfig option
      kcsan: Fix 0-sized checks
      kcsan: Introduce KCSAN_ACCESS_ASSERT access type
      kcsan: Introduce ASSERT_EXCLUSIVE_*() macros
      kcsan: Add test to generate conflicts via debugfs
      kcsan: Expose core configuration parameters as module params
      kcsan: Fix misreporting if concurrent races on same address
      kcsan: Move interfaces that affects checks to kcsan-checks.h
      compiler.h, seqlock.h: Remove unnecessary kcsan.h includes
      kcsan: Introduce kcsan_value_change type
      kcsan: Add kcsan_set_access_mask() support
      kcsan: Introduce ASSERT_EXCLUSIVE_BITS(var, mask)
      kcsan, trace: Make KCSAN compatible with tracing
      kcsan: Add option to allow watcher interruptions
      kcsan: Add option for verbose reporting
      kcsan: Add current->state to implicitly atomic accesses
      kcsan: Update Documentation/dev-tools/kcsan.rst
      kcsan: Update API documentation in kcsan-checks.h
      kcsan: Introduce report access_info and other_info
      kcsan: Avoid blocking producers in prepare_report()
      kcsan: Add support for scoped accesses
      objtool, kcsan: Add explicit check functions to uaccess whitelist
      kcsan: Introduce scoped ASSERT_EXCLUSIVE macros
      kcsan: Move kcsan_{disable,enable}_current() to kcsan-checks.h
      kcsan: Change data_race() to no longer require marking racing accesses
      kcsan: Fix function matching in report
      kcsan: Make reporting aware of KCSAN tests
      checkpatch: Warn about data_race() without comment
      kcsan: Add __kcsan_{enable,disable}_current() variants
      objtool, kcsan: Add kcsan_disable_current() and kcsan_enable_current_nowarn()
      asm-generic/atomic: Use __always_inline for fallback wrappers
      kcsan: Avoid inserting __tsan_func_entry/exit if possible
      kcsan: Restrict supported compilers
      kcsan: Support distinguishing volatile accesses
      kcsan: Pass option tsan-instrument-read-before-write to Clang
      kcsan: Remove 'noinline' from __no_kcsan_or_inline
      kcsan: Update Documentation to change supported compilers
      compiler.h: Remove data_race() and unnecessary checks from {READ,WRITE}_ONCE()
      compiler.h: Avoid nested statement expression in data_race()
      compiler.h: Move function attributes to compiler_types.h
      compiler_types.h, kasan: Use __SANITIZE_ADDRESS__ instead of CONFIG_KASAN to decide inlining

Paul E. McKenney (1):
      kcsan: Add docbook header for data_race()

Peter Zijlstra (1):
      locking/atomics: Flip fallbacks and instrumentation

Qiujun Huang (1):
      kcsan: Fix a typo in a comment

Wei Yongjun (1):
      kcsan: Use GFP_ATOMIC under spin lock


 Documentation/dev-tools/index.rst                  |    1 +
 Documentation/dev-tools/kcsan.rst                  |  321 +++
 MAINTAINERS                                        |   11 +
 Makefile                                           |    3 +-
 arch/arm64/include/asm/atomic.h                    |    6 +-
 arch/x86/Kconfig                                   |    1 +
 arch/x86/boot/Makefile                             |    2 +
 arch/x86/boot/compressed/Makefile                  |    2 +
 arch/x86/entry/vdso/Makefile                       |    6 +
 arch/x86/include/asm/atomic.h                      |   17 +-
 arch/x86/include/asm/atomic64_32.h                 |    9 +
 arch/x86/include/asm/atomic64_64.h                 |   15 +-
 arch/x86/include/asm/bitops.h                      |    6 +-
 arch/x86/kernel/Makefile                           |    4 +
 arch/x86/kernel/cpu/Makefile                       |    3 +
 arch/x86/kernel/e820.c                             |   10 +-
 arch/x86/lib/Makefile                              |    9 +
 arch/x86/mm/Makefile                               |    4 +
 arch/x86/purgatory/.gitignore                      |    1 +
 arch/x86/purgatory/Makefile                        |   21 +-
 arch/x86/realmode/Makefile                         |    3 +
 arch/x86/realmode/rm/Makefile                      |    3 +
 drivers/firmware/efi/libstub/Makefile              |    2 +
 include/asm-generic/atomic-instrumented.h          |  711 +++---
 include/asm-generic/atomic-long.h                  |  331 +--
 include/asm-generic/bitops/instrumented-atomic.h   |   14 +-
 include/asm-generic/bitops/instrumented-lock.h     |   10 +-
 .../asm-generic/bitops/instrumented-non-atomic.h   |   16 +-
 include/linux/atomic-arch-fallback.h               | 2291 ++++++++++++++++++++
 include/linux/atomic-fallback.h                    |  346 ++-
 include/linux/atomic.h                             |   11 +
 include/linux/compiler-clang.h                     |   11 +-
 include/linux/compiler-gcc.h                       |    6 +
 include/linux/compiler.h                           |   53 +-
 include/linux/compiler_types.h                     |   32 +
 include/linux/instrumented.h                       |  109 +
 include/linux/kcsan-checks.h                       |  430 ++++
 include/linux/kcsan.h                              |   59 +
 include/linux/sched.h                              |    4 +
 include/linux/seqlock.h                            |   51 +-
 include/linux/uaccess.h                            |   14 +-
 init/init_task.c                                   |   10 +
 init/main.c                                        |    2 +
 kernel/Makefile                                    |    6 +
 kernel/kcsan/Makefile                              |   14 +
 kernel/kcsan/atomic.h                              |   20 +
 kernel/kcsan/core.c                                |  850 ++++++++
 kernel/kcsan/debugfs.c                             |  349 +++
 kernel/kcsan/encoding.h                            |   95 +
 kernel/kcsan/kcsan.h                               |  142 ++
 kernel/kcsan/report.c                              |  634 ++++++
 kernel/kcsan/test.c                                |  131 ++
 kernel/locking/Makefile                            |    3 +
 kernel/sched/Makefile                              |    6 +
 kernel/trace/Makefile                              |    3 +
 lib/Kconfig.debug                                  |    2 +
 lib/Kconfig.kcsan                                  |  199 ++
 lib/Kconfig.ubsan                                  |   11 +
 lib/Makefile                                       |    4 +
 lib/iov_iter.c                                     |    7 +-
 lib/usercopy.c                                     |    7 +-
 mm/Makefile                                        |    8 +
 scripts/Makefile.kcsan                             |   19 +
 scripts/Makefile.lib                               |   10 +
 scripts/atomic/fallbacks/acquire                   |    6 +-
 scripts/atomic/fallbacks/add_negative              |    8 +-
 scripts/atomic/fallbacks/add_unless                |    8 +-
 scripts/atomic/fallbacks/andnot                    |    6 +-
 scripts/atomic/fallbacks/dec                       |    6 +-
 scripts/atomic/fallbacks/dec_and_test              |    8 +-
 scripts/atomic/fallbacks/dec_if_positive           |    8 +-
 scripts/atomic/fallbacks/dec_unless_positive       |    8 +-
 scripts/atomic/fallbacks/fence                     |    6 +-
 scripts/atomic/fallbacks/fetch_add_unless          |   10 +-
 scripts/atomic/fallbacks/inc                       |    6 +-
 scripts/atomic/fallbacks/inc_and_test              |    8 +-
 scripts/atomic/fallbacks/inc_not_zero              |    8 +-
 scripts/atomic/fallbacks/inc_unless_negative       |    8 +-
 scripts/atomic/fallbacks/read_acquire              |    4 +-
 scripts/atomic/fallbacks/release                   |    6 +-
 scripts/atomic/fallbacks/set_release               |    4 +-
 scripts/atomic/fallbacks/sub_and_test              |    8 +-
 scripts/atomic/fallbacks/try_cmpxchg               |    6 +-
 scripts/atomic/gen-atomic-fallback.sh              |   31 +-
 scripts/atomic/gen-atomic-instrumented.sh          |    9 +-
 scripts/atomic/gen-atomic-long.sh                  |    3 +-
 scripts/atomic/gen-atomics.sh                      |    5 +-
 scripts/checkpatch.pl                              |    8 +
 tools/objtool/check.c                              |   22 +
 89 files changed, 6839 insertions(+), 862 deletions(-)
 create mode 100644 Documentation/dev-tools/kcsan.rst
 create mode 100644 arch/x86/purgatory/.gitignore
 create mode 100644 include/linux/atomic-arch-fallback.h
 create mode 100644 include/linux/instrumented.h
 create mode 100644 include/linux/kcsan-checks.h
 create mode 100644 include/linux/kcsan.h
 create mode 100644 kernel/kcsan/Makefile
 create mode 100644 kernel/kcsan/atomic.h
 create mode 100644 kernel/kcsan/core.c
 create mode 100644 kernel/kcsan/debugfs.c
 create mode 100644 kernel/kcsan/encoding.h
 create mode 100644 kernel/kcsan/kcsan.h
 create mode 100644 kernel/kcsan/report.c
 create mode 100644 kernel/kcsan/test.c
 create mode 100644 lib/Kconfig.kcsan
 create mode 100644 scripts/Makefile.kcsan

diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 09dee10d2592..f7809c7b1ba9 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -21,6 +21,7 @@ whole; patches welcome!
    kasan
    ubsan
    kmemleak
+   kcsan
    gdb-kernel-debugging
    kgdb
    kselftest
diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
new file mode 100644
index 000000000000..ce4bbd918648
--- /dev/null
+++ b/Documentation/dev-tools/kcsan.rst
@@ -0,0 +1,321 @@
+The Kernel Concurrency Sanitizer (KCSAN)
+========================================
+
+The Kernel Concurrency Sanitizer (KCSAN) is a dynamic race detector, which
+relies on compile-time instrumentation, and uses a watchpoint-based sampling
+approach to detect races. KCSAN's primary purpose is to detect `data races`_.
+
+Usage
+-----
+
+KCSAN requires Clang version 11 or later.
+
+To enable KCSAN configure the kernel with::
+
+    CONFIG_KCSAN = y
+
+KCSAN provides several other configuration options to customize behaviour (see
+the respective help text in ``lib/Kconfig.kcsan`` for more info).
+
+Error reports
+~~~~~~~~~~~~~
+
+A typical data race report looks like this::
+
+    ==================================================================
+    BUG: KCSAN: data-race in generic_permission / kernfs_refresh_inode
+
+    write to 0xffff8fee4c40700c of 4 bytes by task 175 on cpu 4:
+     kernfs_refresh_inode+0x70/0x170
+     kernfs_iop_permission+0x4f/0x90
+     inode_permission+0x190/0x200
+     link_path_walk.part.0+0x503/0x8e0
+     path_lookupat.isra.0+0x69/0x4d0
+     filename_lookup+0x136/0x280
+     user_path_at_empty+0x47/0x60
+     vfs_statx+0x9b/0x130
+     __do_sys_newlstat+0x50/0xb0
+     __x64_sys_newlstat+0x37/0x50
+     do_syscall_64+0x85/0x260
+     entry_SYSCALL_64_after_hwframe+0x44/0xa9
+
+    read to 0xffff8fee4c40700c of 4 bytes by task 166 on cpu 6:
+     generic_permission+0x5b/0x2a0
+     kernfs_iop_permission+0x66/0x90
+     inode_permission+0x190/0x200
+     link_path_walk.part.0+0x503/0x8e0
+     path_lookupat.isra.0+0x69/0x4d0
+     filename_lookup+0x136/0x280
+     user_path_at_empty+0x47/0x60
+     do_faccessat+0x11a/0x390
+     __x64_sys_access+0x3c/0x50
+     do_syscall_64+0x85/0x260
+     entry_SYSCALL_64_after_hwframe+0x44/0xa9
+
+    Reported by Kernel Concurrency Sanitizer on:
+    CPU: 6 PID: 166 Comm: systemd-journal Not tainted 5.3.0-rc7+ #1
+    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
+    ==================================================================
+
+The header of the report provides a short summary of the functions involved in
+the race. It is followed by the access types and stack traces of the 2 threads
+involved in the data race.
+
+The other less common type of data race report looks like this::
+
+    ==================================================================
+    BUG: KCSAN: data-race in e1000_clean_rx_irq+0x551/0xb10
+
+    race at unknown origin, with read to 0xffff933db8a2ae6c of 1 bytes by interrupt on cpu 0:
+     e1000_clean_rx_irq+0x551/0xb10
+     e1000_clean+0x533/0xda0
+     net_rx_action+0x329/0x900
+     __do_softirq+0xdb/0x2db
+     irq_exit+0x9b/0xa0
+     do_IRQ+0x9c/0xf0
+     ret_from_intr+0x0/0x18
+     default_idle+0x3f/0x220
+     arch_cpu_idle+0x21/0x30
+     do_idle+0x1df/0x230
+     cpu_startup_entry+0x14/0x20
+     rest_init+0xc5/0xcb
+     arch_call_rest_init+0x13/0x2b
+     start_kernel+0x6db/0x700
+
+    Reported by Kernel Concurrency Sanitizer on:
+    CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc7+ #2
+    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
+    ==================================================================
+
+This report is generated where it was not possible to determine the other
+racing thread, but a race was inferred due to the data value of the watched
+memory location having changed. These can occur either due to missing
+instrumentation or e.g. DMA accesses. These reports will only be generated if
+``CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=y`` (selected by default).
+
+Selective analysis
+~~~~~~~~~~~~~~~~~~
+
+It may be desirable to disable data race detection for specific accesses,
+functions, compilation units, or entire subsystems.  For static blacklisting,
+the below options are available:
+
+* KCSAN understands the ``data_race(expr)`` annotation, which tells KCSAN that
+  any data races due to accesses in ``expr`` should be ignored and resulting
+  behaviour when encountering a data race is deemed safe.
+
+* Disabling data race detection for entire functions can be accomplished by
+  using the function attribute ``__no_kcsan``::
+
+    __no_kcsan
+    void foo(void) {
+        ...
+
+  To dynamically limit for which functions to generate reports, see the
+  `DebugFS interface`_ blacklist/whitelist feature.
+
+  For ``__always_inline`` functions, replace ``__always_inline`` with
+  ``__no_kcsan_or_inline`` (which implies ``__always_inline``)::
+
+    static __no_kcsan_or_inline void foo(void) {
+        ...
+
+* To disable data race detection for a particular compilation unit, add to the
+  ``Makefile``::
+
+    KCSAN_SANITIZE_file.o := n
+
+* To disable data race detection for all compilation units listed in a
+  ``Makefile``, add to the respective ``Makefile``::
+
+    KCSAN_SANITIZE := n
+
+Furthermore, it is possible to tell KCSAN to show or hide entire classes of
+data races, depending on preferences. These can be changed via the following
+Kconfig options:
+
+* ``CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY``: If enabled and a conflicting write
+  is observed via a watchpoint, but the data value of the memory location was
+  observed to remain unchanged, do not report the data race.
+
+* ``CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC``: Assume that plain aligned writes
+  up to word size are atomic by default. Assumes that such writes are not
+  subject to unsafe compiler optimizations resulting in data races. The option
+  causes KCSAN to not report data races due to conflicts where the only plain
+  accesses are aligned writes up to word size.
+
+DebugFS interface
+~~~~~~~~~~~~~~~~~
+
+The file ``/sys/kernel/debug/kcsan`` provides the following interface:
+
+* Reading ``/sys/kernel/debug/kcsan`` returns various runtime statistics.
+
+* Writing ``on`` or ``off`` to ``/sys/kernel/debug/kcsan`` allows turning KCSAN
+  on or off, respectively.
+
+* Writing ``!some_func_name`` to ``/sys/kernel/debug/kcsan`` adds
+  ``some_func_name`` to the report filter list, which (by default) blacklists
+  reporting data races where either one of the top stackframes are a function
+  in the list.
+
+* Writing either ``blacklist`` or ``whitelist`` to ``/sys/kernel/debug/kcsan``
+  changes the report filtering behaviour. For example, the blacklist feature
+  can be used to silence frequently occurring data races; the whitelist feature
+  can help with reproduction and testing of fixes.
+
+Tuning performance
+~~~~~~~~~~~~~~~~~~
+
+Core parameters that affect KCSAN's overall performance and bug detection
+ability are exposed as kernel command-line arguments whose defaults can also be
+changed via the corresponding Kconfig options.
+
+* ``kcsan.skip_watch`` (``CONFIG_KCSAN_SKIP_WATCH``): Number of per-CPU memory
+  operations to skip, before another watchpoint is set up. Setting up
+  watchpoints more frequently will result in the likelihood of races to be
+  observed to increase. This parameter has the most significant impact on
+  overall system performance and race detection ability.
+
+* ``kcsan.udelay_task`` (``CONFIG_KCSAN_UDELAY_TASK``): For tasks, the
+  microsecond delay to stall execution after a watchpoint has been set up.
+  Larger values result in the window in which we may observe a race to
+  increase.
+
+* ``kcsan.udelay_interrupt`` (``CONFIG_KCSAN_UDELAY_INTERRUPT``): For
+  interrupts, the microsecond delay to stall execution after a watchpoint has
+  been set up. Interrupts have tighter latency requirements, and their delay
+  should generally be smaller than the one chosen for tasks.
+
+They may be tweaked at runtime via ``/sys/module/kcsan/parameters/``.
+
+Data Races
+----------
+
+In an execution, two memory accesses form a *data race* if they *conflict*,
+they happen concurrently in different threads, and at least one of them is a
+*plain access*; they *conflict* if both access the same memory location, and at
+least one is a write. For a more thorough discussion and definition, see `"Plain
+Accesses and Data Races" in the LKMM`_.
+
+.. _"Plain Accesses and Data Races" in the LKMM: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/explanation.txt#n1922
+
+Relationship with the Linux-Kernel Memory Consistency Model (LKMM)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The LKMM defines the propagation and ordering rules of various memory
+operations, which gives developers the ability to reason about concurrent code.
+Ultimately this allows to determine the possible executions of concurrent code,
+and if that code is free from data races.
+
+KCSAN is aware of *marked atomic operations* (``READ_ONCE``, ``WRITE_ONCE``,
+``atomic_*``, etc.), but is oblivious of any ordering guarantees and simply
+assumes that memory barriers are placed correctly. In other words, KCSAN
+assumes that as long as a plain access is not observed to race with another
+conflicting access, memory operations are correctly ordered.
+
+This means that KCSAN will not report *potential* data races due to missing
+memory ordering. Developers should therefore carefully consider the required
+memory ordering requirements that remain unchecked. If, however, missing
+memory ordering (that is observable with a particular compiler and
+architecture) leads to an observable data race (e.g. entering a critical
+section erroneously), KCSAN would report the resulting data race.
+
+Race Detection Beyond Data Races
+--------------------------------
+
+For code with complex concurrency design, race-condition bugs may not always
+manifest as data races. Race conditions occur if concurrently executing
+operations result in unexpected system behaviour. On the other hand, data races
+are defined at the C-language level. The following macros can be used to check
+properties of concurrent code where bugs would not manifest as data races.
+
+.. kernel-doc:: include/linux/kcsan-checks.h
+    :functions: ASSERT_EXCLUSIVE_WRITER ASSERT_EXCLUSIVE_WRITER_SCOPED
+                ASSERT_EXCLUSIVE_ACCESS ASSERT_EXCLUSIVE_ACCESS_SCOPED
+                ASSERT_EXCLUSIVE_BITS
+
+Implementation Details
+----------------------
+
+KCSAN relies on observing that two accesses happen concurrently. Crucially, we
+want to (a) increase the chances of observing races (especially for races that
+manifest rarely), and (b) be able to actually observe them. We can accomplish
+(a) by injecting various delays, and (b) by using address watchpoints (or
+breakpoints).
+
+If we deliberately stall a memory access, while we have a watchpoint for its
+address set up, and then observe the watchpoint to fire, two accesses to the
+same address just raced. Using hardware watchpoints, this is the approach taken
+in `DataCollider
+<http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf>`_.
+Unlike DataCollider, KCSAN does not use hardware watchpoints, but instead
+relies on compiler instrumentation and "soft watchpoints".
+
+In KCSAN, watchpoints are implemented using an efficient encoding that stores
+access type, size, and address in a long; the benefits of using "soft
+watchpoints" are portability and greater flexibility. KCSAN then relies on the
+compiler instrumenting plain accesses. For each instrumented plain access:
+
+1. Check if a matching watchpoint exists; if yes, and at least one access is a
+   write, then we encountered a racing access.
+
+2. Periodically, if no matching watchpoint exists, set up a watchpoint and
+   stall for a small randomized delay.
+
+3. Also check the data value before the delay, and re-check the data value
+   after delay; if the values mismatch, we infer a race of unknown origin.
+
+To detect data races between plain and marked accesses, KCSAN also annotates
+marked accesses, but only to check if a watchpoint exists; i.e. KCSAN never
+sets up a watchpoint on marked accesses. By never setting up watchpoints for
+marked operations, if all accesses to a variable that is accessed concurrently
+are properly marked, KCSAN will never trigger a watchpoint and therefore never
+report the accesses.
+
+Key Properties
+~~~~~~~~~~~~~~
+
+1. **Memory Overhead:**  The overall memory overhead is only a few MiB
+   depending on configuration. The current implementation uses a small array of
+   longs to encode watchpoint information, which is negligible.
+
+2. **Performance Overhead:** KCSAN's runtime aims to be minimal, using an
+   efficient watchpoint encoding that does not require acquiring any shared
+   locks in the fast-path. For kernel boot on a system with 8 CPUs:
+
+   - 5.0x slow-down with the default KCSAN config;
+   - 2.8x slow-down from runtime fast-path overhead only (set very large
+     ``KCSAN_SKIP_WATCH`` and unset ``KCSAN_SKIP_WATCH_RANDOMIZE``).
+
+3. **Annotation Overheads:** Minimal annotations are required outside the KCSAN
+   runtime. As a result, maintenance overheads are minimal as the kernel
+   evolves.
+
+4. **Detects Racy Writes from Devices:** Due to checking data values upon
+   setting up watchpoints, racy writes from devices can also be detected.
+
+5. **Memory Ordering:** KCSAN is *not* explicitly aware of the LKMM's ordering
+   rules; this may result in missed data races (false negatives).
+
+6. **Analysis Accuracy:** For observed executions, due to using a sampling
+   strategy, the analysis is *unsound* (false negatives possible), but aims to
+   be complete (no false positives).
+
+Alternatives Considered
+-----------------------
+
+An alternative data race detection approach for the kernel can be found in the
+`Kernel Thread Sanitizer (KTSAN) <https://github.com/google/ktsan/wiki>`_.
+KTSAN is a happens-before data race detector, which explicitly establishes the
+happens-before order between memory operations, which can then be used to
+determine data races as defined in `Data Races`_.
+
+To build a correct happens-before relation, KTSAN must be aware of all ordering
+rules of the LKMM and synchronization primitives. Unfortunately, any omission
+leads to large numbers of false positives, which is especially detrimental in
+the context of the kernel which includes numerous custom synchronization
+mechanisms. To track the happens-before relation, KTSAN's implementation
+requires metadata for each memory location (shadow memory), which for each page
+corresponds to 4 pages of shadow memory, and can translate into overhead of
+tens of GiB on a large system.
diff --git a/MAINTAINERS b/MAINTAINERS
index 9b4e836543a3..aea6fda02845 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9305,6 +9305,17 @@ F:	Documentation/kbuild/kconfig*
 F:	scripts/Kconfig.include
 F:	scripts/kconfig/
 
+KCSAN
+M:	Marco Elver <elver@google.com>
+R:	Dmitry Vyukov <dvyukov@google.com>
+L:	kasan-dev@googlegroups.com
+S:	Maintained
+F:	Documentation/dev-tools/kcsan.rst
+F:	include/linux/kcsan*.h
+F:	kernel/kcsan/
+F:	lib/Kconfig.kcsan
+F:	scripts/Makefile.kcsan
+
 KDUMP
 M:	Dave Young <dyoung@redhat.com>
 M:	Baoquan He <bhe@redhat.com>
diff --git a/Makefile b/Makefile
index 839f9fee22cb..f0c1a3a8d9e4 100644
--- a/Makefile
+++ b/Makefile
@@ -531,7 +531,7 @@ export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
-export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN
+export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN CFLAGS_KCSAN
 export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
 export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
@@ -965,6 +965,7 @@ endif
 include scripts/Makefile.kasan
 include scripts/Makefile.extrawarn
 include scripts/Makefile.ubsan
+include scripts/Makefile.kcsan
 
 # Add user supplied CPPFLAGS, AFLAGS and CFLAGS as the last assignments
 KBUILD_CPPFLAGS += $(KCPPFLAGS)
diff --git a/arch/arm64/include/asm/atomic.h b/arch/arm64/include/asm/atomic.h
index 9543b5e0534d..a08890da696c 100644
--- a/arch/arm64/include/asm/atomic.h
+++ b/arch/arm64/include/asm/atomic.h
@@ -101,8 +101,8 @@ static inline long arch_atomic64_dec_if_positive(atomic64_t *v)
 
 #define ATOMIC_INIT(i)	{ (i) }
 
-#define arch_atomic_read(v)			READ_ONCE((v)->counter)
-#define arch_atomic_set(v, i)			WRITE_ONCE(((v)->counter), (i))
+#define arch_atomic_read(v)			__READ_ONCE((v)->counter)
+#define arch_atomic_set(v, i)			__WRITE_ONCE(((v)->counter), (i))
 
 #define arch_atomic_add_return_relaxed		arch_atomic_add_return_relaxed
 #define arch_atomic_add_return_acquire		arch_atomic_add_return_acquire
@@ -225,6 +225,6 @@ static inline long arch_atomic64_dec_if_positive(atomic64_t *v)
 
 #define arch_atomic64_dec_if_positive		arch_atomic64_dec_if_positive
 
-#include <asm-generic/atomic-instrumented.h>
+#define ARCH_ATOMIC
 
 #endif /* __ASM_ATOMIC_H */
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 10dae8b96ed5..6ad579c7d4cd 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -233,6 +233,7 @@ config X86
 	select THREAD_INFO_IN_TASK
 	select USER_STACKTRACE_SUPPORT
 	select VIRT_TO_BUS
+	select HAVE_ARCH_KCSAN			if X86_64
 	select X86_FEATURE_NAMES		if PROC_FS
 	select PROC_PID_ARCH_STATUS		if PROC_FS
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 4c5355684321..fe605205b4ce 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -9,7 +9,9 @@
 # Changed by many, many contributors over the years.
 #
 
+# Sanitizer runtimes are unavailable and cannot be linked for early boot code.
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Kernel does not boot with kcov instrumentation here.
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 5f7c262bcc99..7619742f91c9 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -17,7 +17,9 @@
 #	(see scripts/Makefile.lib size_append)
 #	compressed vmlinux.bin.all + u32 size of vmlinux.bin.all
 
+# Sanitizer runtimes are unavailable and cannot be linked for early boot code.
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 54e03ab26ff3..04e65f0698f6 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -10,8 +10,11 @@ ARCH_REL_TYPE_ABS += R_386_GLOB_DAT|R_386_JMP_SLOT|R_386_RELATIVE
 include $(srctree)/lib/vdso/Makefile
 
 KBUILD_CFLAGS += $(DISABLE_LTO)
+
+# Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
@@ -29,6 +32,9 @@ vobjs32-y += vdso32/vclock_gettime.o
 
 # files to link into kernel
 obj-y				+= vma.o
+KASAN_SANITIZE_vma.o		:= y
+UBSAN_SANITIZE_vma.o		:= y
+KCSAN_SANITIZE_vma.o		:= y
 OBJECT_FILES_NON_STANDARD_vma.o	:= n
 
 # vDSO images to build
diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
index 115127c7ad28..a9ae58826074 100644
--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -28,7 +28,7 @@ static __always_inline int arch_atomic_read(const atomic_t *v)
 	 * Note for KASAN: we deliberately don't use READ_ONCE_NOCHECK() here,
 	 * it's non-inlined function that increases binary size and stack usage.
 	 */
-	return READ_ONCE((v)->counter);
+	return __READ_ONCE((v)->counter);
 }
 
 /**
@@ -40,7 +40,7 @@ static __always_inline int arch_atomic_read(const atomic_t *v)
  */
 static __always_inline void arch_atomic_set(atomic_t *v, int i)
 {
-	WRITE_ONCE(v->counter, i);
+	__WRITE_ONCE(v->counter, i);
 }
 
 /**
@@ -166,6 +166,7 @@ static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
 {
 	return i + xadd(&v->counter, i);
 }
+#define arch_atomic_add_return arch_atomic_add_return
 
 /**
  * arch_atomic_sub_return - subtract integer and return
@@ -178,32 +179,37 @@ static __always_inline int arch_atomic_sub_return(int i, atomic_t *v)
 {
 	return arch_atomic_add_return(-i, v);
 }
+#define arch_atomic_sub_return arch_atomic_sub_return
 
 static __always_inline int arch_atomic_fetch_add(int i, atomic_t *v)
 {
 	return xadd(&v->counter, i);
 }
+#define arch_atomic_fetch_add arch_atomic_fetch_add
 
 static __always_inline int arch_atomic_fetch_sub(int i, atomic_t *v)
 {
 	return xadd(&v->counter, -i);
 }
+#define arch_atomic_fetch_sub arch_atomic_fetch_sub
 
 static __always_inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	return arch_cmpxchg(&v->counter, old, new);
 }
+#define arch_atomic_cmpxchg arch_atomic_cmpxchg
 
-#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
 static __always_inline bool arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	return try_cmpxchg(&v->counter, old, new);
 }
+#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
 
 static inline int arch_atomic_xchg(atomic_t *v, int new)
 {
 	return arch_xchg(&v->counter, new);
 }
+#define arch_atomic_xchg arch_atomic_xchg
 
 static inline void arch_atomic_and(int i, atomic_t *v)
 {
@@ -221,6 +227,7 @@ static inline int arch_atomic_fetch_and(int i, atomic_t *v)
 
 	return val;
 }
+#define arch_atomic_fetch_and arch_atomic_fetch_and
 
 static inline void arch_atomic_or(int i, atomic_t *v)
 {
@@ -238,6 +245,7 @@ static inline int arch_atomic_fetch_or(int i, atomic_t *v)
 
 	return val;
 }
+#define arch_atomic_fetch_or arch_atomic_fetch_or
 
 static inline void arch_atomic_xor(int i, atomic_t *v)
 {
@@ -255,6 +263,7 @@ static inline int arch_atomic_fetch_xor(int i, atomic_t *v)
 
 	return val;
 }
+#define arch_atomic_fetch_xor arch_atomic_fetch_xor
 
 #ifdef CONFIG_X86_32
 # include <asm/atomic64_32.h>
@@ -262,6 +271,6 @@ static inline int arch_atomic_fetch_xor(int i, atomic_t *v)
 # include <asm/atomic64_64.h>
 #endif
 
-#include <asm-generic/atomic-instrumented.h>
+#define ARCH_ATOMIC
 
 #endif /* _ASM_X86_ATOMIC_H */
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 52cfaecb13f9..5efd01b548d1 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -75,6 +75,7 @@ static inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
 {
 	return arch_cmpxchg64(&v->counter, o, n);
 }
+#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
 
 /**
  * arch_atomic64_xchg - xchg atomic64 variable
@@ -94,6 +95,7 @@ static inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
 			     : "memory");
 	return o;
 }
+#define arch_atomic64_xchg arch_atomic64_xchg
 
 /**
  * arch_atomic64_set - set atomic64 variable
@@ -138,6 +140,7 @@ static inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 			     ASM_NO_INPUT_CLOBBER("memory"));
 	return i;
 }
+#define arch_atomic64_add_return arch_atomic64_add_return
 
 /*
  * Other variants with different arithmetic operators:
@@ -149,6 +152,7 @@ static inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 			     ASM_NO_INPUT_CLOBBER("memory"));
 	return i;
 }
+#define arch_atomic64_sub_return arch_atomic64_sub_return
 
 static inline s64 arch_atomic64_inc_return(atomic64_t *v)
 {
@@ -242,6 +246,7 @@ static inline int arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 			     "S" (v) : "memory");
 	return (int)a;
 }
+#define arch_atomic64_add_unless arch_atomic64_add_unless
 
 static inline int arch_atomic64_inc_not_zero(atomic64_t *v)
 {
@@ -281,6 +286,7 @@ static inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 
 	return old;
 }
+#define arch_atomic64_fetch_and arch_atomic64_fetch_and
 
 static inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
@@ -299,6 +305,7 @@ static inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 
 	return old;
 }
+#define arch_atomic64_fetch_or arch_atomic64_fetch_or
 
 static inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
@@ -317,6 +324,7 @@ static inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 
 	return old;
 }
+#define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
 
 static inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
@@ -327,6 +335,7 @@ static inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 
 	return old;
 }
+#define arch_atomic64_fetch_add arch_atomic64_fetch_add
 
 #define arch_atomic64_fetch_sub(i, v)	arch_atomic64_fetch_add(-(i), (v))
 
diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
index 95c6ceac66b9..809bd010a751 100644
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -19,7 +19,7 @@
  */
 static inline s64 arch_atomic64_read(const atomic64_t *v)
 {
-	return READ_ONCE((v)->counter);
+	return __READ_ONCE((v)->counter);
 }
 
 /**
@@ -31,7 +31,7 @@ static inline s64 arch_atomic64_read(const atomic64_t *v)
  */
 static inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
-	WRITE_ONCE(v->counter, i);
+	__WRITE_ONCE(v->counter, i);
 }
 
 /**
@@ -159,37 +159,43 @@ static __always_inline s64 arch_atomic64_add_return(s64 i, atomic64_t *v)
 {
 	return i + xadd(&v->counter, i);
 }
+#define arch_atomic64_add_return arch_atomic64_add_return
 
 static inline s64 arch_atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	return arch_atomic64_add_return(-i, v);
 }
+#define arch_atomic64_sub_return arch_atomic64_sub_return
 
 static inline s64 arch_atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	return xadd(&v->counter, i);
 }
+#define arch_atomic64_fetch_add arch_atomic64_fetch_add
 
 static inline s64 arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
 	return xadd(&v->counter, -i);
 }
+#define arch_atomic64_fetch_sub arch_atomic64_fetch_sub
 
 static inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
 	return arch_cmpxchg(&v->counter, old, new);
 }
+#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
 
-#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
 static __always_inline bool arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	return try_cmpxchg(&v->counter, old, new);
 }
+#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
 
 static inline s64 arch_atomic64_xchg(atomic64_t *v, s64 new)
 {
 	return arch_xchg(&v->counter, new);
 }
+#define arch_atomic64_xchg arch_atomic64_xchg
 
 static inline void arch_atomic64_and(s64 i, atomic64_t *v)
 {
@@ -207,6 +213,7 @@ static inline s64 arch_atomic64_fetch_and(s64 i, atomic64_t *v)
 	} while (!arch_atomic64_try_cmpxchg(v, &val, val & i));
 	return val;
 }
+#define arch_atomic64_fetch_and arch_atomic64_fetch_and
 
 static inline void arch_atomic64_or(s64 i, atomic64_t *v)
 {
@@ -224,6 +231,7 @@ static inline s64 arch_atomic64_fetch_or(s64 i, atomic64_t *v)
 	} while (!arch_atomic64_try_cmpxchg(v, &val, val | i));
 	return val;
 }
+#define arch_atomic64_fetch_or arch_atomic64_fetch_or
 
 static inline void arch_atomic64_xor(s64 i, atomic64_t *v)
 {
@@ -241,5 +249,6 @@ static inline s64 arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
 	} while (!arch_atomic64_try_cmpxchg(v, &val, val ^ i));
 	return val;
 }
+#define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
 
 #endif /* _ASM_X86_ATOMIC64_64_H */
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 0367efdc5b7a..35460fef39b8 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -201,8 +201,12 @@ arch_test_and_change_bit(long nr, volatile unsigned long *addr)
 	return GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(btc), *addr, c, "Ir", nr);
 }
 
-static __always_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
+static __no_kcsan_or_inline bool constant_test_bit(long nr, const volatile unsigned long *addr)
 {
+	/*
+	 * Because this is a plain access, we need to disable KCSAN here to
+	 * avoid double instrumentation via instrumented bitops.
+	 */
 	return ((1UL << (nr & (BITS_PER_LONG-1))) &
 		(addr[nr >> _BITOPS_LONG_SHIFT])) != 0;
 }
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 8ef4369a4f06..e77261db2391 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -28,6 +28,10 @@ KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
 KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
 
+# With some compiler versions the generated code results in boot hangs, caused
+# by several compilation units. To be safe, disable all instrumentation.
+KCSAN_SANITIZE := n
+
 OBJECT_FILES_NON_STANDARD_test_nx.o			:= y
 OBJECT_FILES_NON_STANDARD_paravirt_patch.o		:= y
 
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 7dc4ad68eb41..dba6a83bc349 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -13,6 +13,9 @@ endif
 KCOV_INSTRUMENT_common.o := n
 KCOV_INSTRUMENT_perf_event.o := n
 
+# As above, instrumenting secondary CPU boot code causes boot hangs.
+KCSAN_SANITIZE_common.o := n
+
 # Make sure load_percpu_segment has no stackprotector
 nostackp := $(call cc-option, -fno-stack-protector)
 CFLAGS_common.o		:= $(nostackp)
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 4d13c57f370a..983cd53ed4c9 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -991,7 +991,15 @@ void __init e820__reserve_setup_data(void)
 	while (pa_data) {
 		data = early_memremap(pa_data, sizeof(*data));
 		e820__range_update(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
-		e820__range_update_kexec(pa_data, sizeof(*data)+data->len, E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
+
+		/*
+		 * SETUP_EFI is supplied by kexec and does not need to be
+		 * reserved.
+		 */
+		if (data->type != SETUP_EFI)
+			e820__range_update_kexec(pa_data,
+						 sizeof(*data) + data->len,
+						 E820_TYPE_RAM, E820_TYPE_RESERVED_KERN);
 
 		if (data->type == SETUP_INDIRECT &&
 		    ((struct setup_indirect *)data->data)->type != SETUP_INDIRECT) {
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 5246db42de45..6110bce7237b 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -6,10 +6,19 @@
 # Produces uninteresting flaky coverage.
 KCOV_INSTRUMENT_delay.o	:= n
 
+# KCSAN uses udelay for introducing watchpoint delay; avoid recursion.
+KCSAN_SANITIZE_delay.o := n
+ifdef CONFIG_KCSAN
+# In case KCSAN+lockdep+ftrace are enabled, disable ftrace for delay.o to avoid
+# lockdep -> [other libs] -> KCSAN -> udelay -> ftrace -> lockdep recursion.
+CFLAGS_REMOVE_delay.o = $(CC_FLAGS_FTRACE)
+endif
+
 # Early boot use of cmdline; don't instrument it
 ifdef CONFIG_AMD_MEM_ENCRYPT
 KCOV_INSTRUMENT_cmdline.o := n
 KASAN_SANITIZE_cmdline.o  := n
+KCSAN_SANITIZE_cmdline.o  := n
 
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_cmdline.o = -pg
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 98f7c6fa2eaa..f7fd0e868c9c 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -7,6 +7,10 @@ KCOV_INSTRUMENT_mem_encrypt_identity.o	:= n
 KASAN_SANITIZE_mem_encrypt.o		:= n
 KASAN_SANITIZE_mem_encrypt_identity.o	:= n
 
+# Disable KCSAN entirely, because otherwise we get warnings that some functions
+# reference __initdata sections.
+KCSAN_SANITIZE := n
+
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_mem_encrypt.o		= -pg
 CFLAGS_REMOVE_mem_encrypt_identity.o	= -pg
diff --git a/arch/x86/purgatory/.gitignore b/arch/x86/purgatory/.gitignore
new file mode 100644
index 000000000000..d2be1500671d
--- /dev/null
+++ b/arch/x86/purgatory/.gitignore
@@ -0,0 +1 @@
+purgatory.chk
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index fb4ee5444379..b04e6e72a592 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -14,10 +14,18 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 
-LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
-targets += purgatory.ro
-
+# When linking purgatory.ro with -r unresolved symbols are not checked,
+# also link a purgatory.chk binary without -r to check for unresolved symbols.
+PURGATORY_LDFLAGS := -e purgatory_start -nostdlib -z nodefaultlib
+LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
+LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
+targets += purgatory.ro purgatory.chk
+
+# Sanitizer, etc. runtimes are unavailable and cannot be linked here.
+GCOV_PROFILE	:= n
 KASAN_SANITIZE	:= n
+UBSAN_SANITIZE	:= n
+KCSAN_SANITIZE	:= n
 KCOV_INSTRUMENT := n
 
 # These are adjustments to the compiler flags used for objects that
@@ -25,7 +33,7 @@ KCOV_INSTRUMENT := n
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
-PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN)
+PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
@@ -58,12 +66,15 @@ CFLAGS_string.o			+= $(PURGATORY_CFLAGS)
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
 
+$(obj)/purgatory.chk: $(obj)/purgatory.ro FORCE
+		$(call if_changed,ld)
+
 targets += kexec-purgatory.c
 
 quiet_cmd_bin2c = BIN2C   $@
       cmd_bin2c = $(objtree)/scripts/bin2c kexec_purgatory < $< > $@
 
-$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro FORCE
+$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro $(obj)/purgatory.chk FORCE
 	$(call if_changed,bin2c)
 
 obj-$(CONFIG_KEXEC_FILE)	+= kexec-purgatory.o
diff --git a/arch/x86/realmode/Makefile b/arch/x86/realmode/Makefile
index 682c895753d9..6b1f3a4eeb44 100644
--- a/arch/x86/realmode/Makefile
+++ b/arch/x86/realmode/Makefile
@@ -6,7 +6,10 @@
 # for more details.
 #
 #
+
+# Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 subdir- := rm
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index b11ec5d8f8ac..83f1b6a56449 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -6,7 +6,10 @@
 # for more details.
 #
 #
+
+# Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
 # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index cce4a7436052..75daaf20374e 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -37,7 +37,9 @@ KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
 
 GCOV_PROFILE			:= n
+# Sanitizer runtimes are unavailable and cannot be linked here.
 KASAN_SANITIZE			:= n
+KCSAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
 
diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index e8730c6b9fe2..379986e40159 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -18,1623 +18,1624 @@
 #define _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
 
 #include <linux/build_bug.h>
-#include <linux/kasan-checks.h>
+#include <linux/compiler.h>
+#include <linux/instrumented.h>
 
-static inline int
+static __always_inline int
 atomic_read(const atomic_t *v)
 {
-	kasan_check_read(v, sizeof(*v));
+	instrument_atomic_read(v, sizeof(*v));
 	return arch_atomic_read(v);
 }
 #define atomic_read atomic_read
 
 #if defined(arch_atomic_read_acquire)
-static inline int
+static __always_inline int
 atomic_read_acquire(const atomic_t *v)
 {
-	kasan_check_read(v, sizeof(*v));
+	instrument_atomic_read(v, sizeof(*v));
 	return arch_atomic_read_acquire(v);
 }
 #define atomic_read_acquire atomic_read_acquire
 #endif
 
-static inline void
+static __always_inline void
 atomic_set(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_set(v, i);
 }
 #define atomic_set atomic_set
 
 #if defined(arch_atomic_set_release)
-static inline void
+static __always_inline void
 atomic_set_release(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_set_release(v, i);
 }
 #define atomic_set_release atomic_set_release
 #endif
 
-static inline void
+static __always_inline void
 atomic_add(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_add(i, v);
 }
 #define atomic_add atomic_add
 
 #if !defined(arch_atomic_add_return_relaxed) || defined(arch_atomic_add_return)
-static inline int
+static __always_inline int
 atomic_add_return(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_add_return(i, v);
 }
 #define atomic_add_return atomic_add_return
 #endif
 
 #if defined(arch_atomic_add_return_acquire)
-static inline int
+static __always_inline int
 atomic_add_return_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_add_return_acquire(i, v);
 }
 #define atomic_add_return_acquire atomic_add_return_acquire
 #endif
 
 #if defined(arch_atomic_add_return_release)
-static inline int
+static __always_inline int
 atomic_add_return_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_add_return_release(i, v);
 }
 #define atomic_add_return_release atomic_add_return_release
 #endif
 
 #if defined(arch_atomic_add_return_relaxed)
-static inline int
+static __always_inline int
 atomic_add_return_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_add_return_relaxed(i, v);
 }
 #define atomic_add_return_relaxed atomic_add_return_relaxed
 #endif
 
 #if !defined(arch_atomic_fetch_add_relaxed) || defined(arch_atomic_fetch_add)
-static inline int
+static __always_inline int
 atomic_fetch_add(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_add(i, v);
 }
 #define atomic_fetch_add atomic_fetch_add
 #endif
 
 #if defined(arch_atomic_fetch_add_acquire)
-static inline int
+static __always_inline int
 atomic_fetch_add_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_acquire(i, v);
 }
 #define atomic_fetch_add_acquire atomic_fetch_add_acquire
 #endif
 
 #if defined(arch_atomic_fetch_add_release)
-static inline int
+static __always_inline int
 atomic_fetch_add_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_release(i, v);
 }
 #define atomic_fetch_add_release atomic_fetch_add_release
 #endif
 
 #if defined(arch_atomic_fetch_add_relaxed)
-static inline int
+static __always_inline int
 atomic_fetch_add_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_relaxed(i, v);
 }
 #define atomic_fetch_add_relaxed atomic_fetch_add_relaxed
 #endif
 
-static inline void
+static __always_inline void
 atomic_sub(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_sub(i, v);
 }
 #define atomic_sub atomic_sub
 
 #if !defined(arch_atomic_sub_return_relaxed) || defined(arch_atomic_sub_return)
-static inline int
+static __always_inline int
 atomic_sub_return(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_sub_return(i, v);
 }
 #define atomic_sub_return atomic_sub_return
 #endif
 
 #if defined(arch_atomic_sub_return_acquire)
-static inline int
+static __always_inline int
 atomic_sub_return_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_sub_return_acquire(i, v);
 }
 #define atomic_sub_return_acquire atomic_sub_return_acquire
 #endif
 
 #if defined(arch_atomic_sub_return_release)
-static inline int
+static __always_inline int
 atomic_sub_return_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_sub_return_release(i, v);
 }
 #define atomic_sub_return_release atomic_sub_return_release
 #endif
 
 #if defined(arch_atomic_sub_return_relaxed)
-static inline int
+static __always_inline int
 atomic_sub_return_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_sub_return_relaxed(i, v);
 }
 #define atomic_sub_return_relaxed atomic_sub_return_relaxed
 #endif
 
 #if !defined(arch_atomic_fetch_sub_relaxed) || defined(arch_atomic_fetch_sub)
-static inline int
+static __always_inline int
 atomic_fetch_sub(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub(i, v);
 }
 #define atomic_fetch_sub atomic_fetch_sub
 #endif
 
 #if defined(arch_atomic_fetch_sub_acquire)
-static inline int
+static __always_inline int
 atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_acquire(i, v);
 }
 #define atomic_fetch_sub_acquire atomic_fetch_sub_acquire
 #endif
 
 #if defined(arch_atomic_fetch_sub_release)
-static inline int
+static __always_inline int
 atomic_fetch_sub_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_release(i, v);
 }
 #define atomic_fetch_sub_release atomic_fetch_sub_release
 #endif
 
 #if defined(arch_atomic_fetch_sub_relaxed)
-static inline int
+static __always_inline int
 atomic_fetch_sub_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_relaxed(i, v);
 }
 #define atomic_fetch_sub_relaxed atomic_fetch_sub_relaxed
 #endif
 
 #if defined(arch_atomic_inc)
-static inline void
+static __always_inline void
 atomic_inc(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_inc(v);
 }
 #define atomic_inc atomic_inc
 #endif
 
 #if defined(arch_atomic_inc_return)
-static inline int
+static __always_inline int
 atomic_inc_return(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_inc_return(v);
 }
 #define atomic_inc_return atomic_inc_return
 #endif
 
 #if defined(arch_atomic_inc_return_acquire)
-static inline int
+static __always_inline int
 atomic_inc_return_acquire(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_inc_return_acquire(v);
 }
 #define atomic_inc_return_acquire atomic_inc_return_acquire
 #endif
 
 #if defined(arch_atomic_inc_return_release)
-static inline int
+static __always_inline int
 atomic_inc_return_release(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_inc_return_release(v);
 }
 #define atomic_inc_return_release atomic_inc_return_release
 #endif
 
 #if defined(arch_atomic_inc_return_relaxed)
-static inline int
+static __always_inline int
 atomic_inc_return_relaxed(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_inc_return_relaxed(v);
 }
 #define atomic_inc_return_relaxed atomic_inc_return_relaxed
 #endif
 
 #if defined(arch_atomic_fetch_inc)
-static inline int
+static __always_inline int
 atomic_fetch_inc(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc(v);
 }
 #define atomic_fetch_inc atomic_fetch_inc
 #endif
 
 #if defined(arch_atomic_fetch_inc_acquire)
-static inline int
+static __always_inline int
 atomic_fetch_inc_acquire(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_acquire(v);
 }
 #define atomic_fetch_inc_acquire atomic_fetch_inc_acquire
 #endif
 
 #if defined(arch_atomic_fetch_inc_release)
-static inline int
+static __always_inline int
 atomic_fetch_inc_release(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_release(v);
 }
 #define atomic_fetch_inc_release atomic_fetch_inc_release
 #endif
 
 #if defined(arch_atomic_fetch_inc_relaxed)
-static inline int
+static __always_inline int
 atomic_fetch_inc_relaxed(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_relaxed(v);
 }
 #define atomic_fetch_inc_relaxed atomic_fetch_inc_relaxed
 #endif
 
 #if defined(arch_atomic_dec)
-static inline void
+static __always_inline void
 atomic_dec(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_dec(v);
 }
 #define atomic_dec atomic_dec
 #endif
 
 #if defined(arch_atomic_dec_return)
-static inline int
+static __always_inline int
 atomic_dec_return(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_dec_return(v);
 }
 #define atomic_dec_return atomic_dec_return
 #endif
 
 #if defined(arch_atomic_dec_return_acquire)
-static inline int
+static __always_inline int
 atomic_dec_return_acquire(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_dec_return_acquire(v);
 }
 #define atomic_dec_return_acquire atomic_dec_return_acquire
 #endif
 
 #if defined(arch_atomic_dec_return_release)
-static inline int
+static __always_inline int
 atomic_dec_return_release(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_dec_return_release(v);
 }
 #define atomic_dec_return_release atomic_dec_return_release
 #endif
 
 #if defined(arch_atomic_dec_return_relaxed)
-static inline int
+static __always_inline int
 atomic_dec_return_relaxed(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_dec_return_relaxed(v);
 }
 #define atomic_dec_return_relaxed atomic_dec_return_relaxed
 #endif
 
 #if defined(arch_atomic_fetch_dec)
-static inline int
+static __always_inline int
 atomic_fetch_dec(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec(v);
 }
 #define atomic_fetch_dec atomic_fetch_dec
 #endif
 
 #if defined(arch_atomic_fetch_dec_acquire)
-static inline int
+static __always_inline int
 atomic_fetch_dec_acquire(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_acquire(v);
 }
 #define atomic_fetch_dec_acquire atomic_fetch_dec_acquire
 #endif
 
 #if defined(arch_atomic_fetch_dec_release)
-static inline int
+static __always_inline int
 atomic_fetch_dec_release(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_release(v);
 }
 #define atomic_fetch_dec_release atomic_fetch_dec_release
 #endif
 
 #if defined(arch_atomic_fetch_dec_relaxed)
-static inline int
+static __always_inline int
 atomic_fetch_dec_relaxed(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_relaxed(v);
 }
 #define atomic_fetch_dec_relaxed atomic_fetch_dec_relaxed
 #endif
 
-static inline void
+static __always_inline void
 atomic_and(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_and(i, v);
 }
 #define atomic_and atomic_and
 
 #if !defined(arch_atomic_fetch_and_relaxed) || defined(arch_atomic_fetch_and)
-static inline int
+static __always_inline int
 atomic_fetch_and(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_and(i, v);
 }
 #define atomic_fetch_and atomic_fetch_and
 #endif
 
 #if defined(arch_atomic_fetch_and_acquire)
-static inline int
+static __always_inline int
 atomic_fetch_and_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_acquire(i, v);
 }
 #define atomic_fetch_and_acquire atomic_fetch_and_acquire
 #endif
 
 #if defined(arch_atomic_fetch_and_release)
-static inline int
+static __always_inline int
 atomic_fetch_and_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_release(i, v);
 }
 #define atomic_fetch_and_release atomic_fetch_and_release
 #endif
 
 #if defined(arch_atomic_fetch_and_relaxed)
-static inline int
+static __always_inline int
 atomic_fetch_and_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_relaxed(i, v);
 }
 #define atomic_fetch_and_relaxed atomic_fetch_and_relaxed
 #endif
 
 #if defined(arch_atomic_andnot)
-static inline void
+static __always_inline void
 atomic_andnot(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_andnot(i, v);
 }
 #define atomic_andnot atomic_andnot
 #endif
 
 #if defined(arch_atomic_fetch_andnot)
-static inline int
+static __always_inline int
 atomic_fetch_andnot(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot(i, v);
 }
 #define atomic_fetch_andnot atomic_fetch_andnot
 #endif
 
 #if defined(arch_atomic_fetch_andnot_acquire)
-static inline int
+static __always_inline int
 atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_acquire(i, v);
 }
 #define atomic_fetch_andnot_acquire atomic_fetch_andnot_acquire
 #endif
 
 #if defined(arch_atomic_fetch_andnot_release)
-static inline int
+static __always_inline int
 atomic_fetch_andnot_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_release(i, v);
 }
 #define atomic_fetch_andnot_release atomic_fetch_andnot_release
 #endif
 
 #if defined(arch_atomic_fetch_andnot_relaxed)
-static inline int
+static __always_inline int
 atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_relaxed(i, v);
 }
 #define atomic_fetch_andnot_relaxed atomic_fetch_andnot_relaxed
 #endif
 
-static inline void
+static __always_inline void
 atomic_or(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_or(i, v);
 }
 #define atomic_or atomic_or
 
 #if !defined(arch_atomic_fetch_or_relaxed) || defined(arch_atomic_fetch_or)
-static inline int
+static __always_inline int
 atomic_fetch_or(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_or(i, v);
 }
 #define atomic_fetch_or atomic_fetch_or
 #endif
 
 #if defined(arch_atomic_fetch_or_acquire)
-static inline int
+static __always_inline int
 atomic_fetch_or_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_acquire(i, v);
 }
 #define atomic_fetch_or_acquire atomic_fetch_or_acquire
 #endif
 
 #if defined(arch_atomic_fetch_or_release)
-static inline int
+static __always_inline int
 atomic_fetch_or_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_release(i, v);
 }
 #define atomic_fetch_or_release atomic_fetch_or_release
 #endif
 
 #if defined(arch_atomic_fetch_or_relaxed)
-static inline int
+static __always_inline int
 atomic_fetch_or_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_relaxed(i, v);
 }
 #define atomic_fetch_or_relaxed atomic_fetch_or_relaxed
 #endif
 
-static inline void
+static __always_inline void
 atomic_xor(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_xor(i, v);
 }
 #define atomic_xor atomic_xor
 
 #if !defined(arch_atomic_fetch_xor_relaxed) || defined(arch_atomic_fetch_xor)
-static inline int
+static __always_inline int
 atomic_fetch_xor(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor(i, v);
 }
 #define atomic_fetch_xor atomic_fetch_xor
 #endif
 
 #if defined(arch_atomic_fetch_xor_acquire)
-static inline int
+static __always_inline int
 atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_acquire(i, v);
 }
 #define atomic_fetch_xor_acquire atomic_fetch_xor_acquire
 #endif
 
 #if defined(arch_atomic_fetch_xor_release)
-static inline int
+static __always_inline int
 atomic_fetch_xor_release(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_release(i, v);
 }
 #define atomic_fetch_xor_release atomic_fetch_xor_release
 #endif
 
 #if defined(arch_atomic_fetch_xor_relaxed)
-static inline int
+static __always_inline int
 atomic_fetch_xor_relaxed(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_relaxed(i, v);
 }
 #define atomic_fetch_xor_relaxed atomic_fetch_xor_relaxed
 #endif
 
 #if !defined(arch_atomic_xchg_relaxed) || defined(arch_atomic_xchg)
-static inline int
+static __always_inline int
 atomic_xchg(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_xchg(v, i);
 }
 #define atomic_xchg atomic_xchg
 #endif
 
 #if defined(arch_atomic_xchg_acquire)
-static inline int
+static __always_inline int
 atomic_xchg_acquire(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_xchg_acquire(v, i);
 }
 #define atomic_xchg_acquire atomic_xchg_acquire
 #endif
 
 #if defined(arch_atomic_xchg_release)
-static inline int
+static __always_inline int
 atomic_xchg_release(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_xchg_release(v, i);
 }
 #define atomic_xchg_release atomic_xchg_release
 #endif
 
 #if defined(arch_atomic_xchg_relaxed)
-static inline int
+static __always_inline int
 atomic_xchg_relaxed(atomic_t *v, int i)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_xchg_relaxed(v, i);
 }
 #define atomic_xchg_relaxed atomic_xchg_relaxed
 #endif
 
 #if !defined(arch_atomic_cmpxchg_relaxed) || defined(arch_atomic_cmpxchg)
-static inline int
+static __always_inline int
 atomic_cmpxchg(atomic_t *v, int old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg(v, old, new);
 }
 #define atomic_cmpxchg atomic_cmpxchg
 #endif
 
 #if defined(arch_atomic_cmpxchg_acquire)
-static inline int
+static __always_inline int
 atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_acquire(v, old, new);
 }
 #define atomic_cmpxchg_acquire atomic_cmpxchg_acquire
 #endif
 
 #if defined(arch_atomic_cmpxchg_release)
-static inline int
+static __always_inline int
 atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_release(v, old, new);
 }
 #define atomic_cmpxchg_release atomic_cmpxchg_release
 #endif
 
 #if defined(arch_atomic_cmpxchg_relaxed)
-static inline int
+static __always_inline int
 atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_relaxed(v, old, new);
 }
 #define atomic_cmpxchg_relaxed atomic_cmpxchg_relaxed
 #endif
 
 #if defined(arch_atomic_try_cmpxchg)
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
-	kasan_check_write(old, sizeof(*old));
+	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg(v, old, new);
 }
 #define atomic_try_cmpxchg atomic_try_cmpxchg
 #endif
 
 #if defined(arch_atomic_try_cmpxchg_acquire)
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
-	kasan_check_write(old, sizeof(*old));
+	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_acquire(v, old, new);
 }
 #define atomic_try_cmpxchg_acquire atomic_try_cmpxchg_acquire
 #endif
 
 #if defined(arch_atomic_try_cmpxchg_release)
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
-	kasan_check_write(old, sizeof(*old));
+	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_release(v, old, new);
 }
 #define atomic_try_cmpxchg_release atomic_try_cmpxchg_release
 #endif
 
 #if defined(arch_atomic_try_cmpxchg_relaxed)
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
-	kasan_check_write(v, sizeof(*v));
-	kasan_check_write(old, sizeof(*old));
+	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
 }
 #define atomic_try_cmpxchg_relaxed atomic_try_cmpxchg_relaxed
 #endif
 
 #if defined(arch_atomic_sub_and_test)
-static inline bool
+static __always_inline bool
 atomic_sub_and_test(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_sub_and_test(i, v);
 }
 #define atomic_sub_and_test atomic_sub_and_test
 #endif
 
 #if defined(arch_atomic_dec_and_test)
-static inline bool
+static __always_inline bool
 atomic_dec_and_test(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_dec_and_test(v);
 }
 #define atomic_dec_and_test atomic_dec_and_test
 #endif
 
 #if defined(arch_atomic_inc_and_test)
-static inline bool
+static __always_inline bool
 atomic_inc_and_test(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_inc_and_test(v);
 }
 #define atomic_inc_and_test atomic_inc_and_test
 #endif
 
 #if defined(arch_atomic_add_negative)
-static inline bool
+static __always_inline bool
 atomic_add_negative(int i, atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_add_negative(i, v);
 }
 #define atomic_add_negative atomic_add_negative
 #endif
 
 #if defined(arch_atomic_fetch_add_unless)
-static inline int
+static __always_inline int
 atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_unless(v, a, u);
 }
 #define atomic_fetch_add_unless atomic_fetch_add_unless
 #endif
 
 #if defined(arch_atomic_add_unless)
-static inline bool
+static __always_inline bool
 atomic_add_unless(atomic_t *v, int a, int u)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_add_unless(v, a, u);
 }
 #define atomic_add_unless atomic_add_unless
 #endif
 
 #if defined(arch_atomic_inc_not_zero)
-static inline bool
+static __always_inline bool
 atomic_inc_not_zero(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_inc_not_zero(v);
 }
 #define atomic_inc_not_zero atomic_inc_not_zero
 #endif
 
 #if defined(arch_atomic_inc_unless_negative)
-static inline bool
+static __always_inline bool
 atomic_inc_unless_negative(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_inc_unless_negative(v);
 }
 #define atomic_inc_unless_negative atomic_inc_unless_negative
 #endif
 
 #if defined(arch_atomic_dec_unless_positive)
-static inline bool
+static __always_inline bool
 atomic_dec_unless_positive(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_dec_unless_positive(v);
 }
 #define atomic_dec_unless_positive atomic_dec_unless_positive
 #endif
 
 #if defined(arch_atomic_dec_if_positive)
-static inline int
+static __always_inline int
 atomic_dec_if_positive(atomic_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic_dec_if_positive(v);
 }
 #define atomic_dec_if_positive atomic_dec_if_positive
 #endif
 
-static inline s64
+static __always_inline s64
 atomic64_read(const atomic64_t *v)
 {
-	kasan_check_read(v, sizeof(*v));
+	instrument_atomic_read(v, sizeof(*v));
 	return arch_atomic64_read(v);
 }
 #define atomic64_read atomic64_read
 
 #if defined(arch_atomic64_read_acquire)
-static inline s64
+static __always_inline s64
 atomic64_read_acquire(const atomic64_t *v)
 {
-	kasan_check_read(v, sizeof(*v));
+	instrument_atomic_read(v, sizeof(*v));
 	return arch_atomic64_read_acquire(v);
 }
 #define atomic64_read_acquire atomic64_read_acquire
 #endif
 
-static inline void
+static __always_inline void
 atomic64_set(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_set(v, i);
 }
 #define atomic64_set atomic64_set
 
 #if defined(arch_atomic64_set_release)
-static inline void
+static __always_inline void
 atomic64_set_release(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_set_release(v, i);
 }
 #define atomic64_set_release atomic64_set_release
 #endif
 
-static inline void
+static __always_inline void
 atomic64_add(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_add(i, v);
 }
 #define atomic64_add atomic64_add
 
 #if !defined(arch_atomic64_add_return_relaxed) || defined(arch_atomic64_add_return)
-static inline s64
+static __always_inline s64
 atomic64_add_return(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_add_return(i, v);
 }
 #define atomic64_add_return atomic64_add_return
 #endif
 
 #if defined(arch_atomic64_add_return_acquire)
-static inline s64
+static __always_inline s64
 atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_add_return_acquire(i, v);
 }
 #define atomic64_add_return_acquire atomic64_add_return_acquire
 #endif
 
 #if defined(arch_atomic64_add_return_release)
-static inline s64
+static __always_inline s64
 atomic64_add_return_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_add_return_release(i, v);
 }
 #define atomic64_add_return_release atomic64_add_return_release
 #endif
 
 #if defined(arch_atomic64_add_return_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_add_return_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_add_return_relaxed(i, v);
 }
 #define atomic64_add_return_relaxed atomic64_add_return_relaxed
 #endif
 
 #if !defined(arch_atomic64_fetch_add_relaxed) || defined(arch_atomic64_fetch_add)
-static inline s64
+static __always_inline s64
 atomic64_fetch_add(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add(i, v);
 }
 #define atomic64_fetch_add atomic64_fetch_add
 #endif
 
 #if defined(arch_atomic64_fetch_add_acquire)
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_acquire(i, v);
 }
 #define atomic64_fetch_add_acquire atomic64_fetch_add_acquire
 #endif
 
 #if defined(arch_atomic64_fetch_add_release)
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_release(i, v);
 }
 #define atomic64_fetch_add_release atomic64_fetch_add_release
 #endif
 
 #if defined(arch_atomic64_fetch_add_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_relaxed(i, v);
 }
 #define atomic64_fetch_add_relaxed atomic64_fetch_add_relaxed
 #endif
 
-static inline void
+static __always_inline void
 atomic64_sub(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_sub(i, v);
 }
 #define atomic64_sub atomic64_sub
 
 #if !defined(arch_atomic64_sub_return_relaxed) || defined(arch_atomic64_sub_return)
-static inline s64
+static __always_inline s64
 atomic64_sub_return(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_sub_return(i, v);
 }
 #define atomic64_sub_return atomic64_sub_return
 #endif
 
 #if defined(arch_atomic64_sub_return_acquire)
-static inline s64
+static __always_inline s64
 atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_acquire(i, v);
 }
 #define atomic64_sub_return_acquire atomic64_sub_return_acquire
 #endif
 
 #if defined(arch_atomic64_sub_return_release)
-static inline s64
+static __always_inline s64
 atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_release(i, v);
 }
 #define atomic64_sub_return_release atomic64_sub_return_release
 #endif
 
 #if defined(arch_atomic64_sub_return_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_relaxed(i, v);
 }
 #define atomic64_sub_return_relaxed atomic64_sub_return_relaxed
 #endif
 
 #if !defined(arch_atomic64_fetch_sub_relaxed) || defined(arch_atomic64_fetch_sub)
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub(i, v);
 }
 #define atomic64_fetch_sub atomic64_fetch_sub
 #endif
 
 #if defined(arch_atomic64_fetch_sub_acquire)
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_acquire(i, v);
 }
 #define atomic64_fetch_sub_acquire atomic64_fetch_sub_acquire
 #endif
 
 #if defined(arch_atomic64_fetch_sub_release)
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_release(i, v);
 }
 #define atomic64_fetch_sub_release atomic64_fetch_sub_release
 #endif
 
 #if defined(arch_atomic64_fetch_sub_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_relaxed(i, v);
 }
 #define atomic64_fetch_sub_relaxed atomic64_fetch_sub_relaxed
 #endif
 
 #if defined(arch_atomic64_inc)
-static inline void
+static __always_inline void
 atomic64_inc(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_inc(v);
 }
 #define atomic64_inc atomic64_inc
 #endif
 
 #if defined(arch_atomic64_inc_return)
-static inline s64
+static __always_inline s64
 atomic64_inc_return(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_inc_return(v);
 }
 #define atomic64_inc_return atomic64_inc_return
 #endif
 
 #if defined(arch_atomic64_inc_return_acquire)
-static inline s64
+static __always_inline s64
 atomic64_inc_return_acquire(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_acquire(v);
 }
 #define atomic64_inc_return_acquire atomic64_inc_return_acquire
 #endif
 
 #if defined(arch_atomic64_inc_return_release)
-static inline s64
+static __always_inline s64
 atomic64_inc_return_release(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_release(v);
 }
 #define atomic64_inc_return_release atomic64_inc_return_release
 #endif
 
 #if defined(arch_atomic64_inc_return_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_inc_return_relaxed(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_relaxed(v);
 }
 #define atomic64_inc_return_relaxed atomic64_inc_return_relaxed
 #endif
 
 #if defined(arch_atomic64_fetch_inc)
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc(v);
 }
 #define atomic64_fetch_inc atomic64_fetch_inc
 #endif
 
 #if defined(arch_atomic64_fetch_inc_acquire)
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_acquire(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_acquire(v);
 }
 #define atomic64_fetch_inc_acquire atomic64_fetch_inc_acquire
 #endif
 
 #if defined(arch_atomic64_fetch_inc_release)
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_release(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_release(v);
 }
 #define atomic64_fetch_inc_release atomic64_fetch_inc_release
 #endif
 
 #if defined(arch_atomic64_fetch_inc_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_relaxed(v);
 }
 #define atomic64_fetch_inc_relaxed atomic64_fetch_inc_relaxed
 #endif
 
 #if defined(arch_atomic64_dec)
-static inline void
+static __always_inline void
 atomic64_dec(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_dec(v);
 }
 #define atomic64_dec atomic64_dec
 #endif
 
 #if defined(arch_atomic64_dec_return)
-static inline s64
+static __always_inline s64
 atomic64_dec_return(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_dec_return(v);
 }
 #define atomic64_dec_return atomic64_dec_return
 #endif
 
 #if defined(arch_atomic64_dec_return_acquire)
-static inline s64
+static __always_inline s64
 atomic64_dec_return_acquire(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_acquire(v);
 }
 #define atomic64_dec_return_acquire atomic64_dec_return_acquire
 #endif
 
 #if defined(arch_atomic64_dec_return_release)
-static inline s64
+static __always_inline s64
 atomic64_dec_return_release(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_release(v);
 }
 #define atomic64_dec_return_release atomic64_dec_return_release
 #endif
 
 #if defined(arch_atomic64_dec_return_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_dec_return_relaxed(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_relaxed(v);
 }
 #define atomic64_dec_return_relaxed atomic64_dec_return_relaxed
 #endif
 
 #if defined(arch_atomic64_fetch_dec)
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec(v);
 }
 #define atomic64_fetch_dec atomic64_fetch_dec
 #endif
 
 #if defined(arch_atomic64_fetch_dec_acquire)
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_acquire(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_acquire(v);
 }
 #define atomic64_fetch_dec_acquire atomic64_fetch_dec_acquire
 #endif
 
 #if defined(arch_atomic64_fetch_dec_release)
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_release(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_release(v);
 }
 #define atomic64_fetch_dec_release atomic64_fetch_dec_release
 #endif
 
 #if defined(arch_atomic64_fetch_dec_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_relaxed(v);
 }
 #define atomic64_fetch_dec_relaxed atomic64_fetch_dec_relaxed
 #endif
 
-static inline void
+static __always_inline void
 atomic64_and(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_and(i, v);
 }
 #define atomic64_and atomic64_and
 
 #if !defined(arch_atomic64_fetch_and_relaxed) || defined(arch_atomic64_fetch_and)
-static inline s64
+static __always_inline s64
 atomic64_fetch_and(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and(i, v);
 }
 #define atomic64_fetch_and atomic64_fetch_and
 #endif
 
 #if defined(arch_atomic64_fetch_and_acquire)
-static inline s64
+static __always_inline s64
 atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_acquire(i, v);
 }
 #define atomic64_fetch_and_acquire atomic64_fetch_and_acquire
 #endif
 
 #if defined(arch_atomic64_fetch_and_release)
-static inline s64
+static __always_inline s64
 atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_release(i, v);
 }
 #define atomic64_fetch_and_release atomic64_fetch_and_release
 #endif
 
 #if defined(arch_atomic64_fetch_and_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_relaxed(i, v);
 }
 #define atomic64_fetch_and_relaxed atomic64_fetch_and_relaxed
 #endif
 
 #if defined(arch_atomic64_andnot)
-static inline void
+static __always_inline void
 atomic64_andnot(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_andnot(i, v);
 }
 #define atomic64_andnot atomic64_andnot
 #endif
 
 #if defined(arch_atomic64_fetch_andnot)
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot(i, v);
 }
 #define atomic64_fetch_andnot atomic64_fetch_andnot
 #endif
 
 #if defined(arch_atomic64_fetch_andnot_acquire)
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_acquire(i, v);
 }
 #define atomic64_fetch_andnot_acquire atomic64_fetch_andnot_acquire
 #endif
 
 #if defined(arch_atomic64_fetch_andnot_release)
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_release(i, v);
 }
 #define atomic64_fetch_andnot_release atomic64_fetch_andnot_release
 #endif
 
 #if defined(arch_atomic64_fetch_andnot_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_relaxed(i, v);
 }
 #define atomic64_fetch_andnot_relaxed atomic64_fetch_andnot_relaxed
 #endif
 
-static inline void
+static __always_inline void
 atomic64_or(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_or(i, v);
 }
 #define atomic64_or atomic64_or
 
 #if !defined(arch_atomic64_fetch_or_relaxed) || defined(arch_atomic64_fetch_or)
-static inline s64
+static __always_inline s64
 atomic64_fetch_or(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or(i, v);
 }
 #define atomic64_fetch_or atomic64_fetch_or
 #endif
 
 #if defined(arch_atomic64_fetch_or_acquire)
-static inline s64
+static __always_inline s64
 atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_acquire(i, v);
 }
 #define atomic64_fetch_or_acquire atomic64_fetch_or_acquire
 #endif
 
 #if defined(arch_atomic64_fetch_or_release)
-static inline s64
+static __always_inline s64
 atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_release(i, v);
 }
 #define atomic64_fetch_or_release atomic64_fetch_or_release
 #endif
 
 #if defined(arch_atomic64_fetch_or_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_relaxed(i, v);
 }
 #define atomic64_fetch_or_relaxed atomic64_fetch_or_relaxed
 #endif
 
-static inline void
+static __always_inline void
 atomic64_xor(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_xor(i, v);
 }
 #define atomic64_xor atomic64_xor
 
 #if !defined(arch_atomic64_fetch_xor_relaxed) || defined(arch_atomic64_fetch_xor)
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor(i, v);
 }
 #define atomic64_fetch_xor atomic64_fetch_xor
 #endif
 
 #if defined(arch_atomic64_fetch_xor_acquire)
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_acquire(i, v);
 }
 #define atomic64_fetch_xor_acquire atomic64_fetch_xor_acquire
 #endif
 
 #if defined(arch_atomic64_fetch_xor_release)
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_release(i, v);
 }
 #define atomic64_fetch_xor_release atomic64_fetch_xor_release
 #endif
 
 #if defined(arch_atomic64_fetch_xor_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_relaxed(i, v);
 }
 #define atomic64_fetch_xor_relaxed atomic64_fetch_xor_relaxed
 #endif
 
 #if !defined(arch_atomic64_xchg_relaxed) || defined(arch_atomic64_xchg)
-static inline s64
+static __always_inline s64
 atomic64_xchg(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_xchg(v, i);
 }
 #define atomic64_xchg atomic64_xchg
 #endif
 
 #if defined(arch_atomic64_xchg_acquire)
-static inline s64
+static __always_inline s64
 atomic64_xchg_acquire(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_xchg_acquire(v, i);
 }
 #define atomic64_xchg_acquire atomic64_xchg_acquire
 #endif
 
 #if defined(arch_atomic64_xchg_release)
-static inline s64
+static __always_inline s64
 atomic64_xchg_release(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_xchg_release(v, i);
 }
 #define atomic64_xchg_release atomic64_xchg_release
 #endif
 
 #if defined(arch_atomic64_xchg_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_xchg_relaxed(atomic64_t *v, s64 i)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_xchg_relaxed(v, i);
 }
 #define atomic64_xchg_relaxed atomic64_xchg_relaxed
 #endif
 
 #if !defined(arch_atomic64_cmpxchg_relaxed) || defined(arch_atomic64_cmpxchg)
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg(v, old, new);
 }
 #define atomic64_cmpxchg atomic64_cmpxchg
 #endif
 
 #if defined(arch_atomic64_cmpxchg_acquire)
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_acquire(v, old, new);
 }
 #define atomic64_cmpxchg_acquire atomic64_cmpxchg_acquire
 #endif
 
 #if defined(arch_atomic64_cmpxchg_release)
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_release(v, old, new);
 }
 #define atomic64_cmpxchg_release atomic64_cmpxchg_release
 #endif
 
 #if defined(arch_atomic64_cmpxchg_relaxed)
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_relaxed(v, old, new);
 }
 #define atomic64_cmpxchg_relaxed atomic64_cmpxchg_relaxed
 #endif
 
 #if defined(arch_atomic64_try_cmpxchg)
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
-	kasan_check_write(old, sizeof(*old));
+	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg(v, old, new);
 }
 #define atomic64_try_cmpxchg atomic64_try_cmpxchg
 #endif
 
 #if defined(arch_atomic64_try_cmpxchg_acquire)
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
-	kasan_check_write(old, sizeof(*old));
+	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_acquire(v, old, new);
 }
 #define atomic64_try_cmpxchg_acquire atomic64_try_cmpxchg_acquire
 #endif
 
 #if defined(arch_atomic64_try_cmpxchg_release)
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
-	kasan_check_write(old, sizeof(*old));
+	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_release(v, old, new);
 }
 #define atomic64_try_cmpxchg_release atomic64_try_cmpxchg_release
 #endif
 
 #if defined(arch_atomic64_try_cmpxchg_relaxed)
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
-	kasan_check_write(v, sizeof(*v));
-	kasan_check_write(old, sizeof(*old));
+	instrument_atomic_write(v, sizeof(*v));
+	instrument_atomic_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
 }
 #define atomic64_try_cmpxchg_relaxed atomic64_try_cmpxchg_relaxed
 #endif
 
 #if defined(arch_atomic64_sub_and_test)
-static inline bool
+static __always_inline bool
 atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_sub_and_test(i, v);
 }
 #define atomic64_sub_and_test atomic64_sub_and_test
 #endif
 
 #if defined(arch_atomic64_dec_and_test)
-static inline bool
+static __always_inline bool
 atomic64_dec_and_test(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_dec_and_test(v);
 }
 #define atomic64_dec_and_test atomic64_dec_and_test
 #endif
 
 #if defined(arch_atomic64_inc_and_test)
-static inline bool
+static __always_inline bool
 atomic64_inc_and_test(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_inc_and_test(v);
 }
 #define atomic64_inc_and_test atomic64_inc_and_test
 #endif
 
 #if defined(arch_atomic64_add_negative)
-static inline bool
+static __always_inline bool
 atomic64_add_negative(s64 i, atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_add_negative(i, v);
 }
 #define atomic64_add_negative atomic64_add_negative
 #endif
 
 #if defined(arch_atomic64_fetch_add_unless)
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_unless(v, a, u);
 }
 #define atomic64_fetch_add_unless atomic64_fetch_add_unless
 #endif
 
 #if defined(arch_atomic64_add_unless)
-static inline bool
+static __always_inline bool
 atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_add_unless(v, a, u);
 }
 #define atomic64_add_unless atomic64_add_unless
 #endif
 
 #if defined(arch_atomic64_inc_not_zero)
-static inline bool
+static __always_inline bool
 atomic64_inc_not_zero(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_inc_not_zero(v);
 }
 #define atomic64_inc_not_zero atomic64_inc_not_zero
 #endif
 
 #if defined(arch_atomic64_inc_unless_negative)
-static inline bool
+static __always_inline bool
 atomic64_inc_unless_negative(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_inc_unless_negative(v);
 }
 #define atomic64_inc_unless_negative atomic64_inc_unless_negative
 #endif
 
 #if defined(arch_atomic64_dec_unless_positive)
-static inline bool
+static __always_inline bool
 atomic64_dec_unless_positive(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_dec_unless_positive(v);
 }
 #define atomic64_dec_unless_positive atomic64_dec_unless_positive
 #endif
 
 #if defined(arch_atomic64_dec_if_positive)
-static inline s64
+static __always_inline s64
 atomic64_dec_if_positive(atomic64_t *v)
 {
-	kasan_check_write(v, sizeof(*v));
+	instrument_atomic_write(v, sizeof(*v));
 	return arch_atomic64_dec_if_positive(v);
 }
 #define atomic64_dec_if_positive atomic64_dec_if_positive
@@ -1644,7 +1645,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define xchg(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_xchg(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1653,7 +1654,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define xchg_acquire(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_xchg_acquire(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1662,7 +1663,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define xchg_release(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_xchg_release(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1671,7 +1672,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define xchg_relaxed(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1680,7 +1681,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1689,7 +1690,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_acquire(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1698,7 +1699,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_release(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1707,7 +1708,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_relaxed(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1716,7 +1717,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg64(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1725,7 +1726,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg64_acquire(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1734,7 +1735,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg64_release(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1743,7 +1744,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg64_relaxed(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__);				\
 })
 #endif
@@ -1751,28 +1752,28 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_local(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg_local(__ai_ptr, __VA_ARGS__);				\
 })
 
 #define cmpxchg64_local(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_cmpxchg64_local(__ai_ptr, __VA_ARGS__);				\
 })
 
 #define sync_cmpxchg(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr));		\
 	arch_sync_cmpxchg(__ai_ptr, __VA_ARGS__);				\
 })
 
 #define cmpxchg_double(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
 	arch_cmpxchg_double(__ai_ptr, __VA_ARGS__);				\
 })
 
@@ -1780,9 +1781,9 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define cmpxchg_double_local(ptr, ...)						\
 ({									\
 	typeof(ptr) __ai_ptr = (ptr);					\
-	kasan_check_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
+	instrument_atomic_write(__ai_ptr, 2 * sizeof(*__ai_ptr));		\
 	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__);				\
 })
 
 #endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// b29b625d5de9280f680e42c7be859b55b15e5f6a
+// 89bf97f3a7509b740845e51ddf31055b48a81f40
diff --git a/include/asm-generic/atomic-long.h b/include/asm-generic/atomic-long.h
index 881c7e27af28..073cf40f431b 100644
--- a/include/asm-generic/atomic-long.h
+++ b/include/asm-generic/atomic-long.h
@@ -6,6 +6,7 @@
 #ifndef _ASM_GENERIC_ATOMIC_LONG_H
 #define _ASM_GENERIC_ATOMIC_LONG_H
 
+#include <linux/compiler.h>
 #include <asm/types.h>
 
 #ifdef CONFIG_64BIT
@@ -22,493 +23,493 @@ typedef atomic_t atomic_long_t;
 
 #ifdef CONFIG_64BIT
 
-static inline long
+static __always_inline long
 atomic_long_read(const atomic_long_t *v)
 {
 	return atomic64_read(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_read_acquire(const atomic_long_t *v)
 {
 	return atomic64_read_acquire(v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_set(atomic_long_t *v, long i)
 {
 	atomic64_set(v, i);
 }
 
-static inline void
+static __always_inline void
 atomic_long_set_release(atomic_long_t *v, long i)
 {
 	atomic64_set_release(v, i);
 }
 
-static inline void
+static __always_inline void
 atomic_long_add(long i, atomic_long_t *v)
 {
 	atomic64_add(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_add_return(long i, atomic_long_t *v)
 {
 	return atomic64_add_return(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_add_return_acquire(long i, atomic_long_t *v)
 {
 	return atomic64_add_return_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_add_return_release(long i, atomic_long_t *v)
 {
 	return atomic64_add_return_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_add_return_relaxed(long i, atomic_long_t *v)
 {
 	return atomic64_add_return_relaxed(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_add(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_add_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add_release(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_add_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_add_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_sub(long i, atomic_long_t *v)
 {
 	atomic64_sub(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_sub_return(long i, atomic_long_t *v)
 {
 	return atomic64_sub_return(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_sub_return_acquire(long i, atomic_long_t *v)
 {
 	return atomic64_sub_return_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_sub_return_release(long i, atomic_long_t *v)
 {
 	return atomic64_sub_return_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
 {
 	return atomic64_sub_return_relaxed(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_sub(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_sub(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_sub_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_sub_release(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_sub_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_sub_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_inc(atomic_long_t *v)
 {
 	atomic64_inc(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_inc_return(atomic_long_t *v)
 {
 	return atomic64_inc_return(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_inc_return_acquire(atomic_long_t *v)
 {
 	return atomic64_inc_return_acquire(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_inc_return_release(atomic_long_t *v)
 {
 	return atomic64_inc_return_release(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_inc_return_relaxed(atomic_long_t *v)
 {
 	return atomic64_inc_return_relaxed(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_inc(atomic_long_t *v)
 {
 	return atomic64_fetch_inc(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_inc_acquire(atomic_long_t *v)
 {
 	return atomic64_fetch_inc_acquire(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_inc_release(atomic_long_t *v)
 {
 	return atomic64_fetch_inc_release(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_inc_relaxed(atomic_long_t *v)
 {
 	return atomic64_fetch_inc_relaxed(v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_dec(atomic_long_t *v)
 {
 	atomic64_dec(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_return(atomic_long_t *v)
 {
 	return atomic64_dec_return(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_return_acquire(atomic_long_t *v)
 {
 	return atomic64_dec_return_acquire(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_return_release(atomic_long_t *v)
 {
 	return atomic64_dec_return_release(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_return_relaxed(atomic_long_t *v)
 {
 	return atomic64_dec_return_relaxed(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_dec(atomic_long_t *v)
 {
 	return atomic64_fetch_dec(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_dec_acquire(atomic_long_t *v)
 {
 	return atomic64_fetch_dec_acquire(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_dec_release(atomic_long_t *v)
 {
 	return atomic64_fetch_dec_release(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_dec_relaxed(atomic_long_t *v)
 {
 	return atomic64_fetch_dec_relaxed(v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_and(long i, atomic_long_t *v)
 {
 	atomic64_and(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_and(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_and(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_and_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_and_release(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_and_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_and_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_andnot(long i, atomic_long_t *v)
 {
 	atomic64_andnot(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_andnot(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_andnot(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_andnot_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_andnot_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_andnot_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_or(long i, atomic_long_t *v)
 {
 	atomic64_or(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_or(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_or(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_or_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_or_release(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_or_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_or_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_xor(long i, atomic_long_t *v)
 {
 	atomic64_xor(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_xor(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_xor(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_xor_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_xor_release(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_xor_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
 {
 	return atomic64_fetch_xor_relaxed(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_xchg(atomic_long_t *v, long i)
 {
 	return atomic64_xchg(v, i);
 }
 
-static inline long
+static __always_inline long
 atomic_long_xchg_acquire(atomic_long_t *v, long i)
 {
 	return atomic64_xchg_acquire(v, i);
 }
 
-static inline long
+static __always_inline long
 atomic_long_xchg_release(atomic_long_t *v, long i)
 {
 	return atomic64_xchg_release(v, i);
 }
 
-static inline long
+static __always_inline long
 atomic_long_xchg_relaxed(atomic_long_t *v, long i)
 {
 	return atomic64_xchg_relaxed(v, i);
 }
 
-static inline long
+static __always_inline long
 atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
 {
 	return atomic64_cmpxchg(v, old, new);
 }
 
-static inline long
+static __always_inline long
 atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
 {
 	return atomic64_cmpxchg_acquire(v, old, new);
 }
 
-static inline long
+static __always_inline long
 atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
 {
 	return atomic64_cmpxchg_release(v, old, new);
 }
 
-static inline long
+static __always_inline long
 atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
 {
 	return atomic64_cmpxchg_relaxed(v, old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 {
 	return atomic64_try_cmpxchg(v, (s64 *)old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
 	return atomic64_try_cmpxchg_acquire(v, (s64 *)old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 {
 	return atomic64_try_cmpxchg_release(v, (s64 *)old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
 	return atomic64_try_cmpxchg_relaxed(v, (s64 *)old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_sub_and_test(long i, atomic_long_t *v)
 {
 	return atomic64_sub_and_test(i, v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_dec_and_test(atomic_long_t *v)
 {
 	return atomic64_dec_and_test(v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_inc_and_test(atomic_long_t *v)
 {
 	return atomic64_inc_and_test(v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_add_negative(long i, atomic_long_t *v)
 {
 	return atomic64_add_negative(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
 {
 	return atomic64_fetch_add_unless(v, a, u);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_add_unless(atomic_long_t *v, long a, long u)
 {
 	return atomic64_add_unless(v, a, u);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_inc_not_zero(atomic_long_t *v)
 {
 	return atomic64_inc_not_zero(v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_inc_unless_negative(atomic_long_t *v)
 {
 	return atomic64_inc_unless_negative(v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_dec_unless_positive(atomic_long_t *v)
 {
 	return atomic64_dec_unless_positive(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_if_positive(atomic_long_t *v)
 {
 	return atomic64_dec_if_positive(v);
@@ -516,493 +517,493 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 
 #else /* CONFIG_64BIT */
 
-static inline long
+static __always_inline long
 atomic_long_read(const atomic_long_t *v)
 {
 	return atomic_read(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_read_acquire(const atomic_long_t *v)
 {
 	return atomic_read_acquire(v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_set(atomic_long_t *v, long i)
 {
 	atomic_set(v, i);
 }
 
-static inline void
+static __always_inline void
 atomic_long_set_release(atomic_long_t *v, long i)
 {
 	atomic_set_release(v, i);
 }
 
-static inline void
+static __always_inline void
 atomic_long_add(long i, atomic_long_t *v)
 {
 	atomic_add(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_add_return(long i, atomic_long_t *v)
 {
 	return atomic_add_return(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_add_return_acquire(long i, atomic_long_t *v)
 {
 	return atomic_add_return_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_add_return_release(long i, atomic_long_t *v)
 {
 	return atomic_add_return_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_add_return_relaxed(long i, atomic_long_t *v)
 {
 	return atomic_add_return_relaxed(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add(long i, atomic_long_t *v)
 {
 	return atomic_fetch_add(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
 {
 	return atomic_fetch_add_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add_release(long i, atomic_long_t *v)
 {
 	return atomic_fetch_add_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
 {
 	return atomic_fetch_add_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_sub(long i, atomic_long_t *v)
 {
 	atomic_sub(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_sub_return(long i, atomic_long_t *v)
 {
 	return atomic_sub_return(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_sub_return_acquire(long i, atomic_long_t *v)
 {
 	return atomic_sub_return_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_sub_return_release(long i, atomic_long_t *v)
 {
 	return atomic_sub_return_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
 {
 	return atomic_sub_return_relaxed(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_sub(long i, atomic_long_t *v)
 {
 	return atomic_fetch_sub(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
 {
 	return atomic_fetch_sub_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_sub_release(long i, atomic_long_t *v)
 {
 	return atomic_fetch_sub_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
 {
 	return atomic_fetch_sub_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_inc(atomic_long_t *v)
 {
 	atomic_inc(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_inc_return(atomic_long_t *v)
 {
 	return atomic_inc_return(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_inc_return_acquire(atomic_long_t *v)
 {
 	return atomic_inc_return_acquire(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_inc_return_release(atomic_long_t *v)
 {
 	return atomic_inc_return_release(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_inc_return_relaxed(atomic_long_t *v)
 {
 	return atomic_inc_return_relaxed(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_inc(atomic_long_t *v)
 {
 	return atomic_fetch_inc(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_inc_acquire(atomic_long_t *v)
 {
 	return atomic_fetch_inc_acquire(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_inc_release(atomic_long_t *v)
 {
 	return atomic_fetch_inc_release(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_inc_relaxed(atomic_long_t *v)
 {
 	return atomic_fetch_inc_relaxed(v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_dec(atomic_long_t *v)
 {
 	atomic_dec(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_return(atomic_long_t *v)
 {
 	return atomic_dec_return(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_return_acquire(atomic_long_t *v)
 {
 	return atomic_dec_return_acquire(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_return_release(atomic_long_t *v)
 {
 	return atomic_dec_return_release(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_return_relaxed(atomic_long_t *v)
 {
 	return atomic_dec_return_relaxed(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_dec(atomic_long_t *v)
 {
 	return atomic_fetch_dec(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_dec_acquire(atomic_long_t *v)
 {
 	return atomic_fetch_dec_acquire(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_dec_release(atomic_long_t *v)
 {
 	return atomic_fetch_dec_release(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_dec_relaxed(atomic_long_t *v)
 {
 	return atomic_fetch_dec_relaxed(v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_and(long i, atomic_long_t *v)
 {
 	atomic_and(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_and(long i, atomic_long_t *v)
 {
 	return atomic_fetch_and(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
 {
 	return atomic_fetch_and_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_and_release(long i, atomic_long_t *v)
 {
 	return atomic_fetch_and_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
 {
 	return atomic_fetch_and_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_andnot(long i, atomic_long_t *v)
 {
 	atomic_andnot(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_andnot(long i, atomic_long_t *v)
 {
 	return atomic_fetch_andnot(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
 {
 	return atomic_fetch_andnot_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
 {
 	return atomic_fetch_andnot_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
 {
 	return atomic_fetch_andnot_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_or(long i, atomic_long_t *v)
 {
 	atomic_or(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_or(long i, atomic_long_t *v)
 {
 	return atomic_fetch_or(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
 {
 	return atomic_fetch_or_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_or_release(long i, atomic_long_t *v)
 {
 	return atomic_fetch_or_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
 {
 	return atomic_fetch_or_relaxed(i, v);
 }
 
-static inline void
+static __always_inline void
 atomic_long_xor(long i, atomic_long_t *v)
 {
 	atomic_xor(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_xor(long i, atomic_long_t *v)
 {
 	return atomic_fetch_xor(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
 {
 	return atomic_fetch_xor_acquire(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_xor_release(long i, atomic_long_t *v)
 {
 	return atomic_fetch_xor_release(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
 {
 	return atomic_fetch_xor_relaxed(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_xchg(atomic_long_t *v, long i)
 {
 	return atomic_xchg(v, i);
 }
 
-static inline long
+static __always_inline long
 atomic_long_xchg_acquire(atomic_long_t *v, long i)
 {
 	return atomic_xchg_acquire(v, i);
 }
 
-static inline long
+static __always_inline long
 atomic_long_xchg_release(atomic_long_t *v, long i)
 {
 	return atomic_xchg_release(v, i);
 }
 
-static inline long
+static __always_inline long
 atomic_long_xchg_relaxed(atomic_long_t *v, long i)
 {
 	return atomic_xchg_relaxed(v, i);
 }
 
-static inline long
+static __always_inline long
 atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
 {
 	return atomic_cmpxchg(v, old, new);
 }
 
-static inline long
+static __always_inline long
 atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
 {
 	return atomic_cmpxchg_acquire(v, old, new);
 }
 
-static inline long
+static __always_inline long
 atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
 {
 	return atomic_cmpxchg_release(v, old, new);
 }
 
-static inline long
+static __always_inline long
 atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
 {
 	return atomic_cmpxchg_relaxed(v, old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
 {
 	return atomic_try_cmpxchg(v, (int *)old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
 {
 	return atomic_try_cmpxchg_acquire(v, (int *)old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
 {
 	return atomic_try_cmpxchg_release(v, (int *)old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
 {
 	return atomic_try_cmpxchg_relaxed(v, (int *)old, new);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_sub_and_test(long i, atomic_long_t *v)
 {
 	return atomic_sub_and_test(i, v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_dec_and_test(atomic_long_t *v)
 {
 	return atomic_dec_and_test(v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_inc_and_test(atomic_long_t *v)
 {
 	return atomic_inc_and_test(v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_add_negative(long i, atomic_long_t *v)
 {
 	return atomic_add_negative(i, v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
 {
 	return atomic_fetch_add_unless(v, a, u);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_add_unless(atomic_long_t *v, long a, long u)
 {
 	return atomic_add_unless(v, a, u);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_inc_not_zero(atomic_long_t *v)
 {
 	return atomic_inc_not_zero(v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_inc_unless_negative(atomic_long_t *v)
 {
 	return atomic_inc_unless_negative(v);
 }
 
-static inline bool
+static __always_inline bool
 atomic_long_dec_unless_positive(atomic_long_t *v)
 {
 	return atomic_dec_unless_positive(v);
 }
 
-static inline long
+static __always_inline long
 atomic_long_dec_if_positive(atomic_long_t *v)
 {
 	return atomic_dec_if_positive(v);
@@ -1010,4 +1011,4 @@ atomic_long_dec_if_positive(atomic_long_t *v)
 
 #endif /* CONFIG_64BIT */
 #endif /* _ASM_GENERIC_ATOMIC_LONG_H */
-// 77558968132ce4f911ad53f6f52ce423006f6268
+// a624200981f552b2c6be4f32fe44da8289f30d87
diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/asm-generic/bitops/instrumented-atomic.h
index 18ce3c9e8eec..fb2cb33a4013 100644
--- a/include/asm-generic/bitops/instrumented-atomic.h
+++ b/include/asm-generic/bitops/instrumented-atomic.h
@@ -11,7 +11,7 @@
 #ifndef _ASM_GENERIC_BITOPS_INSTRUMENTED_ATOMIC_H
 #define _ASM_GENERIC_BITOPS_INSTRUMENTED_ATOMIC_H
 
-#include <linux/kasan-checks.h>
+#include <linux/instrumented.h>
 
 /**
  * set_bit - Atomically set a bit in memory
@@ -25,7 +25,7 @@
  */
 static inline void set_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_set_bit(nr, addr);
 }
 
@@ -38,7 +38,7 @@ static inline void set_bit(long nr, volatile unsigned long *addr)
  */
 static inline void clear_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_clear_bit(nr, addr);
 }
 
@@ -54,7 +54,7 @@ static inline void clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline void change_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_change_bit(nr, addr);
 }
 
@@ -67,7 +67,7 @@ static inline void change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_set_bit(nr, addr);
 }
 
@@ -80,7 +80,7 @@ static inline bool test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_clear_bit(nr, addr);
 }
 
@@ -93,7 +93,7 @@ static inline bool test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_change_bit(nr, addr);
 }
 
diff --git a/include/asm-generic/bitops/instrumented-lock.h b/include/asm-generic/bitops/instrumented-lock.h
index ec53fdeea9ec..b9bec468ae03 100644
--- a/include/asm-generic/bitops/instrumented-lock.h
+++ b/include/asm-generic/bitops/instrumented-lock.h
@@ -11,7 +11,7 @@
 #ifndef _ASM_GENERIC_BITOPS_INSTRUMENTED_LOCK_H
 #define _ASM_GENERIC_BITOPS_INSTRUMENTED_LOCK_H
 
-#include <linux/kasan-checks.h>
+#include <linux/instrumented.h>
 
 /**
  * clear_bit_unlock - Clear a bit in memory, for unlock
@@ -22,7 +22,7 @@
  */
 static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	arch_clear_bit_unlock(nr, addr);
 }
 
@@ -37,7 +37,7 @@ static inline void clear_bit_unlock(long nr, volatile unsigned long *addr)
  */
 static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit_unlock(nr, addr);
 }
 
@@ -52,7 +52,7 @@ static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
  */
 static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_and_set_bit_lock(nr, addr);
 }
 
@@ -71,7 +71,7 @@ static inline bool test_and_set_bit_lock(long nr, volatile unsigned long *addr)
 static inline bool
 clear_bit_unlock_is_negative_byte(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch_clear_bit_unlock_is_negative_byte(nr, addr);
 }
 /* Let everybody know we have it. */
diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
index 95ff28d128a1..20f788a25ef9 100644
--- a/include/asm-generic/bitops/instrumented-non-atomic.h
+++ b/include/asm-generic/bitops/instrumented-non-atomic.h
@@ -11,7 +11,7 @@
 #ifndef _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
 #define _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H
 
-#include <linux/kasan-checks.h>
+#include <linux/instrumented.h>
 
 /**
  * __set_bit - Set a bit in memory
@@ -24,7 +24,7 @@
  */
 static inline void __set_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___set_bit(nr, addr);
 }
 
@@ -39,7 +39,7 @@ static inline void __set_bit(long nr, volatile unsigned long *addr)
  */
 static inline void __clear_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___clear_bit(nr, addr);
 }
 
@@ -54,7 +54,7 @@ static inline void __clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline void __change_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	arch___change_bit(nr, addr);
 }
 
@@ -68,7 +68,7 @@ static inline void __change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_set_bit(nr, addr);
 }
 
@@ -82,7 +82,7 @@ static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_clear_bit(nr, addr);
 }
 
@@ -96,7 +96,7 @@ static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	kasan_check_write(addr + BIT_WORD(nr), sizeof(long));
+	instrument_write(addr + BIT_WORD(nr), sizeof(long));
 	return arch___test_and_change_bit(nr, addr);
 }
 
@@ -107,7 +107,7 @@ static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool test_bit(long nr, const volatile unsigned long *addr)
 {
-	kasan_check_read(addr + BIT_WORD(nr), sizeof(long));
+	instrument_atomic_read(addr + BIT_WORD(nr), sizeof(long));
 	return arch_test_bit(nr, addr);
 }
 
diff --git a/include/linux/atomic-arch-fallback.h b/include/linux/atomic-arch-fallback.h
new file mode 100644
index 000000000000..bcb6aa27cfa6
--- /dev/null
+++ b/include/linux/atomic-arch-fallback.h
@@ -0,0 +1,2291 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by scripts/atomic/gen-atomic-fallback.sh
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+#ifndef _LINUX_ATOMIC_FALLBACK_H
+#define _LINUX_ATOMIC_FALLBACK_H
+
+#include <linux/compiler.h>
+
+#ifndef arch_xchg_relaxed
+#define arch_xchg_relaxed		arch_xchg
+#define arch_xchg_acquire		arch_xchg
+#define arch_xchg_release		arch_xchg
+#else /* arch_xchg_relaxed */
+
+#ifndef arch_xchg_acquire
+#define arch_xchg_acquire(...) \
+	__atomic_op_acquire(arch_xchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_xchg_release
+#define arch_xchg_release(...) \
+	__atomic_op_release(arch_xchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_xchg
+#define arch_xchg(...) \
+	__atomic_op_fence(arch_xchg, __VA_ARGS__)
+#endif
+
+#endif /* arch_xchg_relaxed */
+
+#ifndef arch_cmpxchg_relaxed
+#define arch_cmpxchg_relaxed		arch_cmpxchg
+#define arch_cmpxchg_acquire		arch_cmpxchg
+#define arch_cmpxchg_release		arch_cmpxchg
+#else /* arch_cmpxchg_relaxed */
+
+#ifndef arch_cmpxchg_acquire
+#define arch_cmpxchg_acquire(...) \
+	__atomic_op_acquire(arch_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg_release
+#define arch_cmpxchg_release(...) \
+	__atomic_op_release(arch_cmpxchg, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg
+#define arch_cmpxchg(...) \
+	__atomic_op_fence(arch_cmpxchg, __VA_ARGS__)
+#endif
+
+#endif /* arch_cmpxchg_relaxed */
+
+#ifndef arch_cmpxchg64_relaxed
+#define arch_cmpxchg64_relaxed		arch_cmpxchg64
+#define arch_cmpxchg64_acquire		arch_cmpxchg64
+#define arch_cmpxchg64_release		arch_cmpxchg64
+#else /* arch_cmpxchg64_relaxed */
+
+#ifndef arch_cmpxchg64_acquire
+#define arch_cmpxchg64_acquire(...) \
+	__atomic_op_acquire(arch_cmpxchg64, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg64_release
+#define arch_cmpxchg64_release(...) \
+	__atomic_op_release(arch_cmpxchg64, __VA_ARGS__)
+#endif
+
+#ifndef arch_cmpxchg64
+#define arch_cmpxchg64(...) \
+	__atomic_op_fence(arch_cmpxchg64, __VA_ARGS__)
+#endif
+
+#endif /* arch_cmpxchg64_relaxed */
+
+#ifndef arch_atomic_read_acquire
+static __always_inline int
+arch_atomic_read_acquire(const atomic_t *v)
+{
+	return smp_load_acquire(&(v)->counter);
+}
+#define arch_atomic_read_acquire arch_atomic_read_acquire
+#endif
+
+#ifndef arch_atomic_set_release
+static __always_inline void
+arch_atomic_set_release(atomic_t *v, int i)
+{
+	smp_store_release(&(v)->counter, i);
+}
+#define arch_atomic_set_release arch_atomic_set_release
+#endif
+
+#ifndef arch_atomic_add_return_relaxed
+#define arch_atomic_add_return_acquire arch_atomic_add_return
+#define arch_atomic_add_return_release arch_atomic_add_return
+#define arch_atomic_add_return_relaxed arch_atomic_add_return
+#else /* arch_atomic_add_return_relaxed */
+
+#ifndef arch_atomic_add_return_acquire
+static __always_inline int
+arch_atomic_add_return_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_add_return_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_add_return_acquire arch_atomic_add_return_acquire
+#endif
+
+#ifndef arch_atomic_add_return_release
+static __always_inline int
+arch_atomic_add_return_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_add_return_relaxed(i, v);
+}
+#define arch_atomic_add_return_release arch_atomic_add_return_release
+#endif
+
+#ifndef arch_atomic_add_return
+static __always_inline int
+arch_atomic_add_return(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_add_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_add_return arch_atomic_add_return
+#endif
+
+#endif /* arch_atomic_add_return_relaxed */
+
+#ifndef arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_add_acquire arch_atomic_fetch_add
+#define arch_atomic_fetch_add_release arch_atomic_fetch_add
+#define arch_atomic_fetch_add_relaxed arch_atomic_fetch_add
+#else /* arch_atomic_fetch_add_relaxed */
+
+#ifndef arch_atomic_fetch_add_acquire
+static __always_inline int
+arch_atomic_fetch_add_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_add_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_add_acquire arch_atomic_fetch_add_acquire
+#endif
+
+#ifndef arch_atomic_fetch_add_release
+static __always_inline int
+arch_atomic_fetch_add_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_add_relaxed(i, v);
+}
+#define arch_atomic_fetch_add_release arch_atomic_fetch_add_release
+#endif
+
+#ifndef arch_atomic_fetch_add
+static __always_inline int
+arch_atomic_fetch_add(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_add_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_add arch_atomic_fetch_add
+#endif
+
+#endif /* arch_atomic_fetch_add_relaxed */
+
+#ifndef arch_atomic_sub_return_relaxed
+#define arch_atomic_sub_return_acquire arch_atomic_sub_return
+#define arch_atomic_sub_return_release arch_atomic_sub_return
+#define arch_atomic_sub_return_relaxed arch_atomic_sub_return
+#else /* arch_atomic_sub_return_relaxed */
+
+#ifndef arch_atomic_sub_return_acquire
+static __always_inline int
+arch_atomic_sub_return_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_sub_return_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_sub_return_acquire arch_atomic_sub_return_acquire
+#endif
+
+#ifndef arch_atomic_sub_return_release
+static __always_inline int
+arch_atomic_sub_return_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_sub_return_relaxed(i, v);
+}
+#define arch_atomic_sub_return_release arch_atomic_sub_return_release
+#endif
+
+#ifndef arch_atomic_sub_return
+static __always_inline int
+arch_atomic_sub_return(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_sub_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_sub_return arch_atomic_sub_return
+#endif
+
+#endif /* arch_atomic_sub_return_relaxed */
+
+#ifndef arch_atomic_fetch_sub_relaxed
+#define arch_atomic_fetch_sub_acquire arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub_release arch_atomic_fetch_sub
+#define arch_atomic_fetch_sub_relaxed arch_atomic_fetch_sub
+#else /* arch_atomic_fetch_sub_relaxed */
+
+#ifndef arch_atomic_fetch_sub_acquire
+static __always_inline int
+arch_atomic_fetch_sub_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_sub_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_sub_acquire arch_atomic_fetch_sub_acquire
+#endif
+
+#ifndef arch_atomic_fetch_sub_release
+static __always_inline int
+arch_atomic_fetch_sub_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_sub_relaxed(i, v);
+}
+#define arch_atomic_fetch_sub_release arch_atomic_fetch_sub_release
+#endif
+
+#ifndef arch_atomic_fetch_sub
+static __always_inline int
+arch_atomic_fetch_sub(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_sub_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_sub arch_atomic_fetch_sub
+#endif
+
+#endif /* arch_atomic_fetch_sub_relaxed */
+
+#ifndef arch_atomic_inc
+static __always_inline void
+arch_atomic_inc(atomic_t *v)
+{
+	arch_atomic_add(1, v);
+}
+#define arch_atomic_inc arch_atomic_inc
+#endif
+
+#ifndef arch_atomic_inc_return_relaxed
+#ifdef arch_atomic_inc_return
+#define arch_atomic_inc_return_acquire arch_atomic_inc_return
+#define arch_atomic_inc_return_release arch_atomic_inc_return
+#define arch_atomic_inc_return_relaxed arch_atomic_inc_return
+#endif /* arch_atomic_inc_return */
+
+#ifndef arch_atomic_inc_return
+static __always_inline int
+arch_atomic_inc_return(atomic_t *v)
+{
+	return arch_atomic_add_return(1, v);
+}
+#define arch_atomic_inc_return arch_atomic_inc_return
+#endif
+
+#ifndef arch_atomic_inc_return_acquire
+static __always_inline int
+arch_atomic_inc_return_acquire(atomic_t *v)
+{
+	return arch_atomic_add_return_acquire(1, v);
+}
+#define arch_atomic_inc_return_acquire arch_atomic_inc_return_acquire
+#endif
+
+#ifndef arch_atomic_inc_return_release
+static __always_inline int
+arch_atomic_inc_return_release(atomic_t *v)
+{
+	return arch_atomic_add_return_release(1, v);
+}
+#define arch_atomic_inc_return_release arch_atomic_inc_return_release
+#endif
+
+#ifndef arch_atomic_inc_return_relaxed
+static __always_inline int
+arch_atomic_inc_return_relaxed(atomic_t *v)
+{
+	return arch_atomic_add_return_relaxed(1, v);
+}
+#define arch_atomic_inc_return_relaxed arch_atomic_inc_return_relaxed
+#endif
+
+#else /* arch_atomic_inc_return_relaxed */
+
+#ifndef arch_atomic_inc_return_acquire
+static __always_inline int
+arch_atomic_inc_return_acquire(atomic_t *v)
+{
+	int ret = arch_atomic_inc_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_inc_return_acquire arch_atomic_inc_return_acquire
+#endif
+
+#ifndef arch_atomic_inc_return_release
+static __always_inline int
+arch_atomic_inc_return_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_inc_return_relaxed(v);
+}
+#define arch_atomic_inc_return_release arch_atomic_inc_return_release
+#endif
+
+#ifndef arch_atomic_inc_return
+static __always_inline int
+arch_atomic_inc_return(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_inc_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_inc_return arch_atomic_inc_return
+#endif
+
+#endif /* arch_atomic_inc_return_relaxed */
+
+#ifndef arch_atomic_fetch_inc_relaxed
+#ifdef arch_atomic_fetch_inc
+#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc
+#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc
+#define arch_atomic_fetch_inc_relaxed arch_atomic_fetch_inc
+#endif /* arch_atomic_fetch_inc */
+
+#ifndef arch_atomic_fetch_inc
+static __always_inline int
+arch_atomic_fetch_inc(atomic_t *v)
+{
+	return arch_atomic_fetch_add(1, v);
+}
+#define arch_atomic_fetch_inc arch_atomic_fetch_inc
+#endif
+
+#ifndef arch_atomic_fetch_inc_acquire
+static __always_inline int
+arch_atomic_fetch_inc_acquire(atomic_t *v)
+{
+	return arch_atomic_fetch_add_acquire(1, v);
+}
+#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc_acquire
+#endif
+
+#ifndef arch_atomic_fetch_inc_release
+static __always_inline int
+arch_atomic_fetch_inc_release(atomic_t *v)
+{
+	return arch_atomic_fetch_add_release(1, v);
+}
+#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc_release
+#endif
+
+#ifndef arch_atomic_fetch_inc_relaxed
+static __always_inline int
+arch_atomic_fetch_inc_relaxed(atomic_t *v)
+{
+	return arch_atomic_fetch_add_relaxed(1, v);
+}
+#define arch_atomic_fetch_inc_relaxed arch_atomic_fetch_inc_relaxed
+#endif
+
+#else /* arch_atomic_fetch_inc_relaxed */
+
+#ifndef arch_atomic_fetch_inc_acquire
+static __always_inline int
+arch_atomic_fetch_inc_acquire(atomic_t *v)
+{
+	int ret = arch_atomic_fetch_inc_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_inc_acquire arch_atomic_fetch_inc_acquire
+#endif
+
+#ifndef arch_atomic_fetch_inc_release
+static __always_inline int
+arch_atomic_fetch_inc_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_inc_relaxed(v);
+}
+#define arch_atomic_fetch_inc_release arch_atomic_fetch_inc_release
+#endif
+
+#ifndef arch_atomic_fetch_inc
+static __always_inline int
+arch_atomic_fetch_inc(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_inc_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_inc arch_atomic_fetch_inc
+#endif
+
+#endif /* arch_atomic_fetch_inc_relaxed */
+
+#ifndef arch_atomic_dec
+static __always_inline void
+arch_atomic_dec(atomic_t *v)
+{
+	arch_atomic_sub(1, v);
+}
+#define arch_atomic_dec arch_atomic_dec
+#endif
+
+#ifndef arch_atomic_dec_return_relaxed
+#ifdef arch_atomic_dec_return
+#define arch_atomic_dec_return_acquire arch_atomic_dec_return
+#define arch_atomic_dec_return_release arch_atomic_dec_return
+#define arch_atomic_dec_return_relaxed arch_atomic_dec_return
+#endif /* arch_atomic_dec_return */
+
+#ifndef arch_atomic_dec_return
+static __always_inline int
+arch_atomic_dec_return(atomic_t *v)
+{
+	return arch_atomic_sub_return(1, v);
+}
+#define arch_atomic_dec_return arch_atomic_dec_return
+#endif
+
+#ifndef arch_atomic_dec_return_acquire
+static __always_inline int
+arch_atomic_dec_return_acquire(atomic_t *v)
+{
+	return arch_atomic_sub_return_acquire(1, v);
+}
+#define arch_atomic_dec_return_acquire arch_atomic_dec_return_acquire
+#endif
+
+#ifndef arch_atomic_dec_return_release
+static __always_inline int
+arch_atomic_dec_return_release(atomic_t *v)
+{
+	return arch_atomic_sub_return_release(1, v);
+}
+#define arch_atomic_dec_return_release arch_atomic_dec_return_release
+#endif
+
+#ifndef arch_atomic_dec_return_relaxed
+static __always_inline int
+arch_atomic_dec_return_relaxed(atomic_t *v)
+{
+	return arch_atomic_sub_return_relaxed(1, v);
+}
+#define arch_atomic_dec_return_relaxed arch_atomic_dec_return_relaxed
+#endif
+
+#else /* arch_atomic_dec_return_relaxed */
+
+#ifndef arch_atomic_dec_return_acquire
+static __always_inline int
+arch_atomic_dec_return_acquire(atomic_t *v)
+{
+	int ret = arch_atomic_dec_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_dec_return_acquire arch_atomic_dec_return_acquire
+#endif
+
+#ifndef arch_atomic_dec_return_release
+static __always_inline int
+arch_atomic_dec_return_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_dec_return_relaxed(v);
+}
+#define arch_atomic_dec_return_release arch_atomic_dec_return_release
+#endif
+
+#ifndef arch_atomic_dec_return
+static __always_inline int
+arch_atomic_dec_return(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_dec_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_dec_return arch_atomic_dec_return
+#endif
+
+#endif /* arch_atomic_dec_return_relaxed */
+
+#ifndef arch_atomic_fetch_dec_relaxed
+#ifdef arch_atomic_fetch_dec
+#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec
+#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec
+#define arch_atomic_fetch_dec_relaxed arch_atomic_fetch_dec
+#endif /* arch_atomic_fetch_dec */
+
+#ifndef arch_atomic_fetch_dec
+static __always_inline int
+arch_atomic_fetch_dec(atomic_t *v)
+{
+	return arch_atomic_fetch_sub(1, v);
+}
+#define arch_atomic_fetch_dec arch_atomic_fetch_dec
+#endif
+
+#ifndef arch_atomic_fetch_dec_acquire
+static __always_inline int
+arch_atomic_fetch_dec_acquire(atomic_t *v)
+{
+	return arch_atomic_fetch_sub_acquire(1, v);
+}
+#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec_acquire
+#endif
+
+#ifndef arch_atomic_fetch_dec_release
+static __always_inline int
+arch_atomic_fetch_dec_release(atomic_t *v)
+{
+	return arch_atomic_fetch_sub_release(1, v);
+}
+#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec_release
+#endif
+
+#ifndef arch_atomic_fetch_dec_relaxed
+static __always_inline int
+arch_atomic_fetch_dec_relaxed(atomic_t *v)
+{
+	return arch_atomic_fetch_sub_relaxed(1, v);
+}
+#define arch_atomic_fetch_dec_relaxed arch_atomic_fetch_dec_relaxed
+#endif
+
+#else /* arch_atomic_fetch_dec_relaxed */
+
+#ifndef arch_atomic_fetch_dec_acquire
+static __always_inline int
+arch_atomic_fetch_dec_acquire(atomic_t *v)
+{
+	int ret = arch_atomic_fetch_dec_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_dec_acquire arch_atomic_fetch_dec_acquire
+#endif
+
+#ifndef arch_atomic_fetch_dec_release
+static __always_inline int
+arch_atomic_fetch_dec_release(atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_dec_relaxed(v);
+}
+#define arch_atomic_fetch_dec_release arch_atomic_fetch_dec_release
+#endif
+
+#ifndef arch_atomic_fetch_dec
+static __always_inline int
+arch_atomic_fetch_dec(atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_dec_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_dec arch_atomic_fetch_dec
+#endif
+
+#endif /* arch_atomic_fetch_dec_relaxed */
+
+#ifndef arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_and_acquire arch_atomic_fetch_and
+#define arch_atomic_fetch_and_release arch_atomic_fetch_and
+#define arch_atomic_fetch_and_relaxed arch_atomic_fetch_and
+#else /* arch_atomic_fetch_and_relaxed */
+
+#ifndef arch_atomic_fetch_and_acquire
+static __always_inline int
+arch_atomic_fetch_and_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_and_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_and_acquire arch_atomic_fetch_and_acquire
+#endif
+
+#ifndef arch_atomic_fetch_and_release
+static __always_inline int
+arch_atomic_fetch_and_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_and_relaxed(i, v);
+}
+#define arch_atomic_fetch_and_release arch_atomic_fetch_and_release
+#endif
+
+#ifndef arch_atomic_fetch_and
+static __always_inline int
+arch_atomic_fetch_and(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_and_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_and arch_atomic_fetch_and
+#endif
+
+#endif /* arch_atomic_fetch_and_relaxed */
+
+#ifndef arch_atomic_andnot
+static __always_inline void
+arch_atomic_andnot(int i, atomic_t *v)
+{
+	arch_atomic_and(~i, v);
+}
+#define arch_atomic_andnot arch_atomic_andnot
+#endif
+
+#ifndef arch_atomic_fetch_andnot_relaxed
+#ifdef arch_atomic_fetch_andnot
+#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot
+#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot
+#define arch_atomic_fetch_andnot_relaxed arch_atomic_fetch_andnot
+#endif /* arch_atomic_fetch_andnot */
+
+#ifndef arch_atomic_fetch_andnot
+static __always_inline int
+arch_atomic_fetch_andnot(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and(~i, v);
+}
+#define arch_atomic_fetch_andnot arch_atomic_fetch_andnot
+#endif
+
+#ifndef arch_atomic_fetch_andnot_acquire
+static __always_inline int
+arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and_acquire(~i, v);
+}
+#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
+#endif
+
+#ifndef arch_atomic_fetch_andnot_release
+static __always_inline int
+arch_atomic_fetch_andnot_release(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and_release(~i, v);
+}
+#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
+#endif
+
+#ifndef arch_atomic_fetch_andnot_relaxed
+static __always_inline int
+arch_atomic_fetch_andnot_relaxed(int i, atomic_t *v)
+{
+	return arch_atomic_fetch_and_relaxed(~i, v);
+}
+#define arch_atomic_fetch_andnot_relaxed arch_atomic_fetch_andnot_relaxed
+#endif
+
+#else /* arch_atomic_fetch_andnot_relaxed */
+
+#ifndef arch_atomic_fetch_andnot_acquire
+static __always_inline int
+arch_atomic_fetch_andnot_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_andnot_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_andnot_acquire arch_atomic_fetch_andnot_acquire
+#endif
+
+#ifndef arch_atomic_fetch_andnot_release
+static __always_inline int
+arch_atomic_fetch_andnot_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_andnot_relaxed(i, v);
+}
+#define arch_atomic_fetch_andnot_release arch_atomic_fetch_andnot_release
+#endif
+
+#ifndef arch_atomic_fetch_andnot
+static __always_inline int
+arch_atomic_fetch_andnot(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_andnot_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_andnot arch_atomic_fetch_andnot
+#endif
+
+#endif /* arch_atomic_fetch_andnot_relaxed */
+
+#ifndef arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_or_acquire arch_atomic_fetch_or
+#define arch_atomic_fetch_or_release arch_atomic_fetch_or
+#define arch_atomic_fetch_or_relaxed arch_atomic_fetch_or
+#else /* arch_atomic_fetch_or_relaxed */
+
+#ifndef arch_atomic_fetch_or_acquire
+static __always_inline int
+arch_atomic_fetch_or_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_or_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_or_acquire arch_atomic_fetch_or_acquire
+#endif
+
+#ifndef arch_atomic_fetch_or_release
+static __always_inline int
+arch_atomic_fetch_or_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_or_relaxed(i, v);
+}
+#define arch_atomic_fetch_or_release arch_atomic_fetch_or_release
+#endif
+
+#ifndef arch_atomic_fetch_or
+static __always_inline int
+arch_atomic_fetch_or(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_or_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_or arch_atomic_fetch_or
+#endif
+
+#endif /* arch_atomic_fetch_or_relaxed */
+
+#ifndef arch_atomic_fetch_xor_relaxed
+#define arch_atomic_fetch_xor_acquire arch_atomic_fetch_xor
+#define arch_atomic_fetch_xor_release arch_atomic_fetch_xor
+#define arch_atomic_fetch_xor_relaxed arch_atomic_fetch_xor
+#else /* arch_atomic_fetch_xor_relaxed */
+
+#ifndef arch_atomic_fetch_xor_acquire
+static __always_inline int
+arch_atomic_fetch_xor_acquire(int i, atomic_t *v)
+{
+	int ret = arch_atomic_fetch_xor_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_fetch_xor_acquire arch_atomic_fetch_xor_acquire
+#endif
+
+#ifndef arch_atomic_fetch_xor_release
+static __always_inline int
+arch_atomic_fetch_xor_release(int i, atomic_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic_fetch_xor_relaxed(i, v);
+}
+#define arch_atomic_fetch_xor_release arch_atomic_fetch_xor_release
+#endif
+
+#ifndef arch_atomic_fetch_xor
+static __always_inline int
+arch_atomic_fetch_xor(int i, atomic_t *v)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_fetch_xor_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_fetch_xor arch_atomic_fetch_xor
+#endif
+
+#endif /* arch_atomic_fetch_xor_relaxed */
+
+#ifndef arch_atomic_xchg_relaxed
+#define arch_atomic_xchg_acquire arch_atomic_xchg
+#define arch_atomic_xchg_release arch_atomic_xchg
+#define arch_atomic_xchg_relaxed arch_atomic_xchg
+#else /* arch_atomic_xchg_relaxed */
+
+#ifndef arch_atomic_xchg_acquire
+static __always_inline int
+arch_atomic_xchg_acquire(atomic_t *v, int i)
+{
+	int ret = arch_atomic_xchg_relaxed(v, i);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_xchg_acquire arch_atomic_xchg_acquire
+#endif
+
+#ifndef arch_atomic_xchg_release
+static __always_inline int
+arch_atomic_xchg_release(atomic_t *v, int i)
+{
+	__atomic_release_fence();
+	return arch_atomic_xchg_relaxed(v, i);
+}
+#define arch_atomic_xchg_release arch_atomic_xchg_release
+#endif
+
+#ifndef arch_atomic_xchg
+static __always_inline int
+arch_atomic_xchg(atomic_t *v, int i)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_xchg_relaxed(v, i);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_xchg arch_atomic_xchg
+#endif
+
+#endif /* arch_atomic_xchg_relaxed */
+
+#ifndef arch_atomic_cmpxchg_relaxed
+#define arch_atomic_cmpxchg_acquire arch_atomic_cmpxchg
+#define arch_atomic_cmpxchg_release arch_atomic_cmpxchg
+#define arch_atomic_cmpxchg_relaxed arch_atomic_cmpxchg
+#else /* arch_atomic_cmpxchg_relaxed */
+
+#ifndef arch_atomic_cmpxchg_acquire
+static __always_inline int
+arch_atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
+{
+	int ret = arch_atomic_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_cmpxchg_acquire arch_atomic_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic_cmpxchg_release
+static __always_inline int
+arch_atomic_cmpxchg_release(atomic_t *v, int old, int new)
+{
+	__atomic_release_fence();
+	return arch_atomic_cmpxchg_relaxed(v, old, new);
+}
+#define arch_atomic_cmpxchg_release arch_atomic_cmpxchg_release
+#endif
+
+#ifndef arch_atomic_cmpxchg
+static __always_inline int
+arch_atomic_cmpxchg(atomic_t *v, int old, int new)
+{
+	int ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_cmpxchg_relaxed(v, old, new);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_cmpxchg arch_atomic_cmpxchg
+#endif
+
+#endif /* arch_atomic_cmpxchg_relaxed */
+
+#ifndef arch_atomic_try_cmpxchg_relaxed
+#ifdef arch_atomic_try_cmpxchg
+#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg
+#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg
+#define arch_atomic_try_cmpxchg_relaxed arch_atomic_try_cmpxchg
+#endif /* arch_atomic_try_cmpxchg */
+
+#ifndef arch_atomic_try_cmpxchg
+static __always_inline bool
+arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = arch_atomic_cmpxchg(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
+#endif
+
+#ifndef arch_atomic_try_cmpxchg_acquire
+static __always_inline bool
+arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = arch_atomic_cmpxchg_acquire(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic_try_cmpxchg_release
+static __always_inline bool
+arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = arch_atomic_cmpxchg_release(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg_release
+#endif
+
+#ifndef arch_atomic_try_cmpxchg_relaxed
+static __always_inline bool
+arch_atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = arch_atomic_cmpxchg_relaxed(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic_try_cmpxchg_relaxed arch_atomic_try_cmpxchg_relaxed
+#endif
+
+#else /* arch_atomic_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic_try_cmpxchg_acquire
+static __always_inline bool
+arch_atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
+{
+	bool ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic_try_cmpxchg_acquire arch_atomic_try_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic_try_cmpxchg_release
+static __always_inline bool
+arch_atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
+{
+	__atomic_release_fence();
+	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
+}
+#define arch_atomic_try_cmpxchg_release arch_atomic_try_cmpxchg_release
+#endif
+
+#ifndef arch_atomic_try_cmpxchg
+static __always_inline bool
+arch_atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+{
+	bool ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic_try_cmpxchg_relaxed(v, old, new);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic_try_cmpxchg arch_atomic_try_cmpxchg
+#endif
+
+#endif /* arch_atomic_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic_sub_and_test
+/**
+ * arch_atomic_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer of type atomic_t
+ *
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static __always_inline bool
+arch_atomic_sub_and_test(int i, atomic_t *v)
+{
+	return arch_atomic_sub_return(i, v) == 0;
+}
+#define arch_atomic_sub_and_test arch_atomic_sub_and_test
+#endif
+
+#ifndef arch_atomic_dec_and_test
+/**
+ * arch_atomic_dec_and_test - decrement and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+static __always_inline bool
+arch_atomic_dec_and_test(atomic_t *v)
+{
+	return arch_atomic_dec_return(v) == 0;
+}
+#define arch_atomic_dec_and_test arch_atomic_dec_and_test
+#endif
+
+#ifndef arch_atomic_inc_and_test
+/**
+ * arch_atomic_inc_and_test - increment and test
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+static __always_inline bool
+arch_atomic_inc_and_test(atomic_t *v)
+{
+	return arch_atomic_inc_return(v) == 0;
+}
+#define arch_atomic_inc_and_test arch_atomic_inc_and_test
+#endif
+
+#ifndef arch_atomic_add_negative
+/**
+ * arch_atomic_add_negative - add and test if negative
+ * @i: integer value to add
+ * @v: pointer of type atomic_t
+ *
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+static __always_inline bool
+arch_atomic_add_negative(int i, atomic_t *v)
+{
+	return arch_atomic_add_return(i, v) < 0;
+}
+#define arch_atomic_add_negative arch_atomic_add_negative
+#endif
+
+#ifndef arch_atomic_fetch_add_unless
+/**
+ * arch_atomic_fetch_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns original value of @v
+ */
+static __always_inline int
+arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
+{
+	int c = arch_atomic_read(v);
+
+	do {
+		if (unlikely(c == u))
+			break;
+	} while (!arch_atomic_try_cmpxchg(v, &c, c + a));
+
+	return c;
+}
+#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
+#endif
+
+#ifndef arch_atomic_add_unless
+/**
+ * arch_atomic_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, if @v was not already @u.
+ * Returns true if the addition was done.
+ */
+static __always_inline bool
+arch_atomic_add_unless(atomic_t *v, int a, int u)
+{
+	return arch_atomic_fetch_add_unless(v, a, u) != u;
+}
+#define arch_atomic_add_unless arch_atomic_add_unless
+#endif
+
+#ifndef arch_atomic_inc_not_zero
+/**
+ * arch_atomic_inc_not_zero - increment unless the number is zero
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1, if @v is non-zero.
+ * Returns true if the increment was done.
+ */
+static __always_inline bool
+arch_atomic_inc_not_zero(atomic_t *v)
+{
+	return arch_atomic_add_unless(v, 1, 0);
+}
+#define arch_atomic_inc_not_zero arch_atomic_inc_not_zero
+#endif
+
+#ifndef arch_atomic_inc_unless_negative
+static __always_inline bool
+arch_atomic_inc_unless_negative(atomic_t *v)
+{
+	int c = arch_atomic_read(v);
+
+	do {
+		if (unlikely(c < 0))
+			return false;
+	} while (!arch_atomic_try_cmpxchg(v, &c, c + 1));
+
+	return true;
+}
+#define arch_atomic_inc_unless_negative arch_atomic_inc_unless_negative
+#endif
+
+#ifndef arch_atomic_dec_unless_positive
+static __always_inline bool
+arch_atomic_dec_unless_positive(atomic_t *v)
+{
+	int c = arch_atomic_read(v);
+
+	do {
+		if (unlikely(c > 0))
+			return false;
+	} while (!arch_atomic_try_cmpxchg(v, &c, c - 1));
+
+	return true;
+}
+#define arch_atomic_dec_unless_positive arch_atomic_dec_unless_positive
+#endif
+
+#ifndef arch_atomic_dec_if_positive
+static __always_inline int
+arch_atomic_dec_if_positive(atomic_t *v)
+{
+	int dec, c = arch_atomic_read(v);
+
+	do {
+		dec = c - 1;
+		if (unlikely(dec < 0))
+			break;
+	} while (!arch_atomic_try_cmpxchg(v, &c, dec));
+
+	return dec;
+}
+#define arch_atomic_dec_if_positive arch_atomic_dec_if_positive
+#endif
+
+#ifdef CONFIG_GENERIC_ATOMIC64
+#include <asm-generic/atomic64.h>
+#endif
+
+#ifndef arch_atomic64_read_acquire
+static __always_inline s64
+arch_atomic64_read_acquire(const atomic64_t *v)
+{
+	return smp_load_acquire(&(v)->counter);
+}
+#define arch_atomic64_read_acquire arch_atomic64_read_acquire
+#endif
+
+#ifndef arch_atomic64_set_release
+static __always_inline void
+arch_atomic64_set_release(atomic64_t *v, s64 i)
+{
+	smp_store_release(&(v)->counter, i);
+}
+#define arch_atomic64_set_release arch_atomic64_set_release
+#endif
+
+#ifndef arch_atomic64_add_return_relaxed
+#define arch_atomic64_add_return_acquire arch_atomic64_add_return
+#define arch_atomic64_add_return_release arch_atomic64_add_return
+#define arch_atomic64_add_return_relaxed arch_atomic64_add_return
+#else /* arch_atomic64_add_return_relaxed */
+
+#ifndef arch_atomic64_add_return_acquire
+static __always_inline s64
+arch_atomic64_add_return_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_add_return_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_add_return_acquire arch_atomic64_add_return_acquire
+#endif
+
+#ifndef arch_atomic64_add_return_release
+static __always_inline s64
+arch_atomic64_add_return_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_add_return_relaxed(i, v);
+}
+#define arch_atomic64_add_return_release arch_atomic64_add_return_release
+#endif
+
+#ifndef arch_atomic64_add_return
+static __always_inline s64
+arch_atomic64_add_return(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_add_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_add_return arch_atomic64_add_return
+#endif
+
+#endif /* arch_atomic64_add_return_relaxed */
+
+#ifndef arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_add_acquire arch_atomic64_fetch_add
+#define arch_atomic64_fetch_add_release arch_atomic64_fetch_add
+#define arch_atomic64_fetch_add_relaxed arch_atomic64_fetch_add
+#else /* arch_atomic64_fetch_add_relaxed */
+
+#ifndef arch_atomic64_fetch_add_acquire
+static __always_inline s64
+arch_atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_add_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_add_acquire arch_atomic64_fetch_add_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_add_release
+static __always_inline s64
+arch_atomic64_fetch_add_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_add_relaxed(i, v);
+}
+#define arch_atomic64_fetch_add_release arch_atomic64_fetch_add_release
+#endif
+
+#ifndef arch_atomic64_fetch_add
+static __always_inline s64
+arch_atomic64_fetch_add(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_add_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_add arch_atomic64_fetch_add
+#endif
+
+#endif /* arch_atomic64_fetch_add_relaxed */
+
+#ifndef arch_atomic64_sub_return_relaxed
+#define arch_atomic64_sub_return_acquire arch_atomic64_sub_return
+#define arch_atomic64_sub_return_release arch_atomic64_sub_return
+#define arch_atomic64_sub_return_relaxed arch_atomic64_sub_return
+#else /* arch_atomic64_sub_return_relaxed */
+
+#ifndef arch_atomic64_sub_return_acquire
+static __always_inline s64
+arch_atomic64_sub_return_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_sub_return_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_sub_return_acquire arch_atomic64_sub_return_acquire
+#endif
+
+#ifndef arch_atomic64_sub_return_release
+static __always_inline s64
+arch_atomic64_sub_return_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_sub_return_relaxed(i, v);
+}
+#define arch_atomic64_sub_return_release arch_atomic64_sub_return_release
+#endif
+
+#ifndef arch_atomic64_sub_return
+static __always_inline s64
+arch_atomic64_sub_return(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_sub_return_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_sub_return arch_atomic64_sub_return
+#endif
+
+#endif /* arch_atomic64_sub_return_relaxed */
+
+#ifndef arch_atomic64_fetch_sub_relaxed
+#define arch_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub_release arch_atomic64_fetch_sub
+#define arch_atomic64_fetch_sub_relaxed arch_atomic64_fetch_sub
+#else /* arch_atomic64_fetch_sub_relaxed */
+
+#ifndef arch_atomic64_fetch_sub_acquire
+static __always_inline s64
+arch_atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_sub_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_sub_acquire arch_atomic64_fetch_sub_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_sub_release
+static __always_inline s64
+arch_atomic64_fetch_sub_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_sub_relaxed(i, v);
+}
+#define arch_atomic64_fetch_sub_release arch_atomic64_fetch_sub_release
+#endif
+
+#ifndef arch_atomic64_fetch_sub
+static __always_inline s64
+arch_atomic64_fetch_sub(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_sub_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_sub arch_atomic64_fetch_sub
+#endif
+
+#endif /* arch_atomic64_fetch_sub_relaxed */
+
+#ifndef arch_atomic64_inc
+static __always_inline void
+arch_atomic64_inc(atomic64_t *v)
+{
+	arch_atomic64_add(1, v);
+}
+#define arch_atomic64_inc arch_atomic64_inc
+#endif
+
+#ifndef arch_atomic64_inc_return_relaxed
+#ifdef arch_atomic64_inc_return
+#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return
+#define arch_atomic64_inc_return_release arch_atomic64_inc_return
+#define arch_atomic64_inc_return_relaxed arch_atomic64_inc_return
+#endif /* arch_atomic64_inc_return */
+
+#ifndef arch_atomic64_inc_return
+static __always_inline s64
+arch_atomic64_inc_return(atomic64_t *v)
+{
+	return arch_atomic64_add_return(1, v);
+}
+#define arch_atomic64_inc_return arch_atomic64_inc_return
+#endif
+
+#ifndef arch_atomic64_inc_return_acquire
+static __always_inline s64
+arch_atomic64_inc_return_acquire(atomic64_t *v)
+{
+	return arch_atomic64_add_return_acquire(1, v);
+}
+#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return_acquire
+#endif
+
+#ifndef arch_atomic64_inc_return_release
+static __always_inline s64
+arch_atomic64_inc_return_release(atomic64_t *v)
+{
+	return arch_atomic64_add_return_release(1, v);
+}
+#define arch_atomic64_inc_return_release arch_atomic64_inc_return_release
+#endif
+
+#ifndef arch_atomic64_inc_return_relaxed
+static __always_inline s64
+arch_atomic64_inc_return_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_add_return_relaxed(1, v);
+}
+#define arch_atomic64_inc_return_relaxed arch_atomic64_inc_return_relaxed
+#endif
+
+#else /* arch_atomic64_inc_return_relaxed */
+
+#ifndef arch_atomic64_inc_return_acquire
+static __always_inline s64
+arch_atomic64_inc_return_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_inc_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_inc_return_acquire arch_atomic64_inc_return_acquire
+#endif
+
+#ifndef arch_atomic64_inc_return_release
+static __always_inline s64
+arch_atomic64_inc_return_release(atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_inc_return_relaxed(v);
+}
+#define arch_atomic64_inc_return_release arch_atomic64_inc_return_release
+#endif
+
+#ifndef arch_atomic64_inc_return
+static __always_inline s64
+arch_atomic64_inc_return(atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_inc_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_inc_return arch_atomic64_inc_return
+#endif
+
+#endif /* arch_atomic64_inc_return_relaxed */
+
+#ifndef arch_atomic64_fetch_inc_relaxed
+#ifdef arch_atomic64_fetch_inc
+#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc
+#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc
+#define arch_atomic64_fetch_inc_relaxed arch_atomic64_fetch_inc
+#endif /* arch_atomic64_fetch_inc */
+
+#ifndef arch_atomic64_fetch_inc
+static __always_inline s64
+arch_atomic64_fetch_inc(atomic64_t *v)
+{
+	return arch_atomic64_fetch_add(1, v);
+}
+#define arch_atomic64_fetch_inc arch_atomic64_fetch_inc
+#endif
+
+#ifndef arch_atomic64_fetch_inc_acquire
+static __always_inline s64
+arch_atomic64_fetch_inc_acquire(atomic64_t *v)
+{
+	return arch_atomic64_fetch_add_acquire(1, v);
+}
+#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_inc_release
+static __always_inline s64
+arch_atomic64_fetch_inc_release(atomic64_t *v)
+{
+	return arch_atomic64_fetch_add_release(1, v);
+}
+#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc_release
+#endif
+
+#ifndef arch_atomic64_fetch_inc_relaxed
+static __always_inline s64
+arch_atomic64_fetch_inc_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_fetch_add_relaxed(1, v);
+}
+#define arch_atomic64_fetch_inc_relaxed arch_atomic64_fetch_inc_relaxed
+#endif
+
+#else /* arch_atomic64_fetch_inc_relaxed */
+
+#ifndef arch_atomic64_fetch_inc_acquire
+static __always_inline s64
+arch_atomic64_fetch_inc_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_inc_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_inc_acquire arch_atomic64_fetch_inc_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_inc_release
+static __always_inline s64
+arch_atomic64_fetch_inc_release(atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_inc_relaxed(v);
+}
+#define arch_atomic64_fetch_inc_release arch_atomic64_fetch_inc_release
+#endif
+
+#ifndef arch_atomic64_fetch_inc
+static __always_inline s64
+arch_atomic64_fetch_inc(atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_inc_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_inc arch_atomic64_fetch_inc
+#endif
+
+#endif /* arch_atomic64_fetch_inc_relaxed */
+
+#ifndef arch_atomic64_dec
+static __always_inline void
+arch_atomic64_dec(atomic64_t *v)
+{
+	arch_atomic64_sub(1, v);
+}
+#define arch_atomic64_dec arch_atomic64_dec
+#endif
+
+#ifndef arch_atomic64_dec_return_relaxed
+#ifdef arch_atomic64_dec_return
+#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return
+#define arch_atomic64_dec_return_release arch_atomic64_dec_return
+#define arch_atomic64_dec_return_relaxed arch_atomic64_dec_return
+#endif /* arch_atomic64_dec_return */
+
+#ifndef arch_atomic64_dec_return
+static __always_inline s64
+arch_atomic64_dec_return(atomic64_t *v)
+{
+	return arch_atomic64_sub_return(1, v);
+}
+#define arch_atomic64_dec_return arch_atomic64_dec_return
+#endif
+
+#ifndef arch_atomic64_dec_return_acquire
+static __always_inline s64
+arch_atomic64_dec_return_acquire(atomic64_t *v)
+{
+	return arch_atomic64_sub_return_acquire(1, v);
+}
+#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return_acquire
+#endif
+
+#ifndef arch_atomic64_dec_return_release
+static __always_inline s64
+arch_atomic64_dec_return_release(atomic64_t *v)
+{
+	return arch_atomic64_sub_return_release(1, v);
+}
+#define arch_atomic64_dec_return_release arch_atomic64_dec_return_release
+#endif
+
+#ifndef arch_atomic64_dec_return_relaxed
+static __always_inline s64
+arch_atomic64_dec_return_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_sub_return_relaxed(1, v);
+}
+#define arch_atomic64_dec_return_relaxed arch_atomic64_dec_return_relaxed
+#endif
+
+#else /* arch_atomic64_dec_return_relaxed */
+
+#ifndef arch_atomic64_dec_return_acquire
+static __always_inline s64
+arch_atomic64_dec_return_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_dec_return_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_dec_return_acquire arch_atomic64_dec_return_acquire
+#endif
+
+#ifndef arch_atomic64_dec_return_release
+static __always_inline s64
+arch_atomic64_dec_return_release(atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_dec_return_relaxed(v);
+}
+#define arch_atomic64_dec_return_release arch_atomic64_dec_return_release
+#endif
+
+#ifndef arch_atomic64_dec_return
+static __always_inline s64
+arch_atomic64_dec_return(atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_dec_return_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_dec_return arch_atomic64_dec_return
+#endif
+
+#endif /* arch_atomic64_dec_return_relaxed */
+
+#ifndef arch_atomic64_fetch_dec_relaxed
+#ifdef arch_atomic64_fetch_dec
+#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec
+#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec
+#define arch_atomic64_fetch_dec_relaxed arch_atomic64_fetch_dec
+#endif /* arch_atomic64_fetch_dec */
+
+#ifndef arch_atomic64_fetch_dec
+static __always_inline s64
+arch_atomic64_fetch_dec(atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub(1, v);
+}
+#define arch_atomic64_fetch_dec arch_atomic64_fetch_dec
+#endif
+
+#ifndef arch_atomic64_fetch_dec_acquire
+static __always_inline s64
+arch_atomic64_fetch_dec_acquire(atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub_acquire(1, v);
+}
+#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_dec_release
+static __always_inline s64
+arch_atomic64_fetch_dec_release(atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub_release(1, v);
+}
+#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec_release
+#endif
+
+#ifndef arch_atomic64_fetch_dec_relaxed
+static __always_inline s64
+arch_atomic64_fetch_dec_relaxed(atomic64_t *v)
+{
+	return arch_atomic64_fetch_sub_relaxed(1, v);
+}
+#define arch_atomic64_fetch_dec_relaxed arch_atomic64_fetch_dec_relaxed
+#endif
+
+#else /* arch_atomic64_fetch_dec_relaxed */
+
+#ifndef arch_atomic64_fetch_dec_acquire
+static __always_inline s64
+arch_atomic64_fetch_dec_acquire(atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_dec_relaxed(v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_dec_acquire arch_atomic64_fetch_dec_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_dec_release
+static __always_inline s64
+arch_atomic64_fetch_dec_release(atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_dec_relaxed(v);
+}
+#define arch_atomic64_fetch_dec_release arch_atomic64_fetch_dec_release
+#endif
+
+#ifndef arch_atomic64_fetch_dec
+static __always_inline s64
+arch_atomic64_fetch_dec(atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_dec_relaxed(v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_dec arch_atomic64_fetch_dec
+#endif
+
+#endif /* arch_atomic64_fetch_dec_relaxed */
+
+#ifndef arch_atomic64_fetch_and_relaxed
+#define arch_atomic64_fetch_and_acquire arch_atomic64_fetch_and
+#define arch_atomic64_fetch_and_release arch_atomic64_fetch_and
+#define arch_atomic64_fetch_and_relaxed arch_atomic64_fetch_and
+#else /* arch_atomic64_fetch_and_relaxed */
+
+#ifndef arch_atomic64_fetch_and_acquire
+static __always_inline s64
+arch_atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_and_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_and_acquire arch_atomic64_fetch_and_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_and_release
+static __always_inline s64
+arch_atomic64_fetch_and_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_and_relaxed(i, v);
+}
+#define arch_atomic64_fetch_and_release arch_atomic64_fetch_and_release
+#endif
+
+#ifndef arch_atomic64_fetch_and
+static __always_inline s64
+arch_atomic64_fetch_and(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_and_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_and arch_atomic64_fetch_and
+#endif
+
+#endif /* arch_atomic64_fetch_and_relaxed */
+
+#ifndef arch_atomic64_andnot
+static __always_inline void
+arch_atomic64_andnot(s64 i, atomic64_t *v)
+{
+	arch_atomic64_and(~i, v);
+}
+#define arch_atomic64_andnot arch_atomic64_andnot
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_relaxed
+#ifdef arch_atomic64_fetch_andnot
+#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot
+#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot
+#define arch_atomic64_fetch_andnot_relaxed arch_atomic64_fetch_andnot
+#endif /* arch_atomic64_fetch_andnot */
+
+#ifndef arch_atomic64_fetch_andnot
+static __always_inline s64
+arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and(~i, v);
+}
+#define arch_atomic64_fetch_andnot arch_atomic64_fetch_andnot
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_acquire
+static __always_inline s64
+arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and_acquire(~i, v);
+}
+#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_release
+static __always_inline s64
+arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and_release(~i, v);
+}
+#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_relaxed
+static __always_inline s64
+arch_atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_fetch_and_relaxed(~i, v);
+}
+#define arch_atomic64_fetch_andnot_relaxed arch_atomic64_fetch_andnot_relaxed
+#endif
+
+#else /* arch_atomic64_fetch_andnot_relaxed */
+
+#ifndef arch_atomic64_fetch_andnot_acquire
+static __always_inline s64
+arch_atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_andnot_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_andnot_acquire arch_atomic64_fetch_andnot_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_andnot_release
+static __always_inline s64
+arch_atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_andnot_relaxed(i, v);
+}
+#define arch_atomic64_fetch_andnot_release arch_atomic64_fetch_andnot_release
+#endif
+
+#ifndef arch_atomic64_fetch_andnot
+static __always_inline s64
+arch_atomic64_fetch_andnot(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_andnot_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_andnot arch_atomic64_fetch_andnot
+#endif
+
+#endif /* arch_atomic64_fetch_andnot_relaxed */
+
+#ifndef arch_atomic64_fetch_or_relaxed
+#define arch_atomic64_fetch_or_acquire arch_atomic64_fetch_or
+#define arch_atomic64_fetch_or_release arch_atomic64_fetch_or
+#define arch_atomic64_fetch_or_relaxed arch_atomic64_fetch_or
+#else /* arch_atomic64_fetch_or_relaxed */
+
+#ifndef arch_atomic64_fetch_or_acquire
+static __always_inline s64
+arch_atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_or_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_or_acquire arch_atomic64_fetch_or_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_or_release
+static __always_inline s64
+arch_atomic64_fetch_or_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_or_relaxed(i, v);
+}
+#define arch_atomic64_fetch_or_release arch_atomic64_fetch_or_release
+#endif
+
+#ifndef arch_atomic64_fetch_or
+static __always_inline s64
+arch_atomic64_fetch_or(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_or_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_or arch_atomic64_fetch_or
+#endif
+
+#endif /* arch_atomic64_fetch_or_relaxed */
+
+#ifndef arch_atomic64_fetch_xor_relaxed
+#define arch_atomic64_fetch_xor_acquire arch_atomic64_fetch_xor
+#define arch_atomic64_fetch_xor_release arch_atomic64_fetch_xor
+#define arch_atomic64_fetch_xor_relaxed arch_atomic64_fetch_xor
+#else /* arch_atomic64_fetch_xor_relaxed */
+
+#ifndef arch_atomic64_fetch_xor_acquire
+static __always_inline s64
+arch_atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
+{
+	s64 ret = arch_atomic64_fetch_xor_relaxed(i, v);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_xor_acquire arch_atomic64_fetch_xor_acquire
+#endif
+
+#ifndef arch_atomic64_fetch_xor_release
+static __always_inline s64
+arch_atomic64_fetch_xor_release(s64 i, atomic64_t *v)
+{
+	__atomic_release_fence();
+	return arch_atomic64_fetch_xor_relaxed(i, v);
+}
+#define arch_atomic64_fetch_xor_release arch_atomic64_fetch_xor_release
+#endif
+
+#ifndef arch_atomic64_fetch_xor
+static __always_inline s64
+arch_atomic64_fetch_xor(s64 i, atomic64_t *v)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_fetch_xor_relaxed(i, v);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_fetch_xor arch_atomic64_fetch_xor
+#endif
+
+#endif /* arch_atomic64_fetch_xor_relaxed */
+
+#ifndef arch_atomic64_xchg_relaxed
+#define arch_atomic64_xchg_acquire arch_atomic64_xchg
+#define arch_atomic64_xchg_release arch_atomic64_xchg
+#define arch_atomic64_xchg_relaxed arch_atomic64_xchg
+#else /* arch_atomic64_xchg_relaxed */
+
+#ifndef arch_atomic64_xchg_acquire
+static __always_inline s64
+arch_atomic64_xchg_acquire(atomic64_t *v, s64 i)
+{
+	s64 ret = arch_atomic64_xchg_relaxed(v, i);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_xchg_acquire arch_atomic64_xchg_acquire
+#endif
+
+#ifndef arch_atomic64_xchg_release
+static __always_inline s64
+arch_atomic64_xchg_release(atomic64_t *v, s64 i)
+{
+	__atomic_release_fence();
+	return arch_atomic64_xchg_relaxed(v, i);
+}
+#define arch_atomic64_xchg_release arch_atomic64_xchg_release
+#endif
+
+#ifndef arch_atomic64_xchg
+static __always_inline s64
+arch_atomic64_xchg(atomic64_t *v, s64 i)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_xchg_relaxed(v, i);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_xchg arch_atomic64_xchg
+#endif
+
+#endif /* arch_atomic64_xchg_relaxed */
+
+#ifndef arch_atomic64_cmpxchg_relaxed
+#define arch_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg
+#define arch_atomic64_cmpxchg_release arch_atomic64_cmpxchg
+#define arch_atomic64_cmpxchg_relaxed arch_atomic64_cmpxchg
+#else /* arch_atomic64_cmpxchg_relaxed */
+
+#ifndef arch_atomic64_cmpxchg_acquire
+static __always_inline s64
+arch_atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
+{
+	s64 ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_cmpxchg_acquire arch_atomic64_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic64_cmpxchg_release
+static __always_inline s64
+arch_atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
+{
+	__atomic_release_fence();
+	return arch_atomic64_cmpxchg_relaxed(v, old, new);
+}
+#define arch_atomic64_cmpxchg_release arch_atomic64_cmpxchg_release
+#endif
+
+#ifndef arch_atomic64_cmpxchg
+static __always_inline s64
+arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
+{
+	s64 ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_cmpxchg_relaxed(v, old, new);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
+#endif
+
+#endif /* arch_atomic64_cmpxchg_relaxed */
+
+#ifndef arch_atomic64_try_cmpxchg_relaxed
+#ifdef arch_atomic64_try_cmpxchg
+#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg
+#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg
+#define arch_atomic64_try_cmpxchg_relaxed arch_atomic64_try_cmpxchg
+#endif /* arch_atomic64_try_cmpxchg */
+
+#ifndef arch_atomic64_try_cmpxchg
+static __always_inline bool
+arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	s64 r, o = *old;
+	r = arch_atomic64_cmpxchg(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg_acquire
+static __always_inline bool
+arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
+{
+	s64 r, o = *old;
+	r = arch_atomic64_cmpxchg_acquire(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg_release
+static __always_inline bool
+arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
+{
+	s64 r, o = *old;
+	r = arch_atomic64_cmpxchg_release(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg_release
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg_relaxed
+static __always_inline bool
+arch_atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
+{
+	s64 r, o = *old;
+	r = arch_atomic64_cmpxchg_relaxed(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+#define arch_atomic64_try_cmpxchg_relaxed arch_atomic64_try_cmpxchg_relaxed
+#endif
+
+#else /* arch_atomic64_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic64_try_cmpxchg_acquire
+static __always_inline bool
+arch_atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
+{
+	bool ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+	__atomic_acquire_fence();
+	return ret;
+}
+#define arch_atomic64_try_cmpxchg_acquire arch_atomic64_try_cmpxchg_acquire
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg_release
+static __always_inline bool
+arch_atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
+{
+	__atomic_release_fence();
+	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+}
+#define arch_atomic64_try_cmpxchg_release arch_atomic64_try_cmpxchg_release
+#endif
+
+#ifndef arch_atomic64_try_cmpxchg
+static __always_inline bool
+arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	bool ret;
+	__atomic_pre_full_fence();
+	ret = arch_atomic64_try_cmpxchg_relaxed(v, old, new);
+	__atomic_post_full_fence();
+	return ret;
+}
+#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
+#endif
+
+#endif /* arch_atomic64_try_cmpxchg_relaxed */
+
+#ifndef arch_atomic64_sub_and_test
+/**
+ * arch_atomic64_sub_and_test - subtract value from variable and test result
+ * @i: integer value to subtract
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically subtracts @i from @v and returns
+ * true if the result is zero, or false for all
+ * other cases.
+ */
+static __always_inline bool
+arch_atomic64_sub_and_test(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_sub_return(i, v) == 0;
+}
+#define arch_atomic64_sub_and_test arch_atomic64_sub_and_test
+#endif
+
+#ifndef arch_atomic64_dec_and_test
+/**
+ * arch_atomic64_dec_and_test - decrement and test
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically decrements @v by 1 and
+ * returns true if the result is 0, or false for all other
+ * cases.
+ */
+static __always_inline bool
+arch_atomic64_dec_and_test(atomic64_t *v)
+{
+	return arch_atomic64_dec_return(v) == 0;
+}
+#define arch_atomic64_dec_and_test arch_atomic64_dec_and_test
+#endif
+
+#ifndef arch_atomic64_inc_and_test
+/**
+ * arch_atomic64_inc_and_test - increment and test
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increments @v by 1
+ * and returns true if the result is zero, or false for all
+ * other cases.
+ */
+static __always_inline bool
+arch_atomic64_inc_and_test(atomic64_t *v)
+{
+	return arch_atomic64_inc_return(v) == 0;
+}
+#define arch_atomic64_inc_and_test arch_atomic64_inc_and_test
+#endif
+
+#ifndef arch_atomic64_add_negative
+/**
+ * arch_atomic64_add_negative - add and test if negative
+ * @i: integer value to add
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically adds @i to @v and returns true
+ * if the result is negative, or false when
+ * result is greater than or equal to zero.
+ */
+static __always_inline bool
+arch_atomic64_add_negative(s64 i, atomic64_t *v)
+{
+	return arch_atomic64_add_return(i, v) < 0;
+}
+#define arch_atomic64_add_negative arch_atomic64_add_negative
+#endif
+
+#ifndef arch_atomic64_fetch_add_unless
+/**
+ * arch_atomic64_fetch_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic64_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, so long as @v was not already @u.
+ * Returns original value of @v
+ */
+static __always_inline s64
+arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	s64 c = arch_atomic64_read(v);
+
+	do {
+		if (unlikely(c == u))
+			break;
+	} while (!arch_atomic64_try_cmpxchg(v, &c, c + a));
+
+	return c;
+}
+#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
+#endif
+
+#ifndef arch_atomic64_add_unless
+/**
+ * arch_atomic64_add_unless - add unless the number is already a given value
+ * @v: pointer of type atomic64_t
+ * @a: the amount to add to v...
+ * @u: ...unless v is equal to u.
+ *
+ * Atomically adds @a to @v, if @v was not already @u.
+ * Returns true if the addition was done.
+ */
+static __always_inline bool
+arch_atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
+{
+	return arch_atomic64_fetch_add_unless(v, a, u) != u;
+}
+#define arch_atomic64_add_unless arch_atomic64_add_unless
+#endif
+
+#ifndef arch_atomic64_inc_not_zero
+/**
+ * arch_atomic64_inc_not_zero - increment unless the number is zero
+ * @v: pointer of type atomic64_t
+ *
+ * Atomically increments @v by 1, if @v is non-zero.
+ * Returns true if the increment was done.
+ */
+static __always_inline bool
+arch_atomic64_inc_not_zero(atomic64_t *v)
+{
+	return arch_atomic64_add_unless(v, 1, 0);
+}
+#define arch_atomic64_inc_not_zero arch_atomic64_inc_not_zero
+#endif
+
+#ifndef arch_atomic64_inc_unless_negative
+static __always_inline bool
+arch_atomic64_inc_unless_negative(atomic64_t *v)
+{
+	s64 c = arch_atomic64_read(v);
+
+	do {
+		if (unlikely(c < 0))
+			return false;
+	} while (!arch_atomic64_try_cmpxchg(v, &c, c + 1));
+
+	return true;
+}
+#define arch_atomic64_inc_unless_negative arch_atomic64_inc_unless_negative
+#endif
+
+#ifndef arch_atomic64_dec_unless_positive
+static __always_inline bool
+arch_atomic64_dec_unless_positive(atomic64_t *v)
+{
+	s64 c = arch_atomic64_read(v);
+
+	do {
+		if (unlikely(c > 0))
+			return false;
+	} while (!arch_atomic64_try_cmpxchg(v, &c, c - 1));
+
+	return true;
+}
+#define arch_atomic64_dec_unless_positive arch_atomic64_dec_unless_positive
+#endif
+
+#ifndef arch_atomic64_dec_if_positive
+static __always_inline s64
+arch_atomic64_dec_if_positive(atomic64_t *v)
+{
+	s64 dec, c = arch_atomic64_read(v);
+
+	do {
+		dec = c - 1;
+		if (unlikely(dec < 0))
+			break;
+	} while (!arch_atomic64_try_cmpxchg(v, &c, dec));
+
+	return dec;
+}
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
+#endif
+
+#endif /* _LINUX_ATOMIC_FALLBACK_H */
+// 90cd26cfd69d2250303d654955a0cc12620fb91b
diff --git a/include/linux/atomic-fallback.h b/include/linux/atomic-fallback.h
index a7d240e465c0..2c4927bf7b8d 100644
--- a/include/linux/atomic-fallback.h
+++ b/include/linux/atomic-fallback.h
@@ -6,6 +6,8 @@
 #ifndef _LINUX_ATOMIC_FALLBACK_H
 #define _LINUX_ATOMIC_FALLBACK_H
 
+#include <linux/compiler.h>
+
 #ifndef xchg_relaxed
 #define xchg_relaxed		xchg
 #define xchg_acquire		xchg
@@ -76,7 +78,7 @@
 #endif /* cmpxchg64_relaxed */
 
 #ifndef atomic_read_acquire
-static inline int
+static __always_inline int
 atomic_read_acquire(const atomic_t *v)
 {
 	return smp_load_acquire(&(v)->counter);
@@ -85,7 +87,7 @@ atomic_read_acquire(const atomic_t *v)
 #endif
 
 #ifndef atomic_set_release
-static inline void
+static __always_inline void
 atomic_set_release(atomic_t *v, int i)
 {
 	smp_store_release(&(v)->counter, i);
@@ -100,7 +102,7 @@ atomic_set_release(atomic_t *v, int i)
 #else /* atomic_add_return_relaxed */
 
 #ifndef atomic_add_return_acquire
-static inline int
+static __always_inline int
 atomic_add_return_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_add_return_relaxed(i, v);
@@ -111,7 +113,7 @@ atomic_add_return_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_add_return_release
-static inline int
+static __always_inline int
 atomic_add_return_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -121,7 +123,7 @@ atomic_add_return_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_add_return
-static inline int
+static __always_inline int
 atomic_add_return(int i, atomic_t *v)
 {
 	int ret;
@@ -142,7 +144,7 @@ atomic_add_return(int i, atomic_t *v)
 #else /* atomic_fetch_add_relaxed */
 
 #ifndef atomic_fetch_add_acquire
-static inline int
+static __always_inline int
 atomic_fetch_add_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_add_relaxed(i, v);
@@ -153,7 +155,7 @@ atomic_fetch_add_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_add_release
-static inline int
+static __always_inline int
 atomic_fetch_add_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -163,7 +165,7 @@ atomic_fetch_add_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_add
-static inline int
+static __always_inline int
 atomic_fetch_add(int i, atomic_t *v)
 {
 	int ret;
@@ -184,7 +186,7 @@ atomic_fetch_add(int i, atomic_t *v)
 #else /* atomic_sub_return_relaxed */
 
 #ifndef atomic_sub_return_acquire
-static inline int
+static __always_inline int
 atomic_sub_return_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_sub_return_relaxed(i, v);
@@ -195,7 +197,7 @@ atomic_sub_return_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_sub_return_release
-static inline int
+static __always_inline int
 atomic_sub_return_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -205,7 +207,7 @@ atomic_sub_return_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_sub_return
-static inline int
+static __always_inline int
 atomic_sub_return(int i, atomic_t *v)
 {
 	int ret;
@@ -226,7 +228,7 @@ atomic_sub_return(int i, atomic_t *v)
 #else /* atomic_fetch_sub_relaxed */
 
 #ifndef atomic_fetch_sub_acquire
-static inline int
+static __always_inline int
 atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_sub_relaxed(i, v);
@@ -237,7 +239,7 @@ atomic_fetch_sub_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_sub_release
-static inline int
+static __always_inline int
 atomic_fetch_sub_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -247,7 +249,7 @@ atomic_fetch_sub_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_sub
-static inline int
+static __always_inline int
 atomic_fetch_sub(int i, atomic_t *v)
 {
 	int ret;
@@ -262,7 +264,7 @@ atomic_fetch_sub(int i, atomic_t *v)
 #endif /* atomic_fetch_sub_relaxed */
 
 #ifndef atomic_inc
-static inline void
+static __always_inline void
 atomic_inc(atomic_t *v)
 {
 	atomic_add(1, v);
@@ -278,7 +280,7 @@ atomic_inc(atomic_t *v)
 #endif /* atomic_inc_return */
 
 #ifndef atomic_inc_return
-static inline int
+static __always_inline int
 atomic_inc_return(atomic_t *v)
 {
 	return atomic_add_return(1, v);
@@ -287,7 +289,7 @@ atomic_inc_return(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_return_acquire
-static inline int
+static __always_inline int
 atomic_inc_return_acquire(atomic_t *v)
 {
 	return atomic_add_return_acquire(1, v);
@@ -296,7 +298,7 @@ atomic_inc_return_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_return_release
-static inline int
+static __always_inline int
 atomic_inc_return_release(atomic_t *v)
 {
 	return atomic_add_return_release(1, v);
@@ -305,7 +307,7 @@ atomic_inc_return_release(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_return_relaxed
-static inline int
+static __always_inline int
 atomic_inc_return_relaxed(atomic_t *v)
 {
 	return atomic_add_return_relaxed(1, v);
@@ -316,7 +318,7 @@ atomic_inc_return_relaxed(atomic_t *v)
 #else /* atomic_inc_return_relaxed */
 
 #ifndef atomic_inc_return_acquire
-static inline int
+static __always_inline int
 atomic_inc_return_acquire(atomic_t *v)
 {
 	int ret = atomic_inc_return_relaxed(v);
@@ -327,7 +329,7 @@ atomic_inc_return_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_return_release
-static inline int
+static __always_inline int
 atomic_inc_return_release(atomic_t *v)
 {
 	__atomic_release_fence();
@@ -337,7 +339,7 @@ atomic_inc_return_release(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_return
-static inline int
+static __always_inline int
 atomic_inc_return(atomic_t *v)
 {
 	int ret;
@@ -359,7 +361,7 @@ atomic_inc_return(atomic_t *v)
 #endif /* atomic_fetch_inc */
 
 #ifndef atomic_fetch_inc
-static inline int
+static __always_inline int
 atomic_fetch_inc(atomic_t *v)
 {
 	return atomic_fetch_add(1, v);
@@ -368,7 +370,7 @@ atomic_fetch_inc(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_inc_acquire
-static inline int
+static __always_inline int
 atomic_fetch_inc_acquire(atomic_t *v)
 {
 	return atomic_fetch_add_acquire(1, v);
@@ -377,7 +379,7 @@ atomic_fetch_inc_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_inc_release
-static inline int
+static __always_inline int
 atomic_fetch_inc_release(atomic_t *v)
 {
 	return atomic_fetch_add_release(1, v);
@@ -386,7 +388,7 @@ atomic_fetch_inc_release(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_inc_relaxed
-static inline int
+static __always_inline int
 atomic_fetch_inc_relaxed(atomic_t *v)
 {
 	return atomic_fetch_add_relaxed(1, v);
@@ -397,7 +399,7 @@ atomic_fetch_inc_relaxed(atomic_t *v)
 #else /* atomic_fetch_inc_relaxed */
 
 #ifndef atomic_fetch_inc_acquire
-static inline int
+static __always_inline int
 atomic_fetch_inc_acquire(atomic_t *v)
 {
 	int ret = atomic_fetch_inc_relaxed(v);
@@ -408,7 +410,7 @@ atomic_fetch_inc_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_inc_release
-static inline int
+static __always_inline int
 atomic_fetch_inc_release(atomic_t *v)
 {
 	__atomic_release_fence();
@@ -418,7 +420,7 @@ atomic_fetch_inc_release(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_inc
-static inline int
+static __always_inline int
 atomic_fetch_inc(atomic_t *v)
 {
 	int ret;
@@ -433,7 +435,7 @@ atomic_fetch_inc(atomic_t *v)
 #endif /* atomic_fetch_inc_relaxed */
 
 #ifndef atomic_dec
-static inline void
+static __always_inline void
 atomic_dec(atomic_t *v)
 {
 	atomic_sub(1, v);
@@ -449,7 +451,7 @@ atomic_dec(atomic_t *v)
 #endif /* atomic_dec_return */
 
 #ifndef atomic_dec_return
-static inline int
+static __always_inline int
 atomic_dec_return(atomic_t *v)
 {
 	return atomic_sub_return(1, v);
@@ -458,7 +460,7 @@ atomic_dec_return(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_return_acquire
-static inline int
+static __always_inline int
 atomic_dec_return_acquire(atomic_t *v)
 {
 	return atomic_sub_return_acquire(1, v);
@@ -467,7 +469,7 @@ atomic_dec_return_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_return_release
-static inline int
+static __always_inline int
 atomic_dec_return_release(atomic_t *v)
 {
 	return atomic_sub_return_release(1, v);
@@ -476,7 +478,7 @@ atomic_dec_return_release(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_return_relaxed
-static inline int
+static __always_inline int
 atomic_dec_return_relaxed(atomic_t *v)
 {
 	return atomic_sub_return_relaxed(1, v);
@@ -487,7 +489,7 @@ atomic_dec_return_relaxed(atomic_t *v)
 #else /* atomic_dec_return_relaxed */
 
 #ifndef atomic_dec_return_acquire
-static inline int
+static __always_inline int
 atomic_dec_return_acquire(atomic_t *v)
 {
 	int ret = atomic_dec_return_relaxed(v);
@@ -498,7 +500,7 @@ atomic_dec_return_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_return_release
-static inline int
+static __always_inline int
 atomic_dec_return_release(atomic_t *v)
 {
 	__atomic_release_fence();
@@ -508,7 +510,7 @@ atomic_dec_return_release(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_return
-static inline int
+static __always_inline int
 atomic_dec_return(atomic_t *v)
 {
 	int ret;
@@ -530,7 +532,7 @@ atomic_dec_return(atomic_t *v)
 #endif /* atomic_fetch_dec */
 
 #ifndef atomic_fetch_dec
-static inline int
+static __always_inline int
 atomic_fetch_dec(atomic_t *v)
 {
 	return atomic_fetch_sub(1, v);
@@ -539,7 +541,7 @@ atomic_fetch_dec(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_dec_acquire
-static inline int
+static __always_inline int
 atomic_fetch_dec_acquire(atomic_t *v)
 {
 	return atomic_fetch_sub_acquire(1, v);
@@ -548,7 +550,7 @@ atomic_fetch_dec_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_dec_release
-static inline int
+static __always_inline int
 atomic_fetch_dec_release(atomic_t *v)
 {
 	return atomic_fetch_sub_release(1, v);
@@ -557,7 +559,7 @@ atomic_fetch_dec_release(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_dec_relaxed
-static inline int
+static __always_inline int
 atomic_fetch_dec_relaxed(atomic_t *v)
 {
 	return atomic_fetch_sub_relaxed(1, v);
@@ -568,7 +570,7 @@ atomic_fetch_dec_relaxed(atomic_t *v)
 #else /* atomic_fetch_dec_relaxed */
 
 #ifndef atomic_fetch_dec_acquire
-static inline int
+static __always_inline int
 atomic_fetch_dec_acquire(atomic_t *v)
 {
 	int ret = atomic_fetch_dec_relaxed(v);
@@ -579,7 +581,7 @@ atomic_fetch_dec_acquire(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_dec_release
-static inline int
+static __always_inline int
 atomic_fetch_dec_release(atomic_t *v)
 {
 	__atomic_release_fence();
@@ -589,7 +591,7 @@ atomic_fetch_dec_release(atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_dec
-static inline int
+static __always_inline int
 atomic_fetch_dec(atomic_t *v)
 {
 	int ret;
@@ -610,7 +612,7 @@ atomic_fetch_dec(atomic_t *v)
 #else /* atomic_fetch_and_relaxed */
 
 #ifndef atomic_fetch_and_acquire
-static inline int
+static __always_inline int
 atomic_fetch_and_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_and_relaxed(i, v);
@@ -621,7 +623,7 @@ atomic_fetch_and_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_and_release
-static inline int
+static __always_inline int
 atomic_fetch_and_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -631,7 +633,7 @@ atomic_fetch_and_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_and
-static inline int
+static __always_inline int
 atomic_fetch_and(int i, atomic_t *v)
 {
 	int ret;
@@ -646,7 +648,7 @@ atomic_fetch_and(int i, atomic_t *v)
 #endif /* atomic_fetch_and_relaxed */
 
 #ifndef atomic_andnot
-static inline void
+static __always_inline void
 atomic_andnot(int i, atomic_t *v)
 {
 	atomic_and(~i, v);
@@ -662,7 +664,7 @@ atomic_andnot(int i, atomic_t *v)
 #endif /* atomic_fetch_andnot */
 
 #ifndef atomic_fetch_andnot
-static inline int
+static __always_inline int
 atomic_fetch_andnot(int i, atomic_t *v)
 {
 	return atomic_fetch_and(~i, v);
@@ -671,7 +673,7 @@ atomic_fetch_andnot(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_andnot_acquire
-static inline int
+static __always_inline int
 atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
 	return atomic_fetch_and_acquire(~i, v);
@@ -680,7 +682,7 @@ atomic_fetch_andnot_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_andnot_release
-static inline int
+static __always_inline int
 atomic_fetch_andnot_release(int i, atomic_t *v)
 {
 	return atomic_fetch_and_release(~i, v);
@@ -689,7 +691,7 @@ atomic_fetch_andnot_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_andnot_relaxed
-static inline int
+static __always_inline int
 atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
 	return atomic_fetch_and_relaxed(~i, v);
@@ -700,7 +702,7 @@ atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 #else /* atomic_fetch_andnot_relaxed */
 
 #ifndef atomic_fetch_andnot_acquire
-static inline int
+static __always_inline int
 atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_andnot_relaxed(i, v);
@@ -711,7 +713,7 @@ atomic_fetch_andnot_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_andnot_release
-static inline int
+static __always_inline int
 atomic_fetch_andnot_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -721,7 +723,7 @@ atomic_fetch_andnot_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_andnot
-static inline int
+static __always_inline int
 atomic_fetch_andnot(int i, atomic_t *v)
 {
 	int ret;
@@ -742,7 +744,7 @@ atomic_fetch_andnot(int i, atomic_t *v)
 #else /* atomic_fetch_or_relaxed */
 
 #ifndef atomic_fetch_or_acquire
-static inline int
+static __always_inline int
 atomic_fetch_or_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_or_relaxed(i, v);
@@ -753,7 +755,7 @@ atomic_fetch_or_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_or_release
-static inline int
+static __always_inline int
 atomic_fetch_or_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -763,7 +765,7 @@ atomic_fetch_or_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_or
-static inline int
+static __always_inline int
 atomic_fetch_or(int i, atomic_t *v)
 {
 	int ret;
@@ -784,7 +786,7 @@ atomic_fetch_or(int i, atomic_t *v)
 #else /* atomic_fetch_xor_relaxed */
 
 #ifndef atomic_fetch_xor_acquire
-static inline int
+static __always_inline int
 atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
 	int ret = atomic_fetch_xor_relaxed(i, v);
@@ -795,7 +797,7 @@ atomic_fetch_xor_acquire(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_xor_release
-static inline int
+static __always_inline int
 atomic_fetch_xor_release(int i, atomic_t *v)
 {
 	__atomic_release_fence();
@@ -805,7 +807,7 @@ atomic_fetch_xor_release(int i, atomic_t *v)
 #endif
 
 #ifndef atomic_fetch_xor
-static inline int
+static __always_inline int
 atomic_fetch_xor(int i, atomic_t *v)
 {
 	int ret;
@@ -826,7 +828,7 @@ atomic_fetch_xor(int i, atomic_t *v)
 #else /* atomic_xchg_relaxed */
 
 #ifndef atomic_xchg_acquire
-static inline int
+static __always_inline int
 atomic_xchg_acquire(atomic_t *v, int i)
 {
 	int ret = atomic_xchg_relaxed(v, i);
@@ -837,7 +839,7 @@ atomic_xchg_acquire(atomic_t *v, int i)
 #endif
 
 #ifndef atomic_xchg_release
-static inline int
+static __always_inline int
 atomic_xchg_release(atomic_t *v, int i)
 {
 	__atomic_release_fence();
@@ -847,7 +849,7 @@ atomic_xchg_release(atomic_t *v, int i)
 #endif
 
 #ifndef atomic_xchg
-static inline int
+static __always_inline int
 atomic_xchg(atomic_t *v, int i)
 {
 	int ret;
@@ -868,7 +870,7 @@ atomic_xchg(atomic_t *v, int i)
 #else /* atomic_cmpxchg_relaxed */
 
 #ifndef atomic_cmpxchg_acquire
-static inline int
+static __always_inline int
 atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
 	int ret = atomic_cmpxchg_relaxed(v, old, new);
@@ -879,7 +881,7 @@ atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 #endif
 
 #ifndef atomic_cmpxchg_release
-static inline int
+static __always_inline int
 atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
 	__atomic_release_fence();
@@ -889,7 +891,7 @@ atomic_cmpxchg_release(atomic_t *v, int old, int new)
 #endif
 
 #ifndef atomic_cmpxchg
-static inline int
+static __always_inline int
 atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	int ret;
@@ -911,7 +913,7 @@ atomic_cmpxchg(atomic_t *v, int old, int new)
 #endif /* atomic_try_cmpxchg */
 
 #ifndef atomic_try_cmpxchg
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
@@ -924,7 +926,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef atomic_try_cmpxchg_acquire
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
@@ -937,7 +939,7 @@ atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef atomic_try_cmpxchg_release
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
@@ -950,7 +952,7 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef atomic_try_cmpxchg_relaxed
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
@@ -965,7 +967,7 @@ atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 #else /* atomic_try_cmpxchg_relaxed */
 
 #ifndef atomic_try_cmpxchg_acquire
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
 	bool ret = atomic_try_cmpxchg_relaxed(v, old, new);
@@ -976,7 +978,7 @@ atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef atomic_try_cmpxchg_release
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
 	__atomic_release_fence();
@@ -986,7 +988,7 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 #endif
 
 #ifndef atomic_try_cmpxchg
-static inline bool
+static __always_inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
 	bool ret;
@@ -1010,7 +1012,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
  * true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
+static __always_inline bool
 atomic_sub_and_test(int i, atomic_t *v)
 {
 	return atomic_sub_return(i, v) == 0;
@@ -1027,7 +1029,7 @@ atomic_sub_and_test(int i, atomic_t *v)
  * returns true if the result is 0, or false for all other
  * cases.
  */
-static inline bool
+static __always_inline bool
 atomic_dec_and_test(atomic_t *v)
 {
 	return atomic_dec_return(v) == 0;
@@ -1044,7 +1046,7 @@ atomic_dec_and_test(atomic_t *v)
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
+static __always_inline bool
 atomic_inc_and_test(atomic_t *v)
 {
 	return atomic_inc_return(v) == 0;
@@ -1062,7 +1064,7 @@ atomic_inc_and_test(atomic_t *v)
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-static inline bool
+static __always_inline bool
 atomic_add_negative(int i, atomic_t *v)
 {
 	return atomic_add_return(i, v) < 0;
@@ -1080,7 +1082,7 @@ atomic_add_negative(int i, atomic_t *v)
  * Atomically adds @a to @v, so long as @v was not already @u.
  * Returns original value of @v
  */
-static inline int
+static __always_inline int
 atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c = atomic_read(v);
@@ -1105,7 +1107,7 @@ atomic_fetch_add_unless(atomic_t *v, int a, int u)
  * Atomically adds @a to @v, if @v was not already @u.
  * Returns true if the addition was done.
  */
-static inline bool
+static __always_inline bool
 atomic_add_unless(atomic_t *v, int a, int u)
 {
 	return atomic_fetch_add_unless(v, a, u) != u;
@@ -1121,7 +1123,7 @@ atomic_add_unless(atomic_t *v, int a, int u)
  * Atomically increments @v by 1, if @v is non-zero.
  * Returns true if the increment was done.
  */
-static inline bool
+static __always_inline bool
 atomic_inc_not_zero(atomic_t *v)
 {
 	return atomic_add_unless(v, 1, 0);
@@ -1130,7 +1132,7 @@ atomic_inc_not_zero(atomic_t *v)
 #endif
 
 #ifndef atomic_inc_unless_negative
-static inline bool
+static __always_inline bool
 atomic_inc_unless_negative(atomic_t *v)
 {
 	int c = atomic_read(v);
@@ -1146,7 +1148,7 @@ atomic_inc_unless_negative(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_unless_positive
-static inline bool
+static __always_inline bool
 atomic_dec_unless_positive(atomic_t *v)
 {
 	int c = atomic_read(v);
@@ -1162,7 +1164,7 @@ atomic_dec_unless_positive(atomic_t *v)
 #endif
 
 #ifndef atomic_dec_if_positive
-static inline int
+static __always_inline int
 atomic_dec_if_positive(atomic_t *v)
 {
 	int dec, c = atomic_read(v);
@@ -1178,15 +1180,12 @@ atomic_dec_if_positive(atomic_t *v)
 #define atomic_dec_if_positive atomic_dec_if_positive
 #endif
 
-#define atomic_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
-#define atomic_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
-
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif
 
 #ifndef atomic64_read_acquire
-static inline s64
+static __always_inline s64
 atomic64_read_acquire(const atomic64_t *v)
 {
 	return smp_load_acquire(&(v)->counter);
@@ -1195,7 +1194,7 @@ atomic64_read_acquire(const atomic64_t *v)
 #endif
 
 #ifndef atomic64_set_release
-static inline void
+static __always_inline void
 atomic64_set_release(atomic64_t *v, s64 i)
 {
 	smp_store_release(&(v)->counter, i);
@@ -1210,7 +1209,7 @@ atomic64_set_release(atomic64_t *v, s64 i)
 #else /* atomic64_add_return_relaxed */
 
 #ifndef atomic64_add_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_add_return_relaxed(i, v);
@@ -1221,7 +1220,7 @@ atomic64_add_return_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_add_return_release
-static inline s64
+static __always_inline s64
 atomic64_add_return_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1231,7 +1230,7 @@ atomic64_add_return_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_add_return
-static inline s64
+static __always_inline s64
 atomic64_add_return(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1252,7 +1251,7 @@ atomic64_add_return(s64 i, atomic64_t *v)
 #else /* atomic64_fetch_add_relaxed */
 
 #ifndef atomic64_fetch_add_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_add_relaxed(i, v);
@@ -1263,7 +1262,7 @@ atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_add_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1273,7 +1272,7 @@ atomic64_fetch_add_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_add
-static inline s64
+static __always_inline s64
 atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1294,7 +1293,7 @@ atomic64_fetch_add(s64 i, atomic64_t *v)
 #else /* atomic64_sub_return_relaxed */
 
 #ifndef atomic64_sub_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_sub_return_relaxed(i, v);
@@ -1305,7 +1304,7 @@ atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_sub_return_release
-static inline s64
+static __always_inline s64
 atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1315,7 +1314,7 @@ atomic64_sub_return_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_sub_return
-static inline s64
+static __always_inline s64
 atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1336,7 +1335,7 @@ atomic64_sub_return(s64 i, atomic64_t *v)
 #else /* atomic64_fetch_sub_relaxed */
 
 #ifndef atomic64_fetch_sub_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_sub_relaxed(i, v);
@@ -1347,7 +1346,7 @@ atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_sub_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1357,7 +1356,7 @@ atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_sub
-static inline s64
+static __always_inline s64
 atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1372,7 +1371,7 @@ atomic64_fetch_sub(s64 i, atomic64_t *v)
 #endif /* atomic64_fetch_sub_relaxed */
 
 #ifndef atomic64_inc
-static inline void
+static __always_inline void
 atomic64_inc(atomic64_t *v)
 {
 	atomic64_add(1, v);
@@ -1388,7 +1387,7 @@ atomic64_inc(atomic64_t *v)
 #endif /* atomic64_inc_return */
 
 #ifndef atomic64_inc_return
-static inline s64
+static __always_inline s64
 atomic64_inc_return(atomic64_t *v)
 {
 	return atomic64_add_return(1, v);
@@ -1397,7 +1396,7 @@ atomic64_inc_return(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_inc_return_acquire(atomic64_t *v)
 {
 	return atomic64_add_return_acquire(1, v);
@@ -1406,7 +1405,7 @@ atomic64_inc_return_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_return_release
-static inline s64
+static __always_inline s64
 atomic64_inc_return_release(atomic64_t *v)
 {
 	return atomic64_add_return_release(1, v);
@@ -1415,7 +1414,7 @@ atomic64_inc_return_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_return_relaxed
-static inline s64
+static __always_inline s64
 atomic64_inc_return_relaxed(atomic64_t *v)
 {
 	return atomic64_add_return_relaxed(1, v);
@@ -1426,7 +1425,7 @@ atomic64_inc_return_relaxed(atomic64_t *v)
 #else /* atomic64_inc_return_relaxed */
 
 #ifndef atomic64_inc_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_inc_return_acquire(atomic64_t *v)
 {
 	s64 ret = atomic64_inc_return_relaxed(v);
@@ -1437,7 +1436,7 @@ atomic64_inc_return_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_return_release
-static inline s64
+static __always_inline s64
 atomic64_inc_return_release(atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1447,7 +1446,7 @@ atomic64_inc_return_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_return
-static inline s64
+static __always_inline s64
 atomic64_inc_return(atomic64_t *v)
 {
 	s64 ret;
@@ -1469,7 +1468,7 @@ atomic64_inc_return(atomic64_t *v)
 #endif /* atomic64_fetch_inc */
 
 #ifndef atomic64_fetch_inc
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc(atomic64_t *v)
 {
 	return atomic64_fetch_add(1, v);
@@ -1478,7 +1477,7 @@ atomic64_fetch_inc(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_inc_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_acquire(atomic64_t *v)
 {
 	return atomic64_fetch_add_acquire(1, v);
@@ -1487,7 +1486,7 @@ atomic64_fetch_inc_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_inc_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_release(atomic64_t *v)
 {
 	return atomic64_fetch_add_release(1, v);
@@ -1496,7 +1495,7 @@ atomic64_fetch_inc_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_inc_relaxed
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
 	return atomic64_fetch_add_relaxed(1, v);
@@ -1507,7 +1506,7 @@ atomic64_fetch_inc_relaxed(atomic64_t *v)
 #else /* atomic64_fetch_inc_relaxed */
 
 #ifndef atomic64_fetch_inc_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_acquire(atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_inc_relaxed(v);
@@ -1518,7 +1517,7 @@ atomic64_fetch_inc_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_inc_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc_release(atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1528,7 +1527,7 @@ atomic64_fetch_inc_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_inc
-static inline s64
+static __always_inline s64
 atomic64_fetch_inc(atomic64_t *v)
 {
 	s64 ret;
@@ -1543,7 +1542,7 @@ atomic64_fetch_inc(atomic64_t *v)
 #endif /* atomic64_fetch_inc_relaxed */
 
 #ifndef atomic64_dec
-static inline void
+static __always_inline void
 atomic64_dec(atomic64_t *v)
 {
 	atomic64_sub(1, v);
@@ -1559,7 +1558,7 @@ atomic64_dec(atomic64_t *v)
 #endif /* atomic64_dec_return */
 
 #ifndef atomic64_dec_return
-static inline s64
+static __always_inline s64
 atomic64_dec_return(atomic64_t *v)
 {
 	return atomic64_sub_return(1, v);
@@ -1568,7 +1567,7 @@ atomic64_dec_return(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_dec_return_acquire(atomic64_t *v)
 {
 	return atomic64_sub_return_acquire(1, v);
@@ -1577,7 +1576,7 @@ atomic64_dec_return_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_return_release
-static inline s64
+static __always_inline s64
 atomic64_dec_return_release(atomic64_t *v)
 {
 	return atomic64_sub_return_release(1, v);
@@ -1586,7 +1585,7 @@ atomic64_dec_return_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_return_relaxed
-static inline s64
+static __always_inline s64
 atomic64_dec_return_relaxed(atomic64_t *v)
 {
 	return atomic64_sub_return_relaxed(1, v);
@@ -1597,7 +1596,7 @@ atomic64_dec_return_relaxed(atomic64_t *v)
 #else /* atomic64_dec_return_relaxed */
 
 #ifndef atomic64_dec_return_acquire
-static inline s64
+static __always_inline s64
 atomic64_dec_return_acquire(atomic64_t *v)
 {
 	s64 ret = atomic64_dec_return_relaxed(v);
@@ -1608,7 +1607,7 @@ atomic64_dec_return_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_return_release
-static inline s64
+static __always_inline s64
 atomic64_dec_return_release(atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1618,7 +1617,7 @@ atomic64_dec_return_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_return
-static inline s64
+static __always_inline s64
 atomic64_dec_return(atomic64_t *v)
 {
 	s64 ret;
@@ -1640,7 +1639,7 @@ atomic64_dec_return(atomic64_t *v)
 #endif /* atomic64_fetch_dec */
 
 #ifndef atomic64_fetch_dec
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec(atomic64_t *v)
 {
 	return atomic64_fetch_sub(1, v);
@@ -1649,7 +1648,7 @@ atomic64_fetch_dec(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_dec_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_acquire(atomic64_t *v)
 {
 	return atomic64_fetch_sub_acquire(1, v);
@@ -1658,7 +1657,7 @@ atomic64_fetch_dec_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_dec_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_release(atomic64_t *v)
 {
 	return atomic64_fetch_sub_release(1, v);
@@ -1667,7 +1666,7 @@ atomic64_fetch_dec_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_dec_relaxed
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
 	return atomic64_fetch_sub_relaxed(1, v);
@@ -1678,7 +1677,7 @@ atomic64_fetch_dec_relaxed(atomic64_t *v)
 #else /* atomic64_fetch_dec_relaxed */
 
 #ifndef atomic64_fetch_dec_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_acquire(atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_dec_relaxed(v);
@@ -1689,7 +1688,7 @@ atomic64_fetch_dec_acquire(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_dec_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec_release(atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1699,7 +1698,7 @@ atomic64_fetch_dec_release(atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_dec
-static inline s64
+static __always_inline s64
 atomic64_fetch_dec(atomic64_t *v)
 {
 	s64 ret;
@@ -1720,7 +1719,7 @@ atomic64_fetch_dec(atomic64_t *v)
 #else /* atomic64_fetch_and_relaxed */
 
 #ifndef atomic64_fetch_and_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_and_relaxed(i, v);
@@ -1731,7 +1730,7 @@ atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_and_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1741,7 +1740,7 @@ atomic64_fetch_and_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_and
-static inline s64
+static __always_inline s64
 atomic64_fetch_and(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1756,7 +1755,7 @@ atomic64_fetch_and(s64 i, atomic64_t *v)
 #endif /* atomic64_fetch_and_relaxed */
 
 #ifndef atomic64_andnot
-static inline void
+static __always_inline void
 atomic64_andnot(s64 i, atomic64_t *v)
 {
 	atomic64_and(~i, v);
@@ -1772,7 +1771,7 @@ atomic64_andnot(s64 i, atomic64_t *v)
 #endif /* atomic64_fetch_andnot */
 
 #ifndef atomic64_fetch_andnot
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
 	return atomic64_fetch_and(~i, v);
@@ -1781,7 +1780,7 @@ atomic64_fetch_andnot(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_andnot_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
 	return atomic64_fetch_and_acquire(~i, v);
@@ -1790,7 +1789,7 @@ atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_andnot_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
 	return atomic64_fetch_and_release(~i, v);
@@ -1799,7 +1798,7 @@ atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_andnot_relaxed
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
 	return atomic64_fetch_and_relaxed(~i, v);
@@ -1810,7 +1809,7 @@ atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 #else /* atomic64_fetch_andnot_relaxed */
 
 #ifndef atomic64_fetch_andnot_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_andnot_relaxed(i, v);
@@ -1821,7 +1820,7 @@ atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_andnot_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1831,7 +1830,7 @@ atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_andnot
-static inline s64
+static __always_inline s64
 atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1852,7 +1851,7 @@ atomic64_fetch_andnot(s64 i, atomic64_t *v)
 #else /* atomic64_fetch_or_relaxed */
 
 #ifndef atomic64_fetch_or_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_or_relaxed(i, v);
@@ -1863,7 +1862,7 @@ atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_or_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1873,7 +1872,7 @@ atomic64_fetch_or_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_or
-static inline s64
+static __always_inline s64
 atomic64_fetch_or(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1894,7 +1893,7 @@ atomic64_fetch_or(s64 i, atomic64_t *v)
 #else /* atomic64_fetch_xor_relaxed */
 
 #ifndef atomic64_fetch_xor_acquire
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
 	s64 ret = atomic64_fetch_xor_relaxed(i, v);
@@ -1905,7 +1904,7 @@ atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_xor_release
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
 	__atomic_release_fence();
@@ -1915,7 +1914,7 @@ atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 #endif
 
 #ifndef atomic64_fetch_xor
-static inline s64
+static __always_inline s64
 atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
 	s64 ret;
@@ -1936,7 +1935,7 @@ atomic64_fetch_xor(s64 i, atomic64_t *v)
 #else /* atomic64_xchg_relaxed */
 
 #ifndef atomic64_xchg_acquire
-static inline s64
+static __always_inline s64
 atomic64_xchg_acquire(atomic64_t *v, s64 i)
 {
 	s64 ret = atomic64_xchg_relaxed(v, i);
@@ -1947,7 +1946,7 @@ atomic64_xchg_acquire(atomic64_t *v, s64 i)
 #endif
 
 #ifndef atomic64_xchg_release
-static inline s64
+static __always_inline s64
 atomic64_xchg_release(atomic64_t *v, s64 i)
 {
 	__atomic_release_fence();
@@ -1957,7 +1956,7 @@ atomic64_xchg_release(atomic64_t *v, s64 i)
 #endif
 
 #ifndef atomic64_xchg
-static inline s64
+static __always_inline s64
 atomic64_xchg(atomic64_t *v, s64 i)
 {
 	s64 ret;
@@ -1978,7 +1977,7 @@ atomic64_xchg(atomic64_t *v, s64 i)
 #else /* atomic64_cmpxchg_relaxed */
 
 #ifndef atomic64_cmpxchg_acquire
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
 	s64 ret = atomic64_cmpxchg_relaxed(v, old, new);
@@ -1989,7 +1988,7 @@ atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 #endif
 
 #ifndef atomic64_cmpxchg_release
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
 	__atomic_release_fence();
@@ -1999,7 +1998,7 @@ atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 #endif
 
 #ifndef atomic64_cmpxchg
-static inline s64
+static __always_inline s64
 atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
 	s64 ret;
@@ -2021,7 +2020,7 @@ atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 #endif /* atomic64_try_cmpxchg */
 
 #ifndef atomic64_try_cmpxchg
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	s64 r, o = *old;
@@ -2034,7 +2033,7 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef atomic64_try_cmpxchg_acquire
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
 	s64 r, o = *old;
@@ -2047,7 +2046,7 @@ atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef atomic64_try_cmpxchg_release
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
 	s64 r, o = *old;
@@ -2060,7 +2059,7 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef atomic64_try_cmpxchg_relaxed
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
 	s64 r, o = *old;
@@ -2075,7 +2074,7 @@ atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 #else /* atomic64_try_cmpxchg_relaxed */
 
 #ifndef atomic64_try_cmpxchg_acquire
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
 	bool ret = atomic64_try_cmpxchg_relaxed(v, old, new);
@@ -2086,7 +2085,7 @@ atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef atomic64_try_cmpxchg_release
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
 	__atomic_release_fence();
@@ -2096,7 +2095,7 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 #endif
 
 #ifndef atomic64_try_cmpxchg
-static inline bool
+static __always_inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
 	bool ret;
@@ -2120,7 +2119,7 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
  * true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
+static __always_inline bool
 atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
 	return atomic64_sub_return(i, v) == 0;
@@ -2137,7 +2136,7 @@ atomic64_sub_and_test(s64 i, atomic64_t *v)
  * returns true if the result is 0, or false for all other
  * cases.
  */
-static inline bool
+static __always_inline bool
 atomic64_dec_and_test(atomic64_t *v)
 {
 	return atomic64_dec_return(v) == 0;
@@ -2154,7 +2153,7 @@ atomic64_dec_and_test(atomic64_t *v)
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
+static __always_inline bool
 atomic64_inc_and_test(atomic64_t *v)
 {
 	return atomic64_inc_return(v) == 0;
@@ -2172,7 +2171,7 @@ atomic64_inc_and_test(atomic64_t *v)
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-static inline bool
+static __always_inline bool
 atomic64_add_negative(s64 i, atomic64_t *v)
 {
 	return atomic64_add_return(i, v) < 0;
@@ -2190,7 +2189,7 @@ atomic64_add_negative(s64 i, atomic64_t *v)
  * Atomically adds @a to @v, so long as @v was not already @u.
  * Returns original value of @v
  */
-static inline s64
+static __always_inline s64
 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	s64 c = atomic64_read(v);
@@ -2215,7 +2214,7 @@ atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
  * Atomically adds @a to @v, if @v was not already @u.
  * Returns true if the addition was done.
  */
-static inline bool
+static __always_inline bool
 atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	return atomic64_fetch_add_unless(v, a, u) != u;
@@ -2231,7 +2230,7 @@ atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
  * Atomically increments @v by 1, if @v is non-zero.
  * Returns true if the increment was done.
  */
-static inline bool
+static __always_inline bool
 atomic64_inc_not_zero(atomic64_t *v)
 {
 	return atomic64_add_unless(v, 1, 0);
@@ -2240,7 +2239,7 @@ atomic64_inc_not_zero(atomic64_t *v)
 #endif
 
 #ifndef atomic64_inc_unless_negative
-static inline bool
+static __always_inline bool
 atomic64_inc_unless_negative(atomic64_t *v)
 {
 	s64 c = atomic64_read(v);
@@ -2256,7 +2255,7 @@ atomic64_inc_unless_negative(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_unless_positive
-static inline bool
+static __always_inline bool
 atomic64_dec_unless_positive(atomic64_t *v)
 {
 	s64 c = atomic64_read(v);
@@ -2272,7 +2271,7 @@ atomic64_dec_unless_positive(atomic64_t *v)
 #endif
 
 #ifndef atomic64_dec_if_positive
-static inline s64
+static __always_inline s64
 atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 dec, c = atomic64_read(v);
@@ -2288,8 +2287,5 @@ atomic64_dec_if_positive(atomic64_t *v)
 #define atomic64_dec_if_positive atomic64_dec_if_positive
 #endif
 
-#define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
-#define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
-
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 25de4a2804d70f57e994fe3b419148658bb5378a
+// 1fac0941c79bf0ae100723cc2ac9b94061f0b67a
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 4c0d009a46f0..571a11008ab5 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -25,6 +25,12 @@
  * See Documentation/memory-barriers.txt for ACQUIRE/RELEASE definitions.
  */
 
+#define atomic_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
+#define atomic_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
+
+#define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
+#define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
+
 /*
  * The idea here is to build acquire/release variants by adding explicit
  * barriers on top of the relaxed variant. In the case where the relaxed
@@ -71,7 +77,12 @@
 	__ret;								\
 })
 
+#ifdef ARCH_ATOMIC
+#include <linux/atomic-arch-fallback.h>
+#include <asm-generic/atomic-instrumented.h>
+#else
 #include <linux/atomic-fallback.h>
+#endif
 
 #include <asm-generic/atomic-long.h>
 
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 790c0c6b8552..ee37256ec8bd 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -16,7 +16,7 @@
 #define KASAN_ABI_VERSION 5
 
 #if __has_feature(address_sanitizer) || __has_feature(hwaddress_sanitizer)
-/* emulate gcc's __SANITIZE_ADDRESS__ flag */
+/* Emulate GCC's __SANITIZE_ADDRESS__ flag */
 #define __SANITIZE_ADDRESS__
 #define __no_sanitize_address \
 		__attribute__((no_sanitize("address", "hwaddress")))
@@ -24,6 +24,15 @@
 #define __no_sanitize_address
 #endif
 
+#if __has_feature(thread_sanitizer)
+/* emulate gcc's __SANITIZE_THREAD__ flag */
+#define __SANITIZE_THREAD__
+#define __no_sanitize_thread \
+		__attribute__((no_sanitize("thread")))
+#else
+#define __no_sanitize_thread
+#endif
+
 /*
  * Not all versions of clang implement the the type-generic versions
  * of the builtin overflow checkers. Fortunately, clang implements
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index e2f725273261..7dd4e0349ef3 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -144,6 +144,12 @@
 #define __no_sanitize_address
 #endif
 
+#if defined(__SANITIZE_THREAD__) && __has_attribute(__no_sanitize_thread__)
+#define __no_sanitize_thread __attribute__((no_sanitize_thread))
+#else
+#define __no_sanitize_thread
+#endif
+
 #if GCC_VERSION >= 50100
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 33d3a2e5abab..30827f82ad62 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -250,6 +250,27 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  */
 #include <asm/barrier.h>
 #include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
+
+/**
+ * data_race - mark an expression as containing intentional data races
+ *
+ * This data_race() macro is useful for situations in which data races
+ * should be forgiven.  One example is diagnostic code that accesses
+ * shared variables but is not a part of the core synchronization design.
+ *
+ * This macro *does not* affect normal code generation, but is a hint
+ * to tooling that data races here are to be ignored.
+ */
+#define data_race(expr)							\
+({									\
+	__unqual_scalar_typeof(({ expr; })) __v = ({			\
+		__kcsan_disable_current();				\
+		expr;							\
+	});								\
+	__kcsan_enable_current();					\
+	__v;								\
+})
 
 /*
  * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
@@ -271,30 +292,18 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	__READ_ONCE_SCALAR(x);						\
 })
 
-#define __WRITE_ONCE(x, val)				\
-do {							\
-	*(volatile typeof(x) *)&(x) = (val);		\
+#define __WRITE_ONCE(x, val)						\
+do {									\
+	*(volatile typeof(x) *)&(x) = (val);				\
 } while (0)
 
-#define WRITE_ONCE(x, val)				\
-do {							\
-	compiletime_assert_rwonce_type(x);		\
-	__WRITE_ONCE(x, val);				\
+#define WRITE_ONCE(x, val)						\
+do {									\
+	compiletime_assert_rwonce_type(x);				\
+	__WRITE_ONCE(x, val);						\
 } while (0)
 
-#ifdef CONFIG_KASAN
-/*
- * We can't declare function 'inline' because __no_sanitize_address conflicts
- * with inlining. Attempt to inline it may cause a build failure.
- *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
- * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
- */
-# define __no_kasan_or_inline __no_sanitize_address notrace __maybe_unused
-#else
-# define __no_kasan_or_inline __always_inline
-#endif
-
-static __no_kasan_or_inline
+static __no_sanitize_or_inline
 unsigned long __read_once_word_nocheck(const void *addr)
 {
 	return __READ_ONCE(*(unsigned long *)addr);
@@ -302,8 +311,8 @@ unsigned long __read_once_word_nocheck(const void *addr)
 
 /*
  * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need to load a
- * word from memory atomically but without telling KASAN. This is usually
- * used by unwinding code when walking the stack of a running process.
+ * word from memory atomically but without telling KASAN/KCSAN. This is
+ * usually used by unwinding code when walking the stack of a running process.
  */
 #define READ_ONCE_NOCHECK(x)						\
 ({									\
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index d4e1956f903f..21aed0981edf 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -171,6 +171,38 @@ struct ftrace_likely_data {
  */
 #define noinline_for_stack noinline
 
+/*
+ * Sanitizer helper attributes: Because using __always_inline and
+ * __no_sanitize_* conflict, provide helper attributes that will either expand
+ * to __no_sanitize_* in compilation units where instrumentation is enabled
+ * (__SANITIZE_*__), or __always_inline in compilation units without
+ * instrumentation (__SANITIZE_*__ undefined).
+ */
+#ifdef __SANITIZE_ADDRESS__
+/*
+ * We can't declare function 'inline' because __no_sanitize_address conflicts
+ * with inlining. Attempt to inline it may cause a build failure.
+ *     https://gcc.gnu.org/bugzilla/show_bug.cgi?id=67368
+ * '__maybe_unused' allows us to avoid defined-but-not-used warnings.
+ */
+# define __no_kasan_or_inline __no_sanitize_address notrace __maybe_unused
+# define __no_sanitize_or_inline __no_kasan_or_inline
+#else
+# define __no_kasan_or_inline __always_inline
+#endif
+
+#define __no_kcsan __no_sanitize_thread
+#ifdef __SANITIZE_THREAD__
+# define __no_kcsan_or_inline __no_kcsan notrace __maybe_unused
+# define __no_sanitize_or_inline __no_kcsan_or_inline
+#else
+# define __no_kcsan_or_inline __always_inline
+#endif
+
+#ifndef __no_sanitize_or_inline
+#define __no_sanitize_or_inline __always_inline
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
new file mode 100644
index 000000000000..43e6ea591975
--- /dev/null
+++ b/include/linux/instrumented.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This header provides generic wrappers for memory access instrumentation that
+ * the compiler cannot emit for: KASAN, KCSAN.
+ */
+#ifndef _LINUX_INSTRUMENTED_H
+#define _LINUX_INSTRUMENTED_H
+
+#include <linux/compiler.h>
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
+#include <linux/types.h>
+
+/**
+ * instrument_read - instrument regular read access
+ *
+ * Instrument a regular read access. The instrumentation should be inserted
+ * before the actual read happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_read(const volatile void *v, size_t size)
+{
+	kasan_check_read(v, size);
+	kcsan_check_read(v, size);
+}
+
+/**
+ * instrument_write - instrument regular write access
+ *
+ * Instrument a regular write access. The instrumentation should be inserted
+ * before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_write(v, size);
+}
+
+/**
+ * instrument_atomic_read - instrument atomic read access
+ *
+ * Instrument an atomic read access. The instrumentation should be inserted
+ * before the actual read happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_atomic_read(const volatile void *v, size_t size)
+{
+	kasan_check_read(v, size);
+	kcsan_check_atomic_read(v, size);
+}
+
+/**
+ * instrument_atomic_write - instrument atomic write access
+ *
+ * Instrument an atomic write access. The instrumentation should be inserted
+ * before the actual write happens.
+ *
+ * @ptr address of access
+ * @size size of access
+ */
+static __always_inline void instrument_atomic_write(const volatile void *v, size_t size)
+{
+	kasan_check_write(v, size);
+	kcsan_check_atomic_write(v, size);
+}
+
+/**
+ * instrument_copy_to_user - instrument reads of copy_to_user
+ *
+ * Instrument reads from kernel memory, that are due to copy_to_user (and
+ * variants). The instrumentation must be inserted before the accesses.
+ *
+ * @to destination address
+ * @from source address
+ * @n number of bytes to copy
+ */
+static __always_inline void
+instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	kasan_check_read(from, n);
+	kcsan_check_read(from, n);
+}
+
+/**
+ * instrument_copy_from_user - instrument writes of copy_from_user
+ *
+ * Instrument writes to kernel memory, that are due to copy_from_user (and
+ * variants). The instrumentation should be inserted before the accesses.
+ *
+ * @to destination address
+ * @from source address
+ * @n number of bytes to copy
+ */
+static __always_inline void
+instrument_copy_from_user(const void *to, const void __user *from, unsigned long n)
+{
+	kasan_check_write(to, n);
+	kcsan_check_write(to, n);
+}
+
+#endif /* _LINUX_INSTRUMENTED_H */
diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
new file mode 100644
index 000000000000..7b0b9c44f5f3
--- /dev/null
+++ b/include/linux/kcsan-checks.h
@@ -0,0 +1,430 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_KCSAN_CHECKS_H
+#define _LINUX_KCSAN_CHECKS_H
+
+/* Note: Only include what is already included by compiler.h. */
+#include <linux/compiler_attributes.h>
+#include <linux/types.h>
+
+/*
+ * ACCESS TYPE MODIFIERS
+ *
+ *   <none>: normal read access;
+ *   WRITE : write access;
+ *   ATOMIC: access is atomic;
+ *   ASSERT: access is not a regular access, but an assertion;
+ *   SCOPED: access is a scoped access;
+ */
+#define KCSAN_ACCESS_WRITE  0x1
+#define KCSAN_ACCESS_ATOMIC 0x2
+#define KCSAN_ACCESS_ASSERT 0x4
+#define KCSAN_ACCESS_SCOPED 0x8
+
+/*
+ * __kcsan_*: Always calls into the runtime when KCSAN is enabled. This may be used
+ * even in compilation units that selectively disable KCSAN, but must use KCSAN
+ * to validate access to an address. Never use these in header files!
+ */
+#ifdef CONFIG_KCSAN
+/**
+ * __kcsan_check_access - check generic access for races
+ *
+ * @ptr: address of access
+ * @size: size of access
+ * @type: access type modifier
+ */
+void __kcsan_check_access(const volatile void *ptr, size_t size, int type);
+
+/**
+ * kcsan_disable_current - disable KCSAN for the current context
+ *
+ * Supports nesting.
+ */
+void kcsan_disable_current(void);
+
+/**
+ * kcsan_enable_current - re-enable KCSAN for the current context
+ *
+ * Supports nesting.
+ */
+void kcsan_enable_current(void);
+void kcsan_enable_current_nowarn(void); /* Safe in uaccess regions. */
+
+/**
+ * kcsan_nestable_atomic_begin - begin nestable atomic region
+ *
+ * Accesses within the atomic region may appear to race with other accesses but
+ * should be considered atomic.
+ */
+void kcsan_nestable_atomic_begin(void);
+
+/**
+ * kcsan_nestable_atomic_end - end nestable atomic region
+ */
+void kcsan_nestable_atomic_end(void);
+
+/**
+ * kcsan_flat_atomic_begin - begin flat atomic region
+ *
+ * Accesses within the atomic region may appear to race with other accesses but
+ * should be considered atomic.
+ */
+void kcsan_flat_atomic_begin(void);
+
+/**
+ * kcsan_flat_atomic_end - end flat atomic region
+ */
+void kcsan_flat_atomic_end(void);
+
+/**
+ * kcsan_atomic_next - consider following accesses as atomic
+ *
+ * Force treating the next n memory accesses for the current context as atomic
+ * operations.
+ *
+ * @n: number of following memory accesses to treat as atomic.
+ */
+void kcsan_atomic_next(int n);
+
+/**
+ * kcsan_set_access_mask - set access mask
+ *
+ * Set the access mask for all accesses for the current context if non-zero.
+ * Only value changes to bits set in the mask will be reported.
+ *
+ * @mask: bitmask
+ */
+void kcsan_set_access_mask(unsigned long mask);
+
+/* Scoped access information. */
+struct kcsan_scoped_access {
+	struct list_head list;
+	const volatile void *ptr;
+	size_t size;
+	int type;
+};
+/*
+ * Automatically call kcsan_end_scoped_access() when kcsan_scoped_access goes
+ * out of scope; relies on attribute "cleanup", which is supported by all
+ * compilers that support KCSAN.
+ */
+#define __kcsan_cleanup_scoped                                                 \
+	__maybe_unused __attribute__((__cleanup__(kcsan_end_scoped_access)))
+
+/**
+ * kcsan_begin_scoped_access - begin scoped access
+ *
+ * Begin scoped access and initialize @sa, which will cause KCSAN to
+ * continuously check the memory range in the current thread until
+ * kcsan_end_scoped_access() is called for @sa.
+ *
+ * Scoped accesses are implemented by appending @sa to an internal list for the
+ * current execution context, and then checked on every call into the KCSAN
+ * runtime.
+ *
+ * @ptr: address of access
+ * @size: size of access
+ * @type: access type modifier
+ * @sa: struct kcsan_scoped_access to use for the scope of the access
+ */
+struct kcsan_scoped_access *
+kcsan_begin_scoped_access(const volatile void *ptr, size_t size, int type,
+			  struct kcsan_scoped_access *sa);
+
+/**
+ * kcsan_end_scoped_access - end scoped access
+ *
+ * End a scoped access, which will stop KCSAN checking the memory range.
+ * Requires that kcsan_begin_scoped_access() was previously called once for @sa.
+ *
+ * @sa: a previously initialized struct kcsan_scoped_access
+ */
+void kcsan_end_scoped_access(struct kcsan_scoped_access *sa);
+
+
+#else /* CONFIG_KCSAN */
+
+static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
+					int type) { }
+
+static inline void kcsan_disable_current(void)		{ }
+static inline void kcsan_enable_current(void)		{ }
+static inline void kcsan_enable_current_nowarn(void)	{ }
+static inline void kcsan_nestable_atomic_begin(void)	{ }
+static inline void kcsan_nestable_atomic_end(void)	{ }
+static inline void kcsan_flat_atomic_begin(void)	{ }
+static inline void kcsan_flat_atomic_end(void)		{ }
+static inline void kcsan_atomic_next(int n)		{ }
+static inline void kcsan_set_access_mask(unsigned long mask) { }
+
+struct kcsan_scoped_access { };
+#define __kcsan_cleanup_scoped __maybe_unused
+static inline struct kcsan_scoped_access *
+kcsan_begin_scoped_access(const volatile void *ptr, size_t size, int type,
+			  struct kcsan_scoped_access *sa) { return sa; }
+static inline void kcsan_end_scoped_access(struct kcsan_scoped_access *sa) { }
+
+#endif /* CONFIG_KCSAN */
+
+#ifdef __SANITIZE_THREAD__
+/*
+ * Only calls into the runtime when the particular compilation unit has KCSAN
+ * instrumentation enabled. May be used in header files.
+ */
+#define kcsan_check_access __kcsan_check_access
+
+/*
+ * Only use these to disable KCSAN for accesses in the current compilation unit;
+ * calls into libraries may still perform KCSAN checks.
+ */
+#define __kcsan_disable_current kcsan_disable_current
+#define __kcsan_enable_current kcsan_enable_current_nowarn
+#else
+static inline void kcsan_check_access(const volatile void *ptr, size_t size,
+				      int type) { }
+static inline void __kcsan_enable_current(void)  { }
+static inline void __kcsan_disable_current(void) { }
+#endif
+
+/**
+ * __kcsan_check_read - check regular read access for races
+ *
+ * @ptr: address of access
+ * @size: size of access
+ */
+#define __kcsan_check_read(ptr, size) __kcsan_check_access(ptr, size, 0)
+
+/**
+ * __kcsan_check_write - check regular write access for races
+ *
+ * @ptr: address of access
+ * @size: size of access
+ */
+#define __kcsan_check_write(ptr, size)                                         \
+	__kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
+
+/**
+ * kcsan_check_read - check regular read access for races
+ *
+ * @ptr: address of access
+ * @size: size of access
+ */
+#define kcsan_check_read(ptr, size) kcsan_check_access(ptr, size, 0)
+
+/**
+ * kcsan_check_write - check regular write access for races
+ *
+ * @ptr: address of access
+ * @size: size of access
+ */
+#define kcsan_check_write(ptr, size)                                           \
+	kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
+
+/*
+ * Check for atomic accesses: if atomic accesses are not ignored, this simply
+ * aliases to kcsan_check_access(), otherwise becomes a no-op.
+ */
+#ifdef CONFIG_KCSAN_IGNORE_ATOMICS
+#define kcsan_check_atomic_read(...)	do { } while (0)
+#define kcsan_check_atomic_write(...)	do { } while (0)
+#else
+#define kcsan_check_atomic_read(ptr, size)                                     \
+	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC)
+#define kcsan_check_atomic_write(ptr, size)                                    \
+	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC | KCSAN_ACCESS_WRITE)
+#endif
+
+/**
+ * ASSERT_EXCLUSIVE_WRITER - assert no concurrent writes to @var
+ *
+ * Assert that there are no concurrent writes to @var; other readers are
+ * allowed. This assertion can be used to specify properties of concurrent code,
+ * where violation cannot be detected as a normal data race.
+ *
+ * For example, if we only have a single writer, but multiple concurrent
+ * readers, to avoid data races, all these accesses must be marked; even
+ * concurrent marked writes racing with the single writer are bugs.
+ * Unfortunately, due to being marked, they are no longer data races. For cases
+ * like these, we can use the macro as follows:
+ *
+ * .. code-block:: c
+ *
+ *	void writer(void) {
+ *		spin_lock(&update_foo_lock);
+ *		ASSERT_EXCLUSIVE_WRITER(shared_foo);
+ *		WRITE_ONCE(shared_foo, ...);
+ *		spin_unlock(&update_foo_lock);
+ *	}
+ *	void reader(void) {
+ *		// update_foo_lock does not need to be held!
+ *		... = READ_ONCE(shared_foo);
+ *	}
+ *
+ * Note: ASSERT_EXCLUSIVE_WRITER_SCOPED(), if applicable, performs more thorough
+ * checking if a clear scope where no concurrent writes are expected exists.
+ *
+ * @var: variable to assert on
+ */
+#define ASSERT_EXCLUSIVE_WRITER(var)                                           \
+	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_ASSERT)
+
+/*
+ * Helper macros for implementation of for ASSERT_EXCLUSIVE_*_SCOPED(). @id is
+ * expected to be unique for the scope in which instances of kcsan_scoped_access
+ * are declared.
+ */
+#define __kcsan_scoped_name(c, suffix) __kcsan_scoped_##c##suffix
+#define __ASSERT_EXCLUSIVE_SCOPED(var, type, id)                               \
+	struct kcsan_scoped_access __kcsan_scoped_name(id, _)                  \
+		__kcsan_cleanup_scoped;                                        \
+	struct kcsan_scoped_access *__kcsan_scoped_name(id, _dummy_p)          \
+		__maybe_unused = kcsan_begin_scoped_access(                    \
+			&(var), sizeof(var), KCSAN_ACCESS_SCOPED | (type),     \
+			&__kcsan_scoped_name(id, _))
+
+/**
+ * ASSERT_EXCLUSIVE_WRITER_SCOPED - assert no concurrent writes to @var in scope
+ *
+ * Scoped variant of ASSERT_EXCLUSIVE_WRITER().
+ *
+ * Assert that there are no concurrent writes to @var for the duration of the
+ * scope in which it is introduced. This provides a better way to fully cover
+ * the enclosing scope, compared to multiple ASSERT_EXCLUSIVE_WRITER(), and
+ * increases the likelihood for KCSAN to detect racing accesses.
+ *
+ * For example, it allows finding race-condition bugs that only occur due to
+ * state changes within the scope itself:
+ *
+ * .. code-block:: c
+ *
+ *	void writer(void) {
+ *		spin_lock(&update_foo_lock);
+ *		{
+ *			ASSERT_EXCLUSIVE_WRITER_SCOPED(shared_foo);
+ *			WRITE_ONCE(shared_foo, 42);
+ *			...
+ *			// shared_foo should still be 42 here!
+ *		}
+ *		spin_unlock(&update_foo_lock);
+ *	}
+ *	void buggy(void) {
+ *		if (READ_ONCE(shared_foo) == 42)
+ *			WRITE_ONCE(shared_foo, 1); // bug!
+ *	}
+ *
+ * @var: variable to assert on
+ */
+#define ASSERT_EXCLUSIVE_WRITER_SCOPED(var)                                    \
+	__ASSERT_EXCLUSIVE_SCOPED(var, KCSAN_ACCESS_ASSERT, __COUNTER__)
+
+/**
+ * ASSERT_EXCLUSIVE_ACCESS - assert no concurrent accesses to @var
+ *
+ * Assert that there are no concurrent accesses to @var (no readers nor
+ * writers). This assertion can be used to specify properties of concurrent
+ * code, where violation cannot be detected as a normal data race.
+ *
+ * For example, where exclusive access is expected after determining no other
+ * users of an object are left, but the object is not actually freed. We can
+ * check that this property actually holds as follows:
+ *
+ * .. code-block:: c
+ *
+ *	if (refcount_dec_and_test(&obj->refcnt)) {
+ *		ASSERT_EXCLUSIVE_ACCESS(*obj);
+ *		do_some_cleanup(obj);
+ *		release_for_reuse(obj);
+ *	}
+ *
+ * Note: ASSERT_EXCLUSIVE_ACCESS_SCOPED(), if applicable, performs more thorough
+ * checking if a clear scope where no concurrent accesses are expected exists.
+ *
+ * Note: For cases where the object is freed, `KASAN <kasan.html>`_ is a better
+ * fit to detect use-after-free bugs.
+ *
+ * @var: variable to assert on
+ */
+#define ASSERT_EXCLUSIVE_ACCESS(var)                                           \
+	__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT)
+
+/**
+ * ASSERT_EXCLUSIVE_ACCESS_SCOPED - assert no concurrent accesses to @var in scope
+ *
+ * Scoped variant of ASSERT_EXCLUSIVE_ACCESS().
+ *
+ * Assert that there are no concurrent accesses to @var (no readers nor writers)
+ * for the entire duration of the scope in which it is introduced. This provides
+ * a better way to fully cover the enclosing scope, compared to multiple
+ * ASSERT_EXCLUSIVE_ACCESS(), and increases the likelihood for KCSAN to detect
+ * racing accesses.
+ *
+ * @var: variable to assert on
+ */
+#define ASSERT_EXCLUSIVE_ACCESS_SCOPED(var)                                    \
+	__ASSERT_EXCLUSIVE_SCOPED(var, KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT, __COUNTER__)
+
+/**
+ * ASSERT_EXCLUSIVE_BITS - assert no concurrent writes to subset of bits in @var
+ *
+ * Bit-granular variant of ASSERT_EXCLUSIVE_WRITER().
+ *
+ * Assert that there are no concurrent writes to a subset of bits in @var;
+ * concurrent readers are permitted. This assertion captures more detailed
+ * bit-level properties, compared to the other (word granularity) assertions.
+ * Only the bits set in @mask are checked for concurrent modifications, while
+ * ignoring the remaining bits, i.e. concurrent writes (or reads) to ~mask bits
+ * are ignored.
+ *
+ * Use this for variables, where some bits must not be modified concurrently,
+ * yet other bits are expected to be modified concurrently.
+ *
+ * For example, variables where, after initialization, some bits are read-only,
+ * but other bits may still be modified concurrently. A reader may wish to
+ * assert that this is true as follows:
+ *
+ * .. code-block:: c
+ *
+ *	ASSERT_EXCLUSIVE_BITS(flags, READ_ONLY_MASK);
+ *	foo = (READ_ONCE(flags) & READ_ONLY_MASK) >> READ_ONLY_SHIFT;
+ *
+ * Note: The access that immediately follows ASSERT_EXCLUSIVE_BITS() is assumed
+ * to access the masked bits only, and KCSAN optimistically assumes it is
+ * therefore safe, even in the presence of data races, and marking it with
+ * READ_ONCE() is optional from KCSAN's point-of-view. We caution, however, that
+ * it may still be advisable to do so, since we cannot reason about all compiler
+ * optimizations when it comes to bit manipulations (on the reader and writer
+ * side). If you are sure nothing can go wrong, we can write the above simply
+ * as:
+ *
+ * .. code-block:: c
+ *
+ *	ASSERT_EXCLUSIVE_BITS(flags, READ_ONLY_MASK);
+ *	foo = (flags & READ_ONLY_MASK) >> READ_ONLY_SHIFT;
+ *
+ * Another example, where this may be used, is when certain bits of @var may
+ * only be modified when holding the appropriate lock, but other bits may still
+ * be modified concurrently. Writers, where other bits may change concurrently,
+ * could use the assertion as follows:
+ *
+ * .. code-block:: c
+ *
+ *	spin_lock(&foo_lock);
+ *	ASSERT_EXCLUSIVE_BITS(flags, FOO_MASK);
+ *	old_flags = flags;
+ *	new_flags = (old_flags & ~FOO_MASK) | (new_foo << FOO_SHIFT);
+ *	if (cmpxchg(&flags, old_flags, new_flags) != old_flags) { ... }
+ *	spin_unlock(&foo_lock);
+ *
+ * @var: variable to assert on
+ * @mask: only check for modifications to bits set in @mask
+ */
+#define ASSERT_EXCLUSIVE_BITS(var, mask)                                       \
+	do {                                                                   \
+		kcsan_set_access_mask(mask);                                   \
+		__kcsan_check_access(&(var), sizeof(var), KCSAN_ACCESS_ASSERT);\
+		kcsan_set_access_mask(0);                                      \
+		kcsan_atomic_next(1);                                          \
+	} while (0)
+
+#endif /* _LINUX_KCSAN_CHECKS_H */
diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
new file mode 100644
index 000000000000..53340d8789f9
--- /dev/null
+++ b/include/linux/kcsan.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_KCSAN_H
+#define _LINUX_KCSAN_H
+
+#include <linux/kcsan-checks.h>
+#include <linux/types.h>
+
+#ifdef CONFIG_KCSAN
+
+/*
+ * Context for each thread of execution: for tasks, this is stored in
+ * task_struct, and interrupts access internal per-CPU storage.
+ */
+struct kcsan_ctx {
+	int disable_count; /* disable counter */
+	int atomic_next; /* number of following atomic ops */
+
+	/*
+	 * We distinguish between: (a) nestable atomic regions that may contain
+	 * other nestable regions; and (b) flat atomic regions that do not keep
+	 * track of nesting. Both (a) and (b) are entirely independent of each
+	 * other, and a flat region may be started in a nestable region or
+	 * vice-versa.
+	 *
+	 * This is required because, for example, in the annotations for
+	 * seqlocks, we declare seqlock writer critical sections as (a) nestable
+	 * atomic regions, but reader critical sections as (b) flat atomic
+	 * regions, but have encountered cases where seqlock reader critical
+	 * sections are contained within writer critical sections (the opposite
+	 * may be possible, too).
+	 *
+	 * To support these cases, we independently track the depth of nesting
+	 * for (a), and whether the leaf level is flat for (b).
+	 */
+	int atomic_nest_count;
+	bool in_flat_atomic;
+
+	/*
+	 * Access mask for all accesses if non-zero.
+	 */
+	unsigned long access_mask;
+
+	/* List of scoped accesses. */
+	struct list_head scoped_accesses;
+};
+
+/**
+ * kcsan_init - initialize KCSAN runtime
+ */
+void kcsan_init(void);
+
+#else /* CONFIG_KCSAN */
+
+static inline void kcsan_init(void)			{ }
+
+#endif /* CONFIG_KCSAN */
+
+#endif /* _LINUX_KCSAN_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c5d96e3e7fff..4ea612e9ad27 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -31,6 +31,7 @@
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers.h>
 #include <linux/rseq.h>
+#include <linux/kcsan.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -1197,6 +1198,9 @@ struct task_struct {
 #ifdef CONFIG_KASAN
 	unsigned int			kasan_depth;
 #endif
+#ifdef CONFIG_KCSAN
+	struct kcsan_ctx		kcsan_ctx;
+#endif
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/* Index of current stored address in ret_stack: */
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 0491d963d47e..8b97204f35a7 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -37,8 +37,24 @@
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
 #include <linux/compiler.h>
+#include <linux/kcsan-checks.h>
 #include <asm/processor.h>
 
+/*
+ * The seqlock interface does not prescribe a precise sequence of read
+ * begin/retry/end. For readers, typically there is a call to
+ * read_seqcount_begin() and read_seqcount_retry(), however, there are more
+ * esoteric cases which do not follow this pattern.
+ *
+ * As a consequence, we take the following best-effort approach for raw usage
+ * via seqcount_t under KCSAN: upon beginning a seq-reader critical section,
+ * pessimistically mark the next KCSAN_SEQLOCK_REGION_MAX memory accesses as
+ * atomics; if there is a matching read_seqcount_retry() call, no following
+ * memory operations are considered atomic. Usage of seqlocks via seqlock_t
+ * interface is not affected.
+ */
+#define KCSAN_SEQLOCK_REGION_MAX 1000
+
 /*
  * Version using sequence counter only.
  * This can be used when code has its own mutex protecting the
@@ -115,6 +131,7 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
 		cpu_relax();
 		goto repeat;
 	}
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
 	return ret;
 }
 
@@ -131,6 +148,7 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
 	return ret;
 }
 
@@ -183,6 +201,7 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
 	return ret & ~1;
 }
 
@@ -202,7 +221,8 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
  */
 static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
-	return unlikely(s->sequence != start);
+	kcsan_atomic_next(0);
+	return unlikely(READ_ONCE(s->sequence) != start);
 }
 
 /**
@@ -225,6 +245,7 @@ static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
 
 static inline void raw_write_seqcount_begin(seqcount_t *s)
 {
+	kcsan_nestable_atomic_begin();
 	s->sequence++;
 	smp_wmb();
 }
@@ -233,6 +254,7 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence++;
+	kcsan_nestable_atomic_end();
 }
 
 /**
@@ -243,6 +265,13 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  * usual consistency guarantee. It is one wmb cheaper, because we can
  * collapse the two back-to-back wmb()s.
  *
+ * Note that writes surrounding the barrier should be declared atomic (e.g.
+ * via WRITE_ONCE): a) to ensure the writes become visible to other threads
+ * atomically, avoiding compiler optimizations; b) to document which writes are
+ * meant to propagate to the reader critical section. This is necessary because
+ * neither writes before and after the barrier are enclosed in a seq-writer
+ * critical section that would ensure readers are aware of ongoing writes.
+ *
  *      seqcount_t seq;
  *      bool X = true, Y = false;
  *
@@ -262,18 +291,20 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  *
  *      void write(void)
  *      {
- *              Y = true;
+ *              WRITE_ONCE(Y, true);
  *
  *              raw_write_seqcount_barrier(seq);
  *
- *              X = false;
+ *              WRITE_ONCE(X, false);
  *      }
  */
 static inline void raw_write_seqcount_barrier(seqcount_t *s)
 {
+	kcsan_nestable_atomic_begin();
 	s->sequence++;
 	smp_wmb();
 	s->sequence++;
+	kcsan_nestable_atomic_end();
 }
 
 static inline int raw_read_seqcount_latch(seqcount_t *s)
@@ -398,7 +429,9 @@ static inline void write_seqcount_end(seqcount_t *s)
 static inline void write_seqcount_invalidate(seqcount_t *s)
 {
 	smp_wmb();
+	kcsan_nestable_atomic_begin();
 	s->sequence+=2;
+	kcsan_nestable_atomic_end();
 }
 
 typedef struct {
@@ -430,11 +463,21 @@ typedef struct {
  */
 static inline unsigned read_seqbegin(const seqlock_t *sl)
 {
-	return read_seqcount_begin(&sl->seqcount);
+	unsigned ret = read_seqcount_begin(&sl->seqcount);
+
+	kcsan_atomic_next(0);  /* non-raw usage, assume closing read_seqretry() */
+	kcsan_flat_atomic_begin();
+	return ret;
 }
 
 static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 {
+	/*
+	 * Assume not nested: read_seqretry() may be called multiple times when
+	 * completing read critical section.
+	 */
+	kcsan_flat_atomic_end();
+
 	return read_seqcount_retry(&sl->seqcount, start);
 }
 
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index dac1db05bf7e..7bcadca22100 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -2,9 +2,9 @@
 #ifndef __LINUX_UACCESS_H__
 #define __LINUX_UACCESS_H__
 
+#include <linux/instrumented.h>
 #include <linux/sched.h>
 #include <linux/thread_info.h>
-#include <linux/kasan-checks.h>
 
 #define uaccess_kernel() segment_eq(get_fs(), KERNEL_DS)
 
@@ -58,7 +58,7 @@
 static __always_inline __must_check unsigned long
 __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 {
-	kasan_check_write(to, n);
+	instrument_copy_from_user(to, from, n);
 	check_object_size(to, n, false);
 	return raw_copy_from_user(to, from, n);
 }
@@ -67,7 +67,7 @@ static __always_inline __must_check unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
 	might_fault();
-	kasan_check_write(to, n);
+	instrument_copy_from_user(to, from, n);
 	check_object_size(to, n, false);
 	return raw_copy_from_user(to, from, n);
 }
@@ -88,7 +88,7 @@ __copy_from_user(void *to, const void __user *from, unsigned long n)
 static __always_inline __must_check unsigned long
 __copy_to_user_inatomic(void __user *to, const void *from, unsigned long n)
 {
-	kasan_check_read(from, n);
+	instrument_copy_to_user(to, from, n);
 	check_object_size(from, n, true);
 	return raw_copy_to_user(to, from, n);
 }
@@ -97,7 +97,7 @@ static __always_inline __must_check unsigned long
 __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
-	kasan_check_read(from, n);
+	instrument_copy_to_user(to, from, n);
 	check_object_size(from, n, true);
 	return raw_copy_to_user(to, from, n);
 }
@@ -109,7 +109,7 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
 	unsigned long res = n;
 	might_fault();
 	if (likely(access_ok(from, n))) {
-		kasan_check_write(to, n);
+		instrument_copy_from_user(to, from, n);
 		res = raw_copy_from_user(to, from, n);
 	}
 	if (unlikely(res))
@@ -127,7 +127,7 @@ _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
 	if (access_ok(to, n)) {
-		kasan_check_read(from, n);
+		instrument_copy_to_user(to, from, n);
 		n = raw_copy_to_user(to, from, n);
 	}
 	return n;
diff --git a/init/init_task.c b/init/init_task.c
index a90ac70cc515..15089d15010a 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -174,6 +174,16 @@ struct task_struct init_task
 #ifdef CONFIG_KASAN
 	.kasan_depth	= 1,
 #endif
+#ifdef CONFIG_KCSAN
+	.kcsan_ctx = {
+		.disable_count		= 0,
+		.atomic_next		= 0,
+		.atomic_nest_count	= 0,
+		.in_flat_atomic		= false,
+		.access_mask		= 0,
+		.scoped_accesses	= {LIST_POISON1, NULL},
+	},
+#endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	.softirqs_enabled = 1,
 #endif
diff --git a/init/main.c b/init/main.c
index b59e09353881..0ead83e86b5a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -95,6 +95,7 @@
 #include <linux/rodata_test.h>
 #include <linux/jump_label.h>
 #include <linux/mem_encrypt.h>
+#include <linux/kcsan.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -1036,6 +1037,7 @@ asmlinkage __visible void __init start_kernel(void)
 	acpi_subsystem_init();
 	arch_post_acpi_subsys_init();
 	sfi_init_late();
+	kcsan_init();
 
 	/* Do the rest non-__init'ed, we're now alive */
 	arch_call_rest_init();
diff --git a/kernel/Makefile b/kernel/Makefile
index c332eb9d4841..ce8716a04d0e 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -23,6 +23,9 @@ endif
 # Prevents flicker of uninteresting __do_softirq()/__local_bh_disable_ip()
 # in coverage traces.
 KCOV_INSTRUMENT_softirq.o := n
+# Avoid KCSAN instrumentation in softirq ("No shared variables, all the data
+# are CPU local" => assume no data races), to reduce overhead in interrupts.
+KCSAN_SANITIZE_softirq.o = n
 # These are called from save_stack_trace() on slub debug path,
 # and produce insane amounts of uninteresting coverage.
 KCOV_INSTRUMENT_module.o := n
@@ -31,6 +34,7 @@ KCOV_INSTRUMENT_stacktrace.o := n
 # Don't self-instrument.
 KCOV_INSTRUMENT_kcov.o := n
 KASAN_SANITIZE_kcov.o := n
+KCSAN_SANITIZE_kcov.o := n
 CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 
 # cond_syscall is currently not LTO compatible
@@ -103,6 +107,7 @@ obj-$(CONFIG_TRACEPOINTS) += trace/
 obj-$(CONFIG_IRQ_WORK) += irq_work.o
 obj-$(CONFIG_CPU_PM) += cpu_pm.o
 obj-$(CONFIG_BPF) += bpf/
+obj-$(CONFIG_KCSAN) += kcsan/
 obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
@@ -121,6 +126,7 @@ obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
+KCSAN_SANITIZE_stackleak.o := n
 KCOV_INSTRUMENT_stackleak.o := n
 
 $(obj)/configs.o: $(obj)/config_data.gz
diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
new file mode 100644
index 000000000000..d4999b38d1be
--- /dev/null
+++ b/kernel/kcsan/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+KCSAN_SANITIZE := n
+KCOV_INSTRUMENT := n
+UBSAN_SANITIZE := n
+
+CFLAGS_REMOVE_core.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_debugfs.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
+
+CFLAGS_core.o := $(call cc-option,-fno-conserve-stack,) \
+	$(call cc-option,-fno-stack-protector,)
+
+obj-y := core.o debugfs.o report.o
+obj-$(CONFIG_KCSAN_SELFTEST) += test.o
diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
new file mode 100644
index 000000000000..be9e625227f3
--- /dev/null
+++ b/kernel/kcsan/atomic.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _KERNEL_KCSAN_ATOMIC_H
+#define _KERNEL_KCSAN_ATOMIC_H
+
+#include <linux/jiffies.h>
+#include <linux/sched.h>
+
+/*
+ * Special rules for certain memory where concurrent conflicting accesses are
+ * common, however, the current convention is to not mark them; returns true if
+ * access to @ptr should be considered atomic. Called from slow-path.
+ */
+static bool kcsan_is_atomic_special(const volatile void *ptr)
+{
+	/* volatile globals that have been observed in data races. */
+	return ptr == &jiffies || ptr == &current->state;
+}
+
+#endif /* _KERNEL_KCSAN_ATOMIC_H */
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
new file mode 100644
index 000000000000..15f67949d11e
--- /dev/null
+++ b/kernel/kcsan/core.c
@@ -0,0 +1,850 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/atomic.h>
+#include <linux/bug.h>
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/moduleparam.h>
+#include <linux/percpu.h>
+#include <linux/preempt.h>
+#include <linux/random.h>
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+
+#include "atomic.h"
+#include "encoding.h"
+#include "kcsan.h"
+
+static bool kcsan_early_enable = IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE);
+unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
+unsigned int kcsan_udelay_interrupt = CONFIG_KCSAN_UDELAY_INTERRUPT;
+static long kcsan_skip_watch = CONFIG_KCSAN_SKIP_WATCH;
+static bool kcsan_interrupt_watcher = IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER);
+
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "kcsan."
+module_param_named(early_enable, kcsan_early_enable, bool, 0);
+module_param_named(udelay_task, kcsan_udelay_task, uint, 0644);
+module_param_named(udelay_interrupt, kcsan_udelay_interrupt, uint, 0644);
+module_param_named(skip_watch, kcsan_skip_watch, long, 0644);
+module_param_named(interrupt_watcher, kcsan_interrupt_watcher, bool, 0444);
+
+bool kcsan_enabled;
+
+/* Per-CPU kcsan_ctx for interrupts */
+static DEFINE_PER_CPU(struct kcsan_ctx, kcsan_cpu_ctx) = {
+	.disable_count		= 0,
+	.atomic_next		= 0,
+	.atomic_nest_count	= 0,
+	.in_flat_atomic		= false,
+	.access_mask		= 0,
+	.scoped_accesses	= {LIST_POISON1, NULL},
+};
+
+/*
+ * Helper macros to index into adjacent slots, starting from address slot
+ * itself, followed by the right and left slots.
+ *
+ * The purpose is 2-fold:
+ *
+ *	1. if during insertion the address slot is already occupied, check if
+ *	   any adjacent slots are free;
+ *	2. accesses that straddle a slot boundary due to size that exceeds a
+ *	   slot's range may check adjacent slots if any watchpoint matches.
+ *
+ * Note that accesses with very large size may still miss a watchpoint; however,
+ * given this should be rare, this is a reasonable trade-off to make, since this
+ * will avoid:
+ *
+ *	1. excessive contention between watchpoint checks and setup;
+ *	2. larger number of simultaneous watchpoints without sacrificing
+ *	   performance.
+ *
+ * Example: SLOT_IDX values for KCSAN_CHECK_ADJACENT=1, where i is [0, 1, 2]:
+ *
+ *   slot=0:  [ 1,  2,  0]
+ *   slot=9:  [10, 11,  9]
+ *   slot=63: [64, 65, 63]
+ */
+#define SLOT_IDX(slot, i) (slot + ((i + KCSAN_CHECK_ADJACENT) % NUM_SLOTS))
+
+/*
+ * SLOT_IDX_FAST is used in the fast-path. Not first checking the address's primary
+ * slot (middle) is fine if we assume that races occur rarely. The set of
+ * indices {SLOT_IDX(slot, i) | i in [0, NUM_SLOTS)} is equivalent to
+ * {SLOT_IDX_FAST(slot, i) | i in [0, NUM_SLOTS)}.
+ */
+#define SLOT_IDX_FAST(slot, i) (slot + i)
+
+/*
+ * Watchpoints, with each entry encoded as defined in encoding.h: in order to be
+ * able to safely update and access a watchpoint without introducing locking
+ * overhead, we encode each watchpoint as a single atomic long. The initial
+ * zero-initialized state matches INVALID_WATCHPOINT.
+ *
+ * Add NUM_SLOTS-1 entries to account for overflow; this helps avoid having to
+ * use more complicated SLOT_IDX_FAST calculation with modulo in the fast-path.
+ */
+static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
+
+/*
+ * Instructions to skip watching counter, used in should_watch(). We use a
+ * per-CPU counter to avoid excessive contention.
+ */
+static DEFINE_PER_CPU(long, kcsan_skip);
+
+static __always_inline atomic_long_t *find_watchpoint(unsigned long addr,
+						      size_t size,
+						      bool expect_write,
+						      long *encoded_watchpoint)
+{
+	const int slot = watchpoint_slot(addr);
+	const unsigned long addr_masked = addr & WATCHPOINT_ADDR_MASK;
+	atomic_long_t *watchpoint;
+	unsigned long wp_addr_masked;
+	size_t wp_size;
+	bool is_write;
+	int i;
+
+	BUILD_BUG_ON(CONFIG_KCSAN_NUM_WATCHPOINTS < NUM_SLOTS);
+
+	for (i = 0; i < NUM_SLOTS; ++i) {
+		watchpoint = &watchpoints[SLOT_IDX_FAST(slot, i)];
+		*encoded_watchpoint = atomic_long_read(watchpoint);
+		if (!decode_watchpoint(*encoded_watchpoint, &wp_addr_masked,
+				       &wp_size, &is_write))
+			continue;
+
+		if (expect_write && !is_write)
+			continue;
+
+		/* Check if the watchpoint matches the access. */
+		if (matching_access(wp_addr_masked, wp_size, addr_masked, size))
+			return watchpoint;
+	}
+
+	return NULL;
+}
+
+static inline atomic_long_t *
+insert_watchpoint(unsigned long addr, size_t size, bool is_write)
+{
+	const int slot = watchpoint_slot(addr);
+	const long encoded_watchpoint = encode_watchpoint(addr, size, is_write);
+	atomic_long_t *watchpoint;
+	int i;
+
+	/* Check slot index logic, ensuring we stay within array bounds. */
+	BUILD_BUG_ON(SLOT_IDX(0, 0) != KCSAN_CHECK_ADJACENT);
+	BUILD_BUG_ON(SLOT_IDX(0, KCSAN_CHECK_ADJACENT+1) != 0);
+	BUILD_BUG_ON(SLOT_IDX(CONFIG_KCSAN_NUM_WATCHPOINTS-1, KCSAN_CHECK_ADJACENT) != ARRAY_SIZE(watchpoints)-1);
+	BUILD_BUG_ON(SLOT_IDX(CONFIG_KCSAN_NUM_WATCHPOINTS-1, KCSAN_CHECK_ADJACENT+1) != ARRAY_SIZE(watchpoints) - NUM_SLOTS);
+
+	for (i = 0; i < NUM_SLOTS; ++i) {
+		long expect_val = INVALID_WATCHPOINT;
+
+		/* Try to acquire this slot. */
+		watchpoint = &watchpoints[SLOT_IDX(slot, i)];
+		if (atomic_long_try_cmpxchg_relaxed(watchpoint, &expect_val, encoded_watchpoint))
+			return watchpoint;
+	}
+
+	return NULL;
+}
+
+/*
+ * Return true if watchpoint was successfully consumed, false otherwise.
+ *
+ * This may return false if:
+ *
+ *	1. another thread already consumed the watchpoint;
+ *	2. the thread that set up the watchpoint already removed it;
+ *	3. the watchpoint was removed and then re-used.
+ */
+static __always_inline bool
+try_consume_watchpoint(atomic_long_t *watchpoint, long encoded_watchpoint)
+{
+	return atomic_long_try_cmpxchg_relaxed(watchpoint, &encoded_watchpoint, CONSUMED_WATCHPOINT);
+}
+
+/* Return true if watchpoint was not touched, false if already consumed. */
+static inline bool consume_watchpoint(atomic_long_t *watchpoint)
+{
+	return atomic_long_xchg_relaxed(watchpoint, CONSUMED_WATCHPOINT) != CONSUMED_WATCHPOINT;
+}
+
+/* Remove the watchpoint -- its slot may be reused after. */
+static inline void remove_watchpoint(atomic_long_t *watchpoint)
+{
+	atomic_long_set(watchpoint, INVALID_WATCHPOINT);
+}
+
+static __always_inline struct kcsan_ctx *get_ctx(void)
+{
+	/*
+	 * In interrupts, use raw_cpu_ptr to avoid unnecessary checks, that would
+	 * also result in calls that generate warnings in uaccess regions.
+	 */
+	return in_task() ? &current->kcsan_ctx : raw_cpu_ptr(&kcsan_cpu_ctx);
+}
+
+/* Check scoped accesses; never inline because this is a slow-path! */
+static noinline void kcsan_check_scoped_accesses(void)
+{
+	struct kcsan_ctx *ctx = get_ctx();
+	struct list_head *prev_save = ctx->scoped_accesses.prev;
+	struct kcsan_scoped_access *scoped_access;
+
+	ctx->scoped_accesses.prev = NULL;  /* Avoid recursion. */
+	list_for_each_entry(scoped_access, &ctx->scoped_accesses, list)
+		__kcsan_check_access(scoped_access->ptr, scoped_access->size, scoped_access->type);
+	ctx->scoped_accesses.prev = prev_save;
+}
+
+/* Rules for generic atomic accesses. Called from fast-path. */
+static __always_inline bool
+is_atomic(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *ctx)
+{
+	if (type & KCSAN_ACCESS_ATOMIC)
+		return true;
+
+	/*
+	 * Unless explicitly declared atomic, never consider an assertion access
+	 * as atomic. This allows using them also in atomic regions, such as
+	 * seqlocks, without implicitly changing their semantics.
+	 */
+	if (type & KCSAN_ACCESS_ASSERT)
+		return false;
+
+	if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) &&
+	    (type & KCSAN_ACCESS_WRITE) && size <= sizeof(long) &&
+	    IS_ALIGNED((unsigned long)ptr, size))
+		return true; /* Assume aligned writes up to word size are atomic. */
+
+	if (ctx->atomic_next > 0) {
+		/*
+		 * Because we do not have separate contexts for nested
+		 * interrupts, in case atomic_next is set, we simply assume that
+		 * the outer interrupt set atomic_next. In the worst case, we
+		 * will conservatively consider operations as atomic. This is a
+		 * reasonable trade-off to make, since this case should be
+		 * extremely rare; however, even if extremely rare, it could
+		 * lead to false positives otherwise.
+		 */
+		if ((hardirq_count() >> HARDIRQ_SHIFT) < 2)
+			--ctx->atomic_next; /* in task, or outer interrupt */
+		return true;
+	}
+
+	return ctx->atomic_nest_count > 0 || ctx->in_flat_atomic;
+}
+
+static __always_inline bool
+should_watch(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *ctx)
+{
+	/*
+	 * Never set up watchpoints when memory operations are atomic.
+	 *
+	 * Need to check this first, before kcsan_skip check below: (1) atomics
+	 * should not count towards skipped instructions, and (2) to actually
+	 * decrement kcsan_atomic_next for consecutive instruction stream.
+	 */
+	if (is_atomic(ptr, size, type, ctx))
+		return false;
+
+	if (this_cpu_dec_return(kcsan_skip) >= 0)
+		return false;
+
+	/*
+	 * NOTE: If we get here, kcsan_skip must always be reset in slow path
+	 * via reset_kcsan_skip() to avoid underflow.
+	 */
+
+	/* this operation should be watched */
+	return true;
+}
+
+static inline void reset_kcsan_skip(void)
+{
+	long skip_count = kcsan_skip_watch -
+			  (IS_ENABLED(CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE) ?
+				   prandom_u32_max(kcsan_skip_watch) :
+				   0);
+	this_cpu_write(kcsan_skip, skip_count);
+}
+
+static __always_inline bool kcsan_is_enabled(void)
+{
+	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
+}
+
+static inline unsigned int get_delay(void)
+{
+	unsigned int delay = in_task() ? kcsan_udelay_task : kcsan_udelay_interrupt;
+	return delay - (IS_ENABLED(CONFIG_KCSAN_DELAY_RANDOMIZE) ?
+				prandom_u32_max(delay) :
+				0);
+}
+
+/*
+ * Pull everything together: check_access() below contains the performance
+ * critical operations; the fast-path (including check_access) functions should
+ * all be inlinable by the instrumentation functions.
+ *
+ * The slow-path (kcsan_found_watchpoint, kcsan_setup_watchpoint) are
+ * non-inlinable -- note that, we prefix these with "kcsan_" to ensure they can
+ * be filtered from the stacktrace, as well as give them unique names for the
+ * UACCESS whitelist of objtool. Each function uses user_access_save/restore(),
+ * since they do not access any user memory, but instrumentation is still
+ * emitted in UACCESS regions.
+ */
+
+static noinline void kcsan_found_watchpoint(const volatile void *ptr,
+					    size_t size,
+					    int type,
+					    atomic_long_t *watchpoint,
+					    long encoded_watchpoint)
+{
+	unsigned long flags;
+	bool consumed;
+
+	if (!kcsan_is_enabled())
+		return;
+
+	/*
+	 * The access_mask check relies on value-change comparison. To avoid
+	 * reporting a race where e.g. the writer set up the watchpoint, but the
+	 * reader has access_mask!=0, we have to ignore the found watchpoint.
+	 */
+	if (get_ctx()->access_mask != 0)
+		return;
+
+	/*
+	 * Consume the watchpoint as soon as possible, to minimize the chances
+	 * of !consumed. Consuming the watchpoint must always be guarded by
+	 * kcsan_is_enabled() check, as otherwise we might erroneously
+	 * triggering reports when disabled.
+	 */
+	consumed = try_consume_watchpoint(watchpoint, encoded_watchpoint);
+
+	/* keep this after try_consume_watchpoint */
+	flags = user_access_save();
+
+	if (consumed) {
+		kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_MAYBE,
+			     KCSAN_REPORT_CONSUMED_WATCHPOINT,
+			     watchpoint - watchpoints);
+	} else {
+		/*
+		 * The other thread may not print any diagnostics, as it has
+		 * already removed the watchpoint, or another thread consumed
+		 * the watchpoint before this thread.
+		 */
+		kcsan_counter_inc(KCSAN_COUNTER_REPORT_RACES);
+	}
+
+	if ((type & KCSAN_ACCESS_ASSERT) != 0)
+		kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
+	else
+		kcsan_counter_inc(KCSAN_COUNTER_DATA_RACES);
+
+	user_access_restore(flags);
+}
+
+static noinline void
+kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
+{
+	const bool is_write = (type & KCSAN_ACCESS_WRITE) != 0;
+	const bool is_assert = (type & KCSAN_ACCESS_ASSERT) != 0;
+	atomic_long_t *watchpoint;
+	union {
+		u8 _1;
+		u16 _2;
+		u32 _4;
+		u64 _8;
+	} expect_value;
+	unsigned long access_mask;
+	enum kcsan_value_change value_change = KCSAN_VALUE_CHANGE_MAYBE;
+	unsigned long ua_flags = user_access_save();
+	unsigned long irq_flags = 0;
+
+	/*
+	 * Always reset kcsan_skip counter in slow-path to avoid underflow; see
+	 * should_watch().
+	 */
+	reset_kcsan_skip();
+
+	if (!kcsan_is_enabled())
+		goto out;
+
+	/*
+	 * Special atomic rules: unlikely to be true, so we check them here in
+	 * the slow-path, and not in the fast-path in is_atomic(). Call after
+	 * kcsan_is_enabled(), as we may access memory that is not yet
+	 * initialized during early boot.
+	 */
+	if (!is_assert && kcsan_is_atomic_special(ptr))
+		goto out;
+
+	if (!check_encodable((unsigned long)ptr, size)) {
+		kcsan_counter_inc(KCSAN_COUNTER_UNENCODABLE_ACCESSES);
+		goto out;
+	}
+
+	if (!kcsan_interrupt_watcher)
+		/* Use raw to avoid lockdep recursion via IRQ flags tracing. */
+		raw_local_irq_save(irq_flags);
+
+	watchpoint = insert_watchpoint((unsigned long)ptr, size, is_write);
+	if (watchpoint == NULL) {
+		/*
+		 * Out of capacity: the size of 'watchpoints', and the frequency
+		 * with which should_watch() returns true should be tweaked so
+		 * that this case happens very rarely.
+		 */
+		kcsan_counter_inc(KCSAN_COUNTER_NO_CAPACITY);
+		goto out_unlock;
+	}
+
+	kcsan_counter_inc(KCSAN_COUNTER_SETUP_WATCHPOINTS);
+	kcsan_counter_inc(KCSAN_COUNTER_USED_WATCHPOINTS);
+
+	/*
+	 * Read the current value, to later check and infer a race if the data
+	 * was modified via a non-instrumented access, e.g. from a device.
+	 */
+	expect_value._8 = 0;
+	switch (size) {
+	case 1:
+		expect_value._1 = READ_ONCE(*(const u8 *)ptr);
+		break;
+	case 2:
+		expect_value._2 = READ_ONCE(*(const u16 *)ptr);
+		break;
+	case 4:
+		expect_value._4 = READ_ONCE(*(const u32 *)ptr);
+		break;
+	case 8:
+		expect_value._8 = READ_ONCE(*(const u64 *)ptr);
+		break;
+	default:
+		break; /* ignore; we do not diff the values */
+	}
+
+	if (IS_ENABLED(CONFIG_KCSAN_DEBUG)) {
+		kcsan_disable_current();
+		pr_err("KCSAN: watching %s, size: %zu, addr: %px [slot: %d, encoded: %lx]\n",
+		       is_write ? "write" : "read", size, ptr,
+		       watchpoint_slot((unsigned long)ptr),
+		       encode_watchpoint((unsigned long)ptr, size, is_write));
+		kcsan_enable_current();
+	}
+
+	/*
+	 * Delay this thread, to increase probability of observing a racy
+	 * conflicting access.
+	 */
+	udelay(get_delay());
+
+	/*
+	 * Re-read value, and check if it is as expected; if not, we infer a
+	 * racy access.
+	 */
+	access_mask = get_ctx()->access_mask;
+	switch (size) {
+	case 1:
+		expect_value._1 ^= READ_ONCE(*(const u8 *)ptr);
+		if (access_mask)
+			expect_value._1 &= (u8)access_mask;
+		break;
+	case 2:
+		expect_value._2 ^= READ_ONCE(*(const u16 *)ptr);
+		if (access_mask)
+			expect_value._2 &= (u16)access_mask;
+		break;
+	case 4:
+		expect_value._4 ^= READ_ONCE(*(const u32 *)ptr);
+		if (access_mask)
+			expect_value._4 &= (u32)access_mask;
+		break;
+	case 8:
+		expect_value._8 ^= READ_ONCE(*(const u64 *)ptr);
+		if (access_mask)
+			expect_value._8 &= (u64)access_mask;
+		break;
+	default:
+		break; /* ignore; we do not diff the values */
+	}
+
+	/* Were we able to observe a value-change? */
+	if (expect_value._8 != 0)
+		value_change = KCSAN_VALUE_CHANGE_TRUE;
+
+	/* Check if this access raced with another. */
+	if (!consume_watchpoint(watchpoint)) {
+		/*
+		 * Depending on the access type, map a value_change of MAYBE to
+		 * TRUE (always report) or FALSE (never report).
+		 */
+		if (value_change == KCSAN_VALUE_CHANGE_MAYBE) {
+			if (access_mask != 0) {
+				/*
+				 * For access with access_mask, we require a
+				 * value-change, as it is likely that races on
+				 * ~access_mask bits are expected.
+				 */
+				value_change = KCSAN_VALUE_CHANGE_FALSE;
+			} else if (size > 8 || is_assert) {
+				/* Always assume a value-change. */
+				value_change = KCSAN_VALUE_CHANGE_TRUE;
+			}
+		}
+
+		/*
+		 * No need to increment 'data_races' counter, as the racing
+		 * thread already did.
+		 *
+		 * Count 'assert_failures' for each failed ASSERT access,
+		 * therefore both this thread and the racing thread may
+		 * increment this counter.
+		 */
+		if (is_assert && value_change == KCSAN_VALUE_CHANGE_TRUE)
+			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
+
+		kcsan_report(ptr, size, type, value_change, KCSAN_REPORT_RACE_SIGNAL,
+			     watchpoint - watchpoints);
+	} else if (value_change == KCSAN_VALUE_CHANGE_TRUE) {
+		/* Inferring a race, since the value should not have changed. */
+
+		kcsan_counter_inc(KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN);
+		if (is_assert)
+			kcsan_counter_inc(KCSAN_COUNTER_ASSERT_FAILURES);
+
+		if (IS_ENABLED(CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN) || is_assert)
+			kcsan_report(ptr, size, type, KCSAN_VALUE_CHANGE_TRUE,
+				     KCSAN_REPORT_RACE_UNKNOWN_ORIGIN,
+				     watchpoint - watchpoints);
+	}
+
+	/*
+	 * Remove watchpoint; must be after reporting, since the slot may be
+	 * reused after this point.
+	 */
+	remove_watchpoint(watchpoint);
+	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
+out_unlock:
+	if (!kcsan_interrupt_watcher)
+		raw_local_irq_restore(irq_flags);
+out:
+	user_access_restore(ua_flags);
+}
+
+static __always_inline void check_access(const volatile void *ptr, size_t size,
+					 int type)
+{
+	const bool is_write = (type & KCSAN_ACCESS_WRITE) != 0;
+	atomic_long_t *watchpoint;
+	long encoded_watchpoint;
+
+	/*
+	 * Do nothing for 0 sized check; this comparison will be optimized out
+	 * for constant sized instrumentation (__tsan_{read,write}N).
+	 */
+	if (unlikely(size == 0))
+		return;
+
+	/*
+	 * Avoid user_access_save in fast-path: find_watchpoint is safe without
+	 * user_access_save, as the address that ptr points to is only used to
+	 * check if a watchpoint exists; ptr is never dereferenced.
+	 */
+	watchpoint = find_watchpoint((unsigned long)ptr, size, !is_write,
+				     &encoded_watchpoint);
+	/*
+	 * It is safe to check kcsan_is_enabled() after find_watchpoint in the
+	 * slow-path, as long as no state changes that cause a race to be
+	 * detected and reported have occurred until kcsan_is_enabled() is
+	 * checked.
+	 */
+
+	if (unlikely(watchpoint != NULL))
+		kcsan_found_watchpoint(ptr, size, type, watchpoint,
+				       encoded_watchpoint);
+	else {
+		struct kcsan_ctx *ctx = get_ctx(); /* Call only once in fast-path. */
+
+		if (unlikely(should_watch(ptr, size, type, ctx)))
+			kcsan_setup_watchpoint(ptr, size, type);
+		else if (unlikely(ctx->scoped_accesses.prev))
+			kcsan_check_scoped_accesses();
+	}
+}
+
+/* === Public interface ===================================================== */
+
+void __init kcsan_init(void)
+{
+	BUG_ON(!in_task());
+
+	kcsan_debugfs_init();
+
+	/*
+	 * We are in the init task, and no other tasks should be running;
+	 * WRITE_ONCE without memory barrier is sufficient.
+	 */
+	if (kcsan_early_enable)
+		WRITE_ONCE(kcsan_enabled, true);
+}
+
+/* === Exported interface =================================================== */
+
+void kcsan_disable_current(void)
+{
+	++get_ctx()->disable_count;
+}
+EXPORT_SYMBOL(kcsan_disable_current);
+
+void kcsan_enable_current(void)
+{
+	if (get_ctx()->disable_count-- == 0) {
+		/*
+		 * Warn if kcsan_enable_current() calls are unbalanced with
+		 * kcsan_disable_current() calls, which causes disable_count to
+		 * become negative and should not happen.
+		 */
+		kcsan_disable_current(); /* restore to 0, KCSAN still enabled */
+		kcsan_disable_current(); /* disable to generate warning */
+		WARN(1, "Unbalanced %s()", __func__);
+		kcsan_enable_current();
+	}
+}
+EXPORT_SYMBOL(kcsan_enable_current);
+
+void kcsan_enable_current_nowarn(void)
+{
+	if (get_ctx()->disable_count-- == 0)
+		kcsan_disable_current();
+}
+EXPORT_SYMBOL(kcsan_enable_current_nowarn);
+
+void kcsan_nestable_atomic_begin(void)
+{
+	/*
+	 * Do *not* check and warn if we are in a flat atomic region: nestable
+	 * and flat atomic regions are independent from each other.
+	 * See include/linux/kcsan.h: struct kcsan_ctx comments for more
+	 * comments.
+	 */
+
+	++get_ctx()->atomic_nest_count;
+}
+EXPORT_SYMBOL(kcsan_nestable_atomic_begin);
+
+void kcsan_nestable_atomic_end(void)
+{
+	if (get_ctx()->atomic_nest_count-- == 0) {
+		/*
+		 * Warn if kcsan_nestable_atomic_end() calls are unbalanced with
+		 * kcsan_nestable_atomic_begin() calls, which causes
+		 * atomic_nest_count to become negative and should not happen.
+		 */
+		kcsan_nestable_atomic_begin(); /* restore to 0 */
+		kcsan_disable_current(); /* disable to generate warning */
+		WARN(1, "Unbalanced %s()", __func__);
+		kcsan_enable_current();
+	}
+}
+EXPORT_SYMBOL(kcsan_nestable_atomic_end);
+
+void kcsan_flat_atomic_begin(void)
+{
+	get_ctx()->in_flat_atomic = true;
+}
+EXPORT_SYMBOL(kcsan_flat_atomic_begin);
+
+void kcsan_flat_atomic_end(void)
+{
+	get_ctx()->in_flat_atomic = false;
+}
+EXPORT_SYMBOL(kcsan_flat_atomic_end);
+
+void kcsan_atomic_next(int n)
+{
+	get_ctx()->atomic_next = n;
+}
+EXPORT_SYMBOL(kcsan_atomic_next);
+
+void kcsan_set_access_mask(unsigned long mask)
+{
+	get_ctx()->access_mask = mask;
+}
+EXPORT_SYMBOL(kcsan_set_access_mask);
+
+struct kcsan_scoped_access *
+kcsan_begin_scoped_access(const volatile void *ptr, size_t size, int type,
+			  struct kcsan_scoped_access *sa)
+{
+	struct kcsan_ctx *ctx = get_ctx();
+
+	__kcsan_check_access(ptr, size, type);
+
+	ctx->disable_count++; /* Disable KCSAN, in case list debugging is on. */
+
+	INIT_LIST_HEAD(&sa->list);
+	sa->ptr = ptr;
+	sa->size = size;
+	sa->type = type;
+
+	if (!ctx->scoped_accesses.prev) /* Lazy initialize list head. */
+		INIT_LIST_HEAD(&ctx->scoped_accesses);
+	list_add(&sa->list, &ctx->scoped_accesses);
+
+	ctx->disable_count--;
+	return sa;
+}
+EXPORT_SYMBOL(kcsan_begin_scoped_access);
+
+void kcsan_end_scoped_access(struct kcsan_scoped_access *sa)
+{
+	struct kcsan_ctx *ctx = get_ctx();
+
+	if (WARN(!ctx->scoped_accesses.prev, "Unbalanced %s()?", __func__))
+		return;
+
+	ctx->disable_count++; /* Disable KCSAN, in case list debugging is on. */
+
+	list_del(&sa->list);
+	if (list_empty(&ctx->scoped_accesses))
+		/*
+		 * Ensure we do not enter kcsan_check_scoped_accesses()
+		 * slow-path if unnecessary, and avoids requiring list_empty()
+		 * in the fast-path (to avoid a READ_ONCE() and potential
+		 * uaccess warning).
+		 */
+		ctx->scoped_accesses.prev = NULL;
+
+	ctx->disable_count--;
+
+	__kcsan_check_access(sa->ptr, sa->size, sa->type);
+}
+EXPORT_SYMBOL(kcsan_end_scoped_access);
+
+void __kcsan_check_access(const volatile void *ptr, size_t size, int type)
+{
+	check_access(ptr, size, type);
+}
+EXPORT_SYMBOL(__kcsan_check_access);
+
+/*
+ * KCSAN uses the same instrumentation that is emitted by supported compilers
+ * for ThreadSanitizer (TSAN).
+ *
+ * When enabled, the compiler emits instrumentation calls (the functions
+ * prefixed with "__tsan" below) for all loads and stores that it generated;
+ * inline asm is not instrumented.
+ *
+ * Note that, not all supported compiler versions distinguish aligned/unaligned
+ * accesses, but e.g. recent versions of Clang do. We simply alias the unaligned
+ * version to the generic version, which can handle both.
+ */
+
+#define DEFINE_TSAN_READ_WRITE(size)                                           \
+	void __tsan_read##size(void *ptr)                                      \
+	{                                                                      \
+		check_access(ptr, size, 0);                                    \
+	}                                                                      \
+	EXPORT_SYMBOL(__tsan_read##size);                                      \
+	void __tsan_unaligned_read##size(void *ptr)                            \
+		__alias(__tsan_read##size);                                    \
+	EXPORT_SYMBOL(__tsan_unaligned_read##size);                            \
+	void __tsan_write##size(void *ptr)                                     \
+	{                                                                      \
+		check_access(ptr, size, KCSAN_ACCESS_WRITE);                   \
+	}                                                                      \
+	EXPORT_SYMBOL(__tsan_write##size);                                     \
+	void __tsan_unaligned_write##size(void *ptr)                           \
+		__alias(__tsan_write##size);                                   \
+	EXPORT_SYMBOL(__tsan_unaligned_write##size)
+
+DEFINE_TSAN_READ_WRITE(1);
+DEFINE_TSAN_READ_WRITE(2);
+DEFINE_TSAN_READ_WRITE(4);
+DEFINE_TSAN_READ_WRITE(8);
+DEFINE_TSAN_READ_WRITE(16);
+
+void __tsan_read_range(void *ptr, size_t size)
+{
+	check_access(ptr, size, 0);
+}
+EXPORT_SYMBOL(__tsan_read_range);
+
+void __tsan_write_range(void *ptr, size_t size)
+{
+	check_access(ptr, size, KCSAN_ACCESS_WRITE);
+}
+EXPORT_SYMBOL(__tsan_write_range);
+
+/*
+ * Use of explicit volatile is generally disallowed [1], however, volatile is
+ * still used in various concurrent context, whether in low-level
+ * synchronization primitives or for legacy reasons.
+ * [1] https://lwn.net/Articles/233479/
+ *
+ * We only consider volatile accesses atomic if they are aligned and would pass
+ * the size-check of compiletime_assert_rwonce_type().
+ */
+#define DEFINE_TSAN_VOLATILE_READ_WRITE(size)                                  \
+	void __tsan_volatile_read##size(void *ptr)                             \
+	{                                                                      \
+		const bool is_atomic = size <= sizeof(long long) &&            \
+				       IS_ALIGNED((unsigned long)ptr, size);   \
+		if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS) && is_atomic)      \
+			return;                                                \
+		check_access(ptr, size, is_atomic ? KCSAN_ACCESS_ATOMIC : 0);  \
+	}                                                                      \
+	EXPORT_SYMBOL(__tsan_volatile_read##size);                             \
+	void __tsan_unaligned_volatile_read##size(void *ptr)                   \
+		__alias(__tsan_volatile_read##size);                           \
+	EXPORT_SYMBOL(__tsan_unaligned_volatile_read##size);                   \
+	void __tsan_volatile_write##size(void *ptr)                            \
+	{                                                                      \
+		const bool is_atomic = size <= sizeof(long long) &&            \
+				       IS_ALIGNED((unsigned long)ptr, size);   \
+		if (IS_ENABLED(CONFIG_KCSAN_IGNORE_ATOMICS) && is_atomic)      \
+			return;                                                \
+		check_access(ptr, size,                                        \
+			     KCSAN_ACCESS_WRITE |                              \
+				     (is_atomic ? KCSAN_ACCESS_ATOMIC : 0));   \
+	}                                                                      \
+	EXPORT_SYMBOL(__tsan_volatile_write##size);                            \
+	void __tsan_unaligned_volatile_write##size(void *ptr)                  \
+		__alias(__tsan_volatile_write##size);                          \
+	EXPORT_SYMBOL(__tsan_unaligned_volatile_write##size)
+
+DEFINE_TSAN_VOLATILE_READ_WRITE(1);
+DEFINE_TSAN_VOLATILE_READ_WRITE(2);
+DEFINE_TSAN_VOLATILE_READ_WRITE(4);
+DEFINE_TSAN_VOLATILE_READ_WRITE(8);
+DEFINE_TSAN_VOLATILE_READ_WRITE(16);
+
+/*
+ * The below are not required by KCSAN, but can still be emitted by the
+ * compiler.
+ */
+void __tsan_func_entry(void *call_pc)
+{
+}
+EXPORT_SYMBOL(__tsan_func_entry);
+void __tsan_func_exit(void)
+{
+}
+EXPORT_SYMBOL(__tsan_func_exit);
+void __tsan_init(void)
+{
+}
+EXPORT_SYMBOL(__tsan_init);
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
new file mode 100644
index 000000000000..023e49c58d55
--- /dev/null
+++ b/kernel/kcsan/debugfs.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/atomic.h>
+#include <linux/bsearch.h>
+#include <linux/bug.h>
+#include <linux/debugfs.h>
+#include <linux/init.h>
+#include <linux/kallsyms.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/sort.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include "kcsan.h"
+
+/*
+ * Statistics counters.
+ */
+static atomic_long_t counters[KCSAN_COUNTER_COUNT];
+
+/*
+ * Addresses for filtering functions from reporting. This list can be used as a
+ * whitelist or blacklist.
+ */
+static struct {
+	unsigned long	*addrs;		/* array of addresses */
+	size_t		size;		/* current size */
+	int		used;		/* number of elements used */
+	bool		sorted;		/* if elements are sorted */
+	bool		whitelist;	/* if list is a blacklist or whitelist */
+} report_filterlist = {
+	.addrs		= NULL,
+	.size		= 8,		/* small initial size */
+	.used		= 0,
+	.sorted		= false,
+	.whitelist	= false,	/* default is blacklist */
+};
+static DEFINE_SPINLOCK(report_filterlist_lock);
+
+static const char *counter_to_name(enum kcsan_counter_id id)
+{
+	switch (id) {
+	case KCSAN_COUNTER_USED_WATCHPOINTS:		return "used_watchpoints";
+	case KCSAN_COUNTER_SETUP_WATCHPOINTS:		return "setup_watchpoints";
+	case KCSAN_COUNTER_DATA_RACES:			return "data_races";
+	case KCSAN_COUNTER_ASSERT_FAILURES:		return "assert_failures";
+	case KCSAN_COUNTER_NO_CAPACITY:			return "no_capacity";
+	case KCSAN_COUNTER_REPORT_RACES:		return "report_races";
+	case KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN:	return "races_unknown_origin";
+	case KCSAN_COUNTER_UNENCODABLE_ACCESSES:	return "unencodable_accesses";
+	case KCSAN_COUNTER_ENCODING_FALSE_POSITIVES:	return "encoding_false_positives";
+	case KCSAN_COUNTER_COUNT:
+		BUG();
+	}
+	return NULL;
+}
+
+void kcsan_counter_inc(enum kcsan_counter_id id)
+{
+	atomic_long_inc(&counters[id]);
+}
+
+void kcsan_counter_dec(enum kcsan_counter_id id)
+{
+	atomic_long_dec(&counters[id]);
+}
+
+/*
+ * The microbenchmark allows benchmarking KCSAN core runtime only. To run
+ * multiple threads, pipe 'microbench=<iters>' from multiple tasks into the
+ * debugfs file. This will not generate any conflicts, and tests fast-path only.
+ */
+static noinline void microbenchmark(unsigned long iters)
+{
+	const struct kcsan_ctx ctx_save = current->kcsan_ctx;
+	const bool was_enabled = READ_ONCE(kcsan_enabled);
+	cycles_t cycles;
+
+	/* We may have been called from an atomic region; reset context. */
+	memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
+	/*
+	 * Disable to benchmark fast-path for all accesses, and (expected
+	 * negligible) call into slow-path, but never set up watchpoints.
+	 */
+	WRITE_ONCE(kcsan_enabled, false);
+
+	pr_info("KCSAN: %s begin | iters: %lu\n", __func__, iters);
+
+	cycles = get_cycles();
+	while (iters--) {
+		unsigned long addr = iters & ((PAGE_SIZE << 8) - 1);
+		int type = !(iters & 0x7f) ? KCSAN_ACCESS_ATOMIC :
+				(!(iters & 0xf) ? KCSAN_ACCESS_WRITE : 0);
+		__kcsan_check_access((void *)addr, sizeof(long), type);
+	}
+	cycles = get_cycles() - cycles;
+
+	pr_info("KCSAN: %s end   | cycles: %llu\n", __func__, cycles);
+
+	WRITE_ONCE(kcsan_enabled, was_enabled);
+	/* restore context */
+	current->kcsan_ctx = ctx_save;
+}
+
+/*
+ * Simple test to create conflicting accesses. Write 'test=<iters>' to KCSAN's
+ * debugfs file from multiple tasks to generate real conflicts and show reports.
+ */
+static long test_dummy;
+static long test_flags;
+static long test_scoped;
+static noinline void test_thread(unsigned long iters)
+{
+	const long CHANGE_BITS = 0xff00ff00ff00ff00L;
+	const struct kcsan_ctx ctx_save = current->kcsan_ctx;
+	cycles_t cycles;
+
+	/* We may have been called from an atomic region; reset context. */
+	memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
+
+	pr_info("KCSAN: %s begin | iters: %lu\n", __func__, iters);
+	pr_info("test_dummy@%px, test_flags@%px, test_scoped@%px,\n",
+		&test_dummy, &test_flags, &test_scoped);
+
+	cycles = get_cycles();
+	while (iters--) {
+		/* These all should generate reports. */
+		__kcsan_check_read(&test_dummy, sizeof(test_dummy));
+		ASSERT_EXCLUSIVE_WRITER(test_dummy);
+		ASSERT_EXCLUSIVE_ACCESS(test_dummy);
+
+		ASSERT_EXCLUSIVE_BITS(test_flags, ~CHANGE_BITS); /* no report */
+		__kcsan_check_read(&test_flags, sizeof(test_flags)); /* no report */
+
+		ASSERT_EXCLUSIVE_BITS(test_flags, CHANGE_BITS); /* report */
+		__kcsan_check_read(&test_flags, sizeof(test_flags)); /* no report */
+
+		/* not actually instrumented */
+		WRITE_ONCE(test_dummy, iters);  /* to observe value-change */
+		__kcsan_check_write(&test_dummy, sizeof(test_dummy));
+
+		test_flags ^= CHANGE_BITS; /* generate value-change */
+		__kcsan_check_write(&test_flags, sizeof(test_flags));
+
+		BUG_ON(current->kcsan_ctx.scoped_accesses.prev);
+		{
+			/* Should generate reports anywhere in this block. */
+			ASSERT_EXCLUSIVE_WRITER_SCOPED(test_scoped);
+			ASSERT_EXCLUSIVE_ACCESS_SCOPED(test_scoped);
+			BUG_ON(!current->kcsan_ctx.scoped_accesses.prev);
+			/* Unrelated accesses. */
+			__kcsan_check_access(&cycles, sizeof(cycles), 0);
+			__kcsan_check_access(&cycles, sizeof(cycles), KCSAN_ACCESS_ATOMIC);
+		}
+		BUG_ON(current->kcsan_ctx.scoped_accesses.prev);
+	}
+	cycles = get_cycles() - cycles;
+
+	pr_info("KCSAN: %s end   | cycles: %llu\n", __func__, cycles);
+
+	/* restore context */
+	current->kcsan_ctx = ctx_save;
+}
+
+static int cmp_filterlist_addrs(const void *rhs, const void *lhs)
+{
+	const unsigned long a = *(const unsigned long *)rhs;
+	const unsigned long b = *(const unsigned long *)lhs;
+
+	return a < b ? -1 : a == b ? 0 : 1;
+}
+
+bool kcsan_skip_report_debugfs(unsigned long func_addr)
+{
+	unsigned long symbolsize, offset;
+	unsigned long flags;
+	bool ret = false;
+
+	if (!kallsyms_lookup_size_offset(func_addr, &symbolsize, &offset))
+		return false;
+	func_addr -= offset; /* Get function start */
+
+	spin_lock_irqsave(&report_filterlist_lock, flags);
+	if (report_filterlist.used == 0)
+		goto out;
+
+	/* Sort array if it is unsorted, and then do a binary search. */
+	if (!report_filterlist.sorted) {
+		sort(report_filterlist.addrs, report_filterlist.used,
+		     sizeof(unsigned long), cmp_filterlist_addrs, NULL);
+		report_filterlist.sorted = true;
+	}
+	ret = !!bsearch(&func_addr, report_filterlist.addrs,
+			report_filterlist.used, sizeof(unsigned long),
+			cmp_filterlist_addrs);
+	if (report_filterlist.whitelist)
+		ret = !ret;
+
+out:
+	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	return ret;
+}
+
+static void set_report_filterlist_whitelist(bool whitelist)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&report_filterlist_lock, flags);
+	report_filterlist.whitelist = whitelist;
+	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+}
+
+/* Returns 0 on success, error-code otherwise. */
+static ssize_t insert_report_filterlist(const char *func)
+{
+	unsigned long flags;
+	unsigned long addr = kallsyms_lookup_name(func);
+	ssize_t ret = 0;
+
+	if (!addr) {
+		pr_err("KCSAN: could not find function: '%s'\n", func);
+		return -ENOENT;
+	}
+
+	spin_lock_irqsave(&report_filterlist_lock, flags);
+
+	if (report_filterlist.addrs == NULL) {
+		/* initial allocation */
+		report_filterlist.addrs =
+			kmalloc_array(report_filterlist.size,
+				      sizeof(unsigned long), GFP_ATOMIC);
+		if (report_filterlist.addrs == NULL) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else if (report_filterlist.used == report_filterlist.size) {
+		/* resize filterlist */
+		size_t new_size = report_filterlist.size * 2;
+		unsigned long *new_addrs =
+			krealloc(report_filterlist.addrs,
+				 new_size * sizeof(unsigned long), GFP_ATOMIC);
+
+		if (new_addrs == NULL) {
+			/* leave filterlist itself untouched */
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		report_filterlist.size = new_size;
+		report_filterlist.addrs = new_addrs;
+	}
+
+	/* Note: deduplicating should be done in userspace. */
+	report_filterlist.addrs[report_filterlist.used++] =
+		kallsyms_lookup_name(func);
+	report_filterlist.sorted = false;
+
+out:
+	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+
+	return ret;
+}
+
+static int show_info(struct seq_file *file, void *v)
+{
+	int i;
+	unsigned long flags;
+
+	/* show stats */
+	seq_printf(file, "enabled: %i\n", READ_ONCE(kcsan_enabled));
+	for (i = 0; i < KCSAN_COUNTER_COUNT; ++i)
+		seq_printf(file, "%s: %ld\n", counter_to_name(i),
+			   atomic_long_read(&counters[i]));
+
+	/* show filter functions, and filter type */
+	spin_lock_irqsave(&report_filterlist_lock, flags);
+	seq_printf(file, "\n%s functions: %s\n",
+		   report_filterlist.whitelist ? "whitelisted" : "blacklisted",
+		   report_filterlist.used == 0 ? "none" : "");
+	for (i = 0; i < report_filterlist.used; ++i)
+		seq_printf(file, " %ps\n", (void *)report_filterlist.addrs[i]);
+	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+
+	return 0;
+}
+
+static int debugfs_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, show_info, NULL);
+}
+
+static ssize_t
+debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *off)
+{
+	char kbuf[KSYM_NAME_LEN];
+	char *arg;
+	int read_len = count < (sizeof(kbuf) - 1) ? count : (sizeof(kbuf) - 1);
+
+	if (copy_from_user(kbuf, buf, read_len))
+		return -EFAULT;
+	kbuf[read_len] = '\0';
+	arg = strstrip(kbuf);
+
+	if (!strcmp(arg, "on")) {
+		WRITE_ONCE(kcsan_enabled, true);
+	} else if (!strcmp(arg, "off")) {
+		WRITE_ONCE(kcsan_enabled, false);
+	} else if (!strncmp(arg, "microbench=", sizeof("microbench=") - 1)) {
+		unsigned long iters;
+
+		if (kstrtoul(&arg[sizeof("microbench=") - 1], 0, &iters))
+			return -EINVAL;
+		microbenchmark(iters);
+	} else if (!strncmp(arg, "test=", sizeof("test=") - 1)) {
+		unsigned long iters;
+
+		if (kstrtoul(&arg[sizeof("test=") - 1], 0, &iters))
+			return -EINVAL;
+		test_thread(iters);
+	} else if (!strcmp(arg, "whitelist")) {
+		set_report_filterlist_whitelist(true);
+	} else if (!strcmp(arg, "blacklist")) {
+		set_report_filterlist_whitelist(false);
+	} else if (arg[0] == '!') {
+		ssize_t ret = insert_report_filterlist(&arg[1]);
+
+		if (ret < 0)
+			return ret;
+	} else {
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations debugfs_ops =
+{
+	.read	 = seq_read,
+	.open	 = debugfs_open,
+	.write	 = debugfs_write,
+	.release = single_release
+};
+
+void __init kcsan_debugfs_init(void)
+{
+	debugfs_create_file("kcsan", 0644, NULL, NULL, &debugfs_ops);
+}
diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
new file mode 100644
index 000000000000..f03562aaf2eb
--- /dev/null
+++ b/kernel/kcsan/encoding.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _KERNEL_KCSAN_ENCODING_H
+#define _KERNEL_KCSAN_ENCODING_H
+
+#include <linux/bits.h>
+#include <linux/log2.h>
+#include <linux/mm.h>
+
+#include "kcsan.h"
+
+#define SLOT_RANGE PAGE_SIZE
+
+#define INVALID_WATCHPOINT  0
+#define CONSUMED_WATCHPOINT 1
+
+/*
+ * The maximum useful size of accesses for which we set up watchpoints is the
+ * max range of slots we check on an access.
+ */
+#define MAX_ENCODABLE_SIZE (SLOT_RANGE * (1 + KCSAN_CHECK_ADJACENT))
+
+/*
+ * Number of bits we use to store size info.
+ */
+#define WATCHPOINT_SIZE_BITS bits_per(MAX_ENCODABLE_SIZE)
+/*
+ * This encoding for addresses discards the upper (1 for is-write + SIZE_BITS);
+ * however, most 64-bit architectures do not use the full 64-bit address space.
+ * Also, in order for a false positive to be observable 2 things need to happen:
+ *
+ *	1. different addresses but with the same encoded address race;
+ *	2. and both map onto the same watchpoint slots;
+ *
+ * Both these are assumed to be very unlikely. However, in case it still happens
+ * happens, the report logic will filter out the false positive (see report.c).
+ */
+#define WATCHPOINT_ADDR_BITS (BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)
+
+/*
+ * Masks to set/retrieve the encoded data.
+ */
+#define WATCHPOINT_WRITE_MASK BIT(BITS_PER_LONG-1)
+#define WATCHPOINT_SIZE_MASK                                                   \
+	GENMASK(BITS_PER_LONG-2, BITS_PER_LONG-2 - WATCHPOINT_SIZE_BITS)
+#define WATCHPOINT_ADDR_MASK                                                   \
+	GENMASK(BITS_PER_LONG-3 - WATCHPOINT_SIZE_BITS, 0)
+
+static inline bool check_encodable(unsigned long addr, size_t size)
+{
+	return size <= MAX_ENCODABLE_SIZE;
+}
+
+static inline long
+encode_watchpoint(unsigned long addr, size_t size, bool is_write)
+{
+	return (long)((is_write ? WATCHPOINT_WRITE_MASK : 0) |
+		      (size << WATCHPOINT_ADDR_BITS) |
+		      (addr & WATCHPOINT_ADDR_MASK));
+}
+
+static __always_inline bool decode_watchpoint(long watchpoint,
+					      unsigned long *addr_masked,
+					      size_t *size,
+					      bool *is_write)
+{
+	if (watchpoint == INVALID_WATCHPOINT ||
+	    watchpoint == CONSUMED_WATCHPOINT)
+		return false;
+
+	*addr_masked =    (unsigned long)watchpoint & WATCHPOINT_ADDR_MASK;
+	*size	     =   ((unsigned long)watchpoint & WATCHPOINT_SIZE_MASK) >> WATCHPOINT_ADDR_BITS;
+	*is_write    = !!((unsigned long)watchpoint & WATCHPOINT_WRITE_MASK);
+
+	return true;
+}
+
+/*
+ * Return watchpoint slot for an address.
+ */
+static __always_inline int watchpoint_slot(unsigned long addr)
+{
+	return (addr / PAGE_SIZE) % CONFIG_KCSAN_NUM_WATCHPOINTS;
+}
+
+static __always_inline bool matching_access(unsigned long addr1, size_t size1,
+					    unsigned long addr2, size_t size2)
+{
+	unsigned long end_range1 = addr1 + size1 - 1;
+	unsigned long end_range2 = addr2 + size2 - 1;
+
+	return addr1 <= end_range2 && addr2 <= end_range1;
+}
+
+#endif /* _KERNEL_KCSAN_ENCODING_H */
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
new file mode 100644
index 000000000000..763d6d08d94b
--- /dev/null
+++ b/kernel/kcsan/kcsan.h
@@ -0,0 +1,142 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * The Kernel Concurrency Sanitizer (KCSAN) infrastructure. For more info please
+ * see Documentation/dev-tools/kcsan.rst.
+ */
+
+#ifndef _KERNEL_KCSAN_KCSAN_H
+#define _KERNEL_KCSAN_KCSAN_H
+
+#include <linux/kcsan.h>
+
+/* The number of adjacent watchpoints to check. */
+#define KCSAN_CHECK_ADJACENT 1
+#define NUM_SLOTS (1 + 2*KCSAN_CHECK_ADJACENT)
+
+extern unsigned int kcsan_udelay_task;
+extern unsigned int kcsan_udelay_interrupt;
+
+/*
+ * Globally enable and disable KCSAN.
+ */
+extern bool kcsan_enabled;
+
+/*
+ * Initialize debugfs file.
+ */
+void kcsan_debugfs_init(void);
+
+enum kcsan_counter_id {
+	/*
+	 * Number of watchpoints currently in use.
+	 */
+	KCSAN_COUNTER_USED_WATCHPOINTS,
+
+	/*
+	 * Total number of watchpoints set up.
+	 */
+	KCSAN_COUNTER_SETUP_WATCHPOINTS,
+
+	/*
+	 * Total number of data races.
+	 */
+	KCSAN_COUNTER_DATA_RACES,
+
+	/*
+	 * Total number of ASSERT failures due to races. If the observed race is
+	 * due to two conflicting ASSERT type accesses, then both will be
+	 * counted.
+	 */
+	KCSAN_COUNTER_ASSERT_FAILURES,
+
+	/*
+	 * Number of times no watchpoints were available.
+	 */
+	KCSAN_COUNTER_NO_CAPACITY,
+
+	/*
+	 * A thread checking a watchpoint raced with another checking thread;
+	 * only one will be reported.
+	 */
+	KCSAN_COUNTER_REPORT_RACES,
+
+	/*
+	 * Observed data value change, but writer thread unknown.
+	 */
+	KCSAN_COUNTER_RACES_UNKNOWN_ORIGIN,
+
+	/*
+	 * The access cannot be encoded to a valid watchpoint.
+	 */
+	KCSAN_COUNTER_UNENCODABLE_ACCESSES,
+
+	/*
+	 * Watchpoint encoding caused a watchpoint to fire on mismatching
+	 * accesses.
+	 */
+	KCSAN_COUNTER_ENCODING_FALSE_POSITIVES,
+
+	KCSAN_COUNTER_COUNT, /* number of counters */
+};
+
+/*
+ * Increment/decrement counter with given id; avoid calling these in fast-path.
+ */
+extern void kcsan_counter_inc(enum kcsan_counter_id id);
+extern void kcsan_counter_dec(enum kcsan_counter_id id);
+
+/*
+ * Returns true if data races in the function symbol that maps to func_addr
+ * (offsets are ignored) should *not* be reported.
+ */
+extern bool kcsan_skip_report_debugfs(unsigned long func_addr);
+
+/*
+ * Value-change states.
+ */
+enum kcsan_value_change {
+	/*
+	 * Did not observe a value-change, however, it is valid to report the
+	 * race, depending on preferences.
+	 */
+	KCSAN_VALUE_CHANGE_MAYBE,
+
+	/*
+	 * Did not observe a value-change, and it is invalid to report the race.
+	 */
+	KCSAN_VALUE_CHANGE_FALSE,
+
+	/*
+	 * The value was observed to change, and the race should be reported.
+	 */
+	KCSAN_VALUE_CHANGE_TRUE,
+};
+
+enum kcsan_report_type {
+	/*
+	 * The thread that set up the watchpoint and briefly stalled was
+	 * signalled that another thread triggered the watchpoint.
+	 */
+	KCSAN_REPORT_RACE_SIGNAL,
+
+	/*
+	 * A thread found and consumed a matching watchpoint.
+	 */
+	KCSAN_REPORT_CONSUMED_WATCHPOINT,
+
+	/*
+	 * No other thread was observed to race with the access, but the data
+	 * value before and after the stall differs.
+	 */
+	KCSAN_REPORT_RACE_UNKNOWN_ORIGIN,
+};
+
+/*
+ * Print a race report from thread that encountered the race.
+ */
+extern void kcsan_report(const volatile void *ptr, size_t size, int access_type,
+			 enum kcsan_value_change value_change,
+			 enum kcsan_report_type type, int watchpoint_idx);
+
+#endif /* _KERNEL_KCSAN_KCSAN_H */
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
new file mode 100644
index 000000000000..ac5f8345bae9
--- /dev/null
+++ b/kernel/kcsan/report.c
@@ -0,0 +1,634 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/debug_locks.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/lockdep.h>
+#include <linux/preempt.h>
+#include <linux/printk.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/stacktrace.h>
+
+#include "kcsan.h"
+#include "encoding.h"
+
+/*
+ * Max. number of stack entries to show in the report.
+ */
+#define NUM_STACK_ENTRIES 64
+
+/* Common access info. */
+struct access_info {
+	const volatile void	*ptr;
+	size_t			size;
+	int			access_type;
+	int			task_pid;
+	int			cpu_id;
+};
+
+/*
+ * Other thread info: communicated from other racing thread to thread that set
+ * up the watchpoint, which then prints the complete report atomically.
+ */
+struct other_info {
+	struct access_info	ai;
+	unsigned long		stack_entries[NUM_STACK_ENTRIES];
+	int			num_stack_entries;
+
+	/*
+	 * Optionally pass @current. Typically we do not need to pass @current
+	 * via @other_info since just @task_pid is sufficient. Passing @current
+	 * has additional overhead.
+	 *
+	 * To safely pass @current, we must either use get_task_struct/
+	 * put_task_struct, or stall the thread that populated @other_info.
+	 *
+	 * We cannot rely on get_task_struct/put_task_struct in case
+	 * release_report() races with a task being released, and would have to
+	 * free it in release_report(). This may result in deadlock if we want
+	 * to use KCSAN on the allocators.
+	 *
+	 * Since we also want to reliably print held locks for
+	 * CONFIG_KCSAN_VERBOSE, the current implementation stalls the thread
+	 * that populated @other_info until it has been consumed.
+	 */
+	struct task_struct	*task;
+};
+
+/*
+ * To never block any producers of struct other_info, we need as many elements
+ * as we have watchpoints (upper bound on concurrent races to report).
+ */
+static struct other_info other_infos[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
+
+/*
+ * Information about reported races; used to rate limit reporting.
+ */
+struct report_time {
+	/*
+	 * The last time the race was reported.
+	 */
+	unsigned long time;
+
+	/*
+	 * The frames of the 2 threads; if only 1 thread is known, one frame
+	 * will be 0.
+	 */
+	unsigned long frame1;
+	unsigned long frame2;
+};
+
+/*
+ * Since we also want to be able to debug allocators with KCSAN, to avoid
+ * deadlock, report_times cannot be dynamically resized with krealloc in
+ * rate_limit_report.
+ *
+ * Therefore, we use a fixed-size array, which at most will occupy a page. This
+ * still adequately rate limits reports, assuming that a) number of unique data
+ * races is not excessive, and b) occurrence of unique races within the
+ * same time window is limited.
+ */
+#define REPORT_TIMES_MAX (PAGE_SIZE / sizeof(struct report_time))
+#define REPORT_TIMES_SIZE                                                      \
+	(CONFIG_KCSAN_REPORT_ONCE_IN_MS > REPORT_TIMES_MAX ?                   \
+		 REPORT_TIMES_MAX :                                            \
+		 CONFIG_KCSAN_REPORT_ONCE_IN_MS)
+static struct report_time report_times[REPORT_TIMES_SIZE];
+
+/*
+ * Spinlock serializing report generation, and access to @other_infos. Although
+ * it could make sense to have a finer-grained locking story for @other_infos,
+ * report generation needs to be serialized either way, so not much is gained.
+ */
+static DEFINE_RAW_SPINLOCK(report_lock);
+
+/*
+ * Checks if the race identified by thread frames frame1 and frame2 has
+ * been reported since (now - KCSAN_REPORT_ONCE_IN_MS).
+ */
+static bool rate_limit_report(unsigned long frame1, unsigned long frame2)
+{
+	struct report_time *use_entry = &report_times[0];
+	unsigned long invalid_before;
+	int i;
+
+	BUILD_BUG_ON(CONFIG_KCSAN_REPORT_ONCE_IN_MS != 0 && REPORT_TIMES_SIZE == 0);
+
+	if (CONFIG_KCSAN_REPORT_ONCE_IN_MS == 0)
+		return false;
+
+	invalid_before = jiffies - msecs_to_jiffies(CONFIG_KCSAN_REPORT_ONCE_IN_MS);
+
+	/* Check if a matching race report exists. */
+	for (i = 0; i < REPORT_TIMES_SIZE; ++i) {
+		struct report_time *rt = &report_times[i];
+
+		/*
+		 * Must always select an entry for use to store info as we
+		 * cannot resize report_times; at the end of the scan, use_entry
+		 * will be the oldest entry, which ideally also happened before
+		 * KCSAN_REPORT_ONCE_IN_MS ago.
+		 */
+		if (time_before(rt->time, use_entry->time))
+			use_entry = rt;
+
+		/*
+		 * Initially, no need to check any further as this entry as well
+		 * as following entries have never been used.
+		 */
+		if (rt->time == 0)
+			break;
+
+		/* Check if entry expired. */
+		if (time_before(rt->time, invalid_before))
+			continue; /* before KCSAN_REPORT_ONCE_IN_MS ago */
+
+		/* Reported recently, check if race matches. */
+		if ((rt->frame1 == frame1 && rt->frame2 == frame2) ||
+		    (rt->frame1 == frame2 && rt->frame2 == frame1))
+			return true;
+	}
+
+	use_entry->time = jiffies;
+	use_entry->frame1 = frame1;
+	use_entry->frame2 = frame2;
+	return false;
+}
+
+/*
+ * Special rules to skip reporting.
+ */
+static bool
+skip_report(enum kcsan_value_change value_change, unsigned long top_frame)
+{
+	/* Should never get here if value_change==FALSE. */
+	WARN_ON_ONCE(value_change == KCSAN_VALUE_CHANGE_FALSE);
+
+	/*
+	 * The first call to skip_report always has value_change==TRUE, since we
+	 * cannot know the value written of an instrumented access. For the 2nd
+	 * call there are 6 cases with CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY:
+	 *
+	 * 1. read watchpoint, conflicting write (value_change==TRUE): report;
+	 * 2. read watchpoint, conflicting write (value_change==MAYBE): skip;
+	 * 3. write watchpoint, conflicting write (value_change==TRUE): report;
+	 * 4. write watchpoint, conflicting write (value_change==MAYBE): skip;
+	 * 5. write watchpoint, conflicting read (value_change==MAYBE): skip;
+	 * 6. write watchpoint, conflicting read (value_change==TRUE): report;
+	 *
+	 * Cases 1-4 are intuitive and expected; case 5 ensures we do not report
+	 * data races where the write may have rewritten the same value; case 6
+	 * is possible either if the size is larger than what we check value
+	 * changes for or the access type is KCSAN_ACCESS_ASSERT.
+	 */
+	if (IS_ENABLED(CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY) &&
+	    value_change == KCSAN_VALUE_CHANGE_MAYBE) {
+		/*
+		 * The access is a write, but the data value did not change.
+		 *
+		 * We opt-out of this filter for certain functions at request of
+		 * maintainers.
+		 */
+		char buf[64];
+		int len = scnprintf(buf, sizeof(buf), "%ps", (void *)top_frame);
+
+		if (!strnstr(buf, "rcu_", len) &&
+		    !strnstr(buf, "_rcu", len) &&
+		    !strnstr(buf, "_srcu", len))
+			return true;
+	}
+
+	return kcsan_skip_report_debugfs(top_frame);
+}
+
+static const char *get_access_type(int type)
+{
+	if (type & KCSAN_ACCESS_ASSERT) {
+		if (type & KCSAN_ACCESS_SCOPED) {
+			if (type & KCSAN_ACCESS_WRITE)
+				return "assert no accesses (scoped)";
+			else
+				return "assert no writes (scoped)";
+		} else {
+			if (type & KCSAN_ACCESS_WRITE)
+				return "assert no accesses";
+			else
+				return "assert no writes";
+		}
+	}
+
+	switch (type) {
+	case 0:
+		return "read";
+	case KCSAN_ACCESS_ATOMIC:
+		return "read (marked)";
+	case KCSAN_ACCESS_WRITE:
+		return "write";
+	case KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
+		return "write (marked)";
+	case KCSAN_ACCESS_SCOPED:
+		return "read (scoped)";
+	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_ATOMIC:
+		return "read (marked, scoped)";
+	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_WRITE:
+		return "write (scoped)";
+	case KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ATOMIC:
+		return "write (marked, scoped)";
+	default:
+		BUG();
+	}
+}
+
+static const char *get_bug_type(int type)
+{
+	return (type & KCSAN_ACCESS_ASSERT) != 0 ? "assert: race" : "data-race";
+}
+
+/* Return thread description: in task or interrupt. */
+static const char *get_thread_desc(int task_id)
+{
+	if (task_id != -1) {
+		static char buf[32]; /* safe: protected by report_lock */
+
+		snprintf(buf, sizeof(buf), "task %i", task_id);
+		return buf;
+	}
+	return "interrupt";
+}
+
+/* Helper to skip KCSAN-related functions in stack-trace. */
+static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries)
+{
+	char buf[64];
+	char *cur;
+	int len, skip;
+
+	for (skip = 0; skip < num_entries; ++skip) {
+		len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skip]);
+
+		/* Never show tsan_* or {read,write}_once_size. */
+		if (strnstr(buf, "tsan_", len) ||
+		    strnstr(buf, "_once_size", len))
+			continue;
+
+		cur = strnstr(buf, "kcsan_", len);
+		if (cur) {
+			cur += sizeof("kcsan_") - 1;
+			if (strncmp(cur, "test", sizeof("test") - 1))
+				continue; /* KCSAN runtime function. */
+			/* KCSAN related test. */
+		}
+
+		/*
+		 * No match for runtime functions -- @skip entries to skip to
+		 * get to first frame of interest.
+		 */
+		break;
+	}
+
+	return skip;
+}
+
+/* Compares symbolized strings of addr1 and addr2. */
+static int sym_strcmp(void *addr1, void *addr2)
+{
+	char buf1[64];
+	char buf2[64];
+
+	snprintf(buf1, sizeof(buf1), "%pS", addr1);
+	snprintf(buf2, sizeof(buf2), "%pS", addr2);
+
+	return strncmp(buf1, buf2, sizeof(buf1));
+}
+
+static void print_verbose_info(struct task_struct *task)
+{
+	if (!task)
+		return;
+
+	pr_err("\n");
+	debug_show_held_locks(task);
+	print_irqtrace_events(task);
+}
+
+/*
+ * Returns true if a report was generated, false otherwise.
+ */
+static bool print_report(enum kcsan_value_change value_change,
+			 enum kcsan_report_type type,
+			 const struct access_info *ai,
+			 const struct other_info *other_info)
+{
+	unsigned long stack_entries[NUM_STACK_ENTRIES] = { 0 };
+	int num_stack_entries = stack_trace_save(stack_entries, NUM_STACK_ENTRIES, 1);
+	int skipnr = get_stack_skipnr(stack_entries, num_stack_entries);
+	unsigned long this_frame = stack_entries[skipnr];
+	unsigned long other_frame = 0;
+	int other_skipnr = 0; /* silence uninit warnings */
+
+	/*
+	 * Must check report filter rules before starting to print.
+	 */
+	if (skip_report(KCSAN_VALUE_CHANGE_TRUE, stack_entries[skipnr]))
+		return false;
+
+	if (type == KCSAN_REPORT_RACE_SIGNAL) {
+		other_skipnr = get_stack_skipnr(other_info->stack_entries,
+						other_info->num_stack_entries);
+		other_frame = other_info->stack_entries[other_skipnr];
+
+		/* @value_change is only known for the other thread */
+		if (skip_report(value_change, other_frame))
+			return false;
+	}
+
+	if (rate_limit_report(this_frame, other_frame))
+		return false;
+
+	/* Print report header. */
+	pr_err("==================================================================\n");
+	switch (type) {
+	case KCSAN_REPORT_RACE_SIGNAL: {
+		int cmp;
+
+		/*
+		 * Order functions lexographically for consistent bug titles.
+		 * Do not print offset of functions to keep title short.
+		 */
+		cmp = sym_strcmp((void *)other_frame, (void *)this_frame);
+		pr_err("BUG: KCSAN: %s in %ps / %ps\n",
+		       get_bug_type(ai->access_type | other_info->ai.access_type),
+		       (void *)(cmp < 0 ? other_frame : this_frame),
+		       (void *)(cmp < 0 ? this_frame : other_frame));
+	} break;
+
+	case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
+		pr_err("BUG: KCSAN: %s in %pS\n", get_bug_type(ai->access_type),
+		       (void *)this_frame);
+		break;
+
+	default:
+		BUG();
+	}
+
+	pr_err("\n");
+
+	/* Print information about the racing accesses. */
+	switch (type) {
+	case KCSAN_REPORT_RACE_SIGNAL:
+		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
+		       get_access_type(other_info->ai.access_type), other_info->ai.ptr,
+		       other_info->ai.size, get_thread_desc(other_info->ai.task_pid),
+		       other_info->ai.cpu_id);
+
+		/* Print the other thread's stack trace. */
+		stack_trace_print(other_info->stack_entries + other_skipnr,
+				  other_info->num_stack_entries - other_skipnr,
+				  0);
+
+		if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
+			print_verbose_info(other_info->task);
+
+		pr_err("\n");
+		pr_err("%s to 0x%px of %zu bytes by %s on cpu %i:\n",
+		       get_access_type(ai->access_type), ai->ptr, ai->size,
+		       get_thread_desc(ai->task_pid), ai->cpu_id);
+		break;
+
+	case KCSAN_REPORT_RACE_UNKNOWN_ORIGIN:
+		pr_err("race at unknown origin, with %s to 0x%px of %zu bytes by %s on cpu %i:\n",
+		       get_access_type(ai->access_type), ai->ptr, ai->size,
+		       get_thread_desc(ai->task_pid), ai->cpu_id);
+		break;
+
+	default:
+		BUG();
+	}
+	/* Print stack trace of this thread. */
+	stack_trace_print(stack_entries + skipnr, num_stack_entries - skipnr,
+			  0);
+
+	if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
+		print_verbose_info(current);
+
+	/* Print report footer. */
+	pr_err("\n");
+	pr_err("Reported by Kernel Concurrency Sanitizer on:\n");
+	dump_stack_print_info(KERN_DEFAULT);
+	pr_err("==================================================================\n");
+
+	return true;
+}
+
+static void release_report(unsigned long *flags, struct other_info *other_info)
+{
+	if (other_info)
+		/*
+		 * Use size to denote valid/invalid, since KCSAN entirely
+		 * ignores 0-sized accesses.
+		 */
+		other_info->ai.size = 0;
+
+	raw_spin_unlock_irqrestore(&report_lock, *flags);
+}
+
+/*
+ * Sets @other_info->task and awaits consumption of @other_info.
+ *
+ * Precondition: report_lock is held.
+ * Postcondition: report_lock is held.
+ */
+static void set_other_info_task_blocking(unsigned long *flags,
+					 const struct access_info *ai,
+					 struct other_info *other_info)
+{
+	/*
+	 * We may be instrumenting a code-path where current->state is already
+	 * something other than TASK_RUNNING.
+	 */
+	const bool is_running = current->state == TASK_RUNNING;
+	/*
+	 * To avoid deadlock in case we are in an interrupt here and this is a
+	 * race with a task on the same CPU (KCSAN_INTERRUPT_WATCHER), provide a
+	 * timeout to ensure this works in all contexts.
+	 *
+	 * Await approximately the worst case delay of the reporting thread (if
+	 * we are not interrupted).
+	 */
+	int timeout = max(kcsan_udelay_task, kcsan_udelay_interrupt);
+
+	other_info->task = current;
+	do {
+		if (is_running) {
+			/*
+			 * Let lockdep know the real task is sleeping, to print
+			 * the held locks (recall we turned lockdep off, so
+			 * locking/unlocking @report_lock won't be recorded).
+			 */
+			set_current_state(TASK_UNINTERRUPTIBLE);
+		}
+		raw_spin_unlock_irqrestore(&report_lock, *flags);
+		/*
+		 * We cannot call schedule() since we also cannot reliably
+		 * determine if sleeping here is permitted -- see in_atomic().
+		 */
+
+		udelay(1);
+		raw_spin_lock_irqsave(&report_lock, *flags);
+		if (timeout-- < 0) {
+			/*
+			 * Abort. Reset @other_info->task to NULL, since it
+			 * appears the other thread is still going to consume
+			 * it. It will result in no verbose info printed for
+			 * this task.
+			 */
+			other_info->task = NULL;
+			break;
+		}
+		/*
+		 * If invalid, or @ptr nor @current matches, then @other_info
+		 * has been consumed and we may continue. If not, retry.
+		 */
+	} while (other_info->ai.size && other_info->ai.ptr == ai->ptr &&
+		 other_info->task == current);
+	if (is_running)
+		set_current_state(TASK_RUNNING);
+}
+
+/* Populate @other_info; requires that the provided @other_info not in use. */
+static void prepare_report_producer(unsigned long *flags,
+				    const struct access_info *ai,
+				    struct other_info *other_info)
+{
+	raw_spin_lock_irqsave(&report_lock, *flags);
+
+	/*
+	 * The same @other_infos entry cannot be used concurrently, because
+	 * there is a one-to-one mapping to watchpoint slots (@watchpoints in
+	 * core.c), and a watchpoint is only released for reuse after reporting
+	 * is done by the consumer of @other_info. Therefore, it is impossible
+	 * for another concurrent prepare_report_producer() to set the same
+	 * @other_info, and are guaranteed exclusivity for the @other_infos
+	 * entry pointed to by @other_info.
+	 *
+	 * To check this property holds, size should never be non-zero here,
+	 * because every consumer of struct other_info resets size to 0 in
+	 * release_report().
+	 */
+	WARN_ON(other_info->ai.size);
+
+	other_info->ai = *ai;
+	other_info->num_stack_entries = stack_trace_save(other_info->stack_entries, NUM_STACK_ENTRIES, 2);
+
+	if (IS_ENABLED(CONFIG_KCSAN_VERBOSE))
+		set_other_info_task_blocking(flags, ai, other_info);
+
+	raw_spin_unlock_irqrestore(&report_lock, *flags);
+}
+
+/* Awaits producer to fill @other_info and then returns. */
+static bool prepare_report_consumer(unsigned long *flags,
+				    const struct access_info *ai,
+				    struct other_info *other_info)
+{
+
+	raw_spin_lock_irqsave(&report_lock, *flags);
+	while (!other_info->ai.size) { /* Await valid @other_info. */
+		raw_spin_unlock_irqrestore(&report_lock, *flags);
+		cpu_relax();
+		raw_spin_lock_irqsave(&report_lock, *flags);
+	}
+
+	/* Should always have a matching access based on watchpoint encoding. */
+	if (WARN_ON(!matching_access((unsigned long)other_info->ai.ptr & WATCHPOINT_ADDR_MASK, other_info->ai.size,
+				     (unsigned long)ai->ptr & WATCHPOINT_ADDR_MASK, ai->size)))
+		goto discard;
+
+	if (!matching_access((unsigned long)other_info->ai.ptr, other_info->ai.size,
+			     (unsigned long)ai->ptr, ai->size)) {
+		/*
+		 * If the actual accesses to not match, this was a false
+		 * positive due to watchpoint encoding.
+		 */
+		kcsan_counter_inc(KCSAN_COUNTER_ENCODING_FALSE_POSITIVES);
+		goto discard;
+	}
+
+	return true;
+
+discard:
+	release_report(flags, other_info);
+	return false;
+}
+
+/*
+ * Depending on the report type either sets @other_info and returns false, or
+ * awaits @other_info and returns true. If @other_info is not required for the
+ * report type, simply acquires @report_lock and returns true.
+ */
+static noinline bool prepare_report(unsigned long *flags,
+				    enum kcsan_report_type type,
+				    const struct access_info *ai,
+				    struct other_info *other_info)
+{
+	switch (type) {
+	case KCSAN_REPORT_CONSUMED_WATCHPOINT:
+		prepare_report_producer(flags, ai, other_info);
+		return false;
+	case KCSAN_REPORT_RACE_SIGNAL:
+		return prepare_report_consumer(flags, ai, other_info);
+	default:
+		/* @other_info not required; just acquire @report_lock. */
+		raw_spin_lock_irqsave(&report_lock, *flags);
+		return true;
+	}
+}
+
+void kcsan_report(const volatile void *ptr, size_t size, int access_type,
+		  enum kcsan_value_change value_change,
+		  enum kcsan_report_type type, int watchpoint_idx)
+{
+	unsigned long flags = 0;
+	const struct access_info ai = {
+		.ptr		= ptr,
+		.size		= size,
+		.access_type	= access_type,
+		.task_pid	= in_task() ? task_pid_nr(current) : -1,
+		.cpu_id		= raw_smp_processor_id()
+	};
+	struct other_info *other_info = type == KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
+					? NULL : &other_infos[watchpoint_idx];
+
+	kcsan_disable_current();
+	if (WARN_ON(watchpoint_idx < 0 || watchpoint_idx >= ARRAY_SIZE(other_infos)))
+		goto out;
+
+	/*
+	 * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
+	 * we do not turn off lockdep here; this could happen due to recursion
+	 * into lockdep via KCSAN if we detect a race in utilities used by
+	 * lockdep.
+	 */
+	lockdep_off();
+
+	if (prepare_report(&flags, type, &ai, other_info)) {
+		/*
+		 * Never report if value_change is FALSE, only if we it is
+		 * either TRUE or MAYBE. In case of MAYBE, further filtering may
+		 * be done once we know the full stack trace in print_report().
+		 */
+		bool reported = value_change != KCSAN_VALUE_CHANGE_FALSE &&
+				print_report(value_change, type, &ai, other_info);
+
+		if (reported && panic_on_warn)
+			panic("panic_on_warn set ...\n");
+
+		release_report(&flags, other_info);
+	}
+
+	lockdep_on();
+out:
+	kcsan_enable_current();
+}
diff --git a/kernel/kcsan/test.c b/kernel/kcsan/test.c
new file mode 100644
index 000000000000..d26a052d3383
--- /dev/null
+++ b/kernel/kcsan/test.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/printk.h>
+#include <linux/random.h>
+#include <linux/types.h>
+
+#include "encoding.h"
+
+#define ITERS_PER_TEST 2000
+
+/* Test requirements. */
+static bool test_requires(void)
+{
+	/* random should be initialized for the below tests */
+	return prandom_u32() + prandom_u32() != 0;
+}
+
+/*
+ * Test watchpoint encode and decode: check that encoding some access's info,
+ * and then subsequent decode preserves the access's info.
+ */
+static bool test_encode_decode(void)
+{
+	int i;
+
+	for (i = 0; i < ITERS_PER_TEST; ++i) {
+		size_t size = prandom_u32_max(MAX_ENCODABLE_SIZE) + 1;
+		bool is_write = !!prandom_u32_max(2);
+		unsigned long addr;
+
+		prandom_bytes(&addr, sizeof(addr));
+		if (WARN_ON(!check_encodable(addr, size)))
+			return false;
+
+		/* Encode and decode */
+		{
+			const long encoded_watchpoint =
+				encode_watchpoint(addr, size, is_write);
+			unsigned long verif_masked_addr;
+			size_t verif_size;
+			bool verif_is_write;
+
+			/* Check special watchpoints */
+			if (WARN_ON(decode_watchpoint(
+				    INVALID_WATCHPOINT, &verif_masked_addr,
+				    &verif_size, &verif_is_write)))
+				return false;
+			if (WARN_ON(decode_watchpoint(
+				    CONSUMED_WATCHPOINT, &verif_masked_addr,
+				    &verif_size, &verif_is_write)))
+				return false;
+
+			/* Check decoding watchpoint returns same data */
+			if (WARN_ON(!decode_watchpoint(
+				    encoded_watchpoint, &verif_masked_addr,
+				    &verif_size, &verif_is_write)))
+				return false;
+			if (WARN_ON(verif_masked_addr !=
+				    (addr & WATCHPOINT_ADDR_MASK)))
+				goto fail;
+			if (WARN_ON(verif_size != size))
+				goto fail;
+			if (WARN_ON(is_write != verif_is_write))
+				goto fail;
+
+			continue;
+fail:
+			pr_err("%s fail: %s %zu bytes @ %lx -> encoded: %lx -> %s %zu bytes @ %lx\n",
+			       __func__, is_write ? "write" : "read", size,
+			       addr, encoded_watchpoint,
+			       verif_is_write ? "write" : "read", verif_size,
+			       verif_masked_addr);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+/* Test access matching function. */
+static bool test_matching_access(void)
+{
+	if (WARN_ON(!matching_access(10, 1, 10, 1)))
+		return false;
+	if (WARN_ON(!matching_access(10, 2, 11, 1)))
+		return false;
+	if (WARN_ON(!matching_access(10, 1, 9, 2)))
+		return false;
+	if (WARN_ON(matching_access(10, 1, 11, 1)))
+		return false;
+	if (WARN_ON(matching_access(9, 1, 10, 1)))
+		return false;
+
+	/*
+	 * An access of size 0 could match another access, as demonstrated here.
+	 * Rather than add more comparisons to 'matching_access()', which would
+	 * end up in the fast-path for *all* checks, check_access() simply
+	 * returns for all accesses of size 0.
+	 */
+	if (WARN_ON(!matching_access(8, 8, 12, 0)))
+		return false;
+
+	return true;
+}
+
+static int __init kcsan_selftest(void)
+{
+	int passed = 0;
+	int total = 0;
+
+#define RUN_TEST(do_test)                                                      \
+	do {                                                                   \
+		++total;                                                       \
+		if (do_test())                                                 \
+			++passed;                                              \
+		else                                                           \
+			pr_err("KCSAN selftest: " #do_test " failed");         \
+	} while (0)
+
+	RUN_TEST(test_requires);
+	RUN_TEST(test_encode_decode);
+	RUN_TEST(test_matching_access);
+
+	pr_info("KCSAN selftest: %d/%d tests passed\n", passed, total);
+	if (passed != total)
+		panic("KCSAN selftests failed");
+	return 0;
+}
+postcore_initcall(kcsan_selftest);
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 45452facff3b..6d11cfb9b41f 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -5,6 +5,9 @@ KCOV_INSTRUMENT		:= n
 
 obj-y += mutex.o semaphore.o rwsem.o percpu-rwsem.o
 
+# Avoid recursion lockdep -> KCSAN -> ... -> lockdep.
+KCSAN_SANITIZE_lockdep.o := n
+
 ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_lockdep.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_lockdep_proc.o = $(CC_FLAGS_FTRACE)
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 21fb5a5662b5..5fc9c9b70862 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -7,6 +7,12 @@ endif
 # that is not a function of syscall inputs. E.g. involuntary context switches.
 KCOV_INSTRUMENT := n
 
+# There are numerous data races here, however, most of them are due to plain accesses.
+# This would make it even harder for syzbot to find reproducers, because these
+# bugs trigger without specific input. Disable by default, but should re-enable
+# eventually.
+KCSAN_SANITIZE := n
+
 ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
 # needed for x86 only.  Why this used to be enabled for all architectures is beyond
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 1d8aaa546412..6575bb0a0434 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -6,6 +6,9 @@ ifdef CONFIG_FUNCTION_TRACER
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
 KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
 
+# Avoid recursion due to instrumentation.
+KCSAN_SANITIZE := n
+
 ifdef CONFIG_FTRACE_SELFTEST
 # selftest needs instrumentation
 CFLAGS_trace_selftest_dynamic.o = $(CC_FLAGS_FTRACE)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index cb98741601bd..90e16bfe27c7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1570,6 +1570,8 @@ config PROVIDE_OHCI1394_DMA_INIT
 
 source "samples/Kconfig"
 
+source "lib/Kconfig.kcsan"
+
 config ARCH_HAS_DEVMEM_IS_ALLOWED
 	bool
 
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
new file mode 100644
index 000000000000..5ee88e5119c2
--- /dev/null
+++ b/lib/Kconfig.kcsan
@@ -0,0 +1,199 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config HAVE_ARCH_KCSAN
+	bool
+
+config HAVE_KCSAN_COMPILER
+	def_bool CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-distinguish-volatile=1)
+	help
+	  For the list of compilers that support KCSAN, please see
+	  <file:Documentation/dev-tools/kcsan.rst>.
+
+config KCSAN_KCOV_BROKEN
+	def_bool KCOV && CC_HAS_SANCOV_TRACE_PC
+	depends on CC_IS_CLANG
+	depends on !$(cc-option,-Werror=unused-command-line-argument -fsanitize=thread -fsanitize-coverage=trace-pc)
+	help
+	  Some versions of clang support either KCSAN and KCOV but not the
+	  combination of the two.
+	  See https://bugs.llvm.org/show_bug.cgi?id=45831 for the status
+	  in newer releases.
+
+menuconfig KCSAN
+	bool "KCSAN: dynamic data race detector"
+	depends on HAVE_ARCH_KCSAN && HAVE_KCSAN_COMPILER
+	depends on DEBUG_KERNEL && !KASAN
+	depends on !KCSAN_KCOV_BROKEN
+	select STACKTRACE
+	help
+	  The Kernel Concurrency Sanitizer (KCSAN) is a dynamic
+	  data-race detector that relies on compile-time instrumentation.
+	  KCSAN uses a watchpoint-based sampling approach to detect races.
+
+	  While KCSAN's primary purpose is to detect data races, it
+	  also provides assertions to check data access constraints.
+	  These assertions can expose bugs that do not manifest as
+	  data races.
+
+	  See <file:Documentation/dev-tools/kcsan.rst> for more details.
+
+if KCSAN
+
+config KCSAN_VERBOSE
+	bool "Show verbose reports with more information about system state"
+	depends on PROVE_LOCKING
+	help
+	  If enabled, reports show more information about the system state that
+	  may help better analyze and debug races. This includes held locks and
+	  IRQ trace events.
+
+	  While this option should generally be benign, we call into more
+	  external functions on report generation; if a race report is
+	  generated from any one of them, system stability may suffer due to
+	  deadlocks or recursion.  If in doubt, say N.
+
+config KCSAN_DEBUG
+	bool "Debugging of KCSAN internals"
+
+config KCSAN_SELFTEST
+	bool "Perform short selftests on boot"
+	default y
+	help
+	  Run KCSAN selftests on boot. On test failure, causes the kernel to panic.
+
+config KCSAN_EARLY_ENABLE
+	bool "Early enable during boot"
+	default y
+	help
+	  If KCSAN should be enabled globally as soon as possible. KCSAN can
+	  later be enabled/disabled via debugfs.
+
+config KCSAN_NUM_WATCHPOINTS
+	int "Number of available watchpoints"
+	default 64
+	help
+	  Total number of available watchpoints. An address range maps into a
+	  specific watchpoint slot as specified in kernel/kcsan/encoding.h.
+	  Although larger number of watchpoints may not be usable due to
+	  limited number of CPUs, a larger value helps to improve performance
+	  due to reducing cache-line contention. The chosen default is a
+	  conservative value; we should almost never observe "no_capacity"
+	  events (see /sys/kernel/debug/kcsan).
+
+config KCSAN_UDELAY_TASK
+	int "Delay in microseconds (for tasks)"
+	default 80
+	help
+	  For tasks, the microsecond delay after setting up a watchpoint.
+
+config KCSAN_UDELAY_INTERRUPT
+	int "Delay in microseconds (for interrupts)"
+	default 20
+	help
+	  For interrupts, the microsecond delay after setting up a watchpoint.
+	  Interrupts have tighter latency requirements, and their delay should
+	  be lower than for tasks.
+
+config KCSAN_DELAY_RANDOMIZE
+	bool "Randomize above delays"
+	default y
+	help
+	  If delays should be randomized, where the maximum is KCSAN_UDELAY_*.
+	  If false, the chosen delays are always the KCSAN_UDELAY_* values
+	  as defined above.
+
+config KCSAN_SKIP_WATCH
+	int "Skip instructions before setting up watchpoint"
+	default 4000
+	help
+	  The number of per-CPU memory operations to skip, before another
+	  watchpoint is set up, i.e. one in KCSAN_WATCH_SKIP per-CPU
+	  memory operations are used to set up a watchpoint. A smaller value
+	  results in more aggressive race detection, whereas a larger value
+	  improves system performance at the cost of missing some races.
+
+config KCSAN_SKIP_WATCH_RANDOMIZE
+	bool "Randomize watchpoint instruction skip count"
+	default y
+	help
+	  If instruction skip count should be randomized, where the maximum is
+	  KCSAN_WATCH_SKIP. If false, the chosen value is always
+	  KCSAN_WATCH_SKIP.
+
+config KCSAN_INTERRUPT_WATCHER
+	bool "Interruptible watchers"
+	help
+	  If enabled, a task that set up a watchpoint may be interrupted while
+	  delayed. This option will allow KCSAN to detect races between
+	  interrupted tasks and other threads of execution on the same CPU.
+
+	  Currently disabled by default, because not all safe per-CPU access
+	  primitives and patterns may be accounted for, and therefore could
+	  result in false positives.
+
+config KCSAN_REPORT_ONCE_IN_MS
+	int "Duration in milliseconds, in which any given race is only reported once"
+	default 3000
+	help
+	  Any given race is only reported once in the defined time window.
+	  Different races may still generate reports within a duration that is
+	  smaller than the duration defined here. This allows rate limiting
+	  reporting to avoid flooding the console with reports.  Setting this
+	  to 0 disables rate limiting.
+
+# The main purpose of the below options is to control reported data races (e.g.
+# in fuzzer configs), and are not expected to be switched frequently by other
+# users. We could turn some of them into boot parameters, but given they should
+# not be switched normally, let's keep them here to simplify configuration.
+#
+# The defaults below are chosen to be very conservative, and may miss certain
+# bugs.
+
+config KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
+	bool "Report races of unknown origin"
+	default y
+	help
+	  If KCSAN should report races where only one access is known, and the
+	  conflicting access is of unknown origin. This type of race is
+	  reported if it was only possible to infer a race due to a data value
+	  change while an access is being delayed on a watchpoint.
+
+config KCSAN_REPORT_VALUE_CHANGE_ONLY
+	bool "Only report races where watcher observed a data value change"
+	default y
+	help
+	  If enabled and a conflicting write is observed via a watchpoint, but
+	  the data value of the memory location was observed to remain
+	  unchanged, do not report the data race.
+
+config KCSAN_ASSUME_PLAIN_WRITES_ATOMIC
+	bool "Assume that plain aligned writes up to word size are atomic"
+	default y
+	help
+	  Assume that plain aligned writes up to word size are atomic by
+	  default, and also not subject to other unsafe compiler optimizations
+	  resulting in data races. This will cause KCSAN to not report data
+	  races due to conflicts where the only plain accesses are aligned
+	  writes up to word size: conflicts between marked reads and plain
+	  aligned writes up to word size will not be reported as data races;
+	  notice that data races between two conflicting plain aligned writes
+	  will also not be reported.
+
+config KCSAN_IGNORE_ATOMICS
+	bool "Do not instrument marked atomic accesses"
+	help
+	  Never instrument marked atomic accesses. This option can be used for
+	  additional filtering. Conflicting marked atomic reads and plain
+	  writes will never be reported as a data race, however, will cause
+	  plain reads and marked writes to result in "unknown origin" reports.
+	  If combined with CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=n, data
+	  races where at least one access is marked atomic will never be
+	  reported.
+
+	  Similar to KCSAN_ASSUME_PLAIN_WRITES_ATOMIC, but including unaligned
+	  accesses, conflicting marked atomic reads and plain writes will not
+	  be reported as data races; however, unlike that option, data races
+	  due to two conflicting plain writes will be reported (aligned and
+	  unaligned, if CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n).
+
+endif # KCSAN
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 27bcc2568c95..774315de555a 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -26,9 +26,20 @@ config UBSAN_TRAP
 	  the system. For some system builders this is an acceptable
 	  trade-off.
 
+config UBSAN_KCOV_BROKEN
+	def_bool KCOV && CC_HAS_SANCOV_TRACE_PC
+	depends on CC_IS_CLANG
+	depends on !$(cc-option,-Werror=unused-command-line-argument -fsanitize=bounds -fsanitize-coverage=trace-pc)
+	help
+	  Some versions of clang support either UBSAN or KCOV but not the
+	  combination of the two.
+	  See https://bugs.llvm.org/show_bug.cgi?id=45831 for the status
+	  in newer releases.
+
 config UBSAN_BOUNDS
 	bool "Perform array index bounds checking"
 	default UBSAN
+	depends on !UBSAN_KCOV_BROKEN
 	help
 	  This option enables detection of directly indexed out of bounds
 	  array accesses, where the array size is known at compile time.
diff --git a/lib/Makefile b/lib/Makefile
index 315516fa4ef4..b1c42c10073b 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -25,6 +25,9 @@ KASAN_SANITIZE_string.o := n
 CFLAGS_string.o := $(call cc-option, -fno-stack-protector)
 endif
 
+# Used by KCSAN while enabled, avoid recursion.
+KCSAN_SANITIZE_random32.o := n
+
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 idr.o extable.o sha1.o irq_regs.o argv_split.o \
@@ -296,6 +299,7 @@ endif
 
 UBSAN_SANITIZE_ubsan.o := n
 KASAN_SANITIZE_ubsan.o := n
+KCSAN_SANITIZE_ubsan.o := n
 CFLAGS_ubsan.o := $(call cc-option, -fno-stack-protector) $(DISABLE_STACKLEAK_PLUGIN)
 
 obj-$(CONFIG_SBITMAP) += sbitmap.o
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 51595bf3af85..bf538c2bec77 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -8,6 +8,7 @@
 #include <linux/splice.h>
 #include <net/checksum.h>
 #include <linux/scatterlist.h>
+#include <linux/instrumented.h>
 
 #define PIPE_PARANOIA /* for now */
 
@@ -138,7 +139,7 @@
 static int copyout(void __user *to, const void *from, size_t n)
 {
 	if (access_ok(to, n)) {
-		kasan_check_read(from, n);
+		instrument_copy_to_user(to, from, n);
 		n = raw_copy_to_user(to, from, n);
 	}
 	return n;
@@ -147,7 +148,7 @@ static int copyout(void __user *to, const void *from, size_t n)
 static int copyin(void *to, const void __user *from, size_t n)
 {
 	if (access_ok(from, n)) {
-		kasan_check_write(to, n);
+		instrument_copy_from_user(to, from, n);
 		n = raw_copy_from_user(to, from, n);
 	}
 	return n;
@@ -639,7 +640,7 @@ EXPORT_SYMBOL(_copy_to_iter);
 static int copyout_mcsafe(void __user *to, const void *from, size_t n)
 {
 	if (access_ok(to, n)) {
-		kasan_check_read(from, n);
+		instrument_copy_to_user(to, from, n);
 		n = copy_to_user_mcsafe((__force void *) to, from, n);
 	}
 	return n;
diff --git a/lib/usercopy.c b/lib/usercopy.c
index ca2a697a2061..b26509f112f9 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/uaccess.h>
 #include <linux/bitops.h>
+#include <linux/instrumented.h>
+#include <linux/uaccess.h>
 
 /* out-of-line parts */
 
@@ -10,7 +11,7 @@ unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n
 	unsigned long res = n;
 	might_fault();
 	if (likely(access_ok(from, n))) {
-		kasan_check_write(to, n);
+		instrument_copy_from_user(to, from, n);
 		res = raw_copy_from_user(to, from, n);
 	}
 	if (unlikely(res))
@@ -25,7 +26,7 @@ unsigned long _copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	might_fault();
 	if (likely(access_ok(to, n))) {
-		kasan_check_read(from, n);
+		instrument_copy_to_user(to, from, n);
 		n = raw_copy_to_user(to, from, n);
 	}
 	return n;
diff --git a/mm/Makefile b/mm/Makefile
index 662fd1504646..fa91e963c2f9 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -8,6 +8,14 @@ KASAN_SANITIZE_slab.o := n
 KASAN_SANITIZE_slub.o := n
 KCSAN_SANITIZE_kmemleak.o := n
 
+# These produce frequent data race reports: most of them are due to races on
+# the same word but accesses to different bits of that word. Re-enable KCSAN
+# for these when we have more consensus on what to do about them.
+KCSAN_SANITIZE_slab_common.o := n
+KCSAN_SANITIZE_slab.o := n
+KCSAN_SANITIZE_slub.o := n
+KCSAN_SANITIZE_page_alloc.o := n
+
 # These files are disabled because they produce non-interesting and/or
 # flaky coverage that is not a function of syscall inputs. E.g. slab is out of
 # free pages, or a task is migrated between nodes.
diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
new file mode 100644
index 000000000000..bd4da1af5953
--- /dev/null
+++ b/scripts/Makefile.kcsan
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0
+ifdef CONFIG_KCSAN
+
+# GCC and Clang accept backend options differently. Do not wrap in cc-option,
+# because Clang accepts "--param" even if it is unused.
+ifdef CONFIG_CC_IS_CLANG
+cc-param = -mllvm -$(1)
+else
+cc-param = --param -$(1)
+endif
+
+# Keep most options here optional, to allow enabling more compilers if absence
+# of some options does not break KCSAN nor causes false positive reports.
+CFLAGS_KCSAN := -fsanitize=thread \
+	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls) \
+	$(call cc-option,$(call cc-param,tsan-instrument-read-before-write=1)) \
+	$(call cc-param,tsan-distinguish-volatile=1)
+
+endif # CONFIG_KCSAN
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 127f2a7e3ced..e3f047692aeb 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -152,6 +152,16 @@ _c_flags += $(if $(patsubst n%,, \
 	$(CFLAGS_KCOV))
 endif
 
+#
+# Enable KCSAN flags except some files or directories we don't want to check
+# (depends on variables KCSAN_SANITIZE_obj.o, KCSAN_SANITIZE)
+#
+ifeq ($(CONFIG_KCSAN),y)
+_c_flags += $(if $(patsubst n%,, \
+	$(KCSAN_SANITIZE_$(basetarget).o)$(KCSAN_SANITIZE)y), \
+	$(CFLAGS_KCSAN))
+endif
+
 # $(srctree)/$(src) for including checkin headers from generated source files
 # $(objtree)/$(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)
diff --git a/scripts/atomic/fallbacks/acquire b/scripts/atomic/fallbacks/acquire
index e38871e64db6..59c00529dc7c 100755
--- a/scripts/atomic/fallbacks/acquire
+++ b/scripts/atomic/fallbacks/acquire
@@ -1,8 +1,8 @@
 cat <<EOF
-static inline ${ret}
-${atomic}_${pfx}${name}${sfx}_acquire(${params})
+static __always_inline ${ret}
+${arch}${atomic}_${pfx}${name}${sfx}_acquire(${params})
 {
-	${ret} ret = ${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	${ret} ret = ${arch}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 	__atomic_acquire_fence();
 	return ret;
 }
diff --git a/scripts/atomic/fallbacks/add_negative b/scripts/atomic/fallbacks/add_negative
index e6f4815637de..a66635bceefb 100755
--- a/scripts/atomic/fallbacks/add_negative
+++ b/scripts/atomic/fallbacks/add_negative
@@ -1,6 +1,6 @@
 cat <<EOF
 /**
- * ${atomic}_add_negative - add and test if negative
+ * ${arch}${atomic}_add_negative - add and test if negative
  * @i: integer value to add
  * @v: pointer of type ${atomic}_t
  *
@@ -8,9 +8,9 @@ cat <<EOF
  * if the result is negative, or false when
  * result is greater than or equal to zero.
  */
-static inline bool
-${atomic}_add_negative(${int} i, ${atomic}_t *v)
+static __always_inline bool
+${arch}${atomic}_add_negative(${int} i, ${atomic}_t *v)
 {
-	return ${atomic}_add_return(i, v) < 0;
+	return ${arch}${atomic}_add_return(i, v) < 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/add_unless b/scripts/atomic/fallbacks/add_unless
index 792533885fbf..2ff598a3f9ec 100755
--- a/scripts/atomic/fallbacks/add_unless
+++ b/scripts/atomic/fallbacks/add_unless
@@ -1,6 +1,6 @@
 cat << EOF
 /**
- * ${atomic}_add_unless - add unless the number is already a given value
+ * ${arch}${atomic}_add_unless - add unless the number is already a given value
  * @v: pointer of type ${atomic}_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -8,9 +8,9 @@ cat << EOF
  * Atomically adds @a to @v, if @v was not already @u.
  * Returns true if the addition was done.
  */
-static inline bool
-${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
+static __always_inline bool
+${arch}${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
-	return ${atomic}_fetch_add_unless(v, a, u) != u;
+	return ${arch}${atomic}_fetch_add_unless(v, a, u) != u;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/andnot b/scripts/atomic/fallbacks/andnot
index 9f3a3216b5e3..3f18663dcefb 100755
--- a/scripts/atomic/fallbacks/andnot
+++ b/scripts/atomic/fallbacks/andnot
@@ -1,7 +1,7 @@
 cat <<EOF
-static inline ${ret}
-${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
+static __always_inline ${ret}
+${arch}${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
 {
-	${retstmt}${atomic}_${pfx}and${sfx}${order}(~i, v);
+	${retstmt}${arch}${atomic}_${pfx}and${sfx}${order}(~i, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec b/scripts/atomic/fallbacks/dec
index 10bbc82be31d..e2e01f0574bb 100755
--- a/scripts/atomic/fallbacks/dec
+++ b/scripts/atomic/fallbacks/dec
@@ -1,7 +1,7 @@
 cat <<EOF
-static inline ${ret}
-${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
+static __always_inline ${ret}
+${arch}${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
 {
-	${retstmt}${atomic}_${pfx}sub${sfx}${order}(1, v);
+	${retstmt}${arch}${atomic}_${pfx}sub${sfx}${order}(1, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec_and_test b/scripts/atomic/fallbacks/dec_and_test
index 0ce7103b3df2..e8a5e492eb5f 100755
--- a/scripts/atomic/fallbacks/dec_and_test
+++ b/scripts/atomic/fallbacks/dec_and_test
@@ -1,15 +1,15 @@
 cat <<EOF
 /**
- * ${atomic}_dec_and_test - decrement and test
+ * ${arch}${atomic}_dec_and_test - decrement and test
  * @v: pointer of type ${atomic}_t
  *
  * Atomically decrements @v by 1 and
  * returns true if the result is 0, or false for all other
  * cases.
  */
-static inline bool
-${atomic}_dec_and_test(${atomic}_t *v)
+static __always_inline bool
+${arch}${atomic}_dec_and_test(${atomic}_t *v)
 {
-	return ${atomic}_dec_return(v) == 0;
+	return ${arch}${atomic}_dec_return(v) == 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec_if_positive b/scripts/atomic/fallbacks/dec_if_positive
index c52eacec43c8..527adec89c37 100755
--- a/scripts/atomic/fallbacks/dec_if_positive
+++ b/scripts/atomic/fallbacks/dec_if_positive
@@ -1,14 +1,14 @@
 cat <<EOF
-static inline ${ret}
-${atomic}_dec_if_positive(${atomic}_t *v)
+static __always_inline ${ret}
+${arch}${atomic}_dec_if_positive(${atomic}_t *v)
 {
-	${int} dec, c = ${atomic}_read(v);
+	${int} dec, c = ${arch}${atomic}_read(v);
 
 	do {
 		dec = c - 1;
 		if (unlikely(dec < 0))
 			break;
-	} while (!${atomic}_try_cmpxchg(v, &c, dec));
+	} while (!${arch}${atomic}_try_cmpxchg(v, &c, dec));
 
 	return dec;
 }
diff --git a/scripts/atomic/fallbacks/dec_unless_positive b/scripts/atomic/fallbacks/dec_unless_positive
index 8a2578f14268..dcab6848ca1e 100755
--- a/scripts/atomic/fallbacks/dec_unless_positive
+++ b/scripts/atomic/fallbacks/dec_unless_positive
@@ -1,13 +1,13 @@
 cat <<EOF
-static inline bool
-${atomic}_dec_unless_positive(${atomic}_t *v)
+static __always_inline bool
+${arch}${atomic}_dec_unless_positive(${atomic}_t *v)
 {
-	${int} c = ${atomic}_read(v);
+	${int} c = ${arch}${atomic}_read(v);
 
 	do {
 		if (unlikely(c > 0))
 			return false;
-	} while (!${atomic}_try_cmpxchg(v, &c, c - 1));
+	} while (!${arch}${atomic}_try_cmpxchg(v, &c, c - 1));
 
 	return true;
 }
diff --git a/scripts/atomic/fallbacks/fence b/scripts/atomic/fallbacks/fence
index 82f68fa6931a..3764fc8ce945 100755
--- a/scripts/atomic/fallbacks/fence
+++ b/scripts/atomic/fallbacks/fence
@@ -1,10 +1,10 @@
 cat <<EOF
-static inline ${ret}
-${atomic}_${pfx}${name}${sfx}(${params})
+static __always_inline ${ret}
+${arch}${atomic}_${pfx}${name}${sfx}(${params})
 {
 	${ret} ret;
 	__atomic_pre_full_fence();
-	ret = ${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	ret = ${arch}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 	__atomic_post_full_fence();
 	return ret;
 }
diff --git a/scripts/atomic/fallbacks/fetch_add_unless b/scripts/atomic/fallbacks/fetch_add_unless
index d2c091db7eae..0e0b9aef1515 100755
--- a/scripts/atomic/fallbacks/fetch_add_unless
+++ b/scripts/atomic/fallbacks/fetch_add_unless
@@ -1,6 +1,6 @@
 cat << EOF
 /**
- * ${atomic}_fetch_add_unless - add unless the number is already a given value
+ * ${arch}${atomic}_fetch_add_unless - add unless the number is already a given value
  * @v: pointer of type ${atomic}_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -8,15 +8,15 @@ cat << EOF
  * Atomically adds @a to @v, so long as @v was not already @u.
  * Returns original value of @v
  */
-static inline ${int}
-${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
+static __always_inline ${int}
+${arch}${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
-	${int} c = ${atomic}_read(v);
+	${int} c = ${arch}${atomic}_read(v);
 
 	do {
 		if (unlikely(c == u))
 			break;
-	} while (!${atomic}_try_cmpxchg(v, &c, c + a));
+	} while (!${arch}${atomic}_try_cmpxchg(v, &c, c + a));
 
 	return c;
 }
diff --git a/scripts/atomic/fallbacks/inc b/scripts/atomic/fallbacks/inc
index f866b3ad2353..15ec62946e8c 100755
--- a/scripts/atomic/fallbacks/inc
+++ b/scripts/atomic/fallbacks/inc
@@ -1,7 +1,7 @@
 cat <<EOF
-static inline ${ret}
-${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
+static __always_inline ${ret}
+${arch}${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
 {
-	${retstmt}${atomic}_${pfx}add${sfx}${order}(1, v);
+	${retstmt}${arch}${atomic}_${pfx}add${sfx}${order}(1, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_and_test b/scripts/atomic/fallbacks/inc_and_test
index 4e2068869f7e..cecc8322a21f 100755
--- a/scripts/atomic/fallbacks/inc_and_test
+++ b/scripts/atomic/fallbacks/inc_and_test
@@ -1,15 +1,15 @@
 cat <<EOF
 /**
- * ${atomic}_inc_and_test - increment and test
+ * ${arch}${atomic}_inc_and_test - increment and test
  * @v: pointer of type ${atomic}_t
  *
  * Atomically increments @v by 1
  * and returns true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
-${atomic}_inc_and_test(${atomic}_t *v)
+static __always_inline bool
+${arch}${atomic}_inc_and_test(${atomic}_t *v)
 {
-	return ${atomic}_inc_return(v) == 0;
+	return ${arch}${atomic}_inc_return(v) == 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_not_zero b/scripts/atomic/fallbacks/inc_not_zero
index a7c45c8d107c..50f2d4d48279 100755
--- a/scripts/atomic/fallbacks/inc_not_zero
+++ b/scripts/atomic/fallbacks/inc_not_zero
@@ -1,14 +1,14 @@
 cat <<EOF
 /**
- * ${atomic}_inc_not_zero - increment unless the number is zero
+ * ${arch}${atomic}_inc_not_zero - increment unless the number is zero
  * @v: pointer of type ${atomic}_t
  *
  * Atomically increments @v by 1, if @v is non-zero.
  * Returns true if the increment was done.
  */
-static inline bool
-${atomic}_inc_not_zero(${atomic}_t *v)
+static __always_inline bool
+${arch}${atomic}_inc_not_zero(${atomic}_t *v)
 {
-	return ${atomic}_add_unless(v, 1, 0);
+	return ${arch}${atomic}_add_unless(v, 1, 0);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_unless_negative b/scripts/atomic/fallbacks/inc_unless_negative
index 0c266e71dbd4..87629e0d4a80 100755
--- a/scripts/atomic/fallbacks/inc_unless_negative
+++ b/scripts/atomic/fallbacks/inc_unless_negative
@@ -1,13 +1,13 @@
 cat <<EOF
-static inline bool
-${atomic}_inc_unless_negative(${atomic}_t *v)
+static __always_inline bool
+${arch}${atomic}_inc_unless_negative(${atomic}_t *v)
 {
-	${int} c = ${atomic}_read(v);
+	${int} c = ${arch}${atomic}_read(v);
 
 	do {
 		if (unlikely(c < 0))
 			return false;
-	} while (!${atomic}_try_cmpxchg(v, &c, c + 1));
+	} while (!${arch}${atomic}_try_cmpxchg(v, &c, c + 1));
 
 	return true;
 }
diff --git a/scripts/atomic/fallbacks/read_acquire b/scripts/atomic/fallbacks/read_acquire
index 75863b5203f7..341a88dccaa7 100755
--- a/scripts/atomic/fallbacks/read_acquire
+++ b/scripts/atomic/fallbacks/read_acquire
@@ -1,6 +1,6 @@
 cat <<EOF
-static inline ${ret}
-${atomic}_read_acquire(const ${atomic}_t *v)
+static __always_inline ${ret}
+${arch}${atomic}_read_acquire(const ${atomic}_t *v)
 {
 	return smp_load_acquire(&(v)->counter);
 }
diff --git a/scripts/atomic/fallbacks/release b/scripts/atomic/fallbacks/release
index 3f628a3802d9..f8906d537c0f 100755
--- a/scripts/atomic/fallbacks/release
+++ b/scripts/atomic/fallbacks/release
@@ -1,8 +1,8 @@
 cat <<EOF
-static inline ${ret}
-${atomic}_${pfx}${name}${sfx}_release(${params})
+static __always_inline ${ret}
+${arch}${atomic}_${pfx}${name}${sfx}_release(${params})
 {
 	__atomic_release_fence();
-	${retstmt}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	${retstmt}${arch}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 }
 EOF
diff --git a/scripts/atomic/fallbacks/set_release b/scripts/atomic/fallbacks/set_release
index 45bb5e0cfc08..76068272d5f5 100755
--- a/scripts/atomic/fallbacks/set_release
+++ b/scripts/atomic/fallbacks/set_release
@@ -1,6 +1,6 @@
 cat <<EOF
-static inline void
-${atomic}_set_release(${atomic}_t *v, ${int} i)
+static __always_inline void
+${arch}${atomic}_set_release(${atomic}_t *v, ${int} i)
 {
 	smp_store_release(&(v)->counter, i);
 }
diff --git a/scripts/atomic/fallbacks/sub_and_test b/scripts/atomic/fallbacks/sub_and_test
index 289ef17a2d7a..c580f4c2136e 100755
--- a/scripts/atomic/fallbacks/sub_and_test
+++ b/scripts/atomic/fallbacks/sub_and_test
@@ -1,6 +1,6 @@
 cat <<EOF
 /**
- * ${atomic}_sub_and_test - subtract value from variable and test result
+ * ${arch}${atomic}_sub_and_test - subtract value from variable and test result
  * @i: integer value to subtract
  * @v: pointer of type ${atomic}_t
  *
@@ -8,9 +8,9 @@ cat <<EOF
  * true if the result is zero, or false for all
  * other cases.
  */
-static inline bool
-${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
+static __always_inline bool
+${arch}${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
 {
-	return ${atomic}_sub_return(i, v) == 0;
+	return ${arch}${atomic}_sub_return(i, v) == 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/try_cmpxchg b/scripts/atomic/fallbacks/try_cmpxchg
index 4ed85e2f5378..06db0f738e45 100755
--- a/scripts/atomic/fallbacks/try_cmpxchg
+++ b/scripts/atomic/fallbacks/try_cmpxchg
@@ -1,9 +1,9 @@
 cat <<EOF
-static inline bool
-${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
+static __always_inline bool
+${arch}${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
 {
 	${int} r, o = *old;
-	r = ${atomic}_cmpxchg${order}(v, o, new);
+	r = ${arch}${atomic}_cmpxchg${order}(v, o, new);
 	if (unlikely(r != o))
 		*old = r;
 	return likely(r == o);
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index 1bd7c1707633..0fd1cf0c2b94 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -2,10 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ATOMICDIR=$(dirname $0)
+ARCH=$2
 
 . ${ATOMICDIR}/atomic-tbl.sh
 
-#gen_template_fallback(template, meta, pfx, name, sfx, order, atomic, int, args...)
+#gen_template_fallback(template, meta, pfx, name, sfx, order, arch, atomic, int, args...)
 gen_template_fallback()
 {
 	local template="$1"; shift
@@ -14,10 +15,11 @@ gen_template_fallback()
 	local name="$1"; shift
 	local sfx="$1"; shift
 	local order="$1"; shift
+	local arch="$1"; shift
 	local atomic="$1"; shift
 	local int="$1"; shift
 
-	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
+	local atomicname="${arch}${atomic}_${pfx}${name}${sfx}${order}"
 
 	local ret="$(gen_ret_type "${meta}" "${int}")"
 	local retstmt="$(gen_ret_stmt "${meta}")"
@@ -32,7 +34,7 @@ gen_template_fallback()
 	fi
 }
 
-#gen_proto_fallback(meta, pfx, name, sfx, order, atomic, int, args...)
+#gen_proto_fallback(meta, pfx, name, sfx, order, arch, atomic, int, args...)
 gen_proto_fallback()
 {
 	local meta="$1"; shift
@@ -56,16 +58,17 @@ cat << EOF
 EOF
 }
 
-#gen_proto_order_variants(meta, pfx, name, sfx, atomic, int, args...)
+#gen_proto_order_variants(meta, pfx, name, sfx, arch, atomic, int, args...)
 gen_proto_order_variants()
 {
 	local meta="$1"; shift
 	local pfx="$1"; shift
 	local name="$1"; shift
 	local sfx="$1"; shift
-	local atomic="$1"
+	local arch="$1"
+	local atomic="$2"
 
-	local basename="${atomic}_${pfx}${name}${sfx}"
+	local basename="${arch}${atomic}_${pfx}${name}${sfx}"
 
 	local template="$(find_fallback_template "${pfx}" "${name}" "${sfx}" "${order}")"
 
@@ -94,7 +97,7 @@ gen_proto_order_variants()
 	gen_basic_fallbacks "${basename}"
 
 	if [ ! -z "${template}" ]; then
-		printf "#endif /* ${atomic}_${pfx}${name}${sfx} */\n\n"
+		printf "#endif /* ${arch}${atomic}_${pfx}${name}${sfx} */\n\n"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
@@ -149,20 +152,19 @@ cat << EOF
 #ifndef _LINUX_ATOMIC_FALLBACK_H
 #define _LINUX_ATOMIC_FALLBACK_H
 
+#include <linux/compiler.h>
+
 EOF
 
-for xchg in "xchg" "cmpxchg" "cmpxchg64"; do
+for xchg in "${ARCH}xchg" "${ARCH}cmpxchg" "${ARCH}cmpxchg64"; do
 	gen_xchg_fallbacks "${xchg}"
 done
 
 grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
+	gen_proto "${meta}" "${name}" "${ARCH}" "atomic" "int" ${args}
 done
 
 cat <<EOF
-#define atomic_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
-#define atomic_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
-
 #ifdef CONFIG_GENERIC_ATOMIC64
 #include <asm-generic/atomic64.h>
 #endif
@@ -170,12 +172,9 @@ cat <<EOF
 EOF
 
 grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
+	gen_proto "${meta}" "${name}" "${ARCH}" "atomic64" "s64" ${args}
 done
 
 cat <<EOF
-#define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
-#define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
-
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
 EOF
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index e09812372b17..6afadf73da17 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -20,7 +20,7 @@ gen_param_check()
 	# We don't write to constant parameters
 	[ ${type#c} != ${type} ] && rw="read"
 
-	printf "\tkasan_check_${rw}(${name}, sizeof(*${name}));\n"
+	printf "\tinstrument_atomic_${rw}(${name}, sizeof(*${name}));\n"
 }
 
 #gen_param_check(arg...)
@@ -84,7 +84,7 @@ gen_proto_order_variant()
 	[ ! -z "${guard}" ] && printf "#if ${guard}\n"
 
 cat <<EOF
-static inline ${ret}
+static __always_inline ${ret}
 ${atomicname}(${params})
 {
 ${checks}
@@ -107,7 +107,7 @@ cat <<EOF
 #define ${xchg}(ptr, ...)						\\
 ({									\\
 	typeof(ptr) __ai_ptr = (ptr);					\\
-	kasan_check_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));		\\
+	instrument_atomic_write(__ai_ptr, ${mult}sizeof(*__ai_ptr));		\\
 	arch_${xchg}(__ai_ptr, __VA_ARGS__);				\\
 })
 EOF
@@ -147,7 +147,8 @@ cat << EOF
 #define _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
 
 #include <linux/build_bug.h>
-#include <linux/kasan-checks.h>
+#include <linux/compiler.h>
+#include <linux/instrumented.h>
 
 EOF
 
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
index c240a7231b2e..e318d3f92e53 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -46,7 +46,7 @@ gen_proto_order_variant()
 	local retstmt="$(gen_ret_stmt "${meta}")"
 
 cat <<EOF
-static inline ${ret}
+static __always_inline ${ret}
 atomic_long_${name}(${params})
 {
 	${retstmt}${atomic}_${name}(${argscast});
@@ -64,6 +64,7 @@ cat << EOF
 #ifndef _ASM_GENERIC_ATOMIC_LONG_H
 #define _ASM_GENERIC_ATOMIC_LONG_H
 
+#include <linux/compiler.h>
 #include <asm/types.h>
 
 #ifdef CONFIG_64BIT
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
index 000dc6437893..d29e159ef489 100644
--- a/scripts/atomic/gen-atomics.sh
+++ b/scripts/atomic/gen-atomics.sh
@@ -10,10 +10,11 @@ LINUXDIR=${ATOMICDIR}/../..
 cat <<EOF |
 gen-atomic-instrumented.sh      asm-generic/atomic-instrumented.h
 gen-atomic-long.sh              asm-generic/atomic-long.h
+gen-atomic-fallback.sh          linux/atomic-arch-fallback.h		arch_
 gen-atomic-fallback.sh          linux/atomic-fallback.h
 EOF
-while read script header; do
-	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} > ${LINUXDIR}/include/${header}
+while read script header args; do
+	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} ${args} > ${LINUXDIR}/include/${header}
 	HASH="$(sha1sum ${LINUXDIR}/include/${header})"
 	HASH="${HASH%% *}"
 	printf "// %s\n" "${HASH}" >> ${LINUXDIR}/include/${header}
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 197436b20288..cfb5d42c54de 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5945,6 +5945,14 @@ sub process {
 			}
 		}
 
+# check for data_race without a comment.
+		if ($line =~ /\bdata_race\s*\(/) {
+			if (!ctx_has_comment($first_line, $linenr)) {
+				WARN("DATA_RACE",
+				     "data_race without comment\n" . $herecurr);
+			}
+		}
+
 # check for smp_read_barrier_depends and read_barrier_depends
 		if (!$file && $line =~ /\b(smp_|)read_barrier_depends\s*\(/) {
 			WARN("READ_BARRIER_DEPENDS",
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 63d65a702900..5fbb90a80d23 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -505,6 +505,28 @@ static const char *uaccess_safe_builtin[] = {
 	"__asan_report_store4_noabort",
 	"__asan_report_store8_noabort",
 	"__asan_report_store16_noabort",
+	/* KCSAN */
+	"__kcsan_check_access",
+	"kcsan_found_watchpoint",
+	"kcsan_setup_watchpoint",
+	"kcsan_check_scoped_accesses",
+	"kcsan_disable_current",
+	"kcsan_enable_current_nowarn",
+	/* KCSAN/TSAN */
+	"__tsan_func_entry",
+	"__tsan_func_exit",
+	"__tsan_read_range",
+	"__tsan_write_range",
+	"__tsan_read1",
+	"__tsan_read2",
+	"__tsan_read4",
+	"__tsan_read8",
+	"__tsan_read16",
+	"__tsan_write1",
+	"__tsan_write2",
+	"__tsan_write4",
+	"__tsan_write8",
+	"__tsan_write16",
 	/* KCOV */
 	"write_comp_data",
 	"check_kcov_mode",

