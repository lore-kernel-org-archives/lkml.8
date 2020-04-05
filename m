Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A96C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 03:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4D92072B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 03:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586057198;
	bh=oizNU/QdgZv1AqGVLFMwJesg/me1w2kQ9dlonCE73ps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=TPffMOzZAV4k8R1gFqmaZadHSx2Jxpn0mJxiDZ+43y7Y8gfsQV+Uk4CPgDGX3+qdx
	 NC/XaGtDo+/AYELxeglYbEeFbYHhQ9zycfd4GqR3kA5NjveDZq5yt5UMqtpjX3rqGs
	 L9Sp1Xjgij472s4Bh0rPIeWVlphVrX9pKpzz8j00=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDEDTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 23:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgDEDTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 23:19:38 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55A68206F5;
        Sun,  5 Apr 2020 03:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586056777;
        bh=oizNU/QdgZv1AqGVLFMwJesg/me1w2kQ9dlonCE73ps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EVtclcbptM+puXk5nrOKYddPFvpQr97fYqVeR/fLrlm52cy+/qqWu3xAKc4/3n1g3
         8JmIsPXO6mWDrc036rgOM6vE4XDbNrIhMJQDj3yIBHC9gVGfShgqRYcopory5wc+WT
         LL+KnKH1AEWMe7oPR1Zqv+/rzdMwM48cfObIKwaQ=
Date:   Sun, 5 Apr 2020 12:19:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Jann Horn <jannh@google.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse,
 -msse2 without any visible FPU state protection
Message-Id: <20200405121930.e3ea3e7acc7588102de483e2@kernel.org>
In-Reply-To: <20200404143224.GL2452@worktop.programming.kicks-ass.net>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
        <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
        <20200402141308.GB20730@hirez.programming.kicks-ass.net>
        <20200403142837.f61a18d7bd32fd73777479ad@kernel.org>
        <20200403112113.GN20730@hirez.programming.kicks-ass.net>
        <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
        <20200404143224.GL2452@worktop.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Apr 2020 16:32:24 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Sat, Apr 04, 2020 at 12:08:08PM +0900, Masami Hiramatsu wrote:
> > From c609be0b6403245612503fca1087628655bab96c Mon Sep 17 00:00:00 2001
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > Date: Fri, 3 Apr 2020 16:58:22 +0900
> > Subject: [PATCH] x86: insn: Add insn_is_fpu()
> > 
> > Add insn_is_fpu(insn) which tells that the insn is
> > whether touch the MMX/XMM/YMM register or the instruction
> > of FP coprocessor.
> 
> Looks good, although I changed it a little like so:

OK, and I found there is a mistake on my patch. I should not use (v) for
the instruction, which makes decoder insane.

> 
> --- a/arch/x86/include/asm/insn.h
> +++ b/arch/x86/include/asm/insn.h
> @@ -133,11 +133,12 @@ static inline int insn_is_fpu(struct ins
>  {
>  	if (!insn->opcode.got)
>  		insn_get_opcode(insn);
> -	if (inat_is_fpu(insn->attr)) {
> +	if (inat_is_fpu(insn->attr)) {
>  		if (insn->attr & INAT_FPUIFVEX)
>  			return insn_is_avx(insn);
>  		return 1;
>  	}
> +	return 0;
>  }
>  
>  static inline int insn_has_emulate_prefix(struct insn *insn)
> --- a/arch/x86/lib/x86-opcode-map.txt
> +++ b/arch/x86/lib/x86-opcode-map.txt
> @@ -269,14 +269,14 @@ d4: AAM Ib (i64)
>  d5: AAD Ib (i64)
>  d6:
>  d7: XLAT/XLATB
> -d8: ESC
> -d9: ESC
> -da: ESC
> -db: ESC
> -dc: ESC
> -dd: ESC
> -de: ESC
> -df: ESC
> +d8: FPU
> +d9: FPU
> +da: FPU
> +db: FPU
> +dc: FPU
> +dd: FPU
> +de: FPU
> +df: FPU

I don't want to use FPU since Intel SDM is still using ESC because it
is co-processor escape code.

Here is the new patch. 

From d7eca4946ab3f0d08ad1268f49418f8655aaf57c Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Fri, 3 Apr 2020 16:58:22 +0900
Subject: [PATCH] x86: insn: Add insn_is_fpu()

Add insn_is_fpu(insn) which tells that the insn is
whether touch the MMX/XMM/YMM register or the instruction
of FP coprocessor.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes:
  - Fix SET* also not FPU (unless it has vex prefix.)
  - Fix to remove (v) (VEX only) flag.
---
 arch/x86/include/asm/inat.h                |  7 +++++++
 arch/x86/include/asm/insn.h                | 12 ++++++++++++
 arch/x86/lib/x86-opcode-map.txt            |  6 +++---
 arch/x86/tools/gen-insn-attr-x86.awk       | 22 +++++++++++++++++-----
 tools/arch/x86/include/asm/inat.h          |  7 +++++++
 tools/arch/x86/include/asm/insn.h          | 12 ++++++++++++
 tools/arch/x86/lib/x86-opcode-map.txt      |  6 +++---
 tools/arch/x86/tools/gen-insn-attr-x86.awk | 22 +++++++++++++++++-----
 8 files changed, 78 insertions(+), 16 deletions(-)

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
index ec31f5b60323..c3d36b4c894d 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -1037,9 +1037,9 @@ EndTable
 
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
index a42015b305f4..21de6757893f 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -65,7 +65,11 @@ BEGIN {
 	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr = "\\([df]64\\)"
 	rex_expr = "^REX(\\.[XRWB]+)*"
-	fpu_expr = "^ESC" # TODO
+
+	mmxreg_expr = "^[HLNPQUVW][a-z]+" # MMX/SSE register operands
+	mmx_expr = "^\\((emms|fxsave|fxrstor|ldmxcsr|stmxcsr)\\)" # MMX/SSE nmemonics lacking operands
+	mmxifvex_expr = "^(CMOV|SET.*)" # nmemonics NOT an AVX
+	fpu_expr = "^ESC"
 
 	lprefix1_expr = "\\((66|!F3)\\)"
 	lprefix2_expr = "\\(F3\\)"
@@ -236,10 +240,11 @@ function add_flags(old,new) {
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
@@ -253,7 +258,12 @@ function convert_operands(count,opnd,       i,j,imm,mod)
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
 
@@ -318,9 +328,11 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 		if (match(opcode, rex_expr))
 			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
 
-		# check coprocessor escape : TODO
-		if (match(opcode, fpu_expr))
-			flags = add_flags(flags, "INAT_MODRM")
+		# check coprocessor escape
+		if (match(opcode, fpu_expr) || match(opcode, mmx_expr))
+			flags = add_flags(flags, "INAT_MODRM | INAT_FPU")
+		if (match(opcode, mmxifvex_expr))
+			flags = add_flags(flags, "INAT_FPUIFVEX")
 
 		# check VEX codes
 		if (match(ext, evexonly_expr))
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
index ec31f5b60323..c3d36b4c894d 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -1037,9 +1037,9 @@ EndTable
 
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
index a42015b305f4..21de6757893f 100644
--- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
@@ -65,7 +65,11 @@ BEGIN {
 	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr = "\\([df]64\\)"
 	rex_expr = "^REX(\\.[XRWB]+)*"
-	fpu_expr = "^ESC" # TODO
+
+	mmxreg_expr = "^[HLNPQUVW][a-z]+" # MMX/SSE register operands
+	mmx_expr = "^\\((emms|fxsave|fxrstor|ldmxcsr|stmxcsr)\\)" # MMX/SSE nmemonics lacking operands
+	mmxifvex_expr = "^(CMOV|SET.*)" # nmemonics NOT an AVX
+	fpu_expr = "^ESC"
 
 	lprefix1_expr = "\\((66|!F3)\\)"
 	lprefix2_expr = "\\(F3\\)"
@@ -236,10 +240,11 @@ function add_flags(old,new) {
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
@@ -253,7 +258,12 @@ function convert_operands(count,opnd,       i,j,imm,mod)
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
 
@@ -318,9 +328,11 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 		if (match(opcode, rex_expr))
 			flags = add_flags(flags, "INAT_MAKE_PREFIX(INAT_PFX_REX)")
 
-		# check coprocessor escape : TODO
-		if (match(opcode, fpu_expr))
-			flags = add_flags(flags, "INAT_MODRM")
+		# check coprocessor escape
+		if (match(opcode, fpu_expr) || match(opcode, mmx_expr))
+			flags = add_flags(flags, "INAT_MODRM | INAT_FPU")
+		if (match(opcode, mmxifvex_expr))
+			flags = add_flags(flags, "INAT_FPUIFVEX")
 
 		# check VEX codes
 		if (match(ext, evexonly_expr))
-- 
2.20.1


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
