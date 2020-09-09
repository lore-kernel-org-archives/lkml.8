Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A0FC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 14:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3B222204
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 14:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgIINHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbgIINAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:00:02 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988FBC0617A4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 05:59:16 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kFzgn-00028L-5e; Wed, 09 Sep 2020 14:59:05 +0200
Message-ID: <729431b40a2c0744f8f5496f7f90c612a318bd8c.camel@pengutronix.de>
Subject: Re: [PATCH] sched/deadline: Fix stale throttling on de-/boosted
 tasks
From:   Lucas Stach <l.stach@pengutronix.de>
To:     peterz@infradead.org, Juri Lelli <juri.lelli@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Date:   Wed, 09 Sep 2020 14:59:01 +0200
In-Reply-To: <20200902094339.GZ1362448@hirez.programming.kicks-ass.net>
References: <20200831110719.2126930-1-l.stach@pengutronix.de>
         <20200902060024.GK16601@localhost.localdomain>
         <20200902094339.GZ1362448@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2020-09-02 at 11:43 +0200, peterz@infradead.org wrote:
> On Wed, Sep 02, 2020 at 08:00:24AM +0200, Juri Lelli wrote:
> > On 31/08/20 13:07, Lucas Stach wrote:
> > > When a boosted task gets throttled, what normally happens is that it's
> > > immediately enqueued again with ENQUEUE_REPLENISH, which replenishes the
> > > runtime and clears the dl_throttled flag. There is a special case however:
> > > if the throttling happened on sched-out and the task has been deboosted in
> > > the meantime, the replenish is skipped as the task will return to its
> > > normal scheduling class. This leaves the task with the dl_throttled flag
> > > set.
> > > 
> > > Now if the task gets boosted up to the deadline scheduling class again
> > > while it is sleeping, it's still in the throttled state. The normal wakeup
> > > however will enqueue the task with ENQUEUE_REPLENISH not set, so we don't
> > > actually place it on the rq. Thus we end up with a task that is runnable,
> > > but not actually on the rq and neither a immediate replenishment happens,
> > > nor is the replenishment timer set up, so the task is stuck in
> > > forever-throttled limbo.
> > > 
> > > Clear the dl_throttled flag before dropping back to the normal scheduling
> > > class to fix this issue.
> > > 
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Acked-by: Juri Lelli <juri.lelli@redhat.com>
> 
> Thanks!

Does this mean the patch will get picked up as-is, or are there any
changes required?

Regards,
Lucas

