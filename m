Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E6DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C0C207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgESTx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgESTwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:52:44 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767A8C08C5C0;
        Tue, 19 May 2020 12:52:44 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jb8I2-0007tT-B0; Tue, 19 May 2020 21:52:38 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 94AA11C04D6;
        Tue, 19 May 2020 21:52:37 +0200 (CEST)
Date:   Tue, 19 May 2020 19:52:37 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] vmlinux.lds.h: Create section for protection against
 instrumentation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200505134100.075416272@linutronix.de>
References: <20200505134100.075416272@linutronix.de>
MIME-Version: 1.0
Message-ID: <158991795749.17951.18190372549185535613.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     6553896666433e7efec589838b400a2a652b3ffa
Gitweb:        https://git.kernel.org/tip/6553896666433e7efec589838b400a2a652b3ffa
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 09 Mar 2020 22:47:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 19 May 2020 15:47:20 +02:00

vmlinux.lds.h: Create section for protection against instrumentation

Some code pathes, especially the low level entry code, must be protected
against instrumentation for various reasons:

 - Low level entry code can be a fragile beast, especially on x86.

 - With NO_HZ_FULL RCU state needs to be established before using it.

Having a dedicated section for such code allows to validate with tooling
that no unsafe functions are invoked.

Add the .noinstr.text section and the noinstr attribute to mark
functions. noinstr implies notrace. Kprobes will gain a section check
later.

Provide also a set of markers: instrumentation_begin()/end()

These are used to mark code inside a noinstr function which calls
into regular instrumentable text section as safe.

The instrumentation markers are only active when CONFIG_DEBUG_ENTRY is
enabled as the end marker emits a NOP to prevent the compiler from merging
the annotation points. This means the objtool verification requires a
kernel compiled with this option.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200505134100.075416272@linutronix.de
---
 arch/powerpc/kernel/vmlinux.lds.S |  1 +-
 include/asm-generic/sections.h    |  3 ++-
 include/asm-generic/vmlinux.lds.h | 10 ++++++-
 include/linux/compiler.h          | 53 ++++++++++++++++++++++++++++++-
 include/linux/compiler_types.h    |  4 ++-
 scripts/mod/modpost.c             |  2 +-
 6 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 31a0f20..a1706b6 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -90,6 +90,7 @@ SECTIONS
 #ifdef CONFIG_PPC64
 		*(.tramp.ftrace.text);
 #endif
+		NOINSTR_TEXT
 		SCHED_TEXT
 		CPUIDLE_TEXT
 		LOCK_TEXT
diff --git a/include/asm-generic/sections.h b/include/asm-generic/sections.h
index d1779d4..66397ed 100644
--- a/include/asm-generic/sections.h
+++ b/include/asm-generic/sections.h
@@ -53,6 +53,9 @@ extern char __ctors_start[], __ctors_end[];
 /* Start and end of .opd section - used for function descriptors. */
 extern char __start_opd[], __end_opd[];
 
+/* Start and end of instrumentation protected text section */
+extern char __noinstr_text_start[], __noinstr_text_end[];
+
 extern __visible const void __nosave_begin, __nosave_end;
 
 /* Function descriptor handling (if any).  Override in asm/sections.h */
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 71e387a..db600ef 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -541,6 +541,15 @@
 	__end_rodata = .;
 
 /*
+ * Non-instrumentable text section
+ */
+#define NOINSTR_TEXT							\
+		ALIGN_FUNCTION();					\
+		__noinstr_text_start = .;				\
+		*(.noinstr.text)					\
+		__noinstr_text_end = .;
+
+/*
  * .text section. Map to function alignment to avoid address changes
  * during second ld run in second ld pass when generating System.map
  *
@@ -551,6 +560,7 @@
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
 		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely)	\
+		NOINSTR_TEXT						\
 		*(.text..refcount)					\
 		*(.ref.text)						\
 	MEM_KEEP(init.text*)						\
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 034b0a6..e9ead05 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -120,12 +120,65 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 /* Annotate a C jump table to allow objtool to follow the code flow */
 #define __annotate_jump_table __section(.rodata..c_jump_table)
 
+#ifdef CONFIG_DEBUG_ENTRY
+/* Begin/end of an instrumentation safe region */
+#define instrumentation_begin() ({					\
+	asm volatile("%c0:\n\t"						\
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
+#endif /* CONFIG_DEBUG_ENTRY */
+
 #else
 #define annotate_reachable()
 #define annotate_unreachable()
 #define __annotate_jump_table
 #endif
 
+#ifndef instrumentation_begin
+#define instrumentation_begin()		do { } while(0)
+#define instrumentation_end()		do { } while(0)
+#endif
+
 #ifndef ASM_UNREACHABLE
 # define ASM_UNREACHABLE
 #endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index e970f97..5da257c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -118,6 +118,10 @@ struct ftrace_likely_data {
 #define notrace			__attribute__((__no_instrument_function__))
 #endif
 
+/* Section for code which can't be instrumented at all */
+#define noinstr								\
+	noinline notrace __attribute((__section__(".noinstr.text")))
+
 /*
  * it doesn't make sense on ARM (currently the only user of __naked)
  * to trace naked functions because then mcount is called without
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 5c3c50c..0053d4f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -948,7 +948,7 @@ static void check_section(const char *modname, struct elf_info *elf,
 
 #define DATA_SECTIONS ".data", ".data.rel"
 #define TEXT_SECTIONS ".text", ".text.unlikely", ".sched.text", \
-		".kprobes.text", ".cpuidle.text"
+		".kprobes.text", ".cpuidle.text", ".noinstr.text"
 #define OTHER_TEXT_SECTIONS ".ref.text", ".head.text", ".spinlock.text", \
 		".fixup", ".entry.text", ".exception.text", ".text.*", \
 		".coldtext"
