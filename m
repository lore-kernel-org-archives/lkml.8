Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060D5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB1120716
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tNBCsedz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgHNLsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgHNLsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:48:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A606C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MOOOT8FR20WjgLSWAiehuYkMI9+OIJrQwNnRd5HHJPg=; b=tNBCsedznNKmnNNP7AZZPcBul4
        EvDBoO9HU5CTVvmv/r80UKgrIuEE1K8YL56o62Wwb3RWH9vXJDENu4+3twROWqhSejMFJyROjk75z
        +ofmVe6L8kHaZXB/27E0vNMrxO0cvvvdosz8ejCd36kZvjkAzqQQDj8nCcjfu3salfn3xPq9sTikN
        8i5QOq84dTrzoe13hcmkHcu8H97x3GOYhVOTTfs5sBDFT4+xw9prT6oq57tTOVrUJTTour6QKeihS
        8y/tSsIfoplKmU07/NbARDaIytkHdqLOiD45HVKIr4XjMosn8u6ZBibHyrfodNGZqRFolYEH4UYVx
        yv1awzJA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6YC4-0008Dx-02; Fri, 14 Aug 2020 11:48:20 +0000
Date:   Fri, 14 Aug 2020 12:48:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Roman Gushchin <klamm@yandex-team.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm : sync ra->ra_pages with bdi->ra_pages
Message-ID: <20200814114819.GW17456@casper.infradead.org>
References: <1597395824-3325-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597395824-3325-1-git-send-email-zhaoyang.huang@unisoc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 05:03:44PM +0800, Zhaoyang Huang wrote:
> Some system(like android) will turbo read during startup via expanding the
> readahead window and then set it back to normal(128kb as usual). However, some
> files in the system process context will keep to be opened since it is opened
> up and has no chance to sync with the updated value as it is almost impossible
> to change the files attached to the inode(processes are unaware of these things)

Hang on, you're saying that the _only_ way to do turbo-read is the way
that userspace currently does it, and userspace cannot be modified,
only the kernel?  I think somebody has their priorities wrong!

> We sync ra->ra_pages with bdi->ra_pages when read. Furthermore, in consideration
> of the scenario of eio and fadvise(...,POSIX_FADV_SEQUENTIAL).We introduce a
> seq_read_fact to record the factors of above two cases.

No, this is far too complicated.

