Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8262DC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8A2206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pzmo+Nyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgBLHnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:43:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbgBLHnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i3FzU/6t3BUZQYdYKWKIP++waVhK3QKo6kpSCfJQFvg=; b=pzmo+Nyf5LhurqtfRObXcjN6/i
        30JD94xN3M0+qt1rP80flGX/Md2ds9rmbNxwaBVV7MLc0S4DRwNS/Wn2iY8Tg1qs/aHtczJEdGKpg
        2ck6k5Lrem7z3nme/5pWKJ1Uj95mbxSNqmBCf5kU1ebyIZl66IDfJj+yrsdviQI1o6xINTWOi+bz/
        i3fgDk8fsNnzakvbTENrz6r6YxhUScL9FbYbVMFc/GHD/sAnOFO7tKSfCtc/VyOh/V6vkkPZWJ5pl
        xpNtbqbTM3YuBYafebNA32b7oNP3azQOpNB/VM2lfcDDT4YVv151hmIO2gDK2rJKneWcAT+kGOCTc
        BQe7Kcsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1mg2-0000Aw-Ux; Wed, 12 Feb 2020 07:43:18 +0000
Date:   Tue, 11 Feb 2020 23:43:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/25] fs: Add a filesystem flag for large pages
Message-ID: <20200212074318.GG7068@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-10-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212041845.25879-10-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 08:18:29PM -0800, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> The page cache needs to know whether the filesystem supports pages >
> PAGE_SIZE.

Does it make sense to set this flag on the file_system_type, which
is rather broad scope, or a specific superblock or even inode?

For some file systems we might require on-disk flags that aren't set
for all instances.
