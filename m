Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4722C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DE92068E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3wPal7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHaKFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHaKFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:05:42 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7171C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 03:05:41 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g14so5268939iom.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 03:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aMedIP/dixQAHeOwto23/Giy0VoTYuI32ZVtt7Ep3Rw=;
        b=o3wPal7iimBHGEIwSnZGR75SLwR/w0TbwYc7nYEtzNaEdDv4hNiP8+KeAl74PHZOtB
         kdERjocf+U2usGawT1M2jonYTCAXJihoMxaz4mO72wz+lF+7C/tOZgXL6UlXGSQxOWLB
         dsVQ/Jyc4cUaxhfxwCLsq/bjv6gozsaGGhFHmdhFUX3Eivv+JHhDIBZRPkgrP2+5KRvh
         8twrYCA2gC5UvcYy/P7DI5XRhgKT4AB2xxcAIHbIWkp2C/8HsFJsqAhPmwSmxEImPned
         N3DnLcEy1iDgDCQIOiophSk2BnIRcaHhoT16DVsqLf3bN496EBa782+u/m/i31mJ9NVa
         Ukcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aMedIP/dixQAHeOwto23/Giy0VoTYuI32ZVtt7Ep3Rw=;
        b=VphSWDJ6QckLsN1fSJX6WHTaZ8Dkjze3Xy8nlzhVEb97mD/4K4PmMIGrCjD/YtlgV/
         zI6IYn2QueiLLjW2XK43+R4NxHWj+v5PvX6+7oNsmREjseF5XsDHr46MHDs4uinqqeyx
         mFZrDviRQsnrbJz9Z64YYnfojYxWKP8d+DRYmfFtBVjkfblUK1/WN46eQ87oB40alQCY
         /kgR/9+K9UQ9mewpoOwGHCXw3mMLMv52O/yAnewzlV9PObZtlhtMsDTLZeg4+BfVVukl
         rjUWIPux4NlQRsAbCBB66622K2sr9pBhSVOOGGVSmaobwKZy+fASw6IWL64bQWJYdN4L
         k34g==
X-Gm-Message-State: AOAM532TqRyoa1CR21owrWv0IgtlSZe0QDcItsAfPGiffyE1oL6PXcQm
        s/icZF2fzetMH0fmmbgB8rYgb+1Sn2wfm+d2jNEsQILACzA=
X-Google-Smtp-Source: ABdhPJy1UTzvkT1y0WoGmjdRxGmFbkxD3hQJOgSWa/Vh5LT7shkxWG9WH/pwC9q4qswKdF1vMtDhn0GHhqldGDgpmOg=
X-Received: by 2002:a02:6623:: with SMTP id k35mr493761jac.105.1598868341182;
 Mon, 31 Aug 2020 03:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200819175957.28465-1-david@redhat.com> <20200819175957.28465-2-david@redhat.com>
In-Reply-To: <20200819175957.28465-2-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 31 Aug 2020 12:05:29 +0200
Message-ID: <CAM9Jb+jASOEk-41NzA1BwNMU8wCcBV=vGr6u+n8wyBeQPHmE6Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] mm/memory_hotplug: inline __offline_pages() into offline_pages()
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> There is only a single user, offline_pages(). Let's inline, to make
> it look more similar to online_pages().
>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory_hotplug.c | 16 +++++-----------
>  1 file changed, 5 insertions(+), 11 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 7f62d69660e06..c781d386d87f9 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1473,11 +1473,10 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
>         return 0;
>  }
>
> -static int __ref __offline_pages(unsigned long start_pfn,
> -                 unsigned long end_pfn)
> +int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>  {
> -       unsigned long pfn, nr_pages = 0;
> -       unsigned long offlined_pages = 0;
> +       const unsigned long end_pfn = start_pfn + nr_pages;
> +       unsigned long pfn, system_ram_pages = 0, offlined_pages = 0;
>         int ret, node, nr_isolate_pageblock;
>         unsigned long flags;
>         struct zone *zone;
> @@ -1494,9 +1493,9 @@ static int __ref __offline_pages(unsigned long start_pfn,
>          * memory holes PG_reserved, don't need pfn_valid() checks, and can
>          * avoid using walk_system_ram_range() later.
>          */
> -       walk_system_ram_range(start_pfn, end_pfn - start_pfn, &nr_pages,
> +       walk_system_ram_range(start_pfn, nr_pages, &system_ram_pages,
>                               count_system_ram_pages_cb);
> -       if (nr_pages != end_pfn - start_pfn) {
> +       if (system_ram_pages != nr_pages) {
>                 ret = -EINVAL;
>                 reason = "memory holes";
>                 goto failed_removal;
> @@ -1631,11 +1630,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
>         return ret;
>  }
>
> -int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
> -{
> -       return __offline_pages(start_pfn, start_pfn + nr_pages);
> -}
> -
>  static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
>  {
>         int ret = !is_memblock_offlined(mem);

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
