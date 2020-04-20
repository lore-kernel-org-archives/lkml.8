Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87540C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 630BB221F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 11:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587383780;
	bh=u7yG1A4dyYz+LQCEOwvwrhPfBkWm6kF3HaBT6Ua4scA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gyiVY4WR8t/1AOzeEPVugiOoCe5v/iuISmwjKkTuUWrBw64hS1S4CF99Y7FbXPvmT
	 /Fkn+HZFuPmF3Oc7LyCvR9kgvCEowD3cH7zKRc403osrB/8dgLEaApY50MBnkqJi42
	 1uiOeZio7w8yJZnprfMu41uTlBAxsaYu4cMPjkUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgDTL4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 07:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbgDTL4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:56:13 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D69C922209;
        Mon, 20 Apr 2020 11:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587383772;
        bh=u7yG1A4dyYz+LQCEOwvwrhPfBkWm6kF3HaBT6Ua4scA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xydOqEqWcwRFdcqEbwsPF4nM8ONcg+4vHpV4H5iW/I6b47w1rOe9OZgnotsi1EFR3
         7wMK+AwYSJ7c8EO9jSjb+e1IBsdITCWp2IpR81Rc1QLmibsVfd0mSY0tdREHqKh0be
         5RRpYBr5zUY7fuaixZkUFp5ZieV3S3jD8Vw4uqV8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 37/60] perf evsel: Move and globalize perf_evsel__find_pmu() and perf_evsel__is_aux_event()
Date:   Mon, 20 Apr 2020 08:52:53 -0300
Message-Id: <20200420115316.18781-38-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200420115316.18781-1-acme@kernel.org>
References: <20200420115316.18781-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Move and globalize 2 functions from the auxtrace specific sources so
that they can be reused.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-13-adrian.hunter@intel.com
[ Move to pmu.c, as moving to evsel.h breaks the python binding ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 19 -------------------
 tools/perf/util/evsel.h    |  3 +++
 tools/perf/util/pmu.c      | 20 ++++++++++++++++++++
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
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index ef6a63f3d386..bc912a84b5e9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -18,6 +18,7 @@
 #include <regex.h>
 #include <perf/cpumap.h>
 #include "debug.h"
+#include "evsel.h"
 #include "pmu.h"
 #include "parse-events.h"
 #include "header.h"
@@ -884,6 +885,25 @@ struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu)
 	return NULL;
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
 struct perf_pmu *perf_pmu__find(const char *name)
 {
 	struct perf_pmu *pmu;
-- 
2.21.1

