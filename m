Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3F2C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2E420BED
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cwij6vHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732285AbgIAQsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731971AbgIAQsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:48:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31737C061244;
        Tue,  1 Sep 2020 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nQQXUA/VGMtj9K229q9a5IZGP8mnt1kdy4SDzXnaIyc=; b=cwij6vHukHNI+V8tjoKhjVndSE
        gHsk+IJlyMeIRWYx4AVNurvCNmfsy0SfFSMaga++40VcM+HONvLSs1dSlVU1f/YssK2YwRcEUOJfG
        eC2qsL78uXeHG7Yf+ODvSXKT243Im987iab/BsWqck5lvdleXbt2EeEZoKOeTJcNrXh3KTCkLeNHg
        wjPvflkN5PE7QD3S5mgT7sYUqWp88w7GnsOlIJGSWzBlqcZa5iptC7H7xAq+f0i054XhHoHy/rxIM
        uq7hO4yRgYh1wlyJ8C5wYmuNV2LJpve4+FqnqANXyP8//XGjIUaVlqqWspiCL0uiEkVQX9NPThD9b
        XxMSXSwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kD9SN-00018H-J3; Tue, 01 Sep 2020 16:48:27 +0000
Date:   Tue, 1 Sep 2020 17:48:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] mm: Make more use of readahead_control
Message-ID: <20200901164827.GQ14765@casper.infradead.org>
References: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159897769535.405783.17587409235571100774.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 05:28:15PM +0100, David Howells wrote:
> Here's a set of patches to expand the use of the readahead_control struct,
> essentially from do_sync_mmap_readahead() down.

I like this.

> Note that I've been
> passing the number of pages to read in rac->_nr_pages, and then saving it
> and changing it certain points, e.g. page_cache_readahead_unbounded().

I do not like this.  You're essentially mutating the meaning of _nr_pages
as the ractl moves down the stack, and that's going to lead to bugs.
I'd keep it as a separate argument.

> Also there's an apparent minor bug in khugepaged.c that I've included a
> patch for: page_cache_sync_readahead() looks to be given the wrong size in
> collapse_file().

This needs to go in as an independent fix.  But you didn't actually cc Song.
