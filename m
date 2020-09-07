Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE10C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87DE3208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgIGJRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:17:31 -0400
Received: from foss.arm.com ([217.140.110.172]:58352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbgIGJRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:17:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6006BD6E;
        Mon,  7 Sep 2020 02:17:23 -0700 (PDT)
Received: from dell3630.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EE1A93F66E;
        Mon,  7 Sep 2020 02:17:21 -0700 (PDT)
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Phil Auld <pauld@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Subject: [PATCH 0/3] Remove sched_trace_*() helper functions
Date:   Mon,  7 Sep 2020 11:17:14 +0200
Message-Id: <20200907091717.26116-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch ("sched/debug: Add new tracepoint to track cpu_capacity")
https://lkml.kernel.org/r/1598605249-72651-1-git-send-email-vincent.donnefort@arm.com
revealed the issue that with every tracepoint in the scheduler code
there are sched_trace_*() helper functions in fair.c appearing which
are exported via include/linux/sched.h.

Those tracepoints can be used to build tracepoint-to traceevent
(tp-2-te) converters.

The sched_trace_*() helper functions provide access to data of
internal scheduler structures, like struct rq. They support built-in
or kernel module builds outside kernel/sched/. But they don't have to
be maintained in the scheduler code.

kernel/sched/ is the natural place for a tp-2-te converter to get
access to data of internal scheduler structures.

In case a tp-2-te converter has to be build outside the kernel code
tree there is an easy way to make kernel/sched/sched.h visible.
See header of "sched/fair: Remove sched_trace_*() helper functions" for
details.

The first patch removes those sched_trace_*() helper functions from
the scheduler.

The second patch removes cfs_rq_tg_path() from the scheduler since it
can be coded inside a tp-2-te converter as well.

The third patch allows to use autogroup_path() from within a tp-2-te
converter (i.e. from cfs_rq_tg_path()) in kernel modules builds.

The aim of tracepoints in the scheduler code is to keep the footprint of
traceing code as small as possible and to not guarantee any stable ABI
in relation to internal scheduler structures.

Dietmar Eggemann (3):
  sched/fair: Remove sched_trace_*() helper functions
  sched/fair: Remove cfs_rq_tg_path()
  sched/autogroup: Change autogroup_path() into a static inline function

 include/linux/sched.h    |  13 -----
 kernel/sched/autogroup.c |   8 ---
 kernel/sched/autogroup.h |   8 ++-
 kernel/sched/fair.c      | 105 ---------------------------------------
 kernel/sched/sched.h     |   3 --
 5 files changed, 7 insertions(+), 130 deletions(-)

-- 
2.17.1

