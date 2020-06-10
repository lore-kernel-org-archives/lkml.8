Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5984C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2E620734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sH1hR/ft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgFJFYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 01:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgFJFYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 01:24:09 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ADDC05BD1E;
        Tue,  9 Jun 2020 22:24:09 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e16so865604qtg.0;
        Tue, 09 Jun 2020 22:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=stGYbyy0hIe7gMKA+zTlsc1pHHaFqBnSNnTM1vxhGKQ=;
        b=sH1hR/ftg7dbREqfBeQfywQVOoxKF3sIqXK2QX136WVvT/h4dfC3Hl8BWk2LIiO4v2
         ebsj9ltehqZnk72848Dp/lMT7CPR/VYQTiX3pR0QmXptTFIyotit+3OGCR7ehLV2Mnd9
         PQSeYv584hymmo/eNDDFilggT/r1hTXQxuxImm3sipYpIT69G/EXGDX76bTMhw0GehN8
         hnJyWBrVIfEqxfWrhJHfFzP+H4XVCbgkIBpXlWxU/kNMm85NEmK3+Ma2hNzeDVHk5CIc
         fvOdhfF/oQ5RomnARokjpgc4BYk267IDKqfhWAJD4R/QK7YWL7EhTavcnimr9zIfh8T8
         vYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=stGYbyy0hIe7gMKA+zTlsc1pHHaFqBnSNnTM1vxhGKQ=;
        b=unvYGip9LWgKKdTIZaT1TvzVJBWCJ5X5e4aWCharVQiKu/hapXrnW/WtCjSix3pCfU
         SGZ8iAtMR/QRHaS4l2g1zeuVyHyKs21fNCcL840uu5/5v8ooVpo0Z/XSLBOOWb6oauLl
         lWv6IW785KBCbOiPV+ErgumnhExGgsorNwgk3Iph2wyBSr3QkOKaJCqzplFGyN1hn/49
         pSppSPInZWCrWVvxS6du8Q/kK9D/8Ljv0hRHqf9ADRlh+8+ycUQKfAf3y/g4653hAcph
         LKp7UyWba9wOBgf8h1DS2n73hJupO7XgtkazBzCsReNAuH7tOB2KdAxp9pZWVUv9/veh
         4yQg==
X-Gm-Message-State: AOAM533kibH7EzLwzyuUVU/fTY2WzRfBPLC34RU6bsPrn9lZqw88i60W
        QGbfL0DJv5KNtjl7fWHNBgO+zbWVe61WflFgBeQ=
X-Google-Smtp-Source: ABdhPJwS1Vbp0l7/qFukLruWw2/DM2AotG/IwW7Hj0E6hxH7fGTPOWujbInp5kKoPKMdHOe4g8sGnOqC62TGe3dflnw=
X-Received: by 2002:aed:2359:: with SMTP id i25mr1440164qtc.194.1591766648490;
 Tue, 09 Jun 2020 22:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200603230303.kSkT62Lb5%akpm@linux-foundation.org>
 <a60f7866-3b32-7a0e-5d0a-a48d77f845a8@linux.alibaba.com> <20200609144551.GA452252@cmpxchg.org>
In-Reply-To: <20200609144551.GA452252@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 10 Jun 2020 14:23:57 +0900
Message-ID: <CAAmzW4OrmCBQC05E6Kr-pLw3VU=cthzZCpfEzDabhO5vTaq8KA@mail.gmail.com>
Subject: Re: [patch 113/131] mm: balance LRU lists based on relative thrashing
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?B?6rmA66+87LCs?= <minchan@kernel.org>,
        mm-commits@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 11:46, J=
ohannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Jun 09, 2020 at 05:15:33PM +0800, Alex Shi wrote:
> >
> >
> > =E5=9C=A8 2020/6/4 =E4=B8=8A=E5=8D=887:03, Andrew Morton =E5=86=99=E9=
=81=93:
> > >
> > > +   /* XXX: Move to lru_cache_add() when it supports new vs putback *=
/
> >
> > Hi Hannes,
> >
> > Sorry for a bit lost, would you like to explain a bit more of your idea=
 here?
> >
> > > +   spin_lock_irq(&page_pgdat(page)->lru_lock);
> > > +   lru_note_cost(page);
> > > +   spin_unlock_irq(&page_pgdat(page)->lru_lock);
> > > +
> >
> >
> > What could we see here w/o the lru_lock?
>
> It'll just be part of the existing LRU locking in
> pagevec_lru_move_fn(), when the new pages are added to the LRU in
> batch. See this older patch for example:
>
> https://lore.kernel.org/linux-mm/20160606194836.3624-6-hannes@cmpxchg.org=
/
>
> I didn't include it in this series to reduce conflict with Joonsoo's
> WIP series that also operates in this area and does something similar:

Thanks!

> https://lkml.org/lkml/2020/4/3/63

I haven't completed the rebase of my series but I guess that referenced pat=
ch
"https://lkml.org/lkml/2020/4/3/63" would be removed in the next version.

Before the I/O cost model, a new anonymous page contributes to the LRU recl=
aim
balance. But, now, a new anonymous page doesn't contributes to the I/O cost
so this adjusting patch would not be needed anymore.

If anyone wants to change this part,
"/* XXX: Move to lru_cache_add() when it supports new vs putback */", feel =
free
to do it.

Thanks.
