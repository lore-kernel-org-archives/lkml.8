Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA59C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C6B24676
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkrENFfz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgBSRBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:01:44 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38300 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgBSRBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:01:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id p23so29976081edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PjDqYM5WgCtLmWgEiNTMLE2lKEuKKGiGdDMhNeMpRhE=;
        b=mkrENFfzu+iyPIEOlJwHVA2dipdVpLEX9dIILKnnFzTQ+WWaIgIWHR7DzSxgL+TRU2
         XiePxFR9+Ur8T6Ccs7iCnLrr7cmEBuKZ4RJOv8BinUtqpciLSCTLIs3LkHzPNz1uE8qg
         2NDL+QvKyqe/jTwqgAECeBRRkYeIPYpjV/gX0CSIp3Q/A4vGP5Hn7qWwmTVSlRbpTDCq
         Uh89Vy72HydVIMz2wAUzw9TXetRYL3cc8a4/kPccho4vldpnZu1m2PLGpwzRU44jxv4O
         jy2JbCjs394Nk/pVo3pN7WgB8HC5OC2wyGA4f39ySyTo0wZ9+ohalJn12RvBmldaS8l6
         Qqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PjDqYM5WgCtLmWgEiNTMLE2lKEuKKGiGdDMhNeMpRhE=;
        b=m1/9Sy2AN7BnVNFpWP9Gx5OxnXb8WcyTm4C8Dm062huCTJrTkFigwVExJPWEyvZE8g
         NOojIgY+OIrCwaNkA2nAY71TkV0EOC70/uNH2w7E6IaC1z+XE4bSxfu3p1Vwj6HJnj8+
         Lqw1R0EmqRZkPa3iYLOiQLNTgcaMZcP5r/dN0vXd1SLRg7MUTYspi08kuMxyfLvVXjF4
         SB7dKXktYrbxAXnQk6xfIdF/2m6gfw7EZ6VZdk5ZEew25On+4pQdAxVfqS32DtJhT5zV
         1JrpHC3WIGhoTg//ZCsSC4jvFWJba3T6cBgEyJ2XF47LC5bicoFGjkUrR5fStGQIsigi
         YOzw==
X-Gm-Message-State: APjAAAXU37VSeTImBRDxScNjwJf6as1xOuwngNoI60aeb8hTMpGod/x7
        7bwoiRbxmWNAOAtlVHPtvIIg89NZna+Co6kmM57hw+MrL9U=
X-Google-Smtp-Source: APXvYqx0uS9pXsx1qNwx4zusRcDSVbfDuUNqQtoiMFHg8v3FhP1ktVsFXdm6iCq5gvhRYOn1fEOVTrBxLFKYOadOfC0=
X-Received: by 2002:a05:6402:17aa:: with SMTP id j10mr23067482edy.256.1582131701248;
 Wed, 19 Feb 2020 09:01:41 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2002172139310.152060@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2002181828070.108053@chino.kir.corp.google.com>
 <CAHbLzkrJ_=8f8STvZ2GPGH6Arup8cKgGqigj4FQXWpmD-C5wNQ@mail.gmail.com> <alpine.DEB.2.21.2002181942460.155180@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.2002181942460.155180@chino.kir.corp.google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 19 Feb 2020 09:01:23 -0800
Message-ID: <CAHbLzkq20hzLdYM-EMOfWRqPOr+OQF8uq5yWR=Yb6vQY51LKwg@mail.gmail.com>
Subject: Re: [patch 1/2] mm, shmem: add thp fault alloc and fallback stats
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jeremy Cline <jcline@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 7:44 PM David Rientjes <rientjes@google.com> wrote:
>
> On Tue, 18 Feb 2020, Yang Shi wrote:
>
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -1502,9 +1502,8 @@ static struct page *shmem_alloc_page(gfp_t gfp,
> > >         return page;
> > >  }
> > >
> > > -static struct page *shmem_alloc_and_acct_page(gfp_t gfp,
> > > -               struct inode *inode,
> > > -               pgoff_t index, bool huge)
> > > +static struct page *shmem_alloc_and_acct_page(gfp_t gfp, struct inode *inode,
> > > +               pgoff_t index, bool fault, bool huge)
> > >  {
> > >         struct shmem_inode_info *info = SHMEM_I(inode);
> > >         struct page *page;
> > > @@ -1518,9 +1517,11 @@ static struct page *shmem_alloc_and_acct_page(gfp_t gfp,
> > >         if (!shmem_inode_acct_block(inode, nr))
> > >                 goto failed;
> > >
> > > -       if (huge)
> > > +       if (huge) {
> > >                 page = shmem_alloc_hugepage(gfp, info, index);
> > > -       else
> > > +               if (!page && fault)
> > > +                       count_vm_event(THP_FAULT_FALLBACK);
> > > +       } else
> > >                 page = shmem_alloc_page(gfp, info, index);
> > >         if (page) {
> > >                 __SetPageLocked(page);
> > > @@ -1832,11 +1833,10 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> > >         }
> > >
> > >  alloc_huge:
> > > -       page = shmem_alloc_and_acct_page(gfp, inode, index, true);
> > > +       page = shmem_alloc_and_acct_page(gfp, inode, index, vmf, true);
> > >         if (IS_ERR(page)) {
> > >  alloc_nohuge:
> > > -               page = shmem_alloc_and_acct_page(gfp, inode,
> > > -                                                index, false);
> > > +               page = shmem_alloc_and_acct_page(gfp, inode, index, vmf, false);
> > >         }
> > >         if (IS_ERR(page)) {
> > >                 int retry = 5;
> > > @@ -1871,8 +1871,11 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> > >
> > >         error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
> > >                                             PageTransHuge(page));
> > > -       if (error)
> > > +       if (error) {
> > > +               if (vmf && PageTransHuge(page))
> > > +                       count_vm_event(THP_FAULT_FALLBACK);
> > >                 goto unacct;
> > > +       }
> > >         error = shmem_add_to_page_cache(page, mapping, hindex,
> > >                                         NULL, gfp & GFP_RECLAIM_MASK);
> > >         if (error) {
> > > @@ -1883,6 +1886,8 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> > >         mem_cgroup_commit_charge(page, memcg, false,
> > >                                  PageTransHuge(page));
> > >         lru_cache_add_anon(page);
> > > +       if (vmf && PageTransHuge(page))
> > > +               count_vm_event(THP_FAULT_ALLOC);
> >
> > I think shmem THP alloc is accounted to THP_FILE_ALLOC. And it has
> > been accounted by shmem_add_to_page_cache(). So, it sounds like a
> > double count.
> >
>
> I think we can choose to either include file allocations into both
> thp_fault_alloc and thp_fault_fallback or we can exclude them from both of
> them.  I don't think we can account for only one of them.

How's about the 3rd option, adding THP_FILE_FALLBACK.

According to the past discussion with Hugh and Kirill, basically
shmem/file THP is treated differently and separately from anonymous
THP, and they have separate enabling knobs
(/sys/kernel/mm/transparent_hugepage/enabled just enables anonymous
THP). Since we already have THP_FILE_ALLOC for shmem THP allocation,
IMHO it makes more sense to have dedicated FALLBACK counter. And, this
won't change the old behavior either.

>
> > >
> > >         spin_lock_irq(&info->lock);
> > >         info->alloced += compound_nr(page);
> > >
> >
