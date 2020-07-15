Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FAFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB0E2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594802171;
	bh=lYEiOJIGdKWWZ+1IQf95zSBxf3slRYVw9VggyjNkDMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gCTGw6zxLG0LQW8T1UCkZmv7u9GU+tbEyX38sbxwuw1Eoew85Zklt3XLrCrBNhXMS
	 ltlE4DaQMDaSNUaR/OACiUWK0mbrpb5/vemqKwddOG9uJLmM3MsmMOtD3CqD63IV0F
	 vKZX+i981j404SQygR/PIlSkhoDXL6i+MPgAnIms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbgGOIgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:36:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51516 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbgGOIgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:36:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id 22so4521293wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JbXs7oCulwVFv9sXWuC2a5VDnfZjgW3QGY/2RDFbB6s=;
        b=lvlOue40su2RSzO3/7p7DpuMzuBE98HI35GTnIy+tAIF4pQwBqwsrDI3B1PzPQbUfk
         zEg3IqudYFqHnzPJhRypoOJB7UEpkbBDJSBZ6B8w+Gj/RAydJqooa02dZn0ARYG5AedZ
         lcbcARnarAtRToPVejNvCS1FH1lNk4D6a3rEJ6ryJHv7Ejg4FP82nY4qy5ePVsX/9Ueo
         mKikJI+/PBKknt/6CR6AWwe3SpsXXmiGwg3Y9z+9sjwmzc4DMxgCiWU8zl5sEHoUGYD1
         N2KmMD2+GewWo28C4x0m1J3SQPOE4gHGHxf4JLcRhxOoGMFmtlDiC0lYYGY+lq85V1qq
         Og8Q==
X-Gm-Message-State: AOAM532ekTFsQVX/ekN0Do41omZMl5yj1mlhLuZRDvGy0X+HsxRb9/cW
        jpBSiLLqbFybn8SQY8dh2m4=
X-Google-Smtp-Source: ABdhPJyNgumAlyuAzHqDJl8g2JtRCvbClaKC8LPUnxnGgU5lsT4GBlULKzCN1UwU3yOswVJpknru8g==
X-Received: by 2002:a1c:a589:: with SMTP id o131mr7120865wme.12.1594802167814;
        Wed, 15 Jul 2020 01:36:07 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id n5sm2349843wmi.34.2020.07.15.01.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:36:07 -0700 (PDT)
Date:   Wed, 15 Jul 2020 10:36:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 4/4] mm/gup: use a standard migration target allocation
 callback
Message-ID: <20200715083605.GF5451@dhcp22.suse.cz>
References: <1594789529-6206-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594789529-6206-4-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594789529-6206-4-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-07-20 14:05:29, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There is a well-defined migration target allocation callback. Use it.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/gup.c | 54 ++++++------------------------------------------------
>  1 file changed, 6 insertions(+), 48 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 4ba822a..628ca4c 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1608,52 +1608,6 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
>  }
>  
>  #ifdef CONFIG_CMA
> -static struct page *new_non_cma_page(struct page *page, unsigned long private)
> -{
> -	/*
> -	 * We want to make sure we allocate the new page from the same node
> -	 * as the source page.
> -	 */
> -	int nid = page_to_nid(page);
> -	/*
> -	 * Trying to allocate a page for migration. Ignore allocation
> -	 * failure warnings. We don't force __GFP_THISNODE here because
> -	 * this node here is the node where we have CMA reservation and
> -	 * in some case these nodes will have really less non CMA
> -	 * allocation memory.
> -	 *
> -	 * Note that CMA region is prohibited by allocation scope.
> -	 */
> -	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN;
> -
> -	if (PageHighMem(page))
> -		gfp_mask |= __GFP_HIGHMEM;
> -
> -#ifdef CONFIG_HUGETLB_PAGE
> -	if (PageHuge(page)) {
> -		struct hstate *h = page_hstate(page);
> -
> -		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
> -		return alloc_huge_page_nodemask(h, nid, NULL, gfp_mask);
> -	}
> -#endif
> -	if (PageTransHuge(page)) {
> -		struct page *thp;
> -		/*
> -		 * ignore allocation failure warnings
> -		 */
> -		gfp_t thp_gfpmask = GFP_TRANSHUGE | __GFP_NOWARN;
> -
> -		thp = __alloc_pages_node(nid, thp_gfpmask, HPAGE_PMD_ORDER);
> -		if (!thp)
> -			return NULL;
> -		prep_transhuge_page(thp);
> -		return thp;
> -	}
> -
> -	return __alloc_pages_node(nid, gfp_mask, 0);
> -}
> -
>  static long check_and_migrate_cma_pages(struct task_struct *tsk,
>  					struct mm_struct *mm,
>  					unsigned long start,
> @@ -1668,6 +1622,10 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
>  	bool migrate_allow = true;
>  	LIST_HEAD(cma_page_list);
>  	long ret = nr_pages;
> +	struct migration_target_control mtc = {
> +		.nid = NUMA_NO_NODE,
> +		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN,
> +	};
>  
>  check_again:
>  	for (i = 0; i < nr_pages;) {
> @@ -1713,8 +1671,8 @@ static long check_and_migrate_cma_pages(struct task_struct *tsk,
>  		for (i = 0; i < nr_pages; i++)
>  			put_page(pages[i]);
>  
> -		if (migrate_pages(&cma_page_list, new_non_cma_page,
> -				  NULL, 0, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
> +		if (migrate_pages(&cma_page_list, alloc_migration_target, NULL,
> +			(unsigned long)&mtc, MIGRATE_SYNC, MR_CONTIG_RANGE)) {
>  			/*
>  			 * some of the pages failed migration. Do get_user_pages
>  			 * without migration.
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
