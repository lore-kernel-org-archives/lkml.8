Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAA5C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63499214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d/miR5Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgBJJqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:46:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34694 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgBJJqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HtVwYWV3cLV9hlMU2I2fM3VGcjP7NCI9FS1vAT5oWZk=; b=d/miR5Ucnr1Ko8VrqfQcnmz/m+
        MFeAPPC+zn2e9JnXYsEiCfW2hylvQvSwa5/YvVmbyMAlZH1tdNdh7Yr3Ti4dYkjppiAD7FUfkyKxU
        bir7LbcRxe66ROH1xIaBK304aAKaib7L0p1tmpT+2fADJKlI2yae7j3shGpj4hHX2ikHdqD1gJ2bq
        q7riMT/was8SXX8aD0MSCdV8dijO1aznFla1eR2KrxeuytBB5qOqBwiSWk4FJBEXmSLgpfyQKI3AQ
        HuKN3pT1JiQ53PAye6UYjmMfAeFv00lqEE8mAmjgEselawNPP8FTTR5pCj365A2cqxtl3T37teb4X
        R9lGovDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j15e1-0006V9-9E; Mon, 10 Feb 2020 09:46:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C4090300739;
        Mon, 10 Feb 2020 10:44:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DB55D2B1D5568; Mon, 10 Feb 2020 10:46:16 +0100 (CET)
Date:   Mon, 10 Feb 2020 10:46:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Joel Fernandes, Google" <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [RFC 0/3] Revert SRCU from tracepoint infrastructure
Message-ID: <20200210094616.GC14879@hirez.programming.kicks-ass.net>
References: <20200207205656.61938-1-joel@joelfernandes.org>
 <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2020 at 11:31:25AM -0500, Mathieu Desnoyers wrote:
> ----- On Feb 7, 2020, at 3:56 PM, Joel Fernandes, Google joel@joelfernandes.org wrote:
> 
> > Hi,
> > These patches remove SRCU usage from tracepoints. The reason for proposing the
> > reverts is because the whole point of SRCU was to avoid having to call
> > rcu_irq_enter_irqson(). However this was added back in 865e63b04e9b2 ("tracing:
> > Add back in rcu_irq_enter/exit_irqson() for rcuidle tracepoints") because perf
> > was breaking..
> 
> I think the original patch re-enabling the rcu_irq_enter/exit_irqson() is a
> tracepoint band-aid over what should actually been fixed within perf instead.
> 
> Perf should not do rcu_read_lock/unlock()/synchronize_rcu(), but rather use
> tracepoint_synchronize_unregister() to match the read-side provided by
> tracepoints.
> 
> If perf can then just rely on the underlying synchronization provided by each
> instrumentation providers (tracepoint, kprobe, ...) and not explicitly add its own
> unneeded synchronization on top (e.g. rcu_read_lock/unlock), then it should simplify
> all this.

It can't. At this point it doesn't know where the event came from. Also,
the whole perf stuff is per definition non-preemptible, as it needs to
run from NMI context.

Furthermore, using srcu would be detrimental, because of how it has
smp_mb() in the read side primitives.

The best we can do is move that rcu_irq_enter/exit_*() crud into the
perf tracepoint glue I suppose.
