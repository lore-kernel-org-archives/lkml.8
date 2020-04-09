Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025A2C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5594206A1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 16:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p0OcSIw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgDIQta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 12:49:30 -0400
Received: from merlin.infradead.org ([205.233.59.134]:44984 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgDIQt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xocqm6JWSbmmM8dHA1f1gMmAbr9ZW0sDeohLR0sk8SU=; b=p0OcSIw9KstNGXW3Mh+JYEwRi9
        FHVoQbZMHOFI8I1ohs3PQqYRifTwx+Jvwt+T7qoaNt2SpOq3aTAWp0lWLuq73kx8F5sctTbAJOhFU
        +keuuk68TTvyV7em7UDWYXItjFob3FvCiWH6efS+MyHF4BCUBw7H1Gua5o12YJfCE0+WFMRLmf8OI
        XaY7Uj8InB9DJ8swjTnBPMcUKVXCftQ88rS/XBeosaiAGJoDQwb4J8/MzdlPB2N+vmFTpeNsn4LyI
        8kbYrUq1Y3TrymND8nAybeHeMkbKWZ21ldabJWClAFZGi7apSBcEPrYOqdkJQJUsKUuh+trfeTkG5
        gc6wK3tg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMaMl-0004Er-25; Thu, 09 Apr 2020 16:49:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB64C300B38;
        Thu,  9 Apr 2020 18:49:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C63852BA1D82B; Thu,  9 Apr 2020 18:49:19 +0200 (CEST)
Date:   Thu, 9 Apr 2020 18:49:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Cgroup memory barrier usage and call frequency from scheduler
Message-ID: <20200409164919.GF20713@hirez.programming.kicks-ass.net>
References: <20200409154413.GK3818@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409154413.GK3818@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 04:44:13PM +0100, Mel Gorman wrote:

> For 1, the use of a full barrier seems unnecessary when it appears that
> you could have used a read barrier and a write barrier. The following
> patch drops the profile overhead to 0.1%

Yikes. And why still .1% the below should be a barrier() on x86. Is the
compiler so contrained by that?

> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index ca19b4c8acf5..bc3125949b4b 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -36,7 +36,7 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
>  	 * Paired with the one in cgroup_rstat_cpu_pop_upated().  Either we
>  	 * see NULL updated_next or they see our updated stat.
>  	 */
> -	smp_mb();
> +	smp_rmb();
>  
>  	/*
>  	 * Because @parent's updated_children is terminated with @parent
> @@ -139,7 +139,7 @@ static struct cgroup *cgroup_rstat_cpu_pop_updated(struct cgroup *pos,
>  		 * Either they see NULL updated_next or we see their
>  		 * updated stat.
>  		 */
> -		smp_mb();
> +		smp_wmb();
>  
>  		return pos;
>  	}
