Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03059C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58CE20753
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgCTQog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:44:36 -0400
Received: from outbound-smtp03.blacknight.com ([81.17.249.16]:60590 "EHLO
        outbound-smtp03.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727217AbgCTQog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:44:36 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp03.blacknight.com (Postfix) with ESMTPS id A0A92C0CD5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 16:44:34 +0000 (GMT)
Received: (qmail 4795 invoked from network); 20 Mar 2020 16:44:34 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Mar 2020 16:44:34 -0000
Date:   Fri, 20 Mar 2020 16:44:32 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Track possibly overloaded domains and
 abort a scan if necessary
Message-ID: <20200320164432.GE3818@techsingularity.net>
References: <20200320151245.21152-1-mgorman@techsingularity.net>
 <20200320151245.21152-5-mgorman@techsingularity.net>
 <CAKfTPtAUuO1Jp6P73gAiP+g5iLTx16UeBgBjm_5zjFxwiBD9=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtAUuO1Jp6P73gAiP+g5iLTx16UeBgBjm_5zjFxwiBD9=Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 04:48:39PM +0100, Vincent Guittot wrote:
> > ---
> >  include/linux/sched/topology.h |  1 +
> >  kernel/sched/fair.c            | 65 +++++++++++++++++++++++++++++++++++++++---
> >  kernel/sched/features.h        |  3 ++
> >  3 files changed, 65 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> > index af9319e4cfb9..76ec7a54f57b 100644
> > --- a/include/linux/sched/topology.h
> > +++ b/include/linux/sched/topology.h
> > @@ -66,6 +66,7 @@ struct sched_domain_shared {
> >         atomic_t        ref;
> >         atomic_t        nr_busy_cpus;
> >         int             has_idle_cores;
> > +       int             is_overloaded;
> 
> Can't nr_busy_cpus compared to sd->span_weight give you similar status  ?
> 

It's connected to nohz balancing and I didn't see how I could use that
for detecting overload. Also, I don't think it ever can be larger than
the sd weight and overload is based on the number of running tasks being
greater than the number of available CPUs. Did I miss something obvious?

-- 
Mel Gorman
SUSE Labs
