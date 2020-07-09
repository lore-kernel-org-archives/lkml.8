Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189A6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E975020720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+3u2bih"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgGIHRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgGIHRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:17:09 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDB3C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 00:17:09 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id u8so508384qvj.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 00:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1h9hVyMdDTclBK3/1w4oe9XLN0atp9mtAvhs8SlUBmI=;
        b=g+3u2bih4uowCA884qHq+VmLkDKONLAf8gzEmX8yKeaHdxWGltwlSrLncUwJqhJcbA
         nWzP8CRWLWahZbt289cyjsiumve0sm340Wp7dLS6kNpRTG4Wms8XBNggk99fjRXORYGZ
         L4DHoHTiV2tNcZpivoiB7jYkUkxVgGcvBLw6iwKXgNIj4Wky2BF6tzLD0NRvPU4s5R5V
         SYT9rOiZbIP6UWUWqcOxR80bh6z2mRqyFLIa0Y5ClV5FWiSg6M/UaLaDKGaiMH6sQ7+a
         vfJUoUABqMlyiPZZ2cVVV/Wwt1Y1OVThXT4985Qj2AwgGuROs81wzt1SPX3PRSNc1JsG
         geDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1h9hVyMdDTclBK3/1w4oe9XLN0atp9mtAvhs8SlUBmI=;
        b=Pp9NahFBXl/elykLFLT8uUnBtQFgzT33y/y4DJubbJOrqG6tcIsN1pyeyGLa+WK/3F
         JH7P9/LWkze0A0uxiLyYbCojfp6j405sL3Kk2bWcRGFtQ/mdIrN69AtuIkXAHuyWkvb4
         Lwgx+tpijBshmd2BeC3EwW7qXMfTpSRm77JmTk5VCwmr5ZfjL/gyOIQ6Ih//JHQT0nl1
         wBqyT48VZzCER8jbEtBzGaFL76lDwLpmVAWRW7wE5sSjAJK+INcRF3XMqyXcxt4DMUWt
         r+hsUsJ/M8bcJ0tQiF6NMEjvkWQ/rAGNFgpRwJ2f3Xko4WEL34ianFnYKiw0htHbkI/z
         UtZg==
X-Gm-Message-State: AOAM533cHClgti0gxncBQahjVZwMorvttQpudErn54JkZVUpe9U9tqr4
        xeDBMNywc5KYijDl38iNbdnJe97e8VnPU9Mti+k=
X-Google-Smtp-Source: ABdhPJzAz1NpOlRR93dBItEctK+mP/Znt4rMOYhjdQZltbJbofLUiwAuipdskYLUIwvhTvD3fAb0GDgwvgY6WGjf1ng=
X-Received: by 2002:a0c:99c5:: with SMTP id y5mr38274997qve.66.1594279028564;
 Thu, 09 Jul 2020 00:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-6-git-send-email-iamjoonsoo.kim@lge.com> <e72709dd-c7e2-ff26-f450-dbd2a719b2e4@suse.cz>
In-Reply-To: <e72709dd-c7e2-ff26-f450-dbd2a719b2e4@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 9 Jul 2020 16:17:08 +0900
Message-ID: <CAAmzW4M5kAFgS_P3D8R-1qM+Gpex1Zu=G7aQC3uAYno4UeKBrg@mail.gmail.com>
Subject: Re: [PATCH v4 05/11] mm/migrate: clear __GFP_RECLAIM for THP
 allocation for migration
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

2020=EB=85=84 7=EC=9B=94 7=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:17, Vl=
astimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 7/7/20 9:44 AM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > In mm/migrate.c, THP allocation for migration is called with the provid=
ed
> > gfp_mask | GFP_TRANSHUGE. This gfp_mask contains __GFP_RECLAIM and it
> > would be conflict with the intention of the GFP_TRANSHUGE.
> >
> > GFP_TRANSHUGE/GFP_TRANSHUGE_LIGHT is introduced to control the reclaim
> > behaviour by well defined manner since overhead of THP allocation is
> > quite large and the whole system could suffer from it. So, they deals
> > with __GFP_RECLAIM mask deliberately. If gfp_mask contains __GFP_RECLAI=
M
> > and uses gfp_mask | GFP_TRANSHUGE(_LIGHT) for THP allocation, it means
> > that it breaks the purpose of the GFP_TRANSHUGE(_LIGHT).
> >
> > This patch fixes this situation by clearing __GFP_RECLAIM in provided
> > gfp_mask. Note that there are some other THP allocations for migration
> > and they just uses GFP_TRANSHUGE(_LIGHT) directly. This patch would mak=
e
> > all THP allocation for migration consistent.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > ---
> >  mm/migrate.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 02b31fe..ecd7615 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1547,6 +1547,11 @@ struct page *new_page_nodemask(struct page *page=
,
> >       }
> >
> >       if (PageTransHuge(page)) {
> > +             /*
> > +              * clear __GFP_RECALIM since GFP_TRANSHUGE is the gfp_mas=
k
> > +              * that chooses the reclaim masks deliberately.
> > +              */
> > +             gfp_mask &=3D ~__GFP_RECLAIM;
> >               gfp_mask |=3D GFP_TRANSHUGE;
>
> In addition to what Michal said...
>
> The mask is not passed to this function, so I would just redefine it, as =
is done
> in the hugetlb case. We probably don't even need the __GFP_RETRY_MAYFAIL =
for the
> THP case asi it's just there to prevent OOM kill (per commit 0f55685627d6=
d ) and
> the costly order of THP is enough for that.

As I said in another reply, provided __GFP_THISNODE should be handled
so just redefining it would not work.

Thanks.
