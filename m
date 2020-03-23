Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13B1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E37720781
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCWOxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 10:53:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41630 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgCWOxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 10:53:17 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jGOS3-0000Lp-0M; Mon, 23 Mar 2020 15:53:15 +0100
Date:   Mon, 23 Mar 2020 15:53:14 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 2/3] lockdep: Merge hardirq_threaded and irq_config
 together
Message-ID: <20200323145314.v57acriqj2s6wry2@linutronix.de>
References: <20200323033207.32370-1-frederic@kernel.org>
 <20200323033207.32370-3-frederic@kernel.org>
 <20200323140220.GK2452@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200323140220.GK2452@worktop.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-23 15:02:20 [+0100], Peter Zijlstra wrote:
> On Mon, Mar 23, 2020 at 04:32:06AM +0100, Frederic Weisbecker wrote:
> > These fields describe the same state: a code block running in hardirq
> > that might be threaded under specific configurations.
> > 
> > Merge them together in the same field. Also rename the result as
> > "hardirq_threadable" as we are talking about a possible state and not
> > an actual one.
> 
> What isn't instantly obvious is that they cannot overlap. For instance
> mainline with force threaded interrupt handlers on, can't that have the
> irq_work nest inside a threaded handler ?

I remember we kept them due to the nesting. A threaded-interrupt can be
interrupted by irq_work/hrtimer/posix-timer. 
So in a threaded interrupt it is okay to use a sleeping lock. It is not
okay with irq_work on-top - unless it is the non-atomic one.

> I *think* it just about works out, but it definitely wants a little more
> than this.

Sebastian
