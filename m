Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EE9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB2520759
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcX2eEh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgEVFw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 01:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgEVFw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 01:52:57 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015ACC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 22:52:56 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o19so7450929qtr.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 22:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jUEtbJTo/s1k1xKnZ5zayiAt68J7p5qR5HPp3/wYSZA=;
        b=VcX2eEh3SL5ffZNERfkyISXQ6MCd1g4T5WttpHghQyjoqXCunYEOHKWTiXuFxFDDO+
         RiyHOeC/1rtKcSzk4eVY29tK1CgXvKazKQ450DPV5+o9/HkAuPJZ5MiEvXyLKCMmJdrH
         b9tn+kmTLU/2NoHoYdTwkyOWs0+9qfnhPAxRin1piESzDojseiK8XMIWVZS9UrWEf/Zo
         dNODe+ctDtyH3T8qAc9ke1Dpw2hKQlqy9cMS3RRk32Wi5FdpyrDmPeU2t2e5rGgkhZE8
         rXzchMgLsOGGNMmpryaXQbNXXzPMd1YKngF9rxrGEcNl/+2nJHVnaMB0FTJ7WzuLDMQe
         8Y3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jUEtbJTo/s1k1xKnZ5zayiAt68J7p5qR5HPp3/wYSZA=;
        b=kkXYqZ0m4gVQM1x9OtLbAOvaEJAfhceX8AaVG2jbkIGBs7XCXMbfHG+8oGNZIdE/EM
         AnaIDD0Hs2SbBJWW3yyXa+C98q5JElNaD7hO5T5o551fsJEDlRsf5+ZX4GG5hat7lReF
         9ozX355kHuz/MQWy9memrLyfuuiovrfqe72nwNAKtb0PfDFWwJbI1uT0RrX8ZELzw8fi
         WvUcrtB7tcTD5ZICUuXdD3aOCG1s7+1AUI51VHGR0LHG/jGpvnf8dGqTP4KHT24mRbZY
         BsfDZn7Ci8pWEFzdyWEG8cVXvdYT4XYbWdNWktgM1/odJbnBF10H5Xc7Upbl1EbDTlsS
         /wPA==
X-Gm-Message-State: AOAM531EJ+PMaLauACO0rij340maP/gMje1OdgNOfhn3YGyo759Dn/5+
        Cr9y1EZaZkEsJ9AINZMHIWMuvlNAJ9dfI9FF2BMHjP2o
X-Google-Smtp-Source: ABdhPJx1e8fFPtfihkdBuMz8sSFzb5vEt3BGO8+bUlwtEUnB32VqfYrjCACaarEDs5fdv997BUKImmDVBsolkJPtSdU=
X-Received: by 2002:ac8:6c6:: with SMTP id j6mr14085108qth.194.1590126775932;
 Thu, 21 May 2020 22:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1589764857-6800-4-git-send-email-iamjoonsoo.kim@lge.com> <3499673c-d103-bb69-5f38-8cce8e659a85@oracle.com>
In-Reply-To: <3499673c-d103-bb69-5f38-8cce8e659a85@oracle.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 22 May 2020 14:52:45 +0900
Message-ID: <CAAmzW4N7f5WbcJbhEdPq2W+6xOpdMR_5jDRU_3UmZK_VOBvZnw@mail.gmail.com>
Subject: Re: [PATCH 03/11] mm/hugetlb: introduce alloc_control structure to
 simplify migration target allocation APIs
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 5=EC=9B=94 22=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 3:57, M=
ike Kravetz <mike.kravetz@oracle.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 5/17/20 6:20 PM, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > Currently, page allocation functions for migration requires some argume=
nts.
> > More worse, in the following patch, more argument will be needed to uni=
fy
> > the similar functions. To simplify them, in this patch, unified data
> > structure that controls allocation behaviour is introduced.
>
> As a followup to Roman's question and your answer about adding a suffix/p=
refix
> to the new structure.  It 'may' be a bit confusing as alloc_context is al=
ready
> defined and *ac is passsed around for page allocations.  Perhaps, this ne=
w
> structure could somehow have migrate in the name as it is all about alloc=
ating
> migrate targets?

I have considered that but I cannot find appropriate prefix. In hugetlb cod=
e,
struct alloc_control is passed to the internal function which is not
fully dedicated
to the migration so 'migrate' would not be appropriate prefix.

alloc_context is used by page allocation core and alloc_control would be us=
ed by
outside of it so I think that we can endure it. If there is a good
suggestion, I will change
the name happily.

> >
> > For clean-up, function declarations are re-ordered.
> >
> > Note that, gfp_mask handling on alloc_huge_page_(node|nodemask) is
> > slightly changed, from ASSIGN to OR. It's safe since caller of these
> > functions doesn't pass extra gfp_mask except htlb_alloc_mask().
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Patch makes sense.

Thanks!

> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index a298a8c..94d2386 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1526,10 +1526,15 @@ struct page *new_page_nodemask(struct page *pag=
e,
> >       unsigned int order =3D 0;
> >       struct page *new_page =3D NULL;
> >
> > -     if (PageHuge(page))
> > -             return alloc_huge_page_nodemask(
> > -                             page_hstate(compound_head(page)),
> > -                             preferred_nid, nodemask);
> > +     if (PageHuge(page)) {
> > +             struct hstate *h =3D page_hstate(page);
>
> I assume the removal of compound_head(page) was intentional?  Just asking
> because PageHuge will look at head page while page_hstate will not.  So,
> if passed a non-head page things could go bad.

I was thinking that page_hstate() can handle the tail page but it seems tha=
t
it's not. Thanks for correction. I will change it on next version.

Thanks.
