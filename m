Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6DDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB7B8206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KFcAIY1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgENPcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgENPcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:32:20 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E1AC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1cSvhK8O6Y1n8UvHPL/hV8GEcpVw1UnNKShoq4OCCMQ=; b=KFcAIY1hLtd1dBLMmGlV3IzO0h
        5nf4UiioMsA3zEzRwI+WUb0DS+8vT52ZtfXLwPuxezSzd3igi8stoyAmZumxgwXRtYRNjlqrM2DjV
        jGSavQld2fQ7Y8xy3rLX780lIosG35eG72fa3QTyvJrDI31SfuJRLM8+ipnvvh4atYy2g0m9GBrT6
        tpWdhbxEM5IMdbsp/2bEMwcAwajjuAKMO9UhhMBWIIhWiWHM5tlByvArQ4gHYx+9p1GmREqjV1ltB
        wE8D9JZ40lAuFtPOiu4+c85ItdGTvsW2DdmAh3irxtL2eNwN+fDmhnEH5r2Q171wGfUNrgYlCX+L7
        UXCMIPBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZFpU-0002t7-Rt; Thu, 14 May 2020 15:31:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 99FBE304DB2;
        Thu, 14 May 2020 17:31:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 859862B87A730; Thu, 14 May 2020 17:31:22 +0200 (CEST)
Date:   Thu, 14 May 2020 17:31:22 +0200
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
        Joe Mario <jmario@redhat.com>, Bill Gray <bgray@redhat.com>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200514153122.GE2978@hirez.programming.kicks-ass.net>
References: <20200320152251.GC3818@techsingularity.net>
 <CAE4VaGBGbTT8dqNyLWAwuiqL8E+3p1_SqP6XTTV71wNZMjc9Zg@mail.gmail.com>
 <20200320163843.GD3818@techsingularity.net>
 <CAE4VaGCf0P2ht+7nbGFHV8Dd=e4oDEUPNdRUUBokRWgKRxofAA@mail.gmail.com>
 <20200507155422.GD3758@techsingularity.net>
 <CAE4VaGCDTeE16nNmSS8fGzCBvHsO=qkJAW6yDiORAxgsPi-Ziw@mail.gmail.com>
 <20200508092212.GE3758@techsingularity.net>
 <CAE4VaGC_v6On-YvqdTwAWu3Mq4ofiV0pLov-QpV+QHr_SJr+Rw@mail.gmail.com>
 <CAE4VaGDQWPePtmtCZP=ROYW1KPxtPhGDrxqy2QbirHGJdwk4=w@mail.gmail.com>
 <20200513153023.GF3758@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513153023.GF3758@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 04:30:23PM +0100, Mel Gorman wrote:
> Complete shot in the dark but restore adjust_numa_imbalance() and try
> this
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1a9983da4408..0b31f4468d5b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2393,7 +2393,7 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
>  	struct rq_flags rf;
>  
>  #if defined(CONFIG_SMP)
> -	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
> +	if (sched_feat(TTWU_QUEUE)) {

just saying that this has the risk of regressing other workloads, see:

  518cd6234178 ("sched: Only queue remote wakeups when crossing cache boundaries")

>  		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
>  		ttwu_queue_remote(p, cpu, wake_flags);
>  		return;
> 
> -- 
> Mel Gorman
> SUSE Labs
