Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6876BC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BA920643
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXdnC+un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgEDDIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 23:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgEDDIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 23:08:35 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9631CC061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 20:08:35 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f83so7933811qke.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 20:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qxxlvs+YEH140nApT4Xf3QR0858RxvcLN+In9z+Kg3k=;
        b=LXdnC+ung25aN57duHnahyoDG/bRnYKkQSnGQpKbTRGn1KqaPvFKi6fC83m4x0x5fA
         GxoZ1YzN6BwXJMuKXAG43o8pvI4ruFzQv9X2iNU1EUEl0ufglImj17wCAFbLr7vtqfMA
         bVJJQRIhVrDkBdOLu98tF4j2N0jcFZd8kWofv4uEyyFzK+1Vk0cy0TOM8pJlgKvgFM2C
         K8ZpcmaZ7FFw9c7jBgVD0sjVzQZd/JxEHFhNUFx3FSGX8GeY8h2RJCmYnxYRQf9dGMXV
         4lGkkVcu9gONbXZmJSZESnseETS8BFRodQsekPeewjTJ+2Mi10Rfn761I6N+q2WAHCcL
         AN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qxxlvs+YEH140nApT4Xf3QR0858RxvcLN+In9z+Kg3k=;
        b=gKurGMsQmVSaLZ/fYeQIJ8bc+fHdzZR0lksWMVk2IU6sTk2/sYGBvCacymVN6ASuB7
         rPSmtqVime1e66DJ8D56Eq9DkxOT/xTWXDEjqVc77ULQ1+oBwJ8bILAB17Z+AefJieP2
         Ycld15pZ/3skXosWOSJYszU8YMOFv7hMUe5cXfYIb+7/fU9qwZY+n8oSwVyrDTHTceg1
         PPpqVU0Ft8Tx70lyZb2LQfHGHjzAyRelqebgRwg4cT9idh6KYJ9hCmCNDH+dClfSTnE5
         KTlgaTph+T3yUSisdDTCZV0dGf0IKNEj4lnmjsnUpQZTNwCRI9IdyxQkZZjs5XJcnxO1
         rD2g==
X-Gm-Message-State: AGi0PuY29YyK7gbGReBv7WsE6hQ124BfCheanLtTr6Y0LYr1a/Ifgri/
        izXUXBEg1zZh5c4QV7hiMc1OZLBcyn9wMoft7/o=
X-Google-Smtp-Source: APiQypJSQ7AnUC4tEEmS5jB9JBL/9zuVylZoB75Jo58DUXvy+7Rt6Qhw4kwyh7crVQlvuRZe0VE3DvgZ2WuMM11vy4Q=
X-Received: by 2002:a05:620a:138e:: with SMTP id k14mr14477321qki.452.1588561714646;
 Sun, 03 May 2020 20:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1588130803-20527-8-git-send-email-iamjoonsoo.kim@lge.com> <20200501123052.GD21897@infradead.org>
In-Reply-To: <20200501123052.GD21897@infradead.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 4 May 2020 12:08:23 +0900
Message-ID: <CAAmzW4OZ9dW0j0f_o2hVCBVbeoLwFWrjAdiw87_dqfE9qvW5yg@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] mm: separate PageHighMem() and PageHighMemZone()
 use case
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 5=EC=9B=94 1=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:30, Ch=
ristoph Hellwig <hch@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Apr 29, 2020 at 12:26:40PM +0900, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > Until now, PageHighMem() is used for two different cases. One is to che=
ck
> > if there is a direct mapping for this page or not. The other is to chec=
k
> > the zone of this page, that is, weather it is the highmem type zone or =
not.
> >
> > Now, we have separate functions, PageHighMem() and PageHighMemZone() fo=
r
> > each cases. Use appropriate one.
> >
> > Note that there are some rules to determine the proper macro.
> >
> > 1. If PageHighMem() is called for checking if the direct mapping exists
> > or not, use PageHighMem().
> > 2. If PageHighMem() is used to predict the previous gfp_flags for
> > this page, use PageHighMemZone(). The zone of the page is related to
> > the gfp_flags.
> > 3. If purpose of calling PageHighMem() is to count highmem page and
> > to interact with the system by using this count, use PageHighMemZone().
> > This counter is usually used to calculate the available memory for an
> > kernel allocation and pages on the highmem zone cannot be available
> > for an kernel allocation.
> > 4. Otherwise, use PageHighMemZone(). It's safe since it's implementatio=
n
> > is just copy of the previous PageHighMem() implementation and won't
> > be changed.
> >
> > I apply the rule #3 for this patch.
> >
> > Acked-by: Roman Gushchin <guro@fb.com>
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > ---
> >  mm/memory_hotplug.c | 2 +-
> >  mm/page_alloc.c     | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 555137b..891c214 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -593,7 +593,7 @@ void generic_online_page(struct page *page, unsigne=
d int order)
> >       __free_pages_core(page, order);
> >       totalram_pages_add(1UL << order);
> >  #ifdef CONFIG_HIGHMEM
> > -     if (PageHighMem(page))
> > +     if (PageHighMemZone(page))
> >               totalhigh_pages_add(1UL << order);
> >  #endif
> >  }
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index fc5919e..7fe5115 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -7444,7 +7444,7 @@ void adjust_managed_page_count(struct page *page,=
 long count)
> >       atomic_long_add(count, &page_zone(page)->managed_pages);
> >       totalram_pages_add(count);
> >  #ifdef CONFIG_HIGHMEM
> > -     if (PageHighMem(page))
> > +     if (PageHighMemZone(page))
> >               totalhigh_pages_add(count);
> >  #endif
>
> This function already uses the page_zone structure above, I think
> life would be easier of you compare against that, as that makes
> the code more obvious.

If I can kill all the PageHighMemZone() macro, I will use page_zone() above=
.
However, if it's not possible, I will leave it as it is. It would be
simpler than
your suggestion.

Thanks.
