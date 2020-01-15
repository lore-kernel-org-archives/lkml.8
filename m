Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F7CC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA90D24679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgAOOXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:23:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:52410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgAOOXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:23:15 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FA0A24671;
        Wed, 15 Jan 2020 14:23:14 +0000 (UTC)
Date:   Wed, 15 Jan 2020 09:23:12 -0500
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
Message-ID: <20200115092312.45159939@gandalf.local.home>
In-Reply-To: <3960d46b3a4a4053a696a98ee6fd131d@AcuMS.aculab.com>
References: <212fabd759b0486aa8df588477acf6d0@AcuMS.aculab.com>
        <20200114115906.22f952ff@gandalf.local.home>
        <5ba2ae2d426c4058b314c20c25a9b1d0@AcuMS.aculab.com>
        <20200114124812.4d5355ae@gandalf.local.home>
        <3960d46b3a4a4053a696a98ee6fd131d@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jan 2020 12:57:10 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> I'm surprised the 'normal case' for tracing function entry isn't done
> in assembler without saving all the registers (etc).

Well, it doesn't save all registers unless you ask it to. It only saves
what the compiler mandates for "fentry" before calling C code.

> For tsc stamps I think it should be possible saving just 3 registers
> in under 32 instructions. Scaling to ns is a bit harder.
> It's a shame the ns scaling isn't left to the reading code.

Well, it could be done, as the ring buffer allows you to post process
timestamps. You could switch to using just tsc:

 echo x86-tsc > /sys/kernel/tracing/trace_clock

One reason that we do not post process the scaling to ns is that the
scaling can change over time depending on the clock source, which means
post processing will give you in accurate results. But the
infrastructure is there to do it.

-- Steve


