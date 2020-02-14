Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D4AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E2B2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405925AbgBNQkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:40:04 -0500
Received: from foss.arm.com ([217.140.110.172]:39232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405838AbgBNQj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:39:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A64FA328;
        Fri, 14 Feb 2020 08:39:57 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38FDC3F68E;
        Fri, 14 Feb 2020 08:39:56 -0800 (PST)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH 0/3] RT Capacity Awareness Improvements
Date:   Fri, 14 Feb 2020 16:39:46 +0000
Message-Id: <20200214163949.27850-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavan has pointed out an oversight in the first implementation where we don't
fallback to another unfitting CPU if we are already running on unfitting one.

This also stirred discussion around handling downmigration from fitting to
unfitting CPU.

https://lore.kernel.org/lkml/20200203111451.0d1da58f@oasis.local.home/

Patch 1 adds the missing fallback when a fitting CPU wasn't found, reported
by Pavan.

Patch 2 allows downmigration in the pull case and marks the CPU as overloaded
as suggested by Steve.

Patch 3 fixes the condition in select_task_rq_rt() in case the new_cpu and the
task priorities are the *same*.

The series is based on Linus/master v5.6-rc1.

I ran the following test cases, the results of which can be found in [1]
Each test was run 3 times to demonstrate repeatability of the result.

The tests were ran on Juno-r2, which has 6 CPUs. CPUs [0, 3-5] are Littles and
CPUs [1-2] are Bigs.

By default RT tasks are boosted to max capacity, so no work was done to modify
that. ie: rt_task->uclamp_min = 1024 for all running tests.

	1. 6 RT Tasks
		* 2 Tasks always end up on the big cores
		* The rest end up on the little cores with migration among them
		  happening (it didn't before)
	2. 2 RT Tasks
		* We can see they always end up on the 2 big cores
	3. 4 RT Tasks
		* Results similar to 1
	4. 4 RT Tasks affined to little cores
		* The tasks run on the little cores with some migration as
		  expected

[1] https://gist.github.com/qais-yousef/bb99bdd912628489408a5edae33f85e1

Qais Yousef (3):
  sched/rt: cpupri_find: implement fallback mechanism for !fit case
  sched/rt: allow pulling unfitting task
  sched/rt: fix pushing unfit tasks to a better CPU

 kernel/sched/cpupri.c | 157 +++++++++++++++++++++++++++---------------
 kernel/sched/rt.c     |  50 ++++++++++----
 2 files changed, 139 insertions(+), 68 deletions(-)

-- 
2.17.1

