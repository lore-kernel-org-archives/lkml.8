Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E536AC2BA16
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 03:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3588206F5
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 03:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586057993;
	bh=t2OD5FHHjwh/lbaTpLK43eSeF6L05/SSjVW++3rmqHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1xl5TaOjQqNGmk62PFYCHcBW8wfGA9UcTwefI6uk9Uv1KQdsniKHCWsAoj7HFRybk
	 Su51LZI37cyR3PosNeTVWBwXwY3nQfsCqUn6rbAM5XluvnGejONMslIwvfIFFRd4ol
	 bQl8gNBIpq1Vyc+WsI3g1fPOb4qYEI7pzoJO1lfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgDEDhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 23:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgDEDhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 23:37:23 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4735206D4;
        Sun,  5 Apr 2020 03:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586057841;
        bh=t2OD5FHHjwh/lbaTpLK43eSeF6L05/SSjVW++3rmqHY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xm4e+dyWvzwIIi6izY7mvVYKDJPfVkUGYLccfm7pBFLvtQtJvNUkqspFeFreRxSMi
         Nh5Z1gqYC0lSKHwMTWr1UKKF6YifHmRfAsll4fBwiQZlqFCv6rn41TKj9BVGX6uD8C
         m5CrYfRgP7yNsaXdWIaD2/f+dsB295qbm+rZRKT8=
Date:   Sun, 5 Apr 2020 12:37:12 +0900
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
Message-Id: <20200405123712.63d4d62e9f3ef25e339222bf@kernel.org>
In-Reply-To: <20200404143620.GM2452@worktop.programming.kicks-ass.net>
References: <CAG48ez2Sx4ELkM94aD_h_J7K7KBOeuGmvZLKRkg3n_f2WoZ_cg@mail.gmail.com>
        <4c5fe55d-9db9-2f61-59b2-1fb2e1b45ed0@amd.com>
        <20200402141308.GB20730@hirez.programming.kicks-ass.net>
        <20200403142837.f61a18d7bd32fd73777479ad@kernel.org>
        <20200403112113.GN20730@hirez.programming.kicks-ass.net>
        <20200404120808.05e9aa61500265be2e031bd6@kernel.org>
        <20200404143620.GM2452@worktop.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Apr 2020 16:36:20 +0200
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
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> With that I get a lot of warnings:
> 
>   FPU instruction outside of kernel_fpu_{begin,end}()
> 
> two random examples (x86-64-allmodconfig build):
> 
> arch/x86/xen/enlighten.o: warning: objtool: xen_vcpu_restore()+0x341: FPU instruction outside of kernel_fpu_{begin,end}()
> 
> $ ./objdump-func.sh defconfig-build/arch/x86/xen/enlighten.o xen_vcpu_restore | grep 341
> 0341  841:      0f 92 c3                setb   %bl
> 
> arch/x86/events/core.o: warning: objtool: x86_pmu_stop()+0x6d: FPU instruction outside of kernel_fpu_{begin,end}()
> 
> $ ./objdump-func.sh defconfig-build/arch/x86/events/core.o x86_pmu_stop | grep 6d
> 006d     23ad:  41 0f 92 c6             setb   %r14b
> 
> Which seems to suggest something goes wobbly with SETB, but I'm not
> seeing what in a hurry.

Yes, I also got same issue, please try the new one.

Thank you!

> 
> 
> ---
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -12,6 +12,13 @@
>  #define _ASM_X86_FPU_API_H
>  #include <linux/bottom_half.h>
> 
> +#define annotate_fpu() ({						\
> +	asm volatile("%c0:\n\t"						\
> +		     ".pushsection .discard.fpu_safe\n\t"		\
> +		     ".long %c0b - .\n\t"				\
> +		     ".popsection\n\t" : : "i" (__COUNTER__));		\
> +})
> +
>  /*
>   * Use kernel_fpu_begin/end() if you intend to use FPU in kernel context. It
>   * disables preemption so be careful if you intend to use it for long periods
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -437,6 +437,7 @@ static inline int copy_fpregs_to_fpstate
>  	 * Legacy FPU register saving, FNSAVE always clears FPU registers,
>  	 * so we have to mark them inactive:
>  	 */
> +	annotate_fpu();
>  	asm volatile("fnsave %[fp]; fwait" : [fp] "=m" (fpu->state.fsave));
> 
>  	return 0;
> @@ -462,6 +463,7 @@ static inline void copy_kernel_to_fpregs
>  	 * "m" is a random variable that should be in L1.
>  	 */
>  	if (unlikely(static_cpu_has_bug(X86_BUG_FXSAVE_LEAK))) {
> +		annotate_fpu();
>  		asm volatile(
>  			"fnclex\n\t"
>  			"emms\n\t"
> --- a/arch/x86/kernel/fpu/init.c
> +++ b/arch/x86/kernel/fpu/init.c
> @@ -38,7 +38,10 @@ static void fpu__init_cpu_generic(void)
>  		fpstate_init_soft(&current->thread.fpu.state.soft);
>  	else
>  #endif
> +	{
> +		annotate_fpu();
>  		asm volatile ("fninit");
> +	}
>  }
> 
>  /*
> @@ -61,6 +64,7 @@ static bool fpu__probe_without_cpuid(voi
>  	cr0 &= ~(X86_CR0_TS | X86_CR0_EM);
>  	write_cr0(cr0);
> 
> +	annotate_fpu();
>  	asm volatile("fninit ; fnstsw %0 ; fnstcw %1" : "+m" (fsw), "+m" (fcw));
> 
>  	pr_info("x86/fpu: Probing for FPU: FSW=0x%04hx FCW=0x%04hx\n", fsw, fcw);
> --- a/tools/objtool/arch.h
> +++ b/tools/objtool/arch.h
> @@ -27,6 +27,7 @@ enum insn_type {
>  	INSN_CLAC,
>  	INSN_STD,
>  	INSN_CLD,
> +	INSN_FPU,
>  	INSN_OTHER,
>  };
> 
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -92,6 +92,11 @@ int arch_decode_instruction(struct elf *
>  	*len = insn.length;
>  	*type = INSN_OTHER;
> 
> +	if (insn_is_fpu(&insn)) {
> +		*type = INSN_FPU;
> +		return 0;
> +	}
> +
>  	if (insn.vex_prefix.nbytes)
>  		return 0;
> 
> @@ -357,48 +362,54 @@ int arch_decode_instruction(struct elf *
> 
>  	case 0x0f:
> 
> -		if (op2 == 0x01) {
> -
> +		switch (op2) {
> +		case 0x01:
>  			if (modrm == 0xca)
>  				*type = INSN_CLAC;
>  			else if (modrm == 0xcb)
>  				*type = INSN_STAC;
> +			break;
> 
> -		} else if (op2 >= 0x80 && op2 <= 0x8f) {
> -
> +		case 0x80 ... 0x8f: /* Jcc */
>  			*type = INSN_JUMP_CONDITIONAL;
> +			break;
> 
> -		} else if (op2 == 0x05 || op2 == 0x07 || op2 == 0x34 ||
> -			   op2 == 0x35) {
> -
> -			/* sysenter, sysret */
> +		case 0x05: /* syscall */
> +		case 0x07: /* sysret */
> +		case 0x34: /* sysenter */
> +		case 0x35: /* sysexit */
>  			*type = INSN_CONTEXT_SWITCH;
> +			break;
> 
> -		} else if (op2 == 0x0b || op2 == 0xb9) {
> -
> -			/* ud2 */
> +		case 0xff: /* ud0 */
> +		case 0xb9: /* ud1 */
> +		case 0x0b: /* ud2 */
>  			*type = INSN_BUG;
> +			break;
> 
> -		} else if (op2 == 0x0d || op2 == 0x1f) {
> -
> +		case 0x0d:
> +		case 0x1f:
>  			/* nopl/nopw */
>  			*type = INSN_NOP;
> +			break;
> 
> -		} else if (op2 == 0xa0 || op2 == 0xa8) {
> -
> -			/* push fs/gs */
> +		case 0xa0: /* push fs */
> +		case 0xa8: /* push gs */
>  			*type = INSN_STACK;
>  			op->src.type = OP_SRC_CONST;
>  			op->dest.type = OP_DEST_PUSH;
> +			break;
> 
> -		} else if (op2 == 0xa1 || op2 == 0xa9) {
> -
> -			/* pop fs/gs */
> +		case 0xa1: /* pop fs */
> +		case 0xa9: /* pop gs */
>  			*type = INSN_STACK;
>  			op->src.type = OP_SRC_POP;
>  			op->dest.type = OP_DEST_MEM;
> -		}
> +			break;
> 
> +		default:
> +			break;
> +		}
>  		break;
> 
>  	case 0xc9:
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1316,6 +1316,43 @@ static int read_unwind_hints(struct objt
>  	return 0;
>  }
> 
> +static int read_fpu_hints(struct objtool_file *file)
> +{
> +	struct section *sec;
> +	struct instruction *insn;
> +	struct rela *rela;
> +
> +	sec = find_section_by_name(file->elf, ".rela.discard.fpu_safe");
> +	if (!sec)
> +		return 0;
> +
> +	list_for_each_entry(rela, &sec->rela_list, list) {
> +		if (rela->sym->type != STT_SECTION) {
> +			WARN("unexpected relocation symbol type in %s", sec->name);
> +			return -1;
> +		}
> +
> +		insn = find_insn(file, rela->sym->sec, rela->addend);
> +		if (!insn) {
> +			WARN("bad .discard.fpu_safe entry");
> +			return -1;
> +		}
> +
> +		if (insn->type != INSN_FPU) {
> +			WARN_FUNC("fpu_safe hint not an FPU instruction",
> +				  insn->sec, insn->offset);
> +//			return -1;
> +		}
> +
> +		while (insn && insn->type == INSN_FPU) {
> +			insn->fpu_safe = true;
> +			insn = next_insn_same_func(file, insn);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int read_retpoline_hints(struct objtool_file *file)
>  {
>  	struct section *sec;
> @@ -1422,6 +1459,10 @@ static int decode_sections(struct objtoo
>  	if (ret)
>  		return ret;
> 
> +	ret = read_fpu_hints(file);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
> 
> @@ -2167,6 +2208,16 @@ static int validate_branch(struct objtoo
>  			if (dead_end_function(file, insn->call_dest))
>  				return 0;
> 
> +			if (insn->call_dest) {
> +				if (!strcmp(insn->call_dest->name, "kernel_fpu_begin") ||
> +				    !strcmp(insn->call_dest->name, "emulator_get_fpu"))
> +					state.fpu = true;
> +
> +				if (!strcmp(insn->call_dest->name, "kernel_fpu_end") ||
> +				    !strcmp(insn->call_dest->name, "emulator_put_fpu"))
> +					state.fpu = false;
> +			}
> +
>  			break;
> 
>  		case INSN_JUMP_CONDITIONAL:
> @@ -2275,6 +2326,13 @@ static int validate_branch(struct objtoo
>  			state.df = false;
>  			break;
> 
> +		case INSN_FPU:
> +			if (!state.fpu && !insn->fpu_safe) {
> +				WARN_FUNC("FPU instruction outside of kernel_fpu_{begin,end}()", sec, insn->offset);
> +				return 1;
> +			}
> +			break;
> +
>  		default:
>  			break;
>  		}
> --- a/tools/objtool/check.h
> +++ b/tools/objtool/check.h
> @@ -20,6 +20,7 @@ struct insn_state {
>  	unsigned char type;
>  	bool bp_scratch;
>  	bool drap, end, uaccess, df;
> +	bool fpu;
>  	unsigned int uaccess_stack;
>  	int drap_reg, drap_offset;
>  	struct cfi_reg vals[CFI_NUM_REGS];
> @@ -34,7 +35,7 @@ struct instruction {
>  	enum insn_type type;
>  	unsigned long immediate;
>  	bool alt_group, dead_end, ignore, hint, save, restore, ignore_alts;
> -	bool retpoline_safe;
> +	bool retpoline_safe, fpu_safe;
>  	u8 visited;
>  	struct symbol *call_dest;
>  	struct instruction *jump_dest;
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
