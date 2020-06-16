Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B58C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F412D207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592311860;
	bh=Yf6e5zRy33wPKvW/8cCmN0VJKtAVV+9c3NkeNu9P9xk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MPclKmZ+58qafJZNU71Rv1CMjpx9CZ5sFX7AKdWH0o8EXGkW6cCKc/hx3/Aqx9keA
	 4CXi/p7wiVIeOgoBsZyw9JWPOarPQQ5nyBhV4QBsGjk5r0E7VDLgSMzmMol5tkfUBY
	 2KNVDGh6HqN0eUI/MjW3LmcoYgT2M03hbRlXXzC4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgFPMu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:50:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38002 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFPMuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:50:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id c35so14171790edf.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MHe1CSRo+cFsbAyB9G6KcYrIV0y8O1vCQU197CVP04g=;
        b=kGD8C8F/T48wvPah3Ud3eUJrYu5fAYURgVYkzsBx74++gb0r7cAziciRK5pPQmRD/7
         iWVOdiC+vpOj4VSv9BNNj1lnTZe6mNaV4RcTCuQtKIGgEALe88QWGLvSJM7mhARhU3bm
         ymZCdBRJc02tvHw2IRPqAdMnkloZpoWrelGkWQL5aQagVmBOknjX8k5u+IlqxDafwQxL
         lto/lQMl/dgu98sVD4UMuiEudvz3SioGny3ITPBKua4R6B3oqpwNReYJcRbK1X1thzsp
         z6YXCBKwU4m3APR5X+2n6l6HjecT8yrOAIDxlQ4eE64QHVV5hCMDWtHvC1ABP3TBN8h6
         Brcg==
X-Gm-Message-State: AOAM5324LJYw2jBPYmpmSCzFvgnvtF3Vr4wJie6+1f4swMXvIPQbXoSu
        MaazPWsyCqXTuAeMnTxhH6RDJIed
X-Google-Smtp-Source: ABdhPJxI7jCJkiT5VlYVvpsML9c32Ni2o1T5DMST3i+m0DGsAiF5WPIZcJ6rU+hL47+rYN7vV4MgSg==
X-Received: by 2002:aa7:c609:: with SMTP id h9mr2273544edq.155.1592311853181;
        Tue, 16 Jun 2020 05:50:53 -0700 (PDT)
Received: from localhost (ip-37-188-174-201.eurotel.cz. [37.188.174.201])
        by smtp.gmail.com with ESMTPSA id s2sm2904127edu.39.2020.06.16.05.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:50:52 -0700 (PDT)
Date:   Tue, 16 Jun 2020 14:50:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v1 2/3] mm/memory_hotplug: don't shuffle complete zone
 when onlining memory
Message-ID: <20200616125051.GH9499@dhcp22.suse.cz>
References: <20200616115213.13109-1-david@redhat.com>
 <20200616115213.13109-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616115213.13109-3-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16-06-20 13:52:12, David Hildenbrand wrote:
> Commit e900a918b098 ("mm: shuffle initial free memory to improve
> memory-side-cache utilization") introduced shuffling of free pages
> during system boot and whenever we online memory blocks.
> 
> However, whenever we online memory blocks, all pages that will be
> exposed to the buddy end up getting freed via __free_one_page(). In the
> general case, we free these pages in MAX_ORDER - 1 chunks, which
> corresponds to the shuffle order.
> 
> Inside __free_one_page(), we will already shuffle the newly onlined pages
> using "to_tail = shuffle_pick_tail();". Drop explicit zone shuffling on
> memory hotplug.
> 
> Note: When hotplugging a DIMM, each memory block (e.g., 128MB .. 2G on
> x86-64) will get onlined individually, resulting in a shuffle_zone() for
> every memory block getting onlined.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memory_hotplug.c |  3 ---
>  mm/shuffle.c        |  2 +-
>  mm/shuffle.h        | 12 ------------
>  3 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 9b34e03e730a4..845a517649c71 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -40,7 +40,6 @@
>  #include <asm/tlbflush.h>
>  
>  #include "internal.h"
> -#include "shuffle.h"
>  
>  /*
>   * online_page_callback contains pointer to current page onlining function.
> @@ -822,8 +821,6 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>  	zone->zone_pgdat->node_present_pages += onlined_pages;
>  	pgdat_resize_unlock(zone->zone_pgdat, &flags);
>  
> -	shuffle_zone(zone);
> -
>  	node_states_set_node(nid, &arg);
>  	if (need_zonelists_rebuild)
>  		build_all_zonelists(NULL);
> diff --git a/mm/shuffle.c b/mm/shuffle.c
> index dd13ab851b3ee..609c26aa57db0 100644
> --- a/mm/shuffle.c
> +++ b/mm/shuffle.c
> @@ -180,7 +180,7 @@ void __meminit __shuffle_free_memory(pg_data_t *pgdat)
>  	struct zone *z;
>  
>  	for (z = pgdat->node_zones; z < pgdat->node_zones + MAX_NR_ZONES; z++)
> -		shuffle_zone(z);
> +		__shuffle_zone(z);
>  }
>  
>  bool shuffle_pick_tail(void)
> diff --git a/mm/shuffle.h b/mm/shuffle.h
> index 4d79f03b6658f..657e2b9ec38dd 100644
> --- a/mm/shuffle.h
> +++ b/mm/shuffle.h
> @@ -30,14 +30,6 @@ static inline void shuffle_free_memory(pg_data_t *pgdat)
>  	__shuffle_free_memory(pgdat);
>  }
>  
> -extern void __shuffle_zone(struct zone *z);
> -static inline void shuffle_zone(struct zone *z)
> -{
> -	if (!static_branch_unlikely(&page_alloc_shuffle_key))
> -		return;
> -	__shuffle_zone(z);
> -}
> -
>  static inline bool is_shuffle_order(int order)
>  {
>  	if (!static_branch_unlikely(&page_alloc_shuffle_key))
> @@ -54,10 +46,6 @@ static inline void shuffle_free_memory(pg_data_t *pgdat)
>  {
>  }
>  
> -static inline void shuffle_zone(struct zone *z)
> -{
> -}
> -
>  static inline void page_alloc_shuffle(enum mm_shuffle_ctl ctl)
>  {
>  }
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
