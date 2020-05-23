Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA75C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 15:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAB432072C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 15:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387924AbgEWPAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 11:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbgEWPAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 11:00:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63711C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 08:00:20 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jcVcl-0002JA-PR; Sat, 23 May 2020 16:59:43 +0200
Date:   Sat, 23 May 2020 16:59:42 +0200
From:   "Sebastian A. Siewior" <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 07/25] lockdep: Add preemption disabled assertion API
Message-ID: <20200523145942.vjk3z6pbj6yicqa4@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-8-a.darwish@linutronix.de>
 <20200522175503.GQ325280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200522175503.GQ325280@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-22 19:55:03 [+0200], Peter Zijlstra wrote:
> On Tue, May 19, 2020 at 11:45:29PM +0200, Ahmed S. Darwish wrote:
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index 206774ac6946..54c929ea5b98 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -702,6 +702,14 @@ do {									\
> >  			  "Not in hardirq as expected\n");		\
> >  	} while (0)
> >  
> > +/*
> > + * Don't define this assertion here to avoid a call-site's header file
> > + * dependency on sched.h task_struct current. This is needed by call
> > + * sites that are inline defined at header files already included by
> > + * sched.h.
> > + */
> > +void lockdep_assert_preemption_disabled(void);
> 
> So how about:
> 
> #if defined(CONFIG_PREEMPT_COUNT) && defined(CONFIG_TRACE_IRQFLAGS)
> #define lockdep_assert_preemption_disabled() do { \
> 		WARN_ON(debug_locks && !preempt_count() && \
> 			current->hardirqs_enabled); \
> 	} while (0)
> #else
> #define lockdep_assert_preemption_disabled() do { } while (0)
> #endif
> 
> That is both more consistent with the things you claim it's modelled
> after and also completely avoids that header dependency.

So we need additionally: 

- #include <linux/sched.h> in include/linux/flex_proportions.h
  and I think un another file as well.

- write_seqcount_t_begin_nested() as a define

- write_seqcount_t_begin() as a define

Any "static inline" in the header file using
lockdep_assert_preemption_disabled() will tro to complain about missing
current-> define. But yes, it will work otherwise.

Sebastian
