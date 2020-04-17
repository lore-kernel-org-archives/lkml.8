Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F28C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD162063A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tx/xJ3ff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbgDQLSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729962AbgDQLSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 07:18:41 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEED9C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 04:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/ZnqPGloz5qpK7/E1IaNFav8MSspX6hYlLoRkVBqIng=; b=tx/xJ3ffFqDu/kEWIYVfjBGeWX
        tTPu4RI5XglLsKjomE+B2jjZcnPKb1o2UCr4HRqB/ey7RBetv9MdeFijz24J1XrjGxGeNC1Na5NbT
        a/F+w69aipGcQHPoANnRuAOccl/GykEc2qeRM2Rbn/lH7l01/TaCGSwd5nRJdTn0BrbRxOTNLrmLj
        MhBHLaT1x1SMo4WcVuyx0pT91BM9alES/51BuYzr1iLnPBFnk4tY/5bkUF+DeJ6GY9XBxvR/doHD4
        UuQR2QzoTQYR15dqRAeWdy3nTsprcrKvEp7KT/Y7uFlXMRPr8/gw+PCV2b+3Swerk/VgbW+AXCZeQ
        QdLX1H5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPP0Z-0006Hw-NL; Fri, 17 Apr 2020 11:18:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79C1F3006E0;
        Fri, 17 Apr 2020 13:18:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E3D42B1214B0; Fri, 17 Apr 2020 13:18:05 +0200 (CEST)
Date:   Fri, 17 Apr 2020 13:18:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     vpillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Long Cui <long.cui@intel.com>
Subject: Re: [RFC PATCH 07/13] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200417111805.GA20730@hirez.programming.kicks-ass.net>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <e942da7fd881977923463f19648085c1bfaa37f8.1583332765.git.vpillai@digitalocean.com>
 <20200416033804.GA5712@HP-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416033804.GA5712@HP-G1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 11:39:05AM +0800, Chen Yu wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 02495d44870f..ef101a3ef583 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4477,9 +4477,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  		return next;
>  	}
>  
> -	prev->sched_class->put_prev_task(rq, prev);
> -	if (!rq->nr_running)
> -		newidle_balance(rq, rf);
> +
> +#ifdef CONFIG_SMP
> +	for_class_range(class, prev->sched_class, &idle_sched_class) {
> +		if (class->balance(rq, prev, rf))
> +			break;
> +	}
> +#endif
> +	put_prev_task(rq, prev);
>  
>  	smt_mask = cpu_smt_mask(cpu);

Instead of duplicating that, how about you put the existing copy in a
function to share? finish_prev_task() perhaps?

Also, can you please make newidle_balance() static again; I forgot doing
that in 6e2df0581f56, which would've made you notice this sooner I
suppose.
