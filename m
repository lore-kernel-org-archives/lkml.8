Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4ECC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6416021734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aJhnL6Z0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgBLPNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:13:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBLPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AtDlHsHdJYw9Acg+nv5hW6g32wmo5pQtiQDIUjErmK8=; b=aJhnL6Z0fp8rayjYmoqat0GkJu
        eyw/ghH0eLAZksbKxMzu7hVYO+vVVm2UpQQhZ8eJo786gs6zvmD3uZJv4T+xauYLsWzU5B8DgFaXX
        Va827NYdXYxcIBbJ0lfzn346UgeDk9xl2NgfYIdYyEhbu57XDQH1lQ6Gt+pXApx+98Joo3e9rNL2e
        Qeg+VNYr3biYITLKRztn9m+SYlGAsRkYo5niOV0ZNnBv2G5Dzdzpy27kLNKIZwUPlrASLRrxrR/G+
        5rE5fTGOl5aOIB1lF7us+Xg4iPz0hu0FBRHhdXrF7Rqr5pTSZKLuAmwyQZSQpVmo86n4XSJy9xpvY
        C4z8d/nw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1th9-0000qm-NK; Wed, 12 Feb 2020 15:12:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AD4CC305803;
        Wed, 12 Feb 2020 16:11:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C513D2032662E; Wed, 12 Feb 2020 16:12:53 +0100 (CET)
Date:   Wed, 12 Feb 2020 16:12:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH 8/8] tracing: Remove regular RCU context for _rcuidle
 tracepoints (again)
Message-ID: <20200212151253.GU14897@hirez.programming.kicks-ass.net>
References: <20200212093210.468391728@infradead.org>
 <20200212094108.063885035@infradead.org>
 <20200212092952.7bec74e9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212092952.7bec74e9@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 09:29:52AM -0500, Steven Rostedt wrote:
> On Wed, 12 Feb 2020 10:32:18 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Effectively revert commit 865e63b04e9b2 ("tracing: Add back in
> > rcu_irq_enter/exit_irqson() for rcuidle tracepoints") now that we've
> > taught perf how to deal with not having an RCU context provided.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/linux/tracepoint.h |    8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -179,10 +179,8 @@ static inline struct tracepoint *tracepo
> >  		 * For rcuidle callers, use srcu since sched-rcu	\
> >  		 * doesn't work from the idle path.			\
> >  		 */							\
> > -		if (rcuidle) {						\
> > +		if (rcuidle)						\
> >  			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
> > -			rcu_irq_enter_irqsave();			\
> > -		}							\
> >  									\
> >  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
> >  									\
> > @@ -194,10 +192,8 @@ static inline struct tracepoint *tracepo
> >  			} while ((++it_func_ptr)->func);		\
> >  		}							\
> >  									\
> > -		if (rcuidle) {						\
> > -			rcu_irq_exit_irqsave();				\
> > +		if (rcuidle)						\
> >  			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
> > -		}							\
> >  									\
> >  		preempt_enable_notrace();				\
> >  	} while (0)
> > 
> 
> Which looks basically the same as this patch...
> 
>   https://lore.kernel.org/r/20200211095047.58ddf750@gandalf.local.home

It is a straight revert of 865e63b04e9b2, how different do you want it
to look?

Also it very much isn't that patch, as this one only does the revert and
doesn't mix it in with other stuff.
