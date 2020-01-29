Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2FDC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEEB2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ekn/fv77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgA2MZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:25:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgA2MZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2lzi0tHBubjHqViQizllgApISf5JhzsXPp/MEyJKgUs=; b=Ekn/fv77FZ9oYggBLzpCcO+Iw
        iBh6nfljlN7CDXiRX3fW7XLOFnfWy7Iwu5Je9/P+Qgkf88eortsJlNBnqooWZG2GFTOX57higRi7N
        UbNG/fgo+ol6SCWDKnHfIB2AbYEE0fQYkdoYPA27eEIecZXLuG8JPMelqfT5eI7amiD3yOTeoYMnk
        Z3crrAKXM6PADBIb4Z4BPsHYexzMOcp2DRZuCXkWadzqWjOpNmIwzlWMmE+JQ8RWhVhgviep4MPRb
        dYF8vOb9bylBhHSW0rmiASVlUbVnApR98vN+JP5AJuPyIap1zYaW7dE3Nhoxz9KQyCyot+TMt23IY
        uL8OI61ww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwmOx-0003D9-Rd; Wed, 29 Jan 2020 12:25:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D898E30600B;
        Wed, 29 Jan 2020 13:23:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A48F4201F06FA; Wed, 29 Jan 2020 13:24:57 +0100 (CET)
Date:   Wed, 29 Jan 2020 13:24:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] m68k,mm: Use table allocator for pgtables
Message-ID: <20200129122457.GN14879@hirez.programming.kicks-ass.net>
References: <20200129103941.304769381@infradead.org>
 <20200129104345.434705552@infradead.org>
 <20200129121149.GA31582@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129121149.GA31582@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 12:11:50PM +0000, Will Deacon wrote:
> On Wed, Jan 29, 2020 at 11:39:44AM +0100, Peter Zijlstra wrote:

> > --- a/arch/m68k/include/asm/motorola_pgalloc.h
> > +++ b/arch/m68k/include/asm/motorola_pgalloc.h
> > @@ -10,60 +10,28 @@ extern int free_pointer_table(pmd_t *);
> >  
> >  static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> >  {
> > -	pte_t *pte;
> > -
> > -	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
> > -	if (pte) {
> > -		__flush_page_to_ram(pte);
> > -		flush_tlb_kernel_page(pte);
> > -		nocache_page(pte);
> > -	}
> > -
> > -	return pte;
> > +	return (pte_t *)get_pointer_table();
> 
> Weirdly, get_pointer_table() seems to elide the __flush_page_to_ram()
> call, so you're missing that for ptes with this change. I think it's
> probably needed for the higher levels too (and kernel_page_table()
> does it for example) so I'd be inclined to add it unconditionally
> rather than predicate it on the allocation type introduced by your later
> patch.

The next patch adds that unconditionally to the table allocator. The
only thing conditional on the type is the PG_PageTable and NR_PAGETABLES
accounting crud.

> > --- a/arch/m68k/include/asm/page.h
> > +++ b/arch/m68k/include/asm/page.h
> > @@ -30,7 +30,7 @@ typedef struct { unsigned long pmd; } pm
> >  typedef struct { unsigned long pte; } pte_t;
> >  typedef struct { unsigned long pgd; } pgd_t;
> >  typedef struct { unsigned long pgprot; } pgprot_t;
> > -typedef struct page *pgtable_t;
> > +typedef pte_t *pgtable_t;
> 
> Urgh, this is a big (cross-arch) mess that we should fix later.

Yes, I ran into this when I did those MMU-gather fixes as well. For this
patch I cribbed what s390 already does.

