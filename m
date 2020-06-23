Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D15C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A08E620768
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592917380;
	bh=rVARgibcFkfZVUTWmBpOLFpWFa3uce069mhNNvSJess=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vLa6yKpptdRV+mrISKI+ucNcvnKztrZX7wbjp4Kuekjg6Jf+AiQd363s/hhgugBoK
	 cRuVZ9a8r4UShfP2Mrc6V0cAY51Hc/IyJ5S5bGh6IBWDd7P3gyrkXj4KhRKZ3te67A
	 TsTuPUhmqUMriSoE/EmeL5GGZMsJVD9QRoLTO3MU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbgFWNC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:02:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38166 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729504AbgFWNC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:02:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id z13so8676141wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 06:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UMeXj9gEu6mOkGGZVMZPSy0hX5G3SwwQMeJ+x4wb7Fw=;
        b=mtYMLEX+ynv+lB2sd5XZCgZBp4YtCerG7KychD1hvSZJe8Q11PYvrpuWFL1loS1FPB
         43n3hW7EmwcT4UFacExHW/EuSLhFWZAZWKGLi35siUGMI95D8/Vmm5LNXmFYwUVxTjsa
         FujQl2T4ttXi2CPk9PkJ5+eGvGPRFtHzKFEBStTDgIKRSnsMO0Hca6jbROz8jvut7UVW
         R9J6raekmT7xzGJERtGPYMHyvLQY3G+5nqUnGWBddiqlioUQl2KQxiw9WpLyOfSCry5q
         kJSTsyBnQ0BIyOuGWtsBbXFl7IUTxBLqAZ3u1XDLR5vxyrTf5Y9FLgaJAvW3iAbztGYH
         BqaQ==
X-Gm-Message-State: AOAM530VCHhA+LzSxAURPUc4dczKTatpi/509ZUA/Y+3r3yk57elMdfw
        PQXCK8bqu2EhCmqgrCnXOBk=
X-Google-Smtp-Source: ABdhPJy5YLCs+3mTOktQ35zlgLkwkeVniXT6WxubCHI0KBKjx7wVyKuJEluxQuqxkQhz1ERPHKQn3w==
X-Received: by 2002:adf:8444:: with SMTP id 62mr24144074wrf.278.1592917376580;
        Tue, 23 Jun 2020 06:02:56 -0700 (PDT)
Received: from localhost (ip-37-188-173-135.eurotel.cz. [37.188.173.135])
        by smtp.gmail.com with ESMTPSA id 185sm3722865wmz.22.2020.06.23.06.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 06:02:55 -0700 (PDT)
Date:   Tue, 23 Jun 2020 15:02:54 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 2/2] mm/page_alloc: drop nr_free_pagecache_pages()
Message-ID: <20200623130254.GZ31426@dhcp22.suse.cz>
References: <20200619132410.23859-1-david@redhat.com>
 <20200619132410.23859-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619132410.23859-3-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-06-20 15:24:10, David Hildenbrand wrote:
> nr_free_pagecache_pages() isn't used outside page_alloc.c anymore - and
> the name does not really help to understand what's going on. Let's inline
> it instead and add a comment.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

nr_free_pagecache_pages was an awkward name which kind of makes sense
but it is terribly confusing (e.g. there are pagecache consumers
restricted to lowmem zones only).

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/swap.h |  1 -
>  mm/page_alloc.c      | 16 ++--------------
>  2 files changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 124261acd5d0a..9bde6c6b2c045 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -327,7 +327,6 @@ void workingset_update_node(struct xa_node *node);
>  /* linux/mm/page_alloc.c */
>  extern unsigned long totalreserve_pages;
>  extern unsigned long nr_free_buffer_pages(void);
> -extern unsigned long nr_free_pagecache_pages(void);
>  
>  /* Definition of global_zone_page_state not available yet */
>  #define nr_free_pages() global_zone_page_state(NR_FREE_PAGES)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7b0dde69748c1..c38903d1b3b4d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5177,19 +5177,6 @@ unsigned long nr_free_buffer_pages(void)
>  }
>  EXPORT_SYMBOL_GPL(nr_free_buffer_pages);
>  
> -/**
> - * nr_free_pagecache_pages - count number of pages beyond high watermark
> - *
> - * nr_free_pagecache_pages() counts the number of pages which are beyond the
> - * high watermark within all zones.
> - *
> - * Return: number of pages beyond high watermark within all zones.
> - */
> -unsigned long nr_free_pagecache_pages(void)
> -{
> -	return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER_MOVABLE));
> -}
> -
>  static inline void show_node(struct zone *zone)
>  {
>  	if (IS_ENABLED(CONFIG_NUMA))
> @@ -5911,7 +5898,8 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
>  		__build_all_zonelists(pgdat);
>  		/* cpuset refresh routine should be here */
>  	}
> -	vm_total_pages = nr_free_pagecache_pages();
> +	/* Get the number of free pages beyond high watermark in all zones. */
> +	vm_total_pages = nr_free_zone_pages(gfp_zone(GFP_HIGHUSER_MOVABLE));
>  	/*
>  	 * Disable grouping by mobility if the number of pages in the
>  	 * system is too low to allow the mechanism to work. It would be
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
