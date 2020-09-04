Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4FBC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B80E2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aRjfoMGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgIDPf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:35:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41543 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgIDPf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599233725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ONplZBRzpzNx1xuxo1oURZB5tuuBAE3h4RSprBxZhME=;
        b=aRjfoMGQD20ISPBVlr79LgiHiRPoGJJcf7awkZY84ZABBOeWbMyTSGp3yHFj6SOWSn6lTn
        1TlQT5BptSFNJFOkX3TPnTjbYMpiSibFzthzOLcohXmd6gCwrI/4P1cJhEL64z7a0eTyIh
        BC1mnH+jlTzQO3CKlEx7YSNVt/ru2gI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-WxjkhCaENxalBBl05to9Ag-1; Fri, 04 Sep 2020 11:35:21 -0400
X-MC-Unique: WxjkhCaENxalBBl05to9Ag-1
Received: by mail-ej1-f70.google.com with SMTP id p21so2659039ejj.18
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONplZBRzpzNx1xuxo1oURZB5tuuBAE3h4RSprBxZhME=;
        b=uFhYQtxP/YJNyEYxOdUQZoVfBPXyrC2NkTUnlg1Jex1znksZSdcUCeaSlD1I3A8emC
         gW0dJpDSYmld36Rxs4TZ3crV6stDT+TISaTkGHxAwU7F+wnHl1xjm9dJ3DJg5fEWIMR2
         ZiPoizCcdm3E1cNQZJheC3kqs5fI5SUMhfC0/ttLGkmdthM48dMY0CwpHqIBxcWuDkG5
         FL2t4MD4um4q1ugTFpAjRX1bDamEx/cw8ECX5OVwvA/BPC5tzkONNQtk3r8YNgY6A2Wr
         KXbGJ5KG8AcAY/kHCeFkoQYksZmsubFkxUXNDCWH5p+hWv4EowH4yOr38NJGWSvfenJM
         exOw==
X-Gm-Message-State: AOAM530yVhOeYWAhS+oA2tB7peCFDKOsajQeLUaFIoAWy91jo+Z538dZ
        xNmnx5MNoUJoIpSr9QGoFE2MAbQISIOyMf714PPDoWTiKASkvEUhGHD5kVM0/Ye2ASSUqncMTP9
        SNGYFcgdd2x6e01RxAqwGhKCR
X-Received: by 2002:a17:906:a116:: with SMTP id t22mr8237954ejy.353.1599233719929;
        Fri, 04 Sep 2020 08:35:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbyPvy9XyRy2bItgn+yMtSYyH0OVuXhh0TOYqsZ9rNzLIZkd/PwCQpc5Sr9gggxgm+2RZQkQ==
X-Received: by 2002:a17:906:a116:: with SMTP id t22mr8237912ejy.353.1599233719473;
        Fri, 04 Sep 2020 08:35:19 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id g19sm6464979ejz.5.2020.09.04.08.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:35:19 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v3 09/10] objtool: Make unwind hints definitions available to other architectures
Date:   Fri,  4 Sep 2020 16:30:27 +0100
Message-Id: <20200904153028.32676-10-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200904153028.32676-1-jthierry@redhat.com>
References: <20200904153028.32676-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unwind hints are useful to provide objtool with information about stack
states in non-standard functions/code.
While the type of information being provided might be very arch
specific, the mechanism to provide the information can be useful for
other architectures.

Move the relevant unwint hint definitions for all architectures to
see.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/x86/include/asm/orc_types.h       |  34 -------
 arch/x86/include/asm/unwind_hints.h    |  50 ++-------
 arch/x86/kernel/unwind_orc.c           |  11 +-
 include/linux/objtool.h                |  93 +++++++++++++++++
 tools/arch/x86/include/asm/orc_types.h |  34 -------
 tools/include/linux/objtool.h          | 134 +++++++++++++++++++++++++
 tools/objtool/check.c                  |   3 +-
 tools/objtool/orc_dump.c               |   7 +-
 tools/objtool/orc_gen.c                |   5 +-
 tools/objtool/sync-check.sh            |   4 +-
 10 files changed, 254 insertions(+), 121 deletions(-)
 create mode 100644 tools/include/linux/objtool.h

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index d25534940bde..fdbffec4cfde 100644
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
index 7d903fdb3f43..da38f7f3ae2d 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -1,48 +1,14 @@
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
 
 .macro UNWIND_HINT_REGS base=%rsp offset=0 indirect=0 extra=1 iret=0
@@ -67,12 +33,12 @@
 	.set sp_offset, \offset
 
 	.if \iret
-		.set type, ORC_TYPE_REGS_IRET
+		.set type, UNWIND_HINT_TYPE_REGS_IRET
 	.elseif \extra == 0
-		.set type, ORC_TYPE_REGS_IRET
+		.set type, UNWIND_HINT_TYPE_REGS_IRET
 		.set sp_offset, \offset + (16*8)
 	.else
-		.set type, ORC_TYPE_REGS
+		.set type, UNWIND_HINT_TYPE_REGS
 	.endif
 
 	UNWIND_HINT sp_reg=sp_reg sp_offset=sp_offset type=type
@@ -83,7 +49,7 @@
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
index ec88bbe08a32..4d8b5db57c9a 100644
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
+	case UNWIND_HINT_TYPE_REGS_IRET:
 		if (!deref_stack_iret_regs(state, sp, &state->ip, &state->sp)) {
 			orc_warn_current("can't access iret registers at %pB\n",
 					 (void *)orig_ip);
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 15e9997a9fb4..6df371510b96 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -2,9 +2,60 @@
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
+ * UNWIND_HINT_TYPE_REGS_IRET: Used in entry code to indicate that sp_reg+sp_offset
+ * points to the iret return frame.
+ *
+ * The UNWIND_HINT macros are used only for the unwind_hint struct.  They
+ * aren't used in struct orc_entry due to size and complexity constraints.
+ * Objtool converts them to real types when it converts the hints to orc
+ * entries.
+ */
+#define UNWIND_HINT_TYPE_CALL		0
+#define UNWIND_HINT_TYPE_REGS		1
+#define UNWIND_HINT_TYPE_REGS_IRET	2
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
@@ -29,12 +80,54 @@
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
index d25534940bde..fdbffec4cfde 100644
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
index 000000000000..6df371510b96
--- /dev/null
+++ b/tools/include/linux/objtool.h
@@ -0,0 +1,134 @@
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
+ * UNWIND_HINT_TYPE_REGS_IRET: Used in entry code to indicate that sp_reg+sp_offset
+ * points to the iret return frame.
+ *
+ * The UNWIND_HINT macros are used only for the unwind_hint struct.  They
+ * aren't used in struct orc_entry due to size and complexity constraints.
+ * Objtool converts them to real types when it converts the hints to orc
+ * entries.
+ */
+#define UNWIND_HINT_TYPE_CALL		0
+#define UNWIND_HINT_TYPE_REGS		1
+#define UNWIND_HINT_TYPE_REGS_IRET	2
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
index 921b4ba2d0f9..60e23c8f93e0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -14,6 +14,7 @@
 #include "warn.h"
 #include "arch_elf.h"
 
+#include <linux/objtool.h>
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
 
@@ -1678,7 +1679,7 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 		return 0;
 	}
 
-	if (cfi->type == ORC_TYPE_REGS || cfi->type == ORC_TYPE_REGS_IRET)
+	if (cfi->type == UNWIND_HINT_TYPE_REGS || cfi->type == UNWIND_HINT_TYPE_REGS_IRET)
 		return update_cfi_state_regs(insn, cfi, op);
 
 	switch (op->dest.type) {
diff --git a/tools/objtool/orc_dump.c b/tools/objtool/orc_dump.c
index fca46e006fc2..911ca17e4865 100644
--- a/tools/objtool/orc_dump.c
+++ b/tools/objtool/orc_dump.c
@@ -4,6 +4,7 @@
  */
 
 #include <unistd.h>
+#include <linux/objtool.h>
 #include <asm/orc_types.h>
 #include "objtool.h"
 #include "warn.h"
@@ -37,11 +38,11 @@ static const char *reg_name(unsigned int reg)
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
+	case UNWIND_HINT_TYPE_REGS_IRET:
 		return "iret";
 	default:
 		return "?";
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 66fd56c33303..597ecffead92 100644
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
index 07249900db1c..4c935bde8960 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -3,8 +3,10 @@
 
 TARGET_ARCH=$1
 
+FILES="include/linux/objtool.h"
+
 if [ "$TARGET_ARCH" == "x86" ]; then
-FILES="
+FILES="$FILES
 arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/orc_types.h
 arch/x86/include/asm/emulate_prefix.h
-- 
2.21.3

