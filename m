Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035FFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE0F2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403831AbgFXMK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:10:27 -0400
Received: from foss.arm.com ([217.140.110.172]:41368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388522AbgFXMKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:10:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91C0C1F1;
        Wed, 24 Jun 2020 05:10:24 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7785C3F6CF;
        Wed, 24 Jun 2020 05:10:23 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:10:21 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] Sched: Add a tracepoint to track rq->nr_running
Message-ID: <20200624121020.a5oijq4aenvhqi62@e107158-lin.cambridge.arm.com>
References: <20200619141120.1476-1-pauld@redhat.com>
 <20200622121746.b43ziyjq2eqsseym@e107158-lin.cambridge.arm.com>
 <20200623193819.GG83220@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623193819.GG83220@lorien.usersys.redhat.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil

On 06/23/20 15:38, Phil Auld wrote:

[...]

> > This is a very specific call site, so I guess it looks fine to pass very
> > specific info too.
> > 
> > But I think we can do better by just passing struct rq and add a new helper
> > sched_trace_rq_nr_running() (see the bottom of fair.c for a similar helper
> > functions for tracepoints).
> > 
> > This will allow the user to extract, cpu, nr_running and potentially other info
> > while only pass a single argument to the tracepoint. Potentially extending its
> > future usefulness.
> 
> I can certainly add a sched_trace_rq_nr_running helper and pass the *rq if
> you think that is really important. 

As I said, this is a very specific call site, so passing specific info should
be fine, so not really important.

My general view on this (which is influenced by what Peter asked for when we
first introduced this) is that it's better to allow a trace point to
extract more signals from this specific call site by passing generic info and
let the event code/module do what it wants.

But the idea behind these tracepoints is that they can evolve when they need
to. So I don't think we should hung up on this if it makes things unnecessarily
complex.

> 
> I'd prefer to keep the count field though as that is the only way to tell
> if this is an add_nr_running or sub_nr_running from looking at a single
> trace event.

Passing the count field is fine by me...

> 
> I could make it two different tracepoints.  Would that be better? To me that
> seemed more complicated though. The tooling would need to look at it
> different events and there would be more kernel change.

... but splitting the tracepoint doesn't look pretty.

If passing the rq and the count is enough for you, I'd vote this is better. If
not, then I won't insist into twisting things too much for the sake of it.

Thanks

--
Qais Yousef
