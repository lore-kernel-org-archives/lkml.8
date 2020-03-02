Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A53FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C1921739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgCBN1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:27:36 -0500
Received: from foss.arm.com ([217.140.110.172]:60794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727659AbgCBN1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:27:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCA922F;
        Mon,  2 Mar 2020 05:27:35 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61E673F534;
        Mon,  2 Mar 2020 05:27:34 -0800 (PST)
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
Subject: [PATCH v3 0/6] RT Capacity Awareness Fixes & Improvements
Date:   Mon,  2 Mar 2020 13:27:15 +0000
Message-Id: <20200302132721.8353-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v2:
	* Fix missing check target != -1 (patch 2)
	* Drop the logic to check for fit cpu in wakeup and switched_to_rt()
	  (patch 5)
	* Added the patch that fixes pushing unfit cpu in select_task_rq_rt
	  That was patch 3 in v1[1] (patch 6)

Link to v2:
	https://lore.kernel.org/lkml/20200223184001.14248-1-qais.yousef@arm.com/#t


Pavan, Steve and Dietmar pointed out a few issues and improvements that could
be done to the logic of RT Capacity Awareness, that this series fixes.

Please consider applying as fixes for 5.6.

Except for patch 6 which I'm not sure if the discussion around it has settled,
patches 1-5 should be good to go.

Thanks!

--
Qais Yousef

[1] https://lore.kernel.org/lkml/20200214163949.27850-4-qais.yousef@arm.com/


Qais Yousef (6):
  sched/rt: cpupri_find: Implement fallback mechanism for !fit case
  sched/rt: Re-instate old behavior in select_task_rq_rt
  sched/rt: Optimize cpupri_find on non-heterogenous systems
  sched/rt: Allow pulling unfitting task
  sched/rt: Remove unnecessary push for unfit tasks
  sched/rt: Fix pushing unfit tasks to a better CPU

 kernel/sched/cpupri.c | 167 +++++++++++++++++++++++++++---------------
 kernel/sched/cpupri.h |   6 +-
 kernel/sched/rt.c     |  71 +++++++++++++-----
 3 files changed, 166 insertions(+), 78 deletions(-)

-- 
2.17.1

