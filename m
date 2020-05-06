Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97D0C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C414F21655
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778752;
	bh=7oFq7p2i8MWyeOBRuI2rxMgXebkIlKxXuA80EzJ/74A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u8w8jU6Mm7GQn8dX9r42bQXm6xKJYMIEogbGW9qIMqPVtd7Ev+JInlqxrZ6ldd606
	 Fhs0ro81tThXo4UkkJfHaKWprtIqW3+f/mb/Px88UxCO9+w381g/rV2Ip3sm4ikwqX
	 NTrgcrYZNj0ml1vVWyo200qHI6n3nOQ3FAQlKIZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgEFPZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:25:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730055AbgEFPZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:43 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A72520B1F;
        Wed,  6 May 2020 15:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778742;
        bh=7oFq7p2i8MWyeOBRuI2rxMgXebkIlKxXuA80EzJ/74A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qwVigG8OvwFCTNCpA6mItoNV2aqi1aVp3KJckRv9ngvRtnHlOgrNnG3q3w3CUMEc1
         oRxQPTMcH7tKr4t/V7ky108WTbvjETisasDgmb055Wh3eLGvryJpejEV0PQBwcCvey
         FT+VCZEoL+hqK2clcQZT0BjNF67cXrAQzHeZ69eE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 51/91] perf evsel: Rename perf_evsel__find_pmu() to evsel__find_pmu()
Date:   Wed,  6 May 2020 12:21:54 -0300
Message-Id: <20200506152234.21977-52-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 2 +-
 tools/perf/util/evsel.h    | 2 +-
 tools/perf/util/pmu.c      | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 83ea7ca24686..cddd1d36f724 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2542,7 +2542,7 @@ static int parse_addr_filter(struct evsel *evsel, const char *filter,
 
 static int perf_evsel__nr_addr_filter(struct evsel *evsel)
 {
-	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
+	struct perf_pmu *pmu = evsel__find_pmu(evsel);
 	int nr_addr_filters = 0;
 
 	if (!pmu)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 32015057429c..868e2be434c4 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -158,7 +158,7 @@ int perf_evsel__object_config(size_t object_size,
 			      int (*init)(struct evsel *evsel),
 			      void (*fini)(struct evsel *evsel));
 
-struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel);
+struct perf_pmu *evsel__find_pmu(struct evsel *evsel);
 bool perf_evsel__is_aux_event(struct evsel *evsel);
 
 struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d9f89ed18dea..2dd3d6be1a61 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -886,7 +886,7 @@ struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu)
 	return NULL;
 }
 
-struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
+struct perf_pmu *evsel__find_pmu(struct evsel *evsel)
 {
 	struct perf_pmu *pmu = NULL;
 
@@ -900,7 +900,7 @@ struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
 
 bool perf_evsel__is_aux_event(struct evsel *evsel)
 {
-	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
+	struct perf_pmu *pmu = evsel__find_pmu(evsel);
 
 	return pmu && pmu->auxtrace;
 }
-- 
2.21.1

