Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10A0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 05:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66382078D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 05:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbrZtdsk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgFZFDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 01:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgFZFDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 01:03:01 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAF2C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 22:03:01 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id e2so3959077qvw.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 22:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MMxosiXThyG08g9F3Re/uAQnXv76LxHZgEoK5k+R5QU=;
        b=cbrZtdskpRSfzjwrQOgYOEWxvVAVB6E+a7lG85AZAzbaogkVU1KKQS/XtFaN6j7AWP
         AHWGQav/nh95AfpzALupwzlgBOY2gP9n7R++13RLBJVWVyvnubRfY8qtDkps5nbtOgWm
         +PS1namHJFu5x6A8Ae9YGg/YGye7gnXSI6Prlu6RyS6LRntON59cucam59UkEKW5hpZ0
         UycU1IUGQoaHMltjbR/DrD8Z7Uw3Q5PSgIk2t5kP2V8jLtZtLvO201zo5WQY8FoKxJvh
         9dY7JskJ6ZMeLg5FfZFDTgAyiTLR+Bmt0Lxf+jcNPbC8QUZpdr6VlR+uExRbXi85TnNF
         RcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MMxosiXThyG08g9F3Re/uAQnXv76LxHZgEoK5k+R5QU=;
        b=d3v0A1b9fWUc/qCFlEnhsLHhWWna5tjZiNvsat5WQJuh8cSWgv9s02AoL1BVt3POh/
         PxitmGc39CPPqunlrDMUzZJ/R07YD/1jd8m4tTAYN6v0N3LVcETJm5nbwfz59Otut7qz
         23oTznwmnx8ShKmOlJNetG9R/xmDWz7odotFtMb3UpBS9XSFXDOEAM1HCfgre8jV+TAY
         BImnN3avf2qjnaRLF8WIVLpaG0z0TYJkGwAxkQ6gO2AiHE7F1tRmXVq58QGRXlIrtFHB
         A7AXQxeAZfmtBv2mnC+hUPjZcIE7CpLS+fwJwku1HmERbXbexGLY+FUV2bLJDrJSXL+4
         xNFg==
X-Gm-Message-State: AOAM531sX501gIXpsT44cnEbhl0Si6pDWbc0haX+/j+8YsnQlmeJeetm
        h9KDEacGPVlxW9VYo2Kohd2AdCWq5uqEksPx/xE=
X-Google-Smtp-Source: ABdhPJxgPC/YgWJifSZGvOfbkY5aLyiTKb4zZQFBm05zn5BzUK2zgKygicURgajS84LdK5VtLX3V1xcBTRmuUJ+JtPg=
X-Received: by 2002:a0c:84c2:: with SMTP id m60mr1445883qva.198.1593147780680;
 Thu, 25 Jun 2020 22:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-6-git-send-email-iamjoonsoo.kim@lge.com> <20200625120550.GF1320@dhcp22.suse.cz>
In-Reply-To: <20200625120550.GF1320@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 26 Jun 2020 14:02:49 +0900
Message-ID: <CAAmzW4ObN=GAzCLw8betLftTeCEsLs4OihfNXvtg4CaWyWiBCw@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] mm/migrate: make a standard migration target
 allocation function
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 25=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:05, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue 23-06-20 15:13:45, Joonsoo Kim wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > There are some similar functions for migration target allocation. Since
> > there is no fundamental difference, it's better to keep just one rather
> > than keeping all variants. This patch implements base migration target
> > allocation function. In the following patches, variants will be convert=
ed
> > to use this function.
> >
> > Note that PageHighmem() call in previous function is changed to open-co=
de
> > "is_highmem_idx()" since it provides more readability.
>
> I was little bit surprised that alloc_migration_target still uses
> private argument while it only accepts migration_target_control
> structure pointer but then I have noticed that you are using it as a
> real callback in a later patch.
>
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Few questions inline
> [...]
>
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 47b8ccb..820ea5e 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1648,9 +1648,13 @@ EXPORT_SYMBOL(unpoison_memory);
> >
> >  static struct page *new_page(struct page *p, unsigned long private)
> >  {
> > -     int nid =3D page_to_nid(p);
> > +     struct migration_target_control mtc =3D {
> > +             .nid =3D page_to_nid(p),
> > +             .nmask =3D &node_states[N_MEMORY],
>
> This could be .namsk =3D NULL, right? alloc_migration_target doesn't
> modify the node mask and NULL nodemask is always interpreted as all
> available nodes.

Will do.

> > +             .gfp_mask =3D GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYF=
AIL,
> > +     };
> >
> > -     return new_page_nodemask(p, nid, &node_states[N_MEMORY]);
> > +     return alloc_migration_target(p, (unsigned long)&mtc);
> >  }
> >
> [...]
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 634f1ea..3afff59 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1536,29 +1536,34 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
> >       return rc;
> >  }
> >
> > -struct page *new_page_nodemask(struct page *page,
> > -                             int preferred_nid, nodemask_t *nodemask)
> > +struct page *alloc_migration_target(struct page *page, unsigned long p=
rivate)
> >  {
> > -     gfp_t gfp_mask =3D GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL=
;
> > +     struct migration_target_control *mtc;
> > +     gfp_t gfp_mask;
> >       unsigned int order =3D 0;
> >       struct page *new_page =3D NULL;
> > +     int zidx;
> > +
> > +     mtc =3D (struct migration_target_control *)private;
> > +     gfp_mask =3D mtc->gfp_mask;
> >
> >       if (PageHuge(page)) {
> >               return alloc_huge_page_nodemask(
> > -                             page_hstate(compound_head(page)),
> > -                             preferred_nid, nodemask, 0, false);
> > +                             page_hstate(compound_head(page)), mtc->ni=
d,
> > +                             mtc->nmask, gfp_mask, false);
> >       }
> >
> >       if (PageTransHuge(page)) {
> > +             gfp_mask &=3D ~__GFP_RECLAIM;
>
> What's up with this gfp_mask modification?

THP page allocation uses a standard gfp masks, GFP_TRANSHUGE_LIGHT and
GFP_TRANHUGE. __GFP_RECLAIM flags is a big part of this standard mask desig=
n.
So, I clear it here so as not to disrupt the THP gfp mask.

> >               gfp_mask |=3D GFP_TRANSHUGE;
> >               order =3D HPAGE_PMD_ORDER;
> >       }
> > -
> > -     if (PageHighMem(page) || (zone_idx(page_zone(page)) =3D=3D ZONE_M=
OVABLE))
> > +     zidx =3D zone_idx(page_zone(page));
> > +     if (is_highmem_idx(zidx) || zidx =3D=3D ZONE_MOVABLE)
> >               gfp_mask |=3D __GFP_HIGHMEM;
> >
> >       new_page =3D __alloc_pages_nodemask(gfp_mask, order,
> > -                             preferred_nid, nodemask);
> > +                             mtc->nid, mtc->nmask);
> >
> >       if (new_page && PageTransHuge(new_page))
> >               prep_transhuge_page(new_page);
> > diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> > index aec26d9..adba031 100644
> > --- a/mm/page_isolation.c
> > +++ b/mm/page_isolation.c
> > @@ -309,7 +309,11 @@ int test_pages_isolated(unsigned long start_pfn, u=
nsigned long end_pfn,
> >
> >  struct page *alloc_migrate_target(struct page *page, unsigned long pri=
vate)
> >  {
> > -     int nid =3D page_to_nid(page);
> > +     struct migration_target_control mtc =3D {
> > +             .nid =3D page_to_nid(page),
> > +             .nmask =3D &node_states[N_MEMORY],
>
> nmask =3D NULL again

Okay.

Thanks.
