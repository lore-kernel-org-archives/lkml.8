Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08282C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0C7C21835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QB7WDoSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgEAUcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgEAUbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:31:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E1AC061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 13:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=fEGCSSKqX01IAHLvtw+4gpoKZgt1ek7edQuxQLpC09I=; b=QB7WDoSXxQg93vZRGck8d0btEs
        VIWdvPa+EHZatUGCd2ZHzKaQ6GJ5sd6dr2+zDP/ggd6zJ45k6gWL9ackVQ99NjymUWaH32so9k0nx
        9CXph9O+tiCg8EMXWj8lJERpUC4P1I9LkyzG5ohO3Nu7A54w/m2SrbP1ASd7gYtS7IeLs17aO5cWn
        1JCFt1WuyCfLFEO1fZ4A8C5DqSwkkQdjp12Y9Kg+1CyTOL3YgYLAuRtfoFkOcIwiu/ljDGpZVHyIv
        dTrdc9G2IfKpMpSMcU0XI2xtqtunGBDvAXt+vMKRL4sj3GATSH3GJUNrjhipHMlSsaxsoN9qxes5s
        VSgOuHkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUcJM-0002jm-Iw; Fri, 01 May 2020 20:31:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 75BBF30699C;
        Fri,  1 May 2020 22:31:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C22BB25BAEC06; Fri,  1 May 2020 22:31:00 +0200 (CEST)
Message-Id: <20200501202944.128942570@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 01 May 2020 22:28:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: [PATCH v4 06/18] static_call: Add basic static call infrastructure
References: <20200501202849.647891881@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

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
---
 arch/Kconfig                      |    3 
 include/linux/static_call.h       |  156 ++++++++++++++++++++++++++++++++++++++
 include/linux/static_call_types.h |   15 +++
 3 files changed, 174 insertions(+)
 create mode 100644 include/linux/static_call.h
 create mode 100644 include/linux/static_call_types.h

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -960,6 +960,9 @@ config HAVE_SPARSE_SYSCALL_NR
 	  entries at 4000, 5000 and 6000 locations. This option turns on syscall
 	  related optimizations for a given architecture.
 
+config HAVE_STATIC_CALL
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
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
+ * branch instructions.  They give the flexibility of function pointers, but
+ * with improved performance.  This is especially important for cases where
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
+ *    This requires some arch-specific code (CONFIG_HAVE_STATIC_CALL).
+ *    Otherwise basic indirect calls are used (with function pointers).
+ *
+ *    Each static_call() site calls into a trampoline associated with the name.
+ *    The trampoline has a direct branch to the default function.  Updates to a
+ *    name will modify the trampoline's branch destination.
+ *
+ *    If the arch has CONFIG_HAVE_STATIC_CALL_INLINE, then the call sites
+ *    themselves will be patched at runtime to call the functions directly,
+ *    rather than calling through the trampoline.  This requires objtool or a
+ *    compiler plugin to detect all the static_call() sites and annotate them
+ *    in the .static_call_sites section.
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
--- /dev/null
+++ b/include/linux/static_call_types.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _STATIC_CALL_TYPES_H
+#define _STATIC_CALL_TYPES_H
+
+#include <linux/stringify.h>
+
+#define STATIC_CALL_PREFIX		__SC__
+#define STATIC_CALL_KEY(name)		__PASTE(STATIC_CALL_PREFIX, name)
+
+#define STATIC_CALL_TRAMP_PREFIX	__SCT__
+#define STATIC_CALL_TRAMP_PREFIX_STR	__stringify(STATIC_CALL_TRAMP_PREFIX)
+#define STATIC_CALL_TRAMP(name)		__PASTE(STATIC_CALL_TRAMP_PREFIX, name)
+#define STATIC_CALL_TRAMP_STR(name)	__stringify(STATIC_CALL_TRAMP(name))
+
+#endif /* _STATIC_CALL_TYPES_H */


