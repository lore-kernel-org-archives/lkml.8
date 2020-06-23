Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE85C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB332072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592917148;
	bh=32rHaQckfr7uBuVXlnKsxL7O2Uy1aQ74r6JTVhlFq04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PS5mNERek9XB2IkvmsrdpjqVxdVJxAWCCeV+hR4RuYYGfyb9JEn2AHT2x3SJZsssC
	 Wq8ewz2AcfyQ27Fbzsp5GEBCsN7uTGsaxtlBmADzUywMkZT93C4/pOgM0T6xUGzkpH
	 9r8OIis2BePQHDP9hoMhdkLMURQfAlf7dwucbwJc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbgFWM7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:59:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55560 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbgFWM7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:59:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id g75so2878243wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 05:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pm8CgrHRnlUwqSe0XRvv7lrEFSzaymKtDcX81Pqa84E=;
        b=KyZwlOxgejV6D3y4VxnHTwvfEisqUs1/ekE8ARvQqa5l9IvmJgcSsjItcMkouwGmbb
         ExbxsvLxwz/Gym3C50Uxm4LTHe/PEDN2k5u7JDwGwhZhUEdCcdfC4ob2annzNvztPMdz
         R5xHNkgpxUNtSb3V5EondTqpniI1sRWI6jePKo4oDlugq+BMWLlYVg64h9YiUcrA0ReA
         OPDChCL1uiFWNdr6i8fDuA1m+Si7U1/J/mtI4kT5lxFpUV8d/2jBGxk+zQ6EN0GynjKg
         a6LAzV4fNzl5TJUjW1qbdduS7ojB2Bc6sOfrleo64X0ydvj4tmRltB8w/bs9MeANRWSF
         tKPQ==
X-Gm-Message-State: AOAM532ZSA8LbgiuHJJEnLCjDcm8kOVsDShnoDNdmgHmv5pxT+kHHgJ5
        z9ujaeXDmYKG9phA57R09d4=
X-Google-Smtp-Source: ABdhPJycsdkBT/Nlh8wfjUmgRJGThzMz5C1RHjGAXAfGhN7xTmeHRxqNMmtdByamsgCriX9oQxXvsg==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr6737992wmj.136.1592917144346;
        Tue, 23 Jun 2020 05:59:04 -0700 (PDT)
Received: from localhost (ip-37-188-173-135.eurotel.cz. [37.188.173.135])
        by smtp.gmail.com with ESMTPSA id j41sm23512411wre.12.2020.06.23.05.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 05:59:03 -0700 (PDT)
Date:   Tue, 23 Jun 2020 14:59:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Huang Ying <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 1/2] mm: drop vm_total_pages
Message-ID: <20200623125902.GY31426@dhcp22.suse.cz>
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

On Fri 19-06-20 15:24:09, David Hildenbrand wrote:
> The global variable "vm_total_pages" is a relict from older days. There
> is only a single user that reads the variable - build_all_zonelists() -
> and the first thing it does is updating it. Use a local variable in
> build_all_zonelists() instead and drop the local variable.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

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

-- 
Michal Hocko
SUSE Labs
