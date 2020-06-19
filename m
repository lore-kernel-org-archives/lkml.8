Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB45EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFE420809
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 17:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390120AbgFSRUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 13:20:38 -0400
Received: from foss.arm.com ([217.140.110.172]:49110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFSRUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 13:20:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC0B22B;
        Fri, 19 Jun 2020 10:20:36 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39B193F71F;
        Fri, 19 Jun 2020 10:20:35 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] sched: Optionally skip uclamp logic in fast path
Date:   Fri, 19 Jun 2020 18:20:09 +0100
Message-Id: <20200619172011.5810-1-qais.yousef@arm.com>
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
  sched/uclamp: Fix initialization of strut uclamp_rq
  sched/uclamp: Protect uclamp fast path code with static key

 kernel/sched/core.c | 81 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 9 deletions(-)

-- 
2.17.1

