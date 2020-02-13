Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A44C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3572206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgBMRCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:02:25 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:52772 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbgBMRCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:02:25 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 5DFE7B8875
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 17:02:23 +0000 (GMT)
Received: (qmail 7015 invoked from network); 13 Feb 2020 17:02:23 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 13 Feb 2020 17:02:23 -0000
Date:   Thu, 13 Feb 2020 17:02:21 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [RFC 2/4] sched/numa: replace runnable_load_avg by load_avg
Message-ID: <20200213170220.GA3466@techsingularity.net>
References: <20200212133715.GU3420@suse.de>
 <20200212194903.GS3466@techsingularity.net>
 <CAKfTPtDA5GamN4A1SnegYwYCk123TqUDE9EHFbHTgKCMR+yqGQ@mail.gmail.com>
 <20200213131658.9600-1-hdanton@sina.com>
 <20200213134655.GX3466@techsingularity.net>
 <20200213150026.GB6541@lorien.usersys.redhat.com>
 <20200213151430.GY3466@techsingularity.net>
 <CAKfTPtDjKW45QyXnF7Pu42AP48mNbDWTUttMSoDgDzOO5GSfnA@mail.gmail.com>
 <20200213163437.GZ3466@techsingularity.net>
 <CAKfTPtD8k-LMaXz_MNmxeW5aXDO4ZZ6j=gwCRTRU89OJ9nUEGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtD8k-LMaXz_MNmxeW5aXDO4ZZ6j=gwCRTRU89OJ9nUEGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 05:38:31PM +0100, Vincent Guittot wrote:
> > > Your test doesn't explicitly ensure that the 1 condition is met
> > >
> > > That being said, I'm not sure it's really a wrong thing ? I mean
> > > load_balance will probably try to pull back some tasks on src but as
> > > long as it is not a task with dst node as preferred node, it should
> > > not be that harmfull
> >
> > My thinking was that if source has as many or more running tasks than
> > the destination *after* the move that it's not harmful and does not add
> > work for the load balancer.
> 
> load_balancer will see an imbalance but fbq_classify_group/queue
> should be there to prevent from pulling back tasks that are on the
> preferred node but only other tasks
> 

Yes, exactly. Between fbq_classify and migrate_degrades_locality, I'm
expecting that the load balancer will only override NUMA balancing when
there is no better option. When the imbalance check, I want to avoid
the situation where NUMA balancing moves a task for locality, LB pulls
it back for balance, NUMA retries the move etc because it's stupid. The
locality matters but being continually dequeue/enqueue is unhelpful.

While there might be grounds for relaxing the degree an imbalance is
allowed across SD domains, I am avoiding looking in that direction again
until the load balancer and NUMA balancer stop overriding each other for
silly reasons (or the NUMA balancer fighting itself which can happen).

-- 
Mel Gorman
SUSE Labs
