Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D36C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D25262082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XVWLVjn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgBKPbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:31:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgBKPbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VWBCOELY6rkhccDCqlZILUKA2AGhvyeFtdMCkPYvY6Q=; b=XVWLVjn3Xk2wUFZvXsV0Bhod4q
        eCRC8Jl3We+M4z+VhaSGOYs5+vyaXFvVoqzeieN+007vOuR/HlarbmEZJbXAdEJfgZ8KsoGHWFR55
        vx/pTW4fsq05srqrFTy2XKi8NlRj29xWp1aj/ZrJl4pW3tjPX8SKDU7miwyoXPHk1DmmQe1z+18s1
        RAjbh+C58Hf1hhYmakUN/VMa/TO16k/Ky38tfmfqA/o+Ez+Iu2gx7/rqmfFUY42/3HkbneD6jVl5c
        7ujvZ8VUPsQgoN8px3oh1i3S+JkD/pzbrUrzMZJhB2jzI14pXUvoBs3FscWVQrNVdSJxoWGtiSpwk
        MDalKZCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1XVW-0004uo-1e; Tue, 11 Feb 2020 15:31:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E8AC300739;
        Tue, 11 Feb 2020 16:29:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2362120148940; Tue, 11 Feb 2020 16:31:24 +0100 (CET)
Date:   Tue, 11 Feb 2020 16:31:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200211153124.GV14914@hirez.programming.kicks-ass.net>
References: <20200210170643.3544795d@gandalf.local.home>
 <20200211114954.GK14914@hirez.programming.kicks-ass.net>
 <20200211090503.68c0d70f@gandalf.local.home>
 <20200211150615.GK2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211150615.GK2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 07:06:15AM -0800, Paul E. McKenney wrote:
> And I have to ask...  What happens if we are very early in from-idle
> NMI entry (or very late in NMI exit), such that both in_nmi() and
> rcu_is_watching() are returning false?  Or did I miss a turn somewhere?

We must, by very careful inspection, ensure that doesn't happen.

No tracing must happen before preempt_count increment / after
preempt_count decrement. Otherwise we can no longer recover.
