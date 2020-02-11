Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD38BC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B3F2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D2a6GjUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgBKLuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:50:52 -0500
Received: from merlin.infradead.org ([205.233.59.134]:53110 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgBKLuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:50:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y67BwQMxRYM3PjeNYdtynviH/nF5k899kzzr0M34J3E=; b=D2a6GjUK41it4NsOtJ7f5KRfMr
        PNF+xhX+Z+sgjso57V+MQ6YauMkNsAC9IsiKN9fBnl7JV13BXgksYnZmpjvEG5+WxAILBwayynov6
        OQNHBMClv3xJEwNNXW+dFt8AmwY55F07VIA1Qe1s/ieRvSTGhY3QFMLjTQnCgiCwqFLtlis8vl4Se
        spnT1fKOnUbVoGSsbcgQDos5uey52EyeRDGLGHQAPY/taOmj5ud95qVa8MqLUTcCLM59/nNiRFLNN
        wASswfi4R6GXaE0UX89wPFamBTyg+OT7tzMq1sxgIm4pGB0cb7vuqtelZWit8Bei0ENu2GgPygqbG
        jrj0RANw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1U3B-0002TI-FS; Tue, 11 Feb 2020 11:49:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 867D3300739;
        Tue, 11 Feb 2020 12:48:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2810B2B88D75C; Tue, 11 Feb 2020 12:49:54 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:49:54 +0100
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
Message-ID: <20200211114954.GK14914@hirez.programming.kicks-ass.net>
References: <20200210170643.3544795d@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210170643.3544795d@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:06:43PM -0500, Steven Rostedt wrote:
> +	if (!rcu_watching) {						\
> +		/* Can not use RCU if rcu is not watching and in NMI */	\
> +		if (in_nmi())						\
> +			return;						\
> +		rcu_irq_enter_irqson();					\
> +	}								\

I saw the same weirdness in __trace_stack(), and I'm confused by it.

How can we ever get to: in_nmi() && !rcu_watching() ? That should be a
BUG.  In particular, nmi_enter() has rcu_nmi_enter().

Paul, can that really happen?
