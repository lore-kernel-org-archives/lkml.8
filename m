Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7D5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533F02078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391078AbgEYOvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390995AbgEYOvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:51:43 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28981C061A0E;
        Mon, 25 May 2020 07:51:43 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdERu-00028q-3I; Mon, 25 May 2020 16:51:30 +0200
Date:   Mon, 25 May 2020 16:51:30 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Evgeniy Polyakov <zbr@ioremap.net>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 5/7] connector/cn_proc: Protect send_msg() with a
 local lock
Message-ID: <20200525145130.przpqlspg6nnylke@linutronix.de>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
 <20200524215739.551568-6-bigeasy@linutronix.de>
 <20200525071819.GD329373@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200525071819.GD329373@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-25 09:18:19 [+0200], Ingo Molnar wrote:
> > +static DEFINE_PER_CPU(struct local_evt, local_evt) = {
> > +	.counts = 0,
> 
> I don't think zero initializations need to be written out explicitly.
yes.

> > +	.lock = INIT_LOCAL_LOCK(lock),
> > +};
> >  
> >  static inline void send_msg(struct cn_msg *msg)
> >  {
> > -	preempt_disable();
> > +	local_lock(&local_evt.lock);
> >  
> > -	msg->seq = __this_cpu_inc_return(proc_event_counts) - 1;
> > +	msg->seq = __this_cpu_inc_return(local_evt.counts) - 1;
> 
> Naming nit: renaming this from 'proc_event_counts' to 
> 'local_evt.counts' is a step back IMO - what's an 'evt',
> did we run out of e's? ;-)
> 
> Should be something like local_event.count? (Singular.)

okay.

> Thanks,
> 
> 	Ingo

Sebastian
