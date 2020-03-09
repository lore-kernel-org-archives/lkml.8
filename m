Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBB5C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705652253D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="btPRRmqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgCIUS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:18:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43046 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgCIUS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TWIHUDy3jBW0cS7WR3QKj5Hh4Aa7h7NpiybbLVlDwD8=; b=btPRRmqpXB8zYUKvCBAnCYqbS8
        zLOXODaCWXirdkuGQEu+x4UaVagtE/ql7+eji0mE0GDDQ1xci4BGXfnEFd+Gfy2+36YLHUc8HMQVm
        Ku9dVwcwbcpsPaPHTm258mG5vuJmzZBrwXUSIDVLOrZm2pEH5FD8iOKze/wwGZpRURxjTeUeC2YKJ
        3JBswWTz3orI/X4b6M8iAfLCn2llhLew6McPjYx8E/T4K1EvuRNAVgoRL5zwf52uEALeq6TarclTd
        ERovtuTRXMakFf1nmoY3XQcmRz+mYMhFRJ9WByAtVbqMeSaP3WLdEod56mrUi8j/pVeX0IuT7lM3i
        vPMaa0xQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jBOrN-0001up-J9; Mon, 09 Mar 2020 20:18:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F8C23011E0;
        Mon,  9 Mar 2020 21:18:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF2BF214344E6; Mon,  9 Mar 2020 21:18:42 +0100 (CET)
Date:   Mon, 9 Mar 2020 21:18:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: Instrumentation and RCU
Message-ID: <20200309201842.GL12561@hirez.programming.kicks-ass.net>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu8p797b.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 06:02:32PM +0100, Thomas Gleixner wrote:
> #4 Protecting call chains
> 
>    Our current approach of annotating functions with notrace/noprobe is
>    pretty much broken.
> 
>    Functions which are marked NOPROBE or notrace call out into functions
>    which are not marked and while this might be ok, there are enough
>    places where it is not. But we have no way to verify that.
> 
>    That's just a recipe for disaster. We really cannot request from
>    sysadmins who want to use instrumentation to stare at the code first
>    whether they can place/enable an instrumentation point somewhere.
>    That'd be just a bad joke.
> 
>    I really think we need to have proper text sections which are off
>    limit for any form of instrumentation and have tooling to analyze the
>    calls into other sections. These calls need to be annotated as safe
>    and intentional.

So the only tool I know of that does full callchains is smatch. And in
one of my series I did prod Dan about this.

The alternative is that we bite the bullet and add a vmlinux objtool
pass. This keeps getting mentioned, so maybe it is time :/ I'd hate it,
because it will increase build time at the slowest point, but it'd get
us the coverage we need here.
