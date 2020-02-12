Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F52C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD4E2073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I/9dgvSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgBLRpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:45:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57666 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLRpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uNOaA5HNUCUY+2AjgllicOxRDCeRftAbTQQQ3UaeRp0=; b=I/9dgvSz60x9zWB3SYkDusxqm7
        JcZoW2tLyJ7lQTuFqsWyuAYdNLZAZ/c+opjrlPVrKuaoVrxb8hg4BpMfNDIuC8841FcWCLIqbcvpI
        vfyRqoncY/ZMFUXb2/+EyMbQ9gr/t7IaFBUM5ezDUKGu0H/Ogy7QRySddf4U7fmqe2Mt1boiZY7tE
        6+nHxVjE//LRjtkxqxdvUqZph6nJHcSXLCsJyLOr+u3+wEp+5Xu4MS12B0Trsnd/JLo6m8yjvIhU4
        AtNR5s6+94jkoR4PoSoW78DNhlMMnvojkadRZ3c1/B/kbln6qBvQdPeFgk/QKSY7QlERJACoaoiey
        4Z16Yjfw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1w4h-00017t-5m; Wed, 12 Feb 2020 17:45:23 +0000
Date:   Wed, 12 Feb 2020 09:45:23 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/25] iomap: Support large pages in read paths
Message-ID: <20200212174523.GF7778@bombadil.infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-17-willy@infradead.org>
 <20200212081340.GD24497@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212081340.GD24497@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:13:40AM -0800, Christoph Hellwig wrote:
> > +/*
> > + * Estimate the number of vectors we need based on the current page size;
> > + * if we're wrong we'll end up doing an overly large allocation or needing
> > + * to do a second allocation, neither of which is a big deal.
> > + */
> > +static unsigned int iomap_nr_vecs(struct page *page, loff_t length)
> > +{
> > +	return (length + thp_size(page) - 1) >> page_shift(page);
> > +}
> 
> With the multipage bvecs a huge page (or any physically contigous piece
> of memory) will always use one or less (if merged into the previous)
> bio_vec.  So this can be simplified and optimized.

Oh, hm, right.  So what you really want here is for me to pass in the
number of thp pages allocated by the readahead operation.  rac->nr_pages
is the number of PAGE_SIZE pages, but we could have an rac->nr_segs
element as well.
