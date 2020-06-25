Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE90C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B902088E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wJ5yDwSY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403833AbgFYQFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389860AbgFYQFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:05:50 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9C3C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nbnfe8y2phVSLNtkpgv4yoZAKzFobqvinOzyPepTciA=; b=wJ5yDwSYYtQBTCnxgg6LiDb+j3
        OEOu0V3IhIOevYdpcK3XhbqU/M42tAf1xPjiFbpF3EbxSgs2VHixCTiGCO++8ZRo23BFZSKx8q9FT
        jHGhqG1fksAytQpxqYfqkDxivoCNcceeNdqpCOOAuoOxMeV3pXj5naJPPAEW7jKEnUDBfdKVxaGlp
        3VLdH+Oc/oxPofZm5cEb8DT/nbQfvJjuoYXDTNQO57H+vTyksE0sJ3KebCxqFxwVsB7jcJBpBDaid
        RY0Br5FuDo6EhV1hJMfAsbys3Hg/Q/+WK3bQVd/iDeI7nUHdH1ekeugyVYY24yziSlHX0G3fQ4dSa
        mkL2JG/g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joUNO-0006gj-Rx; Thu, 25 Jun 2020 16:05:22 +0000
Date:   Thu, 25 Jun 2020 17:05:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] mm: Skip opportunistic reclaim for dma pinned pages
Message-ID: <20200625160522.GD7703@casper.infradead.org>
References: <20200624191417.16735-1-chris@chris-wilson.co.uk>
 <20200625114209.GA7703@casper.infradead.org>
 <20200625134044.GD17788@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625134044.GD17788@quack2.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 03:40:44PM +0200, Jan Kara wrote:
> On Thu 25-06-20 12:42:09, Matthew Wilcox wrote:
> > Why are DMA pinned pages still on the LRU list at all?  I never got an
> > answer to this that made sense to me.  By definition, a page which is
> > pinned for DMA is being accessed, and needs to at the very least change
> > position on the LRU list, so just take it off the list when DMA-pinned
> > and put it back on the list when DMA-unpinned.
> 
> Well, we do mark_page_accessed() when pinning in GUP. This is not perfect
> but it's as good as it gets with CPU having no control when the page is
> actually accessed. Also taking the page off and then back to LRU list would
> increase the contention on the LRU list locks and generally cost
> performance so for short term pins it is not desirable... Otherwise I agree
> that conceptually it would make some sence although I'm not sure some
> places wouldn't get confused by e.g. page cache pages not being on LRU
> list. 

We could/should do what we do for mlocked pages:
Documentation/vm/unevictable-lru.rst

I think 'case five' is wrong and needs to be removed.  Pinning is
inappropriate for "I'm going to modify the page myself".
