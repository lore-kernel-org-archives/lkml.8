Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B406C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5C7206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="przNSppQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389318AbgF2Uke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731700AbgF2TOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:10 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159D5C08EB24
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:27:56 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o38so12036085qtf.6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gw+tVMm108dlvFYjlgwkpaUNmll9hAXTiZNH1A33xQ0=;
        b=przNSppQECjARpTbHjJkQFKIlyZSg/yLk36HoqgLJfT6zaLv3Fsbt5tP8s6ae02+PB
         F4UPSvnIvJBNZOI2ib2Mdt2lK1E6HP2S+EkxJvGY3WHPL2Zg+/vVF884MUFyPQFfc7uI
         uSS5jWgEU7jmgZRvPvZPTlTFcCX11DE1oO+hb241K++4iccR7XtkUn2QCDqFdOzF/KAN
         NGCvNOIgKuFar6XPwvDKGq23IUPMDgZb2b3xDMhiFsHrrnogC5tbjTN58h1+LSUZXmaX
         M37IyMUORC+oewtY1OwU/rdIbcPBRQ5Cx2BJPCfWWEH8LbSmlGCfdIIhdhJgKJ1VyoB3
         +Scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gw+tVMm108dlvFYjlgwkpaUNmll9hAXTiZNH1A33xQ0=;
        b=GrXwUPuI/SA4pA2nCWyrYsjONZVGBM4EcMYs9akizQ+5C0fr1QTjnfQIYYKzwp0ZMG
         fXVitTMaJ1JLwmhvt0tIO6Rt/EuzewtTg7fdi8aD+rldaFVjeAEoajqA3Ld2xf4SR53h
         9UR0o/utyILZ+/jYp04kpY1mTblx2dUbcF0eb/dimc4QQ9ZIpkDWyB5uZSvWUA9Mpo9S
         MB4JPyq6li0pRjmlx55QCGIJsbfrGU8JXglDgLXE0ORazZBmtncmK0lRI/LUjk0v7ds+
         QbVDF1Mg5czbooj1Ry8V2NKbjiEO3vLmfsVNo/J8vw0OH9S76rExPifFwxSzC/dRDHgO
         vF4w==
X-Gm-Message-State: AOAM533EkwzuyXA8QrmunH2rTaSO49I4SH42hIKxI5ZKrVq3neg8085u
        tyCzd0m4NRl7wuLhgmoa+eHv1W9qESMsaZaHB6U=
X-Google-Smtp-Source: ABdhPJyVlrDmlqf0W/7e/BtgRL4HPLYLuwxx1jWb4SX2UH0c02g368/AG9vu6e4mYEKkj6K0x4vrVZ/5qPHQsX3LWks=
X-Received: by 2002:ac8:4f49:: with SMTP id i9mr14322889qtw.65.1593412075217;
 Sun, 28 Jun 2020 23:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-5-git-send-email-iamjoonsoo.kim@lge.com> <20200625115422.GE1320@dhcp22.suse.cz>
 <CAAmzW4MHuRhNqVXMntLAc_x4kJgkgQ-pD5GfFxRxJRchrEFr9g@mail.gmail.com> <20200626072324.GT1320@dhcp22.suse.cz>
In-Reply-To: <20200626072324.GT1320@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 29 Jun 2020 15:27:25 +0900
Message-ID: <CAAmzW4NLVwvqtoUb+JJ+WV=7_n800vA+YYC0LyrDS6iQ7wxcdg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] mm/hugetlb: make hugetlb migration callback CMA aware
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

2020=EB=85=84 6=EC=9B=94 26=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 4:23, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Fri 26-06-20 13:49:15, Joonsoo Kim wrote:
> > 2020=EB=85=84 6=EC=9B=94 25=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 8:5=
4, Michal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On Tue 23-06-20 15:13:44, Joonsoo Kim wrote:
> > > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > >
> > > > new_non_cma_page() in gup.c which try to allocate migration target =
page
> > > > requires to allocate the new page that is not on the CMA area.
> > > > new_non_cma_page() implements it by removing __GFP_MOVABLE flag. Th=
is way
> > > > works well for THP page or normal page but not for hugetlb page.
> > >
> > > Could you explain why? I mean why cannot you simply remove __GFP_MOVA=
BLE
> > > flag when calling alloc_huge_page_nodemask and check for it in dequeu=
e
> > > path?
> >
> > If we remove __GFP_MOVABLE when calling alloc_huge_page_nodemask, we ca=
nnot
> > use the page in ZONE_MOVABLE on dequeing.
> >
> > __GFP_MOVABLE is not only used for CMA selector but also used for zone
> > selector.  If we clear it, we cannot use the page in the ZONE_MOVABLE
> > even if it's not CMA pages.  For THP page or normal page allocation,
> > there is no way to avoid this weakness without introducing another
> > flag or argument. For me, introducing another flag or argument for
> > these functions looks over-engineering so I don't change them and
> > leave them as they are (removing __GFP_MOVABLE).
> >
> > But, for alloc_huge_page_nodemask(), introducing a new argument
> > doesn't seem to be a problem since it is not a general function but
> > just a migration target allocation function.
>
> I really do not see why hugetlb and only the dequeing part should be
> special. This just leads to a confusion. From the code point of view it
> makes perfect sense to opt out CMA regions for !__GFP_MOVABLE when
> dequeing. So I would rather see a consistent behavior than a special
> case deep in the hugetlb allocator layer.

It seems that there is a misunderstanding. It's possible to opt out CMA reg=
ions
for !__GFP_MOVABLE when dequeing. It's reasonable. But, for !__GFP_MOVABLE,
we don't search the hugetlb page on the ZONE_MOVABLE when dequeing since
dequeing zone is limited by gfp_zone(gfp_mask). Solution that Introduces a =
new
argument doesn't cause this problem while avoiding CMA regions.

Thanks.
