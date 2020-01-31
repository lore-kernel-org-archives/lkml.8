Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A29C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBC520707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AynFvpk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgAaLPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 06:15:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58100 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728342AbgAaLPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 06:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5OfgyaE20AJ017aVKU8rBOO0ddIOPKVfUp8Sgc1aLVg=; b=AynFvpk3cnMGqU5HpJhMwGbmW
        jljQKytJ7d9x9lLifRy+zW8YGdg+9W+DGyk0FN24JuLWl898qdNl/pzRxqvk/tE211SPowK7GR8lH
        526X0Oib8F8ckCLbrDNSvVxaNrBBEkpIea+Co8/JdNV98cNihh0Yjy59LMhIkKqD5rK545Y2fDxTa
        o9gEJMoJMlMvk8epgGDl7E0veCVFIKY8+qBYzFBHvUry09L9kwbczFnUcMKDJSJfFc4taikjM6CR9
        75S8FE6GB7HlfDKtgpz5QC0A2FqigZSSObAeO136BuEUYfmNO+ED4vVO11oiwSBFDgVtzHwype9dz
        l1cANlcBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixUGL-00062y-Iv; Fri, 31 Jan 2020 11:15:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CCBE3007F2;
        Fri, 31 Jan 2020 12:13:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5061A2014711C; Fri, 31 Jan 2020 12:14:59 +0100 (CET)
Date:   Fri, 31 Jan 2020 12:14:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Rewrite Motorola MMU page-table layout
Message-ID: <20200131111459.GO14946@hirez.programming.kicks-ass.net>
References: <20200129103941.304769381@infradead.org>
 <8a81e075-d3bd-80c1-d869-9935fdd73162@linux-m68k.org>
 <20200131093813.GA3938@willie-the-truck>
 <20200131102239.GB14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131102239.GB14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 11:22:39AM +0100, Peter Zijlstra wrote:
> On Fri, Jan 31, 2020 at 09:38:13AM +0000, Will Deacon wrote:
> 
> > > This series breaks compilation for the ColdFire (with MMU) variant of
> > > the m68k family:
> 
> That's like the same I had reported by the build robots for sun3, which
> I fixed by frobbing pgtable_t. That said, this is probably a more
> consistent change.
> 
> One note below:
> 
> 
> > -static inline struct page *pte_alloc_one(struct mm_struct *mm)
> > +static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
> >  {
> >  	struct page *page = alloc_pages(GFP_DMA, 0);
> >  	pte_t *pte;
> > @@ -54,20 +55,19 @@ static inline struct page *pte_alloc_one(struct mm_struct *mm)
> >  		return NULL;
> >  	}
> >  
> > -	pte = kmap(page);
> > -	if (pte) {
> > -		clear_page(pte);
> > -		__flush_page_to_ram(pte);
> > -		flush_tlb_kernel_page(pte);
> > -		nocache_page(pte);
> > -	}
> > -	kunmap(page);
> > +	pte = page_address(page);
> > +	clear_page(pte);
> > +	__flush_page_to_ram(pte);
> > +	flush_tlb_kernel_page(pte);
> > +	nocache_page(pte);
> 
> See how it does the nocache dance ^

> So either, alloc_one() shouldn't either, or it's all buggered.

Damn, we weren't going to touch coldfire! :-))

So now I found the coldfire docs, and it looks like this thing is a
software tlb-miss arch, so there is no reason what so ever for this to
be nocache. I'll 'fix' that.
