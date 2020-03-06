Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDE5C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF2920658
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8MbbuGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgCFRYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:24:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36988 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFRYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:24:16 -0500
Received: by mail-ed1-f65.google.com with SMTP id m9so3406433edl.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 09:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WZVF3WeW7a9wrdSl0zBcs9raA78Uf8UokFbAXMs0MtY=;
        b=g8MbbuGfSPFiXaKugqYxPbsI+w1HDaJneroTSsByaWf9QRcxgtnRqXWjdFLdwGQ+NG
         AMoljN6kLEhM9XqiFZViwOtz4THPxiF+zMkHIoxAKRJ70yI79J0zpc7iNgLOvZoOwLO3
         h8+w9+UBXn5J/ytjOtHGJ8zaLSI38Mv+DEiQiHcWOx4Ew8XHC007awxBQzAEdrX3+kfb
         qH1oumcl+U4aldZHNfmEJHOoNA6KZhtjrJSuutd+9qjRlnNECX7wb0T0h/fnMnjmFEfB
         6usF1E3yTLbc6+Sda0Cq//wYp/ZVg7jMqIWnaejkuO1tNLs5rRONZJ1c1PbpC2sVLA3h
         7EDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WZVF3WeW7a9wrdSl0zBcs9raA78Uf8UokFbAXMs0MtY=;
        b=MwRBZn4F4TAOzQILsAOcm+4hCHUx4yFkbhNMGhf+E7A7gHrdB6boK7+i/8J7RvFB19
         egF7CSwQncEuIpPT+S9qgXPY08/LWhVgdFojLNSYbEUJ1V62v75Rj5isZa+eYf2tpAwb
         suVx2BdfKkLbWYF74sSu+oSvv3I7dAi4wOHNKOqRdSTVkAkYXvuC5Vqngf0eY6dB0W3M
         xiIpoTNtuYsPnag6mtR7V/+DIrOrvFnLhlpcG7gG+5AabSylX8+RErGRG6ypZEDhCe8E
         D/MTCcJjtJrZQfbyHrlloPH/2UqQnBU6Spy6fAQA+Azdc4tzUdiqC2dM6eDZ3es2bl8g
         dP6Q==
X-Gm-Message-State: ANhLgQ3uG6oAiu8PAYtWTgOQ5sCkfhQmB/ykXE39xpZPzvzojaaOQ1fD
        d5kAjQyzG7YkTdkpPmzGFZMZ5fgBEYscKCVn4Yc=
X-Google-Smtp-Source: ADFU+vuoGR+71ZPoCut+EzCCatlJeD6qgkXezcS9qWz5QI/UUTv/UpbGhdYIFjKJIRV7iaq6SK4g/NSoYScbpb9n7y0=
X-Received: by 2002:a17:906:1cc2:: with SMTP id i2mr3962727ejh.283.1583515453642;
 Fri, 06 Mar 2020 09:24:13 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2002172139310.152060@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2002181828070.108053@chino.kir.corp.google.com>
 <CAHbLzkrJ_=8f8STvZ2GPGH6Arup8cKgGqigj4FQXWpmD-C5wNQ@mail.gmail.com>
 <alpine.DEB.2.21.2002181942460.155180@chino.kir.corp.google.com>
 <CAHbLzkq20hzLdYM-EMOfWRqPOr+OQF8uq5yWR=Yb6vQY51LKwg@mail.gmail.com> <20200220131202.i77zt3zj53mimrnu@box>
In-Reply-To: <20200220131202.i77zt3zj53mimrnu@box>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 6 Mar 2020 09:23:59 -0800
Message-ID: <CAHbLzkpgyrFe6L+U=2hoAyc5o8+2K5r8uyMTKx780iR3EiRE5g@mail.gmail.com>
Subject: Re: [patch 1/2] mm, shmem: add thp fault alloc and fallback stats
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Thu, Feb 20, 2020 at 5:11 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Wed, Feb 19, 2020 at 09:01:23AM -0800, Yang Shi wrote:
> > On Tue, Feb 18, 2020 at 7:44 PM David Rientjes <rientjes@google.com> wrote:
> > >
> > > On Tue, 18 Feb 2020, Yang Shi wrote:
> > >
> > > > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > > > --- a/mm/shmem.c
> > > > > +++ b/mm/shmem.c
> > > > > @@ -1502,9 +1502,8 @@ static struct page *shmem_alloc_page(gfp_t gfp,
> > > > >         return page;
> > > > >  }
> > > > >
> > > > > -static struct page *shmem_alloc_and_acct_page(gfp_t gfp,
> > > > > -               struct inode *inode,
> > > > > -               pgoff_t index, bool huge)
> > > > > +static struct page *shmem_alloc_and_acct_page(gfp_t gfp, struct inode *inode,
> > > > > +               pgoff_t index, bool fault, bool huge)
> > > > >  {
> > > > >         struct shmem_inode_info *info = SHMEM_I(inode);
> > > > >         struct page *page;
> > > > > @@ -1518,9 +1517,11 @@ static struct page *shmem_alloc_and_acct_page(gfp_t gfp,
> > > > >         if (!shmem_inode_acct_block(inode, nr))
> > > > >                 goto failed;
> > > > >
> > > > > -       if (huge)
> > > > > +       if (huge) {
> > > > >                 page = shmem_alloc_hugepage(gfp, info, index);
> > > > > -       else
> > > > > +               if (!page && fault)
> > > > > +                       count_vm_event(THP_FAULT_FALLBACK);
> > > > > +       } else
> > > > >                 page = shmem_alloc_page(gfp, info, index);
> > > > >         if (page) {
> > > > >                 __SetPageLocked(page);
> > > > > @@ -1832,11 +1833,10 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> > > > >         }
> > > > >
> > > > >  alloc_huge:
> > > > > -       page = shmem_alloc_and_acct_page(gfp, inode, index, true);
> > > > > +       page = shmem_alloc_and_acct_page(gfp, inode, index, vmf, true);
> > > > >         if (IS_ERR(page)) {
> > > > >  alloc_nohuge:
> > > > > -               page = shmem_alloc_and_acct_page(gfp, inode,
> > > > > -                                                index, false);
> > > > > +               page = shmem_alloc_and_acct_page(gfp, inode, index, vmf, false);
> > > > >         }
> > > > >         if (IS_ERR(page)) {
> > > > >                 int retry = 5;
> > > > > @@ -1871,8 +1871,11 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> > > > >
> > > > >         error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg,
> > > > >                                             PageTransHuge(page));
> > > > > -       if (error)
> > > > > +       if (error) {
> > > > > +               if (vmf && PageTransHuge(page))
> > > > > +                       count_vm_event(THP_FAULT_FALLBACK);
> > > > >                 goto unacct;
> > > > > +       }
> > > > >         error = shmem_add_to_page_cache(page, mapping, hindex,
> > > > >                                         NULL, gfp & GFP_RECLAIM_MASK);
> > > > >         if (error) {
> > > > > @@ -1883,6 +1886,8 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
> > > > >         mem_cgroup_commit_charge(page, memcg, false,
> > > > >                                  PageTransHuge(page));
> > > > >         lru_cache_add_anon(page);
> > > > > +       if (vmf && PageTransHuge(page))
> > > > > +               count_vm_event(THP_FAULT_ALLOC);
> > > >
> > > > I think shmem THP alloc is accounted to THP_FILE_ALLOC. And it has
> > > > been accounted by shmem_add_to_page_cache(). So, it sounds like a
> > > > double count.
> > > >
> > >
> > > I think we can choose to either include file allocations into both
> > > thp_fault_alloc and thp_fault_fallback or we can exclude them from both of
> > > them.  I don't think we can account for only one of them.
> >
> > How's about the 3rd option, adding THP_FILE_FALLBACK.
>
> I like this option.
>
> Problem with THP_FAULT_* is that shmem_getpage_gfp() is called not only
> from fault path, but also from syscalls.

I found another usecase for THP_FILE_FALLBACK. I wanted to measure
file THP allocation success rate in our uecase. It looks nr_file_alloc
/ (nr_file_alloc + nr_file_fallback) is the most simple way.

David, are you still working on this patch?

>
> --
>  Kirill A. Shutemov
