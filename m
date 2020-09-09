Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8904CC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 326C921919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="snsjbUkl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbgIIQnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbgIIQMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:12:48 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8A4C06138F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:46:19 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y2so1606079lfy.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 06:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OFXb0fPeLozHIVk13q+oqzPm3YSyHqohd5OhKkyGBzk=;
        b=snsjbUklactjQNaOxCa7O3dIYtSGEg2ycGoP/cP0ENJaq6E1pxjSgNYk/K28kQk8wS
         DmGXJF927zgRygzhmTP2PWZdovyGVz9WpC2ykyIfltp92TUwWpJuAqdX6CSQD5TL1XNp
         fHOPBouWFy6DN7Q1STE438GKb73xVEyXQMaxopP/cyk3z5T5RhgwljPTCw3v0vgPPwIJ
         KFqpigwngqqiCjwmCxoNTc6BSnwNvwwQMOjXGB5tW+MWntbgcVer+zwxAGhhFRFfJY2Z
         Nuygjq+UM+c+nMm0NKfrjQ/TjObKOpgZct0cA3365yaUpMMNRKwk42YUCKvbbI4WkkrL
         JR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OFXb0fPeLozHIVk13q+oqzPm3YSyHqohd5OhKkyGBzk=;
        b=Mtc22PXI8w4WXtfBjhYF/r4DnVZk/au2InFQl1RLmorQbngun4rtZ/HfLEUGBY1uyt
         y3zW7ZM9GLP4aKkBAjfqYSi6P46Ense5WNAmXWLI+ZeTAiuAST6dIik+xJd/qzlbYwsy
         EnwK3qfGMJS6456L5XxcSFp1RzD2FjQNxSXm4ng20d0mKXqCHBjziyHM/2KDiNjt+2zc
         UqOaC7MC3oB6CS33J6nCm5+/kt/ZmvHNjujhy+3nB/yJH6X5pyylTyXPeD18+ISOq+BG
         TUMxwrOVfhjiDuHCZELPfLnvD+4k6r0SpDDevCTHeoNIBI5qmghvq4aLFa5ZdrVg+i2M
         zJEA==
X-Gm-Message-State: AOAM532yZ3iJk0qeTYLAOZDhqgZy4gzAJrqT+Q8iRi0sKLIoOQm5lj8j
        9JS0hcGXwCW4WXfWVXsnaf7ohw==
X-Google-Smtp-Source: ABdhPJyTk4108hBQZgn/Y4gNdjt/2DgtafCRGGwNLgK9b1ovUuZLK9iu9GKM7+vEJY6b23OBMrgy6Q==
X-Received: by 2002:a19:8907:: with SMTP id l7mr1931403lfd.105.1599659177768;
        Wed, 09 Sep 2020 06:46:17 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w4sm584720lfq.75.2020.09.09.06.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 06:46:17 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 338DA1036AE; Wed,  9 Sep 2020 16:46:22 +0300 (+03)
Date:   Wed, 9 Sep 2020 16:46:22 +0300
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
Subject: Re: [RFC PATCH 01/16] mm: add pagechain container for storing
 multiple pages.
Message-ID: <20200909134622.xkuzx5nf4xq2vudh@box>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902180628.4052244-2-zi.yan@sent.com>
 <20200907122228.4zlyfysdul3s62me@box>
 <50FA95D1-9222-48C0-9223-C1267E8C7A4A@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50FA95D1-9222-48C0-9223-C1267E8C7A4A@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 11:11:05AM -0400, Zi Yan wrote:
> On 7 Sep 2020, at 8:22, Kirill A. Shutemov wrote:
> 
> > On Wed, Sep 02, 2020 at 02:06:13PM -0400, Zi Yan wrote:
> >> From: Zi Yan <ziy@nvidia.com>
> >>
> >> When depositing page table pages for 1GB THPs, we need 512 PTE pages +
> >> 1 PMD page. Instead of counting and depositing 513 pages, we can use the
> >> PMD page as a leader page and chain the rest 512 PTE pages with ->lru.
> >> This, however, prevents us depositing PMD pages with ->lru, which is
> >> currently used by depositing PTE pages for 2MB THPs. So add a new
> >> pagechain container for PMD pages.
> >>
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >
> > Just deposit it to a linked list in the mm_struct as we do for PMD if
> > split ptl disabled.
> >
> 
> Thank you for checking the patches. Since we don’t have PUD split lock
> yet, I store the PMD page table pages in a newly added linked list head
> in mm_struct like you suggested above.
> 
> I was too vague about my pagechain design for depositing page table pages
> for PUD THPs. Sorry about the confusion. Let me clarify why
> I am doing this pagechain here too. I am sure there would be
> some other designs and I am happy to change my code.
> 
> In my design, I did not store all page table pages in a single list.
> I first deposit 512 PTE pages in one PMD page table page’s pmd_huge_pte
> using pgtable_trans_huge_depsit(), then deposit the PMD page to
> a newly added linked list in mm_struct. Since pmd_huge_pte shares space
> with half of lru in struct page, we cannot use lru to link all PMD
> pages together. As a result, I added pagechain. Also in this way,
> we can avoid these things:
> 
> 1. when we withdraw the PMD page during PUD THP split, we don’t need
> to withdraw 513 page, set up one PMD page, then, deposit 512 PTE pages
> in that PMD page.
> 
> 2. we don’t mix PMD page table pages and PTE page table pages in a single
> list, since they are initialized in different ways. Otherwise, we need
> to maintain a subtle rule in the single page table page list that in every
> 513 pages, first one is PMD page table page and the rest are PTE page
> table pages.
> 
> As I am typing, I also realize that my current design does not work
> when PMD split lock is disabled, so I will fix it. I would store PMD pages
> and PTE pages in two separate lists in mm_struct.
> 
> 
> Any comments?

Okay, fair enough.

Although, I think you can get away without a new data structure. We don't
need double-linked list to deposit page tables. You can rework PTE tables
deposit code to have single-linked list and use one pointer of ->lru (with
proper name) and make PMD tables deposit to use the other one. This way
you can avoid conflict for ->lru.

Does it make sense?

-- 
 Kirill A. Shutemov
