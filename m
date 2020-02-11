Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33B9C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 995D320714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XF4/XgKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgBKMAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:00:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgBKMAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yu2gYGRiJP3Q45wtChO/IudUJSIJ0FJqsxf4cDjun9s=; b=XF4/XgKeDtiZ9dirsX47/tPE0L
        56mIe0F0tSowW2koUT8F+rJfLXOBBZI+xQbVbsPHAM0WcBgyM68hNXembb5INUhBLCccibVOYH4Z9
        jw7576bLX6dI5DW208rKlL9o1H/ZnE4MqAX9kn3LNHdB773kDRnJqb4DiPSakDEH7bFbNX+jFk82m
        +sY1El442NFvFjPSJbP1WohOdWtbb6eivfisexPKKwzLgzRu6l75zSsoNc+nNP4SvtllIpvBfe47a
        7Hc2eso/Et5oY8gXuErgUxoy7SqTWClb87mDmV7RFtgpUC3SLsA1235bkMaBl2CpIx0vH2MDlNL/2
        IPZpDQ6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1UDC-0000jc-5n; Tue, 11 Feb 2020 12:00:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2697F300739;
        Tue, 11 Feb 2020 12:58:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EECB2B88D75C; Tue, 11 Feb 2020 13:00:15 +0100 (CET)
Date:   Tue, 11 Feb 2020 13:00:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200211120015.GL14914@hirez.programming.kicks-ass.net>
References: <20200210170643.3544795d@gandalf.local.home>
 <576504045.617212.1581381032132.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <576504045.617212.1581381032132.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 07:30:32PM -0500, Mathieu Desnoyers wrote:

> > because perf only uses rcu to synchronize trace points.
> 
> That last part seems inaccurate. The tracepoint synchronization is two-fold:
> one part is internal to tracepoint.c (see rcu_free_old_probes()), and the other
> is only needed if the probes are within modules which can be unloaded (see
> tracepoint_synchronize_unregister()). AFAIK, perf never implements probe callbacks
> within modules, so the latter is not needed by perf.
> 
> The culprit of the problem here is that perf issues "rcu_read_lock()" and
> "rcu_read_unlock()" within the probe callbacks it registers to the tracepoints,
> including the rcuidle ones. Those require that RCU is "watching", which is
> triggering the regression when we remove the calls to rcu_irq_enter/exit_irqson()
> from the rcuidle tracepoint instrumentation sites.

It is not the fact that perf issues rcu_read_lock() that is the problem.
As we established yesterday, I can probably remove most rcu_read_lock()
calls from perf today (yay RCU flavour unification).

The problem is that the core perf code uses RCU managed data; and we
need an existence guarantee for it. It would be BAD (TM) if the
ring-buffer we're writing data to were to suddenly dissapear under our
feet etc..

> Which brings a question about handling of NMIs: in the proposed patch, if
> a NMI nests over rcuidle context, AFAIU it will be in a state
> !rcu_is_watching() && in_nmi(), which is handled by this patch with a simple
> "return", meaning important NMIs doing hardware event sampling can be
> completely lost.
> 
> Considering that we cannot use rcu_irq_enter/exit_irqson() from NMI context,
> is it at all valid to use rcu_read_lock/unlock() as perf does from NMI handlers,

Again, rcu_read_lock() itself really isn't the problem. But we need
NMIs, just like regular interrupts, to imply rcu_read_lock(). That is,
any observable (RCU managed) pointer must stay valid during the NMI/IRQ
execution.

> considering that those can be nested on top of rcuidle context ?

As per nmi_enter() calling rcu_nmi_enter() I've always assumed that NMIs
are fully covered by RCU.

If this isn't so, RCU it terminally broken :-)
