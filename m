Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B59C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11CD3214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o6rihI3S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GshCpl6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgIJS4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbgIJSyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:54:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA564C061756;
        Thu, 10 Sep 2020 11:54:37 -0700 (PDT)
Date:   Thu, 10 Sep 2020 18:54:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599764075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=I4eoxOywZhMX7yReNjcGDEP+ASWvFXagpPzhA/GiHeM=;
        b=o6rihI3S4P4rbIIIxxt+IN+jWKAfafYI+G2ns8djPM+bz1Ybq0c5zauM1C42UBAqmiHSeM
        mgnet2rows95dK4eJAB7TiRhNlAV6pUFkiLI6q4GO24K3HpURz0b+iyZiQ7ir9Iz5Yvpu2
        3wzirNCQyrNMtSIdgaGxgDDtoE9IprejKglIRO/aC8ZSS7LjKvPliSo7qCc5OMCoW3COKO
        uetMwnLXXOLRGnQYlCvv2m8Ngx/j2W7KhE0v6RHk7G1KSot/rUxANAvSJiuSZDDQnx4zTq
        OXGlVNflipKoJ2J1kIihW/Ms+VVOlOPYaqAy6a8twyBSE0G6h8boqqP1ZmaD3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599764075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=I4eoxOywZhMX7yReNjcGDEP+ASWvFXagpPzhA/GiHeM=;
        b=GshCpl6vh/FDJAywWmJXgJob8fNKlnuyfaIGi99XdJ7DJFB+ilAl+vXO7pO6PcUDqGvsKA
        oTqoruVcFzoaUzBQ==
From:   "tip-bot2 for Julien Thierry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Make unwind hint definitions available
 to other architectures
Cc:     Julien Thierry <jthierry@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159976407489.20229.9379440488493140927.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     ee819aedf34a8f35cd54ee3967c7beb4d1d4a635
Gitweb:        https://git.kernel.org/tip/ee819aedf34a8f35cd54ee3967c7beb4d1d4a635
Author:        Julien Thierry <jthierry@redhat.com>
AuthorDate:    Fri, 04 Sep 2020 16:30:27 +01:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Thu, 10 Sep 2020 10:43:13 -05:00

objtool: Make unwind hint definitions available to other architectures

Unwind hints are useful to provide objtool with information about stack
states in non-standard functions/code.

While the type of information being provided might be very arch
specific, the mechanism to provide the information can be useful for
other architectures.

Move the relevant unwint hint definitions for all architectures to
see.

[ jpoimboe: REGS_IRET -> REGS_PARTIAL ]

Signed-off-by: Julien Thierry <jthierry@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/orc_types.h       |  34 +------
 arch/x86/include/asm/unwind_hints.h    |  56 +---------
 arch/x86/kernel/unwind_orc.c           |  11 +-
 include/linux/objtool.h                |  88 ++++++++++++++++-
 tools/arch/x86/include/asm/orc_types.h |  34 +------
 tools/include/linux/objtool.h          | 129 ++++++++++++++++++++++++-
 tools/objtool/check.c                  |   4 +-
 tools/objtool/orc_dump.c               |   9 +-
 tools/objtool/orc_gen.c                |   5 +-
 tools/objtool/sync-check.sh            |   4 +-
 10 files changed, 249 insertions(+), 125 deletions(-)
 create mode 100644 tools/include/linux/objtool.h

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index d255349..fdbffec 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -39,27 +39,6 @@
 #define ORC_REG_SP_INDIRECT		9
 #define ORC_REG_MAX			15
 
-/*
- * ORC_TYPE_CALL: Indicates that sp_reg+sp_offset resolves to PREV_SP (the
- * caller's SP right before it made the call).  Used for all callable
- * functions, i.e. all C code and all callable asm functions.
- *
- * ORC_TYPE_REGS: Used in entry code to indicate that sp_reg+sp_offset points
- * to a fully populated pt_regs from a syscall, interrupt, or exception.
- *
- * ORC_TYPE_REGS_IRET: Used in entry code to indicate that sp_reg+sp_offset
- * points to the iret return frame.
- *
- * The UNWIND_HINT macros are used only for the unwind_hint struct.  They
- * aren't used in struct orc_entry due to size and complexity constraints.
- * Objtool converts them to real types when it converts the hints to orc
- * entries.
- */
-#define ORC_TYPE_CALL			0
-#define ORC_TYPE_REGS			1
-#define ORC_TYPE_REGS_IRET		2
-#define UNWIND_HINT_TYPE_RET_OFFSET	3
-
 #ifndef __ASSEMBLY__
 /*
  * This struct is more or less a vastly simplified version of the DWARF Call
@@ -78,19 +57,6 @@ struct orc_entry {
 	unsigned	end:1;
 } __packed;
 
-/*
- * This struct is used by asm and inline asm code to manually annotate the
- * location of registers on the stack for the ORC unwinder.
- *
- * Type can be either ORC_TYPE_* or UNWIND_HINT_TYPE_*.
- */
-struct unwind_hint {
-	u32		ip;
-	s16		sp_offset;
-	u8		sp_reg;
-	u8		type;
-	u8		end;
-};
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ORC_TYPES_H */
diff --git a/arch/x86/include/asm/unwind_hints.h b/arch/x86/include/asm/unwind_hints.h
index 7d903fd..664d461 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -1,51 +1,17 @@
 #ifndef _ASM_X86_UNWIND_HINTS_H
 #define _ASM_X86_UNWIND_HINTS_H
 
+#include <linux/objtool.h>
+
 #include "orc_types.h"
 
 #ifdef __ASSEMBLY__
 
-/*
- * In asm, there are two kinds of code: normal C-type callable functions and
- * the rest.  The normal callable functions can be called by other code, and
- * don't do anything unusual with the stack.  Such normal callable functions
- * are annotated with the ENTRY/ENDPROC macros.  Most asm code falls in this
- * category.  In this case, no special debugging annotations are needed because
- * objtool can automatically generate the ORC data for the ORC unwinder to read
- * at runtime.
- *
- * Anything which doesn't fall into the above category, such as syscall and
- * interrupt handlers, tends to not be called directly by other functions, and
- * often does unusual non-C-function-type things with the stack pointer.  Such
- * code needs to be annotated such that objtool can understand it.  The
- * following CFI hint macros are for this type of code.
- *
- * These macros provide hints to objtool about the state of the stack at each
- * instruction.  Objtool starts from the hints and follows the code flow,
- * making automatic CFI adjustments when it sees pushes and pops, filling out
- * the debuginfo as necessary.  It will also warn if it sees any
- * inconsistencies.
- */
-.macro UNWIND_HINT sp_reg=ORC_REG_SP sp_offset=0 type=ORC_TYPE_CALL end=0
-#ifdef CONFIG_STACK_VALIDATION
-.Lunwind_hint_ip_\@:
-	.pushsection .discard.unwind_hints
-		/* struct unwind_hint */
-		.long .Lunwind_hint_ip_\@ - .
-		.short \sp_offset
-		.byte \sp_reg
-		.byte \type
-		.byte \end
-		.balign 4
-	.popsection
-#endif
-.endm
-
 .macro UNWIND_HINT_EMPTY
-	UNWIND_HINT sp_reg=ORC_REG_UNDEFINED end=1
+	UNWIND_HINT sp_reg=ORC_REG_UNDEFINED type=UNWIND_HINT_TYPE_CALL end=1
 .endm
 
-.macro UNWIND_HINT_REGS base=%rsp offset=0 indirect=0 extra=1 iret=0
+.macro UNWIND_HINT_REGS base=%rsp offset=0 indirect=0 extra=1 partial=0
 	.if \base == %rsp
 		.if \indirect
 			.set sp_reg, ORC_REG_SP_INDIRECT
@@ -66,24 +32,24 @@
 
 	.set sp_offset, \offset
 
-	.if \iret
-		.set type, ORC_TYPE_REGS_IRET
+	.if \partial
+		.set type, UNWIND_HINT_TYPE_REGS_PARTIAL
 	.elseif \extra == 0
-		.set type, ORC_TYPE_REGS_IRET
+		.set type, UNWIND_HINT_TYPE_REGS_PARTIAL
 		.set sp_offset, \offset + (16*8)
 	.else
-		.set type, ORC_TYPE_REGS
+		.set type, UNWIND_HINT_TYPE_REGS
 	.endif
 
 	UNWIND_HINT sp_reg=sp_reg sp_offset=sp_offset type=type
 .endm
 
 .macro UNWIND_HINT_IRET_REGS base=%rsp offset=0
-	UNWIND_HINT_REGS base=\base offset=\offset iret=1
+	UNWIND_HINT_REGS base=\base offset=\offset partial=1
 .endm
 
 .macro UNWIND_HINT_FUNC sp_offset=8
-	UNWIND_HINT sp_offset=\sp_offset
+	UNWIND_HINT sp_reg=ORC_REG_SP sp_offset=\sp_offset type=UNWIND_HINT_TYPE_CALL
 .endm
 
 /*
@@ -92,7 +58,7 @@
  * initial_func_cfi.
  */
 .macro UNWIND_HINT_RET_OFFSET sp_offset=8
-	UNWIND_HINT type=UNWIND_HINT_TYPE_RET_OFFSET sp_offset=\sp_offset
+	UNWIND_HINT sp_reg=ORC_REG_SP type=UNWIND_HINT_TYPE_RET_OFFSET sp_offset=\sp_offset
 .endm
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index ec88bbe..6a339ce 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/objtool.h>
 #include <linux/module.h>
 #include <linux/sort.h>
 #include <asm/ptrace.h>
@@ -127,12 +128,12 @@ static struct orc_entry null_orc_entry = {
 	.sp_offset = sizeof(long),
 	.sp_reg = ORC_REG_SP,
 	.bp_reg = ORC_REG_UNDEFINED,
-	.type = ORC_TYPE_CALL
+	.type = UNWIND_HINT_TYPE_CALL
 };
 
 /* Fake frame pointer entry -- used as a fallback for generated code */
 static struct orc_entry orc_fp_entry = {
-	.type		= ORC_TYPE_CALL,
+	.type		= UNWIND_HINT_TYPE_CALL,
 	.sp_reg		= ORC_REG_BP,
 	.sp_offset	= 16,
 	.bp_reg		= ORC_REG_PREV_SP,
@@ -531,7 +532,7 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	/* Find IP, SP and possibly regs: */
 	switch (orc->type) {
-	case ORC_TYPE_CALL:
+	case UNWIND_HINT_TYPE_CALL:
 		ip_p = sp - sizeof(long);
 
 		if (!deref_stack_reg(state, ip_p, &state->ip))
@@ -546,7 +547,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		state->signal = false;
 		break;
 
-	case ORC_TYPE_REGS:
+	case UNWIND_HINT_TYPE_REGS:
 		if (!deref_stack_regs(state, sp, &state->ip, &state->sp)) {
 			orc_warn_current("can't access registers at %pB\n",
 					 (void *)orig_ip);
@@ -559,7 +560,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		state->signal = true;
 		break;
 
-	case ORC_TYPE_REGS_IRET:
+	case UNWIND_HINT_TYPE_REGS_PARTIAL:
 		if (!deref_stack_iret_regs(state, sp, &state->ip, &state->sp)) {
 			orc_warn_current("can't access iret registers at %pB\n",
 					 (void *)orig_ip);
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 15e9997..ab82c79 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -2,9 +2,55 @@
 #ifndef _LINUX_OBJTOOL_H
 #define _LINUX_OBJTOOL_H
 
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+/*
+ * This struct is used by asm and inline asm code to manually annotate the
+ * location of registers on the stack.
+ */
+struct unwind_hint {
+	u32		ip;
+	s16		sp_offset;
+	u8		sp_reg;
+	u8		type;
+	u8		end;
+};
+#endif
+
+/*
+ * UNWIND_HINT_TYPE_CALL: Indicates that sp_reg+sp_offset resolves to PREV_SP
+ * (the caller's SP right before it made the call).  Used for all callable
+ * functions, i.e. all C code and all callable asm functions.
+ *
+ * UNWIND_HINT_TYPE_REGS: Used in entry code to indicate that sp_reg+sp_offset
+ * points to a fully populated pt_regs from a syscall, interrupt, or exception.
+ *
+ * UNWIND_HINT_TYPE_REGS_PARTIAL: Used in entry code to indicate that
+ * sp_reg+sp_offset points to the iret return frame.
+ */
+#define UNWIND_HINT_TYPE_CALL		0
+#define UNWIND_HINT_TYPE_REGS		1
+#define UNWIND_HINT_TYPE_REGS_PARTIAL	2
+#define UNWIND_HINT_TYPE_RET_OFFSET	3
+
 #ifdef CONFIG_STACK_VALIDATION
 
 #ifndef __ASSEMBLY__
+
+#define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
+	"987: \n\t"						\
+	".pushsection .discard.unwind_hints\n\t"		\
+	/* struct unwind_hint */				\
+	".long 987b - .\n\t"					\
+	".short " __stringify(sp_offset) "\n\t"			\
+	".byte " __stringify(sp_reg) "\n\t"			\
+	".byte " __stringify(type) "\n\t"			\
+	".byte " __stringify(end) "\n\t"			\
+	".balign 4 \n\t"					\
+	".popsection\n\t"
+
 /*
  * This macro marks the given function's stack frame as "non-standard", which
  * tells objtool to ignore the function when doing stack metadata validation.
@@ -29,12 +75,54 @@
 	.long 999b;						\
 	.popsection;
 
+/*
+ * In asm, there are two kinds of code: normal C-type callable functions and
+ * the rest.  The normal callable functions can be called by other code, and
+ * don't do anything unusual with the stack.  Such normal callable functions
+ * are annotated with the ENTRY/ENDPROC macros.  Most asm code falls in this
+ * category.  In this case, no special debugging annotations are needed because
+ * objtool can automatically generate the ORC data for the ORC unwinder to read
+ * at runtime.
+ *
+ * Anything which doesn't fall into the above category, such as syscall and
+ * interrupt handlers, tends to not be called directly by other functions, and
+ * often does unusual non-C-function-type things with the stack pointer.  Such
+ * code needs to be annotated such that objtool can understand it.  The
+ * following CFI hint macros are for this type of code.
+ *
+ * These macros provide hints to objtool about the state of the stack at each
+ * instruction.  Objtool starts from the hints and follows the code flow,
+ * making automatic CFI adjustments when it sees pushes and pops, filling out
+ * the debuginfo as necessary.  It will also warn if it sees any
+ * inconsistencies.
+ */
+.macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
+.Lunwind_hint_ip_\@:
+	.pushsection .discard.unwind_hints
+		/* struct unwind_hint */
+		.long .Lunwind_hint_ip_\@ - .
+		.short \sp_offset
+		.byte \sp_reg
+		.byte \type
+		.byte \end
+		.balign 4
+	.popsection
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #else /* !CONFIG_STACK_VALIDATION */
 
+#ifndef __ASSEMBLY__
+
+#define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
+	"\n\t"
 #define STACK_FRAME_NON_STANDARD(func)
+#else
 #define ANNOTATE_INTRA_FUNCTION_CALL
+.macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
+.endm
+#endif
 
 #endif /* CONFIG_STACK_VALIDATION */
 
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index d255349..fdbffec 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -39,27 +39,6 @@
 #define ORC_REG_SP_INDIRECT		9
 #define ORC_REG_MAX			15
 
-/*
- * ORC_TYPE_CALL: Indicates that sp_reg+sp_offset resolves to PREV_SP (the
- * caller's SP right before it made the call).  Used for all callable
- * functions, i.e. all C code and all callable asm functions.
- *
- * ORC_TYPE_REGS: Used in entry code to indicate that sp_reg+sp_offset points
- * to a fully populated pt_regs from a syscall, interrupt, or exception.
- *
- * ORC_TYPE_REGS_IRET: Used in entry code to indicate that sp_reg+sp_offset
- * points to the iret return frame.
- *
- * The UNWIND_HINT macros are used only for the unwind_hint struct.  They
- * aren't used in struct orc_entry due to size and complexity constraints.
- * Objtool converts them to real types when it converts the hints to orc
- * entries.
- */
-#define ORC_TYPE_CALL			0
-#define ORC_TYPE_REGS			1
-#define ORC_TYPE_REGS_IRET		2
-#define UNWIND_HINT_TYPE_RET_OFFSET	3
-
 #ifndef __ASSEMBLY__
 /*
  * This struct is more or less a vastly simplified version of the DWARF Call
@@ -78,19 +57,6 @@ struct orc_entry {
 	unsigned	end:1;
 } __packed;
 
-/*
- * This struct is used by asm and inline asm code to manually annotate the
- * location of registers on the stack for the ORC unwinder.
- *
- * Type can be either ORC_TYPE_* or UNWIND_HINT_TYPE_*.
- */
-struct unwind_hint {
-	u32		ip;
-	s16		sp_offset;
-	u8		sp_reg;
-	u8		type;
-	u8		end;
-};
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ORC_TYPES_H */
diff --git a/tools/include/linux/objtool.h b/tools/include/linux/objtool.h
new file mode 100644
index 0000000..ab82c79
--- /dev/null
+++ b/tools/include/linux/objtool.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_OBJTOOL_H
+#define _LINUX_OBJTOOL_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+/*
+ * This struct is used by asm and inline asm code to manually annotate the
+ * location of registers on the stack.
+ */
+struct unwind_hint {
+	u32		ip;
+	s16		sp_offset;
+	u8		sp_reg;
+	u8		type;
+	u8		end;
+};
+#endif
+
+/*
+ * UNWIND_HINT_TYPE_CALL: Indicates that sp_reg+sp_offset resolves to PREV_SP
+ * (the caller's SP right before it made the call).  Used for all callable
+ * functions, i.e. all C code and all callable asm functions.
+ *
+ * UNWIND_HINT_TYPE_REGS: Used in entry code to indicate that sp_reg+sp_offset
+ * points to a fully populated pt_regs from a syscall, interrupt, or exception.
+ *
+ * UNWIND_HINT_TYPE_REGS_PARTIAL: Used in entry code to indicate that
+ * sp_reg+sp_offset points to the iret return frame.
+ */
+#define UNWIND_HINT_TYPE_CALL		0
+#define UNWIND_HINT_TYPE_REGS		1
+#define UNWIND_HINT_TYPE_REGS_PARTIAL	2
+#define UNWIND_HINT_TYPE_RET_OFFSET	3
+
+#ifdef CONFIG_STACK_VALIDATION
+
+#ifndef __ASSEMBLY__
+
+#define UNWIND_HINT(sp_reg, sp_offset, type, end)		\
+	"987: \n\t"						\
+	".pushsection .discard.unwind_hints\n\t"		\
+	/* struct unwind_hint */				\
+	".long 987b - .\n\t"					\
+	".short " __stringify(sp_offset) "\n\t"			\
+	".byte " __stringify(sp_reg) "\n\t"			\
+	".byte " __stringify(type) "\n\t"			\
+	".byte " __stringify(end) "\n\t"			\
+	".balign 4 \n\t"					\
+	".popsection\n\t"
+
+/*
+ * This macro marks the given function's stack frame as "non-standard", which
+ * tells objtool to ignore the function when doing stack metadata validation.
+ * It should only be used in special cases where you're 100% sure it won't
+ * affect the reliability of frame pointers and kernel stack traces.
+ *
+ * For more information, see tools/objtool/Documentation/stack-validation.txt.
+ */
+#define STACK_FRAME_NON_STANDARD(func) \
+	static void __used __section(.discard.func_stack_frame_non_standard) \
+		*__func_stack_frame_non_standard_##func = func
+
+#else /* __ASSEMBLY__ */
+
+/*
+ * This macro indicates that the following intra-function call is valid.
+ * Any non-annotated intra-function call will cause objtool to issue a warning.
+ */
+#define ANNOTATE_INTRA_FUNCTION_CALL				\
+	999:							\
+	.pushsection .discard.intra_function_calls;		\
+	.long 999b;						\
+	.popsection;
+
+/*
+ * In asm, there are two kinds of code: normal C-type callable functions and
+ * the rest.  The normal callable functions can be called by other code, and
+ * don't do anything unusual with the stack.  Such normal callable functions
+ * are annotated with the ENTRY/ENDPROC macros.  Most asm code falls in this
+ * category.  In this case, no special debugging annotations are needed because
+ * objtool can automatically generate the ORC data for the ORC unwinder to read
+ * at runtime.
+ *
+ * Anything which doesn't fall into the above category, such as syscall and
+ * interrupt handlers, tends to not be called directly by other functions, and
+ * often does unusual non-C-function-type things with the stack pointer.  Such
+ * code needs to be annotated such that objtool can understand it.  The
+ * following CFI hint macros are for this type of code.
+ *
+ * These macros provide hints to objtool about the state of the stack at each
+ * instruction.  Objtool starts from the hints and follows the code flow,
+ * making automatic CFI adjustments when it sees pushes and pops, filling out
+ * the debuginfo as necessary.  It will also warn if it sees any
+ * inconsistencies.
+ */
+.macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
+.Lunwind_hint_ip_\@:
+	.pushsection .discard.unwind_hints
+		/* struct unwind_hint */
+		.long .Lunwind_hint_ip_\@ - .
+		.short \sp_offset
+		.byte \sp_reg
+		.byte \type
+		.byte \end
+		.balign 4
+	.popsection
+.endm
+
+#endif /* __ASSEMBLY__ */
+
+#else /* !CONFIG_STACK_VALIDATION */
+
+#ifndef __ASSEMBLY__
+
+#define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
+	"\n\t"
+#define STACK_FRAME_NON_STANDARD(func)
+#else
+#define ANNOTATE_INTRA_FUNCTION_CALL
+.macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
+.endm
+#endif
+
+#endif /* CONFIG_STACK_VALIDATION */
+
+#endif /* _LINUX_OBJTOOL_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a94ad88..95c6e0d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -14,6 +14,7 @@
 #include "warn.h"
 #include "arch_elf.h"
 
+#include <linux/objtool.h>
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
 #include <linux/static_call_types.h>
@@ -1805,7 +1806,8 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 		return 0;
 	}
 
-	if (cfi->type == ORC_TYPE_REGS || cfi->type == ORC_TYPE_REGS_IRET)
+	if (cfi->type == UNWIND_HINT_TYPE_REGS ||
+	    cfi->type == UNWIND_HINT_TYPE_REGS_PARTIAL)
 		return update_cfi_state_regs(insn, cfi, op);
 
 	switch (op->dest.type) {
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index fca46e0..5e6a953 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -4,6 +4,7 @@
  */
 
 #include <unistd.h>
+#include <linux/objtool.h>
 #include <asm/orc_types.h>
 #include "objtool.h"
 #include "warn.h"
@@ -37,12 +38,12 @@ static const char *reg_name(unsigned int reg)
 static const char *orc_type_name(unsigned int type)
 {
 	switch (type) {
-	case ORC_TYPE_CALL:
+	case UNWIND_HINT_TYPE_CALL:
 		return "call";
-	case ORC_TYPE_REGS:
+	case UNWIND_HINT_TYPE_REGS:
 		return "regs";
-	case ORC_TYPE_REGS_IRET:
-		return "iret";
+	case UNWIND_HINT_TYPE_REGS_PARTIAL:
+		return "regs (partial)";
 	default:
 		return "?";
 	}
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 22fe439..235663b 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -6,6 +6,9 @@
 #include <stdlib.h>
 #include <string.h>
 
+#include <linux/objtool.h>
+#include <asm/orc_types.h>
+
 #include "check.h"
 #include "warn.h"
 
@@ -146,7 +149,7 @@ int create_orc_sections(struct objtool_file *file)
 	struct orc_entry empty = {
 		.sp_reg = ORC_REG_UNDEFINED,
 		.bp_reg  = ORC_REG_UNDEFINED,
-		.type    = ORC_TYPE_CALL,
+		.type    = UNWIND_HINT_TYPE_CALL,
 	};
 
 	sec = find_section_by_name(file->elf, ".orc_unwind");
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index cea1c12..606a4b5 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -6,8 +6,10 @@ if [ -z "$SRCARCH" ]; then
 	exit 1
 fi
 
+FILES="include/linux/objtool.h"
+
 if [ "$SRCARCH" = "x86" ]; then
-FILES="
+FILES="$FILES
 arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/orc_types.h
 arch/x86/include/asm/emulate_prefix.h
