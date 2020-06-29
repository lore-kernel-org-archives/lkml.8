Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AD8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1C520675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sk970az7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgF2Cna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 22:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgF2Cna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 22:43:30 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B661DC03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 19:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yQyPEA4fwxkaL2Sv58MpobbVI0aOCnfA9ig8/eIofc4=; b=Sk970az7hnYAcjWTyGRiUoVN9O
        tQtxlUTlo/8U5dc3sGFbFmflvvI2Wex6C9zPV7+J2Gkcc9UulOy4vL3t1O6rLgHOcSR2L5HYVFVoC
        jnupRvZRp8u78yS0A7oalZT7fRBlft4E4VVtN/Qrs24w4g81UUSDz0R1U0VvglyW2J7vymqsPbY1D
        b1Of+pOkbouxk4ZUag321o8xceZTyxKucZR2yDMXwKc++LHrTHech+P/vm4ItfZPw6IsjIHzECCj9
        yEx94aoZHo11vausSXGtPLPwK7cMB4ZMgmGPHL2Jsj2BnQmODaHiq76yV1gSM8JW1LmXwUDeAz7Bq
        Ef4rDsWw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpjl0-0002B1-0p; Mon, 29 Jun 2020 02:42:54 +0000
Date:   Mon, 29 Jun 2020 03:42:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Long Li <lonuxli.64@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm:free unused pages in kmalloc_order
Message-ID: <20200629024253.GB25523@casper.infradead.org>
References: <20200627045507.GA57675@lilong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627045507.GA57675@lilong>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 04:55:07AM +0000, Long Li wrote:
> Environment using the slub allocator, 1G memory in my ARM32.
> kmalloc(1024, GFP_HIGHUSER) can allocate memory normally,
> kmalloc(64*1024, GFP_HIGHUSER) will cause a memory leak, because
> alloc_pages returns highmem physical pages, but it cannot be directly
> converted into a virtual address and return NULL, the pages has not
> been released. Usually driver developers will not use the
> GFP_HIGHUSER flag to allocate memory in kmalloc, but I think this
> memory leak is not perfect, it is best to be fixed. This is the
> first time I have posted a patch, there may be something wrong.

Slab used to disallow GFP_HIGHMEM allocations earlier than this,
so you'd never get here.  See one moron's patch here, 20 years ago ...
https://lore.kernel.org/lkml/20001228145801.C19693@parcelfarce.linux.theplanet.co.uk/

Things changed a bit since then.  SLAB_LEVEL_MASK became GFP_SLAB_BUG_MASK,
then GFP_SLAB_BUG_MASK moved to mm/internal.h.  Nowadays, GFP_SLAB_BUG_MASK
is checked only in new_slab(), and it is definitely skipped when we go through
the kmalloc_large() patch.

Could you send a replacement patch which checks GFP_SLAB_BUG_MASK before
calling alloc_pages()?

> +++ b/mm/slab_common.c
> @@ -819,8 +819,12 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
>  	page = alloc_pages(flags, order);
>  	if (likely(page)) {
>  		ret = page_address(page);
> -		mod_node_page_state(page_pgdat(page), NR_SLAB_UNRECLAIMABLE_B,
> -				    PAGE_SIZE << order);
> +		if (ret)
> +			mod_node_page_state(page_pgdat(page),
> +					NR_SLAB_UNRECLAIMABLE_B,
> +					PAGE_SIZE << order);
> +		else
> +			__free_pages(page, order);
>  	}
>  	ret = kasan_kmalloc_large(ret, size, flags);
>  	/* As ret might get tagged, call kmemleak hook after KASAN. */
> -- 
> 2.17.1
> 
> 
