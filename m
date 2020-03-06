Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E6CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5F82073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hK2++YzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgCFIky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 03:40:54 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35330 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgCFIky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b5AjsHscbwI1owfnFTdyAB+4fcyVggSrpzwiFpHNLpY=; b=hK2++YzUYjAqhxwL2oc1TcxkSP
        r1MUE2g2XnsXl6+37tytskVF2/PKJxKpH14gA9ZKNkkIXh6OGxz0Xyzs7scoqHBgGC57YNPWB0u0n
        0spRt410wprUOuEOfCquce+EF/lXkpSg3mzX463wwacwrVCsTMS8n5BE0wvCMEu4S3+wg+WHhRfDf
        8X8IHsJQ+xSUA8H891q+EcE9fSlR07Gesh4F1tpOHpBnHYe6dQEmG1q0LhcFuww4UekORHrYrRKbJ
        sc+0Hzv+zN6CmT7QfsZqUXqmOhLwcIJFICr9Er+aGfc4SarSfRnn5qGMtnfC7vaZs9fRzzB+xSAoC
        62gAhiYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jA8XC-0001dQ-GA; Fri, 06 Mar 2020 08:40:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B2BE23013A4;
        Fri,  6 Mar 2020 09:40:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9734D20139C6B; Fri,  6 Mar 2020 09:40:39 +0100 (CET)
Date:   Fri, 6 Mar 2020 09:40:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Paul Turner <pjt@google.com>
Cc:     Xi Wang <xii@google.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sched: watchdog: Touch kernel watchdog in sched code
Message-ID: <20200306084039.GC12561@hirez.programming.kicks-ass.net>
References: <20200304213941.112303-1-xii@google.com>
 <20200305075742.GR2596@hirez.programming.kicks-ass.net>
 <CAPM31RJdNtxmOi2eeRYFyvRKG9nofhqZfPgZGA5U7u8uZ2WXwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM31RJdNtxmOi2eeRYFyvRKG9nofhqZfPgZGA5U7u8uZ2WXwA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 02:11:49PM -0800, Paul Turner wrote:
> The goal is to improve jitter since we're constantly periodically
> preempting other classes to run the watchdog.   Even on a single CPU
> this is measurable as jitter in the us range.  But, what increases the
> motivation is this disruption has been recently magnified by CPU
> "gifts" which require evicting the whole core when one of the siblings
> schedules one of these watchdog threads.
> 
> The majority outcome being asserted here is that we could actually
> exercise pick_next_task if required -- there are other potential
> things this will catch, but they are much more braindead generally
> speaking (e.g. a bug in pick_next_task itself).

I still utterly hate what the patch does though; there is no way I'll
have watchdog code hook in the scheduler like this. That's just asking
for trouble.

Why isn't it sufficient to sample the existing context switch counters
from the watchdog? And why can't we fix that?
