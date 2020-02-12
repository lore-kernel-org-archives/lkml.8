Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7515EC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F6B421739
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgBLPOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:14:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:36656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbgBLPOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:14:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D93FA206D7;
        Wed, 12 Feb 2020 15:14:16 +0000 (UTC)
Date:   Wed, 12 Feb 2020 10:14:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH 4/8] sched,rcu,tracing: Mark preempt_count_{add,sub}()
 notrace
Message-ID: <20200212101415.3615d66c@gandalf.local.home>
In-Reply-To: <20200212150211.GS14897@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
        <20200212094107.838108888@infradead.org>
        <20200212092417.04c3da8c@gandalf.local.home>
        <20200212150211.GS14897@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 16:02:11 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Feb 12, 2020 at 09:24:17AM -0500, Steven Rostedt wrote:
> > On Wed, 12 Feb 2020 10:32:14 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > Because of the requirement that no tracing happens until after we've
> > > incremented preempt_count, see nmi_enter() / trace_rcu_enter(), mark
> > > these functions as notrace.  
> > 
> > I actually depend on these function being traced.  
> 
> Why? They already have a tracepoint inside.

Only when enabled.

> 
> > We do have
> > "preempt_enable_notrace()" and "preempt_disable_notrace()" for places
> > that shouldn't be traced. Can't we use those? (or simply
> > __preempt_count_add()) in the nmi_enter() code instead? (perhaps create
> > a preempt_count_add_notrace()).  
> 
> My initial patch has __preempt_count_add/sub() in, but then I figured
> someone would go complain the tracepoint would go missing.

Fine, but what bug are you trying to fix? I haven't seen one mentioned
yet. Function tracing has recursion protection, and tracing
preempt_count in nmi_enter() causes no problems. What's the problem you
are trying to solve?

-- Steve
