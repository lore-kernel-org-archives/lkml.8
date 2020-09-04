Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDC6C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 04:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9DF206CA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 04:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599192665;
	bh=atSQ1o94B/mGNkpCk9TKMEzNNhHtnGV27b0zlomMdaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vVkPjQYSaZgCahDBAuNaN+ZP6KpGP8APPNaGE+A/4Eu4ZBrjT8qiVthXZ073uhNSA
	 jmZIrlVsQrTzKeFGKsz28LKRqpHhduo8WfiDlHT5SUDRZ3lBiKeeVxm39g6RL87ydj
	 6LBiSq+VZHmvzQokjI/ynhmABv2+0wR1KuUXWidM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgIDELD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 00:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgIDELB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 00:11:01 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64FEB206CA;
        Fri,  4 Sep 2020 04:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599192660;
        bh=atSQ1o94B/mGNkpCk9TKMEzNNhHtnGV27b0zlomMdaw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LmRE7aS3pA2ZJRm7NWj+alJW+v+FXw2FQByZDOcuw08XdnOhI4cN0nOzbM0c9JiZT
         +R1D6h0SlX3FksGomoe2dNEWxWDSOvrgXJvZqzt+bdsiLX87x0WXfbwmdp7ypkj7+R
         inY6QqYpkDXkGm0pKb/Ojm5uhOMxxsirxRnvQ8x4=
Date:   Thu, 3 Sep 2020 21:10:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, =Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: workingset: ignore slab memory size when
 calculating shadows pressure
Message-Id: <20200903211059.7dc9530e6d988eaeefe53cf7@linux-foundation.org>
In-Reply-To: <20200903230055.1245058-1-guro@fb.com>
References: <20200903230055.1245058-1-guro@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Sep 2020 16:00:55 -0700 Roman Gushchin <guro@fb.com> wrote:

> In the memcg case count_shadow_nodes() sums the number of pages in lru
> lists and the amount of slab memory (reclaimable and non-reclaimable)
> as a baseline for the allowed number of shadow entries.
> 
> It seems to be a good analogy for the !memcg case, where
> node_present_pages() is used. However, it's not quite true, as there
> two problems:
> 
> 1) Due to slab reparenting introduced by commit fb2f2b0adb98 ("mm:
> memcg/slab: reparent memcg kmem_caches on cgroup removal") local
> per-lruvec slab counters might be inaccurate on non-leaf levels.
> It's the only place where local slab counters are used.
> 
> 2) Shadow nodes by themselves are backed by slabs. So there is a loop
> dependency: the more shadow entries are there, the less pressure the
> kernel applies to reclaim them.
> 
> Fortunately, there is a simple way to solve both problems: slab
> counters shouldn't be taken into the account by count_shadow_nodes().
> 
> ...
>
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -495,10 +495,6 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
>  		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
>  			pages += lruvec_page_state_local(lruvec,
>  							 NR_LRU_BASE + i);
> -		pages += lruvec_page_state_local(
> -			lruvec, NR_SLAB_RECLAIMABLE_B) >> PAGE_SHIFT;
> -		pages += lruvec_page_state_local(
> -			lruvec, NR_SLAB_UNRECLAIMABLE_B) >> PAGE_SHIFT;
>  	} else
>  #endif
>  		pages = node_present_pages(sc->nid);

Did this have any observable runtime effects?
