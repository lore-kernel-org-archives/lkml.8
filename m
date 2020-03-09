Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24A4C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C0E24655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583796455;
	bh=17h8a4N6kANiR6E29lK3wwgr86T1/bnJ7Vwdl/7eM7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pKzxvvx7dMPiQnuHJgmzU8UheMcYv8d+/jXM3U+f8JVy1kwx32hFubU/tKgGLE6Nm
	 ROzerGGQ7MEbxIWPhAtqLuNKy8FTg8VKN8NRmpybkB3YqIESF32Y4l6pEzum6GMBNd
	 8py8Nlpl066IIxzq59qKTSdjb6crB7MeyuFVpHzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgCIX1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 19:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbgCIX1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 19:27:34 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915232253D;
        Mon,  9 Mar 2020 23:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583796453;
        bh=17h8a4N6kANiR6E29lK3wwgr86T1/bnJ7Vwdl/7eM7A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nMmVyVnPb7lDl5gONl001Z4fN5F5qqZ80XrozF+A47QUpLkUcaQVbSXpCAC7gbp7B
         UTVbi5CrgsY9RN1WwtaeIgwAgMJ38/UbRstMsC+2QC7H680PbwAXOUIfOJZQTmLI8U
         xmV1M1W8Dq1wMbtatvZGKrIDI61Wfslb2OfvcvB4=
Date:   Mon, 9 Mar 2020 16:27:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-Id: <20200309162733.3e5488f0410bffd9a9461330@linux-foundation.org>
In-Reply-To: <20200309223216.1974290-1-guro@fb.com>
References: <20200309223216.1974290-1-guro@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Mar 2020 15:32:16 -0700 Roman Gushchin <guro@fb.com> wrote:

> Commit 944d9fec8d7a ("hugetlb: add support for gigantic page allocation
> at runtime") has added the run-time allocation of gigantic pages. However
> it actually works only at early stages of the system loading, when
> the majority of memory is free. After some time the memory gets
> fragmented by non-movable pages, so the chances to find a contiguous
> 1 GB block are getting close to zero. Even dropping caches manually
> doesn't help a lot.
> 
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
> Only x86 is covered by this patch, but it's trivial to extend it to
> cover other architectures as well.
> 

Sounds promising.

I'm not seeing any dependencies on CONFIG_CMA in there.  Does the code
actually compile if CONFIG_CMA=n?  If yes, then does it add unneeded
bloat?

