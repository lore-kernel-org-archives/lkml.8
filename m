Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70240C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011E3206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v+sEGe7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732640AbgDARJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 13:09:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53506 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgDARJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LLLB/nPnohzXVBLw+q1F4J0kOnVDPE+oZqg1wawxsEc=; b=v+sEGe7RWdZZTVMC1WZ/Ezjx1Z
        o2svukRTC364w73gl1NriNlrjBe4KsJsvy7sBvloDNsQxgWONUdo023ZTqBNhODsDV81b6VdpLLQy
        hGhY9qoy/AIqLknyU9qYhNdihwk5qUxNXdn3FF6jIvm+wJnzzFM6DNNEzy642yfrkqFgyDdpb/KWG
        ZdJqDdX0WuryOm8POv+sL2drUYdHrkmsMyT8I+JlDJDbtUw4YOWTvJE5txCCuN5qbJwTrlBXEJ7aR
        DLlZ7Dd/eX9VcvQCnIs47MYCLB5zzDrOXMj1Xj6MJBf1qWJ60VRZNkYKvCCHQZ5I6yG6nrVVqqHWK
        9pn2YMKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJgra-0004U7-2M; Wed, 01 Apr 2020 17:09:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 375ED307524;
        Wed,  1 Apr 2020 19:09:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09B232042CFB8; Wed,  1 Apr 2020 19:09:11 +0200 (CEST)
Date:   Wed, 1 Apr 2020 19:09:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200401170910.GX20730@hirez.programming.kicks-ass.net>
References: <20200330170200.GU20713@hirez.programming.kicks-ass.net>
 <20200330190205.k5ssixd5hpshpjjq@treble>
 <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
 <20200331211755.pb7f3wa6oxzjnswc@treble>
 <20200331212040.7lrzmj7tbbx2jgrj@treble>
 <20200331222703.GH2452@worktop.programming.kicks-ass.net>
 <d2cad75e-1708-f0bf-7f88-194bcb29e61d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2cad75e-1708-f0bf-7f88-194bcb29e61d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:43:35PM +0100, Julien Thierry wrote:

> > +static bool has_modified_stack_frame(struct instruction *insn, struct insn_state *state)
> >   {
> > +	u8 ret_offset = insn->ret_offset;
> >   	int i;
> > 
> > -	if (state->cfa.base != initial_func_cfi.cfa.base ||
> > -	    state->cfa.offset != initial_func_cfi.cfa.offset ||
> > -	    state->stack_size != initial_func_cfi.cfa.offset ||
> > -	    state->drap)
> > +	if (state->cfa.base != initial_func_cfi.cfa.base || state->drap)
> > +		return true;
> > +
> > +	if (state->cfa.offset != initial_func_cfi.cfa.offset &&
> > +	    !(ret_offset && state->cfa.offset == initial_func_cfi.cfa.offset + ret_offset))
> 
> Isn't that the same thing as "state->cfa.offset !=
> initial_func_cfi.cfa.offset + ret_offset" ?

I'm confused on what cfa.offset is, sometimes it increase with
stack_size, sometimes it doesn't.

ISTR that for the ftrace case it was indeed cfa.offset + 8, but for the
IRET case below (where it is now not used anymore) it was cfa.offset
(not cfa.offset + 40, which I was expecting).

> > +		return true;
> > +
> > +	if (state->stack_size != initial_func_cfi.cfa.offset + ret_offset)
> >   		return true;
> > 
> > -	for (i = 0; i < CFI_NUM_REGS; i++)
> > +	for (i = 0; i < CFI_NUM_REGS; i++) {
> >   		if (state->regs[i].base != initial_func_cfi.regs[i].base ||
> >   		    state->regs[i].offset != initial_func_cfi.regs[i].offset)
> >   			return true;
> > +	}
> > 
> >   	return false;
> >   }

> > @@ -2185,6 +2148,13 @@ static int validate_branch(struct objtoo
> > 
> >   			break;
> > 
> > +		case INSN_EXCEPTION_RETURN:
> > +			if (func) {
> > +				state.stack_size -= arch_exception_frame_size;
> > +				break;
> 
> Why break instead of returning? Shouldn't an exception return mark the end
> of a branch (whether inside or outside a function) ?
> 
> Here it seems it will continue to the next instruction which might have been
> unreachable.

The code in question (x86's sync_core()), is an exception return to
self. It pushes an exception frame that points to right after the
exception return instruction.

This is the only usage of IRET in STT_FUNC symbols.

So rather than teaching objtool how to interpret the whole
push;push;push;push;push;iret sequence, teach it how big the frame is
(arch_exception_frame_size) and let it continue.

All the other (real) IRETs are in STT_NOTYPE in the entry assembly.

> > +			}
> > +
> > +			/* fallthrough */
> 
> What is the purpose of the fallthrough here? If the exception return was in
> a function, it carried on to the next instruction, so it won't use the
> WARN_FUNC(). So, if I'm looking at the right version of the code only the
> "return 0;" will be used. And, unless my previous comment is wrong, I'd
> argue that we should return both for func and !func.

That came from the fact that we split it out of INSN_CONTEXT_SWITCH.
You're right that it has now reduced to just return 0.

> >   		case INSN_CONTEXT_SWITCH:
> >   			if (func && (!next_insn || !next_insn->hint)) {
> >   				WARN_FUNC("unsupported instruction in callable function",



