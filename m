Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C519C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED42C2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591709196;
	bh=tZl/1oheBjLYSc+VtAaH4ReOMnXXe4JljRKfmUkruOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EGyBm51vk9B07zCBm1H8TsotEcQhrd0WL8ocuoCN7muSCvxjQPpBYuMRFEAUfScn9
	 hKdTzr8VeMIQElvmM0JZYoyKjRY46uF3nDjSgJdHFTm9AtriazRi86Wyo7TmJ6Z3Ct
	 TKo0+jq8Ti+v7LeQJyklzkG8/ZKp9SXb5BggCvOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgFIN0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:26:34 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44483 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbgFIN0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:26:33 -0400
Received: by mail-ed1-f67.google.com with SMTP id l1so16334350ede.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 06:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=duYAHWPnEvooNTZ1VvjKgdBmlQUETGmu9dtBpelWVLQ=;
        b=Xb7xp3cx2p8SV9GWgG35gFWsfDWetvR1Y0uoSIdlXAQOMk8dWDtZlqUyj2qKeFF6IF
         NY3MhYQa886bEKcLcuWRSvYBvxj2NQpe3DNJzCe1Rj7nk174GgnRscux2Xtps1DL0Kws
         OPuTVN428suDDKuWTo8wkha0ds8QC9XVKeOWbUhTSNcGHQ5Fj08GmOQSEUmZWnVnn/fj
         0WFlwkIiZ824uXsr9m1V6F0uKUhqB7ZLiDauXUtJMPJToNQJYoH5WsNXoxrw6cHHbbaF
         xVFYNuGR+iBdCPh4Dxk/hBUCzxYDLO3trdnkNwE1KA8F2GYEVRvkr9pU0WFT41a5No6I
         ZR+w==
X-Gm-Message-State: AOAM533C2/lVdOA/sqta4x8P1hDvsrLwkvg8FjWTWyRL2guN3QHu7Z5m
        2X5RldouawJhrxQg8dCZJNPebiXu
X-Google-Smtp-Source: ABdhPJwKZsdBUo7eIe9utwaZGbva4Y1XIQJsy0fQUCKprAIkQCxVi5jRVVgYBe67gwNiqtl6dJZCjg==
X-Received: by 2002:a50:fd19:: with SMTP id i25mr26529489eds.248.1591709191061;
        Tue, 09 Jun 2020 06:26:31 -0700 (PDT)
Received: from localhost (ip-37-188-174-195.eurotel.cz. [37.188.174.195])
        by smtp.gmail.com with ESMTPSA id z15sm13602811ejw.8.2020.06.09.06.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:26:30 -0700 (PDT)
Date:   Tue, 9 Jun 2020 15:26:29 +0200
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
Subject: Re: [PATCH v2 04/12] mm/hugetlb: use provided ac->gfp_mask for
 allocation
Message-ID: <20200609132629.GF22623@dhcp22.suse.cz>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1590561903-13186-5-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590561903-13186-5-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-05-20 15:44:55, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> gfp_mask handling on alloc_huge_page_(node|nodemask) is
> slightly changed, from ASSIGN to OR. It's safe since caller of these
> functions doesn't pass extra gfp_mask except htlb_alloc_mask().
> 
> This is a preparation step for following patches.

This patch on its own doesn't make much sense to me. Should it be folded
in the patch which uses that?

> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  mm/hugetlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 453ba94..dabe460 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1985,7 +1985,7 @@ struct page *alloc_huge_page_node(struct hstate *h,
>  {
>  	struct page *page = NULL;
>  
> -	ac->gfp_mask = htlb_alloc_mask(h);
> +	ac->gfp_mask |= htlb_alloc_mask(h);
>  	if (ac->nid != NUMA_NO_NODE)
>  		ac->gfp_mask |= __GFP_THISNODE;
>  
> @@ -2004,7 +2004,7 @@ struct page *alloc_huge_page_node(struct hstate *h,
>  struct page *alloc_huge_page_nodemask(struct hstate *h,
>  				struct alloc_control *ac)
>  {
> -	ac->gfp_mask = htlb_alloc_mask(h);
> +	ac->gfp_mask |= htlb_alloc_mask(h);
>  
>  	spin_lock(&hugetlb_lock);
>  	if (h->free_huge_pages - h->resv_huge_pages > 0) {
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
