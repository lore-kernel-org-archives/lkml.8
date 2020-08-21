Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC60C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5CB3207CD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 22:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZLLicUE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHUWpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 18:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHUWpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 18:45:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9341FC061573;
        Fri, 21 Aug 2020 15:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=LfI/OrzE1eBdqL3okL2YqXp0meafLH7tI15of/K2lE0=; b=ZLLicUE0LXy5ygDPQ600jwapxE
        ntnYFz9WnnkqfIwwuEhmTF+f9vh9UMaifQSEswH6deeDHwu5k7fNlyhAIUHDuGcsr6FZ5N9pWFyWJ
        jacc3CKKFXCfV17LDEzxdAGXz7lRoaHNX77thOOT2xZiTwY7iX6jY33McKUcEKA+3WBu23uDc7nql
        utKtmIMlPcYxxWRBqAhHEFn+WDuyski6M19v+7lJdkYlYgSEh+KeMR+YlbTQq4K7IBmPlFlMdbboe
        VHiYKMJ13v1jkicupFxmvKxEouwtnklxTgVLVmwRc/1up5RKS8tsLWiOXB/OkRxZUm9spH4SkCvgE
        M9dODXFg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9Fmk-0008SE-Rj; Fri, 21 Aug 2020 22:45:22 +0000
Date:   Fri, 21 Aug 2020 23:45:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/78] Transparent Huge Pages for XFS
Message-ID: <20200821224522.GX17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... just kidding.  Nobody's going to review 78 patches.  Here's a git
tree instead:

http://git.infradead.org/users/willy/pagecache.git

I do want people to know that the THP patchset now passes xfstests.
I'm sending out portions of the patchset as individual series and trying
to get at least some of these patches merged for 5.10.

https://lore.kernel.org/linux-mm/20200819150555.31669-1-willy@infradead.org/
https://lore.kernel.org/linux-mm/20200819184850.24779-1-willy@infradead.org/
https://lore.kernel.org/linux-block/20200817195206.15172-1-willy@infradead.org/
https://lore.kernel.org/linux-mm/20200804161755.10100-1-willy@infradead.org/
https://lore.kernel.org/linux-mm/20200629152033.16175-1-willy@infradead.org/

I would like people to run their workloads against the git tree and
provide some performance numbers.

The biggest part of this patchset is supporting variable-sized THPs.
So far, all THPs have been PMD sized, and filesystems would prefer a page
size somewhere between PAGE_SIZE and PMD_SIZE.  Using the readahead code,
we increase the page size as we increase the size of readaheads.

This patch set does not attempt to allocate larger pages on writes.
That's a future enhancement.  There is also no support for larger pages
on filesystems other than XFS.  I have plans to add support for NFS, but I
don't plan to add support for buffer heads.  Think of this as an incentive
to convert to using the iomap infrastructure for buffered I/O ;-)
