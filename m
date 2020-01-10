Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C568C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5058120673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578641910;
	bh=rtOHPb5VBELvsqUwFnzqmBRxgpxFX3NiQM661iA+jMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ddjuTb45jjm0CR1VWYKtRxPMhIRb9UREN8a84Plori6VGcJU6qYKMHvcvSOqQfHb3
	 4O0hWnGGT7mLOaHifj4++kDQRssyWqtrYuwyrCVao5pPjaWYhpKyssywULMhcE0AtH
	 7RBhf1eOLDX2kYcM28Fxt0hSPAC64Zznen76XQcg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgAJHi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:38:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39380 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgAJHi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:38:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id 20so853968wmj.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 23:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZjWwBZ88Q84uyiPwE+9hZtJZXGqPOEuXwHPuM2hDV6M=;
        b=kvkgThAS+lgsmfQvEd8irKxvG0HKux2yPp6IGqBXm3bEFBtwjTJ54Y2EtQPvGAjdJx
         1UJfyNoPpmhb2DqxqD7zfC8JAArX7WRUZUdbAVwM17Ze8etGDaTXRfWqabNLmVBS5xy+
         r/G7iOjBCb2/d3UjkXI8sjrRPvLXoY221nRnPSDJRV65Ksy885sLUX9FqNjuHTtq1ZS+
         YqkmXvBKiDhfDmufmdQ7DOLAP8MohNCDgb5mPdvbti/I2FviDVF3Ws/JhJI2ifpMR2Is
         9hUf9jhCa9BZaDQsL9sM9Bush5TayxJLH2edLK8bWnc/OwufNd4wgqiyIbMZ4FI5zgmi
         bdbw==
X-Gm-Message-State: APjAAAVlOYJXHxO8Y2zVX2qK31VYlCINLzoST2xLHDjIxX7sq53ybZYu
        LNOOQ/pUkdKN3Z9qeu4lu/U=
X-Google-Smtp-Source: APXvYqxp1oB3tJAXijtVgqdDR+/kcuIcgwR9w6Y7iWy6vogK8Ly5w8bDeGZ3IGRlq4G6f6TF+Eu93Q==
X-Received: by 2002:a05:600c:2c08:: with SMTP id q8mr2409649wmg.45.1578641906642;
        Thu, 09 Jan 2020 23:38:26 -0800 (PST)
Received: from localhost (ip-37-188-146-105.eurotel.cz. [37.188.146.105])
        by smtp.gmail.com with ESMTPSA id u24sm1247888wml.10.2020.01.09.23.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 23:38:25 -0800 (PST)
Date:   Fri, 10 Jan 2020 08:38:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200110073822.GC29802@dhcp22.suse.cz>
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC Mel and Vlastimil]

On Thu 09-01-20 14:56:46, Cong Wang wrote:
> We observed kcompactd hung at __lock_page():
> 
>  INFO: task kcompactd0:57 blocked for more than 120 seconds.
>        Not tainted 4.19.56.x86_64 #1
>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>  kcompactd0      D    0    57      2 0x80000000
>  Call Trace:
>   ? __schedule+0x236/0x860
>   schedule+0x28/0x80
>   io_schedule+0x12/0x40
>   __lock_page+0xf9/0x120
>   ? page_cache_tree_insert+0xb0/0xb0
>   ? update_pageblock_skip+0xb0/0xb0
>   migrate_pages+0x88c/0xb90
>   ? isolate_freepages_block+0x3b0/0x3b0
>   compact_zone+0x5f1/0x870
>   kcompactd_do_work+0x130/0x2c0
>   ? __switch_to_asm+0x35/0x70
>   ? __switch_to_asm+0x41/0x70
>   ? kcompactd_do_work+0x2c0/0x2c0
>   ? kcompactd+0x73/0x180
>   kcompactd+0x73/0x180
>   ? finish_wait+0x80/0x80
>   kthread+0x113/0x130
>   ? kthread_create_worker_on_cpu+0x50/0x50
>   ret_from_fork+0x35/0x40
> 
> which faddr2line maps to:
> 
>   migrate_pages+0x88c/0xb90:
>   lock_page at include/linux/pagemap.h:483
>   (inlined by) __unmap_and_move at mm/migrate.c:1024
>   (inlined by) unmap_and_move at mm/migrate.c:1189
>   (inlined by) migrate_pages at mm/migrate.c:1419
> 
> Sometimes kcompactd eventually got out of this situation, sometimes not.

What does this mean exactly? Who is holding the page lock?

> I think for memory compaction, it is a best effort to migrate the pages,
> so it doesn't have to wait for I/O to complete. It is fine to call
> trylock_page() here, which is pretty much similar to
> buffer_migrate_lock_buffers().
> 
> Given MIGRATE_SYNC_LIGHT is used on compaction path, just relax the
> check for it.

The exact definition of MIGRATE_SYNC_LIGHT is a bit fuzzy but bailing
out on the page lock sounds too early to me. So far we have tried to
block on everything but the writeback which can take a lot of time.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: linux-mm@kvack.org
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  mm/migrate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 86873b6f38a7..df60026779d2 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1010,7 +1010,8 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>  	bool is_lru = !__PageMovable(page);
>  
>  	if (!trylock_page(page)) {
> -		if (!force || mode == MIGRATE_ASYNC)
> +		if (!force || mode == MIGRATE_ASYNC
> +			   || mode == MIGRATE_SYNC_LIGHT)
>  			goto out;
>  
>  		/*
> -- 
> 2.21.1
> 

-- 
Michal Hocko
SUSE Labs
