Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB935C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 19:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6ECA23380
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 19:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDl4pfBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbgFUT4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 15:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730288AbgFUT4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 15:56:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07973C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:56:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so2135167wrn.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zObDvLUMswNwhUW02zT5yK+sp9mpBr1EUjN7mrnt77Q=;
        b=ZDl4pfBUtctCnhhlx9zDx2Hk+w2sMpu1UA3aPxX+HmitTirspwdVQ6eD4/2BHrG77k
         OJjC1JkTCzIXVxzCGzZjnvoNYmqtXk/Sirekgtw1R/ygsAgpnlnyxjjOAkwk2DC850iu
         IPmYgNMeYwmxe1nj8dd4KoyJypPTvgfZyxKFvwBnV7gtszkZ75cy+E8/v6Mk5ScAVmVL
         UW9b1LZiJAe3/BXjQL4XWO+hxGn70TDNH9TtQxUjD/NLg8BIbRJLLPLo8Lruq469/BRT
         68Wn9SwjcqWXOK9x1SJ4i5jfq/Xi72Czl57A6GSObOftOHLXJvFyGY/CT1sa1B3WPhN8
         BSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zObDvLUMswNwhUW02zT5yK+sp9mpBr1EUjN7mrnt77Q=;
        b=uZhKSzxlBgyd4VH6NsNEfkZWDrlueUbBQifQQA2DFG+quqZ0KY2wxN0thFxPN10MvB
         AJPDvKTcRl5tU+2HGJjL4bRRbwfUsDN32GMhsrn56bVt8cjJ2qWuWMC1mqXuFW666SYK
         WQVfMgt2RoycYjl8kZ3XwIZa7FTnQkbpIDdRJgWhof/k7Cfe63wQSsGDWbV/miguRbLv
         1lVdA1L2ifaF0HxQzajhGT+zUQV5BZS3G9QGHrnZD2pS9OZDzX/DFKnawBkxJp21vg4Z
         k/KYe1csz/Y5IsptcgcmjAB2RbMaXC83EYPrgx4VA6vzhTy6Ox1ZSe1PWIEpCZK6YEtO
         tpvw==
X-Gm-Message-State: AOAM531iTJ72oU3eHfrGyKr8j/ZQpdfzm3aV3w3tDN+zTixQ4F/bfESI
        45xMx10AbSLDGsLmd6geyF7qBAOPYJYi88ujKTQ=
X-Google-Smtp-Source: ABdhPJznTkWlBLkF9J/5Y5X/cRZv0feLeO89ynKHcgU9a5BptQlj9/BWePCGHnYd8XhpEK8u+tv0Gr9YvfRabys3qq8=
X-Received: by 2002:a5d:5310:: with SMTP id e16mr13177181wrv.289.1592769409735;
 Sun, 21 Jun 2020 12:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200619132410.23859-1-david@redhat.com> <20200619132410.23859-2-david@redhat.com>
In-Reply-To: <20200619132410.23859-2-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Sun, 21 Jun 2020 21:56:38 +0200
Message-ID: <CAM9Jb+imokWSRDOHrtJAuCvvbKyjk28LVde2QMFc1YdBsZ=kLA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mm: drop vm_total_pages
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
>         kswapd_run(nid);
>         kcompactd_run(nid);
>
> -       vm_total_pages = nr_free_pagecache_pages();
> -
>         writeback_set_ratelimit();
>
>         memory_notify(MEM_ONLINE, &arg);
> @@ -1586,7 +1584,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
>                 kcompactd_stop(node);
>         }
>
> -       vm_total_pages = nr_free_pagecache_pages();
>         writeback_set_ratelimit();
>
>         memory_notify(MEM_OFFLINE, &arg);
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
> +       unsigned long vm_total_pages;
> +
>         if (system_state == SYSTEM_BOOTING) {
>                 build_all_zonelists_init();
>         } else {
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
>                                    struct reclaim_state *rs)

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
