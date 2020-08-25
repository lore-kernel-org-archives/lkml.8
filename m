Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2484C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2426204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GghfrG7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgHYFeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 01:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbgHYFep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 01:34:45 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CBDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 22:34:44 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id l13so4987601qvt.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 22:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=drVWXY4OrHwvooutCydMRH+dz0kOVIaWYVFSu5MyClQ=;
        b=GghfrG7tHpB+RtuXLrsxXCN5gdU7IRtRyzu9aLirLBUqHoPc3rTHz9Stl1m/Nx9ap5
         Zrdq4fi9e7MkfPZzNKmKr0ljezPD3NLkhGr5wCtzxmB+LqITLs8fQq3erGQU6bKDKoyu
         owJxOO06fUOuMVEZGEjqOX+4/EpWaM0xHIfP1iRcOr0T1Iio4+cqc0LmtzwtaIDLzHl0
         /xhHbgSbSBpbECob2ZJPyp5CR1UE7pZAIX1J52o7dT0bmCJnINsjvX+O7YvNWgm4HyiA
         /Nb1qND2RH/p8Io1SXaKlWejMswiVhJX5YIBocoRcITp7LGfR1BQgh+2ObMKuT64s7IN
         3xeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=drVWXY4OrHwvooutCydMRH+dz0kOVIaWYVFSu5MyClQ=;
        b=TgVpDqIUnikMLPQuOTHDGwS/Nj92gKOWydGpWSd2t6n1xbK+9+w1avFU2GxwRU7R09
         kxRuyxBE++z5ON3VlRzh+q0SWbc/Qy85fqzN73k+a5bRb7kaN6m8QLGt85zoHO18pOhp
         96EijAyzifLFYyHDBLXI2j/dI+sS+FU7FSKaHbVdJzjmZDKHHD30uuUYiOPB/BoRumdw
         sudyVgw/acmRxGWlrVHiTLflv6oOhXEAs1YTsj+bk4IE+TVjxbscIZeNkZ6fFD0FoS9H
         rr0wtDV8roBtvkgmAwoE/BjUd2N8RoRTokrXR0pNnfhfsZYbDmNYyzblWf/P5+sPmqbL
         mX4g==
X-Gm-Message-State: AOAM533BbY5pUYwzOyDr6Ye7s9ACZf7QbJXQMZAEOHIvsihDaxK1b8TW
        gz7IyuY9LcaH2I8DwLLGgwIeg82JWnqAek+hWFpvD6BI
X-Google-Smtp-Source: ABdhPJz5hlNJ2+Bk73J6dH+BmdAkYr0PO3lp+wYxQVw8uEn/erP6D8b0V7QtRTYGy5rYRXZ+meXdQa0mGcLhjLaInKE=
X-Received: by 2002:a0c:ea8e:: with SMTP id d14mr7826970qvp.37.1598333683382;
 Mon, 24 Aug 2020 22:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <1598331582-19923-1-git-send-email-iamjoonsoo.kim@lge.com> <20200824221049.edb3c540bbfc859a6806600d@linux-foundation.org>
In-Reply-To: <20200824221049.edb3c540bbfc859a6806600d@linux-foundation.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 25 Aug 2020 14:34:32 +0900
Message-ID: <CAAmzW4MYQsRoR-q8tUmwPYLvCbiMq_zt19_AgorAQHnbwnu37g@mail.gmail.com>
Subject: Re: [PATCH for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        kernel-team@lge.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 8=EC=9B=94 25=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 2:10, A=
ndrew Morton <akpm@linux-foundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> On Tue, 25 Aug 2020 13:59:42 +0900 js1304@gmail.com wrote:
>
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > memalloc_nocma_{save/restore} APIs can be used to skip page allocation
> > on CMA area, but, there is a missing case and the page on CMA area coul=
d
> > be allocated even if APIs are used. This patch handles this case to fix
> > the potential issue.
> >
> > Missing case is an allocation from the pcplist. MIGRATE_MOVABLE pcplist
> > could have the pages on CMA area so we need to skip it if ALLOC_CMA isn=
't
> > specified.
> >
> > This patch implements this behaviour by checking allocated page from
> > the pcplist rather than skipping an allocation from the pcplist entirel=
y.
> > Skipping the pcplist entirely would result in a mismatch between waterm=
ark
> > check and actual page allocation. And, it requires to break current cod=
e
> > layering that order-0 page is always handled by the pcplist. I'd prefer
> > to avoid it so this patch uses different way to skip CMA page allocatio=
n
> > from the pcplist.
> >
> > ...
> >
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3341,6 +3341,22 @@ static struct page *rmqueue_pcplist(struct zone =
*preferred_zone,
> >       pcp =3D &this_cpu_ptr(zone->pageset)->pcp;
> >       list =3D &pcp->lists[migratetype];
> >       page =3D __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, =
list);
> > +#ifdef CONFIG_CMA
> > +     if (page) {
> > +             int mt =3D get_pcppage_migratetype(page);
> > +
> > +             /*
> > +              * pcp could have the pages on CMA area and we need to sk=
ip it
> > +              * when !ALLOC_CMA. Free all pcplist and retry allocation=
.
> > +              */
> > +             if (is_migrate_cma(mt) && !(alloc_flags & ALLOC_CMA)) {
> > +                     list_add(&page->lru, &pcp->lists[migratetype]);
> > +                     pcp->count++;
> > +                     free_pcppages_bulk(zone, pcp->count, pcp);
> > +                     page =3D __rmqueue_pcplist(zone, migratetype, all=
oc_flags, pcp, list);
> > +             }
> > +     }
> > +#endif
> >       if (page) {
> >               __count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
> >               zone_statistics(preferred_zone, zone);
>
> That's a bunch more code on a very hot path to serve an obscure feature
> which has a single obscure callsite.
>
> Can we instead put the burden on that callsite rather than upon
> everyone?  For (dumb) example, teach __gup_longterm_locked() to put the
> page back if it's CMA and go get another one?

Hmm... Unfortunately, it cannot ensure that we eventually get the non-CMA p=
age.
I think that the only way to ensure it is to implement the
functionality here. We can
use 'unlikely' or 'static branch' to reduce the overhead for a really
rare case but
for now I have no idea how to completely remove the overhead.

Thanks.
