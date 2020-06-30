Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A547DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8064020723
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fXh+iFaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390096AbgF3ROC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388029AbgF3ROC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:14:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C0CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=h9dCCR3Sj6ij6SAKyMivwVidTMWb8VV+xdCxCmwqbSc=; b=fXh+iFaNONuimn4tWMRlR/6hmp
        NY/76oKPggzRBi/jIsdgk7mvxkr0cwOqMmnpVpVU5Q1+lDO+heYD0v6KI7lN2X2jo+d7eXCCCCeQR
        JsQzfndrVwIGu8KrfiV3lYN77kstxuFLTQlUGqXcIkpASY2Boh2233xagOBrkyGnSoBpROnzu+5Js
        cHoTDWjyZe8O7Yt/YOlbriW0qp3LBYN9FbDUYDUiFPgCu/AMchFgbWDiGDKhYZbCIeiDoxxMM/njk
        Y/8Ns5hf97hfID3VfOxJkSUcnPQQNFNTmCuaFZe2JF2B1X9W1EcVQoC3KE/qeC2cipS8AKuEjFkKL
        t+7HwSig==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqJpP-0003YN-Lz; Tue, 30 Jun 2020 17:13:52 +0000
Date:   Tue, 30 Jun 2020 18:13:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Long Li <lonuxli.64@gmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm, slab: Check GFP_SLAB_BUG_MASK before alloc_pages
 in kmalloc_order
Message-ID: <20200630171351.GO25523@casper.infradead.org>
References: <20200630145155.GA52108@lilong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630145155.GA52108@lilong>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 02:51:55PM +0000, Long Li wrote:
> In the ARM32 environment with highmem enabled. Using flag of kmalloc()
> with __GFP_HIGHMEM to allocate large memory, it will go through the
> kmalloc_order() path and return NULL. The __GFP_HIGHMEM flag will
> cause alloc_pages() to allocate highmem memory and pages cannot be
> directly converted to a virtual address, kmalloc_order() will return
> NULL and the page has been allocated.
> 
> After modification, GFP_SLAB_BUG_MASK has been checked before
> allocating pages, refer to the new_slab().
> 
> Signed-off-by: Long Li <lonuxli.64@gmail.com>
> ---
> 
> Changes in v2:
> - patch is rebased againest "[PATCH] mm: Free unused pages in
> kmalloc_order()" [1]
> - check GFP_SLAB_BUG_MASK and generate warnings before alloc_pages
> in kmalloc_order()
> 
> [1] https://lkml.org/lkml/2020/6/27/16
> 
>  mm/slab_common.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index a143a8c8f874..3548f4f8374b 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -27,6 +27,7 @@
>  #include <trace/events/kmem.h>
>  
>  #include "slab.h"
> +#include "internal.h"
>  
>  enum slab_state slab_state;
>  LIST_HEAD(slab_caches);
> @@ -815,6 +816,15 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
>  	void *ret = NULL;
>  	struct page *page;
>  
> +	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
> +		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
> +
> +		flags &= ~GFP_SLAB_BUG_MASK;
> +		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
> +				invalid_mask, &invalid_mask, flags, &flags);
> +		dump_stack();
> +	}
> +
>  	flags |= __GFP_COMP;

Oh, this is really good!  I hadn't actually looked at how slab/slub handle
GFP_SLAB_BUG_MASK.  If you don't mind though, I would suggest that this
code should all be in one place.  Perhaps:

gfp_t kmalloc_invalid_flags(gfp_t flags)
{
	gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;

	flags &= ~GFP_SLAB_BUG_MASK;
	pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
			invalid_mask, &invalid_mask, flags, &flags);
	dump_stack();

	return flags;
}

and then call it from the three places?

Also, the changelog could do with a bit of work.  Perhaps:

kmalloc cannot allocate memory from HIGHMEM.  Allocating large amounts of
memory currently bypasses the check and will simply leak the memory when
page_address() returns NULL.  To fix this, factor the GFP_SLAB_BUG_MASK
check out of slab & slub, and call it from kmalloc_order() as well.

