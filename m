Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6E7C35666
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 18:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A978206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 18:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgBWSkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 13:40:09 -0500
Received: from foss.arm.com ([217.140.110.172]:50442 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWSkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 13:40:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63F2330E;
        Sun, 23 Feb 2020 10:40:08 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC8FE3F703;
        Sun, 23 Feb 2020 10:40:06 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2 0/6] RT Capacity Awareness Fixes & Improvements
Date:   Sun, 23 Feb 2020 18:39:55 +0000
Message-Id: <20200223184001.14248-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavan, Steve and Dietmar pointed out a few issues and improvements that could
be done to the logic of RT Capacity Awareness.

This series implements them. The main issue that triggered the discussion is
the missing fallback mechanism in cpupri_find() if we are running on unfitting
CPU and no fitting CPU was found. In this case we fallback to the best
lowest_rq, which means unfitting tasks can move freely in unfitting CPUs, which
better honours the priority of the task.

This is implemented in patch 1.

The 2nd major issue is on wakeup, the logic that forces a push was incomplete.
Steve suggested using the overload flag, but Pavan pointed out this could cause
unnecessary IPIs.

Patch 5 addresses that.

The discussion on patches 1-4 seemed to have reached a consensus. Patch 5 still
needs more eyes staring at it.

Pavan, if you can provide your Reviewed-by on the patches you're happy with
that'd be appreciated. A Tested-by would be ever better :)

Discussion on v1 can be found here:

	https://lore.kernel.org/lkml/20200214163949.27850-1-qais.yousef@arm.com/

Thanks


Qais Yousef (6):
  sched/rt: cpupri_find: implement fallback mechanism for !fit case
  sched/rt: Re-instate old behavior in select_task_rq_rt
  sched/rt: Optimize cpupri_find on non-heterogenous systems
  sched/rt: allow pulling unfitting task
  sched/rt: Better manage pushing unfit tasks on wakeup
  sched/rt: Remove unnecessary assignment in inc/dec_rt_migration

 kernel/sched/cpupri.c | 167 +++++++++++++++++++++++++++---------------
 kernel/sched/cpupri.h |   6 +-
 kernel/sched/rt.c     | 137 ++++++++++++++++++++++++++++++----
 kernel/sched/sched.h  |   3 +
 4 files changed, 237 insertions(+), 76 deletions(-)

-- 
2.17.1

