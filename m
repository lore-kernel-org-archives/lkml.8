Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD18C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B2520678
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PZDQbdPQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404232AbgDCPSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:18:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43814 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404080AbgDCPSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585927098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=r9AChLwMSKg4YFhFPg7Imr1MIR4UOajnzauX4lYZuyo=;
        b=PZDQbdPQwBfaoswolp5a58ApfX/J7WHw8yg86m/hmU/Qf97F7Ke+QdqkfD3LzafDmIEofa
        iTQuGOFrnm6+0L8HgwLzM03K3UBZddtiosoJ1rDm7ynKQ6zT82kxfa1QXpZe8drsQiBBig
        xf38gXW1c//spvjHvcg39xTjq7ZgDtk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-RQ2bUpOsNvSWSqDlTR1f2g-1; Fri, 03 Apr 2020 11:18:14 -0400
X-MC-Unique: RQ2bUpOsNvSWSqDlTR1f2g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF257800D50;
        Fri,  3 Apr 2020 15:18:12 +0000 (UTC)
Received: from [10.36.112.213] (ovpn-112-213.ams2.redhat.com [10.36.112.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B52299E01;
        Fri,  3 Apr 2020 15:18:09 +0000 (UTC)
Subject: Re: [PATCH v4 2/3] mm: initialize deferred pages with interrupts
 enabled
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        ktkhai@virtuozzo.com, jmorris@namei.org, sashal@kernel.org,
        vbabka@suse.cz
References: <20200403140952.17177-1-pasha.tatashin@soleen.com>
 <20200403140952.17177-3-pasha.tatashin@soleen.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <06a1b582-368e-926a-2f77-c320c08a3450@redhat.com>
Date:   Fri, 3 Apr 2020 17:18:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403140952.17177-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.04.20 16:09, Pavel Tatashin wrote:
> Initializing struct pages is a long task and keeping interrupts disabled
> for the duration of this operation introduces a number of problems.
> 
> 1. jiffies are not updated for long period of time, and thus incorrect time
>    is reported. See proposed solution and discussion here:
>    lkml/20200311123848.118638-1-shile.zhang@linux.alibaba.com
> 2. It prevents farther improving deferred page initialization by allowing
>    intra-node multi-threading.
> 
> We are keeping interrupts disabled to solve a rather theoretical problem
> that was never observed in real world (See 3a2d7fa8a3d5).
> 
> Lets keep interrupts enabled. In case we ever encounter a scenario where
> an interrupt thread wants to allocate large amount of memory this early in
> boot we can deal with that by growing zone (see deferred_grow_zone()) by
> the needed amount before starting deferred_init_memmap() threads.
> 
> Before:
> [    1.232459] node 0 initialised, 12058412 pages in 1ms
> 
> After:
> [    1.632580] node 0 initialised, 12051227 pages in 436ms
> 
> Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages")
> Cc: stable@vger.kernel.org # 4.17+
> 
> Reported-by: Shile Zhang <shile.zhang@linux.alibaba.com>
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/mmzone.h |  2 ++
>  mm/page_alloc.c        | 20 +++++++-------------
>  2 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index e84d448988b6..ac6a8245f063 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -723,6 +723,8 @@ typedef struct pglist_data {
>  	/*
>  	 * Must be held any time you expect node_start_pfn,
>  	 * node_present_pages, node_spanned_pages or nr_zones to stay constant.
> +	 * Also synchronizes pgdat->first_deferred_pfn during deferred page
> +	 * init.
>  	 *
>  	 * pgdat_resize_lock() and pgdat_resize_unlock() are provided to
>  	 * manipulate node_size_lock without checking for CONFIG_MEMORY_HOTPLUG
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d95bfd328107..5ffa8d7e5545 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1784,6 +1784,13 @@ static int __init deferred_init_memmap(void *data)
>  	BUG_ON(pgdat->first_deferred_pfn > pgdat_end_pfn(pgdat));
>  	pgdat->first_deferred_pfn = ULONG_MAX;
>  
> +	/*
> +	 * Once we unlock here, the zone cannot be grown anymore, thus if an
> +	 * interrupt thread must allocate this early in boot, zone must be
> +	 * pre-grown prior to start of deferred page initialization.
> +	 */
> +	pgdat_resize_unlock(pgdat, &flags);
> +
>  	/* Only the highest zone is deferred so find it */
>  	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
>  		zone = pgdat->node_zones + zid;
> @@ -1806,8 +1813,6 @@ static int __init deferred_init_memmap(void *data)
>  		touch_nmi_watchdog();
>  	}
>  zone_empty:
> -	pgdat_resize_unlock(pgdat, &flags);
> -
>  	/* Sanity check that the next zone really is unpopulated */
>  	WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
>  
> @@ -1849,17 +1854,6 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
>  
>  	pgdat_resize_lock(pgdat, &flags);
>  
> -	/*
> -	 * If deferred pages have been initialized while we were waiting for
> -	 * the lock, return true, as the zone was grown.  The caller will retry
> -	 * this zone.  We won't return to this function since the caller also
> -	 * has this static branch.
> -	 */
> -	if (!static_branch_unlikely(&deferred_pages)) {
> -		pgdat_resize_unlock(pgdat, &flags);
> -		return true;
> -	}
> -
>  	/*
>  	 * If someone grew this zone while we were waiting for spinlock, return
>  	 * true, as there might be enough pages already.
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

