Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1289BC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D332073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xg4US8EA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgBLINl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:13:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34404 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgBLINk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xZfWd1AJTNbOk+bHxFddhCEkeI06/CUELyUjy4uk11c=; b=Xg4US8EARSSirwDPiLRmi6pFg8
        Y8KP6yaDbZBjT/yx0qcM6BGzgIX4PwGmHse6ymcZeKuh56v8RoWo1DQliTHeYqMmnApT9ThTOjoJZ
        IVsIQwA6lBduQfWD0CmtX0lE1Meq+/VfJl7fq7ItZYhjJQlikAFej3HwC3Lx3+k2F4lX551cxIl46
        uNP0KBdRrrUHUFpormJ+sYXenWUTcaiqvn0HdIlqxkb3dWvuwcYKsFQA9hsPGa6/K4mg2X8ZCggN0
        Dk6nf6clFcmqH/JVTYE9vUqh3K5DyQYtsqqKVyWV8Q/+Hkd+BE+TxqVnm1SMswtJdRjVHa0VXMzUV
        gMMlu0MQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1n9Q-0005DC-8F; Wed, 12 Feb 2020 08:13:40 +0000
Date:   Wed, 12 Feb 2020 00:13:40 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/25] iomap: Support large pages in read paths
Message-ID: <20200212081340.GD24497@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-17-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-17-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * Estimate the number of vectors we need based on the current page size;
> + * if we're wrong we'll end up doing an overly large allocation or needing
> + * to do a second allocation, neither of which is a big deal.
> + */
> +static unsigned int iomap_nr_vecs(struct page *page, loff_t length)
> +{
> +	return (length + thp_size(page) - 1) >> page_shift(page);
> +}

With the multipage bvecs a huge page (or any physically contigous piece
of memory) will always use one or less (if merged into the previous)
bio_vec.  So this can be simplified and optimized.
