Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306D1C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 135D520768
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407303AbgDNPGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:06:51 -0400
Received: from foss.arm.com ([217.140.110.172]:57612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407283AbgDNPGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:06:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1718E30E;
        Tue, 14 Apr 2020 08:06:38 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2AF23F73D;
        Tue, 14 Apr 2020 08:06:35 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] sched/rt: Distribute tasks in find_lowest_rq()
Date:   Tue, 14 Apr 2020 16:05:52 +0100
Message-Id: <20200414150556.10920-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have a proper function that returns a 'random' CPU in a mask [1]
utilize that in find_lowest_rq() to solve the thundering herd issue described
in this thread

	https://lore.kernel.org/lkml/20200219140243.wfljmupcrwm2jelo@e107158-lin/

But as a pre-amble, I noticed that the new cpumask_any_and_distribute() is
actually an alias for cpumask_any_and() which is documented as returning
a 'random' cpu but actually just does cpumask_first_and().

The first 3 patches cleanup the API so that the whole family of
cpumask_any*() take advantage of the new 'random' behavior and in patch
4 I convert the cpumask_first_and() --> cpumask_any_and() in find_lowest_rq()
to allow to better distribute the RT tasks that wake up simultaneously.

[1] https://lore.kernel.org/lkml/20200311010113.136465-1-joshdon@google.com/

CC: Juri Lelli <juri.lelli@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ben Segall <bsegall@google.com>
CC: Mel Gorman <mgorman@suse.de>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Yury Norov <yury.norov@gmail.com>
CC: Paul Turner <pjt@google.com>
CC: Alexey Dobriyan <adobriyan@gmail.com>
CC: Josh Don <joshdon@google.com>
CC: Pavan Kondeti <pkondeti@codeaurora.org>
CC: linux-kernel@vger.kernel.org

Qais Yousef (4):
  cpumask: Rename cpumask_any_and_distribute
  cpumask: Make cpumask_any() truly random
  cpumask: Convert cpumask_any_but() to the new random function
  sched/rt: Better distribute tasks that wakeup simultaneously

 include/linux/cpumask.h | 33 ++++++-----------
 kernel/sched/core.c     |  2 +-
 kernel/sched/rt.c       |  4 +-
 lib/cpumask.c           | 82 +++++++++++++++++++++++++++--------------
 4 files changed, 68 insertions(+), 53 deletions(-)

-- 
2.17.1

