Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1112C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC980206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 15:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XvIAz7Jx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbgDBPEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:04:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47534 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388810AbgDBPEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=wUAIUHKPNY6CBj+ztvqtf2rjatWpCwWsKeO3Gq2tLe4=; b=XvIAz7Jx6tt/kXRu1RDERocUbP
        EnRazd+MeU/BGXmtllSpnJ/1gEwb8rcQqbwxWfC8uqPwNOXBG9NeY48SOUiHt0uZuHwfuQbpZe/8J
        rUq0P4tGcAgSxZlkzBRpGpx288B0IJx1yLYWUOMSDmmKrteSLWHzXkQu37Ec6E+SkxzFITI/aWGoq
        haqRieAyCUnZLtuF20qKZEwiQVmL8YAd5u+G6dG4jARxLRZCP1jdrBDmOXDNzYWpiWA5ILgKa10Yx
        seBuN6svqAb6LTXP2OeAJzr8OP7HxTBB8SJi1lSmQlzUFB8o9fPwhYW9LhgvexxYU/CkJr+kqbz3O
        ZpDcZkmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jK1O4-0003x0-SW; Thu, 02 Apr 2020 15:04:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 315F3305E45;
        Thu,  2 Apr 2020 17:04:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AB102B0DECD0; Thu,  2 Apr 2020 17:04:07 +0200 (CEST)
Date:   Thu, 2 Apr 2020 17:04:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Julien Thierry <jthierry@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH 3/7] objtool: Add support for intra-function calls
Message-ID: <20200402150407.GD20730@hirez.programming.kicks-ass.net>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-4-alexandre.chartre@oracle.com>
 <db508586-258a-0616-d649-e76e95df9611@redhat.com>
 <4e779423-395d-5e2e-b641-5604902bf096@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e779423-395d-5e2e-b641-5604902bf096@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 03:24:45PM +0200, Alexandre Chartre wrote:
> On 4/2/20 2:53 PM, Julien Thierry wrote:
> > On 4/2/20 9:22 AM, Alexandre Chartre wrote:

> > > +    sec = find_section_by_name(file->elf,
> > > +                   ".rela.discard.intra_function_call");
> > 
> > I'm wondering, do we really need to annotate the intra_function_call
> > and group the in a section?
> > 
> > Would it be a problem to consider all (static) call instructions with
> > a destination that is not the start offset of a symbol to be an
> > intra-function call (and set insn->intra_function_call and
> > insn->jump_dest accordingly)?
> 
> Correct, we could automatically detect intra-function calls instead of
> having to annotate them. However, I choose to annotate them because I don't
> think that's not an expected construct in a "normal" code flow (at least
> on x86). So objtool would still issue a warning on intra-function calls
> by default, and you can annotate them to indicate if they are expected.

I wondered the same thing when reading the patch. I'm confliected on
this. On the one hand auto-detecting this seems like an excellent idea.

If/when the compiler generates them, they had better be okay too.

Josh?
