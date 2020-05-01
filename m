Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60744C47256
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32ED2216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 22:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588373852;
	bh=LXBvB44SCeNdj+HATb89++1mLFiPdFO5sDwPGdqjuAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=r1CLNvMloX7wPzv60YPTUzqqOrWhegBzTgkpPHiIs1ya5vvnCT1UkoH8RX98wCgU4
	 6yM50DC7kA6GATWEdExRIs2rYVDReSMQBtf1bevcqmE9Y/qIN0j41xQk6fTjrh+aJz
	 57R/06QDs8QMs9jFEmS+IVDSAdF77aao1jsr5dvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgEAW5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 18:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAW5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 18:57:31 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47BA9206B8;
        Fri,  1 May 2020 22:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588373850;
        bh=LXBvB44SCeNdj+HATb89++1mLFiPdFO5sDwPGdqjuAU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DlknOgeXeqcbZa1OyVRl65XfKUT1u5FqObkKr7/qhywD2d/0whjATnUElZ1L4S3ay
         +aRbeywfmDA2mpCO3qyD9rztfbyGP0dZB99vFMkOddoW9KKqwu+U3J8KEuSAA1BvXS
         4NeZ9sLPOreeHinYU9kNjCYPmlkQLlDDJrJ6aqQM=
Date:   Fri, 1 May 2020 15:57:29 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Henry Willard <henry.willard@oracle.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm: Limit boost_watermark on small zones.
Message-Id: <20200501155729.a479c4b27f127d9aa866bd8e@linux-foundation.org>
In-Reply-To: <1588294148-6586-1-git-send-email-henry.willard@oracle.com>
References: <1588294148-6586-1-git-send-email-henry.willard@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 17:49:08 -0700 Henry Willard <henry.willard@oracle.com> wrote:

> Commit 1c30844d2dfe ("mm: reclaim small amounts of memory when an external
> fragmentation event occurs") adds a boost_watermark() function which
> increases the min watermark in a zone by at least pageblock_nr_pages or
> the number of pages in a page block. On Arm64, with 64K pages and 512M
> huge pages, this is 8192 pages or 512M. It does this regardless of the
> number of managed pages managed in the zone or the likelihood of success.
> This can put the zone immediately under water in terms of allocating pages
> from the zone, and can cause a small machine to fail immediately due to
> OoM. Unlike set_recommended_min_free_kbytes(), which substantially
> increases min_free_kbytes and is tied to THP, boost_watermark() can be
> called even if THP is not active. The problem is most likely to appear
> on architectures such as Arm64 where pageblock_nr_pages is very large.
> 
> It is desirable to run the kdump capture kernel in as small a space as
> possible to avoid wasting memory. In some architectures, such as Arm64,
> there are restrictions on where the capture kernel can run, and therefore,
> the space available. A capture kernel running in 768M can fail due to OoM
> immediately after boost_watermark() sets the min in zone DMA32, where
> most of the memory is, to 512M. It fails even though there is over 500M of
> free memory. With boost_watermark() suppressed, the capture kernel can run
> successfully in 448M.
> 
> This patch limits boost_watermark() to boosting a zone's min watermark only
> when there are enough pages that the boost will produce positive results.
> In this case that is estimated to be four times as many pages as
> pageblock_nr_pages.
> 

Let's Cc Mel.

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2400,6 +2400,14 @@ static inline void boost_watermark(struct zone *zone)
>  
>  	if (!watermark_boost_factor)
>  		return;
> +	/*
> +	 * Don't bother in zones that are unlikely to produce results.
> +	 * On small machines, including kdump capture kernels running
> +	 * in a small area, boosting the watermark can cause an out of
> +	 * memory situation immediately.
> +	 */
> +	if ((pageblock_nr_pages * 4) > zone_managed_pages(zone))
> +		return;
>  
>  	max_boost = mult_frac(zone->_watermark[WMARK_HIGH],
>  			watermark_boost_factor, 10000);
> -- 
> 1.8.3.1
