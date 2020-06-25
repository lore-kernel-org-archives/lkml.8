Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C42C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB1120781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404201AbgFYLY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:24:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:55444 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404042AbgFYLY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:24:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7CB1AD60;
        Thu, 25 Jun 2020 11:24:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AB4511E1274; Thu, 25 Jun 2020 13:24:55 +0200 (CEST)
Date:   Thu, 25 Jun 2020 13:24:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Chris Wilson <chris@chris-wilson.co.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm: Skip opportunistic reclaim for dma pinned pages
Message-ID: <20200625112455.GC17788@quack2.suse.cz>
References: <20200624191417.16735-1-chris@chris-wilson.co.uk>
 <20200624192116.GO6578@ziepe.ca>
 <44708b2e-479f-7d58-fe01-29cfd6c70bdb@nvidia.com>
 <20200624232047.GP6578@ziepe.ca>
 <887ac706-65f0-3089-b51b-47aabf7d3847@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <887ac706-65f0-3089-b51b-47aabf7d3847@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-06-20 17:11:30, John Hubbard wrote:
> On 2020-06-24 16:20, Jason Gunthorpe wrote:
> > > I do like this code change, though. And I *think* it's actually safe to
> > > do this, as it stays away from writeback or other filesystem activity.
> > > But let me double check that, in case I'm forgetting something.
> 
> ...OK, I've checked, and I like it a little bit less now. Mainly for
> structural reasons, though. I think it would work correctly. But
> here's a concern: try_to_unmap() should only fail to unmap if there is a
> reason to not unmap. Having a page be pinned for dma is a reason to not
> *free* a page, and it's also a reason to be careful about writeback and
> page buffers for writeback and such. But I'm not sure that it's a reason
> to fail to remove mappings.
> 
> True, most (all?) of the reasons that we remove mappings, generally are
> for things that are not allowed while a page is dma-pinned...at least,
> today. But still, there's nothing fundamental about a mapping that
> should prevent it from coming or going while a page is undergoing
> dma.
> 
> So, it's merely a convenient, now-misnamed location in the call stack
> to fail out. That's not great. It might be better, as Jason hints at
> below, to fail out a little earlier, instead. That would lead to a more
> places to call page_maybe_dma_pinned(), but that's not a real problem,
> because it's still a small number of places.

Agreed, I think that shrink_page_list() as Michal writes is a better place
for the page_may_be_dma_pinned() check. But other than that I agree it is
good to avoid all the unnecessary work of preparing a page for reclaim when
we can now check there's no hope of reclaiming it (at this time).

> > I don't know, but could it be that try_to_unmap() has to be done
> > before checking the refcount as each mapping is included in the
> > refcount? ie we couldn't know a DMA pin was active in advance?
> > 
> > Now that we have your pin stuff we can detect a DMA pin without doing
> > all the unmaps?
> > 
> 
> Once something calls pin_user_page*(), then the pages will be marked
> as dma-pinned, yes. So no, there is no need to wait until try_to_unmap()
> to find out.

Yeah, I'm pretty sure the page ref check happens so late because earlier it
was impossible to tell whether there are "external" page references reclaim
cannot get rid of - filesystem may (but need not!) hold a page reference
for its private data, page tables will hold references as well, etc. Now
with page_may_be_dma_pinned() we can detect at least one class of external
references (i.e. pins) early so it's stupid not to do that.

> A final note: depending on where page_maybe_dma_pinned() ends up
> getting called, this might prevent a fair number of the problems that
> Jan originally reported [1], and that I also reported separately!
> 
> Well, not all of the problems, and only after the filesystems get
> converted to call pin_user_pages() (working on that next), but...I think
> it would actually avoid the crash our customer reported back in early
> 2018. Even though we don't have the full file lease + pin_user_pages()
> solution in place.
> 
> That's because reclaim is what triggers the problems that we saw. And
> with this patch, we bail out of reclaim early.

I agree that with this change, some races will become much less likely for
some usecases. But as you say, it's not a full solution.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
