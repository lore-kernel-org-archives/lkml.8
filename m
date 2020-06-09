Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F567C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 567462078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591710813;
	bh=+WxxCg81okJ13W8Y0I2EzY/HL6PWTNXxyTraOaGRKcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pjT3hVbpGgwbNlj0jNHqnZv9NmQvMhX4ZXWO9ebRs/NdzX53hxmRD5+XIQJWusGLs
	 YV+wCAS0YoS9H1fVPeKtWUTmRn9E6Q/owgQAwDby2G6vwSaQ9hWMF1vKI83m0sP5mL
	 BEe4FGU++N/CG002QtCMixJtiABv55gw+6Qyw8wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgFINxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:53:31 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:44684 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729874AbgFINx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:53:29 -0400
Received: by mail-ej1-f66.google.com with SMTP id gl26so22458668ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 06:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ln7jPBzpTkga2kF63B32p1/NUg6bHxfaCJ0cULrwnb4=;
        b=s++dXKDlMG1ZaMAMfYzKxYOay3cPyb9anjgJ945SquSmydbb/hCXLnkxdE8nsKrv0q
         senJXWpcHsvUTb8ChN/7ZTG6eBVZoirAbEY5/BVfgYD3hYcnE4jglNufCrO9uo3B8IG7
         jSXpH2fMS4mXARHn4OWVi2H4YZ9YOThOnoqclZ6zaoqo8Vtt7SBmX0Non0Nu0MPWMRHn
         iI1F/UTc9mvs3YJsu6QI3w2J61pX7fTMKkOgLj+XSB9j65bRFf711weyP4ikMmYcIEQf
         iKGUhAWzN20CgSkikaVgjKeckgSoG87XIjDKED//EfDJ7YwAOHqH+VhlCYQNNBu+IRGH
         4C+w==
X-Gm-Message-State: AOAM532IfjggElg87//zKGI9Yk71zYmcRfv+6cDmDK0YPYxu45sENNNs
        3vIcc59P4lKy9JHgzMKcxliKD1Sc
X-Google-Smtp-Source: ABdhPJyC47KBslfYp3SVMiEiQjKNUQiqs95aOiIyQ3CW+vCSDBDmli8Ctiu4yVXdRPzHj6b2IcbXxQ==
X-Received: by 2002:a17:906:73d5:: with SMTP id n21mr26921005ejl.24.1591710807501;
        Tue, 09 Jun 2020 06:53:27 -0700 (PDT)
Received: from localhost (ip-37-188-174-195.eurotel.cz. [37.188.174.195])
        by smtp.gmail.com with ESMTPSA id 63sm15057599edm.48.2020.06.09.06.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:53:26 -0700 (PDT)
Date:   Tue, 9 Jun 2020 15:53:25 +0200
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
Subject: Re: [PATCH v2 06/12] mm/hugetlb: make hugetlb migration target
 allocation APIs CMA aware
Message-ID: <20200609135325.GH22623@dhcp22.suse.cz>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1590561903-13186-7-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590561903-13186-7-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-05-20 15:44:57, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There is a user who do not want to use CMA memory for migration. Until
> now, it is implemented by caller side but it's not optimal since there
> is limited information on caller. This patch implements it on callee side
> to get better result.

I do not follow this changelog and honestly do not see an improvement.
skip_cma in the alloc_control sound like a hack to me. I can now see
why your earlier patch has started to or the given gfp_mask. If anything
this should be folded here. But even then I do not like a partial
gfp_mask (__GFP_NOWARN on its own really has GFP_NOWAIT like semantic).

> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  include/linux/hugetlb.h |  2 --
>  mm/gup.c                |  9 +++------
>  mm/hugetlb.c            | 21 +++++++++++++++++----
>  mm/internal.h           |  1 +
>  4 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index f482563..3d05f7d 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -503,8 +503,6 @@ struct huge_bootmem_page {
>  	struct hstate *hstate;
>  };
>  
> -struct page *alloc_migrate_huge_page(struct hstate *h,
> -				struct alloc_control *ac);
>  struct page *alloc_huge_page_nodemask(struct hstate *h,
>  				struct alloc_control *ac);
>  struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
> diff --git a/mm/gup.c b/mm/gup.c
> index 6b78f11..87eca79 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1617,14 +1617,11 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
>  		struct alloc_control ac = {
>  			.nid = nid,
>  			.nmask = NULL,
> -			.gfp_mask = gfp_mask,
> +			.gfp_mask = __GFP_NOWARN,
> +			.skip_cma = true,
>  		};
>  
> -		/*
> -		 * We don't want to dequeue from the pool because pool pages will
> -		 * mostly be from the CMA region.
> -		 */
> -		return alloc_migrate_huge_page(h, &ac);
> +		return alloc_huge_page_nodemask(h, &ac);
>  	}
>  
>  	if (PageTransHuge(page)) {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8132985..e465582 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1033,13 +1033,19 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
>  	h->free_huge_pages_node[nid]++;
>  }
>  
> -static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> +static struct page *dequeue_huge_page_node_exact(struct hstate *h,
> +						int nid, bool skip_cma)
>  {
>  	struct page *page;
>  
> -	list_for_each_entry(page, &h->hugepage_freelists[nid], lru)
> +	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
> +		if (skip_cma && is_migrate_cma_page(page))
> +			continue;
> +
>  		if (!PageHWPoison(page))
>  			break;
> +	}
> +
>  	/*
>  	 * if 'non-isolated free hugepage' not found on the list,
>  	 * the allocation fails.
> @@ -1080,7 +1086,7 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h,
>  			continue;
>  		node = zone_to_nid(zone);
>  
> -		page = dequeue_huge_page_node_exact(h, node);
> +		page = dequeue_huge_page_node_exact(h, node, ac->skip_cma);
>  		if (page)
>  			return page;
>  	}
> @@ -1937,7 +1943,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>  	return page;
>  }
>  
> -struct page *alloc_migrate_huge_page(struct hstate *h,
> +static struct page *alloc_migrate_huge_page(struct hstate *h,
>  				struct alloc_control *ac)
>  {
>  	struct page *page;
> @@ -1999,6 +2005,13 @@ struct page *alloc_huge_page_nodemask(struct hstate *h,
>  	}
>  	spin_unlock(&hugetlb_lock);
>  
> +	/*
> +	 * clearing __GFP_MOVABLE flag ensure that allocated page
> +	 * will not come from CMA area
> +	 */
> +	if (ac->skip_cma)
> +		ac->gfp_mask &= ~__GFP_MOVABLE;
> +
>  	return alloc_migrate_huge_page(h, ac);
>  }
>  
> diff --git a/mm/internal.h b/mm/internal.h
> index 6e613ce..159cfd6 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -618,6 +618,7 @@ struct alloc_control {
>  	int nid;		/* preferred node id */
>  	nodemask_t *nmask;
>  	gfp_t gfp_mask;
> +	bool skip_cma;
>  };
>  
>  #endif	/* __MM_INTERNAL_H */
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
