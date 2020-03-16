Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA154C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F90F20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 08:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ajZAHp96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbgCPIzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 04:55:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbgCPIzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 04:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yIz0C8cE2kr7lgSK5EW5SoifRX6h9DdJQZ/1L1Yr8aI=; b=ajZAHp96UGfDXYVzHNtI1elMuA
        JJ2vveSV/7WNqEUWX9314Zac4FvqjfzGg8VgxcXFhca9VuaHa/IIUl69hsZxGXS4bxSGOkT2vmLBj
        kxzCsLYabVJjY1YSx4Z/l/zhZJIxypw7Wh8y+FfdMhzBEC/zCF5VMNvzAoNXJlIYaAEv0ni2yLvtV
        wOSCx9rS196dfAup3I9rH6dVPFgirxoWINjLq8PefmR3IxvSY2085BFuMc0FKdeuOm/iUJKns1Uys
        I029B37TeZjhQFYhyjsXAs7JrZKf9pxkXtclN+A/sFpmu+Oa9bSB9z1bnba2ghpP40cwWuOzUZgTc
        dWn4mvKg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jDlX6-0004C9-20; Mon, 16 Mar 2020 08:55:36 +0000
Date:   Mon, 16 Mar 2020 01:55:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 2/3] mm/gup: fix omission of check on FOLL_LONGTERM in
 gup fast path
Message-ID: <20200316085536.GB1831@infradead.org>
References: <1584333244-10480-1-git-send-email-kernelfans@gmail.com>
 <1584333244-10480-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584333244-10480-3-git-send-email-kernelfans@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 12:34:03PM +0800, Pingfan Liu wrote:
> FOLL_LONGTERM is a special case of FOLL_PIN. It suggests a pin which is
> going to be given to hardware and can't move. It would truncate CMA
> permanently and should be excluded.
> 
> In gup slow path, slow path, where
> __gup_longterm_locked->check_and_migrate_cma_pages() handles FOLL_LONGTERM,
> but in fast path, there lacks such a check, which means a possible leak of
> CMA page to longterm pinned.
> 
> Place a check in try_grab_compound_head() in the fast path to fix the leak,
> and if FOLL_LONGTERM happens on CMA, it will fall back to slow path to
> migrate the page.
> 
> Some note about the check:
> Huge page's subpages have the same migrate type due to either
> allocation from a free_list[] or alloc_contig_range() with param
> MIGRATE_MOVABLE. So it is enough to check on a single subpage
> by is_migrate_cma_page(subpage)
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> To: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/gup.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 9df77b1..78132cf 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -89,6 +89,15 @@ static __maybe_unused struct page *try_grab_compound_head(struct page *page,
>  		int orig_refs = refs;
> 
>  		/*
> +		 * Huge page's subpages have the same migrate type due to either
> +		 * allocation from a free_list[] or alloc_contig_range() with
> +		 * param MIGRATE_MOVABLE. So it is enough to check on a subpage.
> +		 */
> +		if (unlikely(flags & FOLL_LONGTERM) &&
> +			is_migrate_cma_page(page))
> +			return NULL;

Wrong indentation.  We either align two tabs for continuation
statements, or after the opening brace of the previous line.  With a
likely or unlikely thrown in the former IMHO looks much better.  E.g.

		if (unlikely(flags & FOLL_LONGTERM) &&
				is_migrate_cma_page(page))
			return NULL;

