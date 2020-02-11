Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96E6C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD3B024650
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581447302;
	bh=TTvABVf0eAckUd4K2fZS8swB4SzmIFtWNn1cVzFk81k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=uHtPxbsGgJYnf17nFaFDYqlUaYM8kKgKedUeXJ+yIXz63ZHHIouYnmW0EdHtxsE6b
	 iuG2ESjBfm4h5JKX/RqMWDvocSIcB7A1qPEDkuyKSScnNKm8LEMSoJqok8s0w80Iye
	 sNUFpxu8RGmb9Eizzl1UiKyO4Dd/Sr38WqGMaUEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbgBKSzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:55:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:52912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbgBKSzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:55:01 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAB5B2082F;
        Tue, 11 Feb 2020 18:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581447300;
        bh=TTvABVf0eAckUd4K2fZS8swB4SzmIFtWNn1cVzFk81k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IQ/7u5MXIbyyf8t5UZqh8LMZLXCzlp0H3jQQyM9xqDL7Jp3gsfbAVdqcC0oalr9aU
         oLkZmtasTl2qqbvguj0g1dlIH8iBnljQ2hIzh9GdTunAclnzMPsbvAKZLq+okTvLWd
         SOHRqh3bfa0x/r2mKpwW3DB0IcN5a614YGN1O0aM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EE3F43520CBE; Tue, 11 Feb 2020 10:54:57 -0800 (PST)
Date:   Tue, 11 Feb 2020 10:54:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20200211185457.GN2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200211095047.58ddf750@gandalf.local.home>
 <20200211153452.GW14914@hirez.programming.kicks-ass.net>
 <20200211111828.48058768@gandalf.local.home>
 <20200211172952.GY14914@hirez.programming.kicks-ass.net>
 <20200211173213.GX14946@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211173213.GX14946@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 06:32:13PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 11, 2020 at 06:29:52PM +0100, Peter Zijlstra wrote:
> > +#define trace_rcu_enter()					\
> > +({								\
> > +	unsigned long state = 0;				\
> > +	if (!rcu_is_watching())	{				\
> 
> Also, afaict rcu_is_watching() itself needs more love, the functio has
> notrace, but calls other stuff that does not have notrace or inline.

Good catch!  Like this?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1f5fdf7..51616e72 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -295,7 +295,7 @@ static void rcu_dynticks_eqs_online(void)
  *
  * No ordering, as we are sampling CPU-local information.
  */
-static bool rcu_dynticks_curr_cpu_in_eqs(void)
+static bool notrace rcu_dynticks_curr_cpu_in_eqs(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
