Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A671C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46EE520B80
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588170171;
	bh=21kO83dMS6I/arOZxlhQVuoO7KrRp7NNyXm0B3AR3NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lhEBk+HI7x519f1IOWKIgY3XhWyFIRzKPJdOsp1Lkmfh2S10Hz/Pfe34nW9cp+gZu
	 2wAPtkHtJcZEvjOqAIfbsumTsnRM+Ctt61iW1yby7R4V1SxRurD54pruIRpgUvSaEP
	 1pHAp4UGc98J0svdhktmfBhSmQ6w0Ky8f/HR2z7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgD2OWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:22:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56236 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgD2OWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:22:50 -0400
Received: by mail-wm1-f65.google.com with SMTP id e26so2235001wmk.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=omYO6xoVUBqJSlB3DlsFxwqiaIbrxIKjZ56KmIA/PNY=;
        b=BsBi2l4tC/QkIXU9v2cpNGcpMtEZNF5An1C+N5YvsVeqE0tO1dL1FdIHc5815czBly
         Tr6Co/pZtmRjv/Tz3RG74Po42rlKg1okX/GuV0OuTGqXFT7Nub2E3+hS/xxIGnfgu8tS
         7y0oJI6oZxOa4z7rlRizz/96lveOHGN+6vjISiaQN+Z+0n9Tn+FGUZpWgvpDI561wUQC
         tNBIIzPJP7ZjtsT8jW3/JQnVDum3JV944OeA+FUG7nbk6545M07XzH7iZkgK8BY4x/FA
         IbBHHag9N7AIN6rYCafxQzHROdTddVwcwTMzJT3bmvdU9Hui8OQH5CoVihc1TwN6xrQs
         HWoA==
X-Gm-Message-State: AGi0PubqmxNkrOPop0DmZBFNxdrO+JHXGOYhYQfPyEL1emillvY/DpU3
        pT2hSF7eju4J9fiNJDMv/x8=
X-Google-Smtp-Source: APiQypJTl/ybjqxjYD+JXjeLclQXId4nWuN2OMN7/iLaZttrQTZnkgR0CEUgtolI8S72Oxta2pCe+Q==
X-Received: by 2002:a05:600c:258:: with SMTP id 24mr3495136wmj.73.1588170167932;
        Wed, 29 Apr 2020 07:22:47 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id q10sm28827612wrv.95.2020.04.29.07.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:22:47 -0700 (PDT)
Date:   Wed, 29 Apr 2020 16:22:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        v.narang@samsung.com
Subject: Re: [PATCH v3] mm/vmscan.c: change prototype for shrink_page_list
Message-ID: <20200429142245.GH28637@dhcp22.suse.cz>
References: <CGME20200429135110epcas5p4377ad1a5d783d0634ab06e23993116a7@epcas5p4.samsung.com>
 <1588168259-25604-1-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588168259-25604-1-git-send-email-maninder1.s@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-04-20 19:20:59, Maninder Singh wrote:
> 'commit 3c710c1ad11b ("mm, vmscan:
> extract shrink_page_list reclaim counters into a struct")'
> 
> changed data type for the function,
> so changing return type for funciton and its caller.
> 
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

You could have kept my ack from v1
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
> v1 -> v2: position of variable changed mistakenly, thus reverted.
> v2 -> v3: Don't change position of any variable, thus reverted.
> 	  if required then need to send by separate patch.
> 
>  mm/internal.h   |  2 +-
>  mm/page_alloc.c |  2 +-
>  mm/vmscan.c     | 24 ++++++++++++------------
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index b5634e7..c3eeec8 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -527,7 +527,7 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
>          unsigned long, unsigned long);
>  
>  extern void set_pageblock_order(void);
> -unsigned long reclaim_clean_pages_from_list(struct zone *zone,
> +unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  					    struct list_head *page_list);
>  /* The ALLOC_WMARK bits are used as an index to zone->watermark */
>  #define ALLOC_WMARK_MIN		WMARK_MIN
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1385d78..f17d88c6 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8416,7 +8416,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
>  					unsigned long start, unsigned long end)
>  {
>  	/* This function is based on compact_zone() from compaction.c. */
> -	unsigned long nr_reclaimed;
> +	unsigned int nr_reclaimed;
>  	unsigned long pfn = start;
>  	unsigned int tries = 0;
>  	int ret = 0;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b06868f..7631725 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1066,17 +1066,17 @@ static void page_check_dirty_writeback(struct page *page,
>  /*
>   * shrink_page_list() returns the number of reclaimed pages
>   */
> -static unsigned long shrink_page_list(struct list_head *page_list,
> -				      struct pglist_data *pgdat,
> -				      struct scan_control *sc,
> -				      enum ttu_flags ttu_flags,
> -				      struct reclaim_stat *stat,
> -				      bool ignore_references)
> +static unsigned int shrink_page_list(struct list_head *page_list,
> +				     struct pglist_data *pgdat,
> +				     struct scan_control *sc,
> +				     enum ttu_flags ttu_flags,
> +				     struct reclaim_stat *stat,
> +				     bool ignore_references)
>  {
>  	LIST_HEAD(ret_pages);
>  	LIST_HEAD(free_pages);
> -	unsigned nr_reclaimed = 0;
> -	unsigned pgactivate = 0;
> +	unsigned int nr_reclaimed = 0;
> +	unsigned int pgactivate = 0;
>  
>  	memset(stat, 0, sizeof(*stat));
>  	cond_resched();
> @@ -1483,7 +1483,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  	return nr_reclaimed;
>  }
>  
> -unsigned long reclaim_clean_pages_from_list(struct zone *zone,
> +unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  					    struct list_head *page_list)
>  {
>  	struct scan_control sc = {
> @@ -1492,7 +1492,7 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
>  		.may_unmap = 1,
>  	};
>  	struct reclaim_stat dummy_stat;
> -	unsigned long ret;
> +	unsigned int ret;
>  	struct page *page, *next;
>  	LIST_HEAD(clean_pages);
>  
> @@ -1900,7 +1900,7 @@ static int current_may_throttle(void)
>  {
>  	LIST_HEAD(page_list);
>  	unsigned long nr_scanned;
> -	unsigned long nr_reclaimed = 0;
> +	unsigned int nr_reclaimed = 0;
>  	unsigned long nr_taken;
>  	struct reclaim_stat stat;
>  	int file = is_file_lru(lru);
> @@ -2096,7 +2096,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  unsigned long reclaim_pages(struct list_head *page_list)
>  {
>  	int nid = NUMA_NO_NODE;
> -	unsigned long nr_reclaimed = 0;
> +	unsigned int nr_reclaimed = 0;
>  	LIST_HEAD(node_page_list);
>  	struct reclaim_stat dummy_stat;
>  	struct page *page;
> -- 
> 1.9.1
> 

-- 
Michal Hocko
SUSE Labs
