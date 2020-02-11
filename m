Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A031C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3356120714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581427234;
	bh=mVbt8YSJAqw5cLx22e6TTqh0mUQMRzZcOU8Pigm/Bv8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=sbnmPhnQzFgPW6yyohzNEahI+74Z6EZxRTq1OVVCS5o7z9gx/9KDkN9doeHmbK7js
	 KS0e1qoAoFoO9mVflOPjmzaKYmLdwz22a5P/g+y/3j8jQpUyOQZXBxRDiriwbw4qhb
	 3CYb6Cm06uRAn9TXb+Fit5NyHSooOrI6O374aTwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgBKNUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:20:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgBKNUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:20:33 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [193.85.242.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF6C220675;
        Tue, 11 Feb 2020 13:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581427232;
        bh=mVbt8YSJAqw5cLx22e6TTqh0mUQMRzZcOU8Pigm/Bv8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d42wOYAIBewMVPiC+vDef2EglKNrt9DJRa1V3NBn6VXKaAHh3A9XtADvrelh0Zt7l
         +ppyN5IE4avT5hJK5t0z+9aEdqzQt3su3Flrpyq3ctNB3LqTXiRTqWVi2FqAsk/DB9
         hZpr0PHbJydWbO9gjY4GJUaDMGUVs/KABgrPBsWM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 59C5C3520CB5; Tue, 11 Feb 2020 05:20:30 -0800 (PST)
Date:   Tue, 11 Feb 2020 05:20:30 -0800
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
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200211132030.GI2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200210170643.3544795d@gandalf.local.home>
 <20200211114954.GK14914@hirez.programming.kicks-ass.net>
 <20200211125929.GG2935@paulmck-ThinkPad-P72>
 <20200211131046.GR14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211131046.GR14914@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 02:10:46PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 11, 2020 at 04:59:29AM -0800, Paul E. McKenney wrote:
> 
> > However, a quick grep for NMI_MASK didn't show me the NMI_MASK bit
> > getting set.  Help?
> 
> | #define nmi_enter()						\
> | 	do {							\
> | 		arch_nmi_enter();				\
> | 		printk_nmi_enter();				\
> | 		lockdep_off();					\
> | 		ftrace_nmi_enter();				\
> | 		BUG_ON(in_nmi());				\
> | 		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
> 
> 		^^^^ right there
> 
> | 		rcu_nmi_enter();				\
> | 		trace_hardirq_enter();				\
> | 	} while (0)

Color me blind, and thank you!

							Thanx, Paul
