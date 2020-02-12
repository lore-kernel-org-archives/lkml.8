Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093A8C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D092F20873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q0tQVx4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgBLIGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:06:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:49784 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbgBLIGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oDAot7XC0gIAmAyPofX8hByGkkfWmUHeU1+lBRlryTs=; b=Q0tQVx4f/ZbXs9EkIpHSl6gV4y
        ZY4gI3bFP02hOAW7tJIJrFe5GjCZpWwBcYxa8jQNGMdYsyqvtuMP05Dd7adEzyUUVWp+Z076E3oYp
        i+ByNCWLmDVxswwmX2BGcubDSDbpEzEUGNJG9mC5Emts4lJcAUN3sv2S9cDyW6f296uUMqN8XcQs6
        73Rz72JY9PnRkRyjjzj+JQFOsw4P6qITdDiiY3bS0M5gskm/uyymwTUJWbYh6Vh7NSHr5yiDusQ5Q
        nOaSHy4IA4Z7/H6v/GgxtQHmvWjJecfJGa7dykrYKC7NC7M7DELD+fYRvos7rkjujK4JSU6xwa0eM
        SgljleQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1n1R-0004ML-KX; Wed, 12 Feb 2020 08:05:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C3411306E5C;
        Wed, 12 Feb 2020 09:03:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A1B172B9154E9; Wed, 12 Feb 2020 09:05:22 +0100 (CET)
Date:   Wed, 12 Feb 2020 09:05:22 +0100
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
Subject: Re: [PATCH v2] tracing/perf: Move rcu_irq_enter/exit_irqson() to
 perf trace point hook
Message-ID: <20200212080522.GP14897@hirez.programming.kicks-ass.net>
References: <20200211095047.58ddf750@gandalf.local.home>
 <20200211153452.GW14914@hirez.programming.kicks-ass.net>
 <20200211111828.48058768@gandalf.local.home>
 <20200211172952.GY14914@hirez.programming.kicks-ass.net>
 <20200211173213.GX14946@hirez.programming.kicks-ass.net>
 <20200211185457.GN2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211185457.GN2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 10:54:57AM -0800, Paul E. McKenney wrote:
> On Tue, Feb 11, 2020 at 06:32:13PM +0100, Peter Zijlstra wrote:
> > On Tue, Feb 11, 2020 at 06:29:52PM +0100, Peter Zijlstra wrote:
> > > +#define trace_rcu_enter()					\
> > > +({								\
> > > +	unsigned long state = 0;				\
> > > +	if (!rcu_is_watching())	{				\
> > 
> > Also, afaict rcu_is_watching() itself needs more love, the functio has
> > notrace, but calls other stuff that does not have notrace or inline.
> 
> Good catch!  Like this?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1f5fdf7..51616e72 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -295,7 +295,7 @@ static void rcu_dynticks_eqs_online(void)
>   *
>   * No ordering, as we are sampling CPU-local information.
>   */
> -static bool rcu_dynticks_curr_cpu_in_eqs(void)
> +static bool notrace rcu_dynticks_curr_cpu_in_eqs(void)

Right, except that, given the size of the thing, I'd opt for 'inline'
over 'notrace'.
