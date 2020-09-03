Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C0FC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7541E20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Hld+nvYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgICOrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgICOZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:25:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3450BC0611E1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 07:23:01 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y17so2004804lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 07:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O/z6sRcm/w3Gq8tyci41HnHcIsT/GCvCxeftWXJE3ZM=;
        b=Hld+nvYkZKgt0X3+OpEeMXJhLN4SNaQYMvUr7kv8tw+aY0UpEhoAwv4V8pgi4SSJ2H
         MS0NMaV+HXyKOyijf8Jfnzzt+XnwgGnbRVdaDBTnnuCb94tTx6mpw46euxE22JBBvwGw
         bX5kmq9SSzO2dMF9YyvSoS2iNRHFGTjTpHnwQH9Tny80Y/wTWeDwaBjazfnVp62L1PZY
         d1ffElPpl1Gzi1F2mSu59qmoYxS/BO7YWQp+Duj3mHgBaOmDqmtd3kDSD9vgGhT7PuOT
         pByXoVovDnxO+xK3Ai3jNII0arq5wBAMfabJzQ3mViHkzqHkHjsfLv4rgizikRXBrkia
         evgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O/z6sRcm/w3Gq8tyci41HnHcIsT/GCvCxeftWXJE3ZM=;
        b=IJlm3oC2Wgo8qz7qfvst6TSJZTey9F8EtE2yqimr5ob8QoDMtnMhmE6ibL83MWL9tU
         Wi2EERmHA0hKripUQtKpKzvCmJDTUSH7F0rU+bK0MdtSFGy/Zzvjv/Ly2zVUbJMwE9am
         K1KTJQx9P7zZ88QF+BkuOuBkAMICRWwuvPPrVYv0mn0YKRkRe4wvBNvIm0BEisulc78Y
         cC8hTvq6CQiWX6ipzZDtR/Q9aZJ417J0uxBdFh3C53yiR0d/W+GF9ZL7g01j1Zm4/fhG
         hZJwLS0kK9sWr+ZNldGWfa3YpDaZ9/MOqmcFR+qDXHcskuEC1CILpcxwRH1h9oCW4dV6
         vbYQ==
X-Gm-Message-State: AOAM5321+0BNErgXAB1rp7AlhQ23c5x72agNnKu270U+uzSq6rvsyfMl
        bHBKYkZViW9BzziuEIvD/z3A/Q==
X-Google-Smtp-Source: ABdhPJzpabZDHSmsRn/rqjHHltKbK/pr+mbWx6JJtKMzY8LLajUTdLpQxTCqAr5ypxTd8fG0IK1lpg==
X-Received: by 2002:a19:8142:: with SMTP id c63mr1407517lfd.175.1599142979609;
        Thu, 03 Sep 2020 07:22:59 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id k12sm632952ljh.95.2020.09.03.07.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 07:22:59 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BE37E102212; Thu,  3 Sep 2020 17:23:00 +0300 (+03)
Date:   Thu, 3 Sep 2020 17:23:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
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
Message-ID: <20200903142300.bjq2um5y5nwocvar@box>
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

This statement needs a lot of justification. I don't see 1GB THP as viable
for any workload. Opportunistic 1GB allocation is very questionable
strategy.

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

False. Current code can deposit arbitrary number of page tables.

What can be problem to you is that these page tables tied to struct page
of PMD page table.

>    A new pagechain data structure is added to enable multi-page deposit.
> 
> 2. Triple mapped 1GB THP : 1GB THP can be mapped by a combination of PUD, PMD,
>    and PTE entries. Mixing PUD an PTE mapping can be achieved with existing
>    PageDoubleMap mechanism. To add PMD mapping, PMDPageInPUD and
>    sub_compound_mapcount are introduced. PMDPageInPUD is the 512-aligned base
>    page in a 1GB THP and sub_compound_mapcount counts the PMD mapping by using
>    page[N*512 + 3].compound_mapcount.

I had hard time reasoning about DoubleMap vs. rmap. Good for you if you
get it right.

> 3. Using CMA allocaiton for 1GB THP: instead of bump MAX_ORDER, it is more sane
>    to use something less intrusive. So all 1GB THPs are allocated from reserved
>    CMA areas shared with hugetlb. At page splitting time, the bitmap for the 1GB
>    THP is cleared as the resulting pages can be freed via normal page free path.
>    We can fall back to alloc_contig_pages for 1GB THP if necessary.
> 

-- 
 Kirill A. Shutemov
