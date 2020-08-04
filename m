Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A50C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D76222BED
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 12:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgHDMX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 08:23:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:46628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgHDMXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 08:23:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 796B0AD1E;
        Tue,  4 Aug 2020 12:06:10 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] mm/gup: restrict CMA region by using allocation
 scope API
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1596180906-8442-1-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <370b1f3c-98ea-421a-d4a2-621bab5a5eec@suse.cz>
Date:   Tue, 4 Aug 2020 14:05:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596180906-8442-1-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/20 9:35 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> We have well defined scope API to exclude CMA region.
> Use it rather than manipulating gfp_mask manually. With this change,
> we can now restore __GFP_MOVABLE for gfp_mask like as usual migration
> target allocation. It would result in that the ZONE_MOVABLE is also
> searched by page allocator. For hugetlb, gfp_mask is redefined since
> it has a regular allocation mask filter for migration target.
> __GPF_NOWARN is added to hugetlb gfp_mask filter since a new user for
> gfp_mask filter, gup, want to be silent when allocation fails.
> 
> Note that this can be considered as a fix for the commit 9a4e9f3b2d73
> ("mm: update get_user_pages_longterm to migrate pages allocated from
> CMA region"). However, "Fixes" tag isn't added here since it is just
> suboptimal but it doesn't cause any problem.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  include/linux/hugetlb.h |  2 ++
>  mm/gup.c                | 17 ++++++++---------
>  2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 6b9508d..2660b04 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -708,6 +708,8 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
>  	/* Some callers might want to enfoce node */
>  	modified_mask |= (gfp_mask & __GFP_THISNODE);
>  
> +	modified_mask |= (gfp_mask & __GFP_NOWARN);
> +
>  	return modified_mask;
>  }
>  
> diff --git a/mm/gup.c b/mm/gup.c
> index a55f1ec..3990ddc 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1601,10 +1601,12 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
>  	 * Trying to allocate a page for migration. Ignore allocation
>  	 * failure warnings. We don't force __GFP_THISNODE here because
>  	 * this node here is the node where we have CMA reservation and
> -	 * in some case these nodes will have really less non movable
> +	 * in some case these nodes will have really less non CMA
>  	 * allocation memory.
> +	 *
> +	 * Note that CMA region is prohibited by allocation scope.
>  	 */
> -	gfp_t gfp_mask = GFP_USER | __GFP_NOWARN;
> +	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN;
>  
>  	if (PageHighMem(page))
>  		gfp_mask |= __GFP_HIGHMEM;
> @@ -1612,6 +1614,8 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
>  #ifdef CONFIG_HUGETLB_PAGE
>  	if (PageHuge(page)) {
>  		struct hstate *h = page_hstate(page);
> +
> +		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
>  		/*
>  		 * We don't want to dequeue from the pool because pool pages will
>  		 * mostly be from the CMA region.
> @@ -1626,11 +1630,6 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
>  		 */
>  		gfp_t thp_gfpmask = GFP_TRANSHUGE | __GFP_NOWARN;
>  
> -		/*
> -		 * Remove the movable mask so that we don't allocate from
> -		 * CMA area again.
> -		 */
> -		thp_gfpmask &= ~__GFP_MOVABLE;
>  		thp = __alloc_pages_node(nid, thp_gfpmask, HPAGE_PMD_ORDER);
>  		if (!thp)
>  			return NULL;
> @@ -1773,7 +1772,6 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>  				     vmas_tmp, NULL, gup_flags);
>  
>  	if (gup_flags & FOLL_LONGTERM) {
> -		memalloc_nocma_restore(flags);
>  		if (rc < 0)
>  			goto out;
>  
> @@ -1786,9 +1784,10 @@ static long __gup_longterm_locked(struct mm_struct *mm,
>  
>  		rc = check_and_migrate_cma_pages(mm, start, rc, pages,
>  						 vmas_tmp, gup_flags);
> +out:
> +		memalloc_nocma_restore(flags);
>  	}
>  
> -out:
>  	if (vmas_tmp != vmas)
>  		kfree(vmas_tmp);
>  	return rc;
> 

