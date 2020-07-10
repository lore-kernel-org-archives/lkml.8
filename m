Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09067C433F8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EF8206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594400003;
	bh=G1co6859482eTlg6xskgcORKetRq7JwrXuHYx/OGSTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jowCkMPf72mKI53G/vsE6IleHoFcxmHcL7oSL/bEyvvIMlvrAm0esw3AydB3w66Ov
	 oNmcLmRrl1b1TUDaMLCZ1FtLdB6qM4QQNaudVoU9OuObInAEpu46p8mbtgDDWLiGi4
	 XxqbuWUGSsublni2ouWUkLrLsWBQRsd1hs+ab50c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgGJQxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbgGJQxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:53:18 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B099207BB;
        Fri, 10 Jul 2020 16:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594399997;
        bh=G1co6859482eTlg6xskgcORKetRq7JwrXuHYx/OGSTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cEwofPOL1eUU3jKlxhGGZmbMnAa/d5ilN3fZoyOS8s63pqV1mL7IIeZCdB0j7CH0a
         VHXVRP25DBJR90Ue25rXCnYJze8xJoJU9GoayxA3CEG8rGi7UIfa2vKAG2qLNeE7QB
         MDQvyBX7ItYD/kPsXSVRwCb5l0L8t43b9sFhKGco=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Joel Fernandes <joelaf@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: [PATCH v3 16/19] arm64: alternatives: Split up alternative.h
Date:   Fri, 10 Jul 2020 17:52:00 +0100
Message-Id: <20200710165203.31284-17-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/alternative.h contains both the macros needed to use alternatives,
as well the type definitions and function prototypes for applying them.

Split the header in two, so that alternatives can be used from core
header files such as linux/compiler.h without the risk of circular
includes

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/alternative-macros.h | 276 ++++++++++++++++++++
 arch/arm64/include/asm/alternative.h        | 267 +------------------
 arch/arm64/include/asm/insn.h               |   3 +-
 3 files changed, 279 insertions(+), 267 deletions(-)
 create mode 100644 arch/arm64/include/asm/alternative-macros.h

diff --git a/arch/arm64/include/asm/alternative-macros.h b/arch/arm64/include/asm/alternative-macros.h
new file mode 100644
index 000000000000..8f4e4b60e72a
--- /dev/null
+++ b/arch/arm64/include/asm/alternative-macros.h
@@ -0,0 +1,276 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_ALTERNATIVE_MACROS_H
+#define __ASM_ALTERNATIVE_MACROS_H
+
+#include <asm/cpucaps.h>
+
+#define ARM64_CB_PATCH ARM64_NCAPS
+
+/* A64 instructions are always 32 bits. */
+#define	AARCH64_INSN_SIZE		4
+
+#ifndef __ASSEMBLY__
+
+#include <linux/stringify.h>
+
+#define ALTINSTR_ENTRY(feature)					              \
+	" .word 661b - .\n"				/* label           */ \
+	" .word 663f - .\n"				/* new instruction */ \
+	" .hword " __stringify(feature) "\n"		/* feature bit     */ \
+	" .byte 662b-661b\n"				/* source len      */ \
+	" .byte 664f-663f\n"				/* replacement len */
+
+#define ALTINSTR_ENTRY_CB(feature, cb)					      \
+	" .word 661b - .\n"				/* label           */ \
+	" .word " __stringify(cb) "- .\n"		/* callback */	      \
+	" .hword " __stringify(feature) "\n"		/* feature bit     */ \
+	" .byte 662b-661b\n"				/* source len      */ \
+	" .byte 664f-663f\n"				/* replacement len */
+
+/*
+ * alternative assembly primitive:
+ *
+ * If any of these .org directive fail, it means that insn1 and insn2
+ * don't have the same length. This used to be written as
+ *
+ * .if ((664b-663b) != (662b-661b))
+ * 	.error "Alternatives instruction length mismatch"
+ * .endif
+ *
+ * but most assemblers die if insn1 or insn2 have a .inst. This should
+ * be fixed in a binutils release posterior to 2.25.51.0.2 (anything
+ * containing commit 4e4d08cf7399b606 or c1baaddf8861).
+ *
+ * Alternatives with callbacks do not generate replacement instructions.
+ */
+#define __ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg_enabled)	\
+	".if "__stringify(cfg_enabled)" == 1\n"				\
+	"661:\n\t"							\
+	oldinstr "\n"							\
+	"662:\n"							\
+	".pushsection .altinstructions,\"a\"\n"				\
+	ALTINSTR_ENTRY(feature)						\
+	".popsection\n"							\
+	".subsection 1\n"						\
+	"663:\n\t"							\
+	newinstr "\n"							\
+	"664:\n\t"							\
+	".previous\n\t"							\
+	".org	. - (664b-663b) + (662b-661b)\n\t"			\
+	".org	. - (662b-661b) + (664b-663b)\n"			\
+	".endif\n"
+
+#define __ALTERNATIVE_CFG_CB(oldinstr, feature, cfg_enabled, cb)	\
+	".if "__stringify(cfg_enabled)" == 1\n"				\
+	"661:\n\t"							\
+	oldinstr "\n"							\
+	"662:\n"							\
+	".pushsection .altinstructions,\"a\"\n"				\
+	ALTINSTR_ENTRY_CB(feature, cb)					\
+	".popsection\n"							\
+	"663:\n\t"							\
+	"664:\n\t"							\
+	".endif\n"
+
+#define _ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg, ...)	\
+	__ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg))
+
+#define ALTERNATIVE_CB(oldinstr, cb) \
+	__ALTERNATIVE_CFG_CB(oldinstr, ARM64_CB_PATCH, 1, cb)
+#else
+
+#include <asm/assembler.h>
+
+.macro altinstruction_entry orig_offset alt_offset feature orig_len alt_len
+	.word \orig_offset - .
+	.word \alt_offset - .
+	.hword \feature
+	.byte \orig_len
+	.byte \alt_len
+.endm
+
+.macro alternative_insn insn1, insn2, cap, enable = 1
+	.if \enable
+661:	\insn1
+662:	.pushsection .altinstructions, "a"
+	altinstruction_entry 661b, 663f, \cap, 662b-661b, 664f-663f
+	.popsection
+	.subsection 1
+663:	\insn2
+664:	.previous
+	.org	. - (664b-663b) + (662b-661b)
+	.org	. - (662b-661b) + (664b-663b)
+	.endif
+.endm
+
+/*
+ * Alternative sequences
+ *
+ * The code for the case where the capability is not present will be
+ * assembled and linked as normal. There are no restrictions on this
+ * code.
+ *
+ * The code for the case where the capability is present will be
+ * assembled into a special section to be used for dynamic patching.
+ * Code for that case must:
+ *
+ * 1. Be exactly the same length (in bytes) as the default code
+ *    sequence.
+ *
+ * 2. Not contain a branch target that is used outside of the
+ *    alternative sequence it is defined in (branches into an
+ *    alternative sequence are not fixed up).
+ */
+
+/*
+ * Begin an alternative code sequence.
+ */
+.macro alternative_if_not cap
+	.set .Lasm_alt_mode, 0
+	.pushsection .altinstructions, "a"
+	altinstruction_entry 661f, 663f, \cap, 662f-661f, 664f-663f
+	.popsection
+661:
+.endm
+
+.macro alternative_if cap
+	.set .Lasm_alt_mode, 1
+	.pushsection .altinstructions, "a"
+	altinstruction_entry 663f, 661f, \cap, 664f-663f, 662f-661f
+	.popsection
+	.subsection 1
+	.align 2	/* So GAS knows label 661 is suitably aligned */
+661:
+.endm
+
+.macro alternative_cb cb
+	.set .Lasm_alt_mode, 0
+	.pushsection .altinstructions, "a"
+	altinstruction_entry 661f, \cb, ARM64_CB_PATCH, 662f-661f, 0
+	.popsection
+661:
+.endm
+
+/*
+ * Provide the other half of the alternative code sequence.
+ */
+.macro alternative_else
+662:
+	.if .Lasm_alt_mode==0
+	.subsection 1
+	.else
+	.previous
+	.endif
+663:
+.endm
+
+/*
+ * Complete an alternative code sequence.
+ */
+.macro alternative_endif
+664:
+	.if .Lasm_alt_mode==0
+	.previous
+	.endif
+	.org	. - (664b-663b) + (662b-661b)
+	.org	. - (662b-661b) + (664b-663b)
+.endm
+
+/*
+ * Callback-based alternative epilogue
+ */
+.macro alternative_cb_end
+662:
+.endm
+
+/*
+ * Provides a trivial alternative or default sequence consisting solely
+ * of NOPs. The number of NOPs is chosen automatically to match the
+ * previous case.
+ */
+.macro alternative_else_nop_endif
+alternative_else
+	nops	(662b-661b) / AARCH64_INSN_SIZE
+alternative_endif
+.endm
+
+#define _ALTERNATIVE_CFG(insn1, insn2, cap, cfg, ...)	\
+	alternative_insn insn1, insn2, cap, IS_ENABLED(cfg)
+
+.macro user_alt, label, oldinstr, newinstr, cond
+9999:	alternative_insn "\oldinstr", "\newinstr", \cond
+	_asm_extable 9999b, \label
+.endm
+
+/*
+ * Generate the assembly for UAO alternatives with exception table entries.
+ * This is complicated as there is no post-increment or pair versions of the
+ * unprivileged instructions, and USER() only works for single instructions.
+ */
+#ifdef CONFIG_ARM64_UAO
+	.macro uao_ldp l, reg1, reg2, addr, post_inc
+		alternative_if_not ARM64_HAS_UAO
+8888:			ldp	\reg1, \reg2, [\addr], \post_inc;
+8889:			nop;
+			nop;
+		alternative_else
+			ldtr	\reg1, [\addr];
+			ldtr	\reg2, [\addr, #8];
+			add	\addr, \addr, \post_inc;
+		alternative_endif
+
+		_asm_extable	8888b,\l;
+		_asm_extable	8889b,\l;
+	.endm
+
+	.macro uao_stp l, reg1, reg2, addr, post_inc
+		alternative_if_not ARM64_HAS_UAO
+8888:			stp	\reg1, \reg2, [\addr], \post_inc;
+8889:			nop;
+			nop;
+		alternative_else
+			sttr	\reg1, [\addr];
+			sttr	\reg2, [\addr, #8];
+			add	\addr, \addr, \post_inc;
+		alternative_endif
+
+		_asm_extable	8888b,\l;
+		_asm_extable	8889b,\l;
+	.endm
+
+	.macro uao_user_alternative l, inst, alt_inst, reg, addr, post_inc
+		alternative_if_not ARM64_HAS_UAO
+8888:			\inst	\reg, [\addr], \post_inc;
+			nop;
+		alternative_else
+			\alt_inst	\reg, [\addr];
+			add		\addr, \addr, \post_inc;
+		alternative_endif
+
+		_asm_extable	8888b,\l;
+	.endm
+#else
+	.macro uao_ldp l, reg1, reg2, addr, post_inc
+		USER(\l, ldp \reg1, \reg2, [\addr], \post_inc)
+	.endm
+	.macro uao_stp l, reg1, reg2, addr, post_inc
+		USER(\l, stp \reg1, \reg2, [\addr], \post_inc)
+	.endm
+	.macro uao_user_alternative l, inst, alt_inst, reg, addr, post_inc
+		USER(\l, \inst \reg, [\addr], \post_inc)
+	.endm
+#endif
+
+#endif  /*  __ASSEMBLY__  */
+
+/*
+ * Usage: asm(ALTERNATIVE(oldinstr, newinstr, feature));
+ *
+ * Usage: asm(ALTERNATIVE(oldinstr, newinstr, feature, CONFIG_FOO));
+ * N.B. If CONFIG_FOO is specified, but not selected, the whole block
+ *      will be omitted, including oldinstr.
+ */
+#define ALTERNATIVE(oldinstr, newinstr, ...)   \
+	_ALTERNATIVE_CFG(oldinstr, newinstr, __VA_ARGS__, 1)
+
+#endif /* __ASM_ALTERNATIVE_MACROS_H */
diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index 12f0eb56a1cc..a38b92e11811 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -2,17 +2,13 @@
 #ifndef __ASM_ALTERNATIVE_H
 #define __ASM_ALTERNATIVE_H
 
-#include <asm/cpucaps.h>
-#include <asm/insn.h>
-
-#define ARM64_CB_PATCH ARM64_NCAPS
+#include <asm/alternative-macros.h>
 
 #ifndef __ASSEMBLY__
 
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/stddef.h>
-#include <linux/stringify.h>
 
 struct alt_instr {
 	s32 orig_offset;	/* offset to original instruction */
@@ -35,264 +31,5 @@ void apply_alternatives_module(void *start, size_t length);
 static inline void apply_alternatives_module(void *start, size_t length) { }
 #endif
 
-#define ALTINSTR_ENTRY(feature)					              \
-	" .word 661b - .\n"				/* label           */ \
-	" .word 663f - .\n"				/* new instruction */ \
-	" .hword " __stringify(feature) "\n"		/* feature bit     */ \
-	" .byte 662b-661b\n"				/* source len      */ \
-	" .byte 664f-663f\n"				/* replacement len */
-
-#define ALTINSTR_ENTRY_CB(feature, cb)					      \
-	" .word 661b - .\n"				/* label           */ \
-	" .word " __stringify(cb) "- .\n"		/* callback */	      \
-	" .hword " __stringify(feature) "\n"		/* feature bit     */ \
-	" .byte 662b-661b\n"				/* source len      */ \
-	" .byte 664f-663f\n"				/* replacement len */
-
-/*
- * alternative assembly primitive:
- *
- * If any of these .org directive fail, it means that insn1 and insn2
- * don't have the same length. This used to be written as
- *
- * .if ((664b-663b) != (662b-661b))
- * 	.error "Alternatives instruction length mismatch"
- * .endif
- *
- * but most assemblers die if insn1 or insn2 have a .inst. This should
- * be fixed in a binutils release posterior to 2.25.51.0.2 (anything
- * containing commit 4e4d08cf7399b606 or c1baaddf8861).
- *
- * Alternatives with callbacks do not generate replacement instructions.
- */
-#define __ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg_enabled)	\
-	".if "__stringify(cfg_enabled)" == 1\n"				\
-	"661:\n\t"							\
-	oldinstr "\n"							\
-	"662:\n"							\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY(feature)						\
-	".popsection\n"							\
-	".subsection 1\n"						\
-	"663:\n\t"							\
-	newinstr "\n"							\
-	"664:\n\t"							\
-	".previous\n\t"							\
-	".org	. - (664b-663b) + (662b-661b)\n\t"			\
-	".org	. - (662b-661b) + (664b-663b)\n"			\
-	".endif\n"
-
-#define __ALTERNATIVE_CFG_CB(oldinstr, feature, cfg_enabled, cb)	\
-	".if "__stringify(cfg_enabled)" == 1\n"				\
-	"661:\n\t"							\
-	oldinstr "\n"							\
-	"662:\n"							\
-	".pushsection .altinstructions,\"a\"\n"				\
-	ALTINSTR_ENTRY_CB(feature, cb)					\
-	".popsection\n"							\
-	"663:\n\t"							\
-	"664:\n\t"							\
-	".endif\n"
-
-#define _ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg, ...)	\
-	__ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg))
-
-#define ALTERNATIVE_CB(oldinstr, cb) \
-	__ALTERNATIVE_CFG_CB(oldinstr, ARM64_CB_PATCH, 1, cb)
-#else
-
-#include <asm/assembler.h>
-
-.macro altinstruction_entry orig_offset alt_offset feature orig_len alt_len
-	.word \orig_offset - .
-	.word \alt_offset - .
-	.hword \feature
-	.byte \orig_len
-	.byte \alt_len
-.endm
-
-.macro alternative_insn insn1, insn2, cap, enable = 1
-	.if \enable
-661:	\insn1
-662:	.pushsection .altinstructions, "a"
-	altinstruction_entry 661b, 663f, \cap, 662b-661b, 664f-663f
-	.popsection
-	.subsection 1
-663:	\insn2
-664:	.previous
-	.org	. - (664b-663b) + (662b-661b)
-	.org	. - (662b-661b) + (664b-663b)
-	.endif
-.endm
-
-/*
- * Alternative sequences
- *
- * The code for the case where the capability is not present will be
- * assembled and linked as normal. There are no restrictions on this
- * code.
- *
- * The code for the case where the capability is present will be
- * assembled into a special section to be used for dynamic patching.
- * Code for that case must:
- *
- * 1. Be exactly the same length (in bytes) as the default code
- *    sequence.
- *
- * 2. Not contain a branch target that is used outside of the
- *    alternative sequence it is defined in (branches into an
- *    alternative sequence are not fixed up).
- */
-
-/*
- * Begin an alternative code sequence.
- */
-.macro alternative_if_not cap
-	.set .Lasm_alt_mode, 0
-	.pushsection .altinstructions, "a"
-	altinstruction_entry 661f, 663f, \cap, 662f-661f, 664f-663f
-	.popsection
-661:
-.endm
-
-.macro alternative_if cap
-	.set .Lasm_alt_mode, 1
-	.pushsection .altinstructions, "a"
-	altinstruction_entry 663f, 661f, \cap, 664f-663f, 662f-661f
-	.popsection
-	.subsection 1
-	.align 2	/* So GAS knows label 661 is suitably aligned */
-661:
-.endm
-
-.macro alternative_cb cb
-	.set .Lasm_alt_mode, 0
-	.pushsection .altinstructions, "a"
-	altinstruction_entry 661f, \cb, ARM64_CB_PATCH, 662f-661f, 0
-	.popsection
-661:
-.endm
-
-/*
- * Provide the other half of the alternative code sequence.
- */
-.macro alternative_else
-662:
-	.if .Lasm_alt_mode==0
-	.subsection 1
-	.else
-	.previous
-	.endif
-663:
-.endm
-
-/*
- * Complete an alternative code sequence.
- */
-.macro alternative_endif
-664:
-	.if .Lasm_alt_mode==0
-	.previous
-	.endif
-	.org	. - (664b-663b) + (662b-661b)
-	.org	. - (662b-661b) + (664b-663b)
-.endm
-
-/*
- * Callback-based alternative epilogue
- */
-.macro alternative_cb_end
-662:
-.endm
-
-/*
- * Provides a trivial alternative or default sequence consisting solely
- * of NOPs. The number of NOPs is chosen automatically to match the
- * previous case.
- */
-.macro alternative_else_nop_endif
-alternative_else
-	nops	(662b-661b) / AARCH64_INSN_SIZE
-alternative_endif
-.endm
-
-#define _ALTERNATIVE_CFG(insn1, insn2, cap, cfg, ...)	\
-	alternative_insn insn1, insn2, cap, IS_ENABLED(cfg)
-
-.macro user_alt, label, oldinstr, newinstr, cond
-9999:	alternative_insn "\oldinstr", "\newinstr", \cond
-	_asm_extable 9999b, \label
-.endm
-
-/*
- * Generate the assembly for UAO alternatives with exception table entries.
- * This is complicated as there is no post-increment or pair versions of the
- * unprivileged instructions, and USER() only works for single instructions.
- */
-#ifdef CONFIG_ARM64_UAO
-	.macro uao_ldp l, reg1, reg2, addr, post_inc
-		alternative_if_not ARM64_HAS_UAO
-8888:			ldp	\reg1, \reg2, [\addr], \post_inc;
-8889:			nop;
-			nop;
-		alternative_else
-			ldtr	\reg1, [\addr];
-			ldtr	\reg2, [\addr, #8];
-			add	\addr, \addr, \post_inc;
-		alternative_endif
-
-		_asm_extable	8888b,\l;
-		_asm_extable	8889b,\l;
-	.endm
-
-	.macro uao_stp l, reg1, reg2, addr, post_inc
-		alternative_if_not ARM64_HAS_UAO
-8888:			stp	\reg1, \reg2, [\addr], \post_inc;
-8889:			nop;
-			nop;
-		alternative_else
-			sttr	\reg1, [\addr];
-			sttr	\reg2, [\addr, #8];
-			add	\addr, \addr, \post_inc;
-		alternative_endif
-
-		_asm_extable	8888b,\l;
-		_asm_extable	8889b,\l;
-	.endm
-
-	.macro uao_user_alternative l, inst, alt_inst, reg, addr, post_inc
-		alternative_if_not ARM64_HAS_UAO
-8888:			\inst	\reg, [\addr], \post_inc;
-			nop;
-		alternative_else
-			\alt_inst	\reg, [\addr];
-			add		\addr, \addr, \post_inc;
-		alternative_endif
-
-		_asm_extable	8888b,\l;
-	.endm
-#else
-	.macro uao_ldp l, reg1, reg2, addr, post_inc
-		USER(\l, ldp \reg1, \reg2, [\addr], \post_inc)
-	.endm
-	.macro uao_stp l, reg1, reg2, addr, post_inc
-		USER(\l, stp \reg1, \reg2, [\addr], \post_inc)
-	.endm
-	.macro uao_user_alternative l, inst, alt_inst, reg, addr, post_inc
-		USER(\l, \inst \reg, [\addr], \post_inc)
-	.endm
-#endif
-
-#endif  /*  __ASSEMBLY__  */
-
-/*
- * Usage: asm(ALTERNATIVE(oldinstr, newinstr, feature));
- *
- * Usage: asm(ALTERNATIVE(oldinstr, newinstr, feature, CONFIG_FOO));
- * N.B. If CONFIG_FOO is specified, but not selected, the whole block
- *      will be omitted, including oldinstr.
- */
-#define ALTERNATIVE(oldinstr, newinstr, ...)   \
-	_ALTERNATIVE_CFG(oldinstr, newinstr, __VA_ARGS__, 1)
-
+#endif /* __ASSEMBLY__ */
 #endif /* __ASM_ALTERNATIVE_H */
diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
index 0bc46149e491..01da70ba2fb9 100644
--- a/arch/arm64/include/asm/insn.h
+++ b/arch/arm64/include/asm/insn.h
@@ -10,8 +10,7 @@
 #include <linux/build_bug.h>
 #include <linux/types.h>
 
-/* A64 instructions are always 32 bits. */
-#define	AARCH64_INSN_SIZE		4
+#include <asm/alternative.h>
 
 #ifndef __ASSEMBLY__
 /*
-- 
2.27.0.383.g050319c2ae-goog

