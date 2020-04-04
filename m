Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2DDC2D0F2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 03:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3DC20735
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 03:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585969702;
	bh=e/yNSdgbEIWUwfYz0z3Pr5AJ4wh9kn+3CIJpBSQ4o6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KKazq+IUqf4MH3d4UNgiInOekgBFf/vTRaYnWGwaJkamNF3avQJUleGWUwHHbDpjI
	 xVlEbXWEgm031Oftkti41Qg4GnlYHGwAi+Bi53DMkfU8fLt/D4vSsAdNmAzz5Iq9Ms
	 O6wzBoX1qQ4Vfu7NKxMI4D3eM6NsKLtXOSOiazsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgDDDIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 23:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgDDDIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 23:08:20 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF97B2072B;
        Sat,  4 Apr 2020 03:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585969699;
        bh=e/yNSdgbEIWUwfYz0z3Pr5AJ4wh9kn+3CIJpBSQ4o6w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Elv6LC4/TYX5AYW7RwWcmEgec4jNoB+JZq68BnK0W44eJtsB7pOVLxSjckO+njhRr
         orza5m5rf5is6+xFW+O39w7GC1Iont+WzKg3L+zdw1SP1JImUQ6x1Ak2iF1Bxm53UC
         84AAyGCyNNc6ApvtQPmw/nPGvZcDP0dXm0AFPPSA=
Date:   Sat, 4 Apr 2020 12:08:08 +0900
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
Message-Id: <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
In-Reply-To: <20200403112113.GN20730@hirez.programming.kicks-ass.net>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
        <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
        <20200402141308.GB20730@hirez.programming.kicks-ass.net>
        <20200403142837.f61a18d7bd32fd73777479ad@kernel.org>
        <20200403112113.GN20730@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Apr 2020 13:21:13 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Apr 03, 2020 at 02:28:37PM +0900, Masami Hiramatsu wrote:
> > On Thu, 2 Apr 2020 16:13:08 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > Masami, Boris, is there any semi-sane way we can have insn_is_fpu() ?
> > > While digging through various opcode manuals is of course forever fun, I
> > > do feel like it might not be the best way.
> > 
> > Yes, it is possible to add INAT_FPU and insn_is_fpu().
> > But it seems that the below patch needs more classification based on
> > nmemonic or opcodes.
> 
> I went with opcode, and I think I did a fairly decent job, but I did
> find a few problems on a second look at things.
> 
> I don't think nmemonic are going to help, the x86 nmemonics are a mess
> (much like its opcode tables), there's no way to sanely detect what
> registers are effected by an instruction based on name.
> 
> The best I came up with is operand class, see below.

Yeah, so we need another map, current inat map is optimized for
decoding, and lack of some information for reducing size.
E.g. it mixed up the VEX prefix instruction with non-VEX one.

> 
> > IMHO, it is the time to expand gen-insn-attr.awk or clone it to
> > generate another opcode map, so that user will easily extend the
> > insn infrastructure.
> > (e.g. I had made an in-kernel disassembler, which generates a mnemonic
> >  maps from x86-opcode-map.txt)
> >  https://github.com/mhiramat/linux/commits/inkernel-disasm-20130414
> 
> Cute, and I'm thinking we might want that eventually, people have been
> asking for a kernel specific objdump, one that knows about and shows all
> the magical things the kernel does, like alternative, jump-labels and
> soon the static_call stuff, but also things like the exception handling.
> 
> Objtool actually knows about much of that, and pairing it with your
> disassembler could print it.
> 
> > > +	if (insn.vex_prefix.nbytes) {
> > > +		*type = INSN_FPU;
> > >  		return 0;
> > > +	}
> 
> So that's the AVX nonsense dealt with; right until they stick an integer
> instruction in the AVX space I suppose :/ Please tell me they didn't
> already do that..

I'm not so sure.
Theoretically, x86 instruction can be encoded with VEX prefix instead of
REX prefix (most compiler may not output such inefficient code.)

> > >  	op1 = insn.opcode.bytes[0];
> > >  	op2 = insn.opcode.bytes[1];
> > > @@ -357,48 +359,71 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
> > >  
> > >  	case 0x0f:
> > >  
> > > +		switch (op2) {
> 
> > > +		case 0xae:
> > > +			/* insane!! */
> > > +			if ((modrm_reg >= 0 && modrm_reg <= 3) && modrm_mod != 3 && !insn.prefixes.nbytes)
> > > +				*type = INSN_FPU;
> > > +			break;
> 
> This is crazy, but I was trying to get at the x86 FPU control
> instructions:
> 
>   FXSAVE, FXRSTOR, LDMXCSR and STMXCSR
> 
> Which are in Grp15

Yes, that is a complex part.

> Now arguably, I could skip them, the compiler should never emit those,
> and the newer, fancier, XSAV family isn't marked as FPU either, even
> though it will save/restore the FPU/MMX/SSE/AVX states too.
> 
> So I think I'll remove this part, it'll also make the fpu_safe
> annotations easier.
> 
> > > +		case 0x10 ... 0x17:
> > > +		case 0x28 ... 0x2f:
> > > +		case 0x3a:
> > > +		case 0x50 ... 0x77:
> > > +		case 0x7a ... 0x7f:
> > > +		case 0xc2:
> > > +		case 0xc4 ... 0xc6:
> > > +		case 0xd0 ... 0xff:
> > > +			/* MMX, SSE, VMX */
> 
> So afaict these are the MMX and SSE instruction (clearly the VMX is my
> brain loosing it).
> 
> I went with the coder64 opcode tables, but our x86-opcode-map.txt seems
> to agree, mostly.
> 
> I now see that 0f 3a is not all mmx/sse, it also includes RORX which is
> an integer instruction. Also, may I state that the opcode map is a
> sodding disgrace? Why is an integer instruction stuck in the middle of
> SSE instructions like that ?!?!
> 
> And I should shorten the last range to 0xd0 ... 0xfe, as 0f ff is UD0.
> 
> Other than that I think this is pretty accurate.
> 
> > > +			*type = INSN_FPU;
> > > +			break;
> > > +
> > > +		default:
> > > +			break;
> > > +		}
> > >  		break;
> > >  
> > >  	case 0xc9:
> > > @@ -414,6 +439,10 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
> > >  
> > >  		break;
> > >  
> > > +	case 0xd8 ... 0xdf: /* x87 FPU range */
> > > +		*type = INSN_FPU;
> > > +		break;
> 
> Our x86-opcode-map.txt lists that as ESC, but doesn't have an escape
> table for it. Per:
> 
>   http://ref.x86asm.net/coder64.html
> 
> these are all the traditional x87 FPU ops.

Yes, for decoding, we don't need those tables.

> > > +
> > >  	case 0xe3:
> > >  		/* jecxz/jrcxz */
> > >  		*type = INSN_JUMP_CONDITIONAL;
> 
> 
> Now; I suppose I need our x86-opcode-map.txt extended in at least two
> ways:
> 
>  - all those x87 FPU instructions need adding
>  - a way of detecting the affected register set
> 
> Now, I suspect we can do that latter by the instruction operands that
> are already there, although I've not managed to untangle them fully
> (hint, we really should improve the comments on top). Operands seem to
> have one capital that denotes the class:
> 
>  - I: immediate
>  - G: general purpose
>  - E
>  - P,Q: MMX
>  - V,M,W,H: SSE
> 
> So if we can extend the awk magic to provide operand classes for each
> decoded instruction, then that would simplify this lots.

Hmm, it requires to generate another tables. Instead, what about below?
I've added INAT_FPU (and INAT_FPUIFVEX*) flag to find FPU related code.

*) actually, current inat tables have variant tables for the last prefix
variations. But it doesn't have vex variations which doubles the size
of table, that is too much just for FPU opcode.

From c609be0b6403245612503fca1087628655bab96c Mon Sep 17 00:00:00 2001
From: Masami Hiramatsu <mhiramat@kernel.org>
Date: Fri, 3 Apr 2020 16:58:22 +0900
Subject: [PATCH] x86: insn: Add insn_is_fpu()

Add insn_is_fpu(insn) which tells that the insn is
whether touch the MMX/XMM/YMM register or the instruction
of FP coprocessor.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/include/asm/inat.h                |  7 +++++++
 arch/x86/include/asm/insn.h                | 11 +++++++++++
 arch/x86/lib/x86-opcode-map.txt            | 22 +++++++++++-----------
 arch/x86/tools/gen-insn-attr-x86.awk       | 21 ++++++++++++++++-----
 tools/arch/x86/include/asm/inat.h          |  7 +++++++
 tools/arch/x86/include/asm/insn.h          | 11 +++++++++++
 tools/arch/x86/lib/x86-opcode-map.txt      | 22 +++++++++++-----------
 tools/arch/x86/tools/gen-insn-attr-x86.awk | 21 ++++++++++++++++-----
 8 files changed, 90 insertions(+), 32 deletions(-)

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
index 5c1ae3eff9d4..03e711668839 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -129,6 +129,17 @@ static inline int insn_is_evex(struct insn *insn)
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
+}
+
 static inline int insn_has_emulate_prefix(struct insn *insn)
 {
 	return !!insn->emulate_prefix_size;
diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index ec31f5b60323..f139bfccfdb9 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -404,17 +404,17 @@ AVXcode: 1
 3f:
 # 0x0f 0x40-0x4f
 40: CMOVO Gv,Ev
-41: CMOVNO Gv,Ev | kandw/q Vk,Hk,Uk | kandb/d Vk,Hk,Uk (66)
-42: CMOVB/C/NAE Gv,Ev | kandnw/q Vk,Hk,Uk | kandnb/d Vk,Hk,Uk (66)
+41: CMOVNO Gv,Ev | kandw/q Vk,Hk,Uk (v) | kandb/d Vk,Hk,Uk (66),(v)
+42: CMOVB/C/NAE Gv,Ev | kandnw/q Vk,Hk,Uk (v) | kandnb/d Vk,Hk,Uk (66),(v)
 43: CMOVAE/NB/NC Gv,Ev
-44: CMOVE/Z Gv,Ev | knotw/q Vk,Uk | knotb/d Vk,Uk (66)
-45: CMOVNE/NZ Gv,Ev | korw/q Vk,Hk,Uk | korb/d Vk,Hk,Uk (66)
-46: CMOVBE/NA Gv,Ev | kxnorw/q Vk,Hk,Uk | kxnorb/d Vk,Hk,Uk (66)
-47: CMOVA/NBE Gv,Ev | kxorw/q Vk,Hk,Uk | kxorb/d Vk,Hk,Uk (66)
+44: CMOVE/Z Gv,Ev | knotw/q Vk,Uk (v) | knotb/d Vk,Uk (66),(v)
+45: CMOVNE/NZ Gv,Ev | korw/q Vk,Hk,Uk (v) | korb/d Vk,Hk,Uk (66),(v)
+46: CMOVBE/NA Gv,Ev | kxnorw/q Vk,Hk,Uk (v) | kxnorb/d Vk,Hk,Uk (66),(v)
+47: CMOVA/NBE Gv,Ev | kxorw/q Vk,Hk,Uk (v) | kxorb/d Vk,Hk,Uk (66),(v)
 48: CMOVS Gv,Ev
 49: CMOVNS Gv,Ev
-4a: CMOVP/PE Gv,Ev | kaddw/q Vk,Hk,Uk | kaddb/d Vk,Hk,Uk (66)
-4b: CMOVNP/PO Gv,Ev | kunpckbw Vk,Hk,Uk (66) | kunpckwd/dq Vk,Hk,Uk
+4a: CMOVP/PE Gv,Ev | kaddw/q Vk,Hk,Uk (v) | kaddb/d Vk,Hk,Uk (66),(v)
+4b: CMOVNP/PO Gv,Ev | kunpckbw Vk,Hk,Uk (66),(v) | kunpckwd/dq Vk,Hk,Uk (v)
 4c: CMOVL/NGE Gv,Ev
 4d: CMOVNL/GE Gv,Ev
 4e: CMOVLE/NG Gv,Ev
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
index a42015b305f4..2b1ab6673bd3 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -65,7 +65,10 @@ BEGIN {
 	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr = "\\([df]64\\)"
 	rex_expr = "^REX(\\.[XRWB]+)*"
-	fpu_expr = "^ESC" # TODO
+	mmxreg_expr = "^[HLNPQUVW][a-z]+"
+	mmx_expr = "^\\((emms|fxsave|fxrstor|ldmxcsr|stmxcsr)\\)"
+	mmxifvex_expr = "^CMOV" # CMOV is non-vex non-mmx
+	fpu_expr = "^ESC"
 
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
 
@@ -318,9 +327,11 @@ function convert_operands(count,opnd,       i,j,imm,mod)
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
index 568854b14d0a..d21b1debd230 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -129,6 +129,17 @@ static inline int insn_is_evex(struct insn *insn)
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
+}
+
 static inline int insn_has_emulate_prefix(struct insn *insn)
 {
 	return !!insn->emulate_prefix_size;
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index ec31f5b60323..f139bfccfdb9 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -404,17 +404,17 @@ AVXcode: 1
 3f:
 # 0x0f 0x40-0x4f
 40: CMOVO Gv,Ev
-41: CMOVNO Gv,Ev | kandw/q Vk,Hk,Uk | kandb/d Vk,Hk,Uk (66)
-42: CMOVB/C/NAE Gv,Ev | kandnw/q Vk,Hk,Uk | kandnb/d Vk,Hk,Uk (66)
+41: CMOVNO Gv,Ev | kandw/q Vk,Hk,Uk (v) | kandb/d Vk,Hk,Uk (66),(v)
+42: CMOVB/C/NAE Gv,Ev | kandnw/q Vk,Hk,Uk (v) | kandnb/d Vk,Hk,Uk (66),(v)
 43: CMOVAE/NB/NC Gv,Ev
-44: CMOVE/Z Gv,Ev | knotw/q Vk,Uk | knotb/d Vk,Uk (66)
-45: CMOVNE/NZ Gv,Ev | korw/q Vk,Hk,Uk | korb/d Vk,Hk,Uk (66)
-46: CMOVBE/NA Gv,Ev | kxnorw/q Vk,Hk,Uk | kxnorb/d Vk,Hk,Uk (66)
-47: CMOVA/NBE Gv,Ev | kxorw/q Vk,Hk,Uk | kxorb/d Vk,Hk,Uk (66)
+44: CMOVE/Z Gv,Ev | knotw/q Vk,Uk (v) | knotb/d Vk,Uk (66),(v)
+45: CMOVNE/NZ Gv,Ev | korw/q Vk,Hk,Uk (v) | korb/d Vk,Hk,Uk (66),(v)
+46: CMOVBE/NA Gv,Ev | kxnorw/q Vk,Hk,Uk (v) | kxnorb/d Vk,Hk,Uk (66),(v)
+47: CMOVA/NBE Gv,Ev | kxorw/q Vk,Hk,Uk (v) | kxorb/d Vk,Hk,Uk (66),(v)
 48: CMOVS Gv,Ev
 49: CMOVNS Gv,Ev
-4a: CMOVP/PE Gv,Ev | kaddw/q Vk,Hk,Uk | kaddb/d Vk,Hk,Uk (66)
-4b: CMOVNP/PO Gv,Ev | kunpckbw Vk,Hk,Uk (66) | kunpckwd/dq Vk,Hk,Uk
+4a: CMOVP/PE Gv,Ev | kaddw/q Vk,Hk,Uk (v) | kaddb/d Vk,Hk,Uk (66),(v)
+4b: CMOVNP/PO Gv,Ev | kunpckbw Vk,Hk,Uk (66),(v) | kunpckwd/dq Vk,Hk,Uk (v)
 4c: CMOVL/NGE Gv,Ev
 4d: CMOVNL/GE Gv,Ev
 4e: CMOVLE/NG Gv,Ev
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
index a42015b305f4..2b1ab6673bd3 100644
--- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
@@ -65,7 +65,10 @@ BEGIN {
 	modrm_expr = "^([CDEGMNPQRSUVW/][a-z]+|NTA|T[012])"
 	force64_expr = "\\([df]64\\)"
 	rex_expr = "^REX(\\.[XRWB]+)*"
-	fpu_expr = "^ESC" # TODO
+	mmxreg_expr = "^[HLNPQUVW][a-z]+"
+	mmx_expr = "^\\((emms|fxsave|fxrstor|ldmxcsr|stmxcsr)\\)"
+	mmxifvex_expr = "^CMOV" # CMOV is non-vex non-mmx
+	fpu_expr = "^ESC"
 
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
 
@@ -318,9 +327,11 @@ function convert_operands(count,opnd,       i,j,imm,mod)
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





-- 
Masami Hiramatsu <mhiramat@kernel.org>
