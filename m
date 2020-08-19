Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C995BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A849D20758
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 23:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcq8WVW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgHSXGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 19:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgHSXGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 19:06:45 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F28BC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 16:06:45 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w17so158863edt.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 16:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApV9u1cflFzKSz0A3fkLXqLOVXOpSp0i2qXFnaEVB0A=;
        b=hcq8WVW8xePVrqUmTs403JmomWiUUftXEuk5T7jqx3OlIcvOpqtxDeKPOPywIsZkxi
         hOhLV8OOnaQ9BjRJivGjvkszhZwrKDd+KBmdpuErOmrkRXCNSIGJHKRZYZmB4sfK0Eh1
         q0m3sOBtnx8d5y2U1UXbLKAiH47CT0QYko1Ikptj8+SWjD3xh1FszNf7BEUVqs9oADSY
         CR+vN6lYMQJj9JBvUZ+yDBvndF58uFe+FzWtA/si0/tQMWXuXLsmP8liPEOsDgqHBmiK
         Qv54nkglqbMlD5fw0jjqCMkZ+Fvofc6JZfvkuOf1sFcRWNbTFRA4bylFxnRVA9d+zLz/
         p/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApV9u1cflFzKSz0A3fkLXqLOVXOpSp0i2qXFnaEVB0A=;
        b=VaJKXyTFwmLruC6L6GdlLj/7IiINOy9pR0igIJ6TmuLO/nO/mkej4fpEwJ8v6F37M4
         SSJyt6ZVAiehswaJicWbWuCI4k+5g9OmwApEOPofmH6hM51dzkH6qxrsj925cEQJkmh+
         zS0oGHCp+osib0yFHTf7Dg48HOZyx4/j6ug+uDjJ8BXNDnasAnnHmQd0Gndqebt7RCjM
         L8ozUaJvT03DkCMddzWN6Fl/2hDsvcqEYfAyTRCbf2yrqh9e8oqdvMXbzhZ0IugtnXZa
         qCJhHRui6vmsEg0fk5faFMAjb1ipYgQ4hCzrE0CwLPgqWHvPF7qhQ7b8k01rV5DlGvOT
         F9+Q==
X-Gm-Message-State: AOAM5319KhogtalPaibEPBywmp4frU9lVGGptMWDN101jmHhSM97y4q1
        RcwEQrcj1Bt+yJs6ZRCO8uw9g+dNY6SsWhohEQc=
X-Google-Smtp-Source: ABdhPJwrYR6MygaEFcuQnXf1LsPhEernaupCXvsGu3zoQTvrEgm3ZWt2iE+S59WWL/VMOZfhG4XHAoLmbljxvKTiOUk=
X-Received: by 2002:a05:6402:1d92:: with SMTP id dk18mr315695edb.206.1597878404099;
 Wed, 19 Aug 2020 16:06:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200818184704.3625199-1-yuzhao@google.com> <20200818184704.3625199-3-yuzhao@google.com>
In-Reply-To: <20200818184704.3625199-3-yuzhao@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 19 Aug 2020 16:06:32 -0700
Message-ID: <CAHbLzkr7oPFtUog1zJWs54dsS8dhwkWp6ET_Zk71nXmRMtGvDQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: remove superfluous __ClearPageWaiters()
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
> Presumably __ClearPageWaiters() was added to follow the previously
> removed __ClearPageActive() pattern.
>
> Only flags that are in PAGE_FLAGS_CHECK_AT_FREE needs to be properly
> cleared because otherwise we think there may be some kind of leak.
> PG_waiters is not one of those flags and leaving the clearing to
> PAGE_FLAGS_CHECK_AT_PREP is more appropriate.

Actually TBH I'm not very keen to this change, it seems the clearing
is just moved around and the allocation side pays for that instead of
free side.

>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>  include/linux/page-flags.h | 2 +-
>  mm/filemap.c               | 2 ++
>  mm/memremap.c              | 2 --
>  mm/swap.c                  | 3 ---
>  4 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 6be1aa559b1e..dba80a2bdfba 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -318,7 +318,7 @@ static inline int TestClearPage##uname(struct page *page) { return 0; }
>         TESTSETFLAG_FALSE(uname) TESTCLEARFLAG_FALSE(uname)
>
>  __PAGEFLAG(Locked, locked, PF_NO_TAIL)
> -PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD) __CLEARPAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
> +PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
>  PAGEFLAG(Error, error, PF_NO_TAIL) TESTCLEARFLAG(Error, error, PF_NO_TAIL)
>  PAGEFLAG(Referenced, referenced, PF_HEAD)
>         TESTCLEARFLAG(Referenced, referenced, PF_HEAD)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 1aaea26556cc..75240c7ef73f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1079,6 +1079,8 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
>                  * other pages on it.
>                  *
>                  * That's okay, it's a rare case. The next waker will clear it.
> +                * Otherwise the bit will be cleared by PAGE_FLAGS_CHECK_AT_PREP
> +                * when the page is being freed.
>                  */
>         }
>         spin_unlock_irqrestore(&q->lock, flags);
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 3a06eb91cb59..a9d02ffaf9e3 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -451,8 +451,6 @@ void free_devmap_managed_page(struct page *page)
>                 return;
>         }
>
> -       __ClearPageWaiters(page);
> -
>         mem_cgroup_uncharge(page);
>
>         /*
> diff --git a/mm/swap.c b/mm/swap.c
> index 999a84dbe12c..40bf20a75278 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -90,7 +90,6 @@ static void __page_cache_release(struct page *page)
>                 del_page_from_lru_list(page, lruvec, page_off_lru(page));
>                 spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>         }
> -       __ClearPageWaiters(page);
>  }
>
>  static void __put_single_page(struct page *page)
> @@ -900,8 +899,6 @@ void release_pages(struct page **pages, int nr)
>                         del_page_from_lru_list(page, lruvec, page_off_lru(page));
>                 }
>
> -               __ClearPageWaiters(page);
> -
>                 list_add(&page->lru, &pages_to_free);
>         }
>         if (locked_pgdat)
> --
> 2.28.0.220.ged08abb693-goog
>
>
