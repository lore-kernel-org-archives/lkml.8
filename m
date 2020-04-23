Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423B3C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18758206EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BdTjEPIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgDWPWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729008AbgDWPWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:22:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB170C08ED7D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 08:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4ilAvDhDOvqIQ25q6T4G5QwEwvoEj4u+6Gav26YkiWI=; b=BdTjEPIvQUPYwBvuP5/jB1jIL0
        p/JiXpdgN5Knji4pj1QtL9t4lMWvI9leNIk8uuePPc+Ugrb2FzIURelHej0bs98D6GRqU+ILZrms8
        Aphpw63ToskiaFUgIVIISKy8Zwh0PS8e7T31dQu+5ukTsvgD103b7Ia+2yRXlOlbuYZ20uNKB2Ujp
        4pKiL4jA1leoMbGpTILK6j9sn99Pa9MT7hRETHwWybXSIgwsBXiicoJPT4x0aNEv7A6HN8o6N/oWu
        GGF22wG+1n4wdVF5ZJj3ynpwotNmLsz4nwr8/v4a95BUoQo+dXloTz0d1nGm2WtZiDbQCrGHo3Mxb
        tApH/wyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRdgc-0007Z7-3Q; Thu, 23 Apr 2020 15:22:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A36A3010C4;
        Thu, 23 Apr 2020 17:22:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42C1120BE6372; Thu, 23 Apr 2020 17:22:43 +0200 (CEST)
Date:   Thu, 23 Apr 2020 17:22:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     jpoimboe@redhat.com, alexandre.chartre@oracle.com,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH 4/8] objtool: Add support for intra-function calls
Message-ID: <20200423152243.GV20730@hirez.programming.kicks-ass.net>
References: <20200423125013.452964352@infradead.org>
 <20200423125042.794350465@infradead.org>
 <alpine.LSU.2.21.2004231619070.6520@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2004231619070.6520@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 04:34:21PM +0200, Miroslav Benes wrote:
> >  /*
> >   * Find the destination instructions for all calls.
> >   */
> > @@ -715,10 +725,7 @@ static int add_call_destinations(struct
> >  				continue;
> >  
> >  			if (!insn->call_dest) {
> > -				WARN_FUNC("unsupported intra-function call",
> > -					  insn->sec, insn->offset);
> > -				if (retpoline)
> > -					WARN("If this is a retpoline, please patch it in with alternatives and annotate it with ANNOTATE_NOSPEC_ALTERNATIVE.");
> > +				WARN_FUNC("intra-function call", insn->sec, insn->offset);
> 
> "unsupported intra-function call"?

Well, I think the thinking was that intra-function calls are actually
supported, 'unannotated' perhaps ?

> >  				return -1;
> >  			}
> >  
> > @@ -741,6 +748,12 @@ static int add_call_destinations(struct
> >  			}
> >  		} else
> >  			insn->call_dest = rela->sym;
> > +
> > +		/*
> > +		 * Whatever stack impact regular CALLs have, should be
> > +		 * undone by the RETURN of the called function.
> 
>  * Annotated intra-function CALLs are treated as JMPs with a stack_op.
>  * See read_intra_function_calls().
> 
> would make it a bit clearer.

That doesn't work for me; we want to explain why it is OK to delete
stack_ops for regular CALLs. The reason this is OK, is because they're
matched by RETURN.

> > +                */
> > +               remove_insn_ops(insn);
> >         }
> >  
> >         return 0;
> > @@ -1416,6 +1429,57 @@ static int read_instr_hints(struct objto
> >         return 0;
> >  }
> > 
> > +static int read_intra_function_calls(struct objtool_file *file)
> > +{
> > +       struct instruction *insn;
> > +       struct section *sec;
> > +       struct rela *rela;
> > +
> > +       sec = find_section_by_name(file->elf, ".rela.discard.intra_function_calls");
> > +       if (!sec)
> > +               return 0;
> > +
> > +       list_for_each_entry(rela, &sec->rela_list, list) {
> > +               unsigned long dest_off;
> > +
> > +               if (rela->sym->type != STT_SECTION) {
> > +                       WARN("unexpected relocation symbol type in %s",
> > +                            sec->name);
> > +                       return -1;
> > +               }
> > +
> > +               insn = find_insn(file, rela->sym->sec, rela->addend);
> > +               if (!insn) {
> > +                       WARN("bad .discard.intra_function_call entry");
> > +                       return -1;
> > +               }
> > +
> > +               if (insn->type != INSN_CALL) {
> > +                       WARN_FUNC("intra_function_call not a direct call",
> > +                                 insn->sec, insn->offset);
> > +                       return -1;
> > +               }
> > +
> > +               /*
> > +                * Treat intra-function CALLs as JMPs, but with a stack_op.
> > +                * Also see how setup_call_dest() strips stack_ops from normal
> > +                * CALLs.
> 
> /*
>  * Treat annotated intra-function CALLs as JMPs, but with a stack_op.
>  * Also see how add_call_destinations() strips stack_ops from normal
>  * CALLs.
>  */
> 
> ? (note added "annotated" and s/setup_call_dest/add_call_destinations/)

Unannotated intra-function calls are not allowed, so I don't see a
reason to make that distinction, but sure.

> > +                */
> > +               insn->type = INSN_JUMP_UNCONDITIONAL;
> 
> [...]
> 
> > @@ -2245,6 +2313,9 @@ static int validate_branch(struct objtoo
> >  				return 0;
> >  		}
> >  
> > +		if (handle_insn_ops(insn, &state))
> > +			return 1;
> > +
> >  		switch (insn->type) {
> >  
> >  		case INSN_RETURN:
> > @@ -2304,9 +2375,6 @@ static int validate_branch(struct objtoo
> >  			break;
> >  
> >  		case INSN_EXCEPTION_RETURN:
> > -			if (handle_insn_ops(insn, &state))
> > -				return 1;
> > -
> >  			/*
> >  			 * This handles x86's sync_core() case, where we use an
> >  			 * IRET to self. All 'normal' IRET instructions are in
> > @@ -2326,8 +2394,6 @@ static int validate_branch(struct objtoo
> >  			return 0;
> >  
> >  		case INSN_STACK:
> > -			if (handle_insn_ops(insn, &state))
> > -				return 1;
> >  			break;
> 
> So we could get rid of INSN_STACK now as Julien proposed, couldn't we? If 
> I am not missing something. handle_insn_ops() is called unconditionally 
> here for all insn types and you remove stack_ops when unneeded.

Yes, INSN_STACK can now go away in favour of NOPs with stack_ops.
Separate patch though.

> We could also go ahead with Julien's proposal to remove 
> INSN_EXCEPTION_RETURN hack and move it to tools/objtool/arch/x86/decode.c. 

I don't immediately see how; we don't have a symbol there.
