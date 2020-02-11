Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592F9C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249D120656
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kvxfnr45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbgBKPrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:47:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47474 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgBKPrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AKYwQXO+5oCtuoLtBZCS0r3+gAqpZfv/88e+bxs1V30=; b=kvxfnr45cFLxq6OPlh0AwInZem
        qMvbeF4FT74/G1dIUEfhEZYC4+1JegHoCjHdsfa6GXbUPNZ6ITIcKq3Dsp1q7U8gtrEchxnIR92CG
        Fq2PY8psQfyQPRWJ0F3ejbZz/ofkyNRUDLmVDhzgkGMzM6VlrUsVGRStgSOHlRSQHMgOUnV5pEr91
        Z2SUZThVxywLTgguQ/i8L1yd/qn2TXqwz98eBJdskd2OOQGu6n9rwrio0cfkDJ21ApOat1alBAKdD
        DkszHqnJK+rDKlhGZvSi8crM1Uj5eh6qUe4t5pJLcW6mp1paBaEq2rFyh2LUxj+c/HwsVt/NO23IJ
        AIrpg1uQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1XkN-0002pO-Tq; Tue, 11 Feb 2020 15:46:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44108300446;
        Tue, 11 Feb 2020 16:44:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBD112B91E730; Tue, 11 Feb 2020 16:46:45 +0100 (CET)
Date:   Tue, 11 Feb 2020 16:46:45 +0100
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
Message-ID: <20200211154645.GX14914@hirez.programming.kicks-ass.net>
References: <20200211095047.58ddf750@gandalf.local.home>
 <504801580.617591.1581435278202.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <504801580.617591.1581435278202.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 10:34:38AM -0500, Mathieu Desnoyers wrote:
> 
> I'm puzzled by this function. It does:
> 
> perf_tp_event(...)
> {
>      hlist_for_each_entry_rcu(event, head, hlist_entry) {
>          ...
>      }
>      if (task && task != current) {
>          rcu_read_lock();
>          ... = rcu_dereference();
>          list_for_each_entry_rcu(...) {
>              ....
>          }
>          rcu_read_unlock();
>      }
> }
> 
> What is the purpose of the rcu_read_lock/unlock within the if (),
> considering that there is already an hlist rcu iteration just before ?
> It seems to assume that a RCU read-side of some kind of already
> ongoing.

IIRC the hlist_for_each_entry_rcu() uses the RCU stuff from the
tracepoint API, while the stuff inside the if() uses regular RCU.

Them were note the same one -- tracepoints used rcu-sched, perf used
rcu.
