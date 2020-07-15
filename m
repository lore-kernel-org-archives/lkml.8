Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E89DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77908206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594802036;
	bh=yJ25XsOgrvtzDWGEQ2WlZvT86/GEzbZcNWXj3DwVecg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YkJsULlVGTrV9IakyZcq6ChW0FyuA4Ln/RhhGprKPGyX7W6mzFLPdboSlUVjynwLH
	 gnBDEqMyvakhRJ3NVq8BXmj+rQ8B1llIVd8yjrnVcMo1/u0PaezbxflAJ9EPPD3TQZ
	 DNNewkTjzokI5B/TXmbVXtifT7+elU0By4K1EBUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgGOIdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:33:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41276 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgGOIdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:33:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id z15so1482228wrl.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UogqZ/2X6MWGX1K8GDMtBTIuBPUjas+5dLb7mmibZ5Y=;
        b=XA9Hb34GIYql3PjLBmiH/I5XF4aY9nIAQnQSazPp4cXieHBZ0k7dyNGoeDgfjaWdeQ
         5NuGWx6Gmx5YPuO1rZsqgq8chQ1EULGtv+J28amflDBtj5cxEU3IVCS0a+KrB1aEZDJm
         Dmw47UdbSgKNGtQQWQUh6udV2Bg2b44Z57iRf3TnsjZzei7GfWxw8fD7PdlKWcdV97pd
         iI7vibSssr4WyAp1r6yHqcASOSN+sKszUJRR0cgWmxzCiRkNqT7i2txj1PV7i1Fncq9S
         uuo8XdM/uaZG7uSFKpBI4vTULxDmz1Z2TsbZ4aTqT9LotiXvWK6qbXADRFnscValvcav
         jwCg==
X-Gm-Message-State: AOAM531Hsz8yaUioQini1hBHj9PPd0JbIWBYjmqGPmHWt/z83H2nFnIT
        eRvCGLRFr64l2j5g2yj2HUA=
X-Google-Smtp-Source: ABdhPJyeTXlojCPm2UkniYD8Z6F3TBatG36bOsrE5NFr5E+FztEte+oHjdrUX4/BSwJ1nfJn9oc3PA==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr10071811wrw.19.1594802032784;
        Wed, 15 Jul 2020 01:33:52 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id m10sm2229049wru.4.2020.07.15.01.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 01:33:52 -0700 (PDT)
Date:   Wed, 15 Jul 2020 10:33:51 +0200
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
Subject: Re: [PATCH 3/4] mm/hugetlb: make hugetlb migration callback CMA aware
Message-ID: <20200715083351.GE5451@dhcp22.suse.cz>
References: <1594789529-6206-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594789529-6206-3-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594789529-6206-3-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-07-20 14:05:28, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> new_non_cma_page() in gup.c requires to allocate the new page that is not
> on the CMA area. new_non_cma_page() implements it by using allocation
> scope APIs.
> 
> However, there is a work-around for hugetlb. Normal hugetlb page
> allocation API for migration is alloc_huge_page_nodemask(). It consists
> of two steps. First is dequeing from the pool. Second is, if there is no
> available page on the queue, allocating by using the page allocator.
> 
> new_non_cma_page() can't use this API since first step (deque) isn't
> aware of scope API to exclude CMA area. So, new_non_cma_page() exports
> hugetlb internal function for the second step, alloc_migrate_huge_page(),
> to global scope and uses it directly. This is suboptimal since hugetlb
> pages on the queue cannot be utilized.
> 
> This patch tries to fix this situation by making the deque function on
> hugetlb CMA aware. In the deque function, CMA memory is skipped if
> PF_MEMALLOC_NOCMA flag is found.

Now that this is in sync with the global case I do not have any
objections.

> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Minor nit below

[...]
> @@ -1036,10 +1037,16 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
>  static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
>  {
>  	struct page *page;
> +	bool nocma = !!(READ_ONCE(current->flags) & PF_MEMALLOC_NOCMA);

READ_ONCE is not really needed because current->flags are always set on
the current so no race is possible.

> +
> +	list_for_each_entry(page, &h->hugepage_freelists[nid], lru) {
> +		if (nocma && is_migrate_cma_page(page))
> +			continue;
>  
> -	list_for_each_entry(page, &h->hugepage_freelists[nid], lru)
>  		if (!PageHWPoison(page))
>  			break;
> +	}
> +
>  	/*
>  	 * if 'non-isolated free hugepage' not found on the list,
>  	 * the allocation fails.
> @@ -1928,7 +1935,7 @@ static struct page *alloc_surplus_huge_page(struct hstate *h, gfp_t gfp_mask,
>  	return page;
>  }
>  
> -struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
> +static struct page *alloc_migrate_huge_page(struct hstate *h, gfp_t gfp_mask,
>  				     int nid, nodemask_t *nmask)
>  {
>  	struct page *page;
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
