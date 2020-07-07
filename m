Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE2EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F3220702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594120772;
	bh=BcSQgCWnhWikNq5tkZQ5by1N3fSxTtIs4NLJEjvfe2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xeHqXwzZbZdOG1BDGsnGrryOGmvJY+wwJ5IJpjiunrCO9L7+RfuXCXEgqpikScoWI
	 5eA3HOD3f75+UExpST0ZCmuze8Nc/g96ythTh281EUz0ACFU9js2gXgUkrL4EMZd7r
	 uo4xrnryBCcBmI77LQtgmjRRTXL4BXE6cJk0yPAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgGGLTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:19:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50239 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGLTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:19:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id l17so42878563wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c8k1Z32379Bnox8Ze8fWmCnDWiVdpTvUVOFS77fbrFk=;
        b=nb+gKHWKfkKQX3tAXJziveP+ltm+aCFpoKGSfKa0Cbii0yk+bfM/N01js/pE2jrU7d
         lz1DqwyAXMKyz3wFguS9B6OIAzamq78F+KyMzOrEMQaJoWY6YKyyO8X+uUNohzXrdf5W
         3dmt0yvzyH7PbXnVyZjM4Puf1z7uouHHwzMgaodIGxbRkgQ2xd/7m7h3+DFTQdt2Xrys
         DdLElEXmzgCUawyQvjrvMo2jG3wzaUxWrt8RAMxuiA3XncCzHahuXU0J3Y+c+BmpF/L1
         beB+kScnMcqN20ZGQ1/nZ/A1TXpJta7tmfFuLNOxU92D1okmRxyltJ2GugnAn+Yca7hC
         a/9Q==
X-Gm-Message-State: AOAM530XWpWiNWycn8HwtFEybXT30UQdcQHkbtaUvdn0VcVjTj8mfXvP
        I7eu4Vqp6FQ72DTrio8YOemDufVF
X-Google-Smtp-Source: ABdhPJxdtPcw2+OmSnGWODzkRUu3m4P5n4orsrMMoso3zEaOon0U9g9W2Um9aUtDm9veLuTP5Bm2Qw==
X-Received: by 2002:a1c:8094:: with SMTP id b142mr3606848wmd.122.1594120767430;
        Tue, 07 Jul 2020 04:19:27 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id w12sm559698wrm.79.2020.07.07.04.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 04:19:26 -0700 (PDT)
Date:   Tue, 7 Jul 2020 13:19:13 +0200
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
Subject: Re: [PATCH v4 03/11] mm/hugetlb: unify migration callbacks
Message-ID: <20200707111913.GG5913@dhcp22.suse.cz>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-4-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594107889-32228-4-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-07-20 16:44:41, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There is no difference between two migration callback functions,
> alloc_huge_page_node() and alloc_huge_page_nodemask(), except
> __GFP_THISNODE handling. It's redundant to have two almost similar
> functions in order to handle this flag. So, this patch tries to
> remove one by introducing a new argument, gfp_mask, to
> alloc_huge_page_nodemask().
> 
> After introducing gfp_mask argument, it's caller's job to provide correct
> gfp_mask. So, every callsites for alloc_huge_page_nodemask() are changed
> to provide gfp_mask.
> 
> Note that it's safe to remove a node id check in alloc_huge_page_node()
> since there is no caller passing NUMA_NO_NODE as a node id.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Thanks for doing it this way. This makes much more sense than the
prvevious gfp_mask as a modifier approach.

I hope there won't be any weird include dependency problems but 0day
will tell us soon about that.

For the patch, feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/hugetlb.h | 26 ++++++++++++++++++--------
>  mm/hugetlb.c            | 35 ++---------------------------------
>  mm/mempolicy.c          | 10 ++++++----
>  mm/migrate.c            | 11 +++++++----
>  4 files changed, 33 insertions(+), 49 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 50650d0..bb93e95 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -10,6 +10,7 @@
>  #include <linux/list.h>
>  #include <linux/kref.h>
>  #include <linux/pgtable.h>
> +#include <linux/gfp.h>
>  
>  struct ctl_table;
>  struct user_struct;
> @@ -504,9 +505,8 @@ struct huge_bootmem_page {
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
> @@ -692,6 +692,15 @@ static inline bool hugepage_movable_supported(struct hstate *h)
>  	return true;
>  }
>  
> +/* Movability of hugepages depends on migration support. */
> +static inline gfp_t htlb_alloc_mask(struct hstate *h)
> +{
> +	if (hugepage_movable_supported(h))
> +		return GFP_HIGHUSER_MOVABLE;
> +	else
> +		return GFP_HIGHUSER;
> +}
> +
>  static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>  					   struct mm_struct *mm, pte_t *pte)
>  {
> @@ -759,13 +768,9 @@ static inline struct page *alloc_huge_page(struct vm_area_struct *vma,
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
> @@ -878,6 +883,11 @@ static inline bool hugepage_movable_supported(struct hstate *h)
>  	return false;
>  }
>  
> +static inline gfp_t htlb_alloc_mask(struct hstate *h)
> +{
> +	return 0;
> +}
> +
>  static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>  					   struct mm_struct *mm, pte_t *pte)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7e5ba5c0..3245aa0 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1089,15 +1089,6 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
>  	return NULL;
>  }
>  
> -/* Movability of hugepages depends on migration support. */
> -static inline gfp_t htlb_alloc_mask(struct hstate *h)
> -{
> -	if (hugepage_movable_supported(h))
> -		return GFP_HIGHUSER_MOVABLE;
> -	else
> -		return GFP_HIGHUSER;
> -}
> -
>  static struct page *dequeue_huge_page_vma(struct hstate *h,
>  				struct vm_area_struct *vma,
>  				unsigned long address, int avoid_reserve,
> @@ -1979,31 +1970,9 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
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
> -
>  	spin_lock(&hugetlb_lock);
>  	if (h->free_huge_pages - h->resv_huge_pages > 0) {
>  		struct page *page;
> @@ -2031,7 +2000,7 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
>  
>  	gfp_mask = htlb_alloc_mask(h);
>  	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
> -	page = alloc_huge_page_nodemask(h, node, nodemask);
> +	page = alloc_huge_page_nodemask(h, node, nodemask, gfp_mask);
>  	mpol_cond_put(mpol);
>  
>  	return page;
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index dabcee8..9034a53 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1068,10 +1068,12 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
>  /* page allocation callback for NUMA node migration */
>  struct page *alloc_new_node_page(struct page *page, unsigned long node)
>  {
> -	if (PageHuge(page))
> -		return alloc_huge_page_node(page_hstate(compound_head(page)),
> -					node);
> -	else if (PageTransHuge(page)) {
> +	if (PageHuge(page)) {
> +		struct hstate *h = page_hstate(compound_head(page));
> +		gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
> +
> +		return alloc_huge_page_nodemask(h, node, NULL, gfp_mask);
> +	} else if (PageTransHuge(page)) {
>  		struct page *thp;
>  
>  		thp = alloc_pages_node(node,
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 7370a66..3b3d918 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1538,10 +1538,13 @@ struct page *new_page_nodemask(struct page *page,
>  	unsigned int order = 0;
>  	struct page *new_page = NULL;
>  
> -	if (PageHuge(page))
> -		return alloc_huge_page_nodemask(
> -				page_hstate(compound_head(page)),
> -				preferred_nid, nodemask);
> +	if (PageHuge(page)) {
> +		struct hstate *h = page_hstate(compound_head(page));
> +
> +		gfp_mask = htlb_alloc_mask(h);
> +		return alloc_huge_page_nodemask(h, preferred_nid,
> +						nodemask, gfp_mask);
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
