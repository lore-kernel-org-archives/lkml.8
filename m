Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0D3C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF79520678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883014;
	bh=bBWolWt3GxVmRqzLFuACmJVn1j6cRy07FMlTDnHVsTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fLdt+ACI2VBRTfLO4jRiMJPdFcIj/H6LDIdUHNIuMMXrEboK67Z/VxBnyQM02ToU3
	 IVoyeP4eUJLNXTP7fPVV8bnKGCf93v7Ud0Ms5u1FR8ZcevPLW7xg9GSokdFOQtVxb7
	 ARFqWXmH+cnc7U6JxkH7EoATSScclDtOWT8Fb0cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441004AbgDNQuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2501947AbgDNQtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:50 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AE252075E;
        Tue, 14 Apr 2020 16:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882987;
        bh=bBWolWt3GxVmRqzLFuACmJVn1j6cRy07FMlTDnHVsTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SojZANP+g8+3gXOc7blILXwHy+1Z6BXhrhQhkLZVnVDsnFUpcLMq7xQ9yUlO58/h8
         fss4NUZKmRo+yNXF3ShSgAxr35X07Qg36rS7QvNvIxJlj/2+Whaz4fo13TzhPYZYTU
         s249BFi3CVxfp2/8EMP3fjMYlHhnA3sY1JyUTTNg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 15/15] tools headers: Synchronize linux/bits.h with the kernel sources
Date:   Tue, 14 Apr 2020 13:48:54 -0300
Message-Id: <20200414164854.26026-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414164854.26026-1-acme@kernel.org>
References: <20200414164854.26026-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/include/linux/bits.h      | 24 ++++++++--
 tools/include/linux/build_bug.h | 82 +++++++++++++++++++++++++++++++++
 tools/include/linux/kernel.h    |  4 +-
 tools/include/vdso/bits.h       |  9 ++++
 tools/perf/check-headers.sh     |  2 +
 5 files changed, 115 insertions(+), 6 deletions(-)
 create mode 100644 tools/include/linux/build_bug.h
 create mode 100644 tools/include/vdso/bits.h

diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
index 669d69441a62..4671fbf28842 100644
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
index 000000000000..cc7070c7439b
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
index cba226948a0c..a7e54a08fb54 100644
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
index 000000000000..6d005a1f5d94
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
index c905c683606a..cf147db4e5ca 100755
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
-- 
2.21.1

