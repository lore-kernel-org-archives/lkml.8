Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B85C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E5B920728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDWOeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:34:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:50974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDWOeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:34:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CF1B1AB7F;
        Thu, 23 Apr 2020 14:34:21 +0000 (UTC)
Date:   Thu, 23 Apr 2020 16:34:21 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     jpoimboe@redhat.com, alexandre.chartre@oracle.com,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH 4/8] objtool: Add support for intra-function calls
In-Reply-To: <20200423125042.794350465@infradead.org>
Message-ID: <alpine.LSU.2.21.2004231619070.6520@pobox.suse.cz>
References: <20200423125013.452964352@infradead.org> <20200423125042.794350465@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  /*
>   * Find the destination instructions for all calls.
>   */
> @@ -715,10 +725,7 @@ static int add_call_destinations(struct
>  				continue;
>  
>  			if (!insn->call_dest) {
> -				WARN_FUNC("unsupported intra-function call",
> -					  insn->sec, insn->offset);
> -				if (retpoline)
> -					WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
> +				WARN_FUNC("intra-function call", insn->sec, insn->offset);

"unsupported intra-function call"?

>  				return -1;
>  			}
>  
> @@ -741,6 +748,12 @@ static int add_call_destinations(struct
>  			}
>  		} else
>  			insn->call_dest = rela->sym;
> +
> +		/*
> +		 * Whatever stack impact regular CALLs have, should be
> +		 * undone by the RETURN of the called function.

 * Annotated intra-function CALLs are treated as JMPs with a stack_op.
 * See read_intra_function_calls().

would make it a bit clearer.

> +                */
> +               remove_insn_ops(insn);
>         }
>  
>         return 0;
> @@ -1416,6 +1429,57 @@ static int read_instr_hints(struct objto
>         return 0;
>  }
> 
> +static int read_intra_function_calls(struct objtool_file *file)
> +{
> +       struct instruction *insn;
> +       struct section *sec;
> +       struct rela *rela;
> +
> +       sec = find_section_by_name(file->elf, ".rela.discard.intra_function_calls");
> +       if (!sec)
> +               return 0;
> +
> +       list_for_each_entry(rela, &sec->rela_list, list) {
> +               unsigned long dest_off;
> +
> +               if (rela->sym->type != STT_SECTION) {
> +                       WARN("unexpected relocation symbol type in %s",
> +                            sec->name);
> +                       return -1;
> +               }
> +
> +               insn = find_insn(file, rela->sym->sec, rela->addend);
> +               if (!insn) {
> +                       WARN("bad .discard.intra_function_call entry");
> +                       return -1;
> +               }
> +
> +               if (insn->type != INSN_CALL) {
> +                       WARN_FUNC("intra_function_call not a direct call",
> +                                 insn->sec, insn->offset);
> +                       return -1;
> +               }
> +
> +               /*
> +                * Treat intra-function CALLs as JMPs, but with a stack_op.
> +                * Also see how setup_call_dest() strips stack_ops from normal
> +                * CALLs.

/*
 * Treat annotated intra-function CALLs as JMPs, but with a stack_op.
 * Also see how add_call_destinations() strips stack_ops from normal
 * CALLs.
 */

? (note added "annotated" and s/setup_call_dest/add_call_destinations/)

> +                */
> +               insn->type = INSN_JUMP_UNCONDITIONAL;

[...]

> @@ -2245,6 +2313,9 @@ static int validate_branch(struct objtoo
>  				return 0;
>  		}
>  
> +		if (handle_insn_ops(insn, &state))
> +			return 1;
> +
>  		switch (insn->type) {
>  
>  		case INSN_RETURN:
> @@ -2304,9 +2375,6 @@ static int validate_branch(struct objtoo
>  			break;
>  
>  		case INSN_EXCEPTION_RETURN:
> -			if (handle_insn_ops(insn, &state))
> -				return 1;
> -
>  			/*
>  			 * This handles x86's sync_core() case, where we use an
>  			 * IRET to self. All 'normal' IRET instructions are in
> @@ -2326,8 +2394,6 @@ static int validate_branch(struct objtoo
>  			return 0;
>  
>  		case INSN_STACK:
> -			if (handle_insn_ops(insn, &state))
> -				return 1;
>  			break;

So we could get rid of INSN_STACK now as Julien proposed, couldn't we? If 
I am not missing something. handle_insn_ops() is called unconditionally 
here for all insn types and you remove stack_ops when unneeded.

We could also go ahead with Julien's proposal to remove 
INSN_EXCEPTION_RETURN hack and move it to tools/objtool/arch/x86/decode.c. 

Miroslav
