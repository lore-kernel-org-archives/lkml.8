Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE340C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955D4208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmUHQxdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732854AbgFSNrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729134AbgFSNrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:47:17 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EADC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:47:16 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id o26so7691849edq.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JBVkaRaZWirU7e3k0xkGSUsqcHn/FjRRebjp9wA0kB8=;
        b=PmUHQxdSVYbxZQbONx6B+oZ8nBWdOmiTadNXvPbf+fTPZOAkpbSDfCM9sjeZVZXvP3
         Y9+uHvXg0JAI17x3lFfRaHVAXnv/GKBoFuxDetSL9lhvxueuY6ibQB+SDxiUfM5lyBHo
         /3ZRVcLHMl2YTDBHw81i3xQLV6wrlGT2yVJZcCz4iMY2T3r7YkX13jkj62NvakjyJO8R
         Mbru/lhwmz9Sjp7ATaJTPVejdfXGrhrUx4EO9fVFzNJgXI4/892LkgER1CMK4rkkJG66
         y9odYkltbdM4Ue2eQmAfxcUQiZN+D9YKew2Lp3Rq6G06WqJ0IcYyXwjuA7ARvkd3QjVg
         OaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JBVkaRaZWirU7e3k0xkGSUsqcHn/FjRRebjp9wA0kB8=;
        b=rX0caan9bkaY3k0GB6DYlV7onzl4R3ooVKAVRyoRNzhCZPRLHKTA97nG7BKd8gNo63
         mamEOYj3GrM+VUWo1ZL8y2Pgyy6WThS11aljwLoJKFiuaoKydMJLgfmbPYMjQujHih3p
         sBTWjKV9wA+79h8399nzGiEgbTdt4Wt8iDoMcTTeQqU22sZh7jsAGCwkOR+RklL9UmWt
         BsOlZsgcOh5Tez8+68qytoDSMPIjV5JxQtdP8DtaOT8S4kmIoR0rqfr47A8Vs8xDcNUD
         yJyzTA6yweRRgO0U4hsohmBwHvW/YGu3+CcOSc9tBQttXQRC71442jWhuZWN9eY+Vjni
         rwMA==
X-Gm-Message-State: AOAM531as5J67V62Ktqqj5PdgMVO4ntthp4n/ZY4sYBOnNTCqpLPEaq+
        9yZpfaKihMDTgiXlGVr2VG8=
X-Google-Smtp-Source: ABdhPJxsewLRbfv6IzL/Ko1MBXdF0ua15skXMbkoq9vo1+oTuZhfm0tFLfvjflzO1HjqtGHiD7Ukrw==
X-Received: by 2002:a05:6402:b5c:: with SMTP id bx28mr3426773edb.145.1592574435622;
        Fri, 19 Jun 2020 06:47:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id o90sm4679511edb.60.2020.06.19.06.47.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jun 2020 06:47:14 -0700 (PDT)
Date:   Fri, 19 Jun 2020 13:47:14 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 1/2] mm: drop vm_total_pages
Message-ID: <20200619134714.yaxol5ckemhffgqm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200619132410.23859-1-david@redhat.com>
 <20200619132410.23859-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619132410.23859-2-david@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 03:24:09PM +0200, David Hildenbrand wrote:
>The global variable "vm_total_pages" is a relict from older days. There
>is only a single user that reads the variable - build_all_zonelists() -
>and the first thing it does is updating it. Use a local variable in
>build_all_zonelists() instead and drop the local variable.
>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: Johannes Weiner <hannes@cmpxchg.org>
>Cc: Michal Hocko <mhocko@suse.com>
>Cc: Huang Ying <ying.huang@intel.com>
>Cc: Minchan Kim <minchan@kernel.org>
>Cc: Wei Yang <richard.weiyang@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
> include/linux/swap.h | 1 -
> mm/memory_hotplug.c  | 3 ---
> mm/page-writeback.c  | 6 ++----
> mm/page_alloc.c      | 2 ++
> mm/vmscan.c          | 5 -----
> 5 files changed, 4 insertions(+), 13 deletions(-)
>
>diff --git a/include/linux/swap.h b/include/linux/swap.h
>index 4c5974bb9ba94..124261acd5d0a 100644
>--- a/include/linux/swap.h
>+++ b/include/linux/swap.h
>@@ -371,7 +371,6 @@ extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
> extern unsigned long shrink_all_memory(unsigned long nr_pages);
> extern int vm_swappiness;
> extern int remove_mapping(struct address_space *mapping, struct page *page);
>-extern unsigned long vm_total_pages;
> 
> extern unsigned long reclaim_pages(struct list_head *page_list);
> #ifdef CONFIG_NUMA
>diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>index 9b34e03e730a4..d682781cce48d 100644
>--- a/mm/memory_hotplug.c
>+++ b/mm/memory_hotplug.c
>@@ -835,8 +835,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
> 	kswapd_run(nid);
> 	kcompactd_run(nid);
> 
>-	vm_total_pages = nr_free_pagecache_pages();
>-
> 	writeback_set_ratelimit();
> 
> 	memory_notify(MEM_ONLINE, &arg);
>@@ -1586,7 +1584,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
> 		kcompactd_stop(node);
> 	}
> 
>-	vm_total_pages = nr_free_pagecache_pages();
> 	writeback_set_ratelimit();
> 
> 	memory_notify(MEM_OFFLINE, &arg);
>diff --git a/mm/page-writeback.c b/mm/page-writeback.c
>index 28b3e7a675657..4e4ddd67b71e5 100644
>--- a/mm/page-writeback.c
>+++ b/mm/page-writeback.c
>@@ -2076,13 +2076,11 @@ static int page_writeback_cpu_online(unsigned int cpu)
>  * Called early on to tune the page writeback dirty limits.
>  *
>  * We used to scale dirty pages according to how total memory
>- * related to pages that could be allocated for buffers (by
>- * comparing nr_free_buffer_pages() to vm_total_pages.
>+ * related to pages that could be allocated for buffers.
>  *
>  * However, that was when we used "dirty_ratio" to scale with
>  * all memory, and we don't do that any more. "dirty_ratio"
>- * is now applied to total non-HIGHPAGE memory (by subtracting
>- * totalhigh_pages from vm_total_pages), and as such we can't
>+ * is now applied to total non-HIGHPAGE memory, and as such we can't
>  * get into the old insane situation any more where we had
>  * large amounts of dirty pages compared to a small amount of
>  * non-HIGHMEM memory.
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index 0c435b2ed665c..7b0dde69748c1 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -5903,6 +5903,8 @@ build_all_zonelists_init(void)
>  */
> void __ref build_all_zonelists(pg_data_t *pgdat)
> {
>+	unsigned long vm_total_pages;
>+
> 	if (system_state == SYSTEM_BOOTING) {
> 		build_all_zonelists_init();
> 	} else {
>diff --git a/mm/vmscan.c b/mm/vmscan.c
>index b6d84326bdf2d..0010859747df2 100644
>--- a/mm/vmscan.c
>+++ b/mm/vmscan.c
>@@ -170,11 +170,6 @@ struct scan_control {
>  * From 0 .. 200.  Higher means more swappy.
>  */
> int vm_swappiness = 60;
>-/*
>- * The total number of pages which are beyond the high watermark within all
>- * zones.
>- */
>-unsigned long vm_total_pages;
> 
> static void set_task_reclaim_state(struct task_struct *task,
> 				   struct reclaim_state *rs)
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
