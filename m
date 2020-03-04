Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AF8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B937206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 00:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="L24u5zqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbgCDAnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 19:43:05 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33472 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgCDAnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 19:43:05 -0500
Received: by mail-qk1-f196.google.com with SMTP id p62so7106qkb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 16:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wOjgETEggr7acXmXSIGKLYA84kpLrcA+aOyLjNXDSaw=;
        b=L24u5zqDkHCBPaOj1oSrn6IQPgzZGnryJZeVmIyRZITl1GRSlm2vWmgiDWPb6UlNCa
         hZZmmHLySwl37+ZRqpogB1VkAKXaTlIi7WqTlPaVS+b7YIhQa0b/wqwTo5IeAFn1Jtgl
         uCi+r0RahZAfqaPh+2nq/7T0OIQhkrwiCM+yTj3N8PxqLD6gz4GOCkDRl6++fYML/rQv
         jhm5o1hID6OaRxNCKMgayYNz62i7oEE7rc3Ms3nriNevMaotorpYTSYkKGBherhb5R9i
         nUVUhJccEJGYcjKXw/h5IZ5qOGnqlkEfdx8atzZtYl0pR/uAZs/zqfk6GYx4PFlrf2Jk
         A6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wOjgETEggr7acXmXSIGKLYA84kpLrcA+aOyLjNXDSaw=;
        b=mXgc9jFGobz5Qeac5C/Toemryl364ufEKQBtDYGHjlsTg8AvJ+bAWqoFI0e8F6hmat
         QQXRRQoCQgisJHbabMb+6vcaR7Yn76iFeOaPJ4+C3uq9IoboA0UaEXuERmVxOn5kpxKZ
         j9md/mAkfgLOqQaPGsBQJCzkhzYHIg0QsTUy206pr98XNBqv3EIPFr3KtYsmIN7OLDir
         TY42Sj8oSu5bMrnNCQ1RyOdT6k7oZmJoNYyQGXqWsMCgK60Vh165rntTwFe8epBIs4e3
         3LV+77f44akkz7l1RsaaInF8W3rH6Yjy5HWGtWvJen/MAgPQ+Gn1CUdDf6WS3aNOxwXv
         ssfg==
X-Gm-Message-State: ANhLgQ2WbOSxtXjMg8zEpe+mNIRVnHEl75hqT996SBJ+8n/W8LXrLo70
        sbwF9pJhvVfAx8aKRmIIDH0nLQ==
X-Google-Smtp-Source: ADFU+vtT815ZqojFX5Xd5JyTcZYq1D4yYzc3QBiv54PBkSjODKMU8WjxMws4JqGmk+Jx1vFpgBEn7g==
X-Received: by 2002:a37:7746:: with SMTP id s67mr634304qkc.127.1583282583953;
        Tue, 03 Mar 2020 16:43:03 -0800 (PST)
Received: from localhost (pool-96-232-200-60.nycmny.fios.verizon.net. [96.232.200.60])
        by smtp.gmail.com with ESMTPSA id 8sm44239qke.80.2020.03.03.16.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 16:43:03 -0800 (PST)
Date:   Tue, 3 Mar 2020 19:43:02 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Bharata B Rao <bharata@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: fork: fix kernel_stack memcg stats for various stack
 implementations
Message-ID: <20200304004302.GB76149@cmpxchg.org>
References: <20200303233550.251375-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303233550.251375-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 03:35:50PM -0800, Roman Gushchin wrote:
> Depending on CONFIG_VMAP_STACK and the THREAD_SIZE / PAGE_SIZE ratio
> the space for task stacks can be allocated using __vmalloc_node_range(),
> alloc_pages_node() and kmem_cache_alloc_node(). In the first and the
> second cases page->mem_cgroup pointer is set, but in the third it's
> not: memcg membership of a slab page should be determined using the
> memcg_from_slab_page() function, which looks at
> page->slab_cache->memcg_params.memcg . In this case, using
> mod_memcg_page_state() (as in account_kernel_stack()) is incorrect:
> page->mem_cgroup pointer is NULL even for pages charged to a non-root
> memory cgroup.
> 
> It can lead to kernel_stack per-memcg counters permanently showing 0
> on some architectures (depending on the configuration).
> 
> In order to fix it, let's introduce a mod_memcg_obj_state() helper,
> which takes a pointer to a kernel object as a first argument, uses
> mem_cgroup_from_obj() to get a RCU-protected memcg pointer and
> calls mod_memcg_state(). It allows to handle all possible
> configurations (CONFIG_VMAP_STACK and various THREAD_SIZE/PAGE_SIZE
> values) without spilling any memcg/kmem specifics into fork.c .
> 
> Note: this patch has been first posted as a part of the new slab
> controller patchset. This is a slightly updated version: the fixes
> tag has been added and the commit log was extended by the advice
> of Johannes Weiner. Because it's a fix that makes sense by itself,
> I'm re-posting it as a standalone patch.
> 
> Fixes: 4d96ba353075 ("mm: memcg/slab: stop setting page->mem_cgroup pointer for slab pages")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: stable@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks for pointing out the user impact.
