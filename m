Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA4CC2D0F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B3F2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585794358;
	bh=i5q9OjnSdrRHwgxVwFU2JlkrgmID6ZL3uOS6aN9W78I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KpoPqQl+sw66XPGHgBMvwjjk36P1QtjqHm2yi8/d/Gy05YMB18dtnIp9dG2KSXspy
	 26n2j5RHR3io5kksov4RqM08WV5ynqUMTpLHTIycjr/gHV5qZ1RUcbQp2cmpsq3jP1
	 tG5mnjk6OeAkEsnjDDIWCYMOlRmvSYSDk0imyvaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733298AbgDBCZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732435AbgDBCZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:25:56 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA22A20721;
        Thu,  2 Apr 2020 02:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585794354;
        bh=i5q9OjnSdrRHwgxVwFU2JlkrgmID6ZL3uOS6aN9W78I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aIYJ9Yng+1+VM9IynzqC9z9V+xxzvsPaltBvxSR0hx90jJ4DvSc07dS01cAUqcn2y
         GyxXx+zNWjPgSHdiN2uga1J/FI6fvlckkBjhSK2ddLHMZgeHGIrOYnDcO52Xj2mG5C
         9cu4eDSa8c7T3szXgTdSAujcK2diubnA4twiFmhA=
Date:   Wed, 1 Apr 2020 19:25:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v3] mm: hugetlb: optionally allocate gigantic hugepages
 using cma 65;5803;1c Commit 944d9fec8d7a
 ("hugetlb: add support for gigantic page allocation at runtime") has added
 the run-time allocation of gigantic pages. However it actually works only
 at early stages of the system loading, when the majority of memory is free.
 After some time the memory gets fragmented by non-movable pages, so the
 chances to find a contiguous 1 GB block are getting close to zero. Even
 dropping caches manually doesn't help a lot.
Message-Id: <20200401192553.7f437f150203a5fa044a1f75@linux-foundation.org>
In-Reply-To: <20200311220920.2487528-1-guro@fb.com>
References: <20200311220920.2487528-1-guro@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 15:09:20 -0700 Roman Gushchin <guro@fb.com> wrote:

> At large scale rebooting servers in order to allocate gigantic hugepages
> is quite expensive and complex. At the same time keeping some constant
> percentage of memory in reserved hugepages even if the workload isn't
> using it is a big waste: not all workloads can benefit from using 1 GB
> pages.
> 
> The following solution can solve the problem:
> 1) On boot time a dedicated cma area* is reserved. The size is passed
>    as a kernel argument.
> 2) Run-time allocations of gigantic hugepages are performed using the
>    cma allocator and the dedicated cma area
> 
> In this case gigantic hugepages can be allocated successfully with a
> high probability, however the memory isn't completely wasted if nobody
> is using 1GB hugepages: it can be used for pagecache, anon memory,
> THPs, etc.
> 
> * On a multi-node machine a per-node cma area is allocated on each node.
>   Following gigantic hugetlb allocation are using the first available
>   numa node if the mask isn't specified by a user.
> 
> Usage:
> 1) configure the kernel to allocate a cma area for hugetlb allocations:
>    pass hugetlb_cma=10G as a kernel argument
> 
> 2) allocate hugetlb pages as usual, e.g.
>    echo 10 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> 
> If the option isn't enabled or the allocation of the cma area failed,
> the current behavior of the system is preserved.
> 
> x86 and arm-64 are covered by this patch, other architectures can be
> trivially added later.

Lots of review input on v2, but then everyone went quiet ;)

Has everything been addressed?
