Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5BCC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A4420733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 10:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g8z0NGMI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBJKUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 05:20:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJKUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 05:20:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Og2/sR+EpPhzVLDU70FpiS/OXyn2MIXo3lrPW/wFe1Q=; b=g8z0NGMIzR7qFLDc3lNCPU5Ka7
        KCK/YXSRzcKh0ou5w7wRBKYPxJSSq0fPHrBZAaKiTNZDswZ1IRxvTGW7mMuM6eyA8gHphvh5ljry8
        h2OMMYS0ktFdDtZ2lpJP7iTd4MAlaGRqNi1ZgI4ZaKN1U3flrMzK3vjWH9RoYeSSZXepQ5sFvlRwn
        XEx8urRC+jZrLq6e2bTPtqSQrPbFGAU7JlTI4njPjxp2j/l1Y9dLXAtTvVpcMGXY6weKircSoaY1V
        t1iMpDq2haHicH5VMTsC8SkIRvLtZwWmJte2SJ6GcDJyPyhFvbDS1nIserQM0PtaRUu9XiB3pVqAV
        /VFm6qZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j16Ac-0003kh-1Y; Mon, 10 Feb 2020 10:20:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7A1AC300446;
        Mon, 10 Feb 2020 11:18:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 977DD2B835253; Mon, 10 Feb 2020 11:19:58 +0100 (CET)
Date:   Mon, 10 Feb 2020 11:19:58 +0100
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
Message-ID: <20200210101958.GV14946@hirez.programming.kicks-ass.net>
References: <20200207205656.61938-1-joel@joelfernandes.org>
 <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com>
 <20200210094616.GC14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210094616.GC14879@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:46:16AM +0100, Peter Zijlstra wrote:
> On Sat, Feb 08, 2020 at 11:31:25AM -0500, Mathieu Desnoyers wrote:
> > ----- On Feb 7, 2020, at 3:56 PM, Joel Fernandes, Google joel@joelfernandes.org wrote:
> > 
> > > Hi,
> > > These patches remove SRCU usage from tracepoints. The reason for proposing the
> > > reverts is because the whole point of SRCU was to avoid having to call
> > > rcu_irq_enter_irqson(). However this was added back in 865e63b04e9b2 ("tracing:
> > > Add back in rcu_irq_enter/exit_irqson() for rcuidle tracepoints") because perf
> > > was breaking..
> > 
> > I think the original patch re-enabling the rcu_irq_enter/exit_irqson() is a
> > tracepoint band-aid over what should actually been fixed within perf instead.
> > 
> > Perf should not do rcu_read_lock/unlock()/synchronize_rcu(), but rather use
> > tracepoint_synchronize_unregister() to match the read-side provided by
> > tracepoints.
> > 
> > If perf can then just rely on the underlying synchronization provided by each
> > instrumentation providers (tracepoint, kprobe, ...) and not explicitly add its own
> > unneeded synchronization on top (e.g. rcu_read_lock/unlock), then it should simplify
> > all this.
> 
> It can't. At this point it doesn't know where the event came from. Also,
> the whole perf stuff is per definition non-preemptible, as it needs to
> run from NMI context.
> 
> Furthermore, using srcu would be detrimental, because of how it has
> smp_mb() in the read side primitives.
> 
> The best we can do is move that rcu_irq_enter/exit_*() crud into the
> perf tracepoint glue I suppose.

I can't even tell how to do that; the knowledge of this is long gone by
the time we get there. That is, the @rcuidle state is lost in
__DO_TRACE(), it is not passed further down the chain.

Just to clarify; perf doesn't care about the tracepoint synchronization
beyond the glue code. Perf uses RCU itself for it's own purposes.
