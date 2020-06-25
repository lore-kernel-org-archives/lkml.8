Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF09EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F3A20720
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593086996;
	bh=YtvJmzxiCsWnM5agnWOPwEuSMfb0y1g8sUyc7NjR5Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tg/GRfDXYdnyaPDlMHKwd5lw0kIEluwBl9ZIPBR6/5oZAmDH1mXqzeTyN5mvbloAq
	 zjTOkiX88ZIjAA+xkch1FYW+NAmBC8VnHnMPLGCpV4a8E/eLPeLfb8h52qzNgnwuo/
	 ADxOVeS1qdsEe/NIJcg/jO1Su943D9evJCRS6ExA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404509AbgFYMJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:09:54 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55640 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404222AbgFYMJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:09:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id g75so5295366wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 05:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7ITcFTPhqH0yFOromZtekoS/tTUxNAq+U9QVX/lhl28=;
        b=IY5yAJMvqCCiYYl69gSMEWnxGA1ppm9tZtIQ0nY95v2PT14V4fuBXw5XFKgzBRImfu
         3OJnEv58J4uiIPreYWc7cg0CJ3SaOLaugaRllDWeI8/laAL/GD2uFgwLSP3q+iwWSx3j
         NUEmFlqoWaW8B5RAyvl8Xz6tK/d2fmvJ3XBtv01XL45aff72CqX0aWVVPGI3G32qmZno
         JvNwaSleGJJuODwdsLKy+SGmJbpfr6jLWpc6FErVTzfLVi+bzF5BiuZElguhYg1J5+uF
         Qx+UftIllF0UAERuj06aWqU9XMkJxBgnU0qlq6bz5FWFOKYx+ufw73AU6kkjjBXMZvFJ
         29eQ==
X-Gm-Message-State: AOAM531qEzZJxUmkdlJQ+0ecKnTeXnA1Bur+JipCdUKH9/h5UZkPCyGP
        /xN1cuk+R/o6sPn99TVut8o=
X-Google-Smtp-Source: ABdhPJxhjAIFp0j2T3CJ1uC8RQuRiiUpxlMjDETjqjLgOD8JmBIQvHas/txrISYnid6IfswG8QQNTA==
X-Received: by 2002:a05:600c:2058:: with SMTP id p24mr3029922wmg.74.1593086990388;
        Thu, 25 Jun 2020 05:09:50 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id x18sm11707853wmi.35.2020.06.25.05.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:09:49 -0700 (PDT)
Date:   Thu, 25 Jun 2020 14:09:48 +0200
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
Subject: Re: [PATCH v3 7/8] mm/mempolicy: use a standard migration target
 allocation callback
Message-ID: <20200625120948.GH1320@dhcp22.suse.cz>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-8-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592892828-1934-8-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-06-20 15:13:47, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There is a well-defined migration target allocation callback.
> Use it.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/internal.h  |  1 -
>  mm/mempolicy.c | 30 ++++++------------------------
>  mm/migrate.c   |  8 ++++++--
>  3 files changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index fb7f7fe..4f9f6b6 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -613,7 +613,6 @@ static inline bool is_migrate_highatomic_page(struct page *page)
>  }
>  
>  void setup_zone_pageset(struct zone *zone);
> -extern struct page *alloc_new_node_page(struct page *page, unsigned long node);
>  
>  struct migration_target_control {
>  	int nid;		/* preferred node id */
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index a3abf64..85a3f21 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1065,28 +1065,6 @@ static int migrate_page_add(struct page *page, struct list_head *pagelist,
>  	return 0;
>  }
>  
> -/* page allocation callback for NUMA node migration */
> -struct page *alloc_new_node_page(struct page *page, unsigned long node)
> -{
> -	if (PageHuge(page)) {
> -		return alloc_huge_page_nodemask(
> -			page_hstate(compound_head(page)), node,
> -			NULL, __GFP_THISNODE, false);
> -	} else if (PageTransHuge(page)) {
> -		struct page *thp;
> -
> -		thp = alloc_pages_node(node,
> -			(GFP_TRANSHUGE | __GFP_THISNODE),
> -			HPAGE_PMD_ORDER);
> -		if (!thp)
> -			return NULL;
> -		prep_transhuge_page(thp);
> -		return thp;
> -	} else
> -		return __alloc_pages_node(node, GFP_HIGHUSER_MOVABLE |
> -						    __GFP_THISNODE, 0);
> -}
> -
>  /*
>   * Migrate pages from one node to a target node.
>   * Returns error or the number of pages not migrated.
> @@ -1097,6 +1075,10 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
>  	nodemask_t nmask;
>  	LIST_HEAD(pagelist);
>  	int err = 0;
> +	struct migration_target_control mtc = {
> +		.nid = dest,
> +		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE,
> +	};
>  
>  	nodes_clear(nmask);
>  	node_set(source, nmask);
> @@ -1111,8 +1093,8 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
>  			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
>  
>  	if (!list_empty(&pagelist)) {
> -		err = migrate_pages(&pagelist, alloc_new_node_page, NULL, dest,
> -					MIGRATE_SYNC, MR_SYSCALL);
> +		err = migrate_pages(&pagelist, alloc_migration_target, NULL,
> +				(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
>  		if (err)
>  			putback_movable_pages(&pagelist);
>  	}
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 7c4cd74..1c943b0 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1590,9 +1590,13 @@ static int do_move_pages_to_node(struct mm_struct *mm,
>  		struct list_head *pagelist, int node)
>  {
>  	int err;
> +	struct migration_target_control mtc = {
> +		.nid = node,
> +		.gfp_mask = GFP_HIGHUSER_MOVABLE | __GFP_THISNODE,
> +	};
>  
> -	err = migrate_pages(pagelist, alloc_new_node_page, NULL, node,
> -			MIGRATE_SYNC, MR_SYSCALL);
> +	err = migrate_pages(pagelist, alloc_migration_target, NULL,
> +			(unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL);
>  	if (err)
>  		putback_movable_pages(pagelist);
>  	return err;
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
