Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAB6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB8E120772
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nwc67yJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgFEJbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgFEJbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:31:24 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7541DC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 02:31:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y20so673013wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 02:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NAWEqwQD/F5TIg0bPgl0uKs0kGQlTjN/ATKL4zcYsUY=;
        b=Nwc67yJKdX9+1Qop0ErvOGkV+cGnmtPwvls0qkrXVjEC11iL63CnWkgWMJo9Tdj4T/
         YPn1VNsQsFVPcZ9IGbuPYi2eS3BxJhoEtAWcqDJYvL/36xJ/Hjo67IqgwIxzuiFq64nO
         Rbtrq0ZFV3X+ZvYrfx3nxEdAWGGUvjxxSuT6sj/YF88RyxhFRZ2pPmpYWu8URT12MGBl
         vNSrF6Yq5z5cMZ/4TmqxoVJC5uB4NBvbOlTX0BD/3S9k+46P/uwo4u7iZE55w603a6QC
         ay24sCyvBcROAdiEkD7qKWpHmkXK2Zir9gyrREVSy6XHu7l0lCFuvK9OrQZxj5Bdfgh2
         foow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAWEqwQD/F5TIg0bPgl0uKs0kGQlTjN/ATKL4zcYsUY=;
        b=roHrUUbt+4khBgwtC1wATlQjDtCaa7FpYkDrG4bpERPtQNB7AFL6hjXhSlajmw4ZHm
         HKcq+VZy5pDLW6/Ule7d6M2U0u4uLyXdW+jjIUr+gXCL5iV3A48mBkKbQn+w4vknaiRi
         jIlbsOBIWysDZPypFi9NPXn55xNVLA64vb1yKuzGVo38iDPebSuOREc9tzN2srSv+ZXh
         py0PpUG+NIba9dcUT/TAIj62dI4SMiokxAYTH2uVhPNuyAsxP6PecBOl+07xkShvvIlo
         oBkebYvKoWdGIellZ6bYuhuUCC3NZPkNYzDZgALZraTA8CD+YgdA2nfGydW+xCjHauXk
         zPpw==
X-Gm-Message-State: AOAM5313d5+uVKR4qeiBVlCHXyAmD/vc6u7Fe053qIbFdvKJ6Y2ByZEO
        +BNoFjFRYmkIe4i4nUV/2077voIJmy+F80PXp10=
X-Google-Smtp-Source: ABdhPJwCbRoR+xa510LuZxAlNcsHnZzTgWupJPpuEOXyASWrrgyDvVSefRYiw7PUocuAw5wnlsNYfRVLgYROAUBeGBk=
X-Received: by 2002:a7b:cbd9:: with SMTP id n25mr1791465wmi.30.1591349483211;
 Fri, 05 Jun 2020 02:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200605092502.18018-1-sjpark@amazon.com> <20200605092502.18018-2-sjpark@amazon.com>
In-Reply-To: <20200605092502.18018-2-sjpark@amazon.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Fri, 5 Jun 2020 11:31:12 +0200
Message-ID: <CAM9Jb+i5zA7BV51Vnw13xLmbuS0qtSHjZ-NvP7v0vc35jCObkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/page_idle.c: Skip offline pages
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: SeongJae Park <sjpark@amazon.de>
>
> 'Idle page tracking' users can pass random pfn that might be mapped to
> an offline page.  To avoid accessing such pages, this commit modifies
> the 'page_idle_get_page()' to use 'pfn_to_online_page()' instead of
> 'pfn_valid()' and 'pfn_to_page()' combination, so that the pfn mapped to
> an offline page can be skipped.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reported-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_idle.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/mm/page_idle.c b/mm/page_idle.c
> index 295512465065..057c61df12db 100644
> --- a/mm/page_idle.c
> +++ b/mm/page_idle.c
> @@ -4,6 +4,7 @@
>  #include <linux/fs.h>
>  #include <linux/sysfs.h>
>  #include <linux/kobject.h>
> +#include <linux/memory_hotplug.h>
>  #include <linux/mm.h>
>  #include <linux/mmzone.h>
>  #include <linux/pagemap.h>
> @@ -30,13 +31,9 @@
>   */
>  static struct page *page_idle_get_page(unsigned long pfn)
>  {
> -       struct page *page;
> +       struct page *page = pfn_to_online_page(pfn);
>         pg_data_t *pgdat;
>
> -       if (!pfn_valid(pfn))
> -               return NULL;
> -
> -       page = pfn_to_page(pfn);
>         if (!page || !PageLRU(page) ||
>             !get_page_unless_zero(page))
>                 return NULL;

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
