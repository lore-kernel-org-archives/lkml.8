Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F28C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 14:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9272A20657
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 14:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UveeSUgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgHPOmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 10:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgHPOmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 10:42:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09FDC061786;
        Sun, 16 Aug 2020 07:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Fi/5i+oI6s+PTOkb3E6yrfOZGSj+tbh+5f4ilJf9nLw=; b=UveeSUgbP1DWhLeC+lqEWp0X5j
        ndnA52j0HtpC7YRKQ8s//PCLdf3LirmH7KwNMG9xeVo54UNw1Rw0vAY94VSGFk2epX+AoAE8xSyRa
        OBnp6a80L7QgYMFXUlaLj4LuBvKW6KRvJhMkIT6XaKIuENs08LXVK7EELE7RyPFvXTgQCK7T9JCAZ
        75tmkOsmmcjNV4JC4m+u+DlWoOG4sWJhuLncD1r1G0Is9usTEBabY+gwR4eVgbRRnuMxgY/daZNyZ
        A7S9MgMb4OhAoTPTp6WekRtWoyIbhTkEcokCCOc7GaXqzslYPXfzZDW0e6Zlpt5c+eAAjx63SLHeB
        9HQDA8kQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7JrO-00076D-21; Sun, 16 Aug 2020 14:42:10 +0000
Date:   Sun, 16 Aug 2020 15:42:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Meelis Roos <mroos@linux.ee>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] parisc: fix PMD pages allocation by restoring
 pmd_alloc_one()
Message-ID: <20200816144209.GH17456@casper.infradead.org>
References: <20200816142403.15449-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200816142403.15449-1-rppt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 05:24:03PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Commit 1355c31eeb7e ("asm-generic: pgalloc: provide generic pmd_alloc_one()
> and pmd_free_one()") converted parisc to use generic version of
> pmd_alloc_one() but it missed the fact that parisc uses order-1 pages for
> PMD.
> 
> Restore the original version of pmd_alloc_one() for parisc, just use
> GFP_PGTABLE_KERNEL that implies __GFP_ZERO instead of GFP_KERNEL and
> memset.
> 
> Fixes: 1355c31eeb7e ("asm-generic: pgalloc: provide generic pmd_alloc_one() and pmd_free_one()")
> Repoerted-by: Meelis Roos <mroos@linux.ee>

typo, "Reported-by"

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Tested-by: Meelis Roos <mroos@linux.ee>
> Link: https://lkml.kernel.org/r/9f2b5ebd-e4a4-0fa1-6cd3-4b9f6892d1ad@linux.ee 
> ---
> 
> Hi,
> 
> I've trimmed the 'cc list relatively to the bug report and added parisc
> maintainers.
> 
>  arch/parisc/include/asm/pgalloc.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
> index cc7ecc2ef55d..a6482b2ce0ea 100644
> --- a/arch/parisc/include/asm/pgalloc.h
> +++ b/arch/parisc/include/asm/pgalloc.h
> @@ -10,6 +10,7 @@
>  
>  #include <asm/cache.h>
>  
> +#define __HAVE_ARCH_PMD_ALLOC_ONE
>  #define __HAVE_ARCH_PMD_FREE
>  #define __HAVE_ARCH_PGD_FREE
>  #include <asm-generic/pgalloc.h>
> @@ -67,6 +68,11 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
>  			(__u32)(__pa((unsigned long)pmd) >> PxD_VALUE_SHIFT)));
>  }
>  
> +static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
> +{
> +	return (pmd_t *)__get_free_pages(GFP_PGTABLE_KERNEL, PMD_ORDER);
> +}
> +
>  static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
>  {
>  	if (pmd_flag(*pmd) & PxD_FLAG_ATTACHED) {
> -- 
> 2.26.2
> 
