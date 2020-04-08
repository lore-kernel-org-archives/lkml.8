Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1C3C2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A8D20730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586362160;
	bh=1QikKK7f/nBK09T2WDiHVYR6Txj2QstjmPb0A/WaPEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SA8az6y64P39G+0Scrl4Sgg90fJhHiDGUCYhl3aezU5u6cnASi4VkV0XBK7U/N0lj
	 AwqgDnUR8Dgbnu8e/kfukHoQr0RcANt2+ghpE4qcyUYjFEJm9kau5DPTtZMUOF8DKt
	 M5FMfYQ7bBcJiHOilkhNnLL5LH6MSpe/7quStEK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgDHQJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbgDHQJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:09:19 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A4CC206F5;
        Wed,  8 Apr 2020 16:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586362157;
        bh=1QikKK7f/nBK09T2WDiHVYR6Txj2QstjmPb0A/WaPEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDJsAhKFgzfu7ivdKiRDoEiSxK3bxiYBYYg3mZi2k8OgL6U+7LHhWuggt/y1wyapH
         ljpFj63e7ACOSqsY8MBiVKemTjzeQvlfoZ8qo8ByMr6P08/kJkuxrWJfAtzglU6kvW
         l6tFKFa7vUN9CBfBliBA/WrR7wFFRjr/rXB08MqE=
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
Subject: [PATCH v2] x86: insn: Add insn_is_fpu()
Date:   Thu,  9 Apr 2020 01:09:11 +0900
Message-Id: <158636215075.6641.10786116450376715657.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407155449.GF20730@hirez.programming.kicks-ass.net>
References: <20200407155449.GF20730@hirez.programming.kicks-ass.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add insn_is_fpu(insn) which tells that the insn is
whether touch the FPU/SSE/MMX register or the instruction
of FP coprocessor.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
 - Introduce FPU superscript.
 - Fix to add INAT_FPUIFVEX for variant if the first opcode has no
   last prefix superscript.
---
 tools/arch/x86/include/asm/inat.h          |    7 ++++
 tools/arch/x86/include/asm/insn.h          |   12 ++++++
 tools/arch/x86/lib/x86-opcode-map.txt      |   32 ++++++++++------
 tools/arch/x86/tools/gen-insn-attr-x86.awk |   56 ++++++++++++++++++++++++----
 4 files changed, 86 insertions(+), 21 deletions(-)

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
index ec31f5b60323..3aae11931a0a 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -33,6 +33,10 @@
 #  - (F2): the last prefix is 0xF2
 #  - (!F3) : the last prefix is not 0xF3 (including non-last prefix case)
 #  - (66&F2): Both 0x66 and 0xF2 prefixes are specified.
+#
+# Optional Superscripts
+#  - {FPU}: this mnemonic doesn't have FPU/MMX/SSE operands but access those
+#           registers.
 
 Table: one byte opcode
 Referrer:
@@ -269,14 +273,16 @@ d4: AAM Ib (i64)
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
+# coprocessor instruction set), the coprocessor means x87 FPU.
+d8: ESC {FPU}
+d9: ESC {FPU}
+da: ESC {FPU}
+db: ESC {FPU}
+dc: ESC {FPU}
+dd: ESC {FPU}
+de: ESC {FPU}
+df: ESC {FPU}
 # 0xe0 - 0xef
 # Note: "forced64" is Intel CPU behavior: they ignore 0x66 prefix
 # in 64-bit mode. AMD CPUs accept 0x66 prefix, it causes RIP truncation
@@ -462,7 +468,7 @@ AVXcode: 1
 75: pcmpeqw Pq,Qq | vpcmpeqw Vx,Hx,Wx (66),(v1)
 76: pcmpeqd Pq,Qq | vpcmpeqd Vx,Hx,Wx (66),(v1)
 # Note: Remove (v), because vzeroall and vzeroupper becomes emms without VEX.
-77: emms | vzeroupper | vzeroall
+77: emms {FPU} | vzeroupper | vzeroall
 78: VMREAD Ey,Gy | vcvttps2udq/pd2udq Vx,Wpd (evo) | vcvttsd2usi Gv,Wx (F2),(ev) | vcvttss2usi Gv,Wx (F3),(ev) | vcvttps2uqq/pd2uqq Vx,Wx (66),(ev)
 79: VMWRITE Gy,Ey | vcvtps2udq/pd2udq Vx,Wpd (evo) | vcvtsd2usi Gv,Wx (F2),(ev) | vcvtss2usi Gv,Wx (F3),(ev) | vcvtps2uqq/pd2uqq Vx,Wx (66),(ev)
 7a: vcvtudq2pd/uqq2pd Vpd,Wx (F3),(ev) | vcvtudq2ps/uqq2ps Vpd,Wx (F2),(ev) | vcvttps2qq/pd2qq Vx,Wx (66),(ev)
@@ -1036,10 +1042,10 @@ GrpTable: Grp14
 EndTable
 
 GrpTable: Grp15
-0: fxsave | RDFSBASE Ry (F3),(11B)
-1: fxstor | RDGSBASE Ry (F3),(11B)
-2: vldmxcsr Md (v1) | WRFSBASE Ry (F3),(11B)
-3: vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
+0: fxsave {FPU} | RDFSBASE Ry (F3),(11B)
+1: fxrstor {FPU} | RDGSBASE Ry (F3),(11B)
+2: ldmxcsr {FPU} | vldmxcsr Md (v1),{FPU} | WRFSBASE Ry (F3),(11B)
+3: stmxcsr {FPU} | vstmxcsr Md (v1),{FPU} | WRGSBASE Ry (F3),(11B)
 4: XSAVE | ptwrite Ey (F3),(11B)
 5: XRSTOR | lfence (11B) | INCSSPD/Q Ry (F3),(11B)
 6: XSAVEOPT | clwb (66) | mfence (11B) | TPAUSE Rd (66),(11B) | UMONITOR Rv (F3),(11B) | UMWAIT Rd (F2),(11B) | CLRSSBSY Mq (F3)
diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
index a42015b305f4..e8a0436d6397 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -44,7 +44,7 @@ BEGIN {
 	delete atable
 
 	opnd_expr = "^[A-Za-z/]"
-	ext_expr = "^\\("
+	ext_expr = "^(\\(|\\{)"
 	sep_expr = "^\\|$"
 	group_expr = "^Grp[0-9A-Za-z]+"
 
@@ -65,7 +65,9 @@ BEGIN {
 	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr = "\\([df]64\\)"
 	rex_expr = "^REX(\\.[XRWB]+)*"
-	fpu_expr = "^ESC" # TODO
+
+	fpureg_expr = "^[HLNPQUVW][a-z]+" # MMX/SSE register operands
+	fpu_expr = "\\{FPU\\}"
 
 	lprefix1_expr = "\\((66|!F3)\\)"
 	lprefix2_expr = "\\(F3\\)"
@@ -236,10 +238,11 @@ function add_flags(old,new) {
 }
 
 # convert operands to flags.
-function convert_operands(count,opnd,       i,j,imm,mod)
+function convert_operands(count,opnd,       i,j,imm,mod,fpu)
 {
 	imm = null
 	mod = null
+	fpu = null
 	for (j = 1; j <= count; j++) {
 		i = opnd[j]
 		if (match(i, imm_expr) == 1) {
@@ -253,7 +256,12 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 				imm = imm_flag[i]
 		} else if (match(i, modrm_expr))
 			mod = "INAT_MODRM"
+		if (match(i, fpureg_expr) == 1) {
+			fpu = "INAT_FPU"
+		}
 	}
+	if (fpu)
+		imm = add_flags(imm, fpu)
 	return add_flags(imm, mod)
 }
 
@@ -283,6 +291,10 @@ function convert_operands(count,opnd,       i,j,imm,mod)
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
@@ -294,6 +306,7 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 			opnd = $i
 			count = split($(i++), opnds, ",")
 			flags = convert_operands(count, opnds)
+
 		}
 		if (match($i, ext_expr))
 			ext = $(i++)
@@ -318,9 +331,9 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 		if (match(opcode, rex_expr))
 			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
 
-		# check coprocessor escape : TODO
-		if (match(opcode, fpu_expr))
-			flags = add_flags(flags, "INAT_MODRM")
+		# check FPU/MMX/SSE superscripts
+		if (match(ext, fpu_expr))
+			flags = add_flags(flags, "INAT_MODRM | INAT_FPU")
 
 		# check VEX codes
 		if (match(ext, evexonly_expr))
@@ -336,22 +349,49 @@ function convert_operands(count,opnd,       i,j,imm,mod)
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
+			if (lpfpu[0] == 0 && flags !~ "INAT_FPU") {
+				lpfpu[0] = 1
+				lpfpu[1] = 1
+				lpfpu[2] = 1
+				lpfpu[3] = 1
+			}
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
index ec31f5b60323..3aae11931a0a 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -33,6 +33,10 @@
 #  - (F2): the last prefix is 0xF2
 #  - (!F3) : the last prefix is not 0xF3 (including non-last prefix case)
 #  - (66&F2): Both 0x66 and 0xF2 prefixes are specified.
+#
+# Optional Superscripts
+#  - {FPU}: this mnemonic doesn't have FPU/MMX/SSE operands but access those
+#           registers.
 
 Table: one byte opcode
 Referrer:
@@ -269,14 +273,16 @@ d4: AAM Ib (i64)
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
+# coprocessor instruction set), the coprocessor means x87 FPU.
+d8: ESC {FPU}
+d9: ESC {FPU}
+da: ESC {FPU}
+db: ESC {FPU}
+dc: ESC {FPU}
+dd: ESC {FPU}
+de: ESC {FPU}
+df: ESC {FPU}
 # 0xe0 - 0xef
 # Note: "forced64" is Intel CPU behavior: they ignore 0x66 prefix
 # in 64-bit mode. AMD CPUs accept 0x66 prefix, it causes RIP truncation
@@ -462,7 +468,7 @@ AVXcode: 1
 75: pcmpeqw Pq,Qq | vpcmpeqw Vx,Hx,Wx (66),(v1)
 76: pcmpeqd Pq,Qq | vpcmpeqd Vx,Hx,Wx (66),(v1)
 # Note: Remove (v), because vzeroall and vzeroupper becomes emms without VEX.
-77: emms | vzeroupper | vzeroall
+77: emms {FPU} | vzeroupper | vzeroall
 78: VMREAD Ey,Gy | vcvttps2udq/pd2udq Vx,Wpd (evo) | vcvttsd2usi Gv,Wx (F2),(ev) | vcvttss2usi Gv,Wx (F3),(ev) | vcvttps2uqq/pd2uqq Vx,Wx (66),(ev)
 79: VMWRITE Gy,Ey | vcvtps2udq/pd2udq Vx,Wpd (evo) | vcvtsd2usi Gv,Wx (F2),(ev) | vcvtss2usi Gv,Wx (F3),(ev) | vcvtps2uqq/pd2uqq Vx,Wx (66),(ev)
 7a: vcvtudq2pd/uqq2pd Vpd,Wx (F3),(ev) | vcvtudq2ps/uqq2ps Vpd,Wx (F2),(ev) | vcvttps2qq/pd2qq Vx,Wx (66),(ev)
@@ -1036,10 +1042,10 @@ GrpTable: Grp14
 EndTable
 
 GrpTable: Grp15
-0: fxsave | RDFSBASE Ry (F3),(11B)
-1: fxstor | RDGSBASE Ry (F3),(11B)
-2: vldmxcsr Md (v1) | WRFSBASE Ry (F3),(11B)
-3: vstmxcsr Md (v1) | WRGSBASE Ry (F3),(11B)
+0: fxsave {FPU} | RDFSBASE Ry (F3),(11B)
+1: fxrstor {FPU} | RDGSBASE Ry (F3),(11B)
+2: ldmxcsr {FPU} | vldmxcsr Md (v1),{FPU} | WRFSBASE Ry (F3),(11B)
+3: stmxcsr {FPU} | vstmxcsr Md (v1),{FPU} | WRGSBASE Ry (F3),(11B)
 4: XSAVE | ptwrite Ey (F3),(11B)
 5: XRSTOR | lfence (11B) | INCSSPD/Q Ry (F3),(11B)
 6: XSAVEOPT | clwb (66) | mfence (11B) | TPAUSE Rd (66),(11B) | UMONITOR Rv (F3),(11B) | UMWAIT Rd (F2),(11B) | CLRSSBSY Mq (F3)
diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
index a42015b305f4..e8a0436d6397 100644
--- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
@@ -44,7 +44,7 @@ BEGIN {
 	delete atable
 
 	opnd_expr = "^[A-Za-z/]"
-	ext_expr = "^\\("
+	ext_expr = "^(\\(|\\{)"
 	sep_expr = "^\\|$"
 	group_expr = "^Grp[0-9A-Za-z]+"
 
@@ -65,7 +65,9 @@ BEGIN {
 	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr = "\\([df]64\\)"
 	rex_expr = "^REX(\\.[XRWB]+)*"
-	fpu_expr = "^ESC" # TODO
+
+	fpureg_expr = "^[HLNPQUVW][a-z]+" # MMX/SSE register operands
+	fpu_expr = "\\{FPU\\}"
 
 	lprefix1_expr = "\\((66|!F3)\\)"
 	lprefix2_expr = "\\(F3\\)"
@@ -236,10 +238,11 @@ function add_flags(old,new) {
 }
 
 # convert operands to flags.
-function convert_operands(count,opnd,       i,j,imm,mod)
+function convert_operands(count,opnd,       i,j,imm,mod,fpu)
 {
 	imm = null
 	mod = null
+	fpu = null
 	for (j = 1; j <= count; j++) {
 		i = opnd[j]
 		if (match(i, imm_expr) == 1) {
@@ -253,7 +256,12 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 				imm = imm_flag[i]
 		} else if (match(i, modrm_expr))
 			mod = "INAT_MODRM"
+		if (match(i, fpureg_expr) == 1) {
+			fpu = "INAT_FPU"
+		}
 	}
+	if (fpu)
+		imm = add_flags(imm, fpu)
 	return add_flags(imm, mod)
 }
 
@@ -283,6 +291,10 @@ function convert_operands(count,opnd,       i,j,imm,mod)
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
@@ -294,6 +306,7 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 			opnd = $i
 			count = split($(i++), opnds, ",")
 			flags = convert_operands(count, opnds)
+
 		}
 		if (match($i, ext_expr))
 			ext = $(i++)
@@ -318,9 +331,9 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 		if (match(opcode, rex_expr))
 			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
 
-		# check coprocessor escape : TODO
-		if (match(opcode, fpu_expr))
-			flags = add_flags(flags, "INAT_MODRM")
+		# check FPU/MMX/SSE superscripts
+		if (match(ext, fpu_expr))
+			flags = add_flags(flags, "INAT_MODRM | INAT_FPU")
 
 		# check VEX codes
 		if (match(ext, evexonly_expr))
@@ -336,22 +349,49 @@ function convert_operands(count,opnd,       i,j,imm,mod)
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
+			if (lpfpu[0] == 0 && flags !~ "INAT_FPU") {
+				lpfpu[0] = 1
+				lpfpu[1] = 1
+				lpfpu[2] = 1
+				lpfpu[3] = 1
+			}
+			else if (lpfpu[0] != 0 && flags ~ "INAT_FPU")
+				flags = add_flags(flags, "INAT_FPUIFVEX")
+			if (length(flags) == 0)
+				continue;
 			table[idx] = add_flags(table[idx],flags)
 		}
 	}

