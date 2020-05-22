Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABE7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84901222B7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CVZmJGW0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgEVOjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:39:44 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60388 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729868AbgEVOjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q+wlQfoEZBNLKtuvrE+VsWClCngPETJs+hYOYiKjbhU=; b=CVZmJGW0vYxZD0dmWgAVrVlcC6
        OxTGfTA2htrPPwKStyJK8IPEdzI1eKFHUyoJO8Bb+p1/FvoRhqelkgnpZAgqacgVHT/1e5EiJmRkY
        BYhMjaEvOlUV0ifDXrX7NACw5hzlV2hpo67tvpLPAChsXJRVTxf4TIE5fahQBDnfx/+OBqG40r1U5
        hj+9OnRjUeECs+0rViU3e0Cnk+FNI4biae4psOBS6vk5jiLR2UGRzDA+iz4YTUfgOu6RAn5+ryjsD
        ilZ3naiuwM4eBylf9pT5lWpKo0Xhk/I2XF2I/HyTNEeiXxmG/vJarKf2xf+P8W1ZRyYVpPPHACAJa
        eJz2dDaQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jc8pE-0003Bp-KA; Fri, 22 May 2020 14:39:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E9AC53011E8;
        Fri, 22 May 2020 16:38:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B043620BDB12E; Fri, 22 May 2020 16:38:57 +0200 (CEST)
Date:   Fri, 22 May 2020 16:38:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Jirka Hladky <jhladky@redhat.com>, Phil Auld <pauld@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Douglas Shakshober <dshaks@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>,
        riel@surriel.com
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200522143857.GU317569@hirez.programming.kicks-ass.net>
References: <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net>
 <20200514153122.GE2978@hirez.programming.kicks-ass.net>
 <20200515084740.GJ3758@techsingularity.net>
 <20200515111732.GS2957@hirez.programming.kicks-ass.net>
 <20200515142444.GK3001@hirez.programming.kicks-ass.net>
 <20200521103816.GA7167@techsingularity.net>
 <20200521114132.GI325280@hirez.programming.kicks-ass.net>
 <20200522132854.GF7167@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522132854.GF7167@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 02:28:54PM +0100, Mel Gorman wrote:

> Is something like this on top of your patch what you had in mind?

All under the assumption that is makes it go faster of course ;-)

> ---8<---

static inline bool ttwu_queue_cond()
{
	/*
	 * If the CPU does not share cache, then queue the task on the
	 * remote rqs wakelist to avoid accessing remote data.
	 */
	if (!cpus_share_cache(smp_processor_id(), cpu))
		return true;

	/*
	 * If the task is descheduling and the only running task on the
	 * CPU, ....
	 */
	if ((wake_flags & WF_ON_RQ) && cpu_rq(cpu)->nr_running <= 1)
		return true;

	return false;
}

> -static bool ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
> +static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
>  {
> -	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
> -		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
> -		__ttwu_queue_remote(p, cpu, wake_flags);
> -		return true;
> +	if (sched_feat(TTWU_QUEUE)) {
> +		/*
> +		 * If CPU does not share cache then queue the task on the remote
> +		 * rqs wakelist to avoid accessing remote data. Alternatively,
> +		 * if the task is descheduling and the only running task on the
> +		 * CPU then use the wakelist to offload the task activation to
> +		 * the CPU that will soon be idle so the waker can continue.
> +		 * nr_running is checked to avoid unnecessary task stacking.
> +		 */
> +		if (!cpus_share_cache(smp_processor_id(), cpu) ||
> +		    ((wake_flags & WF_ON_RQ) && cpu_rq(cpu)->nr_running <= 1)) {
> +			sched_clock_cpu(cpu); /* Sync clocks across CPUs */
> +			__ttwu_queue_wakelist(p, cpu, wake_flags);
> +			return true;
> +		}

	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
		__ttwu_queue_remote(p, cpu, wake_flags);
		return true;

>  	}
>  
>  	return false;


might be easier to read...
