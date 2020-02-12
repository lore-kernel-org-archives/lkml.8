Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6328C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9169F21739
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G4041bdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgBLRwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:52:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60560 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLRwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PC1JYyytBxzYVOWjA8HahlODsHQReOcYQHnl2qvSG/I=; b=G4041bdkHZ6mUZsGWvbHmafyzc
        d8eKGbikKMu1/Xs3Vqe19YzLl3Bc4o+/WsXU/5dPCcWBWTq57avYyMJBVo7HDek6/QMWnfeCw+suV
        PA1t+NZ9QDXVj+3SNEGLQRMv3wUIj2goGXRQeN7YL3IqICljs1egL/JFlg78R3bHPmltupujDXOOV
        mg44/ZCaRx+qFQTT/WuFlZ3yrT8O/GggnQHIT0wSGf0fgckbd8hsibPPqbi2opqVz3mwlktH2ZY5+
        a5QIEnYFgYTnaZ4AoG0SXjFcKQADdnZqPgRWpOazSvbj0J8M9WKPqR8Qk4EcYmGg+oUDbKoxOnOJ2
        cIuAvtDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1wBu-0003U1-93; Wed, 12 Feb 2020 17:52:50 +0000
Date:   Wed, 12 Feb 2020 09:52:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/25] mm: Optimise find_subpage for !THP
Message-ID: <20200212175250.GA11424@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-3-willy@infradead.org>
 <20200212074105.GE7068@infradead.org>
 <20200212130200.GC7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212130200.GC7778@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 05:02:00AM -0800, Matthew Wilcox wrote:
> > Can you add comments describing the use case of this function and why
> > it does all these checks?  It looks like black magic to me.
> 
> Would this help?
> 
> -static inline struct page *find_subpage(struct page *page, pgoff_t offset)
> +/*
> + * Given the page we found in the page cache, return the page corresponding
> + * to this offset in the file
> + */
> +static inline struct page *find_subpage(struct page *head, pgoff_t offset)
>  {
> -       if (PageHuge(page))
> -               return page;
> +       /* HugeTLBfs wants the head page regardless */
> +       if (PageHuge(head))
> +               return head;
>  
> -       VM_BUG_ON_PAGE(PageTail(page), page);
> +       VM_BUG_ON_PAGE(PageTail(head), head);
>  
> -       return page + (offset & (hpage_nr_pages(page) - 1));
> +       return head + (offset & (hpage_nr_pages(head) - 1));

Much better.
