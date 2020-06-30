Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57C4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A201D206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbgF3LWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:22:06 -0400
Received: from foss.arm.com ([217.140.110.172]:40890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbgF3LWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:22:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BBF030E;
        Tue, 30 Jun 2020 04:22:05 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 454E93F68F;
        Tue, 30 Jun 2020 04:22:03 -0700 (PDT)
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
Subject: [PATCH v6 0/2] sched: Optionally skip uclamp logic in fast path
Date:   Tue, 30 Jun 2020 12:21:21 +0100
Message-Id: <20200630112123.12076-1-qais.yousef@arm.com>
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

Changes in v6:
	* s/uclamp_is_enabled/uclamp_is_used/ + add comment
	* Improve the bailout condition for the case where we could end up with
	  unbalanced call of uclamp_rq_dec_id()
	* Clarify some comments.

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
	  static_branch_unlikely().

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

 kernel/sched/core.c              | 95 ++++++++++++++++++++++++++++++--
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/sched.h             | 47 +++++++++++++++-
 3 files changed, 135 insertions(+), 9 deletions(-)

-- 
2.17.1

