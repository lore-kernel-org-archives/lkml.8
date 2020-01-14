Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540A6C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309FD24658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgANRsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:48:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANRsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:48:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C52924676;
        Tue, 14 Jan 2020 17:48:14 +0000 (UTC)
Date:   Tue, 14 Jan 2020 12:48:12 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Vincent Guittot' <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched/fair: scheduler not running high priority process on idle
 cpu
Message-ID: <20200114124812.4d5355ae@gandalf.local.home>
In-Reply-To: <5ba2ae2d426c4058b314c20c25a9b1d0@AcuMS.aculab.com>
References: <212fabd759b0486aa8df588477acf6d0@AcuMS.aculab.com>
        <20200114115906.22f952ff@gandalf.local.home>
        <5ba2ae2d426c4058b314c20c25a9b1d0@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 17:33:50 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> I have added a cond_resched() to the offending loop, but a close look implies
> that code is called with a lock held in another (less common) path so that
> can't be directly committed and so CONFIG_PREEMPT won't help.
> 
> Indeed requiring CONFIG_PREEMPT doesn't help when customers are running
> the application, nor (probably) on AWS since I doubt it is ever the default.
> 
> Does the same apply to non-RT tasks?
> I can select almost any priority, but RT ones are otherwise a lot better.
> 
> I've also seen RT processes delayed by the network stack 'bh' that runs
> in a softint from the hardware interrupt.
> That can take a while (clearing up tx and refilling rx) and I don't think we
> have any control over the cpu it runs on?

Yes, even with CONFIG_PREEMPT, Linux has no guarantees of latency for
any task regardless of priority. If you have latency requirements, then
you need to apply the PREEMPT_RT patch (which may soon make it to
mainline this year!), which spin locks and bh wont stop a task from
scheduling (unless they need the same lock).

> 
> The cost of ftrace function call entry/exit (about 200 clocks) makes it
> rather unsuitable for any performance measurements unless only
> a very few functions are traced - which rather requires you know
> what the code is doing :-(
> 

Well, when I use function tracing, I start all of them, analyze the
trace, then the functions I don't care about (usually spin locks and
other utils), I add to the set_ftrace_notrace file,  which keeps them
from being part of the trace. I keep doing this until I find a set of
functions that doesn't hurt overhead as much and gives me enough
information to know what is happening. It also helps to enable all or
most events (at least scheduling events).

-- Steve
