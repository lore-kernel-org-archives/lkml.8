Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3276FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0879D20639
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hWycvsSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgHUL6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgHUL6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:58:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53587C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 04:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3FksEgmPr7vqNMfiZSMm66QbIR2tGNR9y3WIbd3p5w0=; b=hWycvsSSENpNlsX6AfzbZx5Cej
        LUs8aJdAspH6c6AdiyqHpmzxRWT8fUx3a6uIeN5hNWToWZqjGprV/3ZR8rVx9lnuK17szKiwSqdzQ
        ou+kYQ76LnUlNgFICJr1LHqF4a6YD2xLO2zHJmcF8STK5f0Ox2/yzSkrrEKTDdSg6WA7QFH21pjYK
        rUUIVYykNHzc1IQxBzEiB2SAeudothLRy/Bj/SjdonMqzDiXZMWO9OkUqXqUYMePG/6WibYToCrhV
        KUogg6lRjBlkaeQGavjN0q+N0Qfsmjquy+RT1uRfB0uUP+5o6WsRZunV+3/QVy97WuQKufPhyA0DV
        xTgCpUVA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k95g0-00086n-Rm; Fri, 21 Aug 2020 11:57:44 +0000
Date:   Fri, 21 Aug 2020 12:57:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, chunyan.zhang@unisoc.com,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH v2] mm : sync ra->ra_pages with bdi->ra_pages
Message-ID: <20200821115744.GP17456@casper.infradead.org>
References: <1598001864-6123-1-git-send-email-zhaoyang.huang@unisoc.com>
 <CAGWkznGfc8g3SRd5vBq7sQGFLuc__98c7t21-3j4T1oAViHvgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznGfc8g3SRd5vBq7sQGFLuc__98c7t21-3j4T1oAViHvgg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 05:31:52PM +0800, Zhaoyang Huang wrote:
> This patch has been verified on an android system and reduces 15% of
> UNITERRUPTIBLE_SLEEP_BLOCKIO which was used to be caused by wrong
> ra->ra_pages.

Wait, what?  Readahead doesn't sleep on the pages it's requesting.
Unless ... your file access pattern is random, so you end up submitting
a readahead I/O that's bigger than needed, so takes longer for the page
you actually wanted to be returned.  I know we have the LOTSAMISS
logic, but that's not really enough.

OK, assuming this problem is really about sync mmap (ie executables),
this makes a bit more sense.  I think the real problem is here:

        ra->start = max_t(long, 0, offset - ra->ra_pages / 2);
        ra->size = ra->ra_pages;
        ra->async_size = ra->ra_pages / 4;
        ra_submit(ra, mapping, file);

which actually skips all the logic we have in ondemand_readahead()
for adjusting the readahead size.  Ugh, this is a mess.

I think a quick fix to your problem will be just replacing ra->ra_pages
with bdi->ra_pages in do_sync_mmap_readahead() and leaving ra->ra_pages
alone everywhere else.

We need a smarter readahead algorithm for mmap'ed files, and I don't have
time to work on it right now.  So let's stick to the same dumb algorithm,
but make it responsive to bdi ra_pages being reset.
