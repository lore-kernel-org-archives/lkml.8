Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEA9C2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D64A02075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 02:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtYYqL8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgDHCsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 22:48:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49693 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726420AbgDHCsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 22:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586314116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZyQQtZLU5SDQeyZw8OwNdlYXeYXgHLQtXdRfXNahoSA=;
        b=AtYYqL8kcZZa3D8BRcjl9chmNr9Ofr2133uaZkVl/X1HKAyruPMIPIH4lnpi3Oi1QhTCFv
        8zf+/xtPWbtoDymBLnWxBAfommp4UUUEi/4CYAnSTdOO9cg2QuJ+Zqs+dYbOvYaJQA5e0e
        3qwFFDAzSUF8qNdmRjvEzfwI4P4nn9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-PN-p-qFFMKS4AMRQ-F6xCA-1; Tue, 07 Apr 2020 22:48:32 -0400
X-MC-Unique: PN-p-qFFMKS4AMRQ-F6xCA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 137D8801E66;
        Wed,  8 Apr 2020 02:48:31 +0000 (UTC)
Received: from localhost (ovpn-13-77.pek2.redhat.com [10.72.13.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4508B119596;
        Wed,  8 Apr 2020 02:48:27 +0000 (UTC)
Date:   Wed, 8 Apr 2020 10:48:24 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 2/2] mm/memory_hotplug: remove
 is_mem_section_removable()
Message-ID: <20200408024824.GR2402@MiWiFi-R3L-srv>
References: <20200407135416.24093-1-david@redhat.com>
 <20200407135416.24093-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407135416.24093-3-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/20 at 03:54pm, David Hildenbrand wrote:
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

Assuming no issue to patch 1, this one looks good.

Reviewed-by: Baoquan He <bhe@redhat.com>

> ---
>  include/linux/memory_hotplug.h |  7 ----
>  mm/memory_hotplug.c            | 75 ----------------------------------
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

