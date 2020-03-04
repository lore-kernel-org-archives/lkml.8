Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB37C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A76821556
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgCDUB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:01:59 -0500
Received: from foss.arm.com ([217.140.110.172]:39010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDUB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 15:01:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1700A1FB;
        Wed,  4 Mar 2020 12:01:58 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7D8F3F6C4;
        Wed,  4 Mar 2020 12:01:56 -0800 (PST)
Date:   Wed, 4 Mar 2020 20:01:54 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] sched/rt: cpupri_find: Implement fallback
 mechanism for !fit case
Message-ID: <20200304200153.c4e2p7qnko54pejt@e107158-lin.cambridge.arm.com>
References: <20200302132721.8353-1-qais.yousef@arm.com>
 <20200302132721.8353-2-qais.yousef@arm.com>
 <20200304112739.7b99677e@gandalf.local.home>
 <20200304173925.43xq4wztummxgs3x@e107158-lin.cambridge.arm.com>
 <20200304135404.146c56eb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200304135404.146c56eb@gandalf.local.home>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/20 13:54, Steven Rostedt wrote:
> > If we fix 1, then assuming found == -1 for all level, we'll still have the
> > problem that the mask is stale.
> > 
> > We can do a full scan again as Tao was suggestion, the 2nd one without any
> > fitness check that is. But isn't this expensive?
> 
> I was hoping to try to avoid that, but it's not that expensive and will
> probably seldom happen. Perhaps we should run some test cases and trace the
> results to see how often that can happen.
> 
> > 
> > We risk the mask being stale anyway directly after selecting it. Or a priority
> > level might become the lowest level just after we dismissed it.
> 
> Sure, but that's still a better effort.

Okay let me run some quick tests and send an updated series if it doesn't
return something suspicious.

Are you happy with the rest of the series then?

> > There's another 'major' problem that I need to bring your attention to,
> > find_lowest_rq() always returns the first CPU in the mask.
> > 
> > See discussion below for more details
> > 
> > 	https://lore.kernel.org/lkml/20200219140243.wfljmupcrwm2jelo@e107158-lin/
> > 
> > In my test because multiple tasks wakeup together they all end up going to CPU1
> > (the first fitting CPU in the mask), then just to be pushed back again. Not
> > necessarily to where they were running before.
> > 
> > Not sure if there are other situations where this could happen.
> > 
> > If we fix this problem then we can help reduce the effect of this raciness in
> > find_lowest_rq(), and end up with less ping-ponging if tasks happen to
> > wakeup/sleep at the wrong time during the scan.
> 
> Hmm, I wonder if there's a fast way of getting the next CPU from the
> current cpu the task is on. Perhaps that will help in the ping ponging.

I think there's for_each_cpu_wrap() or some variant of it that allows to start
from a random place.

This won't help if there's a single cpu in the mask. Or when
nr_waking_tasks > nr_cpus_in_lowest_rq. Still an improvement over the current
behavior nonetheless.

The other option is maybe to mark that cpu unavailable once selected so the
next search can't return it. But when do you mark it available back again?

Thanks

--
Qais Yousef
