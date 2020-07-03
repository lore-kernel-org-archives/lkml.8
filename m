Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C64C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0610420884
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tiv0Wo8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGCAsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 20:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgGCAr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 20:47:59 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB4BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 17:47:59 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id p7so13597342qvl.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 17:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QubtygT6CHPqxIkPsZey+WL7TuPuIYxqs13CLNXIeHw=;
        b=Tiv0Wo8V7BGJ98NUyieGZaCTDAHig6wZyVeaeiVFIhMeO7PL64VLLJBKgiGnmMAWOb
         lIqVjjiMrLzx6Bq8hBzWRDDQN07NPH6sC6vkNbqGv4Q3vLWGezl/uVoGQqE3hiApBORw
         BByd9gH5KUFCjtxCAGSwM1yN8t+O+LK3sJqVf/84Sg11eSAdQJ3/R+iapUrOTzX1SmrK
         Jgegw6uQzJNoHzVgfPNpl+730XkD8fClhCTriVjZG5k2alnF5LFTDfaLx/rMMpNcTj1i
         ic8IQ+h9FAVX8PG81NiOqwqSgN/NG0iGI2Nx6ugBbSxoCFaqCYDazWouLUL3fZM7YTly
         35IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QubtygT6CHPqxIkPsZey+WL7TuPuIYxqs13CLNXIeHw=;
        b=ZOLsN3skqJCqQazm5/MhVkuJfsK1AE1xcnAcGTvTKpb01SUhLOWi94JxXeGHKEPXqQ
         dt+ayP+ZVBwIgyQCP9pUgfFCgs0YWztWEwPhDNhD66FeLrQvcC4IwyrAgkQQvVTKA+rD
         IpOm+oBfxfWQ9wZbLw117lMSJ9fs3ZNE9dmAGL442N10Q8WqfXEarByCl4PFeNiy6vMA
         0wwLwtu/iiMwIYY+qSeT0UbEh4gHfGS33k7Lc4T3CnedU5ZpzDwlFgYQoGjNeSWFitVv
         qndLb8hbQzAqe6lHX5/TZ4crjpqQh4XaKeh/JzTJbpraApg/7Ms2NvFgSUBW546EpuLI
         H2mQ==
X-Gm-Message-State: AOAM533y66DgllmeDovtAfv1GNPLfxLxdjjsk7rJMv/iqQSoyxZ2b11B
        GbdfKnTlSa2mdtExKn3aOJ7ogJYykdQGfWtx0zs=
X-Google-Smtp-Source: ABdhPJz809WyueVeEH9q/ZinGqq/wkDF6ZSpVhBPgriKUE1wN1KSOm4Ffh2VFu7uGvVVyrWeg1m0pqs1z6kQw7zzoNs=
X-Received: by 2002:a0c:99c5:: with SMTP id y5mr9684766qve.66.1593737278471;
 Thu, 02 Jul 2020 17:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592371583-30672-3-git-send-email-iamjoonsoo.kim@lge.com> <4591b38d-fdd0-e2e6-bf11-6e5669575736@suse.cz>
In-Reply-To: <4591b38d-fdd0-e2e6-bf11-6e5669575736@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 3 Jul 2020 09:47:47 +0900
Message-ID: <CAAmzW4M3O_tpg9OdNeagQStVu5nhz_-gFiHnkqdeF6mOn8tqNg@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] mm/vmscan: protect the workingset on anonymous LRU
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 7=EC=9B=94 2=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 3:02, Vl=
astimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 6/17/20 7:26 AM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Hi, how about a more descriptive subject, such as

Hello,

> mm/vmscan: add new anonymous pages to inactive LRU list

This patch does two things to implement workingset protection.

- add new anonymous pages to inactive LRU list
- check two reference to activate

So, I think that the current subject is more descriptive for this patch.

> > In current implementation, newly created or swap-in anonymous page
> > is started on active list. Growing active list results in rebalancing
> > active/inactive list so old pages on active list are demoted to inactiv=
e
> > list. Hence, the page on active list isn't protected at all.
> >
> > Following is an example of this situation.
> >
> > Assume that 50 hot pages on active list. Numbers denote the number of
> > pages on active/inactive list (active | inactive).
> >
> > 1. 50 hot pages on active list
> > 50(h) | 0
> >
> > 2. workload: 50 newly created (used-once) pages
> > 50(uo) | 50(h)
> >
> > 3. workload: another 50 newly created (used-once) pages
> > 50(uo) | 50(uo), swap-out 50(h)
> >
> > This patch tries to fix this issue.
> > Like as file LRU, newly created or swap-in anonymous pages will be
> > inserted to the inactive list. They are promoted to active list if
> > enough reference happens. This simple modification changes the above
> > example as following.
> >
> > 1. 50 hot pages on active list
> > 50(h) | 0
> >
> > 2. workload: 50 newly created (used-once) pages
> > 50(h) | 50(uo)
> >
> > 3. workload: another 50 newly created (used-once) pages
> > 50(h) | 50(uo), swap-out 50(uo)
> >
> > As you can see, hot pages on active list would be protected.
> >
> > Note that, this implementation has a drawback that the page cannot
> > be promoted and will be swapped-out if re-access interval is greater th=
an
> > the size of inactive list but less than the size of total(active+inacti=
ve).
> > To solve this potential issue, following patch will apply workingset
> > detection that is applied to file LRU some day before.
>
> detection similar to the one that's already applied to file LRU.

Will change!

> > v6: Before this patch, all anon pages (inactive + active) are considere=
d
> > as workingset. However, with this patch, only active pages are consider=
ed
> > as workingset. So, file refault formula which uses the number of all
> > anon pages is changed to use only the number of active anon pages.
>
> a "v6" note is more suitable for a diffstat area than commit log, but it'=
s good
> to mention this so drop the 'v6:'?

Okay.

> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

> One more nit below.
>
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -476,23 +476,24 @@ void lru_cache_add(struct page *page)
> >  EXPORT_SYMBOL(lru_cache_add);
> >
> >  /**
> > - * lru_cache_add_active_or_unevictable
> > + * lru_cache_add_inactive_or_unevictable
> >   * @page:  the page to be added to LRU
> >   * @vma:   vma in which page is mapped for determining reclaimability
> >   *
> > - * Place @page on the active or unevictable LRU list, depending on its
> > + * Place @page on the inactive or unevictable LRU list, depending on i=
ts
> >   * evictability.  Note that if the page is not evictable, it goes
> >   * directly back onto it's zone's unevictable list, it does NOT use a
> >   * per cpu pagevec.
> >   */
> > -void lru_cache_add_active_or_unevictable(struct page *page,
> > +void lru_cache_add_inactive_or_unevictable(struct page *page,
> >                                        struct vm_area_struct *vma)
> >  {
> > +     bool unevictable;
> > +
> >       VM_BUG_ON_PAGE(PageLRU(page), page);
> >
> > -     if (likely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) !=3D VM_LOC=
KED))
> > -             SetPageActive(page);
> > -     else if (!TestSetPageMlocked(page)) {
> > +     unevictable =3D (vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) =3D=3D=
 VM_LOCKED;
> > +     if (unevictable && !TestSetPageMlocked(page)) {
>
> I guess this could be "if (unlikely(unevictable) && ..." to match the pre=
vious
> if (likely(evictable)) else ...

I will fix it, too.

Thanks.
