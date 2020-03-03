Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE10C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4741520838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XQRYOUtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgCCQnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:43:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44426 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbgCCQnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:43:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4K9teVxOkEOyXTtctAJbU/3WG4+bePUoiy0aSqM/mWU=; b=XQRYOUtgm8kvEdVHlc1iBpqnQx
        PPZB66OYtNnUCx6VAayoHbugBVopjwjmJRyIWDt4ENOWPeGrnb1Mf2+OccRa8J1rTnSCN/1mJNMvy
        LvrcncqktSCcKShlZOUmuKGdq108N5rThd6u/eIkk083kcy3/t9H5Um+wuXYloHugBs3uAxzgEOsK
        RjrUNJet8auOJqYuj7h9idaev8q9TeM7SsVam+Ib8oas1xNH1DwRXmOHuHn6YaXKz2i9xDjeJw6sJ
        BuA/Hmyka/TibjoGPrzbcHwHK4UJIysq3IKojCyrETM4thyGT1dWk0w2wPq43kCCpSF7iyHDBH5dy
        98zWm44g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9AdZ-00012M-Ci; Tue, 03 Mar 2020 16:43:17 +0000
Date:   Tue, 3 Mar 2020 08:43:17 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Xianting Tian <xianting_tian@126.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap.c: clear page error before actual read
Message-ID: <20200303164317.GS29971@bombadil.infradead.org>
References: <1583248190-18123-1-git-send-email-xianting_tian@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583248190-18123-1-git-send-email-xianting_tian@126.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 10:09:50AM -0500, Xianting Tian wrote:
> This patch is to add the calling of ClearPageError just before the
> actual read of read path of cramfs mount.

Thank you for your patch and your analysis.  I concur; an error set
on a page will not be cleared by doing a subsequent read.  This is
probably an oversight; in generic_file_buffered_read(), we do:

                ClearPageError(page);
                /* Start the actual read. The read will unlock the page. */
                error = mapping->a_ops->readpage(filp, page);

and also in filemap_fault:

        ClearPageError(page);
        fpin = maybe_unlock_mmap_for_io(vmf, fpin);
        error = mapping->a_ops->readpage(file, page);

That said, a freshly allocated page will not have PageError set on
it, so I would prefer to see this:

        /* Someone else locked and filled the page in a very small window */
        if (PageUptodate(page)) {
                unlock_page(page);
                goto out;
        }
+	ClearPageError(page);
        goto filler;

