Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0E2C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47ADA20675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1uSIiAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgBLLAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:00:35 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40079 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgBLLAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:00:35 -0500
Received: by mail-yw1-f66.google.com with SMTP id i126so662546ywe.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 03:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kM97MLC84Ai2tNRM+0y3MuWxaj+OODAjI/0QDkutOj4=;
        b=X1uSIiARBUi8/iGThRGI+8XRd44pO/7iYCwrxGvnU5PUHc2/8SvYSt8FeCx0Wpn9WZ
         +qLc4UCO87rXwnXl5/a8l6fEp1Ew43LHRITzAakgOKtyAAqn9ZjQVagRJwD+/LGb2vsE
         4J2OROvRRFmbqrtiJzUnHwaQDyD135XdQoqkaolm8QdMkI4Mx/tqQyBnezOHs4vndYpo
         sAZVmLkyUaYeTXQEx9JoMHfLoh1fqJIUzNr58JOvRcoR1/Aybj1eZQJ+bwLLffo7X63p
         /Ofl0PDqV2YU79hIlxBcKtL147BJVyYQ63vxX6Qwli0G335+YtrC/Voey3vadQOBS5rK
         MUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kM97MLC84Ai2tNRM+0y3MuWxaj+OODAjI/0QDkutOj4=;
        b=NYnl4khIgcUto8Z4ArURXBHm4AgfNddvczi7DrX1M/84SyMIO2+FQ+TIydrQT1ms3V
         gTP9rLCaxxcTs266Z/KUMZYpCwyTB5Vri9uiIQxVfMAWEpl2op7uEE9hd2v56cblKExB
         Miy3eWL9a0gvgXqPnu7cgzRCy8c3Iln1cWAeUlNX1ioZsynmT5b64AOo9akwGQrJvpkB
         m7yZ7qXBMz9S39HI6s0vhz8aKz4QX1FG0gpf0S6+3gMBYNPZbjK9FW3BRALnkwoHfnQJ
         n5O5dUjM8wY6eo4yyow56tQh/Q67EjxO4M4MSgu8ZMQ+AgD3sQutta6lekK44fMhM0LF
         Dm3w==
X-Gm-Message-State: APjAAAX6vRo7xcwHw6ELgUqibEsk/n8dA5fDDgm/Wyb1irhC0WnNtHPV
        +8TlKAMYmYRhTSr5B3GuvGRlsfyweQx4/vqxqio=
X-Google-Smtp-Source: APXvYqxbLq0kh0iYLKfpU3ZFKorSQiKWexb37ZEBm/V3Dg6nHhIAIbQeZNCqQrF9fn6514N/hA1kBE80DE3yPkcSfL8=
X-Received: by 2002:a81:7b88:: with SMTP id w130mr9611629ywc.231.1581505232324;
 Wed, 12 Feb 2020 03:00:32 -0800 (PST)
MIME-Version: 1.0
References: <1581401993-20041-1-git-send-email-iamjoonsoo.kim@lge.com> <20200212033534.3744-1-hdanton@sina.com>
In-Reply-To: <20200212033534.3744-1-hdanton@sina.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 12 Feb 2020 20:00:13 +0900
Message-ID: <CAAmzW4MdNndLXe9ExjVuxrQ1GG+GY6M_Tt4wXWS72Q_v3Q8aVA@mail.gmail.com>
Subject: Re: [PATCH 9/9] mm/swap: count a new anonymous page as a
 reclaim_state's rotate
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

2020=EB=85=84 2=EC=9B=94 12=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 12:35, =
Hillf Danton <hdanton@sina.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>
> On Mon, 10 Feb 2020 22:20:37 -0800 (PST)
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > reclaim_stat's rotate is used for controlling the ratio of scanning pag=
e
> > between file and anonymous LRU. All new anonymous pages are counted
> > for rotate before the patch, protecting anonymous pages on active LRU, =
and,
> > it makes that reclaim on anonymous LRU is less happened than file LRU.
> >
> > Now, situation is changed. all new anonymous pages are not added
> > to the active LRU so rotate would be far less than before. It will caus=
e
> > that reclaim on anonymous LRU happens more and it would result in bad
> > effect on some system that is optimized for previous setting.
> >
> > Therefore, this patch counts a new anonymous page as a reclaim_state's
> > rotate. Although it is non-logical to add this count to
> > the reclaim_state's rotate in current algorithm, reducing the regressio=
n
> > would be more important.
> >
> > I found this regression on kernel-build test and it is roughly 2~5%
> > performance degradation. With this workaround, performance is completel=
y
> > restored.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > ---
> >  mm/swap.c | 27 ++++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/swap.c b/mm/swap.c
> > index 18b2735..c3584af 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -187,6 +187,9 @@ int get_kernel_page(unsigned long start, int write,=
 struct page **pages)
> >  }
> >  EXPORT_SYMBOL_GPL(get_kernel_page);
> >
> > +static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lru=
vec,
> > +                              void *arg);
> > +
> >  static void pagevec_lru_move_fn(struct pagevec *pvec,
> >       void (*move_fn)(struct page *page, struct lruvec *lruvec, void *a=
rg),
> >       void *arg)
> > @@ -207,6 +210,19 @@ static void pagevec_lru_move_fn(struct pagevec *pv=
ec,
> >                       spin_lock_irqsave(&pgdat->lru_lock, flags);
> >               }
> >
> > +             if (move_fn =3D=3D __pagevec_lru_add_fn) {
> > +                     struct list_head *entry =3D &page->lru;
> > +                     unsigned long next =3D (unsigned long)entry->next=
;
> > +                     unsigned long rotate =3D next & 2;
> > +
> > +                     if (rotate) {
> > +                             VM_BUG_ON(arg);
> > +
> > +                             next =3D next & ~2;
> > +                             entry->next =3D (struct list_head *)next;
> > +                             arg =3D (void *)rotate;
> > +                     }
> > +             }
> >               lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
> >               (*move_fn)(page, lruvec, arg);
> >       }
> > @@ -475,6 +491,14 @@ void lru_cache_add_inactive_or_unevictable(struct =
page *page,
> >                                   hpage_nr_pages(page));
> >               count_vm_event(UNEVICTABLE_PGMLOCKED);
> >       }
> > +
> > +     if (PageSwapBacked(page) && evictable) {
> > +             struct list_head *entry =3D &page->lru;
> > +             unsigned long next =3D (unsigned long)entry->next;
> > +
> > +             next =3D next | 2;
> > +             entry->next =3D (struct list_head *)next;
> > +     }
> >       lru_cache_add(page);
> >  }
> >
> > @@ -927,6 +951,7 @@ static void __pagevec_lru_add_fn(struct page *page,=
 struct lruvec *lruvec,
> >  {
> >       enum lru_list lru;
> >       int was_unevictable =3D TestClearPageUnevictable(page);
> > +     unsigned long rotate =3D (unsigned long)arg;
> >
> >       VM_BUG_ON_PAGE(PageLRU(page), page);
> >
> > @@ -962,7 +987,7 @@ static void __pagevec_lru_add_fn(struct page *page,=
 struct lruvec *lruvec,
> >       if (page_evictable(page)) {
> >               lru =3D page_lru(page);
> >               update_page_reclaim_stat(lruvec, page_is_file_cache(page)=
,
> > -                                      PageActive(page));
> > +                                      PageActive(page) | rotate);
>
>
> Is it likely to rotate a page if we know it's not active?
>
>                 update_page_reclaim_stat(lruvec, page_is_file_cache(page)=
,
> -                                        PageActive(page));
> +                                        PageActive(page) ||
> +                                        !page_is_file_cache(page));
>

My intention is that only newly created anonymous pages contributes
the rotate count.
With your code suggestion, other case for anonymous pages could also contri=
butes
the rotate count since  __pagevec_lru_add_fn() is used else where.

Thanks.
