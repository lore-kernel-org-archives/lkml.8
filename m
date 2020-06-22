Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25885C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E89F32075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ETs4k3/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgFVTTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbgFVTTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:19:13 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD4FC061573;
        Mon, 22 Jun 2020 12:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RQJq+7AzCVSDpLZ6UztkdVPIx33ju3bxwq7Nfv4giNc=; b=ETs4k3/6ptZjuGJ6PGMlAriF7D
        M2ZdWwBt07llvSQB3BRcysDLSM3TjUVsx2uKutQ2vRUYTecj/a7AXSp0PL3NPz0UPP2IXjq5VLKjn
        6ozhtSFlY44iX3P4Ap8ARRAzJivWbV/gjuu+us5GHL1+vWt3oT6DCfP/QV87dyc4uhiGZcDLgnu8N
        uiRNKe31sLOCccpwMvpf0WOFRcD3KbMhRWGZYheSJnDhCgDg6cO7jup1Xc7/MnC1OFUfosB6V8oNv
        9IKsT6yEgtZCNKy+qKjYCc4j/f7UfIglA9F+Jwa67DqAWH/1GBFptB4m0SRMrD+ASdOEZEdHCcMpn
        0uIbqEuA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnRy5-0001ra-3v; Mon, 22 Jun 2020 19:18:57 +0000
Date:   Mon, 22 Jun 2020 20:18:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        agruenba@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Bypass filesystems for reading cached pages
Message-ID: <20200622191857.GB21350@casper.infradead.org>
References: <20200619155036.GZ8681@bombadil.infradead.org>
 <20200622003215.GC2040@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622003215.GC2040@dread.disaster.area>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:32:15AM +1000, Dave Chinner wrote:
> On Fri, Jun 19, 2020 at 08:50:36AM -0700, Matthew Wilcox wrote:
> > 
> > This patch lifts the IOCB_CACHED idea expressed by Andreas to the VFS.
> > The advantage of this patch is that we can avoid taking any filesystem
> > lock, as long as the pages being accessed are in the cache (and we don't
> > need to readahead any pages into the cache).  We also avoid an indirect
> > function call in these cases.
> 
> What does this micro-optimisation actually gain us except for more
> complexity in the IO path?
> 
> i.e. if a filesystem lock has such massive overhead that it slows
> down the cached readahead path in production workloads, then that's
> something the filesystem needs to address, not unconditionally
> bypass the filesystem before the IO gets anywhere near it.

You're been talking about adding a range lock to XFS for a while now.
I remain quite sceptical that range locks are a good idea; they have not
worked out well as a replacement for the mmap_sem, although the workload
for the mmap_sem is quite different and they may yet show promise for
the XFS iolock.

There are production workloads that do not work well on top of a single
file on an XFS filesystem.  For example, using an XFS file in a host as
the backing store for a guest block device.  People tend to work around
that kind of performance bug rather than report it.

Do you agree that the guarantees that XFS currently supplies regarding
locked operation will be maintained if the I/O is contained within a
single page and the mutex is not taken?  ie add this check to the original
patch:

        if (iocb->ki_pos / PAGE_SIZE !=
            (iocb->ki_pos + iov_iter_count(iter) - 1) / PAGE_SIZE)
                goto uncached;

I think that gets me almost everything I want.  Small I/Os are going to
notice the pain of the mutex more than large I/Os.
