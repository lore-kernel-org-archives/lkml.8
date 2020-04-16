Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83F9C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97CA120771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503605AbgDPJNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502315AbgDPIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:31:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13A1C0258D4;
        Thu, 16 Apr 2020 01:31:36 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOzvh-0000m0-26; Thu, 16 Apr 2020 10:31:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 53EEB1C001F;
        Thu, 16 Apr 2020 10:31:24 +0200 (CEST)
Date:   Thu, 16 Apr 2020 08:31:23 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools headers: Synchronize linux/bits.h with the
 kernel sources
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158702588388.28353.9240938500051301319.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e3698b23ecb8c099b4b523e7d5c8c042e93ef15d
Gitweb:        https://git.kernel.org/tip/e3698b23ecb8c099b4b523e7d5c8c042e93ef15d
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 14 Apr 2020 10:27:39 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 14 Apr 2020 11:40:05 -03:00

tools headers: Synchronize linux/bits.h with the kernel sources

To pick up the changes in these csets:

  295bcca84916 ("linux/bits.h: add compile time sanity check of GENMASK inputs")
  3945ff37d2f4 ("linux/bits.h: Extract common header for vDSO")

To address this tools/perf build warning:

  Warning: Kernel ABI header at 'tools/include/linux/bits.h' differs from latest version at 'include/linux/bits.h'
  diff -u tools/include/linux/bits.h include/linux/bits.h

This clashes with usage of userspace's static_assert(), that, at least
on glibc, is guarded by a ifnded/endif pair, do the same to our copy of
build_bug.h and avoid that diff in check_headers.sh so that we continue
checking for drifts with the kernel sources master copy.

This will all be tested with the set of build containers that includes
uCLibc, musl libc, lots of glibc versions in lots of distros and cross
build environments.

The tools/objtool, tools/bpf, etc were tested as well.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/bits.h      | 24 +++++++--
 tools/include/linux/build_bug.h | 82 ++++++++++++++++++++++++++++++++-
 tools/include/linux/kernel.h    |  4 +--
 tools/include/vdso/bits.h       |  9 ++++-
 tools/perf/check-headers.sh     |  2 +-
 5 files changed, 115 insertions(+), 6 deletions(-)
 create mode 100644 tools/include/linux/build_bug.h
 create mode 100644 tools/include/vdso/bits.h

diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
index 669d694..4671fbf 100644
--- a/tools/include/linux/bits.h
+++ b/tools/include/linux/bits.h
@@ -3,9 +3,9 @@
 #define __LINUX_BITS_H
 
 #include <linux/const.h>
+#include <vdso/bits.h>
 #include <asm/bitsperlong.h>
 
-#define BIT(nr)			(UL(1) << (nr))
 #define BIT_ULL(nr)		(ULL(1) << (nr))
 #define BIT_MASK(nr)		(UL(1) << ((nr) % BITS_PER_LONG))
 #define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
@@ -18,12 +18,30 @@
  * position @h. For example
  * GENMASK_ULL(39, 21) gives us the 64bit vector 0x000000ffffe00000.
  */
-#define GENMASK(h, l) \
+#if !defined(__ASSEMBLY__) && \
+	(!defined(CONFIG_CC_IS_GCC) || CONFIG_GCC_VERSION >= 49000)
+#include <linux/build_bug.h>
+#define GENMASK_INPUT_CHECK(h, l) \
+	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
+		__builtin_constant_p((l) > (h)), (l) > (h), 0)))
+#else
+/*
+ * BUILD_BUG_ON_ZERO is not available in h files included from asm files,
+ * disable the input check if that is the case.
+ */
+#define GENMASK_INPUT_CHECK(h, l) 0
+#endif
+
+#define __GENMASK(h, l) \
 	(((~UL(0)) - (UL(1) << (l)) + 1) & \
 	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
+#define GENMASK(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
 
-#define GENMASK_ULL(h, l) \
+#define __GENMASK_ULL(h, l) \
 	(((~ULL(0)) - (ULL(1) << (l)) + 1) & \
 	 (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h))))
+#define GENMASK_ULL(h, l) \
+	(GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
 
 #endif	/* __LINUX_BITS_H */
diff --git a/tools/include/linux/build_bug.h b/tools/include/linux/build_bug.h
new file mode 100644
index 0000000..cc7070c
--- /dev/null
+++ b/tools/include/linux/build_bug.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_BUILD_BUG_H
+#define _LINUX_BUILD_BUG_H
+
+#include <linux/compiler.h>
+
+#ifdef __CHECKER__
+#define BUILD_BUG_ON_ZERO(e) (0)
+#else /* __CHECKER__ */
+/*
+ * Force a compilation error if condition is true, but also produce a
+ * result (of value 0 and type int), so the expression can be used
+ * e.g. in a structure initializer (or where-ever else comma expressions
+ * aren't permitted).
+ */
+#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
+#endif /* __CHECKER__ */
+
+/* Force a compilation error if a constant expression is not a power of 2 */
+#define __BUILD_BUG_ON_NOT_POWER_OF_2(n)	\
+	BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
+#define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
+	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
+
+/*
+ * BUILD_BUG_ON_INVALID() permits the compiler to check the validity of the
+ * expression but avoids the generation of any code, even if that expression
+ * has side-effects.
+ */
+#define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
+
+/**
+ * BUILD_BUG_ON_MSG - break compile if a condition is true & emit supplied
+ *		      error message.
+ * @condition: the condition which the compiler should know is false.
+ *
+ * See BUILD_BUG_ON for description.
+ */
+#define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
+
+/**
+ * BUILD_BUG_ON - break compile if a condition is true.
+ * @condition: the condition which the compiler should know is false.
+ *
+ * If you have some code which relies on certain constants being equal, or
+ * some other compile-time-evaluated condition, you should use BUILD_BUG_ON to
+ * detect if someone changes it.
+ */
+#define BUILD_BUG_ON(condition) \
+	BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
+
+/**
+ * BUILD_BUG - break compile if used.
+ *
+ * If you have some code that you expect the compiler to eliminate at
+ * build time, you should use BUILD_BUG to detect if it is
+ * unexpectedly used.
+ */
+#define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
+
+/**
+ * static_assert - check integer constant expression at build time
+ *
+ * static_assert() is a wrapper for the C11 _Static_assert, with a
+ * little macro magic to make the message optional (defaulting to the
+ * stringification of the tested expression).
+ *
+ * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
+ * scope, but requires the expression to be an integer constant
+ * expression (i.e., it is not enough that __builtin_constant_p() is
+ * true for expr).
+ *
+ * Also note that BUILD_BUG_ON() fails the build if the condition is
+ * true, while static_assert() fails the build if the expression is
+ * false.
+ */
+#ifndef static_assert
+#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
+#define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
+#endif // static_assert
+
+#endif	/* _LINUX_BUILD_BUG_H */
diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index cba2269..a7e54a0 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -5,6 +5,7 @@
 #include <stdarg.h>
 #include <stddef.h>
 #include <assert.h>
+#include <linux/build_bug.h>
 #include <linux/compiler.h>
 #include <endian.h>
 #include <byteswap.h>
@@ -35,9 +36,6 @@
 	(type *)((char *)__mptr - offsetof(type, member)); })
 #endif
 
-#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2*!!(condition)]))
-#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
-
 #ifndef max
 #define max(x, y) ({				\
 	typeof(x) _max1 = (x);			\
diff --git a/tools/include/vdso/bits.h b/tools/include/vdso/bits.h
new file mode 100644
index 0000000..6d005a1
--- /dev/null
+++ b/tools/include/vdso/bits.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_BITS_H
+#define __VDSO_BITS_H
+
+#include <vdso/const.h>
+
+#define BIT(nr)			(UL(1) << (nr))
+
+#endif	/* __VDSO_BITS_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index c905c68..cf147db 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -22,6 +22,7 @@ include/uapi/linux/usbdevice_fs.h
 include/uapi/linux/vhost.h
 include/uapi/sound/asound.h
 include/linux/bits.h
+include/vdso/bits.h
 include/linux/const.h
 include/vdso/const.h
 include/linux/hash.h
@@ -116,6 +117,7 @@ check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/ex
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>" -I"^SYM_FUNC_START\(_LOCAL\)*(memset_\(erms\|orig\))"'
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common\(-tools\)*.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
+check include/linux/build_bug.h       '-I "^#\(ifndef\|endif\)\( \/\/\)* static_assert$"'
 check include/linux/ctype.h	      '-I "isdigit("'
 check lib/ctype.c		      '-I "^EXPORT_SYMBOL" -I "^#include <linux/export.h>" -B'
 check arch/x86/include/asm/inat.h     '-I "^#include [\"<]\(asm/\)*inat_types.h[\">]"'
