Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91A3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 10:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC04206DA
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 10:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E/y/4XcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgDLKM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 06:12:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgDLKM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 06:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IeLMEVbvWVML8LPWQwzHP2rI+YsS4LJFQqPobAoE0tQ=; b=E/y/4XcDknSVI1zx7tOO8lIIH1
        tl+TJApQwjBaxjL9NVH82By12JnXxz1NeXwbGJgfGWRqbY9GqCGHl/VPjaHWEhBs/gwpdJshy8skB
        UG/rF9MyMoCncohfY5JBnVgKdViPNk09ol9DW9H00aEfGgKiMdelCVE7zFrERgTQ22s1c4du6XB5k
        Ahn0YXtnOnEc3a6PtATx/zbeseBzE+o/sd824d8rvTKdifPsE9qc+1tg7YmbyCCbpWqRU0LSQnj9V
        JE3uSTNRYbnnO+l1LpGY6lBx/PDxtxsBSRNwRz45iuqpaCHr3jsXRM6aanKaLVf7ddBrSMYlElgyK
        Uhu7b25g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jNZbD-0002RV-Uv; Sun, 12 Apr 2020 10:12:23 +0000
Date:   Sun, 12 Apr 2020 03:12:23 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 4/4] mm: Add PG_zero support
Message-ID: <20200412101223.GK21484@bombadil.infradead.org>
References: <20200412090945.GA19582@open-light-1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200412090945.GA19582@open-light-1.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 05:09:49AM -0400, liliangleo wrote:
> Zero out the page content usually happens when allocating pages,
> this is a time consuming operation, it makes pin and mlock
> operation very slowly, especially for a large batch of memory.
> 
> This patch introduce a new feature for zero out pages before page
> allocation, it can help to speed up page allocation.
> 
> The idea is very simple, zero out free pages when the system is
> not busy and mark the page with PG_zero, when allocating a page,
> if the page need to be filled with zero, check the flag in the
> struct page, if it's marked as PG_zero, zero out can be skipped,
> it can save cpu time and speed up page allocation.

We are very short on bits in the page flags.  If we can implement this
feature without using another one, this would be good.

If the bit is only set on pages which are PageBuddy(), we can definitely
find space for it as an alias of another bit.
