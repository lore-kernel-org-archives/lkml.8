Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75F1C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDDD2072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DWw9xsYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgAPPcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:32:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbgAPPcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=btpuE5el854pPVMkucdDwUyA1UK49wikjaZy8pvlJf4=; b=DWw9xsYlMFSmLwJKj2qIrn9uK
        oqaSMAq8l49S0Y1yqdy71gCjwLrXApec2DDqFP/XWpGQaiMsxx+5o9vzFhzhKWLkb9f9daBUaPkCD
        E1VG96ftncTg0dzK15FgO+A3YS1cUPwBLa7Uv9btkguS0mNI0bUOturzSNjIrWKzZqnew73TDgFzZ
        FJczEou0zZNa/u/gYcEJQuAJb4DC7WV76lppOGQu591MyIDyylMMRYNUCgjWLdyhiD5z2Af4Z4T5I
        lIiZ7VKM3XLI8MJaRop99NMpGNkOBIdS3ue29HA/SmRLDMVXLvnboBe1u7OzXX4+geQKdp+TNpFD3
        rb6pzU6MQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1is783-0006O7-BT; Thu, 16 Jan 2020 15:32:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C013302524;
        Thu, 16 Jan 2020 16:30:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C15792B6D7721; Thu, 16 Jan 2020 16:32:12 +0100 (CET)
Date:   Thu, 16 Jan 2020 16:32:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v3 1/8] locking/lockdep: Decrement irq context counters
 when removing lock chain
Message-ID: <20200116153212.GS2827@hirez.programming.kicks-ass.net>
References: <20200115214313.13253-1-longman@redhat.com>
 <20200115214313.13253-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115214313.13253-2-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 04:43:06PM -0500, Waiman Long wrote:
> There are currently three counters to track the irq context of a lock
> chain - nr_hardirq_chains, nr_softirq_chains and nr_process_chains.
> They are incremented when a new lock chain is added, but they are
> not decremented when a lock chain is removed. That causes some of the
> statistic counts reported by /proc/lockdep_stats to be incorrect.
> 
> Fix that by decrementing the right counter when a lock chain is removed.
> 
> Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/lockdep.c           | 36 +++++++++++++++++++++---------
>  kernel/locking/lockdep_internals.h |  6 +++++
>  2 files changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 32282e7112d3..b20fa6236b2a 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2299,16 +2299,24 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
>  	return 0;
>  }
>  
> -static void inc_chains(void)
> +static void inc_chains(int irq_context)
>  {
> -	if (current->hardirq_context)
> +	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
>  		nr_hardirq_chains++;
> -	else {
> -		if (current->softirq_context)
> -			nr_softirq_chains++;
> -		else
> -			nr_process_chains++;
> -	}
> +	else if (irq_context & LOCK_CHAIN_SOFTIRQ_CONTEXT)
> +		nr_softirq_chains++;
> +	else
> +		nr_process_chains++;
> +}
> +
> +static void dec_chains(int irq_context)
> +{
> +	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
> +		nr_hardirq_chains--;
> +	else if (irq_context & LOCK_CHAIN_SOFTIRQ_CONTEXT)
> +		nr_softirq_chains--;
> +	else
> +		nr_process_chains--;
>  }
>  
>  #else
> @@ -2324,6 +2332,10 @@ static inline void inc_chains(void)
>  	nr_process_chains++;
>  }
>  
> +static void dec_chains(int irq_context)
> +{
> +	nr_process_chains--;
> +}
>  #endif /* CONFIG_TRACE_IRQFLAGS */
>  

Is there really need for two versions of those functions? Would the
@irq_context argument not always be 0 in the CONFIG_TRACE_IRQFLAGS=n
case?
