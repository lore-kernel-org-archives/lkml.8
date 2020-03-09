Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ABFC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45A2E20873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780691;
	bh=d7bFiCcoenMHmSeqgJZPLiXVTHM0uY6+TD4EXBmi8wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fWYKJye1NlNRkIlnDe44COVUC4q0T5Aec+MEwwcVOa4P76VdGBRQSLOryRkfqYmp6
	 Hf6k8Kx+aJ4NEoLqOd6Ky5gdTrVIBe2De3SaGGbyiavm2v7TQ12WSHRJFgyJSseFcW
	 yaWLrxqDEjC2U2z7kOZ7jwwvTRyHKl4cJ4m3XgTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgCITEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbgCITEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:04:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBAF824670;
        Mon,  9 Mar 2020 19:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780670;
        bh=d7bFiCcoenMHmSeqgJZPLiXVTHM0uY6+TD4EXBmi8wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekbeaMqFI7LJ9/Crp28wQaFzUVcYl6kArwRL9zA00M7DoBzXqAL+lvHv2R4TCrSbz
         kEvB6MCWcqj5cohkA50s1iPYyZLYcRmxu38zOEyltAnde3+HPGEmGJ7FB8cxdkqXGm
         3yikAyK+ejsWYs/aXTubeTh6wYN2T/GARZdxDkto=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 31/32] kcsan: Update Documentation/dev-tools/kcsan.rst
Date:   Mon,  9 Mar 2020 12:04:19 -0700
Message-Id: <20200309190420.6100-31-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200309190359.GA5822@paulmck-ThinkPad-P72>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Extend and improve based on recent changes, and summarize important
bits that have been missing. Tested with "make htmldocs".

Signed-off-by: Marco Elver <elver@google.com>
Cc: Qian Cai <cai@lca.pw>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/dev-tools/kcsan.rst | 227 ++++++++++++++++++++++++--------------
 1 file changed, 144 insertions(+), 83 deletions(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index 65a0be5..52a5d6f 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -1,27 +1,22 @@
 The Kernel Concurrency Sanitizer (KCSAN)
 ========================================
 
-Overview
---------
-
-*Kernel Concurrency Sanitizer (KCSAN)* is a dynamic data race detector for
-kernel space. KCSAN is a sampling watchpoint-based data race detector. Key
-priorities in KCSAN's design are lack of false positives, scalability, and
-simplicity. More details can be found in `Implementation Details`_.
-
-KCSAN uses compile-time instrumentation to instrument memory accesses. KCSAN is
-supported in both GCC and Clang. With GCC it requires version 7.3.0 or later.
-With Clang it requires version 7.0.0 or later.
+The Kernel Concurrency Sanitizer (KCSAN) is a dynamic race detector, which
+relies on compile-time instrumentation, and uses a watchpoint-based sampling
+approach to detect races. KCSAN's primary purpose is to detect `data races`_.
 
 Usage
 -----
 
-To enable KCSAN configure kernel with::
+KCSAN is supported in both GCC and Clang. With GCC it requires version 7.3.0 or
+later. With Clang it requires version 7.0.0 or later.
+
+To enable KCSAN configure the kernel with::
 
     CONFIG_KCSAN = y
 
 KCSAN provides several other configuration options to customize behaviour (see
-their respective help text for more info).
+the respective help text in ``lib/Kconfig.kcsan`` for more info).
 
 Error reports
 ~~~~~~~~~~~~~
@@ -96,7 +91,8 @@ The other less common type of data race report looks like this::
 This report is generated where it was not possible to determine the other
 racing thread, but a race was inferred due to the data value of the watched
 memory location having changed. These can occur either due to missing
-instrumentation or e.g. DMA accesses.
+instrumentation or e.g. DMA accesses. These reports will only be generated if
+``CONFIG_KCSAN_REPORT_RACE_UNKNOWN_ORIGIN=y`` (selected by default).
 
 Selective analysis
 ~~~~~~~~~~~~~~~~~~
@@ -110,9 +106,26 @@ the below options are available:
   behaviour when encountering a data race is deemed safe.
 
 * Disabling data race detection for entire functions can be accomplished by
-  using the function attribute ``__no_kcsan`` (or ``__no_kcsan_or_inline`` for
-  ``__always_inline`` functions). To dynamically control for which functions
-  data races are reported, see the `debugfs`_ blacklist/whitelist feature.
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
+  Note: Older compiler versions (GCC < 9) also do not always honor the
+  ``__no_kcsan`` attribute on regular ``inline`` functions. If false positives
+  with these compilers cannot be tolerated, for small functions where
+  ``__always_inline`` would be appropriate, ``__no_kcsan_or_inline`` should be
+  preferred instead.
 
 * To disable data race detection for a particular compilation unit, add to the
   ``Makefile``::
@@ -124,13 +137,29 @@ the below options are available:
 
     KCSAN_SANITIZE := n
 
-debugfs
-~~~~~~~
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
 
-* The file ``/sys/kernel/debug/kcsan`` can be read to get stats.
+* Reading ``/sys/kernel/debug/kcsan`` returns various runtime statistics.
 
-* KCSAN can be turned on or off by writing ``on`` or ``off`` to
-  ``/sys/kernel/debug/kcsan``.
+* Writing ``on`` or ``off`` to ``/sys/kernel/debug/kcsan`` allows turning KCSAN
+  on or off, respectively.
 
 * Writing ``!some_func_name`` to ``/sys/kernel/debug/kcsan`` adds
   ``some_func_name`` to the report filter list, which (by default) blacklists
@@ -142,91 +171,120 @@ debugfs
   can be used to silence frequently occurring data races; the whitelist feature
   can help with reproduction and testing of fixes.
 
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
 Data Races
 ----------
 
-Informally, two operations *conflict* if they access the same memory location,
-and at least one of them is a write operation. In an execution, two memory
-operations from different threads form a **data race** if they *conflict*, at
-least one of them is a *plain access* (non-atomic), and they are *unordered* in
-the "happens-before" order according to the `LKMM
-<../../tools/memory-model/Documentation/explanation.txt>`_.
+In an execution, two memory accesses form a *data race* if they *conflict*,
+they happen concurrently in different threads, and at least one of them is a
+*plain access*; they *conflict* if both access the same memory location, and at
+least one is a write. For a more thorough discussion and definition, see `"Plain
+Accesses and Data Races" in the LKMM`_.
+
+.. _"Plain Accesses and Data Races" in the LKMM: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/explanation.txt#n1922
 
-Relationship with the Linux Kernel Memory Model (LKMM)
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Relationship with the Linux-Kernel Memory Consistency Model (LKMM)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The LKMM defines the propagation and ordering rules of various memory
 operations, which gives developers the ability to reason about concurrent code.
 Ultimately this allows to determine the possible executions of concurrent code,
 and if that code is free from data races.
 
-KCSAN is aware of *atomic* accesses (``READ_ONCE``, ``WRITE_ONCE``,
-``atomic_*``, etc.), but is oblivious of any ordering guarantees. In other
-words, KCSAN assumes that as long as a plain access is not observed to race
-with another conflicting access, memory operations are correctly ordered.
+KCSAN is aware of *marked atomic operations* (``READ_ONCE``, ``WRITE_ONCE``,
+``atomic_*``, etc.), but is oblivious of any ordering guarantees and simply
+assumes that memory barriers are placed correctly. In other words, KCSAN
+assumes that as long as a plain access is not observed to race with another
+conflicting access, memory operations are correctly ordered.
 
 This means that KCSAN will not report *potential* data races due to missing
-memory ordering. If, however, missing memory ordering (that is observable with
-a particular compiler and architecture) leads to an observable data race (e.g.
-entering a critical section erroneously), KCSAN would report the resulting
-data race.
-
-Race conditions vs. data races
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Race conditions are logic bugs, where unexpected interleaving of racing
-concurrent operations result in an erroneous state.
-
-Data races on the other hand are defined at the *memory model/language level*.
-Many data races are also harmful race conditions, which a tool like KCSAN
-reports!  However, not all data races are race conditions and vice-versa.
-KCSAN's intent is to report data races according to the LKMM. A data race
-detector can only work at the memory model/language level.
-
-Deeper analysis, to find high-level race conditions only, requires conveying
-the intended kernel logic to a tool. This requires (1) the developer writing a
-specification or model of their code, and then (2) the tool verifying that the
-implementation matches. This has been done for small bits of code using model
-checkers and other formal methods, but does not scale to the level of what can
-be covered with a dynamic analysis based data race detector such as KCSAN.
-
-For reasons outlined in this `article <https://lwn.net/Articles/793253/>`_,
-data races can be much more subtle, but can cause no less harm than high-level
-race conditions.
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
+    :functions: ASSERT_EXCLUSIVE_WRITER ASSERT_EXCLUSIVE_ACCESS
+                ASSERT_EXCLUSIVE_BITS
 
 Implementation Details
 ----------------------
 
-The general approach is inspired by `DataCollider
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
 <http://usenix.org/legacy/events/osdi10/tech/full_papers/Erickson.pdf>`_.
 Unlike DataCollider, KCSAN does not use hardware watchpoints, but instead
-relies on compiler instrumentation. Watchpoints are implemented using an
-efficient encoding that stores access type, size, and address in a long; the
-benefits of using "soft watchpoints" are portability and greater flexibility in
-limiting which accesses trigger a watchpoint.
+relies on compiler instrumentation and "soft watchpoints".
 
-More specifically, KCSAN requires instrumenting plain (unmarked, non-atomic)
-memory operations; for each instrumented plain access:
+In KCSAN, watchpoints are implemented using an efficient encoding that stores
+access type, size, and address in a long; the benefits of using "soft
+watchpoints" are portability and greater flexibility. KCSAN then relies on the
+compiler instrumenting plain accesses. For each instrumented plain access:
 
 1. Check if a matching watchpoint exists; if yes, and at least one access is a
    write, then we encountered a racing access.
 
 2. Periodically, if no matching watchpoint exists, set up a watchpoint and
-   stall for a small delay.
+   stall for a small randomized delay.
 
 3. Also check the data value before the delay, and re-check the data value
    after delay; if the values mismatch, we infer a race of unknown origin.
 
-To detect data races between plain and atomic memory operations, KCSAN also
-annotates atomic accesses, but only to check if a watchpoint exists
-(``kcsan_check_atomic_*``); i.e.  KCSAN never sets up a watchpoint on atomic
-accesses.
+To detect data races between plain and marked accesses, KCSAN also annotates
+marked accesses, but only to check if a watchpoint exists; i.e. KCSAN never
+sets up a watchpoint on marked accesses. By never setting up watchpoints for
+marked operations, if all accesses to a variable that is accessed concurrently
+are properly marked, KCSAN will never trigger a watchpoint and therefore never
+report the accesses.
 
 Key Properties
 ~~~~~~~~~~~~~~
 
-1. **Memory Overhead:**  The current implementation uses a small array of longs
-   to encode watchpoint information, which is negligible.
+1. **Memory Overhead:**  The overall memory overhead is only a few MiB
+   depending on configuration. The current implementation uses a small array of
+   longs to encode watchpoint information, which is negligible.
 
 2. **Performance Overhead:** KCSAN's runtime aims to be minimal, using an
    efficient watchpoint encoding that does not require acquiring any shared
@@ -253,14 +311,17 @@ Key Properties
 Alternatives Considered
 -----------------------
 
-An alternative data race detection approach for the kernel can be found in
+An alternative data race detection approach for the kernel can be found in the
 `Kernel Thread Sanitizer (KTSAN) <https://github.com/google/ktsan/wiki>`_.
 KTSAN is a happens-before data race detector, which explicitly establishes the
 happens-before order between memory operations, which can then be used to
-determine data races as defined in `Data Races`_. To build a correct
-happens-before relation, KTSAN must be aware of all ordering rules of the LKMM
-and synchronization primitives. Unfortunately, any omission leads to false
-positives, which is especially important in the context of the kernel which
-includes numerous custom synchronization mechanisms. Furthermore, KTSAN's
-implementation requires metadata for each memory location (shadow memory);
-currently, for each page, KTSAN requires 4 pages of shadow memory.
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
-- 
2.9.5

