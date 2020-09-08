Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E85C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DE3D21D7A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LojVD+pm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgIHJ5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:57:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35834 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728804AbgIHJ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599559029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=57pp/e9LHugR1a1fI9yzmG09N+ZeqaTEuLiJTJ+kcbw=;
        b=LojVD+pmIDE9POFcCuiyyku9ISUE5U1cnkS0um4CfsF14QN/LzJxNbaTfZn9fNOP9PPXHB
        ZAuMJtUfKS2rnB4W9LMTHzIQ0JsCMtkX6/lTONRKAvBibYSBpxQ6STxrD+1lZaD3gbARwU
        /e7CJFXFfyjR93z5rZU+mHadEOYXATY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-vGuvaRPqPOit19k4eRk7-g-1; Tue, 08 Sep 2020 05:57:05 -0400
X-MC-Unique: vGuvaRPqPOit19k4eRk7-g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B28F51005E7B;
        Tue,  8 Sep 2020 09:57:03 +0000 (UTC)
Received: from [10.36.115.46] (ovpn-115-46.ams2.redhat.com [10.36.115.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62E3B60C15;
        Tue,  8 Sep 2020 09:57:01 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] mm/memory_hotplug: drain per-cpu pages again
 during memory offline
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, osalvador@suse.de,
        richard.weiyang@gmail.com, vbabka@suse.cz, rientjes@google.com
References: <20200904151448.100489-1-pasha.tatashin@soleen.com>
 <20200904151448.100489-2-pasha.tatashin@soleen.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <c67aa414-15cf-2cef-e38b-a028e310d500@redhat.com>
Date:   Tue, 8 Sep 2020 11:57:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200904151448.100489-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.09.20 17:14, Pavel Tatashin wrote:
> There is a race during page offline that can lead to infinite loop:
> a page never ends up on a buddy list and __offline_pages() keeps
> retrying infinitely or until a termination signal is received.
> 
> Thread#1 - a new process:
> 
> load_elf_binary
>  begin_new_exec
>   exec_mmap
>    mmput
>     exit_mmap
>      tlb_finish_mmu
>       tlb_flush_mmu
>        release_pages
>         free_unref_page_list
>          free_unref_page_prepare
>           set_pcppage_migratetype(page, migratetype);
>              // Set page->index migration type below  MIGRATE_PCPTYPES
> 
> Thread#2 - hot-removes memory
> __offline_pages
>   start_isolate_page_range
>     set_migratetype_isolate
>       set_pageblock_migratetype(page, MIGRATE_ISOLATE);
>         Set migration type to MIGRATE_ISOLATE-> set
>         drain_all_pages(zone);
>              // drain per-cpu page lists to buddy allocator.
> 
> Thread#1 - continue
>          free_unref_page_commit
>            migratetype = get_pcppage_migratetype(page);
>               // get old migration type
>            list_add(&page->lru, &pcp->lists[migratetype]);
>               // add new page to already drained pcp list
> 
> Thread#2
> Never drains pcp again, and therefore gets stuck in the loop.
> 
> The fix is to try to drain per-cpu lists again after
> check_pages_isolated_cb() fails.
> 
> Fixes: c52e75935f8d ("mm: remove extra drain pages on pcp list")
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: stable@vger.kernel.org
> Acked-by: David Rientjes <rientjes@google.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/memory_hotplug.c | 14 ++++++++++++++
>  mm/page_isolation.c |  8 ++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e9d5ab5d3ca0..b11a269e2356 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1575,6 +1575,20 @@ static int __ref __offline_pages(unsigned long start_pfn,
>  		/* check again */
>  		ret = walk_system_ram_range(start_pfn, end_pfn - start_pfn,
>  					    NULL, check_pages_isolated_cb);
> +		/*
> +		 * per-cpu pages are drained in start_isolate_page_range, but if
> +		 * there are still pages that are not free, make sure that we
> +		 * drain again, because when we isolated range we might
> +		 * have raced with another thread that was adding pages to pcp
> +		 * list.
> +		 *
> +		 * Forward progress should be still guaranteed because
> +		 * pages on the pcp list can only belong to MOVABLE_ZONE
> +		 * because has_unmovable_pages explicitly checks for
> +		 * PageBuddy on freed pages on other zones.
> +		 */
> +		if (ret)
> +			drain_all_pages(zone);
>  	} while (ret);
>  
>  	/* Ok, all of our target is isolated.
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 242c03121d73..63a3db10a8c0 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -170,6 +170,14 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>   * pageblocks we may have modified and return -EBUSY to caller. This
>   * prevents two threads from simultaneously working on overlapping ranges.
>   *
> + * Please note that there is no strong synchronization with the page allocator
> + * either. Pages might be freed while their page blocks are marked ISOLATED.
> + * In some cases pages might still end up on pcp lists and that would allow
> + * for their allocation even when they are in fact isolated already. Depending
> + * on how strong of a guarantee the caller needs drain_all_pages might be needed
> + * (e.g. __offline_pages will need to call it after check for isolated range for
> + * a next retry).
> + *
>   * Return: the number of isolated pageblocks on success and -EBUSY if any part
>   * of range cannot be isolated.
>   */
> 

Acked-by: David Hildenbrand <david@redhat.com>

As an easy stable fix to be improved in the near future.

-- 
Thanks,

David / dhildenb

