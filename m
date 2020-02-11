Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56436C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0CD20675
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DZP3e7Ue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgBKNRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:17:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60042 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBKNRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/qD7p8YSyRpn8QMMjV65ZEJSq5q78FVu+XDqDEf9ATo=; b=DZP3e7UejO+w9XcQA5tzNdpxL6
        RdLkcMkshiD3OOsX1fuCKzJjRt6n1y9ZrJIB3n1uwj2yCFj8gHbrMmqYIAufnqaTIgeqMe8+JWB51
        2PTyzGthzkFMOwK7KGnhPbBcVt+BULGbTDCoXCFKKu3CJvWwEteOTc4WAjZ9V0QEsYMYXr8UiccDF
        m+ZVvmojU89h5cJ6mtfhCucjbGVHMNh1Ar4goMWzDZnQVMLFdT79VwtXxYa4HsZGG9H4VLipCo77F
        SBAAAD6QnrolGfZdNrk2SFQuPTwhptEOsKp+L4UpHwc+emrnwtr7B1ckCJc9QnbcUMRLavQ3FOEAG
        W7pua7JA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1VP5-0003wJ-BR; Tue, 11 Feb 2020 13:16:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 22127300446;
        Tue, 11 Feb 2020 14:14:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2F4920148940; Tue, 11 Feb 2020 14:16:37 +0100 (CET)
Date:   Tue, 11 Feb 2020 14:16:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200211131637.GS14914@hirez.programming.kicks-ass.net>
References: <20200210170643.3544795d@gandalf.local.home>
 <576504045.617212.1581381032132.JavaMail.zimbra@efficios.com>
 <20200211120015.GL14914@hirez.programming.kicks-ass.net>
 <20200211130301.GH2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211130301.GH2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 05:03:01AM -0800, Paul E. McKenney wrote:

> > It is not the fact that perf issues rcu_read_lock() that is the problem.
> > As we established yesterday, I can probably remove most rcu_read_lock()
> > calls from perf today (yay RCU flavour unification).
> 
> Glad some aspect of this unification is actually helping you.  ;-)

rcu_read_lock() is exceedingly cheap though, so I never really worried
about it. But now that RCU includes RCU-sched (again) we can go and
remove a bunch of them.

> > As per nmi_enter() calling rcu_nmi_enter() I've always assumed that NMIs
> > are fully covered by RCU.
> > 
> > If this isn't so, RCU it terminally broken :-)
> 
> All RCU can do is respond to calls to rcu_nmi_enter() and rcu_nmi_exit().
> It has not yet figured out how to force people to add these calls where
> they are needed.  ;-)
> 
> But yes, it would be very nice if architectures arranged things so
> that all NMI handlers were visible to RCU.  And we no longer have
> half-interrupts, so maybe there is hope...

Well,.. you could go back to simply _always_ watching :-)
