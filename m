Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9619C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3C920829
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597599834;
	bh=bqE1iqfMyAjA8fEzhnRGRBNdeXVZNubrkm4U2/bWM3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=st8Jhn2b0rhXl+/5UPgGaDmzkd+Apg2nmAhnOd2Uuk78M0I9TBQTjvK+OhcjbJXc0
	 D13Qu5xf87RiP+aCPJW5XdFcJNkok4Qf0A6mxA2MA53O6qCkpmXQj9BugRC0WaU1on
	 dGe03hQqN18lK4luxFnMe5gatdTCH5d1bnRQWp1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgHPRnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 13:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgHPRnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 13:43:51 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1A6A20829;
        Sun, 16 Aug 2020 17:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597599830;
        bh=bqE1iqfMyAjA8fEzhnRGRBNdeXVZNubrkm4U2/bWM3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yCUO1IGloRsvUPgBykcADjw3OiDi9XO0/7SBIX7O/x4Hae4xdOR4RPYSjlr9wqxbY
         7ly2vhDarRt8vh42qZKZOSe5eTj/M0jsGymhPPVKygLZ3uYokRz0oukRd8GnoJgNr4
         pHKmAuPe8UKr6+a8Xse1XCRVaXlFlxmoW5lwI0Og=
Date:   Sun, 16 Aug 2020 20:43:43 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>, Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] parisc: fix PMD pages allocation by restoring
 pmd_alloc_one()
Message-ID: <20200816174343.GK752365@kernel.org>
References: <20200816142403.15449-1-rppt@kernel.org>
 <20200816144209.GH17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200816144209.GH17456@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 03:42:09PM +0100, Matthew Wilcox wrote:
> On Sun, Aug 16, 2020 at 05:24:03PM +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Commit 1355c31eeb7e ("asm-generic: pgalloc: provide generic pmd_alloc_one()
> > and pmd_free_one()") converted parisc to use generic version of
> > pmd_alloc_one() but it missed the fact that parisc uses order-1 pages for
> > PMD.
> > 
> > Restore the original version of pmd_alloc_one() for parisc, just use
> > GFP_PGTABLE_KERNEL that implies __GFP_ZERO instead of GFP_KERNEL and
> > memset.
> > 
> > Fixes: 1355c31eeb7e ("asm-generic: pgalloc: provide generic pmd_alloc_one() and pmd_free_one()")
> > Repoerted-by: Meelis Roos <mroos@linux.ee>
> 
> typo, "Reported-by"

Helge,

I presume this is going via parisc tree, do you mind fixing up
while applying?

> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > Tested-by: Meelis Roos <mroos@linux.ee>
> > Link: https://lkml.kernel.org/r/9f2b5ebd-e4a4-0fa1-6cd3-4b9f6892d1ad@linux.ee 
> > ---
> > 
> > Hi,
> > 
> > I've trimmed the 'cc list relatively to the bug report and added parisc
> > maintainers.
> > 
> >  arch/parisc/include/asm/pgalloc.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
> > index cc7ecc2ef55d..a6482b2ce0ea 100644
> > --- a/arch/parisc/include/asm/pgalloc.h
> > +++ b/arch/parisc/include/asm/pgalloc.h
> > @@ -10,6 +10,7 @@
> >  
> >  #include <asm/cache.h>
> >  
> > +#define __HAVE_ARCH_PMD_ALLOC_ONE
> >  #define __HAVE_ARCH_PMD_FREE
> >  #define __HAVE_ARCH_PGD_FREE
> >  #include <asm-generic/pgalloc.h>
> > @@ -67,6 +68,11 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
> >  			(__u32)(__pa((unsigned long)pmd) >> PxD_VALUE_SHIFT)));
> >  }
> >  
> > +static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
> > +{
> > +	return (pmd_t *)__get_free_pages(GFP_PGTABLE_KERNEL, PMD_ORDER);
> > +}
> > +
> >  static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
> >  {
> >  	if (pmd_flag(*pmd) & PxD_FLAG_ATTACHED) {
> > -- 
> > 2.26.2
> > 

-- 
Sincerely yours,
Mike.
