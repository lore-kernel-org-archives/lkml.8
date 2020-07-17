Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E74EC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2E0A2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmAcPyW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgGQHqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgGQHqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:46:50 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AA9C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 00:46:50 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q198so7992648qka.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 00:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p1NZQG4oEUmz0+3wGuzHtIVKKrGOlXRqs3faFoSCavU=;
        b=KmAcPyW22oZTklkSOJdP9sECeg8GNajPulowq4jdUx80ZzgXmYSx7Pgit5PSlF5KGo
         68leyRdN5oEI9gwYP4wAD6wUqSZ1wbIVYc4gkHIQT2vQwT2MYmO1QwDheD+Gs6r7h/cy
         fOezCazJFpNCAZwNI1TlcG5Aj09BZVDBVkwBwkwc7TTjvsplIVjgA9/PDR15fFIbI29I
         N+LKElnxxLOdnFcZajoj7zDDKx0jvtxJ/e51bGTR9WygigcFYg/9Z+OApin3nFME1skS
         /Mc16DeMkYBD0CgLts6+1b7MsvqCcKv5pLhU3WTo0Ki85bs5zr89DkvUrLg1jMKa/Cd4
         ovUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p1NZQG4oEUmz0+3wGuzHtIVKKrGOlXRqs3faFoSCavU=;
        b=ihLB06H975U9s6v4aPrmT6dvGxoVDstHrD4Ymkmn0w8PQqOnC3FkU1RG/Z3PqiF8QO
         AlsYnNRkvgwJufk67iRDtcT2meAVKa+2Xlbp7T8/t1nOnS1V+b71FDcyTAPBrQR0XSw/
         J9L8E7cGtdENC+9iqial6tTilUbacsZUooqcKsI5suCQDFVX/oofipELRJ18Vys6uQfp
         CINU5qZvOsvA3Yc5DKP5sgTCDChhxQow7Suyb9KABksP0rLi1KLXfJ9RZ3cuKQ3gH5/v
         TnNjrY20BQIchbKfCKjLxyZKMr1DCGi3BgI6+JHrMEN3xXd1QX7qwgwd0hA37lpiIP/S
         75wg==
X-Gm-Message-State: AOAM5327Kf9nYDGyeIEtFIdHyuFYEgplwC2DTPyfjLNipKUsb9zFJbnz
        vxnrc+B50CxkgXMMZ2VPiZThhqtAmlQBtB/zsTxrzw==
X-Google-Smtp-Source: ABdhPJzKwZp67n8bEinZ+vfbtHSzjOCHp6TG9fY7EVHJC3NPWwu94kDQSMYoR4vJEAxftZUAsKRRbPxLNr7pKNwW6Bs=
X-Received: by 2002:a05:620a:a1b:: with SMTP id i27mr7768542qka.429.1594972009242;
 Fri, 17 Jul 2020 00:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <1594789529-6206-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594789529-6206-2-git-send-email-iamjoonsoo.kim@lge.com> <20200715082401.GC5451@dhcp22.suse.cz>
In-Reply-To: <20200715082401.GC5451@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 17 Jul 2020 16:46:38 +0900
Message-ID: <CAAmzW4P+KXn2e1pU+_+Y6NqDt1-081hCyKNsqbiwfF=FADLzxQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] mm/gup: restrict CMA region by using allocation scope API
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 7=EC=9B=94 15=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 5:24, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed 15-07-20 14:05:27, Joonsoo Kim wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > We have well defined scope API to exclude CMA region.
> > Use it rather than manipulating gfp_mask manually. With this change,
> > we can now use __GFP_MOVABLE for gfp_mask and the ZONE_MOVABLE is also
> > searched by page allocator. For hugetlb, gfp_mask is redefined since
> > it has a regular allocation mask filter for migration target.
> >
> > Note that this can be considered as a fix for the commit 9a4e9f3b2d73
> > ("mm: update get_user_pages_longterm to migrate pages allocated from
> > CMA region"). However, "Fixes" tag isn't added here since it is just
> > suboptimal but it doesn't cause any problem.
>
> But it is breaking the contract that the longterm pins never end up in a
> cma managed memory. So I think Fixes tag is really due. I am not sure
> about stable backport. If the patch was the trivial move of

Previous implementation is correct since longterm pins never end up in a CM=
A
managed memory with that implementation. It's just a different and suboptim=
al
implementation to exclude the CMA area. This is why I don't add the "Fixes"
tag on the patch.

> memalloc_nocma_restore then it would be probably worth it because it is
> trivial to review and backport. I suspect that longterm pins in CMA
> regions would cause hard to debug issues where CMA memory will not be
> available. But I am not really sure this is a real problem considering
> how many long term pin users we have and I have also no idea whether
> those are usually used along with CMA users.
>
> Anyway I think it would really be much better to isolate the
> memalloc_nocma_restore and have it first in the series. The reword of

Unfortunately, it's not possible to place it first in the series since
memalloc_nocma_XXX API has a bug that could return the CMA area even if
scope is set up. It is fixed on the first patch in this series.

> the __GFP_MOVABLE functionality is orthogonal.

My logic is that, we basically assume that using __GFP_MOVABLE is possible
in migration target allocation. And, it was necessarily cleared in
order to exclude
the CMA area. Now, we use the other method to exclude the CMA area so
__GFP_MOVABLE is added like usual. If you think that it deserves to be
a separate patch, I will do it on the next version.

> Btw __GFP_NOWARN change is not documented.

Will document it.

Thanks.
