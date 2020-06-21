Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F949C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0D1247D2
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 14:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592750794;
	bh=5B5GkUamO8FPaTtrpWmKCsIxZc5JI93iNoW6QhBZYcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JvkIllfwAhHMNQ64gtixPkZEIzJLrXczhgNhUPwH7mZ8sDThV3JT7oIoTtL6aqapN
	 gvI472nY3fusXRzFcmjEd+ihDJyTB7vBnM3UCtk3yQRdSy0lnDqDjasd+jiFe6NmJA
	 WBTLgfyxYhkGNs45zUcNTa+G3FzEF6/NczOZ36AY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgFUOqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 10:46:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730154AbgFUOqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 10:46:32 -0400
Received: from kernel.org (unknown [87.70.7.255])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A2BE24740;
        Sun, 21 Jun 2020 14:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592750791;
        bh=5B5GkUamO8FPaTtrpWmKCsIxZc5JI93iNoW6QhBZYcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UvUI50Sn5K/atcS/ZRQ0Blm6KUTN5bezVjq4FTYjIwbYibcWgvxlfYhyG8NyYKt3l
         4yfdi77FJPCGjtddEKKHwzgnp7X01ncnY0JpBbP5EOgUxORx8mQ1pj/BRDtTiw11VY
         p3C+gnTCSwMr+iNJcWPDEoPu/5YRTYG9e/t5XmoM=
Date:   Sun, 21 Jun 2020 17:46:21 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 1/2] mm: drop vm_total_pages
Message-ID: <20200621144621.GF6571@kernel.org>
References: <20200619132410.23859-1-david@redhat.com>
 <20200619132410.23859-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619132410.23859-2-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 03:24:09PM +0200, David Hildenbrand wrote:
> The global variable "vm_total_pages" is a relict from older days. There
> is only a single user that reads the variable - build_all_zonelists() -
> and the first thing it does is updating it. Use a local variable in
> build_all_zonelists() instead and drop the local variable.

Nit:                                       ^ global

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Except the nit above

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/swap.h | 1 -
>  mm/memory_hotplug.c  | 3 ---
>  mm/page-writeback.c  | 6 ++----
>  mm/page_alloc.c      | 2 ++
>  mm/vmscan.c          | 5 -----
>  5 files changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 4c5974bb9ba94..124261acd5d0a 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -371,7 +371,6 @@ extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
>  extern unsigned long shrink_all_memory(unsigned long nr_pages);
>  extern int vm_swappiness;
>  extern int remove_mapping(struct address_space *mapping, struct page *page);
> -extern unsigned long vm_total_pages;
>  
>  extern unsigned long reclaim_pages(struct list_head *page_list);
>  #ifdef CONFIG_NUMA
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 9b34e03e730a4..d682781cce48d 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -835,8 +835,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	kswapd_run(nid);
>  	kcompactd_run(nid);
>  
> -	vm_total_pages = nr_free_pagecache_pages();
> -
>  	writeback_set_ratelimit();
>  
>  	memory_notify(MEM_ONLINE, &arg);
> @@ -1586,7 +1584,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  		kcompactd_stop(node);
>  	}
>  
> -	vm_total_pages = nr_free_pagecache_pages();
>  	writeback_set_ratelimit();
>  
>  	memory_notify(MEM_OFFLINE, &arg);
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 28b3e7a675657..4e4ddd67b71e5 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2076,13 +2076,11 @@ static int page_writeback_cpu_online(unsigned int cpu)
>   * Called early on to tune the page writeback dirty limits.
>   *
>   * We used to scale dirty pages according to how total memory
> - * related to pages that could be allocated for buffers (by
> - * comparing nr_free_buffer_pages() to vm_total_pages.
> + * related to pages that could be allocated for buffers.
>   *
>   * However, that was when we used "dirty_ratio" to scale with
>   * all memory, and we don't do that any more. "dirty_ratio"
> - * is now applied to total non-HIGHPAGE memory (by subtracting
> - * totalhigh_pages from vm_total_pages), and as such we can't
> + * is now applied to total non-HIGHPAGE memory, and as such we can't
>   * get into the old insane situation any more where we had
>   * large amounts of dirty pages compared to a small amount of
>   * non-HIGHMEM memory.
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0c435b2ed665c..7b0dde69748c1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5903,6 +5903,8 @@ build_all_zonelists_init(void)
>   */
>  void __ref build_all_zonelists(pg_data_t *pgdat)
>  {
> +	unsigned long vm_total_pages;
> +
>  	if (system_state == SYSTEM_BOOTING) {
>  		build_all_zonelists_init();
>  	} else {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b6d84326bdf2d..0010859747df2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -170,11 +170,6 @@ struct scan_control {
>   * From 0 .. 200.  Higher means more swappy.
>   */
>  int vm_swappiness = 60;
> -/*
> - * The total number of pages which are beyond the high watermark within all
> - * zones.
> - */
> -unsigned long vm_total_pages;
>  
>  static void set_task_reclaim_state(struct task_struct *task,
>  				   struct reclaim_state *rs)
> -- 
> 2.26.2
> 
> 

-- 
Sincerely yours,
Mike.
