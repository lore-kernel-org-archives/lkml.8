Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598F7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C642074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594121483;
	bh=aUIVEVAXZbopFMRH3TGsLEtnnL4vBmzSRg0vOGqapQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A2/QI+RHhCxuMWwEMoB9rX1zTBiq6QTI4VQz74jwWID+pT7X/8ShcmPgK0QZQ/keR
	 dxXqPPRPrD8PZOPxqZ5vgccyuYQbnKpNWuoeGZDMzN6IO6e7z1AncK0U9RD5tnicGH
	 lbKyXtq+pRQIeTWE8h8BBwLADgCjqoyKIIfLIzNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgGGLbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:31:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36676 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGGLbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:31:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id k6so44781736wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=toA1Nevv1Y/0QdhHvMEudjFGAmi/53XiG4RbTAj5+K0=;
        b=ZjZ7SoCZYN7w4RMLvOvKrYrKd+8ZLW0Jyc3xo6MzG2QgO4ky7hb8w0ftkC4HzWyPzF
         folPCu1LVjVHkDmmiDL/zGBiB/FKme7jOgCB4BKNpY4ezNhz6GO57BxfEASnIhOwHe6P
         G5cxEL3LUXgFs0A6I5UMbsr5di/27mcKRBnw4T7mpS4Qk656ZIf6/nJpAKXaxBq0ynu/
         UUwR5G4T4p7OqvacI2EjzE13sHHrmojchEOad99bgzcXMruI8nGyXHiIsjA8QB7RI4Zd
         hJf08yXX56MqlYJIE/kpXc95l5QLxFaYi12CH7mbByK4NDYOMN0fh4pwZnvoHbuU7Jqd
         EdgQ==
X-Gm-Message-State: AOAM530qF867Iu5c/MmPx3KwpsT4zf/PoOJwhYfmoPtuAhxUKp17nhjU
        63idM0a0TbHod6NrvuEpS+Q=
X-Google-Smtp-Source: ABdhPJxo42/JcizNe97kE/wFAk45kbPAX4LbQ8fCJ/gE7Yu6LDTeW5hvofnItd66CbgtgK5zUTB7Mg==
X-Received: by 2002:a5d:4607:: with SMTP id t7mr57351198wrq.251.1594121479234;
        Tue, 07 Jul 2020 04:31:19 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id b10sm627955wmj.30.2020.07.07.04.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 04:31:18 -0700 (PDT)
Date:   Tue, 7 Jul 2020 13:31:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v4 04/11] mm/hugetlb: make hugetlb migration callback CMA
 aware
Message-ID: <20200707113116.GH5913@dhcp22.suse.cz>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-5-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594107889-32228-5-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-07-20 16:44:42, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> new_non_cma_page() in gup.c which try to allocate migration target page
> requires to allocate the new page that is not on the CMA area.
> new_non_cma_page() implements it by removing __GFP_MOVABLE flag.  This way
> works well for THP page or normal page but not for hugetlb page.
> 
> hugetlb page allocation process consists of two steps.  First is dequeing
> from the pool.  Second is, if there is no available page on the queue,
> allocating from the page allocator.
> 
> new_non_cma_page() can control allocation from the page allocator by
> specifying correct gfp flag.  However, dequeing cannot be controlled until
> now, so, new_non_cma_page() skips dequeing completely.  It is a suboptimal
> since new_non_cma_page() cannot utilize hugetlb pages on the queue so this
> patch tries to fix this situation.
> 
> This patch makes the deque function on hugetlb CMA aware and skip CMA
> pages if newly added skip_cma argument is passed as true.

I really dislike this as already mentioned in the previous version of
the patch. You are making hugetlb and only one part of its allocator a
special snowflake which is almost always a bad idea. Your changelog
lacks any real justification for this inconsistency.

Also by doing so you are keeping an existing bug that the hugetlb
allocator doesn't respect scope gfp flags as I have mentioned when
reviewing the previous version. That bug likely doesn't matter now but
it might in future and as soon as it is fixed all this is just a
pointless exercise.

I do not have energy and time to burn to repeat that argumentation to I
will let Mike to have a final word. Btw. you are keeping his acks even
after considerable changes to patches which I am not really sure he is
ok with.

> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

To this particular patch.
[...]

> diff --git a/mm/gup.c b/mm/gup.c
> index 5daadae..2c3dab4 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1630,11 +1630,12 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
>  #ifdef CONFIG_HUGETLB_PAGE
>  	if (PageHuge(page)) {
>  		struct hstate *h = page_hstate(page);
> +
>  		/*
>  		 * We don't want to dequeue from the pool because pool pages will
>  		 * mostly be from the CMA region.
>  		 */
> -		return alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
> +		return alloc_huge_page_nodemask(h, nid, NULL, gfp_mask, true);

Let me repeat that this whole thing is running under
memalloc_nocma_save. So additional parameter is bogus.
[...]
> -static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> +static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid, bool skip_cma)

If you really insist on an additional parameter at this layer than it
should be checking for the PF_MEMALLOC_NOCMA instead.

[...]
> @@ -1971,21 +1977,29 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
>  
>  /* page migration callback function */
>  struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
> -		nodemask_t *nmask, gfp_t gfp_mask)
> +		nodemask_t *nmask, gfp_t gfp_mask, bool skip_cma)
>  {
> +	unsigned int flags = 0;
> +	struct page *page = NULL;
> +
> +	if (skip_cma)
> +		flags = memalloc_nocma_save();

This is pointless for a scope that is already defined up in the call
chain and fundamentally this is breaking the expected use of the scope
API. The primary reason for that API to exist is to define the scope and
have it sticky for _all_ allocation contexts. So if you have to use it
deep in the allocator then you are doing something wrong.
-- 
Michal Hocko
SUSE Labs
