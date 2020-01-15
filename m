Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4C4C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187812467A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAONSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:18:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgAONSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:18:34 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C2CE2084D;
        Wed, 15 Jan 2020 13:18:33 +0000 (UTC)
Date:   Wed, 15 Jan 2020 08:18:30 -0500
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
Message-ID: <20200115081830.036ade4e@gandalf.local.home>
In-Reply-To: <878a35a6642d482aa0770a055506bd5e@AcuMS.aculab.com>
References: <212fabd759b0486aa8df588477acf6d0@AcuMS.aculab.com>
        <20200114115906.22f952ff@gandalf.local.home>
        <5ba2ae2d426c4058b314c20c25a9b1d0@AcuMS.aculab.com>
        <20200114124812.4d5355ae@gandalf.local.home>
        <878a35a6642d482aa0770a055506bd5e@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2020 12:44:19 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> > Yes, even with CONFIG_PREEMPT, Linux has no guarantees of latency for
> > any task regardless of priority. If you have latency requirements, then
> > you need to apply the PREEMPT_RT patch (which may soon make it to
> > mainline this year!), which spin locks and bh wont stop a task from
> > scheduling (unless they need the same lock)  

Every time you add something to allow higher priority processes to run
with less latency you add overhead. By just adding that spinlock check
or to migrate a process to a idle cpu will add a measurable overhead,
and as you state, distros won't like that.

It's a constant game of give and take.

> 
> Running the driver bh (which is often significant) from a high priority
> worker thread instead of a softint (which isn't much different to the
> 'hardint' it is scheduled from) probably doesn't cost much (in-kernel
> process switches shouldn't be much more than a stack switch).
> That would benefit RT processes since they could be higher
> priority than the bh code.
> Although you'd probably want a 'strongly preferred' cpu for them.

BTW, I believe distros compile with "CONFIG_IRQ_FORCED_THREADING" which
means if you add to the kernel command line "threadirqs" the interrupts
will be run as threads. Which allows for even more preemption.

-- Steve

