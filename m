Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0383C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD34B20758
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZSmHS4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgHSXFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 19:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgHSXFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 19:05:01 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A8EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 16:05:00 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a14so159573edx.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 16:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvQtPoZORjN9LSo3BZs0SVbBGr5W+CxKyp0VPJwa6A0=;
        b=qZSmHS4sO/ZGrvttBIvLzipAMFOquz4Zqw/AkbbrSiWDp8ebhZEbNsRun+QLs5RzW8
         UuH/zowE2waML75yRWyD/AOgYN40Drg+zRIQSRShMZFpBK3H5qrK2kh0s83hutMOss4e
         Cbe2ToHcwoLyp3LrwRMu2LGsi13u2yFkYIVn6f97+HIxEz8PCSep0YfvOfUooGBdrvrZ
         ETdyv60upWe7lFEs3UkKfoWgT654paG3bZFFK0yUmDDQZiSwjatyrECNt/g4kRoHCSon
         mJybiLctGWBfWSuAHBMvbwGDSK2GwP+OJXr/SyBMrO3IeKBmczF5ULQmADr8T2oUr8f7
         rX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvQtPoZORjN9LSo3BZs0SVbBGr5W+CxKyp0VPJwa6A0=;
        b=ZfA7QoESxXn0pBkPqJNruar64YGhAREsuie3VZ03pN3OfdGyJUdArczLoVDMB3g4N9
         FFIJFMIh4i7hGY46CS5PJ3Q0c/QijXEQ7D/J2oth4MsF+2LNukssR3GRNxYGCbumTO6L
         WBL1pbTAefVXU+UM1UGVQmzF5iZnnDTfX7INULwg2K+YkoS1Bum66nm98ct847M/dZbL
         YTbl52EIHtQcNVEfYjH31CAarOarriGOGeXQGBizWRbONF5l+h1+6pONvW6/DlahFYU4
         QhxJJjIc5lPJBg6eiyCw127CaHVZB+eOn5fSUyo3wLAi9yLwTVtnofgsssc2FA39agA3
         nujQ==
X-Gm-Message-State: AOAM532MpAiJ+iRuusSnBW4rD5r7Sl7K+6MLAKgR/VKCNP+46j0xVsmi
        8Ozl026aTYTEkDiGFrvASTUn35+BgcroO8Il624=
X-Google-Smtp-Source: ABdhPJxRbtnGrPQQXQAlbTTU4Qe7MeN3M0rqgblk7edh9EXRmGlfvOQtZOOznLOoNL/71rRzYI6Gj1NgnkVHOWPrJvY=
X-Received: by 2002:a50:e844:: with SMTP id k4mr279877edn.237.1597878299120;
 Wed, 19 Aug 2020 16:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200818184704.3625199-1-yuzhao@google.com> <20200818184704.3625199-2-yuzhao@google.com>
In-Reply-To: <20200818184704.3625199-2-yuzhao@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 19 Aug 2020 16:04:47 -0700
Message-ID: <CAHbLzkrLK3gkeA2_B7jyf99jmA0yvV0fQE53sqOLHyocaCGDSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm: remove superfluous __ClearPageActive()
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:47 AM Yu Zhao <yuzhao@google.com> wrote:
>
> To activate a page, mark_page_accessed() always holds a reference
> on it. It either gets a new reference when adding a page to
> lru_pvecs.activate_page or reuses an existing one it previously
> got when it added a page to lru_pvecs.lru_add. So it doesn't call
> SetPageActive() on a page that doesn't have any reference left.
> Therefore, the race is impossible these days (I didn't brother to
> dig into its history).
>
> For other paths, namely reclaim and migration, a reference count is
> always held while calling SetPageActive() on a page.
>
> SetPageSlabPfmemalloc() also uses SetPageActive(), but it's irrelevant
> to LRU pages.

Seems fine to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  mm/memremap.c | 2 --
>  mm/swap.c     | 2 --
>  2 files changed, 4 deletions(-)
>
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 03e38b7a38f1..3a06eb91cb59 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -451,8 +451,6 @@ void free_devmap_managed_page(struct page *page)
>                 return;
>         }
>
> -       /* Clear Active bit in case of parallel mark_page_accessed */
> -       __ClearPageActive(page);
>         __ClearPageWaiters(page);
>
>         mem_cgroup_uncharge(page);
> diff --git a/mm/swap.c b/mm/swap.c
> index 25c4043491b3..999a84dbe12c 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -900,8 +900,6 @@ void release_pages(struct page **pages, int nr)
>                         del_page_from_lru_list(page, lruvec, page_off_lru(page));
>                 }
>
> -               /* Clear Active bit in case of parallel mark_page_accessed */
> -               __ClearPageActive(page);
>                 __ClearPageWaiters(page);
>
>                 list_add(&page->lru, &pages_to_free);
> --
> 2.28.0.220.ged08abb693-goog
>
>
