Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39A0C2BBC7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8AEE206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CdxfULn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439395AbgDNLhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439354AbgDNLhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:37:15 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111DDC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 04:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5fWEtgrTH9zO0zIcoo+/a88VwILs4L6u8exqS9T3p3Q=; b=CdxfULn1HuYr2DH0TtLsK1gNPW
        okFN71fsxOtk+nhi/fEjZeFESbU9pMlpnAZf2UGJ/WhVZ8Hp3W/uIUId5L8DF5auMRNvtojwvdTfj
        tbwUEWv0f2FKXHsIgdla7khVMn3bUygjYF2Pp/56Ei9qKJPQ/dI3pExkzr4hPhwpjfMqclkXMfTC0
        Of9NXq83F+NUCjcaerVe8hVaYG+7vhsId9uU4TcVP/bitBBkkAFXg6aWQ/ZQiVy8SdpUgw0Vgfzoo
        +mvHZyh2dJbEtzg/RfZtig9UfdsYQ3QllU6jgj43QtIF5GX3Nkn2L8NUDzcoo+7oiq/eMWApdTczB
        4eHT7bKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOJru-0005Ei-Hd; Tue, 14 Apr 2020 11:36:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 47DD7305EEC;
        Tue, 14 Apr 2020 13:36:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B4692038BC5C; Tue, 14 Apr 2020 13:36:39 +0200 (CEST)
Date:   Tue, 14 Apr 2020 13:36:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     vpillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org
Subject: Re: [RFC PATCH 03/13] sched: Core-wide rq->lock
Message-ID: <20200414113639.GS20730@hirez.programming.kicks-ass.net>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <855831b59e1b3774b11c3e33050eac4cc4639f06.1583332765.git.vpillai@digitalocean.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <855831b59e1b3774b11c3e33050eac4cc4639f06.1583332765.git.vpillai@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 04:59:53PM +0000, vpillai wrote:
> @@ -6400,8 +6464,15 @@ int sched_cpu_activate(unsigned int cpu)
>  	/*
>  	 * When going up, increment the number of cores with SMT present.
>  	 */
> -	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
> +	if (cpumask_weight(cpu_smt_mask(cpu)) == 2) {
>  		static_branch_inc_cpuslocked(&sched_smt_present);
> +#ifdef CONFIG_SCHED_CORE
> +		if (static_branch_unlikely(&__sched_core_enabled)) {
> +			rq->core_enabled = true;
> +		}
> +#endif
> +	}
> +
>  #endif
>  	set_cpu_active(cpu, true);
>  
> @@ -6447,8 +6518,16 @@ int sched_cpu_deactivate(unsigned int cpu)
>  	/*
>  	 * When going down, decrement the number of cores with SMT present.
>  	 */
> -	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
> +	if (cpumask_weight(cpu_smt_mask(cpu)) == 2) {
> +#ifdef CONFIG_SCHED_CORE
> +		struct rq *rq = cpu_rq(cpu);
> +		if (static_branch_unlikely(&__sched_core_enabled)) {
> +			rq->core_enabled = false;
> +		}
> +#endif
>  		static_branch_dec_cpuslocked(&sched_smt_present);
> +
> +	}
>  #endif
>  
>  	if (!sched_smp_initialized)

Aside from the fact that it's probably much saner to write this as:

	rq->core_enabled = static_key_enabled(&__sched_core_enabled);

I'm fairly sure I didn't write this part. And while I do somewhat see
the point of disabling core scheduling for a core that has only a single
thread on, I wonder why we care.

The thing is, this directly leads to the utter horror-show that is patch
6.

It should be perfectly possible to core schedule a core with only a
single thread on. It might be a tad silly to do, but it beats the heck
out of the trainwreck created here.

So how did this happen?
