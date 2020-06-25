Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89783C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6713A20672
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405206AbgFYNks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:40:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:55220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404966AbgFYNkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:40:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9490AEDD;
        Thu, 25 Jun 2020 13:40:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E966C1E1274; Thu, 25 Jun 2020 15:40:44 +0200 (CEST)
Date:   Thu, 25 Jun 2020 15:40:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] mm: Skip opportunistic reclaim for dma pinned pages
Message-ID: <20200625134044.GD17788@quack2.suse.cz>
References: <20200624191417.16735-1-chris@chris-wilson.co.uk>
 <20200625114209.GA7703@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625114209.GA7703@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-06-20 12:42:09, Matthew Wilcox wrote:
> On Wed, Jun 24, 2020 at 08:14:17PM +0100, Chris Wilson wrote:
> > A side effect of the LRU shrinker not being dma aware is that we will
> > often attempt to perform direct reclaim on the persistent group of dma
> > pages while continuing to use the dma HW (an issue as the HW may already
> > be actively waiting for the next user request), and even attempt to
> > reclaim a partially allocated dma object in order to satisfy pinning
> > the next user page for that object.
> > 
> > It is to be expected that such pages are made available for reclaim at
> > the end of the dma operation [unpin_user_pages()], and for truly
> > longterm pins to be proactively recovered via device specific shrinkers
> > [i.e. stop the HW, allow the pages to be returned to the system, and
> > then compete again for the memory].
> 
> Why are DMA pinned pages still on the LRU list at all?  I never got an
> answer to this that made sense to me.  By definition, a page which is
> pinned for DMA is being accessed, and needs to at the very least change
> position on the LRU list, so just take it off the list when DMA-pinned
> and put it back on the list when DMA-unpinned.

Well, we do mark_page_accessed() when pinning in GUP. This is not perfect
but it's as good as it gets with CPU having no control when the page is
actually accessed. Also taking the page off and then back to LRU list would
increase the contention on the LRU list locks and generally cost
performance so for short term pins it is not desirable... Otherwise I agree
that conceptually it would make some sence although I'm not sure some
places wouldn't get confused by e.g. page cache pages not being on LRU
list. 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
