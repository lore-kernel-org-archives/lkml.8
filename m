Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90B8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27B520759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOzXbiGv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbgF3HWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730636AbgF3HWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:22:38 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35BBC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:22:38 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id t7so8821049qvl.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YUb/R43ZMssEKSKqN14RVEh1G5REfGOWpdb3ieNJiMU=;
        b=gOzXbiGvAcHgG9UYZFrhTZx/xxwMREB2h3FyW1s/GNRjauXXFRFeFNLlTtWgyE/HD/
         WUwvGJNvfNCTaaFWaE80gjxJHWiVtb+YHBMXzGLOGqksNvnn2anA2KTlrIC8NIxZjP2n
         SwxdCptGcM2slAMWCToErm1+bwmY3oVeR3wdEm3qyzpPjclyz4YGrpAimMqP216l9oZL
         RJ3dpYvE+wW0Pfnp2xZvnWicRbgDzD4Z3QwqJQmgBrIpRfC4GwldbQTFKlirLW6DvSPl
         QLfyNEnRwcTnChkQXbA7T2gfm9pykH5yG7hn2BRoKB6DDvTj7avCwnP6b38gJTjYXsiL
         Vmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YUb/R43ZMssEKSKqN14RVEh1G5REfGOWpdb3ieNJiMU=;
        b=H3a3wkRbLUWWvLfwoYXKfQPtSSeqWx15ozj7DeaNZXmvySRYaOxdA4cHguhhGXh+8j
         DmKrcvdHZRZQf23pKAeSOF1jAwj6dFvD4pF21QzhgTP/jABH0IFCSiCBQhTSxi+q8XL3
         Hu6fXJL7oOtzbzOYLmGWxVqq/VgQB8eX+JZeZUUf3cPKV6xlN654gMG0FOnQrVtdXYrv
         4kxUFuj8Js1fcyc7j4WmXU452DYNk+z57PZcsb2r+cAHuocRDMIp3jNkSel0ICq11llb
         JYgnx6+SIjA6AA6L5X/Ar0FY88nc5JVoN4V6mn+BXQjeOUmHMlyq3mQpYOXSP58KOHXz
         /EGw==
X-Gm-Message-State: AOAM531XuqvgxmxDhVnx+IYFZOxTl2Isqs+//KLDmquzMyBaKGj6VB6b
        fdX1oXQo3tGSB3fg0LEBuiRfLaK0Gkjyit6yCmw=
X-Google-Smtp-Source: ABdhPJw7Sh9pRpAxYP0KNguzmQTPOcCN248K7MQK4XOtXpVblcIPHBVLtKkKxLX6tZdJDGjgDgQXRql9vENUrZdA88g=
X-Received: by 2002:a0c:84c2:: with SMTP id m60mr18687200qva.198.1593501757040;
 Tue, 30 Jun 2020 00:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-5-git-send-email-iamjoonsoo.kim@lge.com> <20200625115422.GE1320@dhcp22.suse.cz>
 <CAAmzW4MHuRhNqVXMntLAc_x4kJgkgQ-pD5GfFxRxJRchrEFr9g@mail.gmail.com>
 <20200626072324.GT1320@dhcp22.suse.cz> <CAAmzW4NLVwvqtoUb+JJ+WV=7_n800vA+YYC0LyrDS6iQ7wxcdg@mail.gmail.com>
 <20200629075510.GA32461@dhcp22.suse.cz> <CAAmzW4PFEEs0FGe+XMHzRdXr0LpdF3TZZG2L3E+opRyZWDZ48A@mail.gmail.com>
 <20200630064256.GB2369@dhcp22.suse.cz>
In-Reply-To: <20200630064256.GB2369@dhcp22.suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Tue, 30 Jun 2020 16:22:22 +0900
Message-ID: <CAAmzW4MFw_Xd_3rV8OVL_8jXfhUWT2v69xEFHaVLY4NKZPhD1A@mail.gmail.com>
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

2020=EB=85=84 6=EC=9B=94 30=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 3:42, M=
ichal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue 30-06-20 15:30:04, Joonsoo Kim wrote:
> > 2020=EB=85=84 6=EC=9B=94 29=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 4:5=
5, Michal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> [...]
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 57ece74e3aae..c1595b1d36f3 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -1092,10 +1092,14 @@ static struct page *dequeue_huge_page_nodemas=
k(struct hstate *h, gfp_t gfp_mask,
> > >  /* Movability of hugepages depends on migration support. */
> > >  static inline gfp_t htlb_alloc_mask(struct hstate *h)
> > >  {
> > > +       gfp_t gfp;
> > > +
> > >         if (hugepage_movable_supported(h))
> > > -               return GFP_HIGHUSER_MOVABLE;
> > > +               gfp =3D GFP_HIGHUSER_MOVABLE;
> > >         else
> > > -               return GFP_HIGHUSER;
> > > +               gfp =3D GFP_HIGHUSER;
> > > +
> > > +       return current_gfp_context(gfp);
> > >  }
> > >
> > >  static struct page *dequeue_huge_page_vma(struct hstate *h,
> > >
> > > If we even fix this general issue for other allocations and allow a
> > > better CMA exclusion then it would be implemented consistently for
> > > everybody.
> >
> > Yes, I have reviewed the memalloc_nocma_{} APIs and found the better wa=
y
> > for CMA exclusion. I will do it after this patch is finished.
> >
> > > Does this make more sense to you are we still not on the same page wr=
t
> > > to the actual problem?
> >
> > Yes, but we have different opinions about it. As said above, I will mak=
e
> > a patch for better CMA exclusion after this patchset. It will make
> > code consistent.
> > I'd really appreciate it if you wait until then.
>
> As I've said I would _prefer_ simplicity over "correctness" if it is only
> partial and hard to reason about from the userspace experience but this
> is not something I would _insist_ on. If Mike as a maintainer of the
> code is ok with that then I will not stand in the way.

Okay.

> But please note that a missing current_gfp_context inside
> htlb_alloc_mask is a subtle bug. I do not think it matters right now but
> with a growing use of scoped apis this might actually hit some day so I
> believe we want to have it in place.

Okay. I will keep in mind and consider it when fixing CMA exclusion on the
other patchset.

Thanks.
