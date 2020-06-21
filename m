Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AE7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 19:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 154DF24804
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 19:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL8ZpLFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbgFUT5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 15:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730288AbgFUT5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 15:57:52 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0329AC061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:57:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so6898240wrv.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVtO0mf5+18xL2wyRUh4C8eKDbifEpFUpjq+V/g/lJQ=;
        b=WL8ZpLFio6q8DFXdiT+zwbQD5AaPUNF0d+V8V4EXXgRu9kOUgdjhUqKXOLfdnVqM5v
         6Z+Vguv3+SGBgKiQkGsxcYhWNzGBiPhm1iZlLsJv4ycKR4DMbATJ8OI/LNsZzn3RqMtX
         AndVH1BJHsu9Ej6bUXi423R2qOOA639VAXzUAQ36ZOHAQihALUuqNR9SWl3A8omsU63w
         t+8lEhoMcPsQWXlPWZ4LXtt+7vJOgTbYq6TRhDeSx1b2uX0Z7K6Phk8I4GftIme3wCHg
         O/g+cnQNqYmAry/H0r9ZzR3kQx6d8XQ1SebUXBb3mE6UUVclOghiVXrAVQ+C/pKbwzhX
         Z5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVtO0mf5+18xL2wyRUh4C8eKDbifEpFUpjq+V/g/lJQ=;
        b=RVbxcrpy+mAMMa1TskfXwXPwyQ6EdS1IxxP8rxtwyVTQdnsWJCuSDU+Gk3lZw/B4Av
         NBAhTdk6WxOKHCUluZMR9KEm4NMlXCbyML4Y0jdQPrvAE5DrL/ALf3kECU0T7PduMQea
         rHxRh04tqD42hfhqmqNeX4yFoBzY7bTXPO0PoCmjEdewmfUr28Ph2jXzNhk4ULj5Iup1
         tjq20gdMey4hGdH0kPETDFRNAC5ppfgFfW3A+fHEaBDAtJrh5vi7WGAXmsAdQndM1nkv
         cKnerTL1iH5TbWuLoBy2/BUgmGkkcliAAbFZd59fFcEFAlBp4FrcFMBLzQC3euwnFEZT
         1psA==
X-Gm-Message-State: AOAM531USSSvQNcJMyRxcbh/sBhdepk6j5DxeNLaKcBRzwtsBhwP7ikJ
        qG7rg5w01zsGrwjLpuQeUgHUTQRgcIBuciZzO5U=
X-Google-Smtp-Source: ABdhPJwZyTYwNoOwTrFxeUfjkqvqeKiAhlF+F7UYGS9p4EeqwhWfVZaDY8nYXJLazazVAeLPyEFYjHUBXWeDJt+MHCg=
X-Received: by 2002:adf:93e3:: with SMTP id 90mr15331654wrp.298.1592769469774;
 Sun, 21 Jun 2020 12:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200619132410.23859-1-david@redhat.com> <20200619132410.23859-3-david@redhat.com>
In-Reply-To: <20200619132410.23859-3-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Sun, 21 Jun 2020 21:57:38 +0200
Message-ID: <CAM9Jb+ijCjwBr_E1+3WkZkh7igMnJv7pJUewX43O63TLGsqiUw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm/page_alloc: drop nr_free_pagecache_pages()
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> -       return nr_free_zone_pages(gfp_zone(GFP_HIGHUSER_MOVABLE));
> -}
> -
>  static inline void show_node(struct zone *zone)
>  {
>         if (IS_ENABLED(CONFIG_NUMA))
> @@ -5911,7 +5898,8 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
>                 __build_all_zonelists(pgdat);
>                 /* cpuset refresh routine should be here */
>         }
> -       vm_total_pages = nr_free_pagecache_pages();
> +       /* Get the number of free pages beyond high watermark in all zones. */
> +       vm_total_pages = nr_free_zone_pages(gfp_zone(GFP_HIGHUSER_MOVABLE));
>         /*
>          * Disable grouping by mobility if the number of pages in the
>          * system is too low to allow the mechanism to work. It would be

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
