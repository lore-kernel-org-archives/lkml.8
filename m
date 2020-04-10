Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F4DC2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB76F20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 15:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="t2Hk/GfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDJP4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 11:56:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41391 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgDJP4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:56:16 -0400
Received: by mail-lf1-f66.google.com with SMTP id u10so499394lfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5oXzzweU9+b1N5+cGj6pvbd+Y8KpBQDkz61NLnD/b7c=;
        b=t2Hk/GfOBLvuuJ342Lrin5iCn8jW7Hdl70kSAp5chiaxVe3jyF6APhVBUz0JD9wR9C
         csCdUGmml/oC1rstoIwryKphaM37BYtFVKrv+Uz5ib0rljmOqRayvK04I+Ux3bBdZVZU
         gidlwxUtSxfhwE5i6DHR013lTGAu27xnhQ61ditOHV5ZRlPksyJtrt/KC9KC72u32hLC
         kNju4qiF4rOQOszUwaVQAvaZHVMM6+RuNrCa79UvgBzMyJnW/j3sAZ75qtAnkjiJi0UK
         86ipF3Ny/DWYDMNdjEAFMrqs73wIyoWWxB3kkB9oq5Xhs5ZNcQ/4IMxXsnqzS5Xf1218
         gnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5oXzzweU9+b1N5+cGj6pvbd+Y8KpBQDkz61NLnD/b7c=;
        b=HbyuL72orRpxUdim6X8fuTh2T7CxciAgnunAju3y9NL+G1oizeQigKKb8CV7apteJD
         58DvpLkwjOS7MGXpp09Y75PUHmyG0s6Ihbb81m4fY8uBCQO2OMS5uCsCinJIEPdgQ4Ef
         RZmf5PYZGayga6K5za/8p/WUhhtWSqIZH/QagdK12bk6pJfB/hdRmDXkAtn2WFvP4o4l
         PzOdIki+UaRjbz11QVFnLC7dKYfmSHps2l3uXosk735M0fsmonBIwTWzWP+71Wo1+zRk
         LiWtt86iJMpty+etfFTVGAj26SwO82ncc4rlxNMZFbjxuimF1z08fL1Ctbmq7HocLrXL
         Kpmw==
X-Gm-Message-State: AGi0PuaIXWXqk1wKO4OyAI4Horb1xAn0Eoo1/t96BZRsWVd1rIsrQc0M
        K4nENjzNxdkzld0pcy5+kyIkvA==
X-Google-Smtp-Source: APiQypI9qvle8foeI1LCtXi2mzT1MhdY9shhQWtO1nZMume9pEjCI8OG2k/lFRxBm7w9FG5W1mkOMw==
X-Received: by 2002:a05:6512:686:: with SMTP id t6mr3048293lfe.163.1586534174501;
        Fri, 10 Apr 2020 08:56:14 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w10sm1264769ljh.85.2020.04.10.08.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 08:56:13 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id DA8EE102110; Fri, 10 Apr 2020 18:56:13 +0300 (+03)
Date:   Fri, 10 Apr 2020 18:56:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 5/8] khugepaged: Allow to callapse a page shared across
 fork
Message-ID: <20200410155613.cxqplrmwckezx3hl@box>
References: <20200403112928.19742-1-kirill.shutemov@linux.intel.com>
 <20200403112928.19742-6-kirill.shutemov@linux.intel.com>
 <b03643ba-8411-8486-737c-1bc29dd10a74@linux.alibaba.com>
 <20200408131044.xzlheacvslrbwrja@box>
 <107630f5-bbde-3f78-23e9-6f6b3113d709@linux.alibaba.com>
 <61569ead-2bbd-6d18-c04c-3251218a3fcd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61569ead-2bbd-6d18-c04c-3251218a3fcd@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 05:03:00PM -0700, Yang Shi wrote:
> 
> 
> On 4/8/20 11:51 AM, Yang Shi wrote:
> > 
> > 
> > On 4/8/20 6:10 AM, Kirill A. Shutemov wrote:
> > > On Mon, Apr 06, 2020 at 01:50:56PM -0700, Yang Shi wrote:
> > > > 
> > > > On 4/3/20 4:29 AM, Kirill A. Shutemov wrote:
> > > > > The page can be included into collapse as long as it doesn't
> > > > > have extra
> > > > > pins (from GUP or otherwise).
> > > > > 
> > > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > > ---
> > > > >    mm/khugepaged.c | 25 ++++++++++++++-----------
> > > > >    1 file changed, 14 insertions(+), 11 deletions(-)
> > > > > 
> > > > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > > > index 57ff287caf6b..1e7e6543ebca 100644
> > > > > --- a/mm/khugepaged.c
> > > > > +++ b/mm/khugepaged.c
> > > > > @@ -581,11 +581,18 @@ static int
> > > > > __collapse_huge_page_isolate(struct vm_area_struct *vma,
> > > > >            }
> > > > >            /*
> > > > > -         * cannot use mapcount: can't collapse if there's a gup pin.
> > > > > -         * The page must only be referenced by the scanned process
> > > > > -         * and page swap cache.
> > > > > +         * Check if the page has any GUP (or other external) pins.
> > > > > +         *
> > > > > +         * The page table that maps the page has been
> > > > > already unlinked
> > > > > +         * from the page table tree and this process cannot get
> > > > > +         * additinal pin on the page.
> > > > > +         *
> > > > > +         * New pins can come later if the page is shared across fork,
> > > > > +         * but not for the this process. It is fine. The
> > > > > other process
> > > > > +         * cannot write to the page, only trigger CoW.
> > > > >             */
> > > > > -        if (page_count(page) != 1 + PageSwapCache(page)) {
> > > > > +        if (total_mapcount(page) + PageSwapCache(page) !=
> > > > > +                page_count(page)) {
> > > > This check looks fine for base page, but what if the page is
> > > > PTE-mapped THP?
> > > > The following patch made this possible.
> > > > 
> > > > If it is PTE-mapped THP and the page is in swap cache, the
> > > > refcount would be
> > > > 512 + the number of PTE-mapped pages.
> > > > 
> > > > Shall we do the below change in the following patch?
> > > > 
> > > > extra_pins = PageSwapCache(page) ? nr_ccompound(page) - 1 : 0;
> > > > if (total_mapcount(page) + PageSwapCache(page) != page_count(page) -
> > > > extra_pins) {
> > > > ...
> > > Looks like you're right.
> > > 
> > > It would be nice to have a test case to demonstrate the issue.
> > > 
> > > Is there any way to trigger moving the page to swap cache? I don't
> > > see it
> > > immediately.
> > 
> > It sounds not easy to trigger since it totally depends on timing, I'm
> > wondering we may have to use MADV_PAGEOUT? Something below off the top
> > of my head may trigger this?
> > 
> > 
> >     CPU       A                                    CPU    B            
> >         CPU    C
> > In parent:
> > MADV_HUGEPAGE
> > page fault to fill with THP
> > fork
> >                                                     In Child:
> > MADV_NOHUGEPAGE
> > MADV_DONTNEED (split pmd)
> > MADV_PAGEOUT
> >                                                             ->
> > add_to_swap
> >                                 khugepaged scan parent and try to
> > collapse PTE-mapped
> > 
> >                                                             ->
> > try_to_unmap
> > 
> > When doing MADV_DONTNEED we need make sure head page is unmapped since
> > MADV_PAGEOUT would call page_mapcount(page) to skip shared mapping.
> 
> This can't trigger it since MADV_PAGEOUT would isolate the page from lru so
> khugepaged_scan_pmd() can't reach the refcount check at all.
> 
> If try_to_unmap() or pageout() fails, the page may stay in swap cache. But I
> didn't think of an easy way to make this happen.

Okay, I'll fix it without a test case.

-- 
 Kirill A. Shutemov
