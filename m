Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA54C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 14:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06FD2072F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 14:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uF4uQoe+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgEIOHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 10:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727882AbgEIOHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 10:07:02 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE72C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 07:07:01 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a9so3684910lfb.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 07:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jc93T48//PCz7sdPyS0gIAsQLpsU+tV5Kt0CzqYwNik=;
        b=uF4uQoe+Y/Rjx41fEplRhUf+B9x5B5F/LKDeKQu+D8rktHPDMcvcrKJ2M9QRQslZfS
         pxpEfjWspPHF07KZa4jVhaeDrW9r2+L6O38kBjVzIONl+siiFRvZHre6UUqVfO5njY4B
         dclVPiAKKVgD9sk/qgxT+kxi1bWfRfD1eDSbafMPpBgtnE3jIzAu//+1lQ4e92NmJfmj
         LCTOgnamNTrgmOw5HmZ+CAhGi7SIJy6XSOZNlSbK8eezV94DWGSsmsC1Idq4uY50QrbP
         w0b4AnWsem9n7jdd6EvNgGuGM5FgnEYGAQe4NPYrBycRSJed3lj+S+y6HdS2UnvQtkqG
         9oyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jc93T48//PCz7sdPyS0gIAsQLpsU+tV5Kt0CzqYwNik=;
        b=qwJY7vVxv9wjzzRQSb++TGEitonBsf4wnifWeknjdGBfxqSRYyCL8HW3np+DJL9Jfd
         kjTlzTjp1wjh2M2cxfW3Xx5+IGb8+1F5dxcX9NCGqpEcQjkfUMMgaCC+p67Pgm1ykhif
         9ivdp9bEz2TnmBhc70X0P1b5oM0T5840ls9HTh9YPk9j26W4coHNQlx6kl3Rms9+qOwg
         NpeqFR/mmz/3VQ19gRRXl1Asom8yPd2WjZdpe4dZI9J0Kh09cz2NiXq0+DY1jHkmOxNA
         mDBXL9eEuqPbu8/DDrMKYU78tY5CVZ2bZON4EkvWl2GDk+uX4SayXd3v1UeqM4uAsibd
         N5vQ==
X-Gm-Message-State: AOAM532nCaP0u74SOPV3766/X38RYVO9qYHb/Tp7LIdQowKTSEKUpgY4
        t/gJG6Ksr+BWHmEn9rRY3D1naHCgROYeHzYVF5dKJA==
X-Google-Smtp-Source: ABdhPJwjPYzDPcoNKv0FtPPZDg27RvRDPPE/INXsZ6+T0TDBOd40qBSDRRPucaEnBz644KrZdQwsAsrxFNOD5b1wI6g=
X-Received: by 2002:a19:f512:: with SMTP id j18mr5027730lfb.33.1589033220016;
 Sat, 09 May 2020 07:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200508212215.181307-1-shakeelb@google.com> <20200508212215.181307-3-shakeelb@google.com>
 <20200508215122.GB226164@cmpxchg.org>
In-Reply-To: <20200508215122.GB226164@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 9 May 2020 07:06:48 -0700
Message-ID: <CALvZod5DyMK0uGhPD5oYjds0Q8ew=1LTqjbHK4YLdsqrfYQqWg@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: swap: fix update_page_reclaim_stat for huge pages
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Mel Gorman <mgorman@suse.de>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 2:51 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, May 08, 2020 at 02:22:15PM -0700, Shakeel Butt wrote:
> > Currently update_page_reclaim_stat() updates the lruvec.reclaim_stats
> > just once for a page irrespective if a page is huge or not. Fix that by
> > passing the hpage_nr_pages(page) to it.
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> https://lore.kernel.org/patchwork/patch/685703/
>
> Laughs, then cries.
>

What happened to that patch? Fell through the cracks?

> > @@ -928,7 +928,7 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
> >       }
> >
> >       if (!PageUnevictable(page))
> > -             update_page_reclaim_stat(lruvec, file, PageActive(page_tail));
> > +             update_page_reclaim_stat(lruvec, file, PageActive(page_tail), 1);
>
> The change to __pagevec_lru_add_fn() below makes sure the tail pages
> are already accounted. This would make them count twice.
>

Yes, you are right. I will just re-send your patch after rebase.



> >  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> > @@ -973,7 +973,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
> >       if (page_evictable(page)) {
> >               lru = page_lru(page);
> >               update_page_reclaim_stat(lruvec, page_is_file_lru(page),
> > -                                      PageActive(page));
> > +                                      PageActive(page), nr_pages);
> >               if (was_unevictable)
> >                       __count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
> >       } else {
