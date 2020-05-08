Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE17C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AFC224994
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgEHNFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728787AbgEHNFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:11 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EB4C05BD43;
        Fri,  8 May 2020 06:05:10 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gb-0007U4-Jl; Fri, 08 May 2020 15:05:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3152F1C0821;
        Fri,  8 May 2020 15:04:56 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:56 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename 'struct perf_evsel__sb_cb_t' to
 'struct evsel__sb_cb_t'
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894309615.8414.4044327569453519346.tip-bot2@tip-bot2>
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

Commit-ID:     65ddce3fd87a822d25c8632afb347b8ece607746
Gitweb:        https://git.kernel.org/tip/65ddce3fd87a822d25c8632afb347b8ece607746
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 29 Apr 2020 15:42:16 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:30 -03:00

perf evsel: Rename 'struct perf_evsel__sb_cb_t' to 'struct evsel__sb_cb_t'

As the "perf_" prefix should be restricted to functions and types in
tools/lib/perf/, aka libperf, this way we reduce a bit the confusion for
types only in libperf or the ones in the more contained tools/perf/
project.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.h          | 4 ++--
 tools/perf/util/evsel.h           | 6 +++---
 tools/perf/util/sideband_evlist.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 93de63e..b6f325d 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -109,9 +109,9 @@ int perf_evlist__add_dummy(struct evlist *evlist);
 
 int perf_evlist__add_sb_event(struct evlist *evlist,
 			      struct perf_event_attr *attr,
-			      perf_evsel__sb_cb_t cb,
+			      evsel__sb_cb_t cb,
 			      void *data);
-void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb, void *data);
+void evlist__set_cb(struct evlist *evlist, evsel__sb_cb_t cb, void *data);
 int perf_evlist__start_sb_thread(struct evlist *evlist,
 				 struct target *target);
 void perf_evlist__stop_sb_thread(struct evlist *evlist);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index bf999e3..7ff37c4 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -18,7 +18,7 @@ struct perf_counts;
 struct perf_stat_evsel;
 union perf_event;
 
-typedef int (perf_evsel__sb_cb_t)(union perf_event *event, void *data);
+typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
 
 enum perf_tool_event {
 	PERF_TOOL_NONE		= 0,
@@ -101,8 +101,8 @@ struct evsel {
 	int			cpu_iter;
 	const char		*pmu_name;
 	struct {
-		perf_evsel__sb_cb_t	*cb;
-		void			*data;
+		evsel__sb_cb_t	*cb;
+		void		*data;
 	} side_band;
 	/*
 	 * For reporting purposes, an evsel sample can have a callchain
diff --git a/tools/perf/util/sideband_evlist.c b/tools/perf/util/sideband_evlist.c
index 1d6f470..bb3706f 100644
--- a/tools/perf/util/sideband_evlist.c
+++ b/tools/perf/util/sideband_evlist.c
@@ -13,7 +13,7 @@
 #include <stdbool.h>
 
 int perf_evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
-			      perf_evsel__sb_cb_t cb, void *data)
+			      evsel__sb_cb_t cb, void *data)
 {
 	struct evsel *evsel;
 
@@ -81,7 +81,7 @@ static void *perf_evlist__poll_thread(void *arg)
 	return NULL;
 }
 
-void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb, void *data)
+void evlist__set_cb(struct evlist *evlist, evsel__sb_cb_t cb, void *data)
 {
 	struct evsel *evsel;
 
