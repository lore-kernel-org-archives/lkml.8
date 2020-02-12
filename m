Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF708C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C44402168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgBLOYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:24:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727988AbgBLOYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:24:21 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 276BD206D7;
        Wed, 12 Feb 2020 14:24:20 +0000 (UTC)
Date:   Wed, 12 Feb 2020 09:24:17 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH 4/8] sched,rcu,tracing: Mark preempt_count_{add,sub}()
 notrace
Message-ID: <20200212092417.04c3da8c@gandalf.local.home>
In-Reply-To: <20200212094107.838108888@infradead.org>
References: <20200212093210.468391728@infradead.org>
        <20200212094107.838108888@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 10:32:14 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Because of the requirement that no tracing happens until after we've
> incremented preempt_count, see nmi_enter() / trace_rcu_enter(), mark
> these functions as notrace.

I actually depend on these function being traced. We do have
"preempt_enable_notrace()" and "preempt_disable_notrace()" for places
that shouldn't be traced. Can't we use those? (or simply
__preempt_count_add()) in the nmi_enter() code instead? (perhaps create
a preempt_count_add_notrace()).

-- Steve



> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3781,7 +3781,7 @@ static inline void preempt_latency_start
>  	}
>  }
>  
> -void preempt_count_add(int val)
> +void notrace preempt_count_add(int val)
>  {
>  #ifdef CONFIG_DEBUG_PREEMPT
>  	/*
> @@ -3813,7 +3813,7 @@ static inline void preempt_latency_stop(
>  		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
>  }
>  
> -void preempt_count_sub(int val)
> +void notrace preempt_count_sub(int val)
>  {
>  #ifdef CONFIG_DEBUG_PREEMPT
>  	/*
> 

