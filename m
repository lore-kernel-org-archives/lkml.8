Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F5EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403CF20734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgFCIDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:03:21 -0400
Received: from foss.arm.com ([217.140.110.172]:58214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFCIDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:03:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A36E31B;
        Wed,  3 Jun 2020 01:03:20 -0700 (PDT)
Received: from macbook.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1D0973F52E;
        Wed,  3 Jun 2020 01:03:18 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] sched: Remove some redundancy
Date:   Wed,  3 Jun 2020 10:03:00 +0200
Message-Id: <20200603080304.16548-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant functions, parameters and macros from the task
scheduler code.

Dietmar Eggemann (4):
  sched/pelt: Remove redundant cap_scale() definition
  sched/core: Remove redundant 'preempt' param from
    sched_class->yield_to_task()
  sched/idle,stop: Remove .get_rr_interval from sched_class
  sched/fair: Remove unused 'sd' parameter from scale_rt_capacity()

 kernel/sched/core.c      | 2 +-
 kernel/sched/fair.c      | 6 +++---
 kernel/sched/idle.c      | 7 -------
 kernel/sched/pelt.c      | 2 --
 kernel/sched/sched.h     | 2 +-
 kernel/sched/stop_task.c | 8 --------
 6 files changed, 5 insertions(+), 22 deletions(-)

-- 
2.17.1

