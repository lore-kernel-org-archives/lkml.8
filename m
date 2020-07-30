Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F915C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C68420809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QH6A421x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgG3Jr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:47:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38082 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729191AbgG3JrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596102429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lHO+GvX2uzE/1hWF4ckwTqk9qt2tVQ8+Nb/MvunUgLA=;
        b=QH6A421x5VWm02PbdzHcA3PYLpaXTddR31/3Eyk5laF1Wo9lQ8lf0AkFdER/1m62wKaU3F
        cIbXkpVdOAt/6oK2Lb67+IFVFZz6eWsTZ1K7OHwGYCDnK3uQPBw9fGSJPnUkPW/cwV1Xg6
        fPLM8oZzG7eNKXWYskPPZivruHvBLSk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-XF0bERyRNCqVwfCSyzy8ig-1; Thu, 30 Jul 2020 05:47:07 -0400
X-MC-Unique: XF0bERyRNCqVwfCSyzy8ig-1
Received: by mail-wm1-f69.google.com with SMTP id h205so2062968wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lHO+GvX2uzE/1hWF4ckwTqk9qt2tVQ8+Nb/MvunUgLA=;
        b=RrNSAZGLF30G6pL49DVIqOIi+ryi9xN+UF4rtquIr4YnMNgLKnen/VpOcJWRW/88lv
         xz6XLxVNRUG+2ZniFK6CmZ60iGLxK4MloDJkuMoupxOYnC8LTIz53cYB//6fu44QeiVg
         +BemFAUDpUQm56A/Pyhlid76L670Ciua1wvB7a71Q1ffM2EEU4b6qtUjQOLny613f3HI
         Labuk3qTtoXzRX54SW6z5VilBkvcPIgnktQ9YIwOLRDpSawIRrU84AzWMCmCc/fkrlM1
         8+AdqJPERF/wj9BKIn6SKMvjeJ8gFAFWwPDvKasMxL5Izk6aIGR/kxTQ+ejQqaBn4efA
         97Wg==
X-Gm-Message-State: AOAM530YF5XMWmY8QeS2qRhm6W0UopgV+KUxGNsItiLe2xAC5Dzinsyk
        djsWK4PHbaVOETuRNIXy1msJ+UUgtL1vj+OAID3Yl/3G4tF0MnjTIlh9LRRYoyYTsG29adKIrnj
        uZvT1MYAjJg0X3picEbKeXDmF
X-Received: by 2002:adf:c401:: with SMTP id v1mr32214656wrf.379.1596102425521;
        Thu, 30 Jul 2020 02:47:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJBoup7+4z2uAf13I6Kgn8vOKHBJEVqRZxqfDSfW1744DLmiG7hwufPMWzJB9UEEKRMiyZ1A==
X-Received: by 2002:adf:c401:: with SMTP id v1mr32214628wrf.379.1596102425052;
        Thu, 30 Jul 2020 02:47:05 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j6sm9009645wro.25.2020.07.30.02.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:47:04 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 8/9] frame: Make unwind hints definitions available to other architectures
Date:   Thu, 30 Jul 2020 10:46:51 +0100
Message-Id: <20200730094652.28297-9-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200730094652.28297-1-jthierry@redhat.com>
References: <20200730094652.28297-1-jthierry@redhat.com>
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
 arch/x86/include/asm/orc_types.h       |  13 ---
 arch/x86/include/asm/unwind_hints.h    |  44 ++--------
 include/linux/frame.h                  |  72 ++++++++++++++++
 tools/arch/x86/include/asm/orc_types.h |  13 ---
 tools/include/linux/frame.h            | 113 +++++++++++++++++++++++++
 tools/objtool/check.c                  |   1 +
 tools/objtool/sync-check.sh            |   4 +-
 7 files changed, 194 insertions(+), 66 deletions(-)
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
index d946adb5de17..fa06f2b99625 100644
--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -2,9 +2,39 @@
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
+#endif
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
@@ -29,12 +59,54 @@
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
index 000000000000..fa06f2b99625
--- /dev/null
+++ b/tools/include/linux/frame.h
@@ -0,0 +1,113 @@
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
+#endif
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
+#endif /* _LINUX_FRAME_H */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 60f5be2accf6..d6731e88259d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -14,6 +14,7 @@
 #include "warn.h"
 #include "arch_elf.h"
 
+#include <linux/frame.h>
 #include <linux/hashtable.h>
 #include <linux/kernel.h>
 
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
2.21.3

