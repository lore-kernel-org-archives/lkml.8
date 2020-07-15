Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40323C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B54920672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594801447;
	bh=42jZMoEINyjtINi8El3KpnJiCfJKOT842iU/fRRE8Jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aBJP0WgJRVMSXcB5saBn5t7IIOrxEhUq5okCa2DcRGzPfxpRz07PW0Mb/JtEyNPob
	 6BoxGUbH4sRbnKsXngl/5s8JDob4pc1m1NF+wetUvmA4E7yS2zXYbtp609S4GrZMrK
	 ktYmHTCNcNgzl4x5Yg3nTf8BbhhwYZEaTtb5Cbog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgGOIYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:24:05 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:38807 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbgGOIYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:24:05 -0400
Received: by mail-ej1-f65.google.com with SMTP id br7so1265823ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7u6fFMc2fGdB0ahSthN2uZky3rmUyFB8YW5Ikd1vBkQ=;
        b=OScwCKaDjp3tgjJsNkvFOYHmgKnWoeDCJpECGf8xZppNXGdMTzpbzGaNp8L94vSomD
         3jjM0AvZPv84jNXx6DL3eYXbTUoPE1iqrhXTQKnc08GRbXc9Q4HZRUNsZnmhe5ZuacEQ
         hOv5G3/Y41RTM4rhBdqLO0D5DDxchsGjGsvYtZkuMjSlN4VLuF8UlC6Q1C3dT9DVQ6b8
         beUQ6h5YEEAyVnfKrOngpY39Qd+RENdgpSp9wSQozE9tmbiNWMKsGgYNQAtLOX88wGRe
         KqLp9tsPZb3oknqFRBZEJPxMr77whRHkI+BSRY8cU5l7xLufhKWjo8LywONnyPiEjSUb
         OHaA==
X-Gm-Message-State: AOAM532yvMfQDaZGP+704/5KPW8vGR2CGEuRi/zhrzjUjKDNwwpngo3D
        JuHVWLGJHUccL9TXxYF8iFU=
X-Google-Smtp-Source: ABdhPJxQxmIp7lUBAHi0FmrGkqiXoiHWR12Su4deAD+nPgjZ6SwcVC/eXiynSSkrioP8OGD6bUp5aw==
X-Received: by 2002:a17:907:7290:: with SMTP id dt16mr8028433ejc.63.1594801442721;
        Wed, 15 Jul 2020 01:24:02 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id v24sm1347858eja.29.2020.07.15.01.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:24:02 -0700 (PDT)
Date:   Wed, 15 Jul 2020 10:24:01 +0200
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
Subject: Re: [PATCH 2/4] mm/gup: restrict CMA region by using allocation
 scope API
Message-ID: <20200715082401.GC5451@dhcp22.suse.cz>
References: <1594789529-6206-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594789529-6206-2-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594789529-6206-2-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-07-20 14:05:27, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> We have well defined scope API to exclude CMA region.
> Use it rather than manipulating gfp_mask manually. With this change,
> we can now use __GFP_MOVABLE for gfp_mask and the ZONE_MOVABLE is also
> searched by page allocator. For hugetlb, gfp_mask is redefined since
> it has a regular allocation mask filter for migration target.
> 
> Note that this can be considered as a fix for the commit 9a4e9f3b2d73
> ("mm: update get_user_pages_longterm to migrate pages allocated from
> CMA region"). However, "Fixes" tag isn't added here since it is just
> suboptimal but it doesn't cause any problem.

But it is breaking the contract that the longterm pins never end up in a
cma managed memory. So I think Fixes tag is really due. I am not sure
about stable backport. If the patch was the trivial move of
memalloc_nocma_restore then it would be probably worth it because it is
trivial to review and backport. I suspect that longterm pins in CMA
regions would cause hard to debug issues where CMA memory will not be
available. But I am not really sure this is a real problem considering
how many long term pin users we have and I have also no idea whether
those are usually used along with CMA users.

Anyway I think it would really be much better to isolate the
memalloc_nocma_restore and have it first in the series. The reword of
the __GFP_MOVABLE functionality is orthogonal.

Btw __GFP_NOWARN change is not documented.

> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
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
> index 5daadae..bbd36a1 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1619,10 +1619,12 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
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
> @@ -1630,6 +1632,8 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
>  #ifdef CONFIG_HUGETLB_PAGE
>  	if (PageHuge(page)) {
>  		struct hstate *h = page_hstate(page);
> +
> +		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
>  		/*
>  		 * We don't want to dequeue from the pool because pool pages will
>  		 * mostly be from the CMA region.
> @@ -1644,11 +1648,6 @@ static struct page *new_non_cma_page(struct page *page, unsigned long private)
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
> @@ -1794,7 +1793,6 @@ static long __gup_longterm_locked(struct task_struct *tsk,
>  				     vmas_tmp, NULL, gup_flags);
>  
>  	if (gup_flags & FOLL_LONGTERM) {
> -		memalloc_nocma_restore(flags);
>  		if (rc < 0)
>  			goto out;
>  
> @@ -1807,9 +1805,10 @@ static long __gup_longterm_locked(struct task_struct *tsk,
>  
>  		rc = check_and_migrate_cma_pages(tsk, mm, start, rc, pages,
>  						 vmas_tmp, gup_flags);
> +out:
> +		memalloc_nocma_restore(flags);
>  	}
>  
> -out:
>  	if (vmas_tmp != vmas)
>  		kfree(vmas_tmp);
>  	return rc;
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
