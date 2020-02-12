Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB6EC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531F220658
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EZkB30n5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgBLHlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:41:06 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40212 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBLHlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k989yYEXmj70ZRBx8wkT7sfnvH6RVcXM9p5aAdTCTKk=; b=EZkB30n59fm83Nl+IMtCHrM0GQ
        YJ7UyPcfBVI5xAdxDqZbXwZItHSQ4zXBreG3TgnkDXI4uYy79zVx9su8fbKCUslAHxkSuwDiuwzNL
        F/i+O0A6L/DtiW+qY64KlmseNyy92gJ5uZtgBuF9RmOFq6EZcZ13iMOXyXCbw8LSQC3vDbv2ej+e8
        8oXwRn7YbOdIH2/bRjkXDkycLL0M4TMgRUsT89Qq0BWGV8POAf4DpUGIweT51VxvI+qyBAmZwBX/j
        vcq6yytio93qhA3QdZ31OFmiRFyiCsxWytZXxZEoluu8rQqEhRivQT8+MLlQsd3M0HWkRFTBKfq3G
        UinBg7oQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1mdt-00089e-N6; Wed, 12 Feb 2020 07:41:05 +0000
Date:   Tue, 11 Feb 2020 23:41:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/25] mm: Optimise find_subpage for !THP
Message-ID: <20200212074105.GE7068@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-3-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:22PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> If THP is disabled, find_subpage can become a no-op.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 75bdfec49710..0842622cca90 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -340,7 +340,7 @@ static inline struct page *find_subpage(struct page *page, pgoff_t offset)
>  
>  	VM_BUG_ON_PAGE(PageTail(page), page);
>  
> -	return page + (offset & (compound_nr(page) - 1));
> +	return page + (offset & (hpage_nr_pages(page) - 1));
>  }

So just above the quoted code is a

	if (PageHuge(page))
		return page;

So how can we get into a compound page that is not a huge page, but
only if THP is enabled?  (Yes, maybe I'm a little rusty on VM
internals).

Can you add comments describing the use case of this function and why
it does all these checks?  It looks like black magic to me.
