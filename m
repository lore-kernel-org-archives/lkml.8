Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB197C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A01A12073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPMXTxAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbgF3HTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730637AbgF3HTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:19:54 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E02FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:19:54 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z63so17655691qkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L9NG4akQ0nBWtVO2y1bLpJgsekyyKFQb47fyn8KWpiw=;
        b=lPMXTxAkII6/orv+Q0Cdu0nhGP2a1FRjQaxioElZ1l4TZYjNTQn/S79/ayPPa0CMQM
         vrorLFeJ8fyA/7aMcJK6QB6fIHr7kOn0pKy20MkETgC7lLx2/1cbhPXojqu3rNlL+YQz
         4bd8ZbgcuzGuKIyxKawPxgYdqDEK9QAUZDy6amqg9LdAeLAhuk5Hh9+cEFeEP1c5dIvV
         WONCyPtK3OyIJTxd4XsbqaJx6psL7FgErxLpbd1XPefsNg6lLCg4CqjXGK9q7M6Qar90
         CTIpq5Ugakti7ZX7uxl+fCZwuEwLl0/R213ebetw91FeTxPUAt/R9+dP9xYB2C9JLYrq
         SZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L9NG4akQ0nBWtVO2y1bLpJgsekyyKFQb47fyn8KWpiw=;
        b=Ogp0wsbjNaYw2eIQsgwCd5DfsP0/6xtrBPV+XFDUANVXuFACD/lBI1PswhFNgCRGPI
         uKSzHJrv1YkdEwHHnCxUzAF/hPqNdHwpt0FGT1TP3vfJqtmXsQ6+KALwAZdIVK/vKEdY
         4hO95oSHl1tAJGvL/evDQPQfMlINNFDwhLHTFR7zYW8IGfH3Ez4vXuYyf/Knohmb2RQF
         BZIt3BKp3VNJ4yLvR/mrZDjJqSSlMZx3Zbla2/TQVG4YUlVp2hTnoDJOZBscf4B07jZu
         GC0RLVZtuIHkS8ageqURNtGxLDW72kpreEE5ULp2fdmkdKBkB5m7JHJR+S+qF5i88cUX
         pmtg==
X-Gm-Message-State: AOAM532PLoq1e7hxFBmePAQkOwqQcyq1WdaHzpQDE7NeWte3C4kXujU3
        LpUr+zW6lDu1Rj6gZH0gFWXs6hVtNrHLF3N3QLHhLNxZ
X-Google-Smtp-Source: ABdhPJy4lgpHe8MfHwzjN4iKzdqrH2z9+Uk33jz/UDOx2enXLyTAGWpa0tXr+Km23qSNcTLudgmzGWYmkC8LrrQ8Pc4=
X-Received: by 2002:a05:620a:a1b:: with SMTP id i27mr18736007qka.429.1593501593115;
 Tue, 30 Jun 2020 00:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-6-git-send-email-iamjoonsoo.kim@lge.com> <20200625120550.GF1320@dhcp22.suse.cz>
 <CAAmzW4ObN=GAzCLw8betLftTeCEsLs4OihfNXvtg4CaWyWiBCw@mail.gmail.com>
 <20200626073342.GU1320@dhcp22.suse.cz> <CAAmzW4PT+M8mUwXMPhQSKLhz9nkPATivL5D-yLyyfC9SOwPnYQ@mail.gmail.com>
 <20200629080350.GB32461@dhcp22.suse.cz>
In-Reply-To: <20200629080350.GB32461@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 30 Jun 2020 16:19:38 +0900
Message-ID: <CAAmzW4PLMc-NgSwZC5VutyJ4AsCcOVchLXEDhKtTtfbRkkfdEA@mail.gmail.com>
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

2020=EB=85=84 6=EC=9B=94 29=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 5:03, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon 29-06-20 15:41:37, Joonsoo Kim wrote:
> > 2020=EB=85=84 6=EC=9B=94 26=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 4:3=
3, Michal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On Fri 26-06-20 14:02:49, Joonsoo Kim wrote:
> > > > 2020=EB=85=84 6=EC=9B=94 25=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84=
 9:05, Michal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > > > >
> > > > > On Tue 23-06-20 15:13:45, Joonsoo Kim wrote:
> > > [...]
> > > > > > -struct page *new_page_nodemask(struct page *page,
> > > > > > -                             int preferred_nid, nodemask_t *no=
demask)
> > > > > > +struct page *alloc_migration_target(struct page *page, unsigne=
d long private)
> > > > > >  {
> > > > > > -     gfp_t gfp_mask =3D GFP_USER | __GFP_MOVABLE | __GFP_RETRY=
_MAYFAIL;
> > > > > > +     struct migration_target_control *mtc;
> > > > > > +     gfp_t gfp_mask;
> > > > > >       unsigned int order =3D 0;
> > > > > >       struct page *new_page =3D NULL;
> > > > > > +     int zidx;
> > > > > > +
> > > > > > +     mtc =3D (struct migration_target_control *)private;
> > > > > > +     gfp_mask =3D mtc->gfp_mask;
> > > > > >
> > > > > >       if (PageHuge(page)) {
> > > > > >               return alloc_huge_page_nodemask(
> > > > > > -                             page_hstate(compound_head(page)),
> > > > > > -                             preferred_nid, nodemask, 0, false=
);
> > > > > > +                             page_hstate(compound_head(page)),=
 mtc->nid,
> > > > > > +                             mtc->nmask, gfp_mask, false);
> > > > > >       }
> > > > > >
> > > > > >       if (PageTransHuge(page)) {
> > > > > > +             gfp_mask &=3D ~__GFP_RECLAIM;
> > > > >
> > > > > What's up with this gfp_mask modification?
> > > >
> > > > THP page allocation uses a standard gfp masks, GFP_TRANSHUGE_LIGHT =
and
> > > > GFP_TRANHUGE. __GFP_RECLAIM flags is a big part of this standard ma=
sk design.
> > > > So, I clear it here so as not to disrupt the THP gfp mask.
> > >
> > > Why this wasn't really needed before? I guess I must be missing
> > > something here. This patch should be mostly mechanical convergence of
> > > existing migration callbacks but this change adds a new behavior AFAI=
CS.
> >
> > Before this patch, a user cannot specify a gfp_mask and THP allocation
> > uses GFP_TRANSHUGE
> > statically.
>
> Unless I am misreading there are code paths (e.g.new_page_nodemask) which=
 simply use
> add GFP_TRANSHUGE to GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL. And
> this goes all the way to thp migration introduction.

Ahh... Indeed. I missed that. There are multiple THP migration target
allocation functions
and some functions use GFP_TRANSHUGE + extra_mask so doesn't include
__GFP_KSWAPD_RECLAIM
but the others includes __GFP_KSWAPD_RECLAIM due to original GFP_USER.
Thanks for clarifying.

> > After this patch, a user can specify a gfp_mask and it
> > could conflict with GFP_TRANSHUGE.
> > This code tries to avoid this conflict.
> >
> > > It would effectively drop __GFP_RETRY_MAYFAIL and __GFP_KSWAPD_RECLAI=
M
> >
> > __GFP_RETRY_MAYFAIL isn't dropped. __GFP_RECLAIM is
> > "___GFP_DIRECT_RECLAIM|___GFP_KSWAPD_RECLAIM".
> > So, __GFP_KSWAPD_RECLAIM would be dropped for THP allocation.
> > IIUC, THP allocation doesn't use __GFP_KSWAPD_RECLAIM since it's
> > overhead is too large and this overhead should be given to the caller
> > rather than system thread (kswapd) and so on.
>
> Yes, there is a reason why KSWAPD is excluded from THP allocations in
> the page fault path. Maybe we want to extend that behavior to the
> migration as well. I do not have a strong opinion on that because I
> haven't seen excessive kswapd reclaim due to THP migrations. They are
> likely too rare.
>
> But as I've said in my previous email. Make this a separate patch with
> an explanation why we want this.

Okay. I will make a separate patch that clears __GFP_RECLAIM for passed
gfp_mask to extend the behavior. It will make THP migration target allocati=
on
consistent. :)

Thanks.
