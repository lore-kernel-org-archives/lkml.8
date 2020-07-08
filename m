Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A73AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 02:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C9720708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 02:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgGHCuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 22:50:12 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:38094 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbgGHCuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 22:50:12 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 06F7ABC117;
        Wed,  8 Jul 2020 02:50:02 +0000 (UTC)
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, tglx@linutronix.de,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, dvhart@infradead.org,
        adrian.hunter@intel.com, yao.jin@linux.intel.com,
        ravi.bangoria@linux.ibm.com, gustavoars@kernel.org,
        ak@linux.intel.com, devurandom@gmx.net, mail@maciej.szmigiero.name,
        songliubraving@fb.com, srikar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: [PATCH] Replace HTTP links with HTTPS ones: performance events
Date:   Wed,  8 Jul 2020 04:49:56 +0200
Message-Id: <20200708024956.57732-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rationale:
Reduces attack surface on kernel devs opening the links for MITM
as HTTPS traffic is much harder to manipulate.

Deterministic algorithm:
For each file:
  If not .svg:
    For each line:
      If doesn't contain `\bxmlns\b`:
        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
          If both the HTTP and HTTPS versions
          return 200 OK and serve the same content:
            Replace HTTP with HTTPS.

Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
---
 Continuing my work started at 93431e0607e5.
 See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master

 If there are any URLs to be removed completely or at least not HTTPSified:
 Just clearly say so and I'll *undo my change*.
 See also: https://lkml.org/lkml/2020/6/27/64

 If there are any valid, but yet not changed URLs:
 See: https://lkml.org/lkml/2020/6/26/837

 If you apply the patch, please let me know.
 Rationale:
 I'd like not to submit patches much faster than you maintainers apply them.

 arch/x86/events/intel/pt.c                         | 2 +-
 arch/x86/events/intel/pt.h                         | 2 +-
 tools/perf/Documentation/perf-data.txt             | 2 +-
 tools/perf/Documentation/perf-list.txt             | 4 ++--
 tools/perf/arch/powerpc/include/dwarf-regs-table.h | 2 +-
 tools/perf/arch/powerpc/util/dwarf-regs.c          | 2 +-
 tools/perf/arch/s390/include/dwarf-regs-table.h    | 2 +-
 tools/perf/bench/futex.h                           | 2 +-
 tools/perf/bench/sched-pipe.c                      | 2 +-
 tools/perf/builtin-c2c.c                           | 2 +-
 tools/perf/builtin-trace.c                         | 2 +-
 tools/perf/scripts/python/futex-contention.py      | 2 +-
 tools/perf/util/annotate.h                         | 2 +-
 tools/perf/util/c++/clang.cpp                      | 2 +-
 tools/perf/util/dso.h                              | 2 +-
 tools/perf/util/stat.c                             | 4 ++--
 tools/perf/util/target.h                           | 2 +-
 17 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index e94af4a54d0d..e2e582f64a1c 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -5,7 +5,7 @@
  *
  * Intel PT is specified in the Intel Architecture Instruction Set Extensions
  * Programming Reference:
- * http://software.intel.com/en-us/intel-isa-extensions
+ * https://software.intel.com/en-us/intel-isa-extensions
  */
 
 #undef DEBUG
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 96906a62aacd..cf39f7c235a7 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -5,7 +5,7 @@
  *
  * Intel PT is specified in the Intel Architecture Instruction Set Extensions
  * Programming Reference:
- * http://software.intel.com/en-us/intel-isa-extensions
+ * https://software.intel.com/en-us/intel-isa-extensions
  */
 
 #ifndef __INTEL_PT_H__
diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
index c87180764829..deef20b92651 100644
--- a/tools/perf/Documentation/perf-data.txt
+++ b/tools/perf/Documentation/perf-data.txt
@@ -45,4 +45,4 @@ OPTIONS for 'convert'
 SEE ALSO
 --------
 linkperf:perf[1]
-[1] Common Trace Format - http://www.efficios.com/ctf
+[1] Common Trace Format - https://www.efficios.com/ctf
diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 376a50b3452d..5f3c31ce4c8c 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -309,5 +309,5 @@ SEE ALSO
 --------
 linkperf:perf-stat[1], linkperf:perf-top[1],
 linkperf:perf-record[1],
-http://www.intel.com/sdm/[Intel® 64 and IA-32 Architectures Software Developer's Manual Volume 3B: System Programming Guide],
-http://support.amd.com/us/Processor_TechDocs/24593_APM_v2.pdf[AMD64 Architecture Programmer’s Manual Volume 2: System Programming]
+https://www.intel.com/sdm/[Intel® 64 and IA-32 Architectures Software Developer's Manual Volume 3B: System Programming Guide],
+https://support.amd.com/us/Processor_TechDocs/24593_APM_v2.pdf[AMD64 Architecture Programmer’s Manual Volume 2: System Programming]
diff --git a/tools/perf/arch/powerpc/include/dwarf-regs-table.h b/tools/perf/arch/powerpc/include/dwarf-regs-table.h
index 66dc015a733d..96777c334103 100644
--- a/tools/perf/arch/powerpc/include/dwarf-regs-table.h
+++ b/tools/perf/arch/powerpc/include/dwarf-regs-table.h
@@ -4,7 +4,7 @@
 
 /*
  * Reference:
- * http://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html
+ * https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html
  * http://refspecs.linux-foundation.org/elf/elfspec_ppc.pdf
  */
 #define REG_DWARFNUM_NAME(reg, idx)	[idx] = "%" #reg
diff --git a/tools/perf/arch/powerpc/util/dwarf-regs.c b/tools/perf/arch/powerpc/util/dwarf-regs.c
index 0c4f4caf53ac..333d6b520a0a 100644
--- a/tools/perf/arch/powerpc/util/dwarf-regs.c
+++ b/tools/perf/arch/powerpc/util/dwarf-regs.c
@@ -29,7 +29,7 @@ struct pt_regs_dwarfnum {
 
 /*
  * Reference:
- * http://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html
+ * https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi-1.9.html
  */
 static const struct pt_regs_dwarfnum regdwarfnum_table[] = {
 	GPR_DWARFNUM_NAME(0),
diff --git a/tools/perf/arch/s390/include/dwarf-regs-table.h b/tools/perf/arch/s390/include/dwarf-regs-table.h
index 671553525f41..aee33de15f92 100644
--- a/tools/perf/arch/s390/include/dwarf-regs-table.h
+++ b/tools/perf/arch/s390/include/dwarf-regs-table.h
@@ -6,7 +6,7 @@
 
 /*
  * For reference, see DWARF register mapping:
- * http://refspecs.linuxfoundation.org/ELF/zSeries/lzsabi0_s390/x1542.html
+ * https://refspecs.linuxfoundation.org/ELF/zSeries/lzsabi0_s390/x1542.html
  */
 static const char * const s390_dwarf_regs[] = {
 	"%r0", "%r1",  "%r2",  "%r3",  "%r4",  "%r5",  "%r6",  "%r7",
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index 31b53cc7d5bc..382f6933fa37 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -2,7 +2,7 @@
 /*
  * Glibc independent futex library for testing kernel functionality.
  * Shamelessly stolen from Darren Hart <dvhltc@us.ibm.com>
- *    http://git.kernel.org/cgit/linux/kernel/git/dvhart/futextest.git/
+ *    https://git.kernel.org/cgit/linux/kernel/git/dvhart/futextest.git/
  */
 
 #ifndef _FUTEX_H
diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 3c88d1f201f1..29805fc93dd6 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -6,7 +6,7 @@
  * pipe: Benchmark for pipe()
  *
  * Based on pipe-test-1m.c by Ingo Molnar <mingo@redhat.com>
- *  http://people.redhat.com/mingo/cfs-scheduler/tools/pipe-test-1m.c
+ *  https://people.redhat.com/mingo/cfs-scheduler/tools/pipe-test-1m.c
  * Ported to perf by Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
  */
 #include <subcmd/parse-options.h>
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index d617d5682c68..5c6b12081ca1 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * This is rewrite of original c2c tool introduced in here:
- *   http://lwn.net/Articles/588866/
+ *   https://lwn.net/Articles/588866/
  *
  * The original tool was changed to fit in current perf state.
  *
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4cbb64edc998..b8f83ef8cfe4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -11,7 +11,7 @@
  *
  * Initially based on the 'trace' prototype by Thomas Gleixner:
  *
- * http://lwn.net/Articles/415728/ ("Announcing a new utility: 'trace'")
+ * https://lwn.net/Articles/415728/ ("Announcing a new utility: 'trace'")
  */
 
 #include "util/record.h"
diff --git a/tools/perf/scripts/python/futex-contention.py b/tools/perf/scripts/python/futex-contention.py
index 0c4841acf75d..f93a91824b59 100644
--- a/tools/perf/scripts/python/futex-contention.py
+++ b/tools/perf/scripts/python/futex-contention.py
@@ -4,7 +4,7 @@
 #
 # Translation of:
 #
-# http://sourceware.org/systemtap/wiki/WSFutexContention
+# https://sourceware.org/systemtap/wiki/WSFutexContention
 #
 # to perf python scripting.
 #
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 0a0cd4f32175..12b92bec8b2f 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -365,7 +365,7 @@ enum symbol_disassemble_errno {
 	 * errno since SUS requires the errno has distinct positive values.
 	 * See 'Issue 6' in the link below.
 	 *
-	 * http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html
+	 * https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html
 	 */
 	__SYMBOL_ANNOTATE_ERRNO__START		= -10000,
 
diff --git a/tools/perf/util/c++/clang.cpp b/tools/perf/util/c++/clang.cpp
index c8885dfa3667..2cccfed3e8d6 100644
--- a/tools/perf/util/c++/clang.cpp
+++ b/tools/perf/util/c++/clang.cpp
@@ -3,7 +3,7 @@
  * llvm C frontend for perf. Support dynamically compile C file
  *
  * Inspired by clang example code:
- * http://llvm.org/svn/llvm-project/cfe/trunk/examples/clang-interpreter/main.cpp
+ * https://llvm.org/svn/llvm-project/cfe/trunk/examples/clang-interpreter/main.cpp
  *
  * Copyright (C) 2016 Wang Nan <wangnan0@huawei.com>
  * Copyright (C) 2016 Huawei Inc.
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index d3d03274b0d1..d1221aa31583 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -82,7 +82,7 @@ enum dso_load_errno {
 	 * errno since SUS requires the errno has distinct positive values.
 	 * See 'Issue 6' in the link below.
 	 *
-	 * http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html
+	 * https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html
 	 */
 	__DSO_LOAD_ERRNO__START		= -10000,
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index cdb154381a87..5a7d290eb780 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -37,13 +37,13 @@ double avg_stats(struct stats *stats)
 }
 
 /*
- * http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance
+ * https://en.wikipedia.org/wiki/Algorithms_for_calculating_variance
  *
  *       (\Sum n_i^2) - ((\Sum n_i)^2)/n
  * s^2 = -------------------------------
  *                  n - 1
  *
- * http://en.wikipedia.org/wiki/Stddev
+ * https://en.wikipedia.org/wiki/Stddev
  *
  * The std dev of the mean is related to the std dev by:
  *
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 6ef01a83b24e..5b066290679b 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -25,7 +25,7 @@ enum target_errno {
 	 * errno since SUS requires the errno has distinct positive values.
 	 * See 'Issue 6' in the link below.
 	 *
-	 * http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html
+	 * https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/errno.h.html
 	 */
 	__TARGET_ERRNO__START		= -10000,
 
-- 
2.27.0

