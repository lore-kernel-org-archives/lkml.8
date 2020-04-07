Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA19C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1066B2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586274237;
	bh=XSedYw7PESHj9iMBtW6ppmhFXcyc6FiIvmL6ObiBSeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uEdf3PSI9hGsKGvMiYZrhzE0Gp8uP2FmQX5HvXzaY+kZmqIupxXA6gcFK0EZojLRC
	 /M7cDcaDrLwXkFWx23EqwPwYFbrq/SkW1iJ/8WIc4IUP9e16iVDKWYcidzpDeRpzi5
	 ShYDpXapgHfnLHDj0pM9sVZoymbinpF5U86z5WeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgDGPn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgDGPnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:43:55 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F31F920730;
        Tue,  7 Apr 2020 15:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586274234;
        bh=XSedYw7PESHj9iMBtW6ppmhFXcyc6FiIvmL6ObiBSeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LP+9Cm4V6Upvvu8pyyE3GeXrrcpr2GUcmV0BXrYf+xfY4W6dWNucNX5Ed4fvH5OFp
         v0glgN62ryQ3Z+Xey07QAsRIvFCdERUKtm86eDVNhRTDhUQZQsb7U1TOvTz6rRmUdF
         RCzWmWK40iW9Y4EFWEqVpc3asHApTjmwT++uwucA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Jann Horn <jannh@google.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH] x86: insn: Add insn_is_fpu()
Date:   Wed,  8 Apr 2020 00:43:48 +0900
Message-Id: <158627422834.32395.5223964021388095786.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200408004111.3dd597f2a7c6172b4c71a9ba@kernel.org>
References: <20200408004111.3dd597f2a7c6172b4c71a9ba@kernel.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add insn_is_fpu(insn) which tells that the insn is
whether touch the MMX/XMM/YMM register or the instruction
of FP coprocessor.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes:
 - Fix non-argument mmx/sse opcode pattern
 - Fix to add INAT_FPUIFVEX if the first opcode isn't FPU but 2nd is FPU
   instead of mnemonic pattern.
---
 arch/x86/include/asm/inat.h                |    7 ++++
 arch/x86/include/asm/insn.h                |   12 +++++++
 arch/x86/lib/x86-opcode-map.txt            |   25 ++++++++------
 arch/x86/tools/gen-insn-attr-x86.awk       |   51 ++++++++++++++++++++++++----
 tools/arch/x86/include/asm/inat.h          |    7 ++++
 tools/arch/x86/include/asm/insn.h          |   12 +++++++
 tools/arch/x86/lib/x86-opcode-map.txt      |   25 ++++++++------
 tools/arch/x86/tools/gen-insn-attr-x86.awk |   51 ++++++++++++++++++++++++----
 8 files changed, 154 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/inat.h b/arch/x86/include/asm/inat.h
index 4cf2ad521f65..ffce45178c08 100644
--- a/arch/x86/include/asm/inat.h
+++ b/arch/x86/include/asm/inat.h
@@ -77,6 +77,8 @@
 #define INAT_VEXOK	(1 << (INAT_FLAG_OFFS + 5))
 #define INAT_VEXONLY	(1 << (INAT_FLAG_OFFS + 6))
 #define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
+#define INAT_FPU	(1 << (INAT_FLAG_OFFS + 8))
+#define INAT_FPUIFVEX	(1 << (INAT_FLAG_OFFS + 9))
 /* Attribute making macros for attribute tables */
 #define INAT_MAKE_PREFIX(pfx)	(pfx << INAT_PFX_OFFS)
 #define INAT_MAKE_ESCAPE(esc)	(esc << INAT_ESC_OFFS)
@@ -227,4 +229,9 @@ static inline int inat_must_evex(insn_attr_t attr)
 {
 	return attr & INAT_EVEXONLY;
 }
+
+static inline int inat_is_fpu(insn_attr_t attr)
+{
+	return attr & INAT_FPU;
+}
 #endif
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 5c1ae3eff9d4..1752c54d2103 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -129,6 +129,18 @@ static inline int insn_is_evex(struct insn *insn)
 	return (insn->vex_prefix.nbytes == 4);
 }
 
+static inline int insn_is_fpu(struct insn *insn)
+{
+	if (!insn->opcode.got)
+		insn_get_opcode(insn);
+	if (inat_is_fpu(insn->attr)) {
+		if (insn->attr & INAT_FPUIFVEX)
+			return insn_is_avx(insn);
+		return 1;
+	}
+	return 0;
+}
+
 static inline int insn_has_emulate_prefix(struct insn *insn)
 {
 	return !!insn->emulate_prefix_size;
diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index ec31f5b60323..5470d378731a 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -269,14 +269,17 @@ d4: AAM Ib (i64)
 d5: AAD Ib (i64)
 d6:
 d7: XLAT/XLATB
-d8: ESC
-d9: ESC
-da: ESC
-db: ESC
-dc: ESC
-dd: ESC
-de: ESC
-df: ESC
+# Intel SDM Appendix A Opcode Map shows these opcode are ESC (Escape to
+# coprocessor instruction set). Since the coprocessor means only x87 FPU
+# now, make it "x87" instead of "ESC".
+d8: x87
+d9: x87
+da: x87
+db: x87
+dc: x87
+dd: x87
+de: x87
+df: x87
 # 0xe0 - 0xef
 # Note: "forced64" is Intel CPU behavior: they ignore 0x66 prefix
 # in 64-bit mode. AMD CPUs accept 0x66 prefix, it causes RIP truncation
@@ -1037,9 +1040,9 @@ EndTable
 
 GrpTable: Grp15
 0: fxsave | RDFSBASE Ry (F3),(11B)
-1: fxstor | RDGSBASE Ry (F3),(11B)
-2: vldmxcsr Md (v1) | WRFSBASE Ry (F3),(11B)
-3: vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
+1: fxrstor | RDGSBASE Ry (F3),(11B)
+2: ldmxcsr | vldmxcsr Md (v1) | WRFSBASE Ry (F3),(11B)
+3: stmxcsr | vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
 4: XSAVE | ptwrite Ey (F3),(11B)
 5: XRSTOR | lfence (11B) | INCSSPD/Q Ry (F3),(11B)
 6: XSAVEOPT | clwb (66) | mfence (11B) | TPAUSE Rd (66),(11B) | UMONITOR Rv (F3),(11B) | UMWAIT Rd (F2),(11B) | CLRSSBSY Mq (F3)
diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
index a42015b305f4..d74d9e605723 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -65,7 +65,10 @@ BEGIN {
 	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr = "\\([df]64\\)"
 	rex_expr = "^REX(\\.[XRWB]+)*"
-	fpu_expr = "^ESC" # TODO
+
+	mmxreg_expr = "^[HLNPQUVW][a-z]+" # MMX/SSE register operands
+	mmx_expr = "^(emms|fxsave|fxrstor|ldmxcsr|stmxcsr)" # MMX/SSE nmemonics lacking operands
+	fpu_expr = "^x87"
 
 	lprefix1_expr = "\\((66|!F3)\\)"
 	lprefix2_expr = "\\(F3\\)"
@@ -236,10 +239,11 @@ function add_flags(old,new) {
 }
 
 # convert operands to flags.
-function convert_operands(count,opnd,       i,j,imm,mod)
+function convert_operands(count,opnd,       i,j,imm,mod,mmx)
 {
 	imm = null
 	mod = null
+	mmx = null
 	for (j = 1; j <= count; j++) {
 		i = opnd[j]
 		if (match(i, imm_expr) == 1) {
@@ -253,7 +257,12 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 				imm = imm_flag[i]
 		} else if (match(i, modrm_expr))
 			mod = "INAT_MODRM"
+		if (match(i, mmxreg_expr) == 1) {
+			mmx = "INAT_FPU"
+		}
 	}
+	if (mmx)
+		imm = add_flags(imm, mmx)
 	return add_flags(imm, mod)
 }
 
@@ -283,6 +292,10 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 	variant = null
 	# converts
 	i = 2
+	lpfpu[0] = 0
+	lpfpu[1] = 0
+	lpfpu[2] = 0
+	lpfpu[3] = 0
 	while (i <= NF) {
 		opcode = $(i++)
 		delete opnds
@@ -294,6 +307,7 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 			opnd = $i
 			count = split($(i++), opnds, ",")
 			flags = convert_operands(count, opnds)
+
 		}
 		if (match($i, ext_expr))
 			ext = $(i++)
@@ -318,9 +332,9 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 		if (match(opcode, rex_expr))
 			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
 
-		# check coprocessor escape : TODO
-		if (match(opcode, fpu_expr))
-			flags = add_flags(flags, "INAT_MODRM")
+		# check coprocessor escape
+		if (match(opcode, fpu_expr) || match(opcode, mmx_expr))
+			flags = add_flags(flags, "INAT_MODRM | INAT_FPU")
 
 		# check VEX codes
 		if (match(ext, evexonly_expr))
@@ -336,22 +350,45 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 				semantic_error("Unknown prefix: " opcode)
 			flags = add_flags(flags, "INAT_MAKE_PREFIX(" prefix_num[opcode] ")")
 		}
-		if (length(flags) == 0)
-			continue
+
 		# check if last prefix
 		if (match(ext, lprefix1_expr)) {
+			if (lpfpu[1] == 0 && flags !~ "INAT_FPU")
+				lpfpu[1] = 1
+			else if (lpfpu[1] != 0 && flags ~ "INAT_FPU")
+				flags = add_flags(flags, "INAT_FPUIFVEX")
+			if (length(flags) == 0)
+				continue;
 			lptable1[idx] = add_flags(lptable1[idx],flags)
 			variant = "INAT_VARIANT"
 		}
 		if (match(ext, lprefix2_expr)) {
+			if (lpfpu[2] == 0 && flags !~ "INAT_FPU")
+				lpfpu[2] = 1
+			else if (lpfpu[2] != 0 && flags ~ "INAT_FPU")
+				flags = add_flags(flags, "INAT_FPUIFVEX")
+			if (length(flags) == 0)
+				continue;
 			lptable2[idx] = add_flags(lptable2[idx],flags)
 			variant = "INAT_VARIANT"
 		}
 		if (match(ext, lprefix3_expr)) {
+			if (lpfpu[3] == 0 && flags !~ "INAT_FPU")
+				lpfpu[3] = 1
+			else if (lpfpu[3] != 0 && flags ~ "INAT_FPU")
+				flags = add_flags(flags, "INAT_FPUIFVEX")
+			if (length(flags) == 0)
+				continue;
 			lptable3[idx] = add_flags(lptable3[idx],flags)
 			variant = "INAT_VARIANT"
 		}
 		if (!match(ext, lprefix_expr)){
+			if (lpfpu[0] == 0 && flags !~ "INAT_FPU")
+				lpfpu[0] = 1
+			else if (lpfpu[0] != 0 && flags ~ "INAT_FPU")
+				flags = add_flags(flags, "INAT_FPUIFVEX")
+			if (length(flags) == 0)
+				continue;
 			table[idx] = add_flags(table[idx],flags)
 		}
 	}
diff --git a/tools/arch/x86/include/asm/inat.h b/tools/arch/x86/include/asm/inat.h
index 877827b7c2c3..2e6a05290efd 100644
--- a/tools/arch/x86/include/asm/inat.h
+++ b/tools/arch/x86/include/asm/inat.h
@@ -77,6 +77,8 @@
 #define INAT_VEXOK	(1 << (INAT_FLAG_OFFS + 5))
 #define INAT_VEXONLY	(1 << (INAT_FLAG_OFFS + 6))
 #define INAT_EVEXONLY	(1 << (INAT_FLAG_OFFS + 7))
+#define INAT_FPU	(1 << (INAT_FLAG_OFFS + 8))
+#define INAT_FPUIFVEX	(1 << (INAT_FLAG_OFFS + 9))
 /* Attribute making macros for attribute tables */
 #define INAT_MAKE_PREFIX(pfx)	(pfx << INAT_PFX_OFFS)
 #define INAT_MAKE_ESCAPE(esc)	(esc << INAT_ESC_OFFS)
@@ -227,4 +229,9 @@ static inline int inat_must_evex(insn_attr_t attr)
 {
 	return attr & INAT_EVEXONLY;
 }
+
+static inline int inat_is_fpu(insn_attr_t attr)
+{
+	return attr & INAT_FPU;
+}
 #endif
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 568854b14d0a..d9f6bd9059c1 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -129,6 +129,18 @@ static inline int insn_is_evex(struct insn *insn)
 	return (insn->vex_prefix.nbytes == 4);
 }
 
+static inline int insn_is_fpu(struct insn *insn)
+{
+	if (!insn->opcode.got)
+		insn_get_opcode(insn);
+	if (inat_is_fpu(insn->attr)) {
+		if (insn->attr & INAT_FPUIFVEX)
+			return insn_is_avx(insn);
+		return 1;
+	}
+	return 0;
+}
+
 static inline int insn_has_emulate_prefix(struct insn *insn)
 {
 	return !!insn->emulate_prefix_size;
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index ec31f5b60323..5470d378731a 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -269,14 +269,17 @@ d4: AAM Ib (i64)
 d5: AAD Ib (i64)
 d6:
 d7: XLAT/XLATB
-d8: ESC
-d9: ESC
-da: ESC
-db: ESC
-dc: ESC
-dd: ESC
-de: ESC
-df: ESC
+# Intel SDM Appendix A Opcode Map shows these opcode are ESC (Escape to
+# coprocessor instruction set). Since the coprocessor means only x87 FPU
+# now, make it "x87" instead of "ESC".
+d8: x87
+d9: x87
+da: x87
+db: x87
+dc: x87
+dd: x87
+de: x87
+df: x87
 # 0xe0 - 0xef
 # Note: "forced64" is Intel CPU behavior: they ignore 0x66 prefix
 # in 64-bit mode. AMD CPUs accept 0x66 prefix, it causes RIP truncation
@@ -1037,9 +1040,9 @@ EndTable
 
 GrpTable: Grp15
 0: fxsave | RDFSBASE Ry (F3),(11B)
-1: fxstor | RDGSBASE Ry (F3),(11B)
-2: vldmxcsr Md (v1) | WRFSBASE Ry (F3),(11B)
-3: vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
+1: fxrstor | RDGSBASE Ry (F3),(11B)
+2: ldmxcsr | vldmxcsr Md (v1) | WRFSBASE Ry (F3),(11B)
+3: stmxcsr | vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
 4: XSAVE | ptwrite Ey (F3),(11B)
 5: XRSTOR | lfence (11B) | INCSSPD/Q Ry (F3),(11B)
 6: XSAVEOPT | clwb (66) | mfence (11B) | TPAUSE Rd (66),(11B) | UMONITOR Rv (F3),(11B) | UMWAIT Rd (F2),(11B) | CLRSSBSY Mq (F3)
diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
index a42015b305f4..d74d9e605723 100644
--- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
@@ -65,7 +65,10 @@ BEGIN {
 	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr = "\\([df]64\\)"
 	rex_expr = "^REX(\\.[XRWB]+)*"
-	fpu_expr = "^ESC" # TODO
+
+	mmxreg_expr = "^[HLNPQUVW][a-z]+" # MMX/SSE register operands
+	mmx_expr = "^(emms|fxsave|fxrstor|ldmxcsr|stmxcsr)" # MMX/SSE nmemonics lacking operands
+	fpu_expr = "^x87"
 
 	lprefix1_expr = "\\((66|!F3)\\)"
 	lprefix2_expr = "\\(F3\\)"
@@ -236,10 +239,11 @@ function add_flags(old,new) {
 }
 
 # convert operands to flags.
-function convert_operands(count,opnd,       i,j,imm,mod)
+function convert_operands(count,opnd,       i,j,imm,mod,mmx)
 {
 	imm = null
 	mod = null
+	mmx = null
 	for (j = 1; j <= count; j++) {
 		i = opnd[j]
 		if (match(i, imm_expr) == 1) {
@@ -253,7 +257,12 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 				imm = imm_flag[i]
 		} else if (match(i, modrm_expr))
 			mod = "INAT_MODRM"
+		if (match(i, mmxreg_expr) == 1) {
+			mmx = "INAT_FPU"
+		}
 	}
+	if (mmx)
+		imm = add_flags(imm, mmx)
 	return add_flags(imm, mod)
 }
 
@@ -283,6 +292,10 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 	variant = null
 	# converts
 	i = 2
+	lpfpu[0] = 0
+	lpfpu[1] = 0
+	lpfpu[2] = 0
+	lpfpu[3] = 0
 	while (i <= NF) {
 		opcode = $(i++)
 		delete opnds
@@ -294,6 +307,7 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 			opnd = $i
 			count = split($(i++), opnds, ",")
 			flags = convert_operands(count, opnds)
+
 		}
 		if (match($i, ext_expr))
 			ext = $(i++)
@@ -318,9 +332,9 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 		if (match(opcode, rex_expr))
 			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
 
-		# check coprocessor escape : TODO
-		if (match(opcode, fpu_expr))
-			flags = add_flags(flags, "INAT_MODRM")
+		# check coprocessor escape
+		if (match(opcode, fpu_expr) || match(opcode, mmx_expr))
+			flags = add_flags(flags, "INAT_MODRM | INAT_FPU")
 
 		# check VEX codes
 		if (match(ext, evexonly_expr))
@@ -336,22 +350,45 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 				semantic_error("Unknown prefix: " opcode)
 			flags = add_flags(flags, "INAT_MAKE_PREFIX(" prefix_num[opcode] ")")
 		}
-		if (length(flags) == 0)
-			continue
+
 		# check if last prefix
 		if (match(ext, lprefix1_expr)) {
+			if (lpfpu[1] == 0 && flags !~ "INAT_FPU")
+				lpfpu[1] = 1
+			else if (lpfpu[1] != 0 && flags ~ "INAT_FPU")
+				flags = add_flags(flags, "INAT_FPUIFVEX")
+			if (length(flags) == 0)
+				continue;
 			lptable1[idx] = add_flags(lptable1[idx],flags)
 			variant = "INAT_VARIANT"
 		}
 		if (match(ext, lprefix2_expr)) {
+			if (lpfpu[2] == 0 && flags !~ "INAT_FPU")
+				lpfpu[2] = 1
+			else if (lpfpu[2] != 0 && flags ~ "INAT_FPU")
+				flags = add_flags(flags, "INAT_FPUIFVEX")
+			if (length(flags) == 0)
+				continue;
 			lptable2[idx] = add_flags(lptable2[idx],flags)
 			variant = "INAT_VARIANT"
 		}
 		if (match(ext, lprefix3_expr)) {
+			if (lpfpu[3] == 0 && flags !~ "INAT_FPU")
+				lpfpu[3] = 1
+			else if (lpfpu[3] != 0 && flags ~ "INAT_FPU")
+				flags = add_flags(flags, "INAT_FPUIFVEX")
+			if (length(flags) == 0)
+				continue;
 			lptable3[idx] = add_flags(lptable3[idx],flags)
 			variant = "INAT_VARIANT"
 		}
 		if (!match(ext, lprefix_expr)){
+			if (lpfpu[0] == 0 && flags !~ "INAT_FPU")
+				lpfpu[0] = 1
+			else if (lpfpu[0] != 0 && flags ~ "INAT_FPU")
+				flags = add_flags(flags, "INAT_FPUIFVEX")
+			if (length(flags) == 0)
+				continue;
 			table[idx] = add_flags(table[idx],flags)
 		}
 	}

