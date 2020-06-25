Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DDAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D4AD2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593087046;
	bh=5qJtjtMrcsDM5HHuA1DidBlIICh4SPzRUZecy4qbFHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=17rP2Q4PaaEf1kkZROlA11IRx2iHzHF8X99NzI+44zUjITLrzMKXsIMFhyd8LUC45
	 G3Rjm6nWTs+ZM9IfbLbi1O0zWxZal+ucnh7IsO8EY46LXeKVeFlU5ErpTAAHQV2KcW
	 VIIURPFMmPvGnMtMlyfffX35rVD1EgABupEHhKdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404529AbgFYMKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:10:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40661 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404309AbgFYMKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:10:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id h5so5586695wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 05:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0jbXkZNbg4noEr6B97w1ewenuEm0dXI4GSPALq5mbo8=;
        b=iE96msYmeVSLIirTJzDORaR44og3dy/l7nHsnIxZ1q8EMY6GLMxHKihOPuO/07P7Lo
         e5u+hE2QhFH2cpo1zvWwrtRZm8RrFUmPXyHvBAzv51tXFLTyWBrQnQjniy2qjE4X/f+n
         yA/blOBy/3kOTnBCVfgAXAJ+FWx4Dd4NuwvUQqBghGE03gJcyjMFTtS602O3S460230Q
         aXE2trMoe1wifZTywU+yoahK/e1Pb9V9mfraSRaOmvH0WtR6YL1mxtJwZf8Z3qmNegZS
         MX876xATiQ3a+c02zNNkXLM3qmlLfB2+h/lYBrbkgaHoJAT19w4q0iOUdOUW4o86aCdb
         qdWA==
X-Gm-Message-State: AOAM530HbX+X9qOLd+O0wIY7cgTePwYrhwFh3pqM2MeVKpFe9e3WcEFy
        aIize0rYu2UFKWOUWzJic08=
X-Google-Smtp-Source: ABdhPJyyKGsttvq6Tk4qNTIvMe64IroJ2hLsykUfDz6vfqJVkJt7XYpLXOaMoOPg4ewfqSbthEa6nw==
X-Received: by 2002:adf:8168:: with SMTP id 95mr36045331wrm.104.1593087042114;
        Thu, 25 Jun 2020 05:10:42 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id o29sm23743756wra.5.2020.06.25.05.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:10:41 -0700 (PDT)
Date:   Thu, 25 Jun 2020 14:10:40 +0200
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
Subject: Re: [PATCH v3 8/8] mm/page_alloc: remove a wrapper for
 alloc_migration_target()
Message-ID: <20200625121040.GI1320@dhcp22.suse.cz>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-9-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592892828-1934-9-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-06-20 15:13:48, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There is a well-defined standard migration target callback.
> Use it directly.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_alloc.c     |  9 +++++++--
>  mm/page_isolation.c | 11 -----------
>  2 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9808339..884dfb5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8359,6 +8359,11 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>  	unsigned long pfn = start;
>  	unsigned int tries = 0;
>  	int ret = 0;
> +	struct migration_target_control mtc = {
> +		.nid = zone_to_nid(cc->zone),
> +		.nmask = &node_states[N_MEMORY],
> +		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> +	};
>  
>  	migrate_prep();
>  
> @@ -8385,8 +8390,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>  							&cc->migratepages);
>  		cc->nr_migratepages -= nr_reclaimed;
>  
> -		ret = migrate_pages(&cc->migratepages, alloc_migrate_target,
> -				    NULL, 0, cc->mode, MR_CONTIG_RANGE);
> +		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
> +				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
>  	}
>  	if (ret < 0) {
>  		putback_movable_pages(&cc->migratepages);
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index adba031..242c031 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -306,14 +306,3 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
>  
>  	return pfn < end_pfn ? -EBUSY : 0;
>  }
> -
> -struct page *alloc_migrate_target(struct page *page, unsigned long private)
> -{
> -	struct migration_target_control mtc = {
> -		.nid = page_to_nid(page),
> -		.nmask = &node_states[N_MEMORY],
> -		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> -	};
> -
> -	return alloc_migration_target(page, (unsigned long)&mtc);
> -}
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
