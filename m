Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B83CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 03:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF57C20723
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 03:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uQ4DOO+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgFGDIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 23:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgFGDIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 23:08:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F87C08C5C2;
        Sat,  6 Jun 2020 20:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gLx0oFTqTzuTph0zmnGYQpCnALOvQER933NotuJjbjs=; b=uQ4DOO+t1aAve27ytLL1YyVEUw
        J7MHx6VEhJJN6aPkOVbP/C2zgJo40/DhkCf2NIAyN3WruvgdI6VHwYo/2/V1lLlMTbr2bo70HKg4M
        fVqEE42W/B5Z5twy+9qmbCOkvGa3iIoFacHwa+Qb6c5OQS35AxLiSxbBCgBTJHqw0MkU1qm7dWy3U
        9YLvAXJJf4nmKN5gNsQ/0YLYHQtljA00b7bioHKmkDTLqCsCX+F7BN0kNRpnb23k4c0vEI4Zfm5UX
        4mO3UzqTlHCjjpH6GOvra0mSU+Iw030ZJDWVuVgZzeBH9sCLI9Cod26uiAMQWAQzRDuKgW8O6pCsg
        y90WIgxQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhlfz-0002SO-LG; Sun, 07 Jun 2020 03:08:47 +0000
Date:   Sat, 6 Jun 2020 20:08:47 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 17/25] mm: Add __page_cache_alloc_order
Message-ID: <20200607030847.GS19604@bombadil.infradead.org>
References: <20200429133657.22632-1-willy@infradead.org>
 <20200429133657.22632-18-willy@infradead.org>
 <CAHbLzkrEmEvVXmhPfngjkLP5iT_GH2SyRhDbHAiC7D2De8xyjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrEmEvVXmhPfngjkLP5iT_GH2SyRhDbHAiC7D2De8xyjw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 11:03:06AM -0700, Yang Shi wrote:
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index 55199cb5bd66..1169e2428dd7 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -205,15 +205,33 @@ static inline int page_cache_add_speculative(struct page *page, int count)
> >         return __page_cache_add_speculative(page, count);
> >  }
> >
> > +static inline gfp_t thp_gfpmask(gfp_t gfp)
> > +{
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +       /* We'd rather allocate smaller pages than stall a page fault */
> > +       gfp |= GFP_TRANSHUGE_LIGHT;
> 
> This looks not correct. GFP_TRANSHUGE_LIGHT may set GFP_FS, but some
> filesystem may expect GFP_NOFS, i.e. in readahead path.

Apologies, I overlooked this mail.

In one of the prerequisite patches for this patch set (which is now merged
as f2c817bed58d9be2051fad1d18e167e173c0c227), we call memalloc_nofs_save()
in the readahead path.  That ensures all allocations will have GFP_NOFS
set by the time the page allocator sees them.

Thanks for checking on this.
