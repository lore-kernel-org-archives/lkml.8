Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE81DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF8862075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594122756;
	bh=sez30fKW/lNxoRpWJDNNdM5jZvgbAuapFH4HEtWh1I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2v4XUFd9BHvGALLRC0uJNOeVcCneSlMchw9iz+QEh3sCfGhZXkMLYGaZX24H6pQQk
	 RVUFmSd4Q0p/KEuRH1g4wYlZSXl2d6Y6Loinc67+kyBhKXKyNLm/93DxMvoDI7rVJq
	 1sMV8FQ3mej2IIKn17ohAq9h3ear3yOkY7Cu8MAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgGGLwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:52:35 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51285 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgGGLwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:52:35 -0400
Received: by mail-wm1-f66.google.com with SMTP id 22so42976999wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sNRnMMERLaDAwkTiaLWq2/DYQfERHbRbW2PRebsMmsk=;
        b=Okv/gs94m4Y9WUZNLUjp5ntM49U8vxRl8MbsUsILK4RoA1uSGXBxh0eXMlcofbjun+
         euv4BWIByBfYPCtgZwUoztSEw8eJg1QC+9kjavHq9bPDwnUtPREWLsj1/jnfAf10ET2e
         bUk6qxP1Gu5CFFOO1ZUIqteCGrO8PrCHGAjMuXdlKTOu1/QRqUeUoSOuoQWQSy4F+oy3
         acl8Qi9Ac28ynoTfhnRQsVv0Z1PcboYzdHx7lsYvVWV3eyQuNT8YpwTQYFkMyGibxzbI
         LaPl9gN317jyxCovFDH+tWsrDMnLRTooZ9P3km5c8BgOpBC3E9VATqq1bF+k1PxPyP8f
         Q3kw==
X-Gm-Message-State: AOAM530BCb76HguH6pYBYiAgyWEqO2cCu2UCgtHoIAsPeF5V9F1d7SZ2
        xOYDaTQI0kacwrAfAk3MAfI=
X-Google-Smtp-Source: ABdhPJx1SU5CWqhyJe8HpbJAvs4NhiE+c1yC8ANHKTFu23E0a1+VBH1Ime/1pXieVpzny4zX812wHg==
X-Received: by 2002:a1c:8117:: with SMTP id c23mr3638451wmd.157.1594122753188;
        Tue, 07 Jul 2020 04:52:33 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id y7sm784462wrt.11.2020.07.07.04.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 04:52:32 -0700 (PDT)
Date:   Tue, 7 Jul 2020 13:52:31 +0200
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
Subject: Re: [PATCH v4 11/11] mm/memory_hotplug: remove a wrapper for
 alloc_migration_target()
Message-ID: <20200707115231.GM5913@dhcp22.suse.cz>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-12-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594107889-32228-12-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-07-20 16:44:49, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> To calculate the correct node to migrate the page for hotplug, we need
> to check node id of the page. Wrapper for alloc_migration_target() exists
> for this purpose.
> 
> However, Vlastimil informs that all migration source pages come from
> a single node. In this case, we don't need to check the node id for each
> page and we don't need to re-set the target nodemask for each page by
> using the wrapper. Set up the migration_target_control once and use it for
> all pages.

yes, memory offlining only operates on a single zone. Have a look at
test_pages_in_a_zone().

> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c | 46 ++++++++++++++++++++++------------------------
>  1 file changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 86bc2ad..269e8ca 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1265,27 +1265,6 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
>  	return 0;
>  }
>  
> -static struct page *new_node_page(struct page *page, unsigned long private)
> -{
> -	nodemask_t nmask = node_states[N_MEMORY];
> -	struct migration_target_control mtc = {
> -		.nid = page_to_nid(page),
> -		.nmask = &nmask,
> -		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> -	};
> -
> -	/*
> -	 * try to allocate from a different node but reuse this node if there
> -	 * are no other online nodes to be used (e.g. we are offlining a part
> -	 * of the only existing node)
> -	 */
> -	node_clear(mtc.nid, *mtc.nmask);
> -	if (nodes_empty(*mtc.nmask))
> -		node_set(mtc.nid, *mtc.nmask);
> -
> -	return alloc_migration_target(page, (unsigned long)&mtc);
> -}
> -
>  static int
>  do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  {
> @@ -1345,9 +1324,28 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  		put_page(page);
>  	}
>  	if (!list_empty(&source)) {
> -		/* Allocate a new page from the nearest neighbor node */
> -		ret = migrate_pages(&source, new_node_page, NULL, 0,
> -					MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
> +		nodemask_t nmask = node_states[N_MEMORY];
> +		struct migration_target_control mtc = {
> +			.nmask = &nmask,
> +			.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> +		};
> +
> +		/*
> +		 * We have checked that migration range is on a single zone so
> +		 * we can use the nid of the first page to all the others.
> +		 */
> +		mtc.nid = page_to_nid(list_first_entry(&source, struct page, lru));
> +
> +		/*
> +		 * try to allocate from a different node but reuse this node
> +		 * if there are no other online nodes to be used (e.g. we are
> +		 * offlining a part of the only existing node)
> +		 */
> +		node_clear(mtc.nid, *mtc.nmask);
> +		if (nodes_empty(*mtc.nmask))
> +			node_set(mtc.nid, *mtc.nmask);
> +		ret = migrate_pages(&source, alloc_migration_target, NULL,
> +			(unsigned long)&mtc, MIGRATE_SYNC, MR_MEMORY_HOTPLUG);
>  		if (ret) {
>  			list_for_each_entry(page, &source, lru) {
>  				pr_warn("migrating pfn %lx failed ret:%d ",
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
