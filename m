Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFB2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F781217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579540646;
	bh=2arvuzsZRrho6p2CID+zbyOJeN2gWR+02fv26IstiHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2cquojO+ZtFdk7rTMoalnf505adLbi26cNw/7dGLZaxuMasb5T7U2dHUstnOKYdg8
	 PB+bbRlCmm4r1M0Mmlb2UFzsx4Rn3JqCgyZYw7BqUQp9OqSlgempnQA/J4OTeY8kZA
	 ekj7Wk/lhIM0D5F4X+bhaxyiT/UFI3MYCuicIZss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgATRRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:17:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41694 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATRRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:17:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so248624wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 09:17:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kEYMCzpg5Y3ZBlBbc0R3YsIwbWtq+NyZ2Gxt9ht/DWE=;
        b=oKh8NW3kC6ZSxqxPOcQ1BH7Anob8ygGz1lUrgFFh1B417z6iPMo9fMYSh6Wg1eZUBB
         SVMLdqE1JjtN+sBSvu37vOz/rO0F6g2aUJ7JGovVy2/LuugGY5pz924VgBt0Alm8L0UU
         pk7vhZYl2aTN26gAb/EPtiuiFkReudTuCqMVG0K4LmsbmQLk4aaRGml9U7c0zen1l/oS
         yGIa3uR9op64rl/Sby5zHCWEw3dRuIQnBvQf9Xg0wHSnr13ZVkHpz/RnSl/ufYA7Ljbf
         qLBsmomgihDzl/DTmYoXMnMvW2aMMeZNiSTLbadzd/hV6Yan7UDd8VkvshfAqw6bMp99
         /g1A==
X-Gm-Message-State: APjAAAV5s3K8zY+DN0tqTm7VpUJeFf5gsHbOGpejMJher2BqxD1uXsvQ
        9MaBf3VNFAncXf6rRU5W4zo+Pr1R
X-Google-Smtp-Source: APXvYqxmH0H4n5gECO7t2dqiUpCbt0SDkU6q+JbFc7hG6xUJ4gtX8mvxed1FR6xIwxuWjbLcyRRdsw==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr589441wre.58.1579540621745;
        Mon, 20 Jan 2020 09:17:01 -0800 (PST)
Received: from localhost (ip-37-188-230-253.eurotel.cz. [37.188.230.253])
        by smtp.gmail.com with ESMTPSA id v8sm46557560wrw.2.2020.01.20.09.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 09:17:01 -0800 (PST)
Date:   Mon, 20 Jan 2020 18:16:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm v3] mm/page_isolation: fix potential warning from user
Message-ID: <20200120171659.GA29276@dhcp22.suse.cz>
References: <20200120163915.1469-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120163915.1469-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-01-20 11:39:15, Qian Cai wrote:
> It makes sense to call the WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE)
> from start_isolate_page_range(), but should avoid triggering it from
> userspace, i.e, from is_mem_section_removable() because it could crash
> the system by a non-root user if warn_on_panic is set.
> 
> While at it, simplify the code a bit by removing an unnecessary jump
> label.
> 
> Suggested-by: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> 
> v3: Drop the page_isolation.c cleanup change.
> v2: Improve the commit log.
>     Warn for all start_isolate_page_range() users not just offlining.
> 
>  mm/page_alloc.c     | 11 ++++-------
>  mm/page_isolation.c | 18 +++++++++++-------
>  2 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 621716a25639..3c4eb750a199 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8231,7 +8231,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		if (is_migrate_cma(migratetype))
>  			return NULL;
>  
> -		goto unmovable;
> +		return page;
>  	}
>  
>  	for (; iter < pageblock_nr_pages; iter++) {
> @@ -8241,7 +8241,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		page = pfn_to_page(pfn + iter);
>  
>  		if (PageReserved(page))
> -			goto unmovable;
> +			return page;
>  
>  		/*
>  		 * If the zone is movable and we have ruled out all reserved
> @@ -8261,7 +8261,7 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  			unsigned int skip_pages;
>  
>  			if (!hugepage_migration_supported(page_hstate(head)))
> -				goto unmovable;
> +				return page;
>  
>  			skip_pages = compound_nr(head) - (page - head);
>  			iter += skip_pages - 1;
> @@ -8303,12 +8303,9 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
>  		 * is set to both of a memory hole page and a _used_ kernel
>  		 * page at boot.
>  		 */
> -		goto unmovable;
> +		return page;
>  	}
>  	return NULL;
> -unmovable:
> -	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> -	return pfn_to_page(pfn + iter);
>  }
>  
>  #ifdef CONFIG_CONTIG_ALLOC
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index e70586523ca3..a9fd7c740c23 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -54,14 +54,18 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>  
>  out:
>  	spin_unlock_irqrestore(&zone->lock, flags);
> -	if (!ret)
> +	if (!ret) {
>  		drain_all_pages(zone);
> -	else if ((isol_flags & REPORT_FAILURE) && unmovable)
> -		/*
> -		 * printk() with zone->lock held will guarantee to trigger a
> -		 * lockdep splat, so defer it here.
> -		 */
> -		dump_page(unmovable, "unmovable page");
> +	} else {
> +		WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);
> +
> +		if ((isol_flags & REPORT_FAILURE) && unmovable)
> +			/*
> +			 * printk() with zone->lock held will likely trigger a
> +			 * lockdep splat, so defer it here.
> +			 */
> +			dump_page(unmovable, "unmovable page");
> +	}
>  
>  	return ret;
>  }
> -- 
> 2.21.0 (Apple Git-122.2)

-- 
Michal Hocko
SUSE Labs
