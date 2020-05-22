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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3ACC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB8D6207FB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 07:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYSjYVIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgEVHjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 03:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgEVHjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 03:39:08 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32404C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:39:08 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i68so7627208qtb.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aXRJpM2H138zpyDQC3RVrPvAFl58tr+boCaBOv+GSas=;
        b=iYSjYVIxRMRCxIl0eNKt5e6cmbSPMoPhaBitsxSf1t4HoLcAJBw6fjtdnM+zgrN/1T
         hFl81xc4k+M53+PP+DpAgMTI6J7GQ+KWq8DD1o4URrb1BneAjMarPrDPipDE/pGCCT2h
         r52AZvbL1/0CrQSVEZK6QZup6S4Oq+vQA4StLYq6TOZlyoLP9GD1cXU/I4HW1h0n5uaj
         1DWi+IS1AN+n8QogJ7XDp3aiS5lVRkhRoyf//L0urD4e0odbrLs8P65cX81Msd/Nn2Mp
         FBVexCz/sVIbIoiyVhHPM0Wvnb6Md3u9XVx2NMUTM2MOo29R7GFk6nHda+9+s7EG+JcF
         M/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aXRJpM2H138zpyDQC3RVrPvAFl58tr+boCaBOv+GSas=;
        b=GQ8dua0L6/s7o4tGiCSg7ZSMj1v3afNDjhvzwWGCHjXzhyL/bNTObwb7pPpdwUhOG/
         uZKsH2jf0zSEmKWay3DsyM9CBA//2fhbiTD/SV+8/WDNWc+4zJHhPnr7VfigbTLCG3w3
         NeUJgshWh/X4GJVGZ7z+uN4M3cZkhNd2Y8XtL2KBhoE195ikyus+7+aC9k8aJc9Y/LDE
         vTmfH7Sj6ck7lMadFBBMyAg28Tmko2dccFgkndlQdJ96Uuiv0kBdzHzb64DtZeg8jABu
         UpDodLt6VoAX3eP9AWZanBFOZ41BeUwKtC1VbwpzmA/voATe6IoAOzSo5bxiU4YxtOZm
         iuqg==
X-Gm-Message-State: AOAM531TJY93xaeuXflAeKDWOidalzJuw1yOiO5PJflRCB6AKrNHCVXf
        XvlBvL39PG2Uwq6PGcI5tXZIGeTgxMF7islld3k=
X-Google-Smtp-Source: ABdhPJyqJ2PmdM/u87/PaNX6rfs/0pI3q5zWIZgGTc23MdPUkbp+6hXzIOQk+vuFzxNd4HohJ1yXbU/uHPhD1W8Ibjo=
X-Received: by 2002:aed:2252:: with SMTP id o18mr14932634qtc.35.1590133147339;
 Fri, 22 May 2020 00:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1589764857-6800-5-git-send-email-iamjoonsoo.kim@lge.com> <01cdaaea-892a-2b29-edbd-279611f418b0@oracle.com>
In-Reply-To: <01cdaaea-892a-2b29-edbd-279611f418b0@oracle.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 22 May 2020 16:38:59 +0900
Message-ID: <CAAmzW4Nv7H_MTD2NoKF3aOCDhETrdKA_VGPxNF+6zTfYY3aq3A@mail.gmail.com>
Subject: Re: [PATCH 04/11] mm/hugetlb: unify hugetlb migration callback function
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

2020=EB=85=84 5=EC=9B=94 22=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 5:54, M=
ike Kravetz <mike.kravetz@oracle.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 5/17/20 6:20 PM, js1304@gmail.com wrote:
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
>
> I wonder if the new field is necessary?
>
> IIUC, it simply prevents the check for NUMA_NO_NODE and possible setting
> of __GFP_THISNODE in previous alloc_huge_page_nodemask() calling sequence=
s.
> However, it appears that node (preferred_nid) is always set to something
> other than NUMA_NO_NODE in those callers.

Okay. I will check it.

> It obviously makes sense to add the field to guarantee no changes to
> functionality while making the conversions.  However, it it is not really
> necessary then it may cause confusion later.

Agreed.

Thanks.
