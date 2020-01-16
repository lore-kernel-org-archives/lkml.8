Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDA7C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4EE2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lq3Y9xB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgAPKog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 05:44:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53966 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgAPKof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:44:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ffWMRa7YOLneyqHMaGbNXGH6RxbN38wir+be0Sv7y+M=; b=Lq3Y9xB2Bd3Kp0n5zU+KNjt79
        1pVaBXT0TaiUL2y5oVTgLjkGXT33LJ3TjzWJBbx4rX9CInv2x7xh6NaRD7+BvLU4+6eR7lb+n7P7h
        8np2HdOARffxBBj8KpDbIk+8HqytN0g38rM+ikcUvNGtBqhAmnJNcXQe/UDZWU96MXhmzcG/wtRiu
        9QlLP5g7HH+JNrHAdbMtd/sGQvGX+5wdiMthZ+HDLRGCD4jDYLqfHWbO4Roqb3h3IC3us4AJSCcOp
        yG0YaSEtDkZT+4D8Bg3GvwtcmJnKtBU+3JZTnesBWgk5+KHl79vHPTkGFZu/WeArd44j+t3ibIMP1
        lWaSbItOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1is2da-00010V-S1; Thu, 16 Jan 2020 10:44:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C257A304BDF;
        Thu, 16 Jan 2020 11:42:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66AA8203D72A2; Thu, 16 Jan 2020 11:44:28 +0100 (CET)
Date:   Thu, 16 Jan 2020 11:44:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        prime.zeng@hisilicon.com, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, mingo@kernel.org
Subject: Re: [PATCH] sched/topology: Assert non-NUMA topology masks don't
 (partially) overlap
Message-ID: <20200116104428.GP2827@hirez.programming.kicks-ass.net>
References: <20200115160915.22575-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115160915.22575-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 04:09:15PM +0000, Valentin Schneider wrote:
> A "less intrusive" alternative is to assert the sd->groups list doesn't get
> re-written, which is a symptom of such bogus topologies. I've briefly
> tested this, you can have a look at it here:
> 
>   http://www.linux-arm.org/git?p=linux-vs.git;a=commit;h=e0ead72137332cbd3d69c9055ab29e6ffae5b37b

Something like that might still make sense. Can't never be too careful,
right ;-)

>  kernel/sched/topology.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 6ec1e595b1d4..dfb64c08a407 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1879,6 +1879,42 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
>  	return sd;
>  }
>  
> +/*
> + * Ensure topology masks are sane, i.e. there are no conflicts (overlaps) for
> + * any two given CPUs at this (non-NUMA) topology level.
> + */
> +static bool topology_span_sane(struct sched_domain_topology_level *tl,
> +			      const struct cpumask *cpu_map, int cpu)
> +{
> +	int i;
> +
> +	/* NUMA levels are allowed to overlap */
> +	if (tl->flags & SDTL_OVERLAP)
> +		return true;
> +
> +	/*
> +	 * Non-NUMA levels cannot partially overlap - they must be either
> +	 * completely equal or completely disjoint. Otherwise we can end up
> +	 * breaking the sched_group lists - i.e. a later get_group() pass
> +	 * breaks the linking done for an earlier span.
> +	 */
> +	for_each_cpu(i, cpu_map) {
> +		if (i == cpu)
> +			continue;
> +		/*
> +		 * We should 'and' all those masks with 'cpu_map' to exactly
> +		 * match the topology we're about to build, but that can only
> +		 * remove CPUs, which only lessens our ability to detect
> +		 * overlaps
> +		 */
> +		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
> +		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  /*
>   * Find the sched_domain_topology_level where all CPU capacities are visible
>   * for all CPUs.
> @@ -1975,6 +2011,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  				has_asym = true;
>  			}
>  
> +			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
> +				goto error;
> +
>  			sd = build_sched_domain(tl, cpu_map, attr, sd, dflags, i);
>  
>  			if (tl == sched_domain_topology)

This is O(nr_cpus), but then, that function already is, so I don't see a
problem with this.

I'll take it, thanks!
