Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C43C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8594207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388145AbgFSRju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:39:50 -0400
Received: from foss.arm.com ([217.140.110.172]:50616 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730934AbgFSRjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:39:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83143D6E;
        Fri, 19 Jun 2020 10:39:48 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFA8A3F71F;
        Fri, 19 Jun 2020 10:39:46 -0700 (PDT)
Date:   Fri, 19 Jun 2020 18:39:44 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Fix initialization of strut uclamp_rq
Message-ID: <20200619173944.blwuimtuqmcxlj2v@e107158-lin.cambridge.arm.com>
References: <20200618195525.7889-1-qais.yousef@arm.com>
 <20200618195525.7889-2-qais.yousef@arm.com>
 <20200619173055.GA576888@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200619173055.GA576888@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/20 19:30, Peter Zijlstra wrote:
> On Thu, Jun 18, 2020 at 08:55:24PM +0100, Qais Yousef wrote:
> 
> > +	for_each_clamp_id(clamp_id) {
> > +		memset(uc_rq[clamp_id].bucket,
> > +		       0,
> > +		       sizeof(struct uclamp_bucket)*UCLAMP_BUCKETS);
> > +
> > +		uc_rq[clamp_id].value = uclamp_none(clamp_id);
> 
> I think you can replace all that with:
> 
> 		*uc_rq = (struct uclamp_rq){
> 			.value = uclamp_none(clamp_id),
> 		};
> 
> it's shorter and is free or weird line-breaks :-)

Sure. I just sent v2 so that people will be encouraged to run tests hopefully.
But will fix in v3.

Do we actually need to 0 out anything here? Shouldn't the runqueues all be in
BSS which gets initialized to 0 by default at boot?

Maybe better stay explicit..

Thanks

--
Qais Yousef
