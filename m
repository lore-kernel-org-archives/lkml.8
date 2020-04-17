Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601C4C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41EC221D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgDQL3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:29:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:54828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730237AbgDQL3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 07:29:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A3C81ABEF;
        Fri, 17 Apr 2020 11:29:33 +0000 (UTC)
Date:   Fri, 17 Apr 2020 13:29:32 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        jthierry@redhat.com, alexandre.chartre@oracle.com
Subject: Re: [PATCH v5 02/17] objtool: Better handle IRET
In-Reply-To: <20200416115118.631224674@infradead.org>
Message-ID: <alpine.LSU.2.21.2004171326230.7737@pobox.suse.cz>
References: <20200416114706.625340212@infradead.org> <20200416115118.631224674@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020, Peter Zijlstra wrote:

> Teach objtool a little more about IRET so that we can avoid using the
> SAVE/RESTORE annotation. In particular, make the weird corner case in
> insn->restore go away.
> 
> The purpose of that corner case is to deal with the fact that
> UNWIND_HINT_RESTORE lands on the instruction after IRET, but that
> instruction can end up being outside the basic block, consider:
> 
> 	if (cond)
> 		sync_core()
> 	foo();
> 
> Then the hint will land on foo(), and we'll encounter the restore
> hint without ever having seen the save hint.
> 
> By teaching objtool about the arch specific exception frame size, and
> assuming that any IRET in an STT_FUNC symbol is an exception frame
> sized POP, we can remove the use of save/restore hints for this code.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/processor.h |    2 --
>  tools/objtool/arch.h             |    1 +
>  tools/objtool/arch/x86/decode.c  |   14 ++++++++++++--
>  tools/objtool/check.c            |   29 ++++++++++++++++-------------
>  4 files changed, 29 insertions(+), 17 deletions(-)
> 
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -727,7 +727,6 @@ static inline void sync_core(void)
>  	unsigned int tmp;
>  
>  	asm volatile (
> -		UNWIND_HINT_SAVE
>  		"mov %%ss, %0\n\t"
>  		"pushq %q0\n\t"
>  		"pushq %%rsp\n\t"
> @@ -737,7 +736,6 @@ static inline void sync_core(void)
>  		"pushq %q0\n\t"
>  		"pushq $1f\n\t"
>  		"iretq\n\t"
> -		UNWIND_HINT_RESTORE
>  		"1:"
>  		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
>  #endif
> --- a/tools/objtool/arch.h
> +++ b/tools/objtool/arch.h
> @@ -19,6 +19,7 @@ enum insn_type {
>  	INSN_CALL,
>  	INSN_CALL_DYNAMIC,
>  	INSN_RETURN,
> +	INSN_EXCEPTION_RETURN,
>  	INSN_CONTEXT_SWITCH,
>  	INSN_STACK,
>  	INSN_BUG,
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -435,9 +435,19 @@ int arch_decode_instruction(struct elf *
>  		*type = INSN_RETURN;
>  		break;
>  
> +	case 0xcf: /* iret */
> +		*type = INSN_EXCEPTION_RETURN;
> +
> +		/* add $40, %rsp */
> +		op->src.type = OP_SRC_ADD;
> +		op->src.reg = CFI_SP;
> +		op->src.offset = 5*8;
> +		op->dest.type = OP_DEST_REG;
> +		op->dest.reg = CFI_SP;
> +		break;
> +
>  	case 0xca: /* retf */
>  	case 0xcb: /* retf */
> -	case 0xcf: /* iret */
>  		*type = INSN_CONTEXT_SWITCH;
>  		break;
>  
> @@ -483,7 +493,7 @@ int arch_decode_instruction(struct elf *
>  
>  	*immediate = insn.immediate.nbytes ? insn.immediate.value : 0;
>  
> -	if (*type == INSN_STACK)
> +	if (*type == INSN_STACK || *type == INSN_EXCEPTION_RETURN)
>  		list_add_tail(&op->list, ops_list);
>  	else
>  		free(op);
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2080,15 +2080,14 @@ static int validate_return(struct symbol
>   * tools/objtool/Documentation/stack-validation.txt.
>   */
>  static int validate_branch(struct objtool_file *file, struct symbol *func,
> -			   struct instruction *first, struct insn_state state)
> +			   struct instruction *insn, struct insn_state state)
>  {
>  	struct alternative *alt;
> -	struct instruction *insn, *next_insn;
> +	struct instruction *next_insn;
>  	struct section *sec;
>  	u8 visited;
>  	int ret;
>  
> -	insn = first;
>  	sec = insn->sec;
>  
>  	if (insn->alt_group && list_empty(&insn->alts)) {
> @@ -2141,16 +2140,6 @@ static int validate_branch(struct objtoo
>  				}
>  
>  				if (!save_insn->visited) {
> -					/*
> -					 * Oops, no state to copy yet.
> -					 * Hopefully we can reach this
> -					 * instruction from another branch
> -					 * after the save insn has been
> -					 * visited.
> -					 */
> -					if (insn == first)
> -						return 0;
> -
>  					WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
>  						  sec, insn->offset);
>  					return 1;
> @@ -2243,6 +2232,20 @@ static int validate_branch(struct objtoo
>  
>  			break;
>  
> +		case INSN_EXCEPTION_RETURN:
> +			if (handle_insn_ops(insn, &state))
> +				return 1;
> +
> +			/*
> +			 * This handles x86's sync_core() case, where we use an
> +			 * IRET to self. All 'normal' IRET instructions are in
> +			 * STT_NOTYPE entry symbols.
> +			 */
> +			if (func)
> +				break;
> +
> +			return 0;
> +
>  		case INSN_CONTEXT_SWITCH:
>  			if (func && (!next_insn || !next_insn->hint)) {
>  				WARN_FUNC("unsupported instruction in callable function",

It looks really simple.

Have you tried Julien's proposal about removing INSN_STACK altogether, 
move the x86 to arch/x86/ and call handle_insn_ops() unconditionally, or 
have you just postponed it? As I said, I think it could be better in the 
long term, but the above looks good for now as well.

Miroslav
