Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149E9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E488C20737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591710876;
	bh=rjBAjn+09rDinP+3WVIsbSfT4/h7rXeEo1bvrNH44A0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FY8kfUSGkVxUwAAPrqW40bHJDQMRq08UvnRranEUdNDfQ0USWlBTrathuZoLJ5QmP
	 /tPHCBkHJuCGeV1vrczHB040cKRuLq6kyhqvmsPS3SrWN4HZHVdJK1V+7K5i1I7JSt
	 i7i9cSD2aji3jGT3Ld11VoDk/2q0bGEYihywE2ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbgFINyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:54:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46237 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbgFINye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:54:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id m21so16399617eds.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 06:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u6d5a1wYS310TnY2RCLtD0HWF1rRF6Bt1vMfKfFcb28=;
        b=syXUqDaTKvf43wBY4Imze6r7aPbpZYBipO5HcXmujvqEAP3XyFa96ZqCkQ/Cosbu9y
         7YA/ieCzcyoX/R2uppgjt8/sHplb0+9nW8LKWRCtDx/hDjeM+uMOn5rDKrGczedZn15O
         GgWvD8HkEr1128YoKqzBZK1aUdJYneBvndA8GSM4p5+8/oVq7YrCmZ37StkkPoqS5QNG
         4e5qsAmDL2ULxZeD5VE2IF7b0lfe8cKC7/OUaoZciL6xnhFyd0n9CWdNKEaWIL4kiGUO
         fuRjgXj55KtpCSpLtLWV2Kvze9kDWpop9oSSa/5sd4m0qZTOvz5Yw8RYlE0yhSrv6art
         1T6w==
X-Gm-Message-State: AOAM531TxKNKE033HPdk4w1LioVn8QESfWrblEqBAn7x5GeFt9g3ueTF
        /GxTfrfm3TuhDEFTllLGF/0aBBoW
X-Google-Smtp-Source: ABdhPJyDNXxQrUuqOAS5w0ko4VQewnI1d3vzHbe9r7WdhIfFeYSIRzf4jOqjl7yqnwQtmtBTOA8ULg==
X-Received: by 2002:a05:6402:1767:: with SMTP id da7mr27430433edb.90.1591710872569;
        Tue, 09 Jun 2020 06:54:32 -0700 (PDT)
Received: from localhost (ip-37-188-174-195.eurotel.cz. [37.188.174.195])
        by smtp.gmail.com with ESMTPSA id dg24sm12595287edb.55.2020.06.09.06.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:54:31 -0700 (PDT)
Date:   Tue, 9 Jun 2020 15:54:31 +0200
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
Subject: Re: [PATCH v2 07/12] mm/hugetlb: do not modify user provided gfp_mask
Message-ID: <20200609135431.GI22623@dhcp22.suse.cz>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1590561903-13186-8-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590561903-13186-8-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-05-20 15:44:58, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> It's not good practice to modify user input. Instead of using it to
> build correct gfp_mask for APIs, this patch introduces another gfp_mask
> field, __gfp_mask, for internal usage.

Ugh, this is really ugly. It is just hugetlb to add __GFP_THISNODE as a
special case. This is an ugly hack but I do not think we want to work
around it by yet another hack. Moreover it seems that the __GFP_THISNODE
might be not needed anymore as pointed out in a reply to earlier patch.

> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  mm/hugetlb.c  | 19 ++++++++++---------
>  mm/internal.h |  2 ++
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e465582..4757e72 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1068,15 +1068,15 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h,
>  	struct zoneref *z;
>  	int node = NUMA_NO_NODE;
>  
> -	zonelist = node_zonelist(ac->nid, ac->gfp_mask);
> +	zonelist = node_zonelist(ac->nid, ac->__gfp_mask);
>  
>  retry_cpuset:
>  	cpuset_mems_cookie = read_mems_allowed_begin();
>  	for_each_zone_zonelist_nodemask(zone, z, zonelist,
> -			gfp_zone(ac->gfp_mask), ac->nmask) {
> +			gfp_zone(ac->__gfp_mask), ac->nmask) {
>  		struct page *page;
>  
> -		if (!cpuset_zone_allowed(zone, ac->gfp_mask))
> +		if (!cpuset_zone_allowed(zone, ac->__gfp_mask))
>  			continue;
>  		/*
>  		 * no need to ask again on the same node. Pool is node rather than
> @@ -1127,8 +1127,8 @@ static struct page *dequeue_huge_page_vma(struct hstate *h,
>  	if (avoid_reserve && h->free_huge_pages - h->resv_huge_pages == 0)
>  		goto err;
>  
> -	ac.gfp_mask = htlb_alloc_mask(h);
> -	ac.nid = huge_node(vma, address, ac.gfp_mask, &mpol, &ac.nmask);
> +	ac.__gfp_mask = htlb_alloc_mask(h);
> +	ac.nid = huge_node(vma, address, ac.__gfp_mask, &mpol, &ac.nmask);
>  
>  	page = dequeue_huge_page_nodemask(h, &ac);
>  	if (page && !avoid_reserve && vma_has_reserves(vma, chg)) {
> @@ -1951,7 +1951,7 @@ static struct page *alloc_migrate_huge_page(struct hstate *h,
>  	if (hstate_is_gigantic(h))
>  		return NULL;
>  
> -	page = alloc_fresh_huge_page(h, ac->gfp_mask,
> +	page = alloc_fresh_huge_page(h, ac->__gfp_mask,
>  				ac->nid, ac->nmask, NULL);
>  	if (!page)
>  		return NULL;
> @@ -1989,9 +1989,10 @@ struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
>  struct page *alloc_huge_page_nodemask(struct hstate *h,
>  				struct alloc_control *ac)
>  {
> -	ac->gfp_mask |= htlb_alloc_mask(h);
> +	ac->__gfp_mask = htlb_alloc_mask(h);
> +	ac->__gfp_mask |= ac->gfp_mask;
>  	if (ac->nid == NUMA_NO_NODE)
> -		ac->gfp_mask &= ~__GFP_THISNODE;
> +		ac->__gfp_mask &= ~__GFP_THISNODE;
>  
>  	spin_lock(&hugetlb_lock);
>  	if (h->free_huge_pages - h->resv_huge_pages > 0) {
> @@ -2010,7 +2011,7 @@ struct page *alloc_huge_page_nodemask(struct hstate *h,
>  	 * will not come from CMA area
>  	 */
>  	if (ac->skip_cma)
> -		ac->gfp_mask &= ~__GFP_MOVABLE;
> +		ac->__gfp_mask &= ~__GFP_MOVABLE;
>  
>  	return alloc_migrate_huge_page(h, ac);
>  }
> diff --git a/mm/internal.h b/mm/internal.h
> index 159cfd6..2dc0268 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -619,6 +619,8 @@ struct alloc_control {
>  	nodemask_t *nmask;
>  	gfp_t gfp_mask;
>  	bool skip_cma;
> +
> +	gfp_t __gfp_mask;	/* Used internally in API implementation */
>  };
>  
>  #endif	/* __MM_INTERNAL_H */
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
