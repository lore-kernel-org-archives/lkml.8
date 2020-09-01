Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47732C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17BB6206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKvWNEH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbgIAQFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbgIAPlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:41:25 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338E3C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 08:41:24 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i26so2284245ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mRRv/JWr8lefJK8mOV5+SVMKnyOKM6jC1YlJAAQDR3k=;
        b=DKvWNEH3Gj78jemdv3xdYpWry18IwiJrX2WSmxBD9QiFUMXZk7WJJK1Ckv3j2MsKvd
         JkZDL3Cspa3ZWauj6niFf3qa3/wvuCOvJQCPlQCDK/7DrAmMohx4s35NZd60qn7rEaRf
         eD0Zh6lsBKI35S5bYfaD2ggRIZUIMTVnWUaWahiuKMTXQ2XYMYyedsSkPvMaM+qP04AN
         qLGyply6M6Uz0B5UiUDHj9ORJSfdI1J5B0ah9ay62g6TRX0DPYuDY3NbHcVlR2zj5cxC
         aHz1xeWR/XNN9xLbd7VSng/wpbh5+TAU8986gqSMno0rABJJjgxBSzNRsg2RzbDPmgOO
         eT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mRRv/JWr8lefJK8mOV5+SVMKnyOKM6jC1YlJAAQDR3k=;
        b=uUhWSknU1rZogW4MtABMWOnipRb9psLoKUA5zfSaNDGJTKRqSyoxrfYHZk6ZOdx6Fv
         UAhfrRupKSPTjyB0vAFJJmPEKtGq7ELr8B1jF+0sEWVGNZpFAkGvV0Lc9bnbZD1jFY0b
         306WNLwKEkohpYziFN9lU8Hu9fbo3k6bINkxEbwkAz4OTtZ0Qu8fcqxYIHelfsXWgbdA
         O8ob/BIPMxgpyvKjmTV83I/oKFvF0bZ3yYBsZZ5Y73Sy6YkpySmS1ZrAU3uZLsOEyYF9
         nXklef6ccAKJsq/hM4Qn4mfjcGuyPQ2KihjM9txfZ4FJZAVdV1Tt5EnW5pWGMSvkyFA7
         bEgg==
X-Gm-Message-State: AOAM5339vE5DnHbNTLU1/riRLb+nuK6rTaIIXg0wXtEa+jKxKN7g8iH6
        sCoIZEVBiG2nayZrviv1+mKWKcd/dry4jsG6sxY=
X-Google-Smtp-Source: ABdhPJwSI7Ww+Iu3sIIm2sM4dYRhO7So9wRLA8acL04LZKVkQWQTxScqvQ4zcYZurITt0TyiquVJi606SSSQXpe6bs0=
X-Received: by 2002:a17:906:edd6:: with SMTP id sb22mr1852146ejb.499.1598974882857;
 Tue, 01 Sep 2020 08:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils> <alpine.LSU.2.11.2008301408230.5954@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008301408230.5954@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 1 Sep 2020 08:41:11 -0700
Message-ID: <CAHbLzkpdW5hLVP0wUcwrrEnnHpqnrHRWZnMWtiGnhezNaEDyzA@mail.gmail.com>
Subject: Re: [PATCH 5/5] mlock: fix unevictable_pgs event counts on THP
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 2:09 PM Hugh Dickins <hughd@google.com> wrote:
>
> 5.8 commit 5d91f31faf8e ("mm: swap: fix vmstats for huge page") has
> established that vm_events should count every subpage of a THP,
> including unevictable_pgs_culled and unevictable_pgs_rescued; but
> lru_cache_add_inactive_or_unevictable() was not doing so for
> unevictable_pgs_mlocked, and mm/mlock.c was not doing so for
> unevictable_pgs mlocked, munlocked, cleared and stranded.
>
> Fix them; but THPs don't go the pagevec way in mlock.c,
> so no fixes needed on that path.
>
> Fixes: 5d91f31faf8e ("mm: swap: fix vmstats for huge page")
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Yang Shi <shy828301@gmail.com>

> ---
> I've only checked UNEVICTABLEs: there may be more inconsistencies left.
> The check_move_unevictable_pages() patch brought me to this one, but
> this is more important because mlock works on all THPs, without needing
> special testing "force".  But, it's still just monotonically increasing
> event counts, so not all that important.
>
>  mm/mlock.c |   24 +++++++++++++++---------
>  mm/swap.c  |    6 +++---
>  2 files changed, 18 insertions(+), 12 deletions(-)
>
> --- 5.9-rc2/mm/mlock.c  2020-08-16 17:32:50.665507048 -0700
> +++ linux/mm/mlock.c    2020-08-28 17:42:07.975278411 -0700
> @@ -58,11 +58,14 @@ EXPORT_SYMBOL(can_do_mlock);
>   */
>  void clear_page_mlock(struct page *page)
>  {
> +       int nr_pages;
> +
>         if (!TestClearPageMlocked(page))
>                 return;
>
> -       mod_zone_page_state(page_zone(page), NR_MLOCK, -thp_nr_pages(page));
> -       count_vm_event(UNEVICTABLE_PGCLEARED);
> +       nr_pages = thp_nr_pages(page);
> +       mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
> +       count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
>         /*
>          * The previous TestClearPageMlocked() corresponds to the smp_mb()
>          * in __pagevec_lru_add_fn().
> @@ -76,7 +79,7 @@ void clear_page_mlock(struct page *page)
>                  * We lost the race. the page already moved to evictable list.
>                  */
>                 if (PageUnevictable(page))
> -                       count_vm_event(UNEVICTABLE_PGSTRANDED);
> +                       count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
>         }
>  }
>
> @@ -93,9 +96,10 @@ void mlock_vma_page(struct page *page)
>         VM_BUG_ON_PAGE(PageCompound(page) && PageDoubleMap(page), page);
>
>         if (!TestSetPageMlocked(page)) {
> -               mod_zone_page_state(page_zone(page), NR_MLOCK,
> -                                   thp_nr_pages(page));
> -               count_vm_event(UNEVICTABLE_PGMLOCKED);
> +               int nr_pages = thp_nr_pages(page);
> +
> +               mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
> +               count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
>                 if (!isolate_lru_page(page))
>                         putback_lru_page(page);
>         }
> @@ -138,7 +142,7 @@ static void __munlock_isolated_page(stru
>
>         /* Did try_to_unlock() succeed or punt? */
>         if (!PageMlocked(page))
> -               count_vm_event(UNEVICTABLE_PGMUNLOCKED);
> +               count_vm_events(UNEVICTABLE_PGMUNLOCKED, thp_nr_pages(page));
>
>         putback_lru_page(page);
>  }
> @@ -154,10 +158,12 @@ static void __munlock_isolated_page(stru
>   */
>  static void __munlock_isolation_failed(struct page *page)
>  {
> +       int nr_pages = thp_nr_pages(page);
> +
>         if (PageUnevictable(page))
> -               __count_vm_event(UNEVICTABLE_PGSTRANDED);
> +               __count_vm_events(UNEVICTABLE_PGSTRANDED, nr_pages);
>         else
> -               __count_vm_event(UNEVICTABLE_PGMUNLOCKED);
> +               __count_vm_events(UNEVICTABLE_PGMUNLOCKED, nr_pages);
>  }
>
>  /**
> --- 5.9-rc2/mm/swap.c   2020-08-16 17:32:50.709507284 -0700
> +++ linux/mm/swap.c     2020-08-28 17:42:07.975278411 -0700
> @@ -494,14 +494,14 @@ void lru_cache_add_inactive_or_unevictab
>
>         unevictable = (vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) == VM_LOCKED;
>         if (unlikely(unevictable) && !TestSetPageMlocked(page)) {
> +               int nr_pages = thp_nr_pages(page);
>                 /*
>                  * We use the irq-unsafe __mod_zone_page_stat because this
>                  * counter is not modified from interrupt context, and the pte
>                  * lock is held(spinlock), which implies preemption disabled.
>                  */
> -               __mod_zone_page_state(page_zone(page), NR_MLOCK,
> -                                   thp_nr_pages(page));
> -               count_vm_event(UNEVICTABLE_PGMLOCKED);
> +               __mod_zone_page_state(page_zone(page), NR_MLOCK, nr_pages);
> +               count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
>         }
>         lru_cache_add(page);
>  }
>
