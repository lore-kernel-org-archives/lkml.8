Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA88C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA8820737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 11:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xoxqCrbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403786AbgDCLVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 07:21:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47900 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgDCLVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xf4j8+2qvSkoJeupk2bcPoSbCSUjVqAszySE+PCmsjY=; b=xoxqCrbBcGuj9CmtG2xpCSMoH3
        QMpy0mHxSvnD8tScX1dLuaWF7CwCNNfqqeUbGj1T/EWps6Ptc26fO/O4MW+rt2HmjW4PQfCYdR53n
        kGtzWOa00Vdki/TCJJMoQwXnW5scr2Wwga7P8+ABxZ6QgRAyg+6ebA9uN153YYX4nEbV2z3Xpmpll
        3zvLgs9uMshpe/JM1/OwsESkcF/wNwTBVxT00b695fbmpAz226mYEbzXasbOY48EeWz4e6BuA0qHl
        +Xht1LDRUL2UMitxBu003FBe4lOzkgJl2vp7v4evXNnLBXjIbEg6vzXsU34wlZDibRyQXoNQsTh9d
        HRJQxCaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKKNw-0005FU-DJ; Fri, 03 Apr 2020 11:21:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47DDD30477A;
        Fri,  3 Apr 2020 13:21:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31AC12B122108; Fri,  3 Apr 2020 13:21:13 +0200 (CEST)
Date:   Fri, 3 Apr 2020 13:21:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
Message-ID: <20200403112113.GN20730@hirez.programming.kicks-ass.net>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
 <20200402141308.GB20730@hirez.programming.kicks-ass.net>
 <20200403142837.f61a18d7bd32fd73777479ad@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403142837.f61a18d7bd32fd73777479ad@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 02:28:37PM +0900, Masami Hiramatsu wrote:
> On Thu, 2 Apr 2020 16:13:08 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:

> > Masami, Boris, is there any semi-sane way we can have insn_is_fpu() ?
> > While digging through various opcode manuals is of course forever fun, I
> > do feel like it might not be the best way.
> 
> Yes, it is possible to add INAT_FPU and insn_is_fpu().
> But it seems that the below patch needs more classification based on
> nmemonic or opcodes.

I went with opcode, and I think I did a fairly decent job, but I did
find a few problems on a second look at things.

I don't think nmemonic are going to help, the x86 nmemonics are a mess
(much like its opcode tables), there's no way to sanely detect what
registers are effected by an instruction based on name.

The best I came up with is operand class, see below.

> IMHO, it is the time to expand gen-insn-attr.awk or clone it to
> generate another opcode map, so that user will easily extend the
> insn infrastructure.
> (e.g. I had made an in-kernel disassembler, which generates a mnemonic
>  maps from x86-opcode-map.txt)
>  https://github.com/mhiramat/linux/commits/inkernel-disasm-20130414

Cute, and I'm thinking we might want that eventually, people have been
asking for a kernel specific objdump, one that knows about and shows all
the magical things the kernel does, like alternative, jump-labels and
soon the static_call stuff, but also things like the exception handling.

Objtool actually knows about much of that, and pairing it with your
disassembler could print it.

> > +	if (insn.vex_prefix.nbytes) {
> > +		*type = INSN_FPU;
> >  		return 0;
> > +	}

So that's the AVX nonsense dealt with; right until they stick an integer
instruction in the AVX space I suppose :/ Please tell me they didn't
already do that..

> >  
> >  	op1 = insn.opcode.bytes[0];
> >  	op2 = insn.opcode.bytes[1];
> > @@ -357,48 +359,71 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
> >  
> >  	case 0x0f:
> >  
> > +		switch (op2) {

> > +		case 0xae:
> > +			/* insane!! */
> > +			if ((modrm_reg >= 0 && modrm_reg <= 3) && modrm_mod != 3 && !insn.prefixes.nbytes)
> > +				*type = INSN_FPU;
> > +			break;

This is crazy, but I was trying to get at the x86 FPU control
instructions:

  FXSAVE, FXRSTOR, LDMXCSR and STMXCSR

Which are in Grp15

Now arguably, I could skip them, the compiler should never emit those,
and the newer, fancier, XSAV family isn't marked as FPU either, even
though it will save/restore the FPU/MMX/SSE/AVX states too.

So I think I'll remove this part, it'll also make the fpu_safe
annotations easier.

> > +		case 0x10 ... 0x17:
> > +		case 0x28 ... 0x2f:
> > +		case 0x3a:
> > +		case 0x50 ... 0x77:
> > +		case 0x7a ... 0x7f:
> > +		case 0xc2:
> > +		case 0xc4 ... 0xc6:
> > +		case 0xd0 ... 0xff:
> > +			/* MMX, SSE, VMX */

So afaict these are the MMX and SSE instruction (clearly the VMX is my
brain loosing it).

I went with the coder64 opcode tables, but our x86-opcode-map.txt seems
to agree, mostly.

I now see that 0f 3a is not all mmx/sse, it also includes RORX which is
an integer instruction. Also, may I state that the opcode map is a
sodding disgrace? Why is an integer instruction stuck in the middle of
SSE instructions like that ?!?!

And I should shorten the last range to 0xd0 ... 0xfe, as 0f ff is UD0.

Other than that I think this is pretty accurate.

> > +			*type = INSN_FPU;
> > +			break;
> > +
> > +		default:
> > +			break;
> > +		}
> >  		break;
> >  
> >  	case 0xc9:
> > @@ -414,6 +439,10 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
> >  
> >  		break;
> >  
> > +	case 0xd8 ... 0xdf: /* x87 FPU range */
> > +		*type = INSN_FPU;
> > +		break;

Our x86-opcode-map.txt lists that as ESC, but doesn't have an escape
table for it. Per:

  http://ref.x86asm.net/coder64.html

these are all the traditional x87 FPU ops.


> > +
> >  	case 0xe3:
> >  		/* jecxz/jrcxz */
> >  		*type = INSN_JUMP_CONDITIONAL;


Now; I suppose I need our x86-opcode-map.txt extended in at least two
ways:

 - all those x87 FPU instructions need adding
 - a way of detecting the affected register set

Now, I suspect we can do that latter by the instruction operands that
are already there, although I've not managed to untangle them fully
(hint, we really should improve the comments on top). Operands seem to
have one capital that denotes the class:

 - I: immediate
 - G: general purpose
 - E
 - P,Q: MMX
 - V,M,W,H: SSE

So if we can extend the awk magic to provide operand classes for each
decoded instruction, then that would simplify this lots.

New version below...

---
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -12,6 +12,13 @@
 #define _ASM_X86_FPU_API_H
 #include <linux/bottom_half.h>
 
+#define annotate_fpu() ({						\
+	asm volatile("%c0:\n\t"						\
+		     ".pushsection .discard.fpu_safe\n\t"		\
+		     ".long %c0b - .\n\t"				\
+		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+})
+
 /*
  * Use kernel_fpu_begin/end() if you intend to use FPU in kernel context. It
  * disables preemption so be careful if you intend to use it for long periods
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -437,6 +437,7 @@ static inline int copy_fpregs_to_fpstate
 	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
 	 * so we have to mark them inactive:
 	 */
+	annotate_fpu();
 	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
 
 	return 0;
@@ -462,6 +463,7 @@ static inline void copy_kernel_to_fpregs
 	 * "m" is a random variable that should be in L1.
 	 */
 	if (unlikely(static_cpu_has_bug(X86_BUG_FXSAVE_LEAK))) {
+		annotate_fpu();
 		asm volatile(
 			"fnclex\n\t"
 			"emms\n\t"
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -38,7 +38,10 @@ static void fpu__init_cpu_generic(void)
 		fpstate_init_soft(&current->thread.fpu.state.soft);
 	else
 #endif
+	{
+		annotate_fpu();
 		asm volatile ("fninit");
+	}
 }
 
 /*
@@ -61,6 +64,7 @@ static bool fpu__probe_without_cpuid(voi
 	cr0 &= ~(X86_CR0_TS | X86_CR0_EM);
 	write_cr0(cr0);
 
+	annotate_fpu();
 	asm volatile("fninit ; fnstsw %0 ; fnstcw %1" : "+m" (fsw), "+m" (fcw));
 
 	pr_info("x86/fpu: Probing for FPU: FSW=0x%04hx FCW=0x%04hx\n", fsw, fcw);
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -27,6 +27,7 @@ enum insn_type {
 	INSN_CLAC,
 	INSN_STD,
 	INSN_CLD,
+	INSN_FPU,
 	INSN_OTHER,
 };
 
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -73,7 +73,7 @@ int arch_decode_instruction(struct elf *
 {
 	struct insn insn;
 	int x86_64, sign;
-	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
+	unsigned char op1, op2, op3, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
 		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
 		      modrm_reg = 0, sib = 0;
 
@@ -92,11 +92,14 @@ int arch_decode_instruction(struct elf *
 	*len = insn.length;
 	*type = INSN_OTHER;
 
-	if (insn.vex_prefix.nbytes)
+	if (insn.vex_prefix.nbytes) {
+		*type = INSN_FPU; /* AVX */
 		return 0;
+	}
 
 	op1 = insn.opcode.bytes[0];
 	op2 = insn.opcode.bytes[1];
+	op3 = insn.opcode.bytes[2];
 
 	if (insn.rex_prefix.nbytes) {
 		rex = insn.rex_prefix.bytes[0];
@@ -357,48 +360,75 @@ int arch_decode_instruction(struct elf *
 
 	case 0x0f:
 
-		if (op2 == 0x01) {
-
+		switch (op2) {
+		case 0x01:
 			if (modrm == 0xca)
 				*type = INSN_CLAC;
 			else if (modrm == 0xcb)
 				*type = INSN_STAC;
+			break;
 
-		} else if (op2 >= 0x80 && op2 <= 0x8f) {
-
+		case 0x80 ... 0x8f: /* Jcc */
 			*type = INSN_JUMP_CONDITIONAL;
+			break;
 
-		} else if (op2 == 0x05 || op2 == 0x07 || op2 == 0x34 ||
-			   op2 == 0x35) {
-
-			/* sysenter, sysret */
+		case 0x05: /* syscall */
+		case 0x07: /* sysret */
+		case 0x34: /* sysenter */
+		case 0x35: /* sysexit */
 			*type = INSN_CONTEXT_SWITCH;
+			break;
 
-		} else if (op2 == 0x0b || op2 == 0xb9) {
-
-			/* ud2 */
+		case 0xff: /* ud0 */
+		case 0xb9: /* ud1 */
+		case 0x0b: /* ud2 */
 			*type = INSN_BUG;
+			break;
 
-		} else if (op2 == 0x0d || op2 == 0x1f) {
-
+		case 0x0d:
+		case 0x1f:
 			/* nopl/nopw */
 			*type = INSN_NOP;
+			break;
 
-		} else if (op2 == 0xa0 || op2 == 0xa8) {
-
-			/* push fs/gs */
+		case 0xa0: /* push fs */
+		case 0xa8: /* push gs */
 			*type = INSN_STACK;
 			op->src.type = OP_SRC_CONST;
 			op->dest.type = OP_DEST_PUSH;
+			break;
 
-		} else if (op2 == 0xa1 || op2 == 0xa9) {
-
-			/* pop fs/gs */
+		case 0xa1: /* pop fs */
+		case 0xa9: /* pop gs */
 			*type = INSN_STACK;
 			op->src.type = OP_SRC_POP;
 			op->dest.type = OP_DEST_MEM;
-		}
+			break;
+
+		case 0x3a:
+			/* 3 byte escape 0f 3a; SSE4 */
+			switch (op3) {
+			case 0xf0: break; /* exclude RORX */
+			default:
+				 *type = INSN_FPU;
+				 break;
+			}
+			break;
 
+		case 0x10 ... 0x17: /* SSE */
+		case 0x28 ... 0x2f: /* SSE */
+		case 0x50 ... 0x5f: /* SSE */
+		case 0x60 ... 0x77: /* MMX */
+		case 0x7a ... 0x7f: /* MMX */
+		case 0xc2:	    /* SSE */
+		case 0xc4 ... 0xc6: /* SSE */
+		case 0xd0 ... 0xfe: /* MMX */
+			*type = INSN_FPU;
+			break;
+
+		default:
+			break;
+		}
 		break;
 
 	case 0xc9:
@@ -414,6 +444,10 @@ int arch_decode_instruction(struct elf *
 
 		break;
 
+	case 0xd8 ... 0xdf: /* x87 FPU range */
+		*type = INSN_FPU;
+		break;
+
 	case 0xe3:
 		/* jecxz/jrcxz */
 		*type = INSN_JUMP_CONDITIONAL;
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1316,6 +1316,43 @@ static int read_unwind_hints(struct objt
 	return 0;
 }
 
+static int read_fpu_hints(struct objtool_file *file)
+{
+	struct section *sec;
+	struct instruction *insn;
+	struct rela *rela;
+
+	sec = find_section_by_name(file->elf, ".rela.discard.fpu_safe");
+	if (!sec)
+		return 0;
+
+	list_for_each_entry(rela, &sec->rela_list, list) {
+		if (rela->sym->type != STT_SECTION) {
+			WARN("unexpected relocation symbol type in %s", sec->name);
+			return -1;
+		}
+
+		insn = find_insn(file, rela->sym->sec, rela->addend);
+		if (!insn) {
+			WARN("bad .discard.fpu_safe entry");
+			return -1;
+		}
+
+		if (insn->type != INSN_FPU) {
+			WARN_FUNC("fpu_safe hint not an FPU instruction",
+				  insn->sec, insn->offset);
+//			return -1;
+		}
+
+		while (insn && insn->type == INSN_FPU) {
+			insn->fpu_safe = true;
+			insn = next_insn_same_func(file, insn);
+		}
+	}
+
+	return 0;
+}
+
 static int read_retpoline_hints(struct objtool_file *file)
 {
 	struct section *sec;
@@ -1422,6 +1459,10 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	ret = read_fpu_hints(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -2167,6 +2208,16 @@ static int validate_branch(struct objtoo
 			if (dead_end_function(file, insn->call_dest))
 				return 0;
 
+			if (insn->call_dest) {
+				if (!strcmp(insn->call_dest->name, "kernel_fpu_begin") ||
+				    !strcmp(insn->call_dest->name, "emulator_get_fpu"))
+					state.fpu = true;
+
+				if (!strcmp(insn->call_dest->name, "kernel_fpu_end") ||
+				    !strcmp(insn->call_dest->name, "emulator_put_fpu"))
+					state.fpu = false;
+			}
+
 			break;
 
 		case INSN_JUMP_CONDITIONAL:
@@ -2275,6 +2326,13 @@ static int validate_branch(struct objtoo
 			state.df = false;
 			break;
 
+		case INSN_FPU:
+			if (!state.fpu && !insn->fpu_safe) {
+				WARN_FUNC("FPU instruction outside of kernel_fpu_{begin,end}()", sec, insn->offset);
+				return 1;
+			}
+			break;
+
 		default:
 			break;
 		}
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -20,6 +20,7 @@ struct insn_state {
 	unsigned char type;
 	bool bp_scratch;
 	bool drap, end, uaccess, df;
+	bool fpu;
 	unsigned int uaccess_stack;
 	int drap_reg, drap_offset;
 	struct cfi_reg vals[CFI_NUM_REGS];
@@ -34,7 +35,7 @@ struct instruction {
 	enum insn_type type;
 	unsigned long immediate;
 	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
-	bool retpoline_safe;
+	bool retpoline_safe, fpu_safe;
 	u8 visited;
 	struct symbol *call_dest;
 	struct instruction *jump_dest;
