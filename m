Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97692C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6304F20787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gB69s7S5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgCaUk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:40:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaUk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:40:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6tH+zODD2TY2pB32niBjLq/y3AZwAV0LHkQ0NlUifq8=; b=gB69s7S5OwB45mm/PZKHmhMo4W
        kxWuFeo47HVg2/SumgcIlbH3J3gCLNoi5H4Qx+12uT8nhmrghvzzAndedpoANR8dX9VLYmdVQJXQL
        T4SrmZqD1eX51M5gVjUg2Rn3SOs+EMkExA7k6KHVoOykgaoC57FnGbGoSDTirKCIokKLuy4mhfa/f
        mpQcTkd9HjviMuNsQRF6BeyQMyipCkBnkrL6l9t8SZP09VbsX6UHaYlZhsdbmmn/DoW9LE90ubHtQ
        Md7CBlwUYNfcH8bQT5YPVDtTYFamCDL1EmTkqcrxWmyFuQaU3Ta676Uqf8YANfMSDgKmNZ2adnf3G
        0hKtcjDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJNgo-0003iR-1h; Tue, 31 Mar 2020 20:40:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D918A98354A; Tue, 31 Mar 2020 22:40:47 +0200 (CEST)
Date:   Tue, 31 Mar 2020 22:40:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200331204047.GF2452@worktop.programming.kicks-ass.net>
References: <20200326113049.GD20696@hirez.programming.kicks-ass.net>
 <20200326135620.tlmof5fa7p5wct62@treble>
 <20200326154938.GO20713@hirez.programming.kicks-ass.net>
 <20200326195718.GD2452@worktop.programming.kicks-ass.net>
 <20200327010001.i3kebxb4um422ycb@treble>
 <20200330170200.GU20713@hirez.programming.kicks-ass.net>
 <20200330190205.k5ssixd5hpshpjjq@treble>
 <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331202315.zialorhlxmml6ec7@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 03:23:15PM -0500, Josh Poimboeuf wrote:
> On Tue, Mar 31, 2020 at 01:16:52PM +0200, Peter Zijlstra wrote:
> > Subject: objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
> > 
> > This replaces the SAVE/RESTORE hints with a RET_OFFSET hint that applies
> > to the following instructions:
> > 
> >  - any instruction that terminates a function, like: RETURN and sibling
> >    calls. It allows the stack-frame to be off by @sp_offset, ie. it
> >    allows stuffing the return stack.
> > 
> >  - EXCEPTION_RETURN (a new INSN_type that splits IRET out of
> >    CONTEXT_SWITCH) and here it denotes a @sp_offset sized POP and makes
> >    the instruction continue.
> 
> Looking closer, I see how my UNWIND_HINT_ADJUST idea doesn't work for
> the ftrace_regs_caller() case.  The ORC data is actually correct there.
> So basically we need a way to tell objtool to be quiet.

Right.

> I now understand what you're trying to do with the RET_TAIL thing, and I
> guess it's ok for the ftrace case.  But I'd rather an UNWIND_HINT_IGNORE
> before the tail cail, which would tell objtool to just silence the tail
> call warning.  It's simpler for the user to understand, it's simpler
> logic in objtool, and I think an "ignore warnings for the next insn"
> hint would be more generally applicable anyway.

I like how this is specific on how far the stack can be off, as opposed
so say 'ignore any warning on this instruction'.

Because by saying this RET should be +8, we'll still get a warning when
this is not the case (and in fact I should strengthen the patch to
implement that).

Also, you don't want to suppress any other valid warning at that
instruction.

Furthermore, I really don't think we ought to worry about ease-of-use
here, there's really not that many people writing x86 assembly.

> But also... the RET_OFFSET usage for sync_core() *really* bugs me.

Fair enough.

> I know you said it's like an indirect tail call with a bigger frame, but
> that's kind of stretching it because the function frame is still there.
> 
> And objtool doesn't treat it like a tail call at all.  In fact, it
> handles it *completely* differently from the normal ret-tail-call case.
> Instead of silencing a tail call warning, it adjusts the stack offset
> and continues the code path.
> 
> This basically adds *two* new hint types, while trying to call them the
> same thing.  There's no overlapping functionality between them in
> objtool, other than the use of the same insn->ret_offset variable.  But
> it's two distinct functionalities, depending on the context (return/tail
> vs IRETQ).

I'm not against adding a second/separate hint for this. In fact, I
almost considered teaching objtool how to interpret the whole IRET frame
so that we can do it without hints. It's just that that's too much code
for this one case.

HINT_IRET_SELF ?
