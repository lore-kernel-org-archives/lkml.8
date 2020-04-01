Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FE3C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7625020719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 19:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585771046;
	bh=RfDfeAokK4EcGZpiA0MMXyddKSGHzKejN/fXLQnHngE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mc/otbVq1RPg7QlxV0ruurXFTIEz8Mtlv/fdBoO71OIqujXj7h5tq0VcNsDQp32LK
	 CY6JXnibh36BTJO6LOibRxBV45RBZiuN+43icORwfssi1atIWCxm0hu69ItIAp+8HN
	 rFFY6ZSoL9HxfLQQuLCAJ8NN1U4OJyNbiY7YKKjo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbgDAT5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:57:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42588 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732397AbgDAT5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 15:57:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15so1533169wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 12:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BfeWMzPG/CsGUhWdM7BSSj5928zUrkpDblF4iYmrPrM=;
        b=Rde32TQCzLgSOn2ngo0FOwZLErprKtJSAMqJSqb83elGTk/tDr4Bul87T8irF0miD1
         qoTobTwqWm/NtCh+VZHVqe3xg0r7GI5YGD8OIo5u/ccjFpndoqGhB5aIx4MHOfJMz0zm
         LDgOrSJdUj/S/52EvUIFs0NBq/gDUjsB/hydMmBjBn/1HcNXA7TENxjn/fgM/f8H0xpt
         QGfjQNW+idng0LNe67craj05iUqaed8lmaiFea8NPlQ1bjgM5LfW2hzUsLpqaRgKbG2w
         3QQfgjrkb1CF12/HRKC83Z8DuSzWlpDpZbvLS5Tt+D1qUzG6BgKv37EbIMwSnAIKxwYb
         0mHQ==
X-Gm-Message-State: ANhLgQ2iApDuzGIyHRjAj9dbWvQyy4yPT5u38+7rJIZlpFCZMN/IZ9QE
        96IGavpa/21tknx9UMnGt+R9+wRZ
X-Google-Smtp-Source: ADFU+vsQeWJS1uRThwStGyZu2I+V/ABE4rBeGsFnkUIAkO6jmYykRntRGlDR5OiGA/xsHvUzxRwr7w==
X-Received: by 2002:a5d:6187:: with SMTP id j7mr28807567wru.419.1585771043649;
        Wed, 01 Apr 2020 12:57:23 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id a124sm3813626wmd.37.2020.04.01.12.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 12:57:22 -0700 (PDT)
Date:   Wed, 1 Apr 2020 21:57:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, dan.j.williams@intel.com,
        shile.zhang@linux.alibaba.com, daniel.m.jordan@oracle.com,
        ktkhai@virtuozzo.com, david@redhat.com, jmorris@namei.org,
        sashal@kernel.org
Subject: Re: [PATCH] mm: initialize deferred pages with interrupts enabled
Message-ID: <20200401195721.GZ22681@dhcp22.suse.cz>
References: <20200401193238.22544-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401193238.22544-1-pasha.tatashin@soleen.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-04-20 15:32:38, Pavel Tatashin wrote:
> Initializing struct pages is a long task and keeping interrupts disabled
> for the duration of this operation introduces a number of problems.
> 
> 1. jiffies are not updated for long period of time, and thus incorrect time
>    is reported. See proposed solution and discussion here:
>    lkml/20200311123848.118638-1-shile.zhang@linux.alibaba.com

http://lkml.kernel.org/r/20200311123848.118638-1-shile.zhang@linux.alibaba.com

> 2. It prevents farther improving deferred page initialization by allowing
>    inter-node multi-threading.
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

Fixes: 3a2d7fa8a3d5 ("mm: disable interrupts while initializing deferred pages")
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

I would much rather see pgdat_resize_lock completely out of both the
allocator and deferred init path altogether but this can be done in a
separate patch. This one looks slightly safer for stable backports.

To be completely honest I would love to see the resize lock go away
completely. That might need a deeper thought but I believe it is
something that has never been done properly.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/page_alloc.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..4498a13b372d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1792,6 +1792,13 @@ static int __init deferred_init_memmap(void *data)
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
> @@ -1812,8 +1819,6 @@ static int __init deferred_init_memmap(void *data)
>  	while (spfn < epfn)
>  		nr_pages += deferred_init_maxorder(&i, zone, &spfn, &epfn);
>  zone_empty:
> -	pgdat_resize_unlock(pgdat, &flags);
> -
>  	/* Sanity check that the next zone really is unpopulated */
>  	WARN_ON(++zid < MAX_NR_ZONES && populated_zone(++zone));
>  
> @@ -1854,18 +1859,6 @@ deferred_grow_zone(struct zone *zone, unsigned int order)
>  		return false;
>  
>  	pgdat_resize_lock(pgdat, &flags);
> -
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
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
