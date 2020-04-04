Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB94C2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B03206F5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 14:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nHrGeW4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgDDOgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 10:36:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57468 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgDDOgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 10:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I+r4x9xNZsFWPlGZuxANeH7KhfgG+dmZr3efwChpjZ0=; b=nHrGeW4dN3kR6ZE9RShN4Xjat8
        WgyRgjI7qix21+1tQoPymXFmvCGxR7RZIKFti0FCCcbBcPIFyxIlsOJ4ytKugjbviP5yxuO3Aq2uf
        DGDNV5kZyfVtwZYNwQBRbHzfvLAC+RlYdiQ7mhYW0nKs8srPnNhkw3f/gQ/IoF87IFv3fP9fDglG1
        NUNegaIAcQlDNIhuRrBXIJgaTCso8NeOxAWGh4Vu72ZnWK9Q2n5sw/ljGjpdnFpXExQlfNAs+iQVP
        T1xESqjIr/BM1/d9euhgRtOmHYAEQAQJftMXo7Q6FQvFKdKsFpI8SLTa9V8AokYCPAnFNPH6aBj15
        3utuQ3rA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKjuJ-0003vD-77; Sat, 04 Apr 2020 14:36:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6F7659834EB; Sat,  4 Apr 2020 16:36:20 +0200 (CEST)
Date:   Sat, 4 Apr 2020 16:36:20 +0200
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
Message-ID: <20200404143620.GM2452@worktop.programming.kicks-ass.net>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
 <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
 <20200402141308.GB20730@hirez.programming.kicks-ass.net>
 <20200403142837.f61a18d7bd32fd73777479ad@kernel.org>
 <20200403112113.GN20730@hirez.programming.kicks-ass.net>
 <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 12:08:08PM +0900, Masami Hiramatsu wrote:
> From c609be0b6403245612503fca1087628655bab96c Mon Sep 17 00:00:00 2001
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Date: Fri, 3 Apr 2020 16:58:22 +0900
> Subject: [PATCH] x86: insn: Add insn_is_fpu()
> 
> Add insn_is_fpu(insn) which tells that the insn is
> whether touch the MMX/XMM/YMM register or the instruction
> of FP coprocessor.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

With that I get a lot of warnings:

  FPU instruction outside of kernel_fpu_{begin,end}()

two random examples (x86-64-allmodconfig build):

arch/x86/xen/enlighten.o: warning: objtool: xen_vcpu_restore()+0x341: FPU instruction outside of kernel_fpu_{begin,end}()

$ ./objdump-func.sh defconfig-build/arch/x86/xen/enlighten.o xen_vcpu_restore | grep 341
0341  841:      0f 92 c3                setb   %bl

arch/x86/events/core.o: warning: objtool: x86_pmu_stop()+0x6d: FPU instruction outside of kernel_fpu_{begin,end}()

$ ./objdump-func.sh defconfig-build/arch/x86/events/core.o x86_pmu_stop | grep 6d
006d     23ad:  41 0f 92 c6             setb   %r14b

Which seems to suggest something goes wobbly with SETB, but I'm not
seeing what in a hurry.


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
@@ -92,6 +92,11 @@ int arch_decode_instruction(struct elf *
 	*len = insn.length;
 	*type = INSN_OTHER;

+	if (insn_is_fpu(&insn)) {
+		*type = INSN_FPU;
+		return 0;
+	}
+
 	if (insn.vex_prefix.nbytes)
 		return 0;

@@ -357,48 +362,54 @@ int arch_decode_instruction(struct elf *

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

+		default:
+			break;
+		}
 		break;

 	case 0xc9:
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

