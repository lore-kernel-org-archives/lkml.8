Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FACC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B92207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593084392;
	bh=hAejMCZ5V4Itz6safoU3lHXHVMAX1y+HnT/O+QgGZmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CVp150WU9P0yVZL2e8L5WwQvIYFhy/nJ+xKfm7HqIYGtHqUG6J3AsQc7Yj633Euf/
	 5YnXlURAGib6AYVAhR76FOBIvbLZ1P2FG5+2MOQdV44kA+uIMFhh9PnTQ+or+mseni
	 iCrAE+9MgclxCVI/JHTwZ3vNOMKcKoRu5XXCRocQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404246AbgFYL0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:26:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37374 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404191AbgFYL0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:26:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id a6so5456108wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 04:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=etA55BCQ8iHeiBTCtackK2XXLQsF8u92csBraii8Z0g=;
        b=PamvVsLW2c67yg1TjQlXU41vqq1+4VozLHmDPLCfKhU8H8S7fDtfVyjk/kT/f8ubc8
         +xA1K5zEaEKYimJ3CRse0DDbpV0JGIWKigDW+VQAh6xPMctpUHLA3omz7MRMOGFX818l
         bLifAPi0EcotnbSNWF1wgzEucFNQWZfBsaflYKwa+0FpNY09K1WqEeQ4wqmltUBu3zuQ
         8RduCZmzKu+Yb3lu85wWqiG/PbWjySyUMqbkXeeIuUc7bXaUmIBOmWZOB11jQi+YTpdy
         /ISw5qsSR3ArEl8NjJF9BfMcHv7wQtKGfq19JMf+EipyGWTaNMUVEg429k+AKJa1oaG4
         OsEQ==
X-Gm-Message-State: AOAM531EzUZY708nI4Nm39OW5oGq3TCxInfuJpAQw+IeKVr68bvHvvgL
        dfUF3MsRSVRYmcqc5prqDmE=
X-Google-Smtp-Source: ABdhPJyLbM9iNUEmKIhXyovrrT9GOMTWMK+SpXo6pA9BoM+mz0gi/uIo97RxnAt0k0deI9x5hi0JAQ==
X-Received: by 2002:a5d:4b4f:: with SMTP id w15mr14681864wrs.84.1593084388098;
        Thu, 25 Jun 2020 04:26:28 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id y7sm26065629wrt.11.2020.06.25.04.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 04:26:27 -0700 (PDT)
Date:   Thu, 25 Jun 2020 13:26:25 +0200
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
Subject: Re: [PATCH v3 3/8] mm/hugetlb: unify migration callbacks
Message-ID: <20200625112625.GD1320@dhcp22.suse.cz>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-4-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592892828-1934-4-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-06-20 15:13:43, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There is no difference between two migration callback functions,
> alloc_huge_page_node() and alloc_huge_page_nodemask(), except
> __GFP_THISNODE handling. This patch adds an argument, gfp_mask, on
> alloc_huge_page_nodemask() and replace the callsite for
> alloc_huge_page_node() with the call to
> alloc_huge_page_nodemask(..., __GFP_THISNODE).
> 
> It's safe to remove a node id check in alloc_huge_page_node() since
> there is no caller passing NUMA_NO_NODE as a node id.

Yes this is indeed safe. alloc_huge_page_node used to be called from
other internal hugetlb allocation layer and that allowed NUMA_NO_NODE as
well. Now it is called only from the mempolicy migration callback and
that always specifies a node and want to stick with that node.

But I have to say I really dislike the gfp semantic because it is
different from any other allocation function I can think of. It
specifies what to be added rather than what should be used.

Removing the function is ok but please use the full gfp mask instead
or if that is impractical for some reason (wich shouldn't be the case
as htlb_alloc_mask should be trivial to make static inline) make it
explicit that this is not a gfp_mask but a gfp modifier and explicitly
state which modifiers are allowed.
 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  include/linux/hugetlb.h | 11 +++--------
>  mm/hugetlb.c            | 26 +++-----------------------
>  mm/mempolicy.c          |  9 +++++----
>  mm/migrate.c            |  5 +++--
>  4 files changed, 14 insertions(+), 37 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 50650d0..8a8b755 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -504,9 +504,8 @@ struct huge_bootmem_page {
>  
>  struct page *alloc_huge_page(struct vm_area_struct *vma,
>  				unsigned long addr, int avoid_reserve);
> -struct page *alloc_huge_page_node(struct hstate *h, int nid);
>  struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
> -				nodemask_t *nmask);
> +				nodemask_t *nmask, gfp_t gfp_mask);
>  struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
>  				unsigned long address);
>  struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
> @@ -759,13 +758,9 @@ static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
>  	return NULL;
>  }
>  
> -static inline struct page *alloc_huge_page_node(struct hstate *h, int nid)
> -{
> -	return NULL;
> -}
> -
>  static inline struct page *
> -alloc_huge_page_nodemask(struct hstate *h, int preferred_nid, nodemask_t *nmask)
> +alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
> +			nodemask_t *nmask, gfp_t gfp_mask)
>  {
>  	return NULL;
>  }
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d54bb7e..bd408f2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1979,30 +1979,10 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
>  }
>  
>  /* page migration callback function */
> -struct page *alloc_huge_page_node(struct hstate *h, int nid)
> -{
> -	gfp_t gfp_mask = htlb_alloc_mask(h);
> -	struct page *page = NULL;
> -
> -	if (nid != NUMA_NO_NODE)
> -		gfp_mask |= __GFP_THISNODE;
> -
> -	spin_lock(&hugetlb_lock);
> -	if (h->free_huge_pages - h->resv_huge_pages > 0)
> -		page = dequeue_huge_page_nodemask(h, gfp_mask, nid, NULL);
> -	spin_unlock(&hugetlb_lock);
> -
> -	if (!page)
> -		page = alloc_migrate_huge_page(h, gfp_mask, nid, NULL);
> -
> -	return page;
> -}
> -
> -/* page migration callback function */
>  struct page *alloc_huge_page_nodemask(struct hstate *h, int preferred_nid,
> -		nodemask_t *nmask)
> +		nodemask_t *nmask, gfp_t gfp_mask)
>  {
> -	gfp_t gfp_mask = htlb_alloc_mask(h);
> +	gfp_mask |= htlb_alloc_mask(h);
>  
>  	spin_lock(&hugetlb_lock);
>  	if (h->free_huge_pages - h->resv_huge_pages > 0) {
> @@ -2031,7 +2011,7 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
>  
>  	gfp_mask = htlb_alloc_mask(h);
>  	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
> -	page = alloc_huge_page_nodemask(h, node, nodemask);
> +	page = alloc_huge_page_nodemask(h, node, nodemask, 0);
>  	mpol_cond_put(mpol);
>  
>  	return page;
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index b9e85d4..f21cff5 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1068,10 +1068,11 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
>  /* page allocation callback for NUMA node migration */
>  struct page *alloc_new_node_page(struct page *page, unsigned long node)
>  {
> -	if (PageHuge(page))
> -		return alloc_huge_page_node(page_hstate(compound_head(page)),
> -					node);
> -	else if (PageTransHuge(page)) {
> +	if (PageHuge(page)) {
> +		return alloc_huge_page_nodemask(
> +			page_hstate(compound_head(page)), node,
> +			NULL, __GFP_THISNODE);
> +	} else if (PageTransHuge(page)) {
>  		struct page *thp;
>  
>  		thp = alloc_pages_node(node,
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6b5c75b..6ca9f0c 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1543,10 +1543,11 @@ struct page *new_page_nodemask(struct page *page,
>  	unsigned int order = 0;
>  	struct page *new_page = NULL;
>  
> -	if (PageHuge(page))
> +	if (PageHuge(page)) {
>  		return alloc_huge_page_nodemask(
>  				page_hstate(compound_head(page)),
> -				preferred_nid, nodemask);
> +				preferred_nid, nodemask, 0);
> +	}
>  
>  	if (PageTransHuge(page)) {
>  		gfp_mask |= GFP_TRANSHUGE;
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
