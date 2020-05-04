Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC07C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B3B6206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDG+Nkkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgEDDDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 23:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbgEDDDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 23:03:04 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6762DC061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 20:03:04 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q7so15319393qkf.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 20:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6VKmRZQoAi2XKZ9R9IxXdPd+IOCcT2HWgI8X3qTMjEk=;
        b=WDG+NkkcTqZQueDWsJd72lp06lGDOnKch7ZI9bj0ZpmR/z1dyQjpCQvH8gJgb5oCUQ
         JFkTAfLlILFElrDYcpzuSQckxBQdwb36P5NoVys6Tgf/8kCVM4qLljZ3KeHde5zxgzK8
         P1S+Hxxjgelta8sFQkPIthS44Nof2yQcr2WC0Af4UB9wAhy3N85KUhSoftuhkHtqBNKa
         UeTlb1Cc3L0MZu/wcow3956MteAvwo3ClyGdjteqO4kTE7ZrK3AxB+uOXtMPaUpKV4fr
         Q1uVCXXtaU/CnEeYkpXGu5xTuaOXJGbfVO8WfJDvJqFJaP8XhAhU788X1U09QjKwSjC9
         ZC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6VKmRZQoAi2XKZ9R9IxXdPd+IOCcT2HWgI8X3qTMjEk=;
        b=XjXs1WcO6nj5g6LH9GWqTE2+pwZbU5RDbkl6A8GzOhr9GfnlpxQRqiCbDTDpCfrZlA
         84Gv6m8bGWXC/aGuzy6dZ5uwsoA1I1cL4yQCBNmhIzltD6/uXllQ6WyUjOIAuVMAAXfm
         zG30Qf+NoFblHB09W70cbBEojFVWzZDELnH+GGHTQzrUAP7gPde1H2A9bAv18MWlZ6hi
         Tm53Pla0+Ci3dZxSA9/4BW8Rtlu9jVT10wxAOI6trvNvjYQe4pFh+FdwnhP/mKFXgTfw
         nGkwCNXftfgYoaTNXM4BtXFNmi7alkM2GvGAeiVvxoQhZ9X1Fq96t/pQTDsbLlv7YyIr
         qHHQ==
X-Gm-Message-State: AGi0PubFAAdU+qVqfaOomAxGehAQaOoZL+Ai0rN+MLFb3EjUOV43ES97
        95pUi558bYyUPyEaenhJvM5ZjPlseHj1mTkdvuk=
X-Google-Smtp-Source: APiQypIwV4l/gvU4QExXYfhUKUXlzf7D5RROpYiLehTEpXv/GWWOMLHjatqzIkIMiXJZVN0IbizscDuu2LUFHJBXTGI=
X-Received: by 2002:ae9:ea0a:: with SMTP id f10mr8876257qkg.272.1588561383180;
 Sun, 03 May 2020 20:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1588130803-20527-6-git-send-email-iamjoonsoo.kim@lge.com> <20200501122427.GB21897@infradead.org>
In-Reply-To: <20200501122427.GB21897@infradead.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 4 May 2020 12:02:52 +0900
Message-ID: <CAAmzW4NERJeiVsekHFicbH2v4BMQprUsHe+9U+T4JvMMOMB=PA@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] mm/gup: separate PageHighMem() and
 PageHighMemZone() use case
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

2020=EB=85=84 5=EC=9B=94 1=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:24, Ch=
ristoph Hellwig <hch@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, Apr 29, 2020 at 12:26:38PM +0900, js1304@gmail.com wrote:
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
> > I apply the rule #2 for this patch.
> >
> > Acked-by: Roman Gushchin <guro@fb.com>
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > ---
> >  mm/gup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 11fda53..9652eed 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -1608,7 +1608,7 @@ static struct page *new_non_cma_page(struct page =
*page, unsigned long private)
> >        */
> >       gfp_t gfp_mask =3D GFP_USER | __GFP_NOWARN;
> >
> > -     if (PageHighMem(page))
> > +     if (PageHighMemZone(page))
> >               gfp_mask |=3D __GFP_HIGHMEM;
>
> I think this wants to stay PageHighMem.  This migrates CMA pages to
> other places before doing a long term pin.  Anything that didn't have
> a direct mapping before won't need one for the new page, which could
> also include non-highmem zones without a highmem mapping.

What we want to do here is to guess allocation gfp flags of original
page in order to allocate
a new page with most relaxed gfp flag. It is depend on the zone where
the page belong to
rather than existence of direct mapping. Until now, existence of
direct mapping implies
the type of zone so there is no problem.

After my future CMA patchset, direct mapped CMA page will be on the
ZONE_MOVABLE.
And, a page on ZONE_MOVABLE should be allocated with __GFP_HIGHMEM |
__GFP_MOVABLE.
So, most relaxed gfp flag for this CMA page would include
__GFP_HIGHMEM. If PageHighMem()
is used here, __GFP_HIGHMEM would be lost since this CMA page has a
direct mapping.

Therefore, PageHighMemZone() is right one here.

Anyway, I saw Eric's comment in other e-mail that abstraction is
needed to guess gfp flags of
original page and I agree with it. This site can also get benefit of
such a change.

Thanks.
