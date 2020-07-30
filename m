Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0F7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 04:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C7942072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 04:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCTc8xvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgG3EbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 00:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgG3EbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 00:31:12 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C0BC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 21:31:12 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p16so10602364ile.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 21:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8IWClMf+Ao4pEqXoB9q668049Xra3AgdP5q2Ybi4E0=;
        b=rCTc8xvgE9Ui97ENvy7ojAC5zhzBo56lHoEpYw8H7EUHC+JPaBfIbyGZ5nwC2FrYXk
         JehpEw6CYfgWp+fSumr4EfDjvXv1y51KnUMbbsvz0lrrCugYsh9dXr5Ud+tpElv2RfiI
         plP+lyZa6iPkzc2GTh3DxSW0B9xeFpAkwcJXK48OiF6XhUfAz9FyXiyFG2j7WAhdx5mZ
         AA2CJOnhBxi7QKS9w37F+n2AlK2i/jqc9q1B3Nw3QOdSweM1NyqFWJPyrd/Gmgd+J4MP
         4QKE1hDuIEDwcMj9eGWdGU4mrhXRO+ml006SJPd2H/d6S2xB+ox9tMVNHpzihUfeyS7e
         t0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8IWClMf+Ao4pEqXoB9q668049Xra3AgdP5q2Ybi4E0=;
        b=P31UL+If7RFQpkyJzzdDD3r9bdR7wWMWL7wh2d69x+HBOLxaOOm0RCR8tZ2kQogTDJ
         nlKRp6aav1gPIagJKtwPi+DrljBwyHfSbOIl3GMKpVKf6+w6RUJ3z5j4AOv/jiNHi1Q/
         dTeHWJRPAi4Kwa0o93VXaAEwVSCHCWN5lN6Ha3J6Fh/+Uuk+VB/5g+RmuyWbaK6i5SZR
         kCmrF0atqFR1R/GksOi/npEN/XOrLQxPzUyf9L97SD4tcJyvzXUOvhPfpdvN/a6rfriy
         EnelbG3jFBvYwiqLzp/2ERWF/JrIWVfqrbUBmYvrDMVO8709glzV8ytTtckwarb/aKB7
         BhNQ==
X-Gm-Message-State: AOAM533xpTZ9zRKsoM2Ema6sfsTZ+kR9j8IHsR2asWN6RTV4KKf7+0qM
        RwhERZwaIH39m0+LWpg1agGceIxqkUgB0V4EBLg=
X-Google-Smtp-Source: ABdhPJydOlDtkkFQ7R5dCMPMhtBMULJz9VbqLkowKMQpkrafuAntcCxNQaR4Ib8wrP396W86AK02AU1tIJ//znQ0jSc=
X-Received: by 2002:a92:ce09:: with SMTP id b9mr15888272ilo.143.1596083471618;
 Wed, 29 Jul 2020 21:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200630142639.22770-1-david@redhat.com> <20200630142639.22770-5-david@redhat.com>
In-Reply-To: <20200630142639.22770-5-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 30 Jul 2020 06:31:00 +0200
Message-ID: <CAM9Jb+iBVeFDyichYkdZgcHgd6wJABygJ_GwuL_Og_bqjQ=KwQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] mm/page_isolation: cleanup set_migratetype_isolate()
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Let's clean it up a bit, simplifying error handling and getting rid of
> the label.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/page_isolation.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 02a01bff6b219..5f869bef23fa4 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -17,12 +17,9 @@
>
>  static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
>  {
> -       struct page *unmovable = NULL;
> -       struct zone *zone;
> +       struct zone *zone = page_zone(page);
> +       struct page *unmovable;
>         unsigned long flags;
> -       int ret = -EBUSY;
> -
> -       zone = page_zone(page);
>
>         spin_lock_irqsave(&zone->lock, flags);
>
> @@ -51,21 +48,20 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
>                                                                         NULL);
>
>                 __mod_zone_freepage_state(zone, -nr_pages, mt);
> -               ret = 0;
> +               spin_unlock_irqrestore(&zone->lock, flags);
> +               drain_all_pages(zone);
> +               return 0;
>         }
>
> -out:
>         spin_unlock_irqrestore(&zone->lock, flags);
> -       if (!ret) {
> -               drain_all_pages(zone);
> -       } else if ((isol_flags & REPORT_FAILURE) && unmovable)
> +       if (isol_flags & REPORT_FAILURE)
>                 /*
>                  * printk() with zone->lock held will likely trigger a
>                  * lockdep splat, so defer it here.
>                  */
>                 dump_page(unmovable, "unmovable page");
>
> -       return ret;
> +       return -EBUSY;
>  }
>
>  static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
> --

This clean up looks good to me.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 2.26.2
>
>
