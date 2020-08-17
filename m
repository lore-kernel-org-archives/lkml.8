Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA79C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 20:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98AD62065D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 20:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml31MldZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgHQUsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgHQUsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 16:48:50 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D29C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 13:48:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id jp10so19496011ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 13:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YjJiTdRGVF0goPd59MYh+h3GY5hJS7gjFJZG7yoZyuo=;
        b=Ml31MldZn3KK/G0Jv6xZ6AsDMJw1ouC75FKCJbyKahiNIHPcYUhQ9pY3PetacMCzgj
         29l9MdrYbJVXDk6a3qcrbb8sKIRCSUDQjQ8uYiWDYZo5I2kEry+av3DmVI7ms+VnFpAn
         E7GZO0Koosh2k0JjS84dvRjbh24Fnsz1nS6HKH9+DOvelmDBUYzmHSI/zbw8R3DRQsJ5
         BkDtogbecfflmhe8DiUaz8zRn5xSK9MeB14D8CJxT28v6dmgJZH2MqingR2/Mvniz8L8
         YZE6zoU0ah9zmyqqB4N+S6OK/iWa5swlS0fjbDitnEzxfWqtIEvo4x7BFIBvXooQkoM9
         mQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YjJiTdRGVF0goPd59MYh+h3GY5hJS7gjFJZG7yoZyuo=;
        b=cYztxSRa+2NT3j0/BRWVKSER4+qaO0p7Lm34T2hiFX/KXiVD5+5m06rk+Qcz3UQ04s
         8T5/mivkTCsuZIAj2mpaoi1sVTNNDqsoeHsajb4CgZzr5SiW5ntbhSSNXcLHJC8F9me8
         TFmj85LRfmbdc1UfOhKx+9HM2x8kFcGALIjtmOg88oC03jskqCao0g6Vc/g2tnc8jgzH
         DA9Ud61zziIQgjct5utM2tjaVRq1O6FtxdL9hJuWZjyju1ATXBRrB45OwE9g40wXMmdm
         bPn2Jd46ohz5oc729KMxidal7CRhKKOUIfSgFaWbrMF6oQHcykpvFyENOL0qv2/uB94l
         DiFw==
X-Gm-Message-State: AOAM531E1s7ltEkeH/8rX6stLEMtzAB7i6mwGkMQV2K6LL58a0/YXKAk
        +hG96rGo3CyQ+rPCXs2c9Gdn/5dNuviZAdLLg14=
X-Google-Smtp-Source: ABdhPJwj2ZNodIPnhvWf7gZdnK0XLGnOVTYhBQ/2U3GGCu29TZbMGFv52dm9ubVdmWKb0myBqrh169embzt5sYL/rmc=
X-Received: by 2002:a17:907:2078:: with SMTP id qp24mr16704362ejb.286.1597697328178;
 Mon, 17 Aug 2020 13:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200812040423.2707213-1-yuzhao@google.com> <CAHbLzkqE+i8Y+YQE-6DJgED6Hwpa4BftNdVHgpB1YT7sEcPVcw@mail.gmail.com>
 <20200813073408.GA3996183@google.com>
In-Reply-To: <20200813073408.GA3996183@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 17 Aug 2020 13:48:36 -0700
Message-ID: <CAHbLzkqTF+zsPLcKomfequ6jvPaNg=gorf_Tz2o7ntVHS7quuQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: don't call activate_page() on new ksm pages
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Mel Gorman <mgorman@suse.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joonsoo Kim <js1304@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 12:34 AM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Aug 12, 2020 at 10:19:24PM -0700, Yang Shi wrote:
> > On Tue, Aug 11, 2020 at 9:04 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > lru_cache_add_active_or_unevictable() already adds new ksm pages to
> > > active lru. Calling activate_page() isn't really necessary in this
> > > case.
> > >
> > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > > ---
> > >  mm/swapfile.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index 6c26916e95fd..cf115ea26a20 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -1913,16 +1913,16 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
> > >                    pte_mkold(mk_pte(page, vma->vm_page_prot)));
> > >         if (page == swapcache) {
> > >                 page_add_anon_rmap(page, vma, addr, false);
> > > +               /*
> > > +                * Move the page to the active list so it is not
> > > +                * immediately swapped out again after swapon.
> > > +                */
> > > +               activate_page(page);
> >
> > Actually I think we could just remove this activate_page() call with
> > Joonsoo's anonymous page workingset series merged. The active bit will
> > be taken care by workingset_refault().
> >
> > >         } else { /* ksm created a completely new copy */
> > >                 page_add_new_anon_rmap(page, vma, addr, false);
> > >                 lru_cache_add_active_or_unevictable(page, vma);
> >
> > And it looks the latest linus's tree already changed this to
> > lru_cache_add_inactive_or_unevictable() by commit b518154e59
> > ("mm/vmscan: protect the workingset on anonymous LRU")
>
> Oops, apparently my tree is out of date. I'll work on a new version
> that removes the superfluous activate_page(). Meanwhile, can you
> please take a look at the rest of this series and let me know if
> there is anything else that we might want to change? Thank you.

I took a look at those two patches. For the #2 I didn't spot anything
wrong, but I may miss something. For the #3, TBH I don't think the
justification is strong enough since you just moved the PG_waiters bit
cleared to allocation time, someone could argue it may hurt allocation
latency.
