Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A99C4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 03:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F7324680
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 03:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582774786;
	bh=9Cffmdd0qW73kmajGjKfvODv6L7Gr3tpz2QX3jQxlFs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=J/0iw/XBIaNRrF8yVgx5eTfiUB6yCXGl9JHTSo6VNcE6/jz3TGcq3dQwDY+xYEbDU
	 9n3znRrEbeF6/G2NhebNBPxcUzY1vNjOkYUpl2ywcaUO2tjkY0U6cu2Y6DeWXdcjI3
	 KZimHafC8zgER52Do0BKZ637kKYVv4lVwfkWO9FY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgB0Djp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 22:39:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbgB0Djp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 22:39:45 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA2532467A;
        Thu, 27 Feb 2020 03:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582774784;
        bh=9Cffmdd0qW73kmajGjKfvODv6L7Gr3tpz2QX3jQxlFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XMatfAjFIhOlMtWJ/mHdt/ligz0Nban01KEtDur859vkq2xBkAVBxgCqyxRgurghc
         qWN2kXNPGUGVbqF4SBHpkPnkRN8ekg8/vcVgXlc/MdtfDwrbGSY9661RsbOCF32fee
         4yuJmjNrIfmxWSaggM2O2YPHlsfAZKOc4ihVFE6E=
Date:   Wed, 26 Feb 2020 19:39:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     js1304@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 0/9] workingset protection/detection on the anonymous
 LRU list
Message-Id: <20200226193942.30049da9c090b466bdc5ec23@linux-foundation.org>
In-Reply-To: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 14:11:44 +0900 js1304@gmail.com wrote:

> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Hello,
> 
> This patchset implements workingset protection and detection on
> the anonymous LRU list.

The test robot measurement got my attention!

http://lkml.kernel.org/r/20200227022905.GH6548@shao2-debian

> * Changes on v2
> - fix a critical bug that uses out of index lru list in
> workingset_refault()
> - fix a bug that reuses the rotate value for previous page
> 
> * SUBJECT
> workingset protection
> 
> * PROBLEM
> In current implementation, newly created or swap-in anonymous page is
> started on the active list. Growing the active list results in rebalancing
> active/inactive list so old pages on the active list are demoted to the
> inactive list. Hence, hot page on the active list isn't protected at all.
> 
> Following is an example of this situation.
> 
> Assume that 50 hot pages on active list and system can contain total
> 100 pages. Numbers denote the number of pages on active/inactive
> list (active | inactive). (h) stands for hot pages and (uo) stands for
> used-once pages.
> 
> 1. 50 hot pages on active list
> 50(h) | 0
> 
> 2. workload: 50 newly created (used-once) pages
> 50(uo) | 50(h)
> 
> 3. workload: another 50 newly created (used-once) pages
> 50(uo) | 50(uo), swap-out 50(h)
> 
> As we can see, hot pages are swapped-out and it would cause swap-in later.
> 
> * SOLUTION
> Since this is what we want to avoid, this patchset implements workingset
> protection. Like as the file LRU list, newly created or swap-in anonymous
> page is started on the inactive list. Also, like as the file LRU list,
> if enough reference happens, the page will be promoted. This simple
> modification changes the above example as following.

One wonders why on earth we weren't doing these things in the first
place?

> * SUBJECT
> workingset detection

It sounds like the above simple aging changes provide most of the
improvement, and that the workingset changes are less beneficial and a
bit more risky/speculative?

If so, would it be best for us to concentrate on the aging changes
first, let that settle in and spread out and then turn attention to the
workingset changes?

