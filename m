Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67DFC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C812078A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="knb2OU/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgCXWLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:11:15 -0400
Received: from merlin.infradead.org ([205.233.59.134]:37142 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgCXWLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fg7lcfYPp/xvJSNTrWbhmzwZRat2kWak0mQQUbMiiP0=; b=knb2OU/H9TS/LRJlLmdm6jeiD9
        TgHfl6SsT3OOUpR6O7E2Ey/ZxxFi/x7ZpSvJ7yogSXlO7HXZwYDeg8H1r9KCDyPw8TZPoHtiYf2B/
        zneAl4qNdg2LYeZqC9DJWMzDqD9fTCW9G/uktf/hOshLKjmuos+4UFaDEEMKkvCz9/4RapOyFqQHq
        YanhGtQlzz2D9wJhIiRrAIcvhfKwPFFSJbUJaTxhGfqJr3vEdXqTNx1zhZsiRBMZk1siFNnbDBUEG
        hFt+QdTW8ucpF6q3Wjh+B6xzifICa6TdjGRszV0U8N79lkBf+8fXoOTqwmNF4o+KM8Vdv7p9UngSF
        3UM75bMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGrlP-0006Oc-BW; Tue, 24 Mar 2020 22:11:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9FCCA983502; Tue, 24 Mar 2020 23:11:09 +0100 (CET)
Date:   Tue, 24 Mar 2020 23:11:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 18/26] objtool: Fix !CFI insn_state propagation
Message-ID: <20200324221109.GU2452@worktop.programming.kicks-ass.net>
References: <20200324153113.098167666@infradead.org>
 <20200324160924.987489248@infradead.org>
 <20200324214006.tlanaff5q6gkgk2a@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324214006.tlanaff5q6gkgk2a@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 04:40:06PM -0500, Josh Poimboeuf wrote:
> On Tue, Mar 24, 2020 at 04:31:31PM +0100, Peter Zijlstra wrote:

> > +		if (!save_insn->visited) {
> > +			/*
> > +			 * Oops, no state to copy yet.
> > +			 * Hopefully we can reach this
> > +			 * instruction from another branch
> > +			 * after the save insn has been
> > +			 * visited.
> > +			 */
> > +			if (insn == first)
> > +				return 0; // XXX
> 
> Yeah, moving this code out to apply_insn_hint() seems like a nice idea,
> but it wouldn't be worth it if it breaks this case.  TBH I don't
> remember if this check was for a real-world case.  Might be worth
> looking at...  If this case doesn't exist in reality then we could just
> remove this check altogether.

I'll go run a bunch of builds with a print on it, that should tell us I
suppose.

> > +
> > +			WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
> > +					sec, insn->offset);
> > +			return 1;
> > +		}
> > +
> > +		insn->state = save_insn->state;
> > +	}
> > +
> > +	*state = insn->state;
> 
> This would have been easier to review if apply_insn_hint() were added in
> a separate patch.

27 it will be!

> > +
> > +	/* restore !CFI state */
> > +	state->df = old.df;
> > +	state->uaccess = old.uaccess;
> > +	state->uaccess_stack = old.uaccess_stack;
> 
> Maybe we should just move the CFI stuff into a state->cfi substruct.
> That would remove the need for these bits and probably also the comment
> above the insn_state declaration.

Indeed!
