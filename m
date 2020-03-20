Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB68C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F4F2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgCTPM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:12:58 -0400
Received: from outbound-smtp36.blacknight.com ([46.22.139.219]:55885 "EHLO
        outbound-smtp36.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726773AbgCTPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:12:58 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp36.blacknight.com (Postfix) with ESMTPS id 024EC1B75
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 15:12:57 +0000 (GMT)
Received: (qmail 28040 invoked from network); 20 Mar 2020 15:12:56 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 20 Mar 2020 15:12:56 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/4] Throttle select_idle_sibling when a target domain is overloaded
Date:   Fri, 20 Mar 2020 15:12:41 +0000
Message-Id: <20200320151245.21152-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-on from the CPU/NUMA load balancer reconcilation
after I noticed that select_idle_sibling() was doing excessive work. It
was originally part of a larger series that merged select_idle_core,
select_idle_sibling and select_idle_cpu as a single pass. Unfortunately,
fixes have invalidated the tests multiple times so this series covers
only one part for now as the tests are extremely time-consuming.

tip/sched/core as of March 13th was used as the baseline with "sched/fair:
fix condition of avg_load calculation" applied which was just picked up
by tip at the time of writing.

Patches 1-2 add schedstats to track the efficiency of
select_idle_sibling(). Ordinarily they are disabled and are only really
of use to a kernel developer. However, I find them more practical to work
with than perf.

Patch 3 is a trivial micro-optimisation that avoids clearing part of
a cpumask if a core has been found.

Patch 4 tracks whether a domain appeared to be overloaded during
select_idle_cpu() so that future scans can abort early if necessary.
This reduces the number of runqueues that are scanned uselessly when
a domain is overloaded.

 include/linux/sched/topology.h |   1 +
 kernel/sched/debug.c           |   6 +++
 kernel/sched/fair.c            | 103 +++++++++++++++++++++++++++++++++++------
 kernel/sched/features.h        |   3 ++
 kernel/sched/sched.h           |   8 ++++
 kernel/sched/stats.c           |   9 ++--
 6 files changed, 113 insertions(+), 17 deletions(-)

-- 
2.16.4

