Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0153EC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC6820740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2j2TeH/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgCYTlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:41:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38588 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYTlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A4m0ZPlZ5obZNWQXf/Gh81v44Z2dZ2lWdMjLJARw93o=; b=2j2TeH/fcS3veYk8MlAVFfrNY9
        NVsmTpfC8Py8Giv9Wp9JA00hC85v5ol0Di/AE4K7sRPP4pItlhuFoz6zHvf7Roj+NaJmp4+Ydf5ow
        tOt5qFIZjCRQvNR7TIBc3yM7meeDcQrjdOC629I79voE0rhhC6uEKGCrmNM5vFacbMTDtFZFszjsV
        wfimBFgU5T2Hh2nmbZSsqmI9EdMRAyIg13kgafcMYNAf5CHzk/cc6akYM+zIqKS52ZgrtdKVqgbe8
        KhhnwSd7e56qhwogXUIJ6lGRhI4HmgsZB3Gqcq/UTq/AVS4/03vlZAS1Xitg3mzcp00m1xBJWxtr8
        ctZeuymQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHBtf-0006Nk-3P; Wed, 25 Mar 2020 19:41:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 288843010C2;
        Wed, 25 Mar 2020 20:41:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 16FB720206085; Wed, 25 Mar 2020 20:41:00 +0100 (CET)
Date:   Wed, 25 Mar 2020 20:41:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     tglx@linutronix.de, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH v4 02/13] objtool: Factor out CFI hints
Message-ID: <20200325194100.GL20713@hirez.programming.kicks-ass.net>
References: <20200325174525.772641599@infradead.org>
 <20200325174605.455086309@infradead.org>
 <alpine.LSU.2.21.2003251924440.3128@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2003251924440.3128@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 07:26:06PM +0100, Miroslav Benes wrote:
> On Wed, 25 Mar 2020, Peter Zijlstra wrote:
> 
> > Move the application of CFI hints into it's own function.
> > No functional changes intended.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  tools/objtool/check.c |   67 ++++++++++++++++++++++++++++----------------------
> >  1 file changed, 38 insertions(+), 29 deletions(-)
> > 
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -2033,6 +2033,41 @@ static int validate_return(struct symbol
> >  	return 0;
> >  }
> >  
> > +static int apply_insn_hint(struct objtool_file *file, struct section *sec,
> > +			   struct symbol *func, struct instruction *insn,
> > +			   struct insn_state *state)
> > +{
> > +	if (insn->restore) {
> > +		struct instruction *save_insn, *i;
> > +
> > +		i = insn;
> > +		save_insn = NULL;
> > +		sym_for_each_insn_continue_reverse(file, func, i) {
> > +			if (i->save) {
> > +				save_insn = i;
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (!save_insn) {
> > +			WARN_FUNC("no corresponding CFI save for CFI restore",
> > +				  sec, insn->offset);
> > +			return 1;
> > +		}
> > +
> > +		if (!save_insn->visited) {
> > +			WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
> > +				  sec, insn->offset);
> > +			return 1;
> > +		}
> > +
> > +		insn->state = save_insn->state;
> > +	}
> > +
> > +	state = insn->state;
> 
> It does not matter, because it will change later again, but there should 
> be
> 
> *state = insn->state;
> 
> here, right?

Argh, yes.  Let me go edit the patches.
