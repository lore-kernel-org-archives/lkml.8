Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC72C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C2242088E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IlAEIN73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404317AbgFYLmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404228AbgFYLmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:42:39 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C798C061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 04:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fUle3aetxySRQYFTnbRVKd4H1XlZhjMbUYZWBlbn48k=; b=IlAEIN73y4SkxmCkWa7yhDlk/1
        UTW+wamX8rd87nkcMA14xI0uj+0eOXBymR+brQ5VDMPdgCuIQj9fOIAD0VjGWzKJyTDEPLAij4+WQ
        VJJqHujQFBPr7JkgUDt+QAU0DthmowEChSj/NuZ8Hpy+1l07QSxDJFCZK6Dexf9pU6SNlVnyjs+5h
        yd3Qe0uKKMJzuqjIT5lWIA7tSJ01vemZ5QqyoOgreX9XHeczZitK58Q7GO1Gzdg1ykVg5Wj/BOWo+
        5GCmVrrXL7DZcbwuyEsdfVcVBmUhL5tzYpe/MMCEuWwnSPivhcofUheKgxN2SlgD9ZPx9FrKWdNb4
        EBbP/zKA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joQGf-0002Qb-OE; Thu, 25 Jun 2020 11:42:09 +0000
Date:   Thu, 25 Jun 2020 12:42:09 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] mm: Skip opportunistic reclaim for dma pinned pages
Message-ID: <20200625114209.GA7703@casper.infradead.org>
References: <20200624191417.16735-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624191417.16735-1-chris@chris-wilson.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 08:14:17PM +0100, Chris Wilson wrote:
> A side effect of the LRU shrinker not being dma aware is that we will
> often attempt to perform direct reclaim on the persistent group of dma
> pages while continuing to use the dma HW (an issue as the HW may already
> be actively waiting for the next user request), and even attempt to
> reclaim a partially allocated dma object in order to satisfy pinning
> the next user page for that object.
> 
> It is to be expected that such pages are made available for reclaim at
> the end of the dma operation [unpin_user_pages()], and for truly
> longterm pins to be proactively recovered via device specific shrinkers
> [i.e. stop the HW, allow the pages to be returned to the system, and
> then compete again for the memory].

Why are DMA pinned pages still on the LRU list at all?  I never got an
answer to this that made sense to me.  By definition, a page which is
pinned for DMA is being accessed, and needs to at the very least change
position on the LRU list, so just take it off the list when DMA-pinned
and put it back on the list when DMA-unpinned.

This overly complex lease stuff must have some reason for existing, but
I still don't get it.
