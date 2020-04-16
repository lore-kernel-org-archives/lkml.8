Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ABEC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5036F214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 07:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nS2o1aPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439044AbgDPH2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439271AbgDPH2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:28:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A70C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+c0BnVkUz/p/ZKVi7AZts0cdD6pPHHHH4PNO8czLDVY=; b=nS2o1aPJSp7O48N4kyJVtmzwm9
        o/CUJvWe2Ml1QhA8pNAxjV7XCmlmH2xiukea7gdl8oBX35YDirwn9uk6CMtmQ9p683g+j0UXrxKiF
        fTR9SW9rhWZ7CrgfCRNs3FRsQTj+gcuyiQbASur8OhEncmXrdGzdyztPYlwCXAL1aUZakUr60fY31
        sxyaR4cvx3nngoGR3IZZvpO1SZcxt5Q0xu0JVv5tdelkuVeuxsvWhBfnrYv4UF+rb91GV8Fty64Oc
        uC/tX13pHdogoWD4zd/6hZjevXzbmPnZwF9upx+PRN3Bu4JF+aTVGYNgkJeJW2CX86RJkd6LOkb2x
        SjTRyH5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOyvm-0002R2-89; Thu, 16 Apr 2020 07:27:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9F7583015D0;
        Thu, 16 Apr 2020 09:27:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5DEE229E70278; Thu, 16 Apr 2020 09:27:23 +0200 (CEST)
Date:   Thu, 16 Apr 2020 09:27:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/cpuacct: Use __this_cpu_add() instead of
 this_cpu_ptr()
Message-ID: <20200416072723.GK20730@hirez.programming.kicks-ass.net>
References: <20200416065310.37539-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416065310.37539-1-songmuchun@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 02:53:10PM +0800, Muchun Song wrote:
> There seems to be no difference between the two, but on some
> architectures(e.g. x86_64), there will be optimizations for
> __this_cpu_add(). We can disassemble the code for you to see
> the difference between them on x86_64.
> 
>   1) this_cpu_ptr(ca->cpuusage)->usages[index] += cputime;
> 
>      ffffffff810d7227: add %gs:0x7ef37fa9(%rip),%rax # f1d8 <this_cpu_off>
>      ffffffff810d722f: add %rsi,(%rax)               # %rsi is @cputime
> 
> This result in two add instructions emitted by the compiler.
> 
>   2) __this_cpu_add(ca->cpuusage->usages[index], cputime);
> 
>      ffffffff810d7227: add %rsi,%gs:(%rax)           # %rsi is @cputime
> 
> This result in only one add instruction emitted by the compiler.
> 
> So we have enough reasons to use the __this_cpu_add().

The patch is OK, but I can't take it with such complete nonsense for a
Changelog.

The reason this_cpu_add() and __this_cpu_add() exist and are different
is for different calling context. this_cpu_*() is always safe and
correct, but as you notice, not always optimal. __this_cpu_*() relies on
the caller already having preemption (and or IRQs disabled) to allow for
better code-gen.

Now, the below call-sites have rq->lock taken, and this means preemption
(and IRQs) are indeed disabled, so it is safe to use __this_cpu_*().

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  kernel/sched/cpuacct.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
> index 9fbb103834345..6448b0438ffb2 100644
> --- a/kernel/sched/cpuacct.c
> +++ b/kernel/sched/cpuacct.c
> @@ -347,7 +347,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
>  	rcu_read_lock();
>  
>  	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
> -		this_cpu_ptr(ca->cpuusage)->usages[index] += cputime;
> +		__this_cpu_add(ca->cpuusage->usages[index], cputime);
>  
>  	rcu_read_unlock();
>  }
> @@ -363,7 +363,7 @@ void cpuacct_account_field(struct task_struct *tsk, int index, u64 val)
>  
>  	rcu_read_lock();
>  	for (ca = task_ca(tsk); ca != &root_cpuacct; ca = parent_ca(ca))
> -		this_cpu_ptr(ca->cpustat)->cpustat[index] += val;
> +		__this_cpu_add(ca->cpustat->cpustat[index], val);
>  	rcu_read_unlock();
>  }
>  
> -- 
> 2.11.0
> 
