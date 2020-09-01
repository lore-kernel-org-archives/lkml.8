Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB51C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 629F5206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5Ah/xy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbgIAP5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731507AbgIAP5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:57:30 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F38C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 08:57:28 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i26so2361405ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 08:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ja1Ngj7NH47x40mFJlmmy6/fspeTMYwfVXDFlvDZIns=;
        b=R5Ah/xy7z0CYa/cOPWoKydl55+5AZx0X0xQJSi7oXsefEDGnUWoEmUvrBgHDB6qi9M
         /0BqPFsX1uD16ZqQrlqlFY/brxotDPaHIoOx5hvvLGC7lSE/Rn1VXNwev5SZpYADEWZW
         xGNROhES6O3tp7K9FtFb1rbn1WTcgV36Lmdx4vC4Z9L++ntjEsM9CkS30Xkv7gD8IL23
         xj71aaX3htYZQSlf+C1O1oREaf7eGZp+A5SifAfa3S5foT+pHlv7zElngZUgc2r/DNbI
         3ceu3otruVt5OiOnce89EX+sGUkJIuxUfOEGdYo8PjqYYHV/c0UHcQUPFJI8vhhJiyUW
         Uyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ja1Ngj7NH47x40mFJlmmy6/fspeTMYwfVXDFlvDZIns=;
        b=PhXA+m9Yy3s282lhu/WpyNXMLv88oBE0fw0WiezpZAu1zA752w6MGeYeYv+kQBCu5C
         SBjN/D2Cwpi2fdH2v3zZ6xsmJ+2lajHHg5U6lfLQ/Kg/gFEeeauohUBE6wfTtaOZ+bCa
         GrU5pIP0VwFdnDoMQs/6gbtYM34pMjK7me0xxOIGbTraNDWiUl2Xgphc2Hln1x48GT2O
         9cXXVxA/rG12JAqBPzH8YoVmMpdTiS7hjSNQYI7A7H9uA2PZTv+SRsczDWFrFnpL178x
         jp8/m3mj0KBJWuxaIElc4IMRuFcTve61soqaLZdrehIQBDi2T70p+iYUFFF8wWVKlteH
         9cEw==
X-Gm-Message-State: AOAM533e+xXXZBhZRfi/bB1XNR0woJrC+nflWq/LUgsDBVfSllRMweJW
        EZT9H6fpRDUyya5VWnErwDjcAVhgxrEfVhtg36I=
X-Google-Smtp-Source: ABdhPJyuNoXmSK9kdaNb5NJmH/3HsU8fUsgYikM66A4Np4f+RaqiTJn5bkqn7polwbuP2ipcbL+X4LqpsmkGVqFyETs=
X-Received: by 2002:a17:906:edd6:: with SMTP id sb22mr1911092ejb.499.1598975847689;
 Tue, 01 Sep 2020 08:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2008301343270.5954@eggly.anvils> <alpine.LSU.2.11.2008301405000.5954@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2008301405000.5954@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 1 Sep 2020 08:57:15 -0700
Message-ID: <CAHbLzkrJ-E1LVbjfTAmoZ37Hw68SWjnUovvcedFVHfsLecp2Mw@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: fix check_move_unevictable_pages() on THP
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shakeel Butt <shakeelb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Qian Cai <cai@lca.pw>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Kuo-Hsin Yang <vovoy@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 2:08 PM Hugh Dickins <hughd@google.com> wrote:
>
> check_move_unevictable_pages() is used in making unevictable shmem pages
> evictable: by shmem_unlock_mapping(), drm_gem_check_release_pagevec() and
> i915/gem check_release_pagevec().  Those may pass down subpages of a huge
> page, when /sys/kernel/mm/transparent_hugepage/shmem_enabled is "force".
>
> That does not crash or warn at present, but the accounting of vmstats
> unevictable_pgs_scanned and unevictable_pgs_rescued is inconsistent:
> scanned being incremented on each subpage, rescued only on the head
> (since tails already appear evictable once the head has been updated).
>
> 5.8 commit 5d91f31faf8e ("mm: swap: fix vmstats for huge page") has
> established that vm_events in general (and unevictable_pgs_rescued in
> particular) should count every subpage: so follow that precedent here.
>
> Do this in such a way that if mem_cgroup_page_lruvec() is made stricter
> (to check page->mem_cgroup is always set), no problem: skip the tails
> before calling it, and add thp_nr_pages() to vmstats on the head.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Acked-by: Yang Shi <shy828301@gmail.com>

> ---
> Nothing here worth going to stable, since it's just a testing config
> that is fixed, whose event numbers are not very important; but this
> will be needed before Alex Shi's warning, and might as well go in now.
>
> The callers of check_move_unevictable_pages() could be optimized,
> to skip over tails: but Matthew Wilcox has other changes in flight
> there, so let's skip the optimization for now.
>
>  mm/vmscan.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> --- 5.9-rc2/mm/vmscan.c 2020-08-16 17:32:50.721507348 -0700
> +++ linux/mm/vmscan.c   2020-08-28 17:47:10.595580876 -0700
> @@ -4260,8 +4260,14 @@ void check_move_unevictable_pages(struct
>         for (i = 0; i < pvec->nr; i++) {
>                 struct page *page = pvec->pages[i];
>                 struct pglist_data *pagepgdat = page_pgdat(page);
> +               int nr_pages;
> +
> +               if (PageTransTail(page))
> +                       continue;
> +
> +               nr_pages = thp_nr_pages(page);
> +               pgscanned += nr_pages;
>
> -               pgscanned++;
>                 if (pagepgdat != pgdat) {
>                         if (pgdat)
>                                 spin_unlock_irq(&pgdat->lru_lock);
> @@ -4280,7 +4286,7 @@ void check_move_unevictable_pages(struct
>                         ClearPageUnevictable(page);
>                         del_page_from_lru_list(page, lruvec, LRU_UNEVICTABLE);
>                         add_page_to_lru_list(page, lruvec, lru);
> -                       pgrescued++;
> +                       pgrescued += nr_pages;
>                 }
>         }
>
>
