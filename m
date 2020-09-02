Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AA2C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F03720BED
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ns69/13R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgIBSlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgIBSk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:40:56 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45443C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 11:40:56 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id x7so83335qvi.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 11:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bcS4U/TDkEjmDy6yRXTrs721YqsTWjDogH9TsoE/8jw=;
        b=Ns69/13R3eFgRAb4C1FKKSHcQxcT9FZKrX9XPAQ03AcFO8aOy08/ckYt1jhIZ3gyvd
         ovgS5sfE2U2RSCimiPyH0JCM+UUZM5+CglyAmBbCRhvLb63FHHXWxxakFGe3T6NBN/cP
         dE8Y/lvNhUJ/PpejPr2JVgWWqNzEH8mrSbFvzifWF1UUMJWDRYzcqj7dAdKEiVMXkeo/
         H2MK8JVF22Iu4hkchgEWo3Y5dtAkDGtmpJxjf2MRVFE+B90P2v2h/6rgnpKAbSZb7/Xm
         MEaq2gUIeww97cpgfHlmaB3P5ivue4L6JNVreYJxGGgxar4c1R5SxTpIqxui+6GhyLiS
         bH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bcS4U/TDkEjmDy6yRXTrs721YqsTWjDogH9TsoE/8jw=;
        b=EgF5MW0N7ecIhrhxyafGkt4tqdq1toQQ/gWkMBiNtR6w6c0n88xy/NKRtrLt4CrmhE
         dYgbjeUoA3sCZ00kQZQgcAPzG8N7iLLTQRZx3MzPaqyHD+s+inPe3oxsyhJ/GjdXvfKH
         YMDBI9e5rX7vP48aVXLHTLdn+t6iBzSutkEABABnVW5QuQ36qDPS1ILG/SC3I/YDgN21
         0IKpCB5Cj2pIPc1yuyrvQwxyVjQF+qsFX1+qQI+QVuVcgrAdXh0Q2kidg+JKnb3z4HXr
         UhTMwEFLggOix6bqy+d7oMZC7VCa6ikYcfPq80WfVjqHfUADHIujD0EFnBpLRVvW3KMt
         8Pig==
X-Gm-Message-State: AOAM532kfQMzg8RIU/W1tLInDxlJ7S+Yx5IXVYjAvm7BhEvRVtgRX+IY
        V4BMzAg5FlgK4lrHJpNXk1jAWg==
X-Google-Smtp-Source: ABdhPJwd9nFRvA8UdAquhEw+PDJOEzDc0A/bniNOGFlBp8JhZE8bbPMlLpq5HE1vaWwJ43rHEbFxjA==
X-Received: by 2002:a0c:f607:: with SMTP id r7mr8016373qvm.219.1599072055497;
        Wed, 02 Sep 2020 11:40:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v185sm358054qki.128.2020.09.02.11.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 11:40:54 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kDXgj-005xHZ-I4; Wed, 02 Sep 2020 15:40:53 -0300
Date:   Wed, 2 Sep 2020 15:40:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200902184053.GF24045@ziepe.ca>
References: <20200902180628.4052244-1-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902180628.4052244-1-zi.yan@sent.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 02:06:12PM -0400, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> Hi all,
> 
> This patchset adds support for 1GB THP on x86_64. It is on top of
> v5.9-rc2-mmots-2020-08-25-21-13.
> 
> 1GB THP is more flexible for reducing translation overhead and increasing the
> performance of applications with large memory footprint without application
> changes compared to hugetlb.
> 
> Design
> =======
> 
> 1GB THP implementation looks similar to exiting THP code except some new designs
> for the additional page table level.
> 
> 1. Page table deposit and withdraw using a new pagechain data structure:
>    instead of one PTE page table page, 1GB THP requires 513 page table pages
>    (one PMD page table page and 512 PTE page table pages) to be deposited
>    at the page allocaiton time, so that we can split the page later. Currently,
>    the page table deposit is using ->lru, thus only one page can be deposited.
>    A new pagechain data structure is added to enable multi-page deposit.
> 
> 2. Triple mapped 1GB THP : 1GB THP can be mapped by a combination of PUD, PMD,
>    and PTE entries. Mixing PUD an PTE mapping can be achieved with existing
>    PageDoubleMap mechanism. To add PMD mapping, PMDPageInPUD and
>    sub_compound_mapcount are introduced. PMDPageInPUD is the 512-aligned base
>    page in a 1GB THP and sub_compound_mapcount counts the PMD mapping by using
>    page[N*512 + 3].compound_mapcount.
> 
> 3. Using CMA allocaiton for 1GB THP: instead of bump MAX_ORDER, it is more sane
>    to use something less intrusive. So all 1GB THPs are allocated from reserved
>    CMA areas shared with hugetlb. At page splitting time, the bitmap for the 1GB
>    THP is cleared as the resulting pages can be freed via normal page free path.
>    We can fall back to alloc_contig_pages for 1GB THP if necessary.
> 
> 
> Patch Organization
> =======
> 
> Patch 01 adds the new pagechain data structure.
> 
> Patch 02 to 13 adds 1GB THP support in variable places.
> 
> Patch 14 tries to use alloc_contig_pages for 1GB THP allocaiton.
> 
> Patch 15 moves hugetlb_cma reservation to cma.c and rename it to hugepage_cma.
> 
> Patch 16 use hugepage_cma reservation for 1GB THP allocation.
> 
> 
> Any suggestions and comments are welcome.
> 
> 
> Zi Yan (16):
>   mm: add pagechain container for storing multiple pages.
>   mm: thp: 1GB anonymous page implementation.
>   mm: proc: add 1GB THP kpageflag.
>   mm: thp: 1GB THP copy on write implementation.
>   mm: thp: handling 1GB THP reference bit.
>   mm: thp: add 1GB THP split_huge_pud_page() function.
>   mm: stats: make smap stats understand PUD THPs.
>   mm: page_vma_walk: teach it about PMD-mapped PUD THP.
>   mm: thp: 1GB THP support in try_to_unmap().
>   mm: thp: split 1GB THPs at page reclaim.
>   mm: thp: 1GB THP follow_p*d_page() support.
>   mm: support 1GB THP pagemap support.
>   mm: thp: add a knob to enable/disable 1GB THPs.
>   mm: page_alloc: >=MAX_ORDER pages allocation an deallocation.
>   hugetlb: cma: move cma reserve function to cma.c.
>   mm: thp: use cma reservation for pud thp allocation.

Surprised this doesn't touch mm/pagewalk.c ?

Jason
