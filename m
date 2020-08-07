Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D71C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 458612075A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 20:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgHGUVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 16:21:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHGUVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:21:50 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A02002074D;
        Fri,  7 Aug 2020 20:21:49 +0000 (UTC)
Date:   Fri, 7 Aug 2020 16:21:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, will@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, elver@google.com,
        paulmck@kernel.org, rjw@rjwysocki.net
Subject: Re: [RFC][PATCH 2/3] locking,entry: #PF vs TRACE_IRQFLAGS
Message-ID: <20200807162148.48d96247@oasis.local.home>
In-Reply-To: <20200807193018.060388629@infradead.org>
References: <20200807192336.405068898@infradead.org>
        <20200807193018.060388629@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Aug 2020 21:23:38 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Much of the complexity in irqenter_{enter,exit}() is due to #PF being
> the sole exception that can schedule from kernel context.
> 
> One additional wrinkle with #PF is that it is non-maskable, it can
> happen _anywhere_. Due to this, and the wonders of tracing, we can get
> the 'normal' NMI nesting vs TRACE_IRQFLAGS:
> 
> 	local_irq_disable()
> 	  raw_local_irq_disable();
> 	  trace_hardirqs_off();
> 
> 	local_irq_enable();

Do you mean to have that ';' there? That is, it the below is called
from local_irq_enable(), right? A ';' means that local_irq_enable()
is completed.


> 	  trace_hardirqs_on();
> 	  <#PF>
> 	    trace_hardirqs_off()
> 	    ...
> 	    if (!regs_irqs_disabled(regs)

regs has it disabled, so this is false, right?

> 	      trace_hardirqs_on();
> 	  </#PF>

I missed the '/' in the above. At first I thought this was another page
fault :-/

> 	  // WHOOPS -- lockdep thinks IRQs are disabled again!
> 	  raw_local_irqs_enable();
> 
> Rework irqenter_{enter,exit}() to save/restore the software state.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/entry-common.h |    1 
>  kernel/entry/common.c        |   52 ++++++++++++++++++++-----------------------
>  2 files changed, 26 insertions(+), 27 deletions(-)
> 
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -310,6 +310,7 @@ void irqentry_exit_to_user_mode(struct p
>  #ifndef irqentry_state
>  typedef struct irqentry_state {
>  	bool	exit_rcu;
> +	bool	irqs_enabled;

Instead of passing a structure around, should we look at converting
"irqentry_state" into a flags field?

-- Steve


>  } irqentry_state_t;
>  #endif
>  
