Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A889C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64EC4206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390724AbgF2VRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:17:04 -0400
Received: from foss.arm.com ([217.140.110.172]:36814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729802AbgF2Sy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:54:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 347081529;
        Mon, 29 Jun 2020 09:26:38 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B2EC3F71E;
        Mon, 29 Jun 2020 09:26:36 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] sched: Optionally skip uclamp logic in fast path
Date:   Mon, 29 Jun 2020 17:26:31 +0100
Message-Id: <20200629162633.8800-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series attempts to address the report that uclamp logic could be expensive
sometimes and shows a regression in netperf UDP_STREAM under certain
conditions.

The first patch is a fix for how struct uclamp_rq is initialized which is
required by the 2nd patch which contains the real 'fix'.

Worth noting that the root cause of the overhead is believed to be system
specific or related to potential certain code/data layout issues, leading to
worse I/D $ performance.

Different systems exhibited different behaviors and the regression did
disappear in certain kernel version while attempting to reporoduce.

More info can be found here:

https://lore.kernel.org/lkml/20200616110824.dgkkbyapn3io6wik@e107158-lin/

Having the static key seemed the best thing to do to ensure the effect of
uclamp is minimized for kernels that compile it in but don't have a userspace
that uses it, which will allow distros to distribute uclamp capable kernels by
default without having to compromise on performance for some systems that could
be affected.

Changes in v5:
	* Fix a race that could happen when order of enqueue/dequeue of tasks
	  A and B is not done in order, and sched_uclamp_used is enabled in
	  between.
	* Add more comments explaining the race and the behavior of
	  uclamp_rq_util_with() which is now protected with a static key to be
	  a NOP. When no uclamp aggregation at rq level is done, this function
	  can't do much.

Changes in v4:
	* Fix broken boosting of RT tasks when static key is disabled.

Changes in v3:
	* Avoid double negatives and rename the static key to uclamp_used
	* Unconditionally enable the static key through any of the paths where
	  the user can modify the default uclamp value.
	* Use C99 named struct initializer for struct uclamp_rq which is easier
	  to read than the memset().

Changes in v2:
	* Add more info in the commit message about the result of perf diff to
	  demonstrate that the activate/deactivate_task pressure is reduced in
	  the fast path.

	* Fix sparse warning reported by the test robot.

	* Add an extra commit about using static_branch_likely() instead of
	  static_branc_unlikely().

Thanks

--
Qais Yousef

Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
CC: Patrick Bellasi <patrick.bellasi@matbug.net>
Cc: Chris Redpath <chris.redpath@arm.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org


Qais Yousef (2):
  sched/uclamp: Fix initialization of struct uclamp_rq
  sched/uclamp: Protect uclamp fast path code with static key

 kernel/sched/core.c              | 86 +++++++++++++++++++++++++++++---
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/sched.h             | 39 ++++++++++++++-
 3 files changed, 117 insertions(+), 10 deletions(-)

-- 
2.17.1

