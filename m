Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA836C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD6F1208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VUKw3Mu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgBKPaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:30:12 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40102 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgBKPaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xs1yi8tH5NlwpQTjZ5mWrKCjszSGc2Crjq6zFwHP5fM=; b=VUKw3Mu9CU7DXAAvFmKAUbkx3e
        4Yp/jolurw1aMjjGZClbb0hlWAw02eoatGweEGv0/IyLTZjaboZ7RqegsOFaJgc0AnofCmXmZEVu5
        mFvNTPOrsxPaEmGu7mSw3h6wZL+dtNjou3OzgP6dBDXHkYtF313+58eGXpAZAnL23Oj+eCfCudHUu
        djc+jBCwDWDwHVH4s2DgVOvxtEWxht91tkG+0e0Gbd0nyAomjrCWaOTDoRUzAAAxN0Cj91+RasqdW
        FIYNfc+pDlfESAkVhelzfHJdvOJRF4r1CAQjmh9fxCumgzxDiAtLF5xoddmEXW+o2VITkyC8onb3E
        xWfrraJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1XTw-0003ds-CQ; Tue, 11 Feb 2020 15:29:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78C7930066E;
        Tue, 11 Feb 2020 16:27:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 13C8220148940; Tue, 11 Feb 2020 16:29:45 +0100 (CET)
Date:   Tue, 11 Feb 2020 16:29:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200211152945.GW14946@hirez.programming.kicks-ass.net>
References: <20200210170643.3544795d@gandalf.local.home>
 <20200211114954.GK14914@hirez.programming.kicks-ass.net>
 <20200211090503.68c0d70f@gandalf.local.home>
 <20200211150532.GU14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211150532.GU14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:05:32PM +0100, Peter Zijlstra wrote:

> So we haz:
> 
> | #define nmi_enter()						\
> | 	do {							\
> | 		arch_nmi_enter();				\
> 
> arm64 only, lets ignore for now
> 
> | 		printk_nmi_enter();				\
> 
> notrace
> 
> | 		lockdep_off();					\
> 
> notrace
> 
> | 		ftrace_nmi_enter();				\
> 
> !notrace !!!
> 
> | 		BUG_ON(in_nmi());				\
> | 		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);\
> 
> lets make this __preempt_count_add() ASAP !

preempt_count_add() first frobs the actual preempt_count and then does
the trace, so that might just work. But it does need a notrace
annotation, I'm thinking, because calling into the function tracer
_before_ we do the preempt_count increment is irrecoverable crap.

> | 		rcu_nmi_enter();				\
> 
> are you _really_ sure you want to go trace that ?!?
> 
> | 		trace_hardirq_enter();				\
> | 	} while (0)
> 
> 
