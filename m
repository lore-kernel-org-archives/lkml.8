Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BCBC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F233B20661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TJ3m1SVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgBLICr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:02:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50944 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgBLICq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nfa7El0ORw2HCTWB7Em/MVPCwTy7Wkmj8WcnIu9Inb8=; b=TJ3m1SVhqEJjhO3XOm6k+WyBd5
        wqma/gwkuMm4Nz26PccFx+VKw0wRuOSfE2TFPzFD7FfRhJbcqHyZk0Fon4y9r+3IHKCOFzltclt1U
        ke3yre4BvrLB9sEpCEkm+5pWBF/NRjKKg8elz5LEMBNf9qIPR0dWHQxtXNWUbgacoq/E8My85KP+y
        n+wHySPM0SRW7JMxhNhyyCTH7kW/HB+uM178GISHHnOA/4tBLn/NdoZPblNkJhx2SgleJseor07Qd
        5WNrXzIrb4cvWk0eqk6vqUhCFzUUhZNl/Dy4UY40R0McLUI7i4UbdzmyhaXHTrEUjF1ji/4OklzE1
        SmvYSezA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1myV-0007xU-So; Wed, 12 Feb 2020 08:02:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C4F0930066E;
        Wed, 12 Feb 2020 09:00:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BDC6A2B9154E8; Wed, 12 Feb 2020 09:02:20 +0100 (CET)
Date:   Wed, 12 Feb 2020 09:02:20 +0100
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
Subject: Re: [PATCH v2] tracing/perf: Move rcu_irq_enter/exit_irqson() to
 perf trace point hook
Message-ID: <20200212080220.GO14897@hirez.programming.kicks-ass.net>
References: <20200211095047.58ddf750@gandalf.local.home>
 <20200211153452.GW14914@hirez.programming.kicks-ass.net>
 <20200211111828.48058768@gandalf.local.home>
 <20200211172952.GY14914@hirez.programming.kicks-ass.net>
 <903136616.617885.1581442521855.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <903136616.617885.1581442521855.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 12:35:21PM -0500, Mathieu Desnoyers wrote:

> Minor nits:
> 
> Why not make these an enum ?
> 
> > +
> > +#define trace_rcu_enter()					\
> > +({								\
> > +	unsigned long state = 0;				\
> > +	if (!rcu_is_watching())	{				\
> > +		if (in_nmi()) {					\
> > +			state = __TR_NMI;			\
> > +			rcu_nmi_enter();			\
> > +		} else {					\
> > +			state = __TR_IRQ;			\
> > +			rcu_irq_enter_irqson();			\
> > +		}						\
> > +	}							\
> > +	state;							\
> > +})
> > +
> > +#define trace_rcu_exit(state)					\
> > +do {								\
> > +	switch (state) {					\
> > +	case __TR_IRQ:						\
> > +		rcu_irq_exit_irqson();				\
> > +		break;						\
> > +	case __IRQ_NMI:						\
> > +		rcu_nmi_exit();					\
> > +		break;						\
> > +	default:						\
> > +		break;						\
> > +	}							\
> > +} while (0)
> 
> And convert these into static inline functions ?

Probably the same reason the rest of the file is macros; header hell.

Now, I could probably make these inlines, but then I'd have to add more
RCU function declariations to this file (which is outside of
rcupdate.h). Do we want to do that?

The reason these were in this file is because I want to keep the comment
and implementation near to nmi_enter/exit.
