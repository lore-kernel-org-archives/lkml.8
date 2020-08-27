Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF7EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3504F22CAE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H+uXV9mP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgH0Mp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgH0M05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:26:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5928C061234
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WR0JbwYpcKbUOXFKigJtskF/5Rf4W2AfrlUuN1W+bsM=; b=H+uXV9mPRYjsGIq94MPTzLDOHg
        AhABlz1ms+kupgpq6eu6blxwpVJHiBxNdDdF7DDdfGVnbfURALdJc0roZONNxy7U0tFsG6mtyFbDv
        tJZQoIFzewHaBFfia7THTczhceUNnACC2J88y+Hct9uiQ/Jhp549tEpYeW1hHjLcteIdX6E3jp2k6
        Ze/qeVOM+252nE2Tl6kvMsuEAOHf9mjTjPShX8wnLqHLDbtVG5p1RG1P27Sg8IWYJfUBtisxYr3WQ
        YLMqfxxlm9x43PkLVQYD6UpYWveA+A3c7ZVI20iEk4D/XJ9xekJIQMtfCOznX9Gzf9hr0s9I+QTvR
        VGdXosvQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBGt9-0001qR-2P; Thu, 27 Aug 2020 12:20:19 +0000
Date:   Thu, 27 Aug 2020 13:20:19 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill@shutemov.name,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Race between freeing and waking page
Message-ID: <20200827122019.GC14765@casper.infradead.org>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
 <alpine.LSU.2.11.2008241231460.1065@eggly.anvils>
 <alpine.LSU.2.11.2008262301240.4405@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2008262301240.4405@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:01:00AM -0700, Hugh Dickins wrote:
> It was a crash from checking PageWaiters on a Tail in wake_up_page(),
> called from end_page_writeback(), from ext4_finish_bio(): yet the
> page a tail of a shmem huge page.  Linus's wake_up_page_bit() changes?
> No, I don't think so.  It seems to me that once end_page_writeback()
> has done its test_clear_page_writeback(), it has no further hold on
> the struct page, which could be reused as part of a compound page
> by the time of wake_up_page()'s PageWaiters check.  But I probably
> need to muse on that for longer.

I think you're right.  Example:

truncate_inode_pages_range()
pagevec_lookup_entries()
lock_page()

--- ctx switch ---

ext4_finish_bio()
end_page_writeback()
test_clear_page_writeback()

--- ctx switch ---

wait_on_page_writeback() <- noop
truncate_inode_page()
unlock_page()
pagevec_release()

... page can now be allocated

--- ctx switch ---

wake_up_page()
PageWaiters then has that check for PageTail.

This isn't unique to ext4; the iomap completion path behaves the exact
same way.  The thing is, this is a harmless race.  It seems unnecessary
for anybody here to incur the overhead of adding a page ref to be sure
the page isn't reallocated.  We don't want to wake up the waiters before
clearing the bit in question.

I'm tempted to suggest this:

 static void wake_up_page(struct page *page, int bit)
 {
-       if (!PageWaiters(page))
+       if (PageTail(page) || !PageWaiters(page))
                return;
        wake_up_page_bit(page, bit);

which only adds an extra read to the struct page that we were going to
access anyway.  Even that seems unnecessary though; PageWaiters is
going to be clear.  Maybe we can just change the PF policy from
PF_ONLY_HEAD to PF_ANY.  I don't think it's critical that we have this
check.

Nick?
