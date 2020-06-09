Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8479FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0E120760
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591710245;
	bh=WYzXrt8mSkVD3G69Ipf+owNPaazU6/w/9+LQ15tg6MI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=16nLYhfI7e/UXjWbYvF1Z6qItvKFKmgX8Wlu/cMb7VwNDV2O6KAPvA/KIAU71YQPK
	 aoa8m/DeQtQI9K9knNtfIzYRtQ3sd53bDwAvMPkKmdFhONCK/2pUenqM7ywYC+3anD
	 0peuCa2UHOeX4/M3XFnO9eQI1ZW+H725pw/MoETk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbgFINny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:43:54 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41793 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729978AbgFINnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:43:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id m32so11213780ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 06:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tDta39kY0KD/UCX5IqkzMlRDHf+tP30+naJxD+kt06Q=;
        b=B1MCoX4cMa4VK1neEoo426lhQrEbZwrP3x/8aOLaKzJJvw0XoLFmmnw38bNrgsOavg
         XW+Vf2j59qy9CTakpQgHe0CcVGXuF7LbK41MSKnQLvt7BO31nzxwpAatM9aqAWW+qEi8
         8QpVZ900H2KNBOcfvjbEtpNOMOERR52maKx205ibgtbR8zMpR1h2nwvG0ehG9rUF5J0s
         S6LG4nSOngC08GVk+eP5vVRZOfswZuaNgnPzFPTkgqx1GnFW19wvbu50Pz+Lta5r1tKB
         AovRg7ExZlPnlrRd5I7YbPoL1gHUHGCw52lUOIgyHwbIoghFsf2qfPPT1bLOWoUMqJDN
         HcxQ==
X-Gm-Message-State: AOAM533gpg4lTpfIC+FejQxyMkWcC2Vlem2h7hRHcZzDPpGoQwGHOp+Q
        hYEopHBOqmVplfPjq4Pprns=
X-Google-Smtp-Source: ABdhPJz+oNcGe2WzhWETpnlzI4CI5Vqr6XnKJBcnd8A69F1kji+h8swMtpeYP1ajEvMvYUnBdUw2gA==
X-Received: by 2002:aa7:c2c7:: with SMTP id m7mr26587825edp.148.1591710192306;
        Tue, 09 Jun 2020 06:43:12 -0700 (PDT)
Received: from localhost (ip-37-188-174-195.eurotel.cz. [37.188.174.195])
        by smtp.gmail.com with ESMTPSA id q14sm15832047edj.47.2020.06.09.06.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:43:11 -0700 (PDT)
Date:   Tue, 9 Jun 2020 15:43:09 +0200
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
Subject: Re: [PATCH v2 05/12] mm/hugetlb: unify hugetlb migration callback
 function
Message-ID: <20200609134309.GG22623@dhcp22.suse.cz>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1590561903-13186-6-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590561903-13186-6-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-05-20 15:44:56, Joonsoo Kim wrote:
[...]
> -/* page migration callback function */
>  struct page *alloc_huge_page_nodemask(struct hstate *h,
>  				struct alloc_control *ac)
>  {
>  	ac->gfp_mask |= htlb_alloc_mask(h);
> +	if (ac->nid == NUMA_NO_NODE)
> +		ac->gfp_mask &= ~__GFP_THISNODE;

Is this really needed? alloc_huge_page_node is currently only called
from numa migration code and the target node should be always defined.

>  
>  	spin_lock(&hugetlb_lock);
>  	if (h->free_huge_pages - h->resv_huge_pages > 0) {
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 3b6b551..e705efd 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1073,9 +1073,10 @@ struct page *alloc_new_node_page(struct page *page, unsigned long node)
>  		struct alloc_control ac = {
>  			.nid = node,
>  			.nmask = NULL,
> +			.gfp_mask = __GFP_THISNODE,
>  		};
>  
> -		return alloc_huge_page_node(h, &ac);
> +		return alloc_huge_page_nodemask(h, &ac);
>  	} else if (PageTransHuge(page)) {
>  		struct page *thp;
>  
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
