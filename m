Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A1FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C2F0206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 15:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FbXhDDUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbgFHP2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:28:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59927 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730264AbgFHP2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591630089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tTjjCWgOVP+JiV1x/LwPic4IjLbWywge1pJeAGsyXV4=;
        b=FbXhDDUMefDdkJoqPnAMSRKUIJ2Pl99pzf5grr8/6G0Yl/Au8UI5ha6H5A9vjOFFSs6987
        X3tX/0C0gObJ2OjkamsU+rR8qLyMwc4c8wCkBFiqakS9Tw/vUWmb0tipWoYKWNb2yPiLiw
        Q+ioeicB7TwQbJ0zGdYL8Rzc6LUb2IU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-y-8yvkF6NPWjt_t5_qR6Vg-1; Mon, 08 Jun 2020 11:28:07 -0400
X-MC-Unique: y-8yvkF6NPWjt_t5_qR6Vg-1
Received: by mail-wm1-f71.google.com with SMTP id g84so5379684wmf.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 08:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tTjjCWgOVP+JiV1x/LwPic4IjLbWywge1pJeAGsyXV4=;
        b=k5wxAZxFNAn9otQsPrf8Iw+4ERuZHzvrIVpvrWszE0cSFW3lwOx1jCNW7Y3u+gVYbq
         MYvaD8vimqIlUAAkQ5LN+rOi+uetzrULrEGobfb3sQGlZYZVSw9MHwdWxiMBbqIScIYN
         0GnPjDa2ZikYwut9qtuImGbl3H1MGAKhqlU6Y6vdh39qQaqpqRTxpIo0ISteZoXJuYw9
         9G0EiV4amu2YTnMkykp1gzg2roAJ4f2sgRbwa2KtRTtojYrMMty2Mkb5NdhFt95rT0y5
         jZbtpsp9bvHWOIZqNjuDWAXWyx8INyQOeC3VZP5EkLWj13prcU5xXwRB1O820c5JJz8J
         Obkg==
X-Gm-Message-State: AOAM530VU7YhwFLKdS8gIFcjWX7gZY4Z+//lpUlIuTD+Oh2C7ZmsgyOV
        a1ZkO9LRILaZPystgt9eaKF17O0r7tgbKmwHJifahcvQVDlvNS+tTDVh4XZte3+3gtJZLPvnLtZ
        ChO2hsNVZRRpCTjoB+Ip+/6tD
X-Received: by 2002:a1c:19c1:: with SMTP id 184mr16125713wmz.29.1591630085838;
        Mon, 08 Jun 2020 08:28:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw73a7sprqqBtfJKSIjtAX+R9kDjYTR6x2GiDV+NUVBmXJrtripywXJGtCP0xxi8QkVaQ/6UQ==
X-Received: by 2002:a1c:19c1:: with SMTP id 184mr16125685wmz.29.1591630085228;
        Mon, 08 Jun 2020 08:28:05 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id u130sm23981707wmg.32.2020.06.08.08.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 08:28:04 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, Julien Thierry <jthierry@redhat.com>
Subject: [RFC PATCH 7/7] objtool: Make unwind_hints available for all architectures
Date:   Mon,  8 Jun 2020 16:27:54 +0100
Message-Id: <20200608152754.2483-8-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200608152754.2483-1-jthierry@redhat.com>
References: <20200608152754.2483-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unwind hints are useful to give some information about the call frame
or stack states in non-standard code.

Despite unwind hints being used in arch-independent code, the
unwind_hint structure type itself is define in x86 kernel headers.

This is because what an unwind hint will describe is very architecture
specific, both regarding the state and the affected registers.

To get to share this concept, expose the unwind_hint structure across
architecutres. However, the hint types remain defined by the
architecture code. Objtool then needs it's arch specific code to
"decode" the unwind hint into a cfi_state.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 arch/x86/include/asm/orc_types.h       |  13 ---
 arch/x86/include/asm/unwind_hints.h    |  44 ++--------
 include/linux/frame.h                  |  83 +++++++++++++++++-
 tools/arch/x86/include/asm/orc_types.h |  13 ---
 tools/include/linux/frame.h            | 114 +++++++++++++++++++++++++
 tools/objtool/arch.h                   |   5 +-
 tools/objtool/arch/x86/decode.c        |  54 ++++++++++++
 tools/objtool/cfi.h                    |   3 +-
 tools/objtool/check.c                  |  59 +++----------
 tools/objtool/orc_gen.c                |   4 +-
 tools/objtool/sync-check.sh            |   4 +-
 11 files changed, 275 insertions(+), 121 deletions(-)
 create mode 100644 tools/include/linux/frame.h

diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index d25534940bde..00408d30b13e 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -78,19 +78,6 @@ struct orc_entry {
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
index 7d903fdb3f43..e81a18bb114f 100644
--- a/arch/x86/include/asm/unwind_hints.h
+++ b/arch/x86/include/asm/unwind_hints.h
@@ -1,48 +1,14 @@
 #ifndef _ASM_X86_UNWIND_HINTS_H
 #define _ASM_X86_UNWIND_HINTS_H

+#include <linux/frame.h>
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
+	UNWIND_HINT sp_reg=ORC_REG_UNDEFINED type=ORC_TYPE_CALL end=1
 .endm

 .macro UNWIND_HINT_REGS base=%rsp offset=0 indirect=0 extra=1 iret=0
@@ -83,7 +49,7 @@
 .endm

 .macro UNWIND_HINT_FUNC sp_offset=8
-	UNWIND_HINT sp_offset=\sp_offset
+	UNWIND_HINT sp_reg=ORC_REG_SP sp_offset=\sp_offset type=ORC_TYPE_CALL
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
diff --git a/include/linux/frame.h b/include/linux/frame.h
index 303cda600e56..9a41292453eb 100644
--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -2,7 +2,36 @@
 #ifndef _LINUX_FRAME_H
 #define _LINUX_FRAME_H

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
+
 #ifdef CONFIG_STACK_VALIDATION
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
@@ -15,6 +44,18 @@
 	static void __used __section(.discard.func_stack_frame_non_standard) \
 		*__func_stack_frame_non_standard_##func = func

+#else /* !CONFIG_STACK_VALIDATION */
+
+#define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
+	"\n\t"
+
+#define STACK_FRAME_NON_STANDARD(func)
+
+#endif /* CONFIG_STACK_VALIDATION */
+
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_STACK_VALIDATION
 /*
  * This macro indicates that the following intra-function call is valid.
  * Any non-annotated intra-function call will cause objtool to issue a warning.
@@ -25,11 +66,49 @@
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
 #else /* !CONFIG_STACK_VALIDATION */

-#define STACK_FRAME_NON_STANDARD(func)
 #define ANNOTATE_INTRA_FUNCTION_CALL

-#endif /* CONFIG_STACK_VALIDATION */
+.macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
+.endm
+
+#endif
+
+#endif /* __ASSEMBLY__ */

 #endif /* _LINUX_FRAME_H */
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index d25534940bde..00408d30b13e 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -78,19 +78,6 @@ struct orc_entry {
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
diff --git a/tools/include/linux/frame.h b/tools/include/linux/frame.h
new file mode 100644
index 000000000000..9a41292453eb
--- /dev/null
+++ b/tools/include/linux/frame.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FRAME_H
+#define _LINUX_FRAME_H
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
+
+#ifdef CONFIG_STACK_VALIDATION
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
+#else /* !CONFIG_STACK_VALIDATION */
+
+#define UNWIND_HINT(sp_reg, sp_offset, type, end)	\
+	"\n\t"
+
+#define STACK_FRAME_NON_STANDARD(func)
+
+#endif /* CONFIG_STACK_VALIDATION */
+
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_STACK_VALIDATION
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
+#else /* !CONFIG_STACK_VALIDATION */
+
+#define ANNOTATE_INTRA_FUNCTION_CALL
+
+.macro UNWIND_HINT sp_reg:req sp_offset=0 type:req end=0
+.endm
+
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _LINUX_FRAME_H */
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index eda15a5a285e..b7b8081a8117 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -7,12 +7,11 @@
 #define _ARCH_H

 #include <stdbool.h>
+#include <linux/frame.h>
 #include <linux/list.h>
 #include "objtool.h"
 #include "cfi.h"

-#include <asm/orc_types.h>
-
 enum insn_type {
 	INSN_JUMP_CONDITIONAL,
 	INSN_JUMP_UNCONDITIONAL,
@@ -84,4 +83,6 @@ unsigned long arch_jump_destination(struct instruction *insn);

 unsigned long arch_dest_rela_offset(int addend);

+int arch_decode_insn_hint(struct instruction *insn, struct unwind_hint *hint);
+
 #endif /* _ARCH_H */
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 4b504fc90bbb..bf1fb2354423 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -6,6 +6,8 @@
 #include <stdio.h>
 #include <stdlib.h>

+#include <linux/frame.h>
+
 #define unlikely(cond) (cond)
 #include <asm/insn.h>
 #include "../../../arch/x86/lib/inat.c"
@@ -15,6 +17,7 @@
 #include "../../elf.h"
 #include "../../arch.h"
 #include "../../warn.h"
+#include <asm/orc_types.h>

 static unsigned char op_to_cfi_reg[][2] = {
 	{CFI_AX, CFI_R8},
@@ -565,3 +568,54 @@ void arch_initial_func_cfi_state(struct cfi_init_state *state)
 	state->regs[16].base = CFI_CFA;
 	state->regs[16].offset = -8;
 }
+
+int arch_decode_insn_hint(struct instruction *insn, struct unwind_hint *hint)
+{
+	struct cfi_reg *cfa = &insn->cfi.cfa;
+
+	if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
+		insn->ret_offset = hint->sp_offset;
+		return 0;
+	}
+
+	insn->hint = true;
+
+	switch (hint->sp_reg) {
+	case ORC_REG_UNDEFINED:
+		cfa->base = CFI_UNDEFINED;
+		break;
+	case ORC_REG_SP:
+		cfa->base = CFI_SP;
+		break;
+	case ORC_REG_BP:
+		cfa->base = CFI_BP;
+		break;
+	case ORC_REG_SP_INDIRECT:
+		cfa->base = CFI_SP_INDIRECT;
+		break;
+	case ORC_REG_R10:
+		cfa->base = CFI_R10;
+		break;
+	case ORC_REG_R13:
+		cfa->base = CFI_R13;
+		break;
+	case ORC_REG_DI:
+		cfa->base = CFI_DI;
+		break;
+	case ORC_REG_DX:
+		cfa->base = CFI_DX;
+		break;
+	default:
+		WARN_FUNC("unsupported unwind_hint sp base reg %d",
+			  insn->sec, insn->offset, hint->sp_reg);
+		return -1;
+	}
+
+	cfa->offset = hint->sp_offset;
+	insn->cfi.hint_type = hint->type;
+	insn->cfi.end = hint->end;
+
+	insn->cfi.sp_only = hint->type == ORC_TYPE_REGS || hint->type == ORC_TYPE_REGS_IRET;
+
+	return 0;
+}
diff --git a/tools/objtool/cfi.h b/tools/objtool/cfi.h
index c7c59c6a44ee..f5aeca023133 100644
--- a/tools/objtool/cfi.h
+++ b/tools/objtool/cfi.h
@@ -29,10 +29,11 @@ struct cfi_state {
 	struct cfi_reg cfa;
 	int stack_size;
 	int drap_reg, drap_offset;
-	unsigned char type;
+	unsigned char hint_type;
 	bool bp_scratch;
 	bool drap;
 	bool end;
+	bool sp_only;
 };

 #endif /* _OBJTOOL_CFI_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 444688264c39..1de4224a7fe2 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -13,6 +13,7 @@
 #include "special.h"
 #include "warn.h"

+#include <linux/frame.h>
 #include <linux/hashtable.h>
 #include <linux/kernel.h>

@@ -1175,7 +1176,6 @@ static int read_unwind_hints(struct objtool_file *file)
 	struct rela *rela;
 	struct unwind_hint *hint;
 	struct instruction *insn;
-	struct cfi_reg *cfa;
 	int i;

 	sec = find_section_by_name(file->elf, ".discard.unwind_hints");
@@ -1210,49 +1210,10 @@ static int read_unwind_hints(struct objtool_file *file)
 			return -1;
 		}

-		cfa = &insn->cfi.cfa;
-
-		if (hint->type == UNWIND_HINT_TYPE_RET_OFFSET) {
-			insn->ret_offset = hint->sp_offset;
-			continue;
-		}
-
-		insn->hint = true;
-
-		switch (hint->sp_reg) {
-		case ORC_REG_UNDEFINED:
-			cfa->base = CFI_UNDEFINED;
-			break;
-		case ORC_REG_SP:
-			cfa->base = CFI_SP;
-			break;
-		case ORC_REG_BP:
-			cfa->base = CFI_BP;
-			break;
-		case ORC_REG_SP_INDIRECT:
-			cfa->base = CFI_SP_INDIRECT;
-			break;
-		case ORC_REG_R10:
-			cfa->base = CFI_R10;
-			break;
-		case ORC_REG_R13:
-			cfa->base = CFI_R13;
-			break;
-		case ORC_REG_DI:
-			cfa->base = CFI_DI;
-			break;
-		case ORC_REG_DX:
-			cfa->base = CFI_DX;
-			break;
-		default:
-			WARN_FUNC("unsupported unwind_hint sp base reg %d",
-				  insn->sec, insn->offset, hint->sp_reg);
+		if (arch_decode_insn_hint(insn, hint)) {
+			WARN_FUNC("Bad unwind hint", insn->sec, insn->offset);
 			return -1;
 		}
-
-		cfa->offset = hint->sp_offset;
-		insn->cfi.type = hint->type;
-		insn->cfi.end = hint->end;
 	}

 	return 0;
@@ -1529,9 +1490,9 @@ static bool has_valid_stack_frame(struct insn_state *state)
 	return false;
 }

-static int update_cfi_state_regs(struct instruction *insn,
-				  struct cfi_state *cfi,
-				  struct stack_op *op)
+static int update_sp_only_cfi_state(struct instruction *insn,
+				    struct cfi_state *cfi,
+				    struct stack_op *op)
 {
 	struct cfi_reg *cfa = &cfi->cfa;

@@ -1637,8 +1598,8 @@ static int update_cfi_state(struct instruction *insn, struct cfi_state *cfi,
 		return 0;
 	}

-	if (cfi->type == ORC_TYPE_REGS || cfi->type == ORC_TYPE_REGS_IRET)
-		return update_cfi_state_regs(insn, cfi, op);
+	if (cfi->sp_only)
+		return update_sp_only_cfi_state(insn, cfi, op);

 	switch (op->dest.type) {

@@ -2042,10 +2003,10 @@ static bool insn_cfi_match(struct instruction *insn, struct cfi_state *cfi2)
 			break;
 		}

-	} else if (cfi1->type != cfi2->type) {
+	} else if (cfi1->hint_type != cfi2->hint_type) {

 		WARN_FUNC("stack state mismatch: type1=%d type2=%d",
-			  insn->sec, insn->offset, cfi1->type, cfi2->type);
+			  insn->sec, insn->offset, cfi1->hint_type, cfi2->hint_type);

 	} else if (cfi1->drap != cfi2->drap ||
 		   (cfi1->drap && cfi1->drap_reg != cfi2->drap_reg) ||
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 2c4e1974bbb5..515f93e841d5 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -9,6 +9,8 @@
 #include "check.h"
 #include "warn.h"

+#include <asm/orc_types.h>
+
 struct orc_data {
 	struct list_head list;
 	struct instruction *insn;
@@ -92,7 +94,7 @@ int create_orc(struct objtool_file *file)

 		orc->sp_offset = cfa->offset;
 		orc->bp_offset = bp->offset;
-		orc->type = insn->cfi.type;
+		orc->type = insn->cfi.hint_type;
 	}

 	return 0;
diff --git a/tools/objtool/sync-check.sh b/tools/objtool/sync-check.sh
index f01b5a4d12ac..dc14ade100aa 100755
--- a/tools/objtool/sync-check.sh
+++ b/tools/objtool/sync-check.sh
@@ -3,8 +3,10 @@

 TARGET_ARCH=$1

+FILES="include/linux/frame.h"
+
 if [ "$TARGET_ARCH" == "x86" ]; then
-FILES="
+FILES="$FILES
 arch/x86/include/asm/inat_types.h
 arch/x86/include/asm/orc_types.h
 arch/x86/include/asm/emulate_prefix.h
--
2.21.1

