Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB67C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BEC246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dQAcQnm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgB1E07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 23:26:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47434 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbgB1E07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kreL7heGps3JbfLIts0FLNnvtArOFcr7qYt1z2FRj5U=; b=dQAcQnm5hKtXRL++8eUjEfM0UT
        3XWJYgpPsIwt6Yt6evJVGLYQk49iP+1VD01zQfPZU/G2fC166+OI1j0veUuAFEOiE5X6TvZbF6ApX
        tufOFW3vFytrauc9O7EzL76PJDmObN+eZQY9qYdPViKN0DdWtFho9qGdznDG/sL35Q+vmztA1iL8+
        y7S/PP4GU0dyLkMZy0N7qYySxU/rB58T1UeVvVhk0Li6Zlv5W4qaUB16JIRN/UfxPRwHDjB6GNun+
        +5eNiMOufQ0rbKhehA8PngUkXZ8r1eigi08h3/5je2hB0Y88nTHUjKoLJkZdtrenuUDpsVv5C0bFk
        +9NUK4cg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7XEc-0004yD-EJ; Fri, 28 Feb 2020 04:26:46 +0000
Date:   Thu, 27 Feb 2020 20:26:46 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] huge tmpfs: try to split_huge_page() when punching hole
Message-ID: <20200228042646.GF29971@bombadil.infradead.org>
References: <alpine.LSU.2.11.2002261959020.10801@eggly.anvils>
 <20200227084704.aolem5nktpricrzo@box>
 <alpine.LSU.2.11.2002271909250.2026@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2002271909250.2026@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 08:04:21PM -0800, Hugh Dickins wrote:
> It's good to consider the implications for hole-punch on a persistent
> filesystem cached with THPs (or lower order compound pages); but I
> disagree that they should behave differently from this patch.
> 
> The hole-punch is fundamentally directed at freeing up the storage, yes;
> but its page cache must also be removed, otherwise you have the user
> writing into cache which is not backed by storage, and potentially losing
> the data later.  So a hole must be punched in the compound page in that
> case too: in fact, it's then much more important that split_huge_page()
> succeeds - not obvious what the fallback should be if it fails (perhaps
> in that case the compound page must be kept, but all its pmds removed,
> and info on holes kept in spare fields of the compound page, to prevent
> writes and write faults without calling back into the filesystem:
> soluble, but more work than tmpfs needs today)(and perhaps when that
> extra work is done, we would choose to rely on it rather than
> immediately splitting; but it will involve discounting the holes).

Ooh, a topic that reasonable people can disagree on!

The current prototype I have will allocate (huge) pages and then
ask the filesystem to fill them.  The filesystem may well find that
the extent is a hole, and if it is, it will fill the page with zeroes.
Then, the application may write to those pages, and if it does, the
filesystem will be notified to create an on-disk extent for that write.

I haven't looked at the hole-punch path in detail, but presumably it
notifies the filesystem to create a hole extent and zeroes out the
pagecache for that range (possibly by removing entire pages, and with
memset for partial pages).  Then a subsequent write to the hole will
cause the filesystem to allocate a new non-hole extent, just like the
previous case.

I think it's reasonable for the page cache to interpret a hole-punch
request as being a hint that the hole is unlikely to be accessed again,
so allocating new smaller pages for that region of the file (or just
writing back & dropping the covering page altogether) would seem like
a reasonable implementation decision.

However, it also seems reasonable that just memset() of the affected
region and leaving the page intact would also be an acceptable
implementation.  As long as writes to the newly-created hole cause the
page to become dirtied and thus writeback to be in effect.  It probably
wouldn't be as good an implementation, but it shouldn't lose writes as
you suggest above.

I'm not sure I'd choose to split a large page into smaller pages.  I think
I'd prefer to allocate lower-order pages and memcpy() the data over.
Again, that's an implementation choice, and not something that should
be visible outside the implementation.

[1] http://git.infradead.org/users/willy/linux-dax.git/shortlog/refs/heads/xarray-pagecache
