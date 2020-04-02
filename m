Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA869C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA14320784
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZLG/3RGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388322AbgDBONY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:13:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbgDBONX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=7A4IKcikn+x1j2WTaO4Cr1+STZDBvmtI9QKOvR01z/U=; b=ZLG/3RGsqPbg/eY3uPD5YeHqD2
        exVA6hJpuh8xIEwx5b1+oYMocjmTs6hPxuxWE9dDACCcHGHfUR0z4Ww/vj1J+psyi4nzHQNHDrgm4
        f08ui1AVYyUFExxl41PqD/0ORRYaAF6xpud3tSd1rpxfmgd3+TS2hzwpcPm7EKpR6WqMERxxIAiua
        koQWotBERut8gOp3mBs1Dljp9TaMImTHfTsmtG72jcEo09vFFHDqYbfpd8beVgpwYmQSpzpqp/1yO
        bQKpqmkTmvaM4sFPDAphtOLGlBA6fDb6u7Id1fyflCHof/AvXhgYTbXkM6GRuPrVT02+XKH2WGgmM
        ucy5I6pA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jK0al-00048p-A5; Thu, 02 Apr 2020 14:13:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 936793060FD;
        Thu,  2 Apr 2020 16:13:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A70E2B0AEC9C; Thu,  2 Apr 2020 16:13:08 +0200 (CEST)
Date:   Thu, 2 Apr 2020 16:13:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     Jann Horn <jannh@google.com>,
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
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        mhiramat@kernel.org
Subject: Re: AMD DC graphics display code enables -mhard-float, -msse, -msse2
 without any visible FPU state protection
Message-ID: <20200402141308.GB20730@hirez.programming.kicks-ass.net>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 09:33:54AM +0200, Christian König wrote:
> Hi Jann,
> 
> Am 02.04.20 um 04:34 schrieb Jann Horn:
> > [x86 folks in CC so that they can chime in on the precise rules for this stuff]
> > 
> > Hi!
> > 
> > I noticed that several makefiles under drivers/gpu/drm/amd/display/dc/
> > turn on floating-point instructions in the compiler flags
> > (-mhard-float, -msse and -msse2) in order to make the "float" and
> > "double" types usable from C code without requiring helper functions.
> > 
> > However, as far as I know, code running in normal kernel context isn't
> > allowed to use floating-point registers without special protection
> > using helpers like kernel_fpu_begin() and kernel_fpu_end() (which also
> > require that the protected code never blocks). If you violate that
> > rule, that can lead to various issues - among other things, I think
> > the kernel will clobber userspace FPU register state, and I think the
> > kernel code can blow up if a context switch happens at the wrong time,
> > since in-kernel task switches don't preserve FPU state.
> > 
> > Is there some hidden trick I'm missing that makes it okay to use FPU
> > registers here?
> > 
> > I would try testing this, but unfortunately none of the AMD devices I
> > have here have the appropriate graphics hardware...
> 
> yes, using the floating point calculations in the display code has been a
> source of numerous problems and confusion in the past.
> 
> The calls to kernel_fpu_begin() and kernel_fpu_end() are hidden behind the
> DC_FP_START() and DC_FP_END() macros which are supposed to hide the
> architecture depend handling for x86 and PPC64.
> 
> This originated from the graphics block integrated into AMD CPU (where we
> knew which fp unit we had), but as far as I know is now also used for
> dedicated AMD GPUs as well.
> 
> I'm not really a fan of this either, but so far we weren't able to convince
> the hardware engineers to not use floating point calculations for the
> display stuff.

Might I complain that:

	make O=allmodconfig-build drivers/gpu/drm/amd/display/dc/

does not in fact work?

Anyway, how do people feel about something like the below?

Masami, Boris, is there any semi-sane way we can have insn_is_fpu() ?
While digging through various opcode manuals is of course forever fun, I
do feel like it might not be the best way.

---
 arch/x86/include/asm/fpu/api.h      |  7 ++++
 arch/x86/include/asm/fpu/internal.h | 11 ++++++
 arch/x86/kernel/fpu/init.c          |  5 +++
 tools/objtool/arch.h                |  1 +
 tools/objtool/arch/x86/decode.c     | 71 ++++++++++++++++++++++++++-----------
 tools/objtool/check.c               | 58 ++++++++++++++++++++++++++++++
 tools/objtool/check.h               |  3 +-
 7 files changed, 134 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index b774c52e5411..b9bca1cdc875 100644
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
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 44c48e34d799..bc436213a0d4 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -102,6 +102,11 @@ static inline void fpstate_init_fxstate(struct fxregs_state *fx)
 }
 extern void fpstate_sanitize_xstate(struct fpu *fpu);
 
+#define _ASM_ANNOTATE_FPU(at)						\
+		     ".pushsection .discard.fpu_safe\n"			\
+		     ".long " #at " - .\n"				\
+		     ".popsection\n"					\
+
 #define user_insn(insn, output, input...)				\
 ({									\
 	int err;							\
@@ -116,6 +121,7 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
 		     "    jmp  2b\n"					\
 		     ".previous\n"					\
 		     _ASM_EXTABLE(1b, 3b)				\
+		     _ASM_ANNOTATE_FPU(1b)				\
 		     : [err] "=r" (err), output				\
 		     : "0"(0), input);					\
 	err;								\
@@ -131,6 +137,7 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
 		     "    jmp  2b\n"					\
 		     ".previous\n"					\
 		     _ASM_EXTABLE(1b, 3b)				\
+		     _ASM_ANNOTATE_FPU(1b)				\
 		     : [err] "=r" (err), output				\
 		     : "0"(0), input);					\
 	err;								\
@@ -140,6 +147,7 @@ extern void fpstate_sanitize_xstate(struct fpu *fpu);
 	asm volatile("1:" #insn "\n\t"					\
 		     "2:\n"						\
 		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_fprestore)	\
+		     _ASM_ANNOTATE_FPU(1b)				\
 		     : output : input)
 
 static inline int copy_fregs_to_user(struct fregs_state __user *fx)
@@ -197,6 +205,7 @@ static inline int copy_user_to_fregs(struct fregs_state __user *fx)
 
 static inline void copy_fxregs_to_kernel(struct fpu *fpu)
 {
+	annotate_fpu();
 	if (IS_ENABLED(CONFIG_X86_32))
 		asm volatile( "fxsave %[fx]" : [fx] "=m" (fpu->state.fxsave));
 	else
@@ -437,6 +446,7 @@ static inline int copy_fpregs_to_fpstate(struct fpu *fpu)
 	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
 	 * so we have to mark them inactive:
 	 */
+	annotate_fpu();
 	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
 
 	return 0;
@@ -462,6 +472,7 @@ static inline void copy_kernel_to_fpregs(union fpregs_state *fpstate)
 	 * "m" is a random variable that should be in L1.
 	 */
 	if (unlikely(static_cpu_has_bug(X86_BUG_FXSAVE_LEAK))) {
+		annotate_fpu();
 		asm volatile(
 			"fnclex\n\t"
 			"emms\n\t"
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 6ce7e0a23268..ca7890bd197c 100644
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
@@ -61,6 +64,7 @@ static bool fpu__probe_without_cpuid(void)
 	cr0 &= ~(X86_CR0_TS | X86_CR0_EM);
 	write_cr0(cr0);
 
+	annotate_fpu();
 	asm volatile("fninit ; fnstsw %0 ; fnstcw %1" : "+m" (fsw), "+m" (fcw));
 
 	pr_info("x86/fpu: Probing for FPU: FSW=0x%04hx FCW=0x%04hx\n", fsw, fcw);
@@ -101,6 +105,7 @@ static void __init fpu__init_system_mxcsr(void)
 		/* Static because GCC does not get 16-byte stack alignment right: */
 		static struct fxregs_state fxregs __initdata;
 
+		annotate_fpu();
 		asm volatile("fxsave %0" : "+m" (fxregs));
 
 		mask = fxregs.mxcsr_mask;
diff --git a/tools/objtool/arch.h b/tools/objtool/arch.h
index ced3765c4f44..e748ddc92958 100644
--- a/tools/objtool/arch.h
+++ b/tools/objtool/arch.h
@@ -27,6 +27,7 @@ enum insn_type {
 	INSN_CLAC,
 	INSN_STD,
 	INSN_CLD,
+	INSN_FPU,
 	INSN_OTHER,
 };
 
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index a62e032863a8..7be6e1384efb 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -92,8 +92,10 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 	*len = insn.length;
 	*type = INSN_OTHER;
 
-	if (insn.vex_prefix.nbytes)
+	if (insn.vex_prefix.nbytes) {
+		*type = INSN_FPU;
 		return 0;
+	}
 
 	op1 = insn.opcode.bytes[0];
 	op2 = insn.opcode.bytes[1];
@@ -357,48 +359,71 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
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
+		case 0x0b: /* ud2 */
+		case 0xb9: /* ud1 */
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
+		case 0xae:
+			/* insane!! */
+			if ((modrm_reg >= 0 && modrm_reg <= 3) && modrm_mod != 3 && !insn.prefixes.nbytes)
+				*type = INSN_FPU;
+			break;
 
+		case 0x10 ... 0x17:
+		case 0x28 ... 0x2f:
+		case 0x3a:
+		case 0x50 ... 0x77:
+		case 0x7a ... 0x7f:
+		case 0xc2:
+		case 0xc4 ... 0xc6:
+		case 0xd0 ... 0xff:
+			/* MMX, SSE, VMX */
+			*type = INSN_FPU;
+			break;
+
+		default:
+			break;
+		}
 		break;
 
 	case 0xc9:
@@ -414,6 +439,10 @@ int arch_decode_instruction(struct elf *elf, struct section *sec,
 
 		break;
 
+	case 0xd8 ... 0xdf: /* x87 FPU range */
+		*type = INSN_FPU;
+		break;
+
 	case 0xe3:
 		/* jecxz/jrcxz */
 		*type = INSN_JUMP_CONDITIONAL;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e3bb76358148..af6be584f6a5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1316,6 +1316,43 @@ static int read_unwind_hints(struct objtool_file *file)
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
@@ -1422,6 +1459,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_fpu_hints(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -2167,6 +2208,16 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
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
@@ -2275,6 +2326,13 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
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
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index f0ce8ffe7135..89c22bcdc64f 100644
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
