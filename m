Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AAFC2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E71220731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586268049;
	bh=2w5sH6h2pN9ftiCQ9aQDnwVXxqYKcZjwJu9ddTMXg3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JGUOapM4GHtbSR82pXVNJsIpE+WuHdWK0M7rym3X8qudzNf0JlrKyWbyvi/mBm67Y
	 7TZ0NaiGzEoox7aag1aRr2rhnPRUC34xD8iVZ5gzEKgH37FcdF8rm5901iKG0XPPWM
	 Jl/wENHcMXzEg1kqChA3VkDObeCOJ7DE/r9bOec0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgDGOAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:00:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33492 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbgDGOAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:00:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id a25so4072116wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=85uYzIYLpB2MYaLC8rzrAx+z7Cwj0As1rWHW278xDPo=;
        b=bElxHQHTu5bIIIC/hpUBloMSeq/yrvRPz5uEwUuwg2sbAaXB5AW0inVPBeYT2E8DKY
         y+1+/MiZkOeqXt96tdICX258TyX5KE1gsITA74Q1Gmgz4h3pdgH3ErFG+xVNo4nkrRTX
         q3aRUgOrZHmgoAe1OMhZarWVVTCX3+Z6bUrsmvSwr2OUnlkLJvbo6N6OKSGWJrqI0Jew
         wlbBDEEJJ+Of9TIIlM7QYPHq9N0sr3r+M0f2fSFk9l9o4NZy3Nf9Z0c/YmT2fiP0mNMK
         O+WN+WR9tw/jz3tfvc9D9PrWVbQutfzC2O4HOSgPoLfhAwmKdBRtFvL9fqiFR0Ph5Wta
         SQ+Q==
X-Gm-Message-State: AGi0Pub/qVvYDW9A8L5El9weKBAiX9rCB8mUK10JCYoIsX/jB8oh72lO
        yJFwOOwIR0y2LD4EEUb54+A=
X-Google-Smtp-Source: APiQypImQFPPXUMgFY6K5WDlmtafD7U+zunnmfuk3kzE+z1nl24TQB9VD0Ss3D+cVVp8jxutcNevsQ==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr3047177wrn.237.1586268045808;
        Tue, 07 Apr 2020 07:00:45 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id c6sm5637232wrm.0.2020.04.07.07.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:00:45 -0700 (PDT)
Date:   Tue, 7 Apr 2020 16:00:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 2/2] mm/memory_hotplug: remove
 is_mem_section_removable()
Message-ID: <20200407140044.GR18914@dhcp22.suse.cz>
References: <20200407135416.24093-1-david@redhat.com>
 <20200407135416.24093-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407135416.24093-3-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-04-20 15:54:16, David Hildenbrand wrote:
> Fortunately, all users of is_mem_section_removable() are gone. Get rid of
> it, including some now unnecessary functions.
> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memory_hotplug.h |  7 ----
>  mm/memory_hotplug.c            | 75 ----------------------------------

\o/

Thanks!

>  2 files changed, 82 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 93d9ada74ddd..7dca9cd6076b 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -314,19 +314,12 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
>  
> -extern bool is_mem_section_removable(unsigned long pfn, unsigned long nr_pages);
>  extern void try_offline_node(int nid);
>  extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
>  extern int remove_memory(int nid, u64 start, u64 size);
>  extern void __remove_memory(int nid, u64 start, u64 size);
>  
>  #else
> -static inline bool is_mem_section_removable(unsigned long pfn,
> -					unsigned long nr_pages)
> -{
> -	return false;
> -}
> -
>  static inline void try_offline_node(int nid) {}
>  
>  static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 47cf6036eb31..4d338d546d52 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1112,81 +1112,6 @@ int add_memory(int nid, u64 start, u64 size)
>  EXPORT_SYMBOL_GPL(add_memory);
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
> -/*
> - * A free page on the buddy free lists (not the per-cpu lists) has PageBuddy
> - * set and the size of the free page is given by page_order(). Using this,
> - * the function determines if the pageblock contains only free pages.
> - * Due to buddy contraints, a free page at least the size of a pageblock will
> - * be located at the start of the pageblock
> - */
> -static inline int pageblock_free(struct page *page)
> -{
> -	return PageBuddy(page) && page_order(page) >= pageblock_order;
> -}
> -
> -/* Return the pfn of the start of the next active pageblock after a given pfn */
> -static unsigned long next_active_pageblock(unsigned long pfn)
> -{
> -	struct page *page = pfn_to_page(pfn);
> -
> -	/* Ensure the starting page is pageblock-aligned */
> -	BUG_ON(pfn & (pageblock_nr_pages - 1));
> -
> -	/* If the entire pageblock is free, move to the end of free page */
> -	if (pageblock_free(page)) {
> -		int order;
> -		/* be careful. we don't have locks, page_order can be changed.*/
> -		order = page_order(page);
> -		if ((order < MAX_ORDER) && (order >= pageblock_order))
> -			return pfn + (1 << order);
> -	}
> -
> -	return pfn + pageblock_nr_pages;
> -}
> -
> -static bool is_pageblock_removable_nolock(unsigned long pfn)
> -{
> -	struct page *page = pfn_to_page(pfn);
> -	struct zone *zone;
> -
> -	/*
> -	 * We have to be careful here because we are iterating over memory
> -	 * sections which are not zone aware so we might end up outside of
> -	 * the zone but still within the section.
> -	 * We have to take care about the node as well. If the node is offline
> -	 * its NODE_DATA will be NULL - see page_zone.
> -	 */
> -	if (!node_online(page_to_nid(page)))
> -		return false;
> -
> -	zone = page_zone(page);
> -	pfn = page_to_pfn(page);
> -	if (!zone_spans_pfn(zone, pfn))
> -		return false;
> -
> -	return !has_unmovable_pages(zone, page, MIGRATE_MOVABLE,
> -				    MEMORY_OFFLINE);
> -}
> -
> -/* Checks if this range of memory is likely to be hot-removable. */
> -bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
> -{
> -	unsigned long end_pfn, pfn;
> -
> -	end_pfn = min(start_pfn + nr_pages,
> -			zone_end_pfn(page_zone(pfn_to_page(start_pfn))));
> -
> -	/* Check the starting page of each pageblock within the range */
> -	for (pfn = start_pfn; pfn < end_pfn; pfn = next_active_pageblock(pfn)) {
> -		if (!is_pageblock_removable_nolock(pfn))
> -			return false;
> -		cond_resched();
> -	}
> -
> -	/* All pageblocks in the memory block are likely to be hot-removable */
> -	return true;
> -}
> -
>  /*
>   * Confirm all pages in a range [start, end) belong to the same zone (skipping
>   * memory holes). When true, return the zone.
> -- 
> 2.25.1
> 

-- 
Michal Hocko
SUSE Labs
