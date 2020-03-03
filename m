Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37D5C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2F620863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgCCLot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:44:49 -0500
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:41772 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727738AbgCCLot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:44:49 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp02.blacknight.com (Postfix) with ESMTPS id CC9D7BA998
        for <linux-kernel@vger.kernel.org>; Tue,  3 Mar 2020 11:44:46 +0000 (GMT)
Received: (qmail 25366 invoked from network); 3 Mar 2020 11:44:46 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Mar 2020 11:44:46 -0000
Date:   Tue, 3 Mar 2020 11:44:44 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Paul McKenney <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] sched/fair: Fix statistics for find_idlest_group()
Message-ID: <20200303114444.GM3818@techsingularity.net>
References: <20200303110258.1092-1-mgorman@techsingularity.net>
 <20200303110258.1092-2-mgorman@techsingularity.net>
 <CAKfTPtC5LAU9mmfqX9qydR-GQekXrSSNTErONm493UBpZWHZsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtC5LAU9mmfqX9qydR-GQekXrSSNTErONm493UBpZWHZsA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 12:14:07PM +0100, Vincent Guittot wrote:
> Hi Mel,
> 
> On Tue, 3 Mar 2020 at 12:03, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > From: Vincent Guittot <vincent.guittot@linaro.org>
> >
> > From: Vincent Guittot <vincent.guittot@linaro.org>
> >
> > sgs->group_weight is not set while gathering statistics in
> > update_sg_wakeup_stats(). This means that a group can be classified as
> > fully busy with 0 running tasks if utilization is high enough.
> >
> > This path is mainly used for fork and exec.
> >
> > Fixes: 57abff067a08 ("sched/fair: Rework find_idlest_group()")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> > Acked-by: Mel Gorman <mgorman@techsingularity.net>
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > Link: https://lore.kernel.org/r/20200218144534.4564-1-vincent.guittot@linaro.org
> 
> This one has been merged in tip/sched/urgent
> 

I know and it appears in next but not in mainline yet. As tip/sched/core
is the development baseline for scheduler patches, it should have the
patch -- most likely via mainline to preserve git history. By including
it here, I wanted to highlight that anyone working on tip/sched/core at
the moment should include the patch if they want to avoid invalidating
any test results.

-- 
Mel Gorman
SUSE Labs
