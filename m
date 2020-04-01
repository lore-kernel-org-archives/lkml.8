Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB23C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 408A22173E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbgDAKR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:17:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:34152 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732268AbgDAKR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:17:56 -0400
IronPort-SDR: /ZDTpQhiUpJklIojIt3N6rhOylGCB/UVmENijRK4hAL8joPOGAbtfjALOJpYNmtKVumm3qCwZe
 7RSlKrd5mIOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 03:17:55 -0700
IronPort-SDR: bjwGXf0xdxFSVWpgAaqV31mEeVsR/SP4s4Pqgkz+0IUwweQMkuQkGmueMYDQ9qStXATlPhFNoH
 ubYSbPYNmhZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; 
   d="scan'208";a="395925574"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.87])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2020 03:17:54 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/16] perf tools: Move and globalize perf_evsel__find_pmu() and perf_evsel__is_aux_event()
Date:   Wed,  1 Apr 2020 13:16:09 +0300
Message-Id: <20200401101613.6201-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401101613.6201-1-adrian.hunter@intel.com>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move and globalize 2 functions so that they can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 19 -------------------
 tools/perf/util/evsel.c    | 20 ++++++++++++++++++++
 tools/perf/util/evsel.h    |  3 +++
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 809a09e75c55..33ad33378a90 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -58,25 +58,6 @@
 #include "symbol/kallsyms.h"
 #include <internal/lib.h>
 
-static struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
-{
-	struct perf_pmu *pmu = NULL;
-
-	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-		if (pmu->type == evsel->core.attr.type)
-			break;
-	}
-
-	return pmu;
-}
-
-static bool perf_evsel__is_aux_event(struct evsel *evsel)
-{
-	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
-
-	return pmu && pmu->auxtrace;
-}
-
 /*
  * Make a group from 'leader' to 'last', requiring that the events were not
  * already grouped to a different leader.
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 60e6cd49dee3..d4ab073c9fe7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -44,6 +44,7 @@
 #include "stat.h"
 #include "string2.h"
 #include "memswap.h"
+#include "pmu.h"
 #include "util.h"
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
@@ -100,6 +101,25 @@ int perf_evsel__object_config(size_t object_size,
 	return 0;
 }
 
+struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
+{
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (pmu->type == evsel->core.attr.type)
+			break;
+	}
+
+	return pmu;
+}
+
+bool perf_evsel__is_aux_event(struct evsel *evsel)
+{
+	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
+
+	return pmu && pmu->auxtrace;
+}
+
 #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
 
 int __perf_evsel__sample_size(u64 sample_type)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index e64ed4202cab..a463bc65b001 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -158,6 +158,9 @@ int perf_evsel__object_config(size_t object_size,
 			      int (*init)(struct evsel *evsel),
 			      void (*fini)(struct evsel *evsel));
 
+struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel);
+bool perf_evsel__is_aux_event(struct evsel *evsel);
+
 struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
 
 static inline struct evsel *evsel__new(struct perf_event_attr *attr)
-- 
2.17.1

