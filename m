Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19BFC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D727206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgBLPsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:48:54 -0500
Received: from outbound-smtp55.blacknight.com ([46.22.136.239]:44703 "EHLO
        outbound-smtp55.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727458AbgBLPsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:48:54 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id 53B9BFA7BD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 15:48:52 +0000 (GMT)
Received: (qmail 23295 invoked from network); 12 Feb 2020 15:48:51 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Feb 2020 15:48:51 -0000
Date:   Wed, 12 Feb 2020 15:48:50 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/11] Reconcile NUMA balancing decisions with the
 load balancer
Message-ID: <20200212154850.GQ3466@techsingularity.net>
References: <20200212093654.4816-1-mgorman@techsingularity.net>
 <CAKfTPtA7LVe0wccghiQbRArfZZFz7xZwV3dsoQ_Jcdr4swVWZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtA7LVe0wccghiQbRArfZZFz7xZwV3dsoQ_Jcdr4swVWZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 02:22:03PM +0100, Vincent Guittot wrote:
> Hi Mel,
> 
> On Wed, 12 Feb 2020 at 10:36, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > The NUMA balancer makes placement decisions on tasks that partially
> > take the load balancer into account and vice versa but there are
> > inconsistencies. This can result in placement decisions that override
> > each other leading to unnecessary migrations -- both task placement and
> > page placement. This is a prototype series that attempts to reconcile the
> > decisions. It's a bit premature but it would also need to be reconciled
> > with Vincent's series "[PATCH 0/4] remove runnable_load_avg and improve
> > group_classify"
> >
> > The first three patches are unrelated and are either pending in tip or
> > should be but they were part of the testing of this series so I have to
> > mention them.
> >
> > The fourth and fifth patches are tracing only and was needed to get
> > sensible data out of ftrace with respect to task placement for NUMA
> > balancing. Patches 6-8 reduce overhead and reduce the changes of NUMA
> > balancing overriding itself. Patches 9-11 try and bring the CPU placement
> > decisions of NUMA balancing in line with the load balancer.
> 
> Don't know if it's only me but I can't find patches 9-11 on mailing list
> 

I think my outgoing SMTP must have decided I was spamming. I tried
resending just those patches.

At the moment, I'm redoing a series in top of tip taking the tracing
patches, yours on top (for testing) and the minor optimisations to see
what that gets me.  The reconcilation between NUMA balancing and load
balancing (patches 9-11) can be redone on top if the rest look ok.

-- 
Mel Gorman
SUSE Labs
