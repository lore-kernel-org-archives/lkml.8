Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4F7C11D07
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECC6206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 13:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="crFreDBE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgBTNLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 08:11:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33210 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbgBTNLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 08:11:36 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so4200392lji.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 05:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=95x/svoIHvKtwThYjiFAhoANuT+9jaK/n8hE5y8HQuM=;
        b=crFreDBEqFDDkMhb8t3wiTSXcSXwcMBXrtLRBgy/EB6JgvFI6XWm7x1/wOie4gsbXL
         QQ3QUTJ54ZQaY7DLyG0eMDhKW78NMtF0EpKV24KUqJAkpHjg8Unrzjo+h6ky+AFW6w2A
         2cswn+BY3t7POXQu0hky4IgR2elmaN4migYzFs2WLjXV9imgcdbO5zf+rJEPXHq/b80S
         DxB/WY+cbZK3AP5wy95Bxtl1lU+u53iV1tcCYhIPUmcdswhSOkvoqCu1k+2OFctN8IlA
         oEYCzCmBsQCOym4VAMEm/FRo6zwAdtAGRmD61x+6BtVfCPZSk0yBaTr+Ih8D5DGdQUfE
         u75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=95x/svoIHvKtwThYjiFAhoANuT+9jaK/n8hE5y8HQuM=;
        b=RksYfE/P1d7LDwWDHul6Q68I5FH6qis1jYA5z8wdJd/SEQh7OyWwtk512fDNTnMqUX
         1Ot202+Xt4odeZ9XliGQGlGRPIgu+B8tREwZRdbRXh+WqymqdH4d1LuZDq6g5azmIJ0D
         tOgX09GGwkxIxRk9fbJibgaQgPpmvf3cuy6NLs80iedOvPj/4iEPr0fZOUZ6PChJowTX
         GFDh+NEG9QWbUggDidM+R+xAQt/KeNQOHDKSG5gmrimNKV1Ee2pqsnu0FDMLrUNdYbOc
         qqOKf+R95UdVqvQ+Obfj6RlJAVqL4hf6MWDebM3OsSdNRavFatKPiB25P5uR3ulXEMTC
         tJCw==
X-Gm-Message-State: APjAAAVRjmp4YNuuziHfsLtRMzGAoFC2nPH7Ba9sPEv+NmP1cgKrhJiA
        HG7/NfdiMkVk97DLejFWzEiPdA==
X-Google-Smtp-Source: APXvYqwHcoB79WTtbZlwQ7P2hFgI1BkSfCjBHhn1dayq2xGKeB0Z18obfHCYvUiqt8PFH2LvliAXjw==
X-Received: by 2002:a2e:8e84:: with SMTP id z4mr18170854ljk.207.1582204293381;
        Thu, 20 Feb 2020 05:11:33 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n13sm1784076lji.91.2020.02.20.05.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 05:11:32 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0B508100FBB; Thu, 20 Feb 2020 16:12:02 +0300 (+03)
Date:   Thu, 20 Feb 2020 16:12:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jeremy Cline <jcline@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [patch 1/2] mm, shmem: add thp fault alloc and fallback stats
Message-ID: <20200220131202.i77zt3zj53mimrnu@box>
References: <alpine.DEB.2.21.2002172139310.152060@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2002181828070.108053@chino.kir.corp.google.com>
 <CAHbLzkrJ_=8f8STvZ2GPGH6Arup8cKgGqigj4FQXWpmD-C5wNQ@mail.gmail.com>
 <alpine.DEB.2.21.2002181942460.155180@chino.kir.corp.google.com>
 <CAHbLzkq20hzLdYM-EMOfWRqPOr+OQF8uq5yWR=Yb6vQY51LKwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkq20hzLdYM-EMOfWRqPOr+OQF8uq5yWR=Yb6vQY51LKwg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 09:01:23AM -0800, Yang Shi wrote:
> On Tue, Feb 18, 2020 at 7:44 PM David Rientjes <rientjes@google.com> wrote:
> >
> > On Tue, 18 Feb 2020, Yang Shi wrote:
> >
> > > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > > --- a/mm/shmem.c
> > > > +++ b/mm/shmem.c
> > > > @@ -1502,9 +1502,8 @@ static struct page *shmem_alloc_page(gfp_t gfp,
> > > >         return page;
> > > >  }
> > > >
> > > > -static struct page *shmem_alloc_and_acct_page(gfp_t gfp,
> > > > -               struct inode *inode,
> > > > -               pgoff_t index, bool huge)
> > > > +static struct page *shmem_alloc_and_acct_page(gfp_t gfp, struct inode *inode,
> > > > +               pgoff_t index, bool fault, bool huge)
> > > >  {
> > > >         struct shmem_inode_info *info = SHMEM_I(inode);
> > > >         struct page *page;
> > > > @@ -1518,9 +1517,11 @@ static struct page *shmem_alloc_and_acct_page(gfp_t gfp,
> > > >         if (!shmem_inode_acct_block(inode, nr))
> > > >                 goto failed;
> > > >
> > > > -       if (huge)
> > > > +       if (huge) {
> > > >                 page = shmem_alloc_hugepage(gfp, info, index);
> > > > -       else
> > > > +               if (!page && fault)
> > > > +                       count_vm_event(THP_FAULT_FALLBACK);
> > > > +       } else
> > > >                 page = shmem_alloc_page(gfp, info, index);
> > > >         if (page) {
> > > >                 __SetPageLocked(page);
> > > > @@ -1832,11 +1833,10 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> > > >         }
> > > >
> > > >  alloc_huge:
> > > > -       page = shmem_alloc_and_acct_page(gfp, inode, index, true);
> > > > +       page = shmem_alloc_and_acct_page(gfp, inode, index, vmf, true);
> > > >         if (IS_ERR(page)) {
> > > >  alloc_nohuge:
> > > > -               page = shmem_alloc_and_acct_page(gfp, inode,
> > > > -                                                index, false);
> > > > +               page = shmem_alloc_and_acct_page(gfp, inode, index, vmf, false);
> > > >         }
> > > >         if (IS_ERR(page)) {
> > > >                 int retry = 5;
> > > > @@ -1871,8 +1871,11 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> > > >
> > > >         error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
> > > >                                             PageTransHuge(page));
> > > > -       if (error)
> > > > +       if (error) {
> > > > +               if (vmf && PageTransHuge(page))
> > > > +                       count_vm_event(THP_FAULT_FALLBACK);
> > > >                 goto unacct;
> > > > +       }
> > > >         error = shmem_add_to_page_cache(page, mapping, hindex,
> > > >                                         NULL, gfp & GFP_RECLAIM_MASK);
> > > >         if (error) {
> > > > @@ -1883,6 +1886,8 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> > > >         mem_cgroup_commit_charge(page, memcg, false,
> > > >                                  PageTransHuge(page));
> > > >         lru_cache_add_anon(page);
> > > > +       if (vmf && PageTransHuge(page))
> > > > +               count_vm_event(THP_FAULT_ALLOC);
> > >
> > > I think shmem THP alloc is accounted to THP_FILE_ALLOC. And it has
> > > been accounted by shmem_add_to_page_cache(). So, it sounds like a
> > > double count.
> > >
> >
> > I think we can choose to either include file allocations into both
> > thp_fault_alloc and thp_fault_fallback or we can exclude them from both of
> > them.  I don't think we can account for only one of them.
> 
> How's about the 3rd option, adding THP_FILE_FALLBACK.

I like this option.

Problem with THP_FAULT_* is that shmem_getpage_gfp() is called not only
from fault path, but also from syscalls.

-- 
 Kirill A. Shutemov
