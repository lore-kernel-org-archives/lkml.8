Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8683AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624B720720
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593086757;
	bh=x46fnzFSGKD5mQYhgkMEi9s1sk7tZ+q4Wwhm8nJN0AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gLZxCgpSZ6ie24hsvxmRv5IdzUlFicirYx1GGAbnaZl9yNmxPQ0vow/KrTS3oepEs
	 pnsNSr+SqyQ7Mlx0E+15euz7gF9PBT1hi5SHFpF93Y5QBpb9dOSVZO9XQ7083kFupD
	 aYOLFYntKW1bplEPg7U77flxd4Oa0l1H98IrZ0IU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404451AbgFYMFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:05:55 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:46844 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404222AbgFYMFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:05:55 -0400
Received: by mail-ej1-f67.google.com with SMTP id p20so5641334ejd.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 05:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8fk91U2s/m8+FIC5vyjKnNNYUZeJkJlznjUqWipzu6w=;
        b=gs1ockmXEzFuy4JhrPprvim5DuIPRGHXVqII5uPwnIsED+5VE62+dM9bElkoIcQ128
         86ejxhpx7tHuKSJnPzCqxqByn+HqDxlHLTBYohC/kr5QcP68qG+C2Pd8W0OvIVgMkMV0
         gOyx3gtRdqzMgWeEpqaW4fheJnI5CyzkeMrspViXPeIOV3FYcUZIgfwQvXxXBNu6JaTu
         HUTMROKFG0MT4kpgzqgYHkYoRe8JOPjmVRAMw+vetqnaw3XujMP0RLVRhlYLFGKqFh0o
         onhl7qcX9XK85XpOwAZCpd8JSDM6cIQxo6U8s3zrXDQ9yszVOzqTNLdK8knKv2YgFYSt
         ndXQ==
X-Gm-Message-State: AOAM531dvUN4x7AAFVo2A8Qa9ObBQ2aHM9XDuRuWOnuJBMoSt2b9kAF0
        i3sOfK7F4recXQ/UfgEeJxk=
X-Google-Smtp-Source: ABdhPJygr5WUe7jrzHUM9eTvyZAL0A4EKJKuAUKFs4eQSkzv/SRbQIVpEMSD9P3fjiikyzcgLZBKmw==
X-Received: by 2002:a17:906:d204:: with SMTP id w4mr29517792ejz.117.1593086753031;
        Thu, 25 Jun 2020 05:05:53 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id l24sm16789159ejb.5.2020.06.25.05.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:05:52 -0700 (PDT)
Date:   Thu, 25 Jun 2020 14:05:50 +0200
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
Subject: Re: [PATCH v3 5/8] mm/migrate: make a standard migration target
 allocation function
Message-ID: <20200625120550.GF1320@dhcp22.suse.cz>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-6-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592892828-1934-6-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-06-20 15:13:45, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There are some similar functions for migration target allocation. Since
> there is no fundamental difference, it's better to keep just one rather
> than keeping all variants. This patch implements base migration target
> allocation function. In the following patches, variants will be converted
> to use this function.
> 
> Note that PageHighmem() call in previous function is changed to open-code
> "is_highmem_idx()" since it provides more readability.

I was little bit surprised that alloc_migration_target still uses
private argument while it only accepts migration_target_control
structure pointer but then I have noticed that you are using it as a
real callback in a later patch.

> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Few questions inline
[...]

> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 47b8ccb..820ea5e 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1648,9 +1648,13 @@ EXPORT_SYMBOL(unpoison_memory);
>  
>  static struct page *new_page(struct page *p, unsigned long private)
>  {
> -	int nid = page_to_nid(p);
> +	struct migration_target_control mtc = {
> +		.nid = page_to_nid(p),
> +		.nmask = &node_states[N_MEMORY],

This could be .namsk = NULL, right? alloc_migration_target doesn't
modify the node mask and NULL nodemask is always interpreted as all
available nodes.

> +		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> +	};
>  
> -	return new_page_nodemask(p, nid, &node_states[N_MEMORY]);
> +	return alloc_migration_target(p, (unsigned long)&mtc);
>  }
>  
[...]
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 634f1ea..3afff59 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1536,29 +1536,34 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	return rc;
>  }
>  
> -struct page *new_page_nodemask(struct page *page,
> -				int preferred_nid, nodemask_t *nodemask)
> +struct page *alloc_migration_target(struct page *page, unsigned long private)
>  {
> -	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
> +	struct migration_target_control *mtc;
> +	gfp_t gfp_mask;
>  	unsigned int order = 0;
>  	struct page *new_page = NULL;
> +	int zidx;
> +
> +	mtc = (struct migration_target_control *)private;
> +	gfp_mask = mtc->gfp_mask;
>  
>  	if (PageHuge(page)) {
>  		return alloc_huge_page_nodemask(
> -				page_hstate(compound_head(page)),
> -				preferred_nid, nodemask, 0, false);
> +				page_hstate(compound_head(page)), mtc->nid,
> +				mtc->nmask, gfp_mask, false);
>  	}
>  
>  	if (PageTransHuge(page)) {
> +		gfp_mask &= ~__GFP_RECLAIM;

What's up with this gfp_mask modification?

>  		gfp_mask |= GFP_TRANSHUGE;
>  		order = HPAGE_PMD_ORDER;
>  	}
> -
> -	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
> +	zidx = zone_idx(page_zone(page));
> +	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
>  		gfp_mask |= __GFP_HIGHMEM;
>  
>  	new_page = __alloc_pages_nodemask(gfp_mask, order,
> -				preferred_nid, nodemask);
> +				mtc->nid, mtc->nmask);
>  
>  	if (new_page && PageTransHuge(new_page))
>  		prep_transhuge_page(new_page);
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index aec26d9..adba031 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -309,7 +309,11 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
>  
>  struct page *alloc_migrate_target(struct page *page, unsigned long private)
>  {
> -	int nid = page_to_nid(page);
> +	struct migration_target_control mtc = {
> +		.nid = page_to_nid(page),
> +		.nmask = &node_states[N_MEMORY],

nmask = NULL again

> +		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> +	};
>  
> -	return new_page_nodemask(page, nid, &node_states[N_MEMORY]);
> +	return alloc_migration_target(page, (unsigned long)&mtc);
>  }
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
