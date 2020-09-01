Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E872C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC0D207BC
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eBTRTied";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6eAFYSlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgIAMFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:05:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39532 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgIALtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:49:33 -0400
Date:   Tue, 01 Sep 2020 11:48:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=567tHqyVGRaoVCjUmAyziH07a5wSj2pQIKlKoF96nAU=;
        b=eBTRTiedLMZXuixHDx8qjen9FXvBHUg9tq3OG1l874mfCoUGXCaEt9VqR9YMR0LetGW9wl
        OeVXW1JlWQLetHnVVJqsS5BwdCd1NEMHJVnj+YoMlLHimGRnp/NjY0X1F7uFnH2KCxP4eh
        xmRhhyJ4FmAjd4zSnIW3DeNAgHIlBjR5H5SDxjX3J9lATkJMDPGVtRX+K7Ow1/Pnxco/Qp
        +/dteeaSXi/HbX9g+VUOXR8wG7iT8mlbDjwHt39eo6zaNwutGdSSRFg9ct3HuW/itgRK+p
        XvW3P6TWbHtRecVdbiwksVUQQJXbGXh9v9wvD6387URoBiqmj3Y8Sc3dGflcbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960887;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=567tHqyVGRaoVCjUmAyziH07a5wSj2pQIKlKoF96nAU=;
        b=6eAFYSlWJ5VU5K7Gg26snMBimxM2EN4G21YsyYfTXPdAV4FbgO1m+j+diARDMD6RZSpELe
        punZholsdn0LTjCw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/static_call] static_call: Add basic static call infrastructure
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200818135804.623259796@infradead.org>
References: <20200818135804.623259796@infradead.org>
MIME-Version: 1.0
Message-ID: <159896088701.20229.6666457726458211508.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/static_call branch of tip:

Commit-ID:     115284d89a436e9b66da0c6c4f6efded806874b2
Gitweb:        https://git.kernel.org/tip/115284d89a436e9b66da0c6c4f6efded806874b2
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Tue, 18 Aug 2020 15:57:41 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:58:04 +02:00

static_call: Add basic static call infrastructure

Static calls are a replacement for global function pointers.  They use
code patching to allow direct calls to be used instead of indirect
calls.  They give the flexibility of function pointers, but with
improved performance.  This is especially important for cases where
retpolines would otherwise be used, as retpolines can significantly
impact performance.

The concept and code are an extension of previous work done by Ard
Biesheuvel and Steven Rostedt:

  https://lkml.kernel.org/r/20181005081333.15018-1-ard.biesheuvel@linaro.org
  https://lkml.kernel.org/r/20181006015110.653946300@goodmis.org

There are two implementations, depending on arch support:

 1) out-of-line: patched trampolines (CONFIG_HAVE_STATIC_CALL)
 2) basic function pointers

For more details, see the comments in include/linux/static_call.h.

[peterz: simplified interface]

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20200818135804.623259796@infradead.org
---
 arch/Kconfig                      |   3 +-
 include/linux/static_call.h       | 156 +++++++++++++++++++++++++++++-
 include/linux/static_call_types.h |  15 +++-
 3 files changed, 174 insertions(+)
 create mode 100644 include/linux/static_call.h
 create mode 100644 include/linux/static_call_types.h

diff --git a/arch/Kconfig b/arch/Kconfig
index af14a56..806e6df 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -975,6 +975,9 @@ config HAVE_SPARSE_SYSCALL_NR
 config ARCH_HAS_VDSO_DATA
 	bool
 
+config HAVE_STATIC_CALL
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
new file mode 100644
index 0000000..d8892df
--- /dev/null
+++ b/include/linux/static_call.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_STATIC_CALL_H
+#define _LINUX_STATIC_CALL_H
+
+/*
+ * Static call support
+ *
+ * Static calls use code patching to hard-code function pointers into direct
+ * branch instructions. They give the flexibility of function pointers, but
+ * with improved performance. This is especially important for cases where
+ * retpolines would otherwise be used, as retpolines can significantly impact
+ * performance.
+ *
+ *
+ * API overview:
+ *
+ *   DECLARE_STATIC_CALL(name, func);
+ *   DEFINE_STATIC_CALL(name, func);
+ *   static_call(name)(args...);
+ *   static_call_update(name, func);
+ *
+ * Usage example:
+ *
+ *   # Start with the following functions (with identical prototypes):
+ *   int func_a(int arg1, int arg2);
+ *   int func_b(int arg1, int arg2);
+ *
+ *   # Define a 'my_name' reference, associated with func_a() by default
+ *   DEFINE_STATIC_CALL(my_name, func_a);
+ *
+ *   # Call func_a()
+ *   static_call(my_name)(arg1, arg2);
+ *
+ *   # Update 'my_name' to point to func_b()
+ *   static_call_update(my_name, &func_b);
+ *
+ *   # Call func_b()
+ *   static_call(my_name)(arg1, arg2);
+ *
+ *
+ * Implementation details:
+ *
+ *   This requires some arch-specific code (CONFIG_HAVE_STATIC_CALL).
+ *   Otherwise basic indirect calls are used (with function pointers).
+ *
+ *   Each static_call() site calls into a trampoline associated with the name.
+ *   The trampoline has a direct branch to the default function.  Updates to a
+ *   name will modify the trampoline's branch destination.
+ *
+ *   If the arch has CONFIG_HAVE_STATIC_CALL_INLINE, then the call sites
+ *   themselves will be patched at runtime to call the functions directly,
+ *   rather than calling through the trampoline.  This requires objtool or a
+ *   compiler plugin to detect all the static_call() sites and annotate them
+ *   in the .static_call_sites section.
+ */
+
+#include <linux/types.h>
+#include <linux/cpu.h>
+#include <linux/static_call_types.h>
+
+#ifdef CONFIG_HAVE_STATIC_CALL
+#include <asm/static_call.h>
+
+/*
+ * Either @site or @tramp can be NULL.
+ */
+extern void arch_static_call_transform(void *site, void *tramp, void *func);
+
+#define STATIC_CALL_TRAMP_ADDR(name) &STATIC_CALL_TRAMP(name)
+
+/*
+ * __ADDRESSABLE() is used to ensure the key symbol doesn't get stripped from
+ * the symbol table so that objtool can reference it when it generates the
+ * .static_call_sites section.
+ */
+#define __static_call(name)						\
+({									\
+	__ADDRESSABLE(STATIC_CALL_KEY(name));				\
+	&STATIC_CALL_TRAMP(name);					\
+})
+
+#else
+#define STATIC_CALL_TRAMP_ADDR(name) NULL
+#endif
+
+
+#define DECLARE_STATIC_CALL(name, func)					\
+	extern struct static_call_key STATIC_CALL_KEY(name);		\
+	extern typeof(func) STATIC_CALL_TRAMP(name);
+
+#define static_call_update(name, func)					\
+({									\
+	BUILD_BUG_ON(!__same_type(*(func), STATIC_CALL_TRAMP(name)));	\
+	__static_call_update(&STATIC_CALL_KEY(name),			\
+			     STATIC_CALL_TRAMP_ADDR(name), func);	\
+})
+
+#if defined(CONFIG_HAVE_STATIC_CALL)
+
+struct static_call_key {
+	void *func;
+};
+
+#define DEFINE_STATIC_CALL(name, _func)					\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_KEY(name) = {		\
+		.func = _func,						\
+	};								\
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
+
+#define static_call(name)	__static_call(name)
+
+static inline
+void __static_call_update(struct static_call_key *key, void *tramp, void *func)
+{
+	cpus_read_lock();
+	WRITE_ONCE(key->func, func);
+	arch_static_call_transform(NULL, tramp, func);
+	cpus_read_unlock();
+}
+
+#define EXPORT_STATIC_CALL(name)					\
+	EXPORT_SYMBOL(STATIC_CALL_KEY(name));				\
+	EXPORT_SYMBOL(STATIC_CALL_TRAMP(name))
+
+#define EXPORT_STATIC_CALL_GPL(name)					\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name));			\
+	EXPORT_SYMBOL_GPL(STATIC_CALL_TRAMP(name))
+
+#else /* Generic implementation */
+
+struct static_call_key {
+	void *func;
+};
+
+#define DEFINE_STATIC_CALL(name, _func)					\
+	DECLARE_STATIC_CALL(name, _func);				\
+	struct static_call_key STATIC_CALL_KEY(name) = {		\
+		.func = _func,						\
+	}
+
+#define static_call(name)						\
+	((typeof(STATIC_CALL_TRAMP(name))*)(STATIC_CALL_KEY(name).func))
+
+static inline
+void __static_call_update(struct static_call_key *key, void *tramp, void *func)
+{
+	WRITE_ONCE(key->func, func);
+}
+
+#define EXPORT_STATIC_CALL(name)	EXPORT_SYMBOL(STATIC_CALL_KEY(name))
+#define EXPORT_STATIC_CALL_GPL(name)	EXPORT_SYMBOL_GPL(STATIC_CALL_KEY(name))
+
+#endif /* CONFIG_HAVE_STATIC_CALL */
+
+#endif /* _LINUX_STATIC_CALL_H */
diff --git a/include/linux/static_call_types.h b/include/linux/static_call_types.h
new file mode 100644
index 0000000..5ed249d
--- /dev/null
+++ b/include/linux/static_call_types.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _STATIC_CALL_TYPES_H
+#define _STATIC_CALL_TYPES_H
+
+#include <linux/stringify.h>
+
+#define STATIC_CALL_KEY_PREFIX		__SCK__
+#define STATIC_CALL_KEY(name)		__PASTE(STATIC_CALL_KEY_PREFIX, name)
+
+#define STATIC_CALL_TRAMP_PREFIX	__SCT__
+#define STATIC_CALL_TRAMP_PREFIX_STR	__stringify(STATIC_CALL_TRAMP_PREFIX)
+#define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
+#define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
+
+#endif /* _STATIC_CALL_TYPES_H */
