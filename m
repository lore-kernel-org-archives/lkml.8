Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD6AC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A9F20B80
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F5ul1L8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgD2PvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgD2PvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:51:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABF5C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NxBBFFm6MtwCSdPcYTRckA3NQsUn3OiyYrVi4AMqwnQ=; b=F5ul1L8C/XskogCvKJ7LlCJhxO
        aEbtYahfIeSU21RzUMsl9uZ5r10KqANOnR1jsEOW9tK4Cq3MBhpGKSBrSQVB9phdebLADYTGKOlH4
        VgStoiCqApU9zqGEWPJ7rcdX9WjI02fLZ8JdcW1pGCOWLIXve1N6yUg6hr5AkrADB3tcgk1GveKxO
        9VO5ndtowBnBFjzkofqJ2rF3jPSmRsmCrtIIfyURzmKfGZ98AH1F0M6gcOjUe+6bLPuPbXqLVzzvD
        xZmfy8U5d7ZgssyrtyGXEbUzpWW4AiifAGHsyzhDjCuW9PoLrICqF0sl+6Ky+umNJ/XoeVLQRfkN2
        pCIWfZbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTozP-0000df-GE; Wed, 29 Apr 2020 15:51:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC0143011E8;
        Wed, 29 Apr 2020 17:51:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C378620BD9729; Wed, 29 Apr 2020 17:51:09 +0200 (CEST)
Date:   Wed, 29 Apr 2020 17:51:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     jpoimboe@redhat.com, alexandre.chartre@oracle.com,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 02/14] objtool: Fix ORC vs alternatives
Message-ID: <20200429155109.GN13592@hirez.programming.kicks-ass.net>
References: <20200428191101.886208539@infradead.org>
 <20200428191659.499074346@infradead.org>
 <alpine.LSU.2.21.2004291622160.28992@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2004291622160.28992@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 04:33:31PM +0200, Miroslav Benes wrote:
> On Tue, 28 Apr 2020, Peter Zijlstra wrote:
> >  /*
> > + * Alternatives should not contain any ORC entries, this in turn means they
> > + * should not contain any CFI ops, which implies all instructions should have
> > + * the same same CFI state.
> > + *
> > + * It is possible to constuct alternatives that have unreachable holes that go
> > + * unreported (because they're NOPs), such holes would result in CFI_UNDEFINED
> > + * states which then results in ORC entries, which we just said we didn't want.
> > + *
> > + * Avoid them by copying the CFI entry of the first instruction into the whole
> > + * alternative.
> > + */
> > +static void fill_alternative_cfi(struct objtool_file *file, struct instruction *insn)
> > +{
> > +	struct instruction *first_insn = insn;
> > +	int alt_group = insn->alt_group;
> > +
> > +	sec_for_each_insn_continue(file, insn) {
> > +		if (insn->alt_group != alt_group)
> > +			break;
> > +		insn->cfi = first_insn->cfi;
> > +	}
> > +}
> 
> If I am reading this and previous patch correctly...
> 
> The function would copy cfi only to "orig" alternative (its insn->alts is 
> non-empty, orig_insn->alt_group differs from new_insn->alt_group), right? 

Yes.

> Would it make sense to do the same for "new" alternative, because of the 
> invariant? It seems to me it is not processed anywhere that way.

No.

> Am I missing something? Whenever I try to read all this alternatives 
> handling in objtool, I get lost pretty soon.

We only care about the ORC covering the original range, because that is
the range we execute code from. The memory where we store the
alternative instructions (.altinstruction section) is never executed,
that is, RIP should never point there, so we don't need ORC data covering
it.

