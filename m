Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D588C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C4B20714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MuERL3Od"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgBLO7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:59:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43082 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBLO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FgFLJTvBuzlIrLf1DK1nejj+RgbkbMvjMUWGEtVxYBg=; b=MuERL3OdmrQeEWKpBpT5VAehhz
        E+6+xkiw+s2UiGXu4mgWVmfRQUEEx0E+R2LkMpxjsWrcgNO272pjwNAilmDIs6pRP7LpIOIVSrppB
        +cJxC/+5C92Ltp45Y44BZREyDIcmQA/0q2W9yM1CVfLzV47+uuvXamcQZiE5X5iMtsaPhzK09IFDp
        VvG5tlIqNJVKdy+Xia1dyAEdco37dyFinfTUo7ppecnZ2DFYWqzKTUss7QKuBW5Mgh4Vvtdp7ZmPy
        ZNbfBuZ4qnIKBWqAOucnmyaBhHnqPAohxYyPsvE3dB+LsqqmKfX6vvyHw5tlVMkhsKXS+n/YlJX+r
        zogXuURQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1tTg-0004Q9-RN; Wed, 12 Feb 2020 14:59:00 +0000
Date:   Wed, 12 Feb 2020 06:59:00 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/25] fs: Add a filesystem flag for large pages
Message-ID: <20200212145900.GD7778@bombadil.infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-10-willy@infradead.org>
 <20200212074318.GG7068@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212074318.GG7068@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 11:43:18PM -0800, Christoph Hellwig wrote:
> On Tue, Feb 11, 2020 at 08:18:29PM -0800, Matthew Wilcox wrote:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > 
> > The page cache needs to know whether the filesystem supports pages >
> > PAGE_SIZE.
> 
> Does it make sense to set this flag on the file_system_type, which
> is rather broad scope, or a specific superblock or even inode?
> 
> For some file systems we might require on-disk flags that aren't set
> for all instances.

I don't see why we'd need on-disk flags or need to control this on a
per-inode or per-sb basis.  My intent for this flag is to represent
whether the filesystem understands large pages; how the file is cached
should make no difference to the on-disk layout.
