Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C416CC2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BCB20752
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgDDIne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:43:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41722 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgDDImO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:14 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNN-0001Bi-Te; Sat, 04 Apr 2020 10:42:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 597371C0813;
        Sat,  4 Apr 2020 10:41:56 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:55 -0000
From:   "tip-bot2 for John Garry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf pmu: Refactor pmu_add_cpu_aliases()
Cc:     John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1584442939-8911-4-git-send-email-john.garry@huawei.com>
References: <1584442939-8911-4-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <158598971596.28353.16146351074016231140.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e45ad701e784e0eed8a07b537b47afb302c59dab
Gitweb:        https://git.kernel.org/tip/e45ad701e784e0eed8a07b537b47afb302c59dab
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Tue, 17 Mar 2020 19:02:15 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 24 Mar 2020 10:35:59 -03:00

perf pmu: Refactor pmu_add_cpu_aliases()

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
index 8b99fd3..c616a06 100644
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
@@ -744,16 +743,11 @@ out:
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
@@ -788,6 +782,17 @@ new_alias:
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
index 6737e3d..0b4a0ef 100644
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
 
