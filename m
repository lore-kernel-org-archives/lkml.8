Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0D6C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B189C20656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RHw28AD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbgDNN5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388403AbgDNN5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:57:02 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA95C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 06:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WC37s8Ht6QqNkYbP3999BQxifTQpC/YXEFzgVPBIVaw=; b=RHw28AD5hjh4UjulH+lgH603fP
        G2UEzbi5TCHeEhyNWyF1X9N+Ib8G2fEI4g9sedmhOgabjmnIrR7OTDJDvuBLi4Veu3gk7fX4L8Zw2
        qV60gzlPhpQ1MD1DDKIx9+8ie+7NtQzXmB9xqoV7BuWifJnPUtev5KJ0hFTOJkySL40UltMpns67e
        qLDYnwbo2ErJtUvGYk2ELo0JUCSMJgHXOYX4WPFbTk2CVUXYhkZPssHhr1KqijRG28o7fkVHdc2u+
        aKV54y2c+nguzj+bu/ScxHGeF7B7QLVSNWYj6y/OpgXnNB9mXZMy1N68RgawNIHzp+XV0N+gpalsu
        05+cgW1w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOM39-0000yX-J1; Tue, 14 Apr 2020 13:56:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4401E300483;
        Tue, 14 Apr 2020 15:56:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 06E7B2B663BAF; Tue, 14 Apr 2020 15:56:25 +0200 (CEST)
Date:   Tue, 14 Apr 2020 15:56:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     vpillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        Aaron Lu <ziqian.lzq@antfin.com>
Subject: Re: [RFC PATCH 09/13] sched/fair: core wide vruntime comparison
Message-ID: <20200414135624.GU20730@hirez.programming.kicks-ass.net>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <2f83d888890cec14be3a7aead0859dceebb4012f.1583332765.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f83d888890cec14be3a7aead0859dceebb4012f.1583332765.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 04:59:59PM +0000, vpillai wrote:
> From: Aaron Lu <aaron.lu@linux.alibaba.com>
> 
> This patch provides a vruntime based way to compare two cfs task's
> priority, be it on the same cpu or different threads of the same core.
> 
> When the two tasks are on the same CPU, we just need to find a common
> cfs_rq both sched_entities are on and then do the comparison.
> 
> When the two tasks are on differen threads of the same core, the root
> level sched_entities to which the two tasks belong will be used to do
> the comparison.
> 
> An ugly illustration for the cross CPU case:
> 
>    cpu0         cpu1
>  /   |  \     /   |  \
> se1 se2 se3  se4 se5 se6
>     /  \            /   \
>   se21 se22       se61  se62
> 
> Assume CPU0 and CPU1 are smt siblings and task A's se is se21 while
> task B's se is se61. To compare priority of task A and B, we compare
> priority of se2 and se6. Whose vruntime is smaller, who wins.
> 
> To make this work, the root level se should have a common cfs_rq min
> vuntime, which I call it the core cfs_rq min vruntime.
> 
> When we adjust the min_vruntime of rq->core, we need to propgate
> that down the tree so as to not cause starvation of existing tasks
> based on previous vruntime.

You forgot the time complexity analysis.


> +static void coresched_adjust_vruntime(struct cfs_rq *cfs_rq, u64 delta)
> +{
> +	struct sched_entity *se, *next;
> +
> +	if (!cfs_rq)
> +		return;
> +
> +	cfs_rq->min_vruntime -= delta;
> +	rbtree_postorder_for_each_entry_safe(se, next,
> +			&cfs_rq->tasks_timeline.rb_root, run_node) {

Which per this ^

> +		if (se->vruntime > delta)
> +			se->vruntime -= delta;
> +		if (se->my_q)
> +			coresched_adjust_vruntime(se->my_q, delta);
> +	}
> +}

> @@ -511,6 +607,7 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
>  
>  	/* ensure we never gain time by being placed backwards. */
>  	cfs_rq->min_vruntime = max_vruntime(cfs_rq_min_vruntime(cfs_rq), vruntime);
> +	update_core_cfs_rq_min_vruntime(cfs_rq);
>  #ifndef CONFIG_64BIT
>  	smp_wmb();
>  	cfs_rq->min_vruntime_copy = cfs_rq->min_vruntime;

as called from here, is exceedingly important.

Worse, I don't think our post-order iteration is even O(n).


All of this is exceedingly yuck.
