Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A11EC169F9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35482208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgBSTKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:10:32 -0500
Received: from mga05.intel.com ([192.55.52.43]:7642 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgBSTKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:10:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2020 11:10:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,461,1574150400"; 
   d="scan'208";a="408536204"
Received: from otc-lr-04.jf.intel.com ([10.54.39.48])
  by orsmga005.jf.intel.com with ESMTP; 19 Feb 2020 11:10:31 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, jolsa@redhat.com, mingo@redhat.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, namhyung@kernel.org,
        ravi.bangoria@linux.ibm.com, yao.jin@linux.intel.com,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 0/5] Support metric group constraint
Date:   Wed, 19 Feb 2020 11:08:35 -0800
Message-Id: <1582139320-75181-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some metric groups, e.g. Page_Walks_Utilization, will never count when
NMI watchdog is enabled.

 $echo 1 > /proc/sys/kernel/nmi_watchdog
 $perf stat -M Page_Walks_Utilization

 Performance counter stats for 'system wide':

 <not counted>      itlb_misses.walk_pending       (0.00%)
 <not counted>      dtlb_load_misses.walk_pending  (0.00%)
 <not counted>      dtlb_store_misses.walk_pending (0.00%)
 <not counted>      ept.walk_pending               (0.00%)
 <not counted>      cycles                         (0.00%)

       2.343460588 seconds time elapsed

 Some events weren't counted. Try disabling the NMI watchdog:
        echo 0 > /proc/sys/kernel/nmi_watchdog
        perf stat ...
        echo 1 > /proc/sys/kernel/nmi_watchdog
 The events in group usually have to be from the same PMU. Try
 reorganizing the group.

A metric group is a weak group, which relies on group validation
code in the kernel to determine whether to be opened as a group or
a non-group. However, group validation code may return false-positives,
especially when NMI watchdog is enabled. (The metric group is allowed
as a group but will never be scheduled.)

The attempt to fix the group validation code has been rejected.
https://lore.kernel.org/lkml/20200117091341.GX2827@hirez.programming.kicks-ass.net/
Because we cannot accurately predict whether the group can be scheduled
as a group, only by checking current status.

This patch set provides another solution to mitigate the issue.
Add "MetricConstraint" in event list, which provides a hint for perf tool,
e.g. "MetricConstraint": "NO_NMI_WATCHDOG". Perf tool can change the
metric group to non-group (standalone metrics) if NMI watchdog is enabled.

After applying the patch,

 $echo 1 > /proc/sys/kernel/nmi_watchdog
 $perf stat -M Page_Walks_Utilization
  Splitting metric group Page_Walks_Utilization into standalone metrics.
  Try disabling the NMI watchdog to comply NO_NMI_WATCHDOG metric constraint:
        echo 0 > /proc/sys/kernel/nmi_watchdog
        perf stat ...
        echo 1 > /proc/sys/kernel/nmi_watchdog

 Performance counter stats for 'system wide':

        18,253,454      itlb_misses.walk_pending  #      0.0
                              Page_Walks_Utilization   (50.55%)
        78,051,525      dtlb_load_misses.walk_pending  (50.55%)
        29,213,063      dtlb_store_misses.walk_pending (50.55%)
                 0      ept.walk_pending               (50.55%)
     2,542,132,364      cycles                         (49.92%)

       1.037095993 seconds time elapsed

Kan Liang (5):
  perf jevents: Support metric constraint
  perf metricgroup: Factor out metricgroup__add_metric_weak_group()
  perf util: Factor out sysctl__nmi_watchdog_enabled()
  perf metricgroup: Support metric constraint
  perf vendor events: Add NO_NMI_WATCHDOG metric constraint

 .../arch/x86/cascadelakex/clx-metrics.json         |  3 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |  3 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  3 +-
 tools/perf/pmu-events/jevents.c                    | 19 +++--
 tools/perf/pmu-events/jevents.h                    |  2 +-
 tools/perf/pmu-events/pmu-events.h                 |  1 +
 tools/perf/util/metricgroup.c                      | 97 ++++++++++++++++------
 tools/perf/util/stat-display.c                     |  6 +-
 tools/perf/util/util.c                             | 18 ++++
 tools/perf/util/util.h                             |  2 +
 10 files changed, 116 insertions(+), 38 deletions(-)

-- 
2.7.4

