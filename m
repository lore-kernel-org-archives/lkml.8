Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E462C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7222820684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XJcn4xDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgATKRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:17:30 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34200 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgATKRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:17:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gztlN05IQZuOK4W6S4SylxVz4OdRtg3T258KyW9CMgg=; b=XJcn4xDGGPQYbnCszSKBw9t5B
        LU4e5ux4iin89IR5TGzNDbwlXg0z2XQRNSxQCDZiZpSfnOfQCxS/9UWQ9grbYMElOdqU+5/hzytEt
        7/WwvYhZS+9yH3DN5SYdTjmRa+bJw98fpipggGjr7QaryGLJiy2xnLm/d6zio3YYvPnuNeyoe+Mu3
        OUXa5Me3vOpovYKrLffPIfiVFbOuSHMyBRIkg1TvHQLmFbhs7Jwn5FmWDTsAJ1mCwe+BpreUZ+JY/
        xVJUJoUXjNYaMcu92TMbR/8sYt3K6GtjeKvj8Cj9gtvLqbuem7BHnAcuSEoNgRZK8iGikF8i5F2Gs
        7OvHbzpng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1itU75-0003c9-OY; Mon, 20 Jan 2020 10:16:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CE00F305E4E;
        Mon, 20 Jan 2020 11:15:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62A352041FB24; Mon, 20 Jan 2020 11:16:52 +0100 (CET)
Date:   Mon, 20 Jan 2020 11:16:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        paulmck@kernel.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/core: fix illegal RCU from offline CPUs
Message-ID: <20200120101652.GM14879@hirez.programming.kicks-ass.net>
References: <20200113190331.12788-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113190331.12788-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 02:03:31PM -0500, Qian Cai wrote:
> In the CPU-offline process, it calls mmdrop() after idle entry and the
> subsequent call to cpuhp_report_idle_dead(). Once execution passes the
> call to rcu_report_dead(), RCU is ignoring the CPU, which results in
> lockdep complaints when mmdrop() uses RCU from either memcg or
> debugobjects, so it by scheduling mmdrop() on another online CPU.
> 
> According to the commit a79e53d85683 ("x86/mm: Fix pgd_lock deadlock"),
> mmdrop() is not interrupt-safe, and called from
> smp_call_function_single() could end up running mmdrop() from the IPI
> interrupt handler.
> 

<deletes ~100 lines of gunk>

Surely the critical information contained in these nearly 100 lines of
splat can be more consicely represented?


> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 90e4b00ace89..1863a6fc4d82 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6194,7 +6194,8 @@ void idle_task_exit(void)
>  		current->active_mm = &init_mm;
>  		finish_arch_post_lock_switch();
>  	}
> -	mmdrop(mm);
> +	smp_call_function_single(cpumask_first(cpu_online_mask),
> +				 (void (*)(void *))mmdrop_async, mm, 0);
>  }

Bah.. that's horrible. Surely we can find a better place to do this in
the whole hotplug machinery.

Perhaps you can have takedown_cpu() do the mmdrop()?
