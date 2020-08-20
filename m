Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8186EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F124207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="bqapqgbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbgHTRhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbgHTRhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:37:03 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BFBC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:37:03 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x12so1799273qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LoboofYleSqsx6Po76z6KtFKykk6O4/M/law9ADONhQ=;
        b=bqapqgbGxSqIpTZ9lqM1OdRQ4ld0i+GkD+9Nmxa1GUtaiBn/O9VbQypsMHolHj0z6R
         O5BVPWUTxs1lPqRKqLIHUGDCBJLiJ4iTA7HIC6qB9jSaJjvKbm8SI/1kvGieeG0doLWJ
         OCDi+LYKIfxOKRk0/y7qOPc8DpMwu+WU3vD+l8KIvb21LNwGFGLgzaQthypuZUWvs+rs
         oJCpu+HfrIXROzi0WhrBWx4WpDDfRvE0lUwTcbI+9/X0czS0xt7v14LrRI0jg5MRRTp/
         LBDfwgBeTz7UfF8zOvwgvyF3yu6ue4PzybmMEWhEHmy34YliUAVBRRucg//JTWS0mIdc
         WDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LoboofYleSqsx6Po76z6KtFKykk6O4/M/law9ADONhQ=;
        b=Zr53uYGofj71/+DY5++AfU7O5nJaZ/l9E/yVa3H6bkPAFLbMNdlZvrEex+ocw5Jo67
         Y1fyEX2a9DKv6ZWt1S7hVVJO4HXubfzZyL4cCqoyFZudjf7Da5Ac8oG609cTr7yCT3NQ
         8mGHfzBsWX+MME58n1hqscdAEwL2bw/zoD1yrMIUzNKYow0bWto9IS+FEMvT80l2PSaV
         gwJdpycizuOAgsK0e7cABR5Z8rOG5SdJnpQQpL4arZ9pCwEOSC8nOm7v4YahwzLkAcvZ
         E+McRjrLqcHcrC7MDVXnkmAJ4o4b3Nt4q8i9CIOCImci2/anI7ZcqarcLo38SfhFrfRY
         Fg2Q==
X-Gm-Message-State: AOAM532ECipM38VZUlYK2E6bQgRyYoaDF9k8jowHhlZNre9Pt+u0QFxp
        zfJ6J5Iq8Opj8/vQdv4ehVpLsw==
X-Google-Smtp-Source: ABdhPJy0N3AzU+bC9wgIjMRXMwdsW3NNSoeyvr6MWRhCLnEfbQNcRW8bcmUt5YL0OIu+rlUywXSVzA==
X-Received: by 2002:ac8:c0e:: with SMTP id k14mr3885478qti.364.1597945021939;
        Thu, 20 Aug 2020 10:37:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:3cdd])
        by smtp.gmail.com with ESMTPSA id k11sm2653665qkk.93.2020.08.20.10.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 10:37:01 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:35:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH 2/3] mm/memcg: Simplify mem_cgroup_get_max()
Message-ID: <20200820173546.GB912520@cmpxchg.org>
References: <20200820130350.3211-1-longman@redhat.com>
 <20200820130350.3211-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820130350.3211-3-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 09:03:49AM -0400, Waiman Long wrote:
> The mem_cgroup_get_max() function used to get memory+swap max from
> both the v1 memsw and v2 memory+swap page counters & return the maximum
> of these 2 values. This is redundant and it is more efficient to just
> get either the v1 or the v2 values depending on which one is currently
> in use.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memcontrol.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 26b7a48d3afb..d219dca5239f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1633,17 +1633,13 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
>   */
>  unsigned long mem_cgroup_get_max(struct mem_cgroup *memcg)
>  {
> -	unsigned long max;
> +	unsigned long max = READ_ONCE(memcg->memory.max);
>  
> -	max = READ_ONCE(memcg->memory.max);
>  	if (mem_cgroup_swappiness(memcg)) {
> -		unsigned long memsw_max;
> -		unsigned long swap_max;
> -
> -		memsw_max = memcg->memsw.max;
> -		swap_max = READ_ONCE(memcg->swap.max);
> -		swap_max = min(swap_max, (unsigned long)total_swap_pages);
> -		max = min(max + swap_max, memsw_max);
> +		if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +			max += READ_ONCE(memcg->swap.max);
> +		else
> +			max = memcg->memsw.max;

I agree with the premise of the patch, but v1 and v2 have sufficiently
different logic, and the way v1 overrides max from the innermost
branch again also doesn't help in understanding what's going on.

Can you please split out the v1 and v2 code?

	if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
		max = READ_ONCE(memcg->memory.max);
		if (mem_cgroup_swappiness(memcg))
			max += READ_ONCE(memcg->swap.max);
	} else {
		if (mem_cgroup_swappiness(memcg))
			max = memcg->memsw.max;
		else
			max = READ_ONCE(memcg->memory.max);
	}

It's slightly repetitive, but IMO much more readable.
