Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD030C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD4C2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QMMEHPi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgDFJlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:41:39 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33350 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgDFJlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eWD0h4HDJIC+j23RjV+nLrsJjqGzLhXKvD7tRceWp/E=; b=QMMEHPi1bthngWf2yz1q7kCfRJ
        FFhLDiGBJGLO175iwcsz0ES6qU5SeUEhqWiMyc7o3OdQn5Zhmz30HemWzCLsXfRir/JoUdUmfax7F
        YIQt5vQMBk3yrKnCLW3xd2/NeBdQi8D6EZPXfTEOhCnu0wwJVNXkfxfzae3AO2/VQWi5CpqgDvbv+
        8R8qNwmsA1prUXlUjj/5XbIfDiktpBjw7PlE/ziVJD1BqojXBA3CUv9ps7f7TVdP+Ci+spR5lL/ke
        vTitP1swSSvUJvEMZpBOk/w/A4IPk45m9+k6p4tkizSJJw2abRG4z8UnunmQYF/kGvMXFLC1dR6jn
        p2CKvipw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLOG3-0000Ak-5Y; Mon, 06 Apr 2020 09:41:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 980D0300478;
        Mon,  6 Apr 2020 11:31:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 81C312BAC6A6B; Mon,  6 Apr 2020 11:31:43 +0200 (CEST)
Date:   Mon, 6 Apr 2020 11:31:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Julien Thierry <jthierry@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
Message-ID: <20200406093143.GH20730@hirez.programming.kicks-ass.net>
References: <fc224792-bd1c-08ff-072f-e584740521b4@oracle.com>
 <a250f29d-969a-b704-6dd6-c6cc7b84f526@redhat.com>
 <20200402154022.GG20730@hirez.programming.kicks-ass.net>
 <bc3a31dc-9d59-5756-aad3-187533f05654@redhat.com>
 <20200403151757.lhhia7pzqptvlqz5@treble>
 <20200403154620.GS20730@hirez.programming.kicks-ass.net>
 <20200404133218.GL20760@hirez.programming.kicks-ass.net>
 <20200404142232.wpn7estahnabfy3z@treble>
 <20200404155126.GF20730@hirez.programming.kicks-ass.net>
 <27f433a3-6109-9831-5292-3df4155e10fb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27f433a3-6109-9831-5292-3df4155e10fb@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 10:19:56AM +0200, Alexandre Chartre wrote:
> 
> On 4/4/20 5:51 PM, Peter Zijlstra wrote:
> > On Sat, Apr 04, 2020 at 09:22:32AM -0500, Josh Poimboeuf wrote:
> > > On Sat, Apr 04, 2020 at 03:32:18PM +0200, Peter Zijlstra wrote:
> > > > On Fri, Apr 03, 2020 at 05:46:20PM +0200, Peter Zijlstra wrote:
> > > > > On Fri, Apr 03, 2020 at 10:17:57AM -0500, Josh Poimboeuf wrote:
> > > > > > Peter, I think my previous idea for UNWIND_HINT_ADJUST stack_add=8 would
> > > > > > work here?
> > > > > 
> > > > > Yes, it would.
> > > > 
> > > > Sorry, I have reconsidered. While it will shut up objtool, it will not
> > > > 'work'. That is, the ORC data generated will not correctly unwind.
> > > > 
> > > > I'll try and write a longer email tonight.
> > > 
> > > Right, that's what I've been trying to say.  The ORC data will be
> > > non-deterministic unless we unroll the loop.  Or did you mean something
> > > else?
> > 
> > The below should result in deterministic code.
> > 
> > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> > index 07e95dcb40ad..109ee65f4a11 100644
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -59,8 +59,8 @@
> >   	jmp	775b;				\
> >   774:						\
> >   	dec	reg;				\
> > -	jnz	771b;				\
> > -	add	$(BITS_PER_LONG/8) * nr, sp;
> > +	add	$(BITS_PER_LONG/8) * $2, sp;	\
> > +	jnz	771b;
> >   #ifdef __ASSEMBLY__
> 
> Nice. This works fine and allows to remove ANNOTATE_NOSPEC_ALTERNATIVE when
> using __FILL_RETURN_BUFFER. However this is probably less performant because
> we now have nr/2 add instructions instead of just 1.

Does it actually matter though? That is, can you measure the difference?
