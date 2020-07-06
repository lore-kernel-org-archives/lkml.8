Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C12C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33A620724
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIf6Nsqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGFIeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgGFIeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:34:36 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A0CC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 01:34:36 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id m8so12611193qvk.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 01:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UkKwMcyV/GIfNduaGOpb0yO+n875IEZ+a5vFi7DoFpk=;
        b=DIf6NsqeHVipKmVGsTJqd0GUJh0l+C6ZQxY2ih+ict7nQ1yoDCOZ9fNe8A4UoyjpaM
         uDH1M1E6zSsDUgV/bOeuHpDnRu2+vdPJIcKI2atc0fIcSgzXgW2MNZaIhA1jrOtb+s1F
         hath9V1gbPmd/NeroyZBPcDq2X+ZAfs0UvN5Tz7y6WdFqIftTifpOJdWixbpIgeyHsgk
         mosNhaIyCEIHAK4Z5QYQp99hforMNcMTDO8UevE/n9XK+hrZ8l6Ce6oz4acoMmvXRvhf
         +YikJlULjh7ZHAzmZ0S3Ad8td4BocD1NYEux4809TroeBRQh0ht/gWDTvb2/eEiJxzlR
         nVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UkKwMcyV/GIfNduaGOpb0yO+n875IEZ+a5vFi7DoFpk=;
        b=mIOV5Ak1vHX31f97DbAR5hG/98/Ia27m76x3goeJRUCste1gh3+KoVP1/h3KTAXB+L
         K7nG+Giq1j4xEIRbgbxK+dDH17cEZi1l4cOCj6XUEJL99ZYSrQGbWnQQdzsgLlIoMtaK
         A/ReKtDc7jJwqguDYhpaOXoHHcOZ0C+t3Gvs10NjxQ8Luvt4QTCl4C4AmGAKOKOAQEP0
         q1AWCkWN6l0yq4YfrHinZsI7N7pYgvH0y/omhyMI7EobXklxNiHQSCdmnVNk+/h5Pk8H
         t8Zm4DeqgD4IwndCe7b+0BoNs7Hs4+qGzTJsCMIn2yfY6srNKrr2LGXA1p93fSpGB9I0
         oWhQ==
X-Gm-Message-State: AOAM530GNAoE9S3pxAsXUs8YUE+IgTDwGZ6ooM28XsXyDdhLxX/C0oxC
        VGA+NNgBYyQQqe/8NJtBCQ+mq8RSo5nmhuJuNtw=
X-Google-Smtp-Source: ABdhPJzvQ/UEjQJLymsEW6+9+VbkS0haV5RioJL/PYBX+QMXInUlAPbwpJdA/73/RaZLynG/7h/cWMq7+zWksj+uAhw=
X-Received: by 2002:a0c:99c5:: with SMTP id y5mr22989544qve.66.1594024475887;
 Mon, 06 Jul 2020 01:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-7-git-send-email-iamjoonsoo.kim@lge.com> <1693d7a8-4384-8fd8-69a2-55552329a34d@suse.cz>
In-Reply-To: <1693d7a8-4384-8fd8-69a2-55552329a34d@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 6 Jul 2020 17:34:24 +0900
Message-ID: <CAAmzW4N7TQtJT+Mo+dfaJ0TEhZ+xHq3waBa7Q5qKGt0vTEBOHA@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] mm/gup: use a standard migration target allocation callback
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 7=EC=9B=94 4=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 12:56, V=
lastimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 6/23/20 8:13 AM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > There is a well-defined migration target allocation callback.
> > It's mostly similar with new_non_cma_page() except considering CMA page=
s.
> >
> > This patch adds a CMA consideration to the standard migration target
> > allocation callback and use it on gup.c.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> But a suggestion below.
>
> > ---
> >  mm/gup.c      | 57 ++++++++-------------------------------------------=
------
> >  mm/internal.h |  1 +
> >  mm/migrate.c  |  4 +++-
> >  3 files changed, 12 insertions(+), 50 deletions(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 15be281..f6124e3 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1608,56 +1608,15 @@ static bool check_dax_vmas(struct vm_area_struc=
t **vmas, long nr_pages)
> >  }
> >
> >  #ifdef CONFIG_CMA
> > -static struct page *new_non_cma_page(struct page *page, unsigned long =
private)
> > +static struct page *alloc_migration_target_non_cma(struct page *page, =
unsigned long private)
> >  {
>
> ...
>
> > +     struct migration_target_control mtc =3D {
> > +             .nid =3D page_to_nid(page),
> > +             .gfp_mask =3D GFP_USER | __GFP_NOWARN,
> > +             .skip_cma =3D true,
> > +     };
> >
> > -     return __alloc_pages_node(nid, gfp_mask, 0);
> > +     return alloc_migration_target(page, (unsigned long)&mtc);
>
> Do we really need this wrapper? The only user is check_and_migrate_cma_pa=
ges so
> just opencode it?

This wrapper exists for setting up a different nid for each page.
However, as you suggested in the next reply, we can remove this wrapper if
NUMA_NO_NODE handling is added to the standard function. I will add NUMA_NO=
_NODE
handling to the standard function and remove this wrapper.

Thanks.
