Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D72DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 341E5246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 03:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PrwiOPtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbgB1Dmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 22:42:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:42104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbgB1Dmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 22:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SorkXSQyHVFqXiBzU6ChGVstv5nQC7vtybcab5vAzZQ=; b=PrwiOPtFyyIzy115nfdPW77hCd
        2pCQCdbsaNz9X9vQFk1rhdEqJvGggUmOXriIAnfF98EIVos5VDeNA2nc3wFuXld3G+xMV2AKkgRdy
        NrwQOFsxfdpv6vO/Y1zt3rRLxxqySeehc62tv5RGVf7sAIHtLXgJG59+csJ/OTYMP1NxEH+UvQ/al
        MhwPsy4gMb5m9s63zmXXddeEXHedXvMzLwJsboi0MlFEDVWSjHkmsMcN60Qy3LPqm7iqiGhN8ZNfI
        ApqtIiyf083m1Cxujpp4PM030y06HGwps8F8Km0ZSZ6EeIJ7D53Nk6O9hi0aNjXv3+uThGdivtHie
        HKCVdJdw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7WY4-0006gR-7A; Fri, 28 Feb 2020 03:42:48 +0000
Date:   Thu, 27 Feb 2020 19:42:48 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [RFC 0/3] mm: Discard lazily freed pages when migrating
Message-ID: <20200228034248.GE29971@bombadil.infradead.org>
References: <20200228033819.3857058-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228033819.3857058-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 11:38:16AM +0800, Huang, Ying wrote:
> MADV_FREE is a lazy free mechanism in Linux.  According to the manpage
> of mavise(2), the semantics of MADV_FREE is,
> 
>   The application no longer requires the pages in the range specified
>   by addr and len.  The kernel can thus free these pages, but the
>   freeing could be delayed until memory pressure occurs. ...
> 
> Originally, the pages freed lazily by MADV_FREE will only be freed
> really by page reclaiming when there is memory pressure or when
> unmapping the address range.  In addition to that, there's another
> opportunity to free these pages really, when we try to migrate them.
> 
> The main value to do that is to avoid to create the new memory
> pressure immediately if possible.  Instead, even if the pages are
> required again, they will be allocated gradually on demand.  That is,
> the memory will be allocated lazily when necessary.  This follows the
> common philosophy in the Linux kernel, allocate resources lazily on
> demand.

Do you have an example program which does this (and so benefits)?
If so, can you quantify the benefit at all?
