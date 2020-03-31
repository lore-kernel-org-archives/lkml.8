Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00988C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B36207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 21:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gCFMJoI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbgCaVHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:07:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51726 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgCaVHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TdKLErdYAhpy+aevf+rPoQWJBOmm5AFEN10IJcqqdTA=; b=gCFMJoI5t1iLIbrbakBPfey08z
        r4FSRSNoq+3IjxCH6HfkCgcD3t0IikcK57Uxd2OVPkAj86HJbGfXxW9kJX/Na6iTquXJDPrpzT4jl
        6WdvpYy7SVc9hdokiiYPKSvick4f5e13cervutSgE+62Rcayfd4phdInk5HqnWXwhRFHKfVZWKrPK
        Y4FG8hUXpwu9icbvoTJpDysml7UjaN3JyfwRRSYNs17lzEde3eEB9w/1P/M8DBivCR1UKFDt0s5JI
        KWBwpeR+1JZ4QKaNglBpR+bHh4kEb/IgfZlxRnwoBoljiDZwndCOisJxo6jm+XsH60wb2sWCEVMJn
        aK+NcPbA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJO6V-0005iL-8I; Tue, 31 Mar 2020 21:07:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 692A098354A; Tue, 31 Mar 2020 23:07:20 +0200 (CEST)
Date:   Tue, 31 Mar 2020 23:07:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH] objtool,ftrace: Implement UNWIND_HINT_RET_OFFSET
Message-ID: <20200331210720.GG2452@worktop.programming.kicks-ass.net>
References: <20200326135620.tlmof5fa7p5wct62@treble>
 <20200326154938.GO20713@hirez.programming.kicks-ass.net>
 <20200326195718.GD2452@worktop.programming.kicks-ass.net>
 <20200327010001.i3kebxb4um422ycb@treble>
 <20200330170200.GU20713@hirez.programming.kicks-ass.net>
 <20200330190205.k5ssixd5hpshpjjq@treble>
 <20200330200254.GV20713@hirez.programming.kicks-ass.net>
 <20200331111652.GH20760@hirez.programming.kicks-ass.net>
 <20200331202315.zialorhlxmml6ec7@treble>
 <20200331204047.GF2452@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331204047.GF2452@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:40:47PM +0200, Peter Zijlstra wrote:
> On Tue, Mar 31, 2020 at 03:23:15PM -0500, Josh Poimboeuf wrote:

> > I now understand what you're trying to do with the RET_TAIL thing, and I
> > guess it's ok for the ftrace case.  But I'd rather an UNWIND_HINT_IGNORE
> > before the tail cail, which would tell objtool to just silence the tail
> > call warning.  It's simpler for the user to understand, it's simpler
> > logic in objtool, and I think an "ignore warnings for the next insn"
> > hint would be more generally applicable anyway.
> 
> I like how this is specific on how far the stack can be off, as opposed
> so say 'ignore any warning on this instruction'.
> 
> Because by saying this RET should be +8, we'll still get a warning when
> this is not the case (and in fact I should strengthen the patch to
> implement that).

Like this; I'm confused on what cfa.offset is vs stack_size though.

But this way we're strict and always warn when the unexpected happens.

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1423,8 +1423,7 @@ static bool has_modified_stack_frame(str
 	    !(ret_offset && state->cfa.offset == initial_func_cfi.cfa.offset + ret_offset))
 		return true;
 
-	if (state->stack_size != initial_func_cfi.cfa.offset &&
-	    !(ret_offset && state->stack_size == initial_func_cfi.cfa.offset + ret_offset))
+	if (state->stack_size != initial_func_cfi.cfa.offset + ret_offset)
 		return true;
 
 	for (i = 0; i < CFI_NUM_REGS; i++) {

