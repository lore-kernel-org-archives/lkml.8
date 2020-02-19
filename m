Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FEBC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6672C20801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 03:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3IBW1bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBSDoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 22:44:13 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:36370 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgBSDoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 22:44:12 -0500
Received: by mail-pl1-f177.google.com with SMTP id a6so8976769plm.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 19:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8yMk1rmENYxZ4Ak7kdDvWY8wqNcb6ofqoMJvwOVdmAo=;
        b=Q3IBW1bjFwvi4HtS64zNZH7Vt2aIPBvcJXYNnGvmm62rWgxJ36Taj6dctGqf8Wz8h1
         j3ze+JJsU6etxCHyjski5b/JNc0WfoWywTJ6m0s/zMV0MtUpw+DcBJDEA3gyxRe6kVCD
         PBu+DUcP9c3O2IFscEsVK3IOf+w1tk2/NTSEmaxAAia5hnZLoHOOuYivCQRX8uor5ej5
         YylpAn59Mvv4AnHpurfuc5Io3tHVUf4Xl+NoEA4oBhhCV9gT0Our0OEEXvF05DvW79Bg
         11AEsC04tkucDZ+2vHN4w1RlrvZW382oONkuLKTlt9C0fctyNvBq22NU8CUDZCG4k5nY
         b6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8yMk1rmENYxZ4Ak7kdDvWY8wqNcb6ofqoMJvwOVdmAo=;
        b=HC/oxePF/hV9xY42pDqE39iOSHqMdJBenabd9N2cwhSbXx/IX0zjbwv9tl0k3ZfKTA
         YKPP5FJ+HDEvgNYhEoK0Th1+yryjimjCo0mH5sRM64ospD9XfqP6PcMu9kKlqmGRJvBy
         PgRpt3Gx2NUa1gwcKayTEHQ/WzRmCiVhv9XPPargpzqFJY8Y1U0zocqjJZ1vpaul065Q
         MMAce0WSKjyWoL3qFzhnyHwWPILTZHo2Yn9v5KiAQsSd1I8EA2OR/xlDvzo1u4Ndsanz
         JhBu5R4JeZ1+7ucI3bfV+/HcwAFHxSK6OK1K7LYHp4v7M+/ox7543X7z2JcntexdZQqG
         fgrQ==
X-Gm-Message-State: APjAAAWDRKgBorLvaK3xl0XfTvHBorTGgJ15IF/qEJRik+3uXUnLy3bc
        BGn5C5ndDtscSz/YwbcalKiVkw==
X-Google-Smtp-Source: APXvYqywKJqSY/QsUSapcxVOLx/1D3vm3NcKxSmir1lWiX699L2XwwlfE4rTvVAMfeqTPD0Mh3AgKw==
X-Received: by 2002:a17:90a:8547:: with SMTP id a7mr7037628pjw.0.1582083851875;
        Tue, 18 Feb 2020 19:44:11 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id g2sm414891pgn.59.2020.02.18.19.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 19:44:11 -0800 (PST)
Date:   Tue, 18 Feb 2020 19:44:10 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yang Shi <shy828301@gmail.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jeremy Cline <jcline@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [patch 1/2] mm, shmem: add thp fault alloc and fallback stats
In-Reply-To: <CAHbLzkrJ_=8f8STvZ2GPGH6Arup8cKgGqigj4FQXWpmD-C5wNQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2002181942460.155180@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2002172139310.152060@chino.kir.corp.google.com> <alpine.DEB.2.21.2002181828070.108053@chino.kir.corp.google.com> <CAHbLzkrJ_=8f8STvZ2GPGH6Arup8cKgGqigj4FQXWpmD-C5wNQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020, Yang Shi wrote:

> > diff --git a/mm/shmem.c b/mm/shmem.c
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -1502,9 +1502,8 @@ static struct page *shmem_alloc_page(gfp_t gfp,
> >         return page;
> >  }
> >
> > -static struct page *shmem_alloc_and_acct_page(gfp_t gfp,
> > -               struct inode *inode,
> > -               pgoff_t index, bool huge)
> > +static struct page *shmem_alloc_and_acct_page(gfp_t gfp, struct inode *inode,
> > +               pgoff_t index, bool fault, bool huge)
> >  {
> >         struct shmem_inode_info *info = SHMEM_I(inode);
> >         struct page *page;
> > @@ -1518,9 +1517,11 @@ static struct page *shmem_alloc_and_acct_page(gfp_t gfp,
> >         if (!shmem_inode_acct_block(inode, nr))
> >                 goto failed;
> >
> > -       if (huge)
> > +       if (huge) {
> >                 page = shmem_alloc_hugepage(gfp, info, index);
> > -       else
> > +               if (!page && fault)
> > +                       count_vm_event(THP_FAULT_FALLBACK);
> > +       } else
> >                 page = shmem_alloc_page(gfp, info, index);
> >         if (page) {
> >                 __SetPageLocked(page);
> > @@ -1832,11 +1833,10 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> >         }
> >
> >  alloc_huge:
> > -       page = shmem_alloc_and_acct_page(gfp, inode, index, true);
> > +       page = shmem_alloc_and_acct_page(gfp, inode, index, vmf, true);
> >         if (IS_ERR(page)) {
> >  alloc_nohuge:
> > -               page = shmem_alloc_and_acct_page(gfp, inode,
> > -                                                index, false);
> > +               page = shmem_alloc_and_acct_page(gfp, inode, index, vmf, false);
> >         }
> >         if (IS_ERR(page)) {
> >                 int retry = 5;
> > @@ -1871,8 +1871,11 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> >
> >         error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
> >                                             PageTransHuge(page));
> > -       if (error)
> > +       if (error) {
> > +               if (vmf && PageTransHuge(page))
> > +                       count_vm_event(THP_FAULT_FALLBACK);
> >                 goto unacct;
> > +       }
> >         error = shmem_add_to_page_cache(page, mapping, hindex,
> >                                         NULL, gfp & GFP_RECLAIM_MASK);
> >         if (error) {
> > @@ -1883,6 +1886,8 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> >         mem_cgroup_commit_charge(page, memcg, false,
> >                                  PageTransHuge(page));
> >         lru_cache_add_anon(page);
> > +       if (vmf && PageTransHuge(page))
> > +               count_vm_event(THP_FAULT_ALLOC);
> 
> I think shmem THP alloc is accounted to THP_FILE_ALLOC. And it has
> been accounted by shmem_add_to_page_cache(). So, it sounds like a
> double count.
> 

I think we can choose to either include file allocations into both 
thp_fault_alloc and thp_fault_fallback or we can exclude them from both of 
them.  I don't think we can account for only one of them.

> >
> >         spin_lock_irq(&info->lock);
> >         info->alloced += compound_nr(page);
> >
> 
