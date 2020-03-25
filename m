Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CC5C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EB92080C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140171;
	bh=IHdqzSwqlE6V8YzfQ0TaG2lnbARPDY1mfl6rQAOXAZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V3HJsqUwJr9HYxwEw4AliSkDNHnLJbc1xJ7b60si1Xe1U4pu39NKETbNnPiQfY9pT
	 BAR7fUwfXco2tf6gZ5f6LxCAQ/F8W3hO8uq6bQy88/JrmG87Uk23oiKztmE2fIaPyz
	 TVh5avSUtOIiYVzpPmTke8yrEGG5sfly+63NOP24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgCYMmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbgCYMmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:42:47 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC145208D6;
        Wed, 25 Mar 2020 12:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585140166;
        bh=IHdqzSwqlE6V8YzfQ0TaG2lnbARPDY1mfl6rQAOXAZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0IiCaTU5uSi4wTkNL8JibJoW1du1quoxDyPMSCOVuJBVBelAC6IWQGDG1lJUgPHkY
         byaIZUyYpPqkmst8GmZ4Ifldd9JliRiWcqs2Mt6gV1XDNSIRm11/uK7tn5guyJVC3r
         bHLfxH0n3isoYLk5NoM+CJP/eXKiMC9hbAYoH6LM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/24] perf pmu: Refactor pmu_add_cpu_aliases()
Date:   Wed, 25 Mar 2020 09:41:18 -0300
Message-Id: <20200325124124.32648-19-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

Create pmu_add_cpu_aliases_map() from pmu_add_cpu_aliases(), so the caller
can pass the map; the pmu-events test would use this since there would
be no CPUID matching to a mapfile there.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
Link: http://lore.kernel.org/lkml/1584442939-8911-4-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 21 +++++++++++++--------
 tools/perf/util/pmu.h |  3 +++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 8b99fd312aae..c616a06a34a8 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -21,7 +21,6 @@
 #include "pmu.h"
 #include "parse-events.h"
 #include "header.h"
-#include "pmu-events/pmu-events.h"
 #include "string2.h"
 #include "strbuf.h"
 #include "fncache.h"
@@ -744,16 +743,11 @@ static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
  * to the current running CPU. Then, add all PMU events from that table
  * as aliases.
  */
-static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
+void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
+			     struct pmu_events_map *map)
 {
 	int i;
-	struct pmu_events_map *map;
 	const char *name = pmu->name;
-
-	map = perf_pmu__find_map(pmu);
-	if (!map)
-		return;
-
 	/*
 	 * Found a matching PMU events table. Create aliases
 	 */
@@ -788,6 +782,17 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 	}
 }
 
+static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
+{
+	struct pmu_events_map *map;
+
+	map = perf_pmu__find_map(pmu);
+	if (!map)
+		return;
+
+	pmu_add_cpu_aliases_map(head, pmu, map);
+}
+
 struct perf_event_attr * __weak
 perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
 {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 6737e3d5d568..0b4a0efae38e 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -7,6 +7,7 @@
 #include <linux/perf_event.h>
 #include <stdbool.h>
 #include "parse-events.h"
+#include "pmu-events/pmu-events.h"
 
 struct perf_evsel_config_term;
 
@@ -97,6 +98,8 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
 int perf_pmu__test(void);
 
 struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
+void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
+			     struct pmu_events_map *map);
 
 struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
 
-- 
2.21.1

