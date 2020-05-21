Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F42C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F29207C4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/Jk5vrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgEUBXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 21:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgEUBXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 21:23:06 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1727C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:23:05 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id v15so2359487qvr.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GMtVJCbEkgZEzF1ZBLwMVt1cXESOIC8nVZA92hfRjqg=;
        b=r/Jk5vrcSB3KOhVo3r3+GMSVZKwb4XxUm7Va/OGQ74reFpHxmw0Gaclxys3Ptme1uP
         UvxVu0JcGhJUPGmpbaLHLWLw9vNHFKZI6/qpCDfmM6LN/95XtsMdOTbm/dq9Hnfm7s0o
         MGmF1+Izrxltv0meQR5wJgbfzBsNsKiYaSwF8HjsMZAr/ZnCFXEsAfAWRAjlKMS+ma3k
         H3GtqGWxbe1E8U/+ZvXM2TRyP1kAf5PrKnVwEscnJLob7sIhoMt13rjzo7//vxAlETkf
         fegfNHIrt1dR9WkPCItxFWGBhl0ZEpJG/dwLjtpO6fsjuNJVh3YRhVcpz9kkFwMWHWdQ
         3dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GMtVJCbEkgZEzF1ZBLwMVt1cXESOIC8nVZA92hfRjqg=;
        b=OeXiSd9wOhNMOrMkHS/3YIpAeGUHUcDrQoZPx2up7HJkIwxrZSApXoqxpMigcyYLDb
         oWSVuMkmE66rNXN0C6VGo9ciPZldbSEN4wwAqr8iopbXXd6W+qGefXXsFtm3inEczNrB
         hYtjVwv5hu+1jf8vSMQ3kjCPGD0VWuc54KV3Zkd6NLBExJ/A/RHwIsdt83oOCFohJs5K
         ccX0h2xhfW/hl5gMcwmAn+A6VNNP8ZxsPrs43Uq9cdgfZKhItpFHSsm9ZUzltJLW6bWW
         1pIhseWIEYURhB9qvG0WUHS9X/7m0XuiwxHVUSp4YYoEJARxq4i9G0bVtoQYiPJVn1RO
         KFyQ==
X-Gm-Message-State: AOAM533hGZFt1FnvawntW1G1yuiX+A5TjrogC92ahXL6YCvsK8mGAVzD
        q9NAEkT6eStAWSAyqXFbpFotuviLtHlhV5cGLtI=
X-Google-Smtp-Source: ABdhPJzbHRVGo23tLtEGTMcZdTYgdnp2ZMXPEnEBO/hnKIpKb0mugizf+vf4GkyhoMbTLVzY0h1wGGzK9l7+TlRzSj0=
X-Received: by 2002:a0c:f3ca:: with SMTP id f10mr8036835qvm.66.1590024184723;
 Wed, 20 May 2020 18:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1589764857-6800-5-git-send-email-iamjoonsoo.kim@lge.com> <20200521004608.GC317575@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200521004608.GC317575@carbon.dhcp.thefacebook.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 21 May 2020 10:22:51 +0900
Message-ID: <CAAmzW4NmZ4L1DePauuFthmwH9-4AkviGOSbwRD46VMpJzJqU2g@mail.gmail.com>
Subject: Re: [PATCH 04/11] mm/hugetlb: unify hugetlb migration callback function
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
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

2020=EB=85=84 5=EC=9B=94 21=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 9:46, R=
oman Gushchin <guro@fb.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, May 18, 2020 at 10:20:50AM +0900, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > There is no difference between two migration callback functions,
> > alloc_huge_page_node() and alloc_huge_page_nodemask(), except
> > __GFP_THISNODE handling. This patch adds one more field on to
> > the alloc_control and handles this exception.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > ---
> >  include/linux/hugetlb.h |  8 --------
> >  mm/hugetlb.c            | 23 ++---------------------
> >  mm/internal.h           |  1 +
> >  mm/mempolicy.c          |  3 ++-
> >  4 files changed, 5 insertions(+), 30 deletions(-)
> >
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 6da217e..4892ed3 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -505,8 +505,6 @@ struct huge_bootmem_page {
> >
> >  struct page *alloc_migrate_huge_page(struct hstate *h,
> >                               struct alloc_control *ac);
> > -struct page *alloc_huge_page_node(struct hstate *h,
> > -                             struct alloc_control *ac);
> >  struct page *alloc_huge_page_nodemask(struct hstate *h,
> >                               struct alloc_control *ac);
>
> Maybe drop _nodemask suffix in the remaining function?

We cannot remove the suffix since there is already the same named function,
alloc_huge_page().

> >  struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_stru=
ct *vma,
> > @@ -755,12 +753,6 @@ static inline void huge_ptep_modify_prot_commit(st=
ruct vm_area_struct *vma,
> >  struct hstate {};
> >
> >  static inline struct page *
> > -alloc_huge_page_node(struct hstate *h, struct alloc_control *ac)
> > -{
> > -     return NULL;
> > -}
> > -
> > -static inline struct page *
> >  alloc_huge_page_nodemask(struct hstate *h, struct alloc_control *ac)
> >  {
> >       return NULL;
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 859dba4..60b0983 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1981,31 +1981,12 @@ struct page *alloc_buddy_huge_page_with_mpol(st=
ruct hstate *h,
> >  }
> >
> >  /* page migration callback function */
> > -struct page *alloc_huge_page_node(struct hstate *h,
> > -                             struct alloc_control *ac)
> > -{
> > -     struct page *page =3D NULL;
> > -
> > -     ac->gfp_mask |=3D htlb_alloc_mask(h);
> > -     if (ac->nid !=3D NUMA_NO_NODE)
> > -             ac->gfp_mask |=3D __GFP_THISNODE;
> > -
> > -     spin_lock(&hugetlb_lock);
> > -     if (h->free_huge_pages - h->resv_huge_pages > 0)
> > -             page =3D dequeue_huge_page_nodemask(h, ac);
> > -     spin_unlock(&hugetlb_lock);
> > -
> > -     if (!page)
> > -             page =3D alloc_migrate_huge_page(h, ac);
> > -
> > -     return page;
> > -}
> > -
> > -/* page migration callback function */
> >  struct page *alloc_huge_page_nodemask(struct hstate *h,
> >                               struct alloc_control *ac)
> >  {
> >       ac->gfp_mask |=3D htlb_alloc_mask(h);
> > +     if (ac->thisnode && ac->nid !=3D NUMA_NO_NODE)
> > +             ac->gfp_mask |=3D __GFP_THISNODE;
> >
> >       spin_lock(&hugetlb_lock);
> >       if (h->free_huge_pages - h->resv_huge_pages > 0) {
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 75b3f8e..574722d0 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -618,6 +618,7 @@ struct alloc_control {
> >       int nid;
> >       nodemask_t *nmask;
> >       gfp_t gfp_mask;
> > +     bool thisnode;
> >  };
>
> Can you, please, add some comments what each field exactly mean?

Will do.

Thanks.
