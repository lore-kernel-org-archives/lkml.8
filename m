Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D49EC33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E8E20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580469511;
	bh=kfksbVctjzkm9cOOLXTOESFvzM3fs9LV6pPtQoFVLmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wxGclQdhi4m4tapsGnojHj7VrjxduXT8zAlJCG0o7QyyvBFTuFCyTGOgtGqQBfDm/
	 7nkSfRRF5wrv52H9WV2SgS2dNxjmBq0bPQrigNESVdURzhysaut7JFQmQV3Uv0B35R
	 V/RZBl3T3CSKR/Z0I7TurJPDLUKYj6alL/O0/1HQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgAaLSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 06:18:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgAaLS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 06:18:29 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2566C20707;
        Fri, 31 Jan 2020 11:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580469509;
        bh=kfksbVctjzkm9cOOLXTOESFvzM3fs9LV6pPtQoFVLmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vZ7rnWZlXp3qRQJMGAb5dXXrK3h9eqVI1EAq8cOoQT1+57gnyX1fNJ/TgEHHuVG7D
         TA00ucPfJGpvv1jkS137NaXFfaPQGfE1BqHpfQfAvKfYIiPpJmsziReRrBooQ/+jkP
         zZdy0qb4tH84LrqdKCCpCShFwt2L6VSSyKDBVfD0=
Date:   Fri, 31 Jan 2020 11:18:24 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Rewrite Motorola MMU page-table layout
Message-ID: <20200131111824.GA4298@willie-the-truck>
References: <20200129103941.304769381@infradead.org>
 <8a81e075-d3bd-80c1-d869-9935fdd73162@linux-m68k.org>
 <20200131093813.GA3938@willie-the-truck>
 <20200131102239.GB14914@hirez.programming.kicks-ass.net>
 <20200131111459.GO14946@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131111459.GO14946@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 12:14:59PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 31, 2020 at 11:22:39AM +0100, Peter Zijlstra wrote:
> > On Fri, Jan 31, 2020 at 09:38:13AM +0000, Will Deacon wrote:
> > 
> > > > This series breaks compilation for the ColdFire (with MMU) variant of
> > > > the m68k family:
> > 
> > That's like the same I had reported by the build robots for sun3, which
> > I fixed by frobbing pgtable_t. That said, this is probably a more
> > consistent change.
> > 
> > One note below:
> > 
> > 
> > > -static inline struct page *pte_alloc_one(struct mm_struct *mm)
> > > +static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
> > >  {
> > >  	struct page *page = alloc_pages(GFP_DMA, 0);
> > >  	pte_t *pte;
> > > @@ -54,20 +55,19 @@ static inline struct page *pte_alloc_one(struct mm_struct *mm)
> > >  		return NULL;
> > >  	}
> > >  
> > > -	pte = kmap(page);
> > > -	if (pte) {
> > > -		clear_page(pte);
> > > -		__flush_page_to_ram(pte);
> > > -		flush_tlb_kernel_page(pte);
> > > -		nocache_page(pte);
> > > -	}
> > > -	kunmap(page);
> > > +	pte = page_address(page);
> > > +	clear_page(pte);
> > > +	__flush_page_to_ram(pte);
> > > +	flush_tlb_kernel_page(pte);
> > > +	nocache_page(pte);
> > 
> > See how it does the nocache dance ^
> 
> > So either, alloc_one() shouldn't either, or it's all buggered.
> 
> Damn, we weren't going to touch coldfire! :-))
> 
> So now I found the coldfire docs, and it looks like this thing is a
> software tlb-miss arch, so there is no reason what so ever for this to
> be nocache. I'll 'fix' that.

Does that mean we can drop the GFP_DMA too? If so, this all ends up
looking very similar to the sun3 code wrt alloc/free and they could
probably use the same implementation (since the generic code doesn't
like out pgtable_t definition).

Will
