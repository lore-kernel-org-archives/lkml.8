Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8953C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B88022070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vl9O8cXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgA2Mn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:43:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgA2Mn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jevnuIC5gZOp8gmdjzUHYbGt3WgdQxyaTB8XVPmRRP4=; b=Vl9O8cXT21pITlblL5uiZDvZY
        /S9Bmy7jPCHEK6ajpjhPBx4oDBUnbj9dUMhe1awhrh/uMflr1GVuscoFQ3heunMeuwUsEcTKaGQFx
        JD7RzlDWzxr3m4PWe/m1CxOq4lAyAefJDXDll0EJgM+RtbVMOsNrJ2QerGO9A273sHtL5AoVhSpW4
        oyy1v8+HsJeLT3kUfuq6hHy4QiSRUDYDVjcA1faIeZYPZ5ivn23PUFsuOEKQUJFLIGwapsxkX0AOs
        fO4qRvUsGstcp6Lw0omSpW3zwmgnY/SkMNRHuWnoRkHtviljbLVdA8DiExmyRJ/CvG1KGDg4iGBhk
        us8fT0X0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwmhG-0000bD-Gi; Wed, 29 Jan 2020 12:43:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 234053035D4;
        Wed, 29 Jan 2020 13:42:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DFECE2B7159FA; Wed, 29 Jan 2020 13:43:52 +0100 (CET)
Date:   Wed, 29 Jan 2020 13:43:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] m68k,mm: Extend table allocator for multiple sizes
Message-ID: <20200129124352.GP14879@hirez.programming.kicks-ass.net>
References: <20200129103941.304769381@infradead.org>
 <20200129104345.491163937@infradead.org>
 <20200129121752.GB31582@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129121752.GB31582@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 12:17:53PM +0000, Will Deacon wrote:
> On Wed, Jan 29, 2020 at 11:39:45AM +0100, Peter Zijlstra wrote:

> > +extern void *get_pointer_table(int type);
> 
> Could be prettier/obfuscated with an enum type?

Definitely, but then we get to bike-shed on names :-)

enum m68k_table_type {
	TABLE_BIG = 0,
	TABLE_SMALL,
};

Is not exactly _that_ much better, and while TABLE_PTE works,
TABLE_PGD_PMD is a bit crap.

> > --- a/arch/m68k/mm/memory.c
> > +++ b/arch/m68k/mm/memory.c

> > -pmd_t *get_pointer_table (void)
> > +void *get_pointer_table (int type)
> >  {
> > -	ptable_desc *dp = ptable_list.next;
> > -	unsigned char mask = PD_MARKBITS (dp);
> > -	unsigned char tmp;
> > -	unsigned int off;
> > +	ptable_desc *dp = ptable_list[type].next;
> > +	unsigned int mask, tmp, off;
> 
> nit, but if you do:
> 
> 	unsigned int mask = list_empty(&ptable_list[type]) ? 0 : PD_MARKBITS(dp);
> 
> then you can leave the existing mask logic as-is.

Indeed!
