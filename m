Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D07C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34E924671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgAOK7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:59:22 -0500
Received: from foss.arm.com ([217.140.110.172]:34942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgAOK7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:59:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58AA51007;
        Wed, 15 Jan 2020 02:59:21 -0800 (PST)
Received: from e112479-lin.warwick.arm.com (e112479-lin.warwick.arm.com [10.32.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34A4C3F6C4;
        Wed, 15 Jan 2020 02:59:18 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     nd@arm.com, James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Return EINVAL when precise_ip perf events are requested on Arm
Date:   Wed, 15 Jan 2020 10:58:55 +0000
Message-Id: <20200115105855.13395-2-james.clark@arm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200115105855.13395-1-james.clark@arm.com>
References: <20200115105855.13395-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM PMU events can be delivered with arbitrary skid, and there's
nothing the kernel can do to prevent this. Given that, the PMU
cannot support precise_ip != 0.

Also update comment to state that attr.config field is used to
set the event type rather than event_id which doesn't exist.

Signed-off-by: James Clark <james.clark@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: Al Grant <al.grant@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/perf/arm_pmu.c          | 3 +++
 include/uapi/linux/perf_event.h | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index df352b334ea7..4ddbdb93b3b6 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -102,6 +102,9 @@ armpmu_map_event(struct perf_event *event,
 	u64 config = event->attr.config;
 	int type = event->attr.type;
 
+	if (event->attr.precise)
+		return -EINVAL;
+
 	if (type == event->pmu->type)
 		return armpmu_map_raw_event(raw_event_mask, config);
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 377d794d3105..3501b2eb168a 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -38,8 +38,8 @@ enum perf_type_id {
 };
 
 /*
- * Generalized performance event event_id types, used by the
- * attr.event_id parameter of the sys_perf_event_open()
+ * Generalized hardware performance event types, used by the
+ * attr.config parameter of the sys_perf_event_open()
  * syscall:
  */
 enum perf_hw_id {
-- 
2.24.0

