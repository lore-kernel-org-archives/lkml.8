Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B388C35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205242176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 11:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgBYL7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 06:59:05 -0500
Received: from outbound-smtp07.blacknight.com ([46.22.139.12]:45237 "EHLO
        outbound-smtp07.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726587AbgBYL7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 06:59:04 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp07.blacknight.com (Postfix) with ESMTPS id D06861C346A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 11:59:02 +0000 (GMT)
Received: (qmail 17056 invoked from network); 25 Feb 2020 11:59:02 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Feb 2020 11:59:02 -0000
Date:   Tue, 25 Feb 2020 11:59:01 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200225115901.GB3466@techsingularity.net>
References: <20200224095223.13361-1-mgorman@techsingularity.net>
 <20200224151641.GA24316@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200224151641.GA24316@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 04:16:41PM +0100, Ingo Molnar wrote:
> 
> * Mel Gorman <mgorman@techsingularity.net> wrote:
> 
> > The only differences in V6 are due to Vincent's latest patch series.
> > 
> > This is V5 which includes the latest versions of Vincent's patch
> > addressing review feedback. Patches 4-9 are Vincent's work plus one
> > important performance fix. Vincent's patches were retested and while
> > not presented in detail, it was mostly an improvement.
> > 
> > Changelog since V5:
> > o Import Vincent's latest patch set
> 
> >  include/linux/sched.h        |  31 ++-
> >  include/trace/events/sched.h |  49 ++--
> >  kernel/sched/core.c          |  13 -
> >  kernel/sched/debug.c         |  17 +-
> >  kernel/sched/fair.c          | 626 ++++++++++++++++++++++++++++---------------
> >  kernel/sched/pelt.c          |  59 ++--
> >  kernel/sched/sched.h         |  42 ++-
> >  7 files changed, 535 insertions(+), 302 deletions(-)
> 
> Applied to tip:sched/core for v5.7 inclusion, thanks Mel and Vincent!
> 

Thanks!

> Please base future iterations on top of a0f03b617c3b (current 
> sched/core).
> 

Will do.

However I noticed that "sched/fair: Fix find_idlest_group() to handle
CPU affinity" did not make it to tip/sched/core. Peter seemed to think it
was fine. Was it rejected or is it just sitting in Peter's queue somewhere?

-- 
Mel Gorman
SUSE Labs
