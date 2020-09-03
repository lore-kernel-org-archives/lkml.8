Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2629C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D672071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="enbJpHJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgICDQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbgICDQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:16:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052C7C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 20:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7M8dRmKxQ8SWluGuVH32a8z7XHLLbxlTFvPn8UpLMTU=; b=enbJpHJKb+JneT1dFhIpxsm6WV
        a7rMEnu0PrG4jkeDJ/TCAz4dih5YwJv9ZvIXK209n256YoLrj0jYYnrWKQ8FISbbPQouIYxwDA3qL
        RBLRr6ykUvENNQu4G5imMII4ui3QGdMB8yqVxdti8Rs01rFfffiQWyVDZqIDCo36G2zThkg3ojjFe
        V1qE+XACU/MlY0opp2nT6pSE34s/ktp7lh4e9zHOG0IRW9VBowogev6bnKyYY2TBHFjixtv3U4EBG
        2j/wDRJjfX9+wvZggBkU8V+ut4wzfYZx97dPvNJEKbLD/MXR0/vCYwQmvwL0SQpaiUehHR0W6TsUa
        xUaRbs3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDfiz-0000R4-Vo; Thu, 03 Sep 2020 03:15:46 +0000
Date:   Thu, 3 Sep 2020 04:15:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/16] mm: add pagechain container for storing
 multiple pages.
Message-ID: <20200903031545.GZ14765@casper.infradead.org>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902180628.4052244-2-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902180628.4052244-2-zi.yan@sent.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 02:06:13PM -0400, Zi Yan wrote:
> When depositing page table pages for 1GB THPs, we need 512 PTE pages +
> 1 PMD page. Instead of counting and depositing 513 pages, we can use the
> PMD page as a leader page and chain the rest 512 PTE pages with ->lru.
> This, however, prevents us depositing PMD pages with ->lru, which is
> currently used by depositing PTE pages for 2MB THPs. So add a new
> pagechain container for PMD pages.

But you've allocated a page for the PMD table.  Why can't you use that
4kB to store pointers to the 512 PTE tables?

You could also use an existing data structure like the XArray (although
not a pagevec).

