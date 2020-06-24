Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D48C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02405206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YLLzjUvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404668AbgFXPwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404616AbgFXPv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:51:56 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F37C061796
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=InvGRR3rIy8v4T7njFiGENNThv7s4MZD97W3xUFALPU=; b=YLLzjUvG2jKeedOud1zl6XUmP+
        EGhCxNJdWK+lfBayyefD3KE/znbA/B2hOIov40JvhJs6QP3EA6c5ZAsRGaijoM4qsvxSFW56jel6K
        AfIYp+cmOW4MO+uw+dj3wXaRTut5vDBis1xxvpNiQaB/kNfOwHSf8OnWuzKH77zuLGBkrbCOVn+i5
        jgZ+f3mj9VA2pKkvSPl/0zQMgfpvsinefTD4I/v40almp/mAseCdRaK7nYT5xou5YgX39q/SqZ3o5
        kusAvkznswK6t1UIiy7KVi1HuSsePlFxG1shgLZPZVk59GoYwWYlnN0/FNaiImWJ7Wq+Ip14Qyouy
        WLKx5Q2A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo7gC-0001dO-JY; Wed, 24 Jun 2020 15:51:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B2C52307966;
        Wed, 24 Jun 2020 17:51:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E8E70236E775E; Wed, 24 Jun 2020 17:51:13 +0200 (CEST)
Message-ID: <20200624154157.270808336@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Jun 2020 17:30:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com, linux@rasmusvillemoes.dk
Subject: [PATCH v5 09/17] x86/static_call: Add out-of-line static call implementation
References: <20200624153024.794671356@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

Add the x86 out-of-line static call implementation.  For each key, a
permanent trampoline is created which is the destination for all static
calls for the given key.  The trampoline has a direct jump which gets
patched by static_call_update() when the destination function changes.

[peterz: fixed trampoline, rewrote patching code]
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                   |    1 +
 arch/x86/include/asm/static_call.h |   23 +++++++++++++++++++++++
 arch/x86/kernel/Makefile           |    1 +
 arch/x86/kernel/static_call.c      |   31 +++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)
 create mode 100644 arch/x86/include/asm/static_call.h
 create mode 100644 arch/x86/kernel/static_call.c

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -211,6 +211,7 @@ config X86
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_STACKPROTECTOR		if CC_HAS_SANE_STACKPROTECTOR
 	select HAVE_STACK_VALIDATION		if X86_64
+	select HAVE_STATIC_CALL
 	select HAVE_RSEQ
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UNSTABLE_SCHED_CLOCK
--- /dev/null
+++ b/arch/x86/include/asm/static_call.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_STATIC_CALL_H
+#define _ASM_STATIC_CALL_H
+
+#include <asm/text-patching.h>
+
+/*
+ * For CONFIG_HAVE_STATIC_CALL, this is a permanent trampoline which
+ * does a direct jump to the function.  The direct jump gets patched by
+ * static_call_update().
+ */
+#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
+	asm(".pushsection .text, \"ax\"				\n"	\
+	    ".align 4						\n"	\
+	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
+	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
+	    "	.byte 0xe9 # jmp.d32				\n"	\
+	    "	.long " #func " - (. + 4)			\n"	\
+	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
+	    ".size " STATIC_CALL_TRAMP_STR(name) ", . - " STATIC_CALL_TRAMP_STR(name) " \n" \
+	    ".popsection					\n")
+
+#endif /* _ASM_STATIC_CALL_H */
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -68,6 +68,7 @@ obj-y			+= tsc.o tsc_msr.o io_delay.o rt
 obj-y			+= pci-iommu_table.o
 obj-y			+= resource.o
 obj-y			+= irqflags.o
+obj-y			+= static_call.o
 
 obj-y				+= process.o
 obj-y				+= fpu/
--- /dev/null
+++ b/arch/x86/kernel/static_call.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/static_call.h>
+#include <linux/memory.h>
+#include <linux/bug.h>
+#include <asm/text-patching.h>
+
+static void __static_call_transform(void *insn, u8 opcode, void *func)
+{
+	const void *code = text_gen_insn(opcode, (long)insn, (long)func);
+
+	if (WARN_ONCE(*(u8 *)insn != opcode,
+		      "unexpected static call insn opcode 0x%x at %pS\n",
+		      opcode, insn))
+		return;
+
+	if (memcmp(insn, code, CALL_INSN_SIZE) == 0)
+		return;
+
+	text_poke_bp(insn, code, CALL_INSN_SIZE, NULL);
+}
+
+void arch_static_call_transform(void *site, void *tramp, void *func)
+{
+	mutex_lock(&text_mutex);
+
+	if (tramp)
+		__static_call_transform(tramp, JMP32_INSN_OPCODE, func);
+
+	mutex_unlock(&text_mutex);
+}
+EXPORT_SYMBOL_GPL(arch_static_call_transform);


