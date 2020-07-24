Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9B8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2CE120737
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PBUzQrmX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PSlwBK4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgGXMCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:02:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37720 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGXMC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:02:26 -0400
Date:   Fri, 24 Jul 2020 12:02:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595592142;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xgAikLBvITSzNqzcxXEvFpGwYd2TiQpsNuh8QeV6ruE=;
        b=PBUzQrmXOoEYZOiAZc+iHJs4aV7YHvEktzeW6eaDx4X+XASJIohe683dQb/kLVj/X2K5kL
        UxqcQ2lLmtJY9zhYGlnpJudU858cgxDyD/pFYqmOQW5GZ+188+Y1DRotxe8j3qcSJB8NQ3
        /8jS79Q5+Tw6qFjjrnnsG6aJKwx+JbbkAxWWFdNrYku1udKlZJTlHFMFPMA15rtrT+oeNf
        fPwcsOR49M7X2eZh8hqqJLZfOGH9Eac7oUhZXurRaCFuS4BGgqgB+0yAXS+6VF6/ry1dtn
        LJPUAeprndekbsxfzqTbs0ZCIxNFaD9LwlgFiSqdAmmOFOBdc1fU/loyiCEUEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595592142;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xgAikLBvITSzNqzcxXEvFpGwYd2TiQpsNuh8QeV6ruE=;
        b=PSlwBK4WDogVDCBE8p9b1DhQVq7PUvfYnjAcQOfqK5Ey2Nf8yQmbxFbQ0eHkx6i4tRcX9w
        PwsPW1NDNzlso8DA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/headers] compiler.h: Move instrumentation_begin()/end() to
 new <linux/instrumentation.h> header
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200604071921.GA1361070@gmail.com>
References: <20200604071921.GA1361070@gmail.com>
MIME-Version: 1.0
Message-ID: <159559214141.4006.8712776602481546473.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/headers branch of tip:

Commit-ID:     d19e789f068b3d633cbac430764962f404198022
Gitweb:        https://git.kernel.org/tip/d19e789f068b3d633cbac430764962f404198022
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 24 Jul 2020 13:50:25 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 24 Jul 2020 13:56:23 +02:00

compiler.h: Move instrumentation_begin()/end() to new <linux/instrumentation.h> header

Linus pointed out that compiler.h - which is a key header that gets included in every
single one of the 28,000+ kernel files during a kernel build - was bloated in:

  655389666643: ("vmlinux.lds.h: Create section for protection against instrumentation")

Linus noted:

 > I have pulled this, but do we really want to add this to a header file
 > that is _so_ core that it gets included for basically every single
 > file built?
 >
 > I don't even see those instrumentation_begin/end() things used
 > anywhere right now.
 >
 > It seems excessive. That 53 lines is maybe not a lot, but it pushed
 > that header file to over 12kB, and while it's mostly comments, it's
 > extra IO and parsing basically for _every_ single file compiled in the
 > kernel.
 >
 > For what appears to be absolutely zero upside right now, and I really
 > don't see why this should be in such a core header file!

Move these primitives into a new header: <linux/instrumentation.h>, and include that
header in the headers that make use of it.

Unfortunately one of these headers is asm-generic/bug.h, which does get included
in a lot of places, similarly to compiler.h. So the de-bloating effect isn't as
good as we'd like it to be - but at least the interfaces are defined separately.

No change to functionality intended.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200604071921.GA1361070@gmail.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/bug.h       |  1 +-
 include/asm-generic/bug.h        |  1 +-
 include/linux/compiler.h         | 53 +-----------------------------
 include/linux/context_tracking.h |  2 +-
 include/linux/instrumentation.h  | 57 +++++++++++++++++++++++++++++++-
 5 files changed, 61 insertions(+), 53 deletions(-)
 create mode 100644 include/linux/instrumentation.h

diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 0281895..297fa12 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_BUG_H
 
 #include <linux/stringify.h>
+#include <linux/instrumentation.h>
 
 /*
  * Despite that some emulators terminate on UD2, we use it for WARN().
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index c94e33a..18b0f4e 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -3,6 +3,7 @@
 #define _ASM_GENERIC_BUG_H
 
 #include <linux/compiler.h>
+#include <linux/instrumentation.h>
 
 #define CUT_HERE		"------------[ cut here ]------------\n"
 
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 204e768..681894b 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -120,65 +120,12 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 /* Annotate a C jump table to allow objtool to follow the code flow */
 #define __annotate_jump_table __section(.rodata..c_jump_table)
 
-#ifdef CONFIG_DEBUG_ENTRY
-/* Begin/end of an instrumentation safe region */
-#define instrumentation_begin() ({					\
-	asm volatile("%c0: nop\n\t"						\
-		     ".pushsection .discard.instr_begin\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
-})
-
-/*
- * Because instrumentation_{begin,end}() can nest, objtool validation considers
- * _begin() a +1 and _end() a -1 and computes a sum over the instructions.
- * When the value is greater than 0, we consider instrumentation allowed.
- *
- * There is a problem with code like:
- *
- * noinstr void foo()
- * {
- *	instrumentation_begin();
- *	...
- *	if (cond) {
- *		instrumentation_begin();
- *		...
- *		instrumentation_end();
- *	}
- *	bar();
- *	instrumentation_end();
- * }
- *
- * If instrumentation_end() would be an empty label, like all the other
- * annotations, the inner _end(), which is at the end of a conditional block,
- * would land on the instruction after the block.
- *
- * If we then consider the sum of the !cond path, we'll see that the call to
- * bar() is with a 0-value, even though, we meant it to happen with a positive
- * value.
- *
- * To avoid this, have _end() be a NOP instruction, this ensures it will be
- * part of the condition block and does not escape.
- */
-#define instrumentation_end() ({					\
-	asm volatile("%c0: nop\n\t"					\
-		     ".pushsection .discard.instr_end\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
-})
-#endif /* CONFIG_DEBUG_ENTRY */
-
 #else
 #define annotate_reachable()
 #define annotate_unreachable()
 #define __annotate_jump_table
 #endif
 
-#ifndef instrumentation_begin
-#define instrumentation_begin()		do { } while(0)
-#define instrumentation_end()		do { } while(0)
-#endif
-
 #ifndef ASM_UNREACHABLE
 # define ASM_UNREACHABLE
 #endif
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 981b880..d53cd33 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -5,6 +5,8 @@
 #include <linux/sched.h>
 #include <linux/vtime.h>
 #include <linux/context_tracking_state.h>
+#include <linux/instrumentation.h>
+
 #include <asm/ptrace.h>
 
 
diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
new file mode 100644
index 0000000..93e2ad6
--- /dev/null
+++ b/include/linux/instrumentation.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_INSTRUMENTATION_H
+#define __LINUX_INSTRUMENTATION_H
+
+#if defined(CONFIG_DEBUG_ENTRY) && defined(CONFIG_STACK_VALIDATION)
+
+/* Begin/end of an instrumentation safe region */
+#define instrumentation_begin() ({					\
+	asm volatile("%c0: nop\n\t"						\
+		     ".pushsection .discard.instr_begin\n\t"		\
+		     ".long %c0b - .\n\t"				\
+		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+})
+
+/*
+ * Because instrumentation_{begin,end}() can nest, objtool validation considers
+ * _begin() a +1 and _end() a -1 and computes a sum over the instructions.
+ * When the value is greater than 0, we consider instrumentation allowed.
+ *
+ * There is a problem with code like:
+ *
+ * noinstr void foo()
+ * {
+ *	instrumentation_begin();
+ *	...
+ *	if (cond) {
+ *		instrumentation_begin();
+ *		...
+ *		instrumentation_end();
+ *	}
+ *	bar();
+ *	instrumentation_end();
+ * }
+ *
+ * If instrumentation_end() would be an empty label, like all the other
+ * annotations, the inner _end(), which is at the end of a conditional block,
+ * would land on the instruction after the block.
+ *
+ * If we then consider the sum of the !cond path, we'll see that the call to
+ * bar() is with a 0-value, even though, we meant it to happen with a positive
+ * value.
+ *
+ * To avoid this, have _end() be a NOP instruction, this ensures it will be
+ * part of the condition block and does not escape.
+ */
+#define instrumentation_end() ({					\
+	asm volatile("%c0: nop\n\t"					\
+		     ".pushsection .discard.instr_end\n\t"		\
+		     ".long %c0b - .\n\t"				\
+		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+})
+#else
+# define instrumentation_begin()	do { } while(0)
+# define instrumentation_end()		do { } while(0)
+#endif
+
+#endif /* __LINUX_INSTRUMENTATION_H */
