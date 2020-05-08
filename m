Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E01EC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 481F1208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbgEHNKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730429AbgEHNFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127F1C05BD0A;
        Fri,  8 May 2020 06:05:08 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2ga-0007Sg-0d; Fri, 08 May 2020 15:05:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 295D71C0845;
        Fri,  8 May 2020 15:04:55 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:55 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename perf_evsel__find_pmu() to
 evsel__find_pmu()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894309510.8414.6441501861170338478.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e76026bdd51bcd4a0b9793c655891cde45367f5f
Gitweb:        https://git.kernel.org/tip/e76026bdd51bcd4a0b9793c655891cde45367f5f
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 29 Apr 2020 15:50:10 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:30 -03:00

perf evsel: Rename perf_evsel__find_pmu() to evsel__find_pmu()

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
index 83ea7ca..cddd1d3 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2542,7 +2542,7 @@ out_exit:
 
 static int perf_evsel__nr_addr_filter(struct evsel *evsel)
 {
-	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
+	struct perf_pmu *pmu = evsel__find_pmu(evsel);
 	int nr_addr_filters = 0;
 
 	if (!pmu)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3201505..868e2be 100644
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
index d9f89ed..2dd3d6b 100644
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
