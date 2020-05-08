Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC34C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50CCE249A4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgEHNLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730410AbgEHNFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:03 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF359C05BD43;
        Fri,  8 May 2020 06:05:02 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gU-0007Nc-Di; Fri, 08 May 2020 15:04:58 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 254971C0833;
        Fri,  8 May 2020 15:04:52 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:52 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename perf_evsel__group_desc() to
 evsel__group_desc()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894309208.8414.5577763038882933487.tip-bot2@tip-bot2>
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

Commit-ID:     347c751a64af1ae10927d3e4e59171a72a062b3c
Gitweb:        https://git.kernel.org/tip/347c751a64af1ae10927d3e4e59171a72a062b3c
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 29 Apr 2020 16:09:12 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:30 -03:00

perf evsel: Rename perf_evsel__group_desc() to evsel__group_desc()

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 2 +-
 tools/perf/ui/gtk/hists.c   | 2 +-
 tools/perf/util/annotate.c  | 4 ++--
 tools/perf/util/evsel.c     | 2 +-
 tools/perf/util/evsel.h     | 2 +-
 tools/perf/util/hist.c      | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index b5dd93a..e00f624 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -462,7 +462,7 @@ static size_t hists__fprintf_nr_sample_events(struct hists *hists, struct report
 	if (perf_evsel__is_group_event(evsel)) {
 		struct evsel *pos;
 
-		perf_evsel__group_desc(evsel, buf, size);
+		evsel__group_desc(evsel, buf, size);
 		evname = buf;
 
 		for_each_group_member(pos, evsel) {
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index 50c072d..40b52ae 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -646,7 +646,7 @@ int perf_evlist__gtk_browse_hists(struct evlist *evlist,
 				continue;
 
 			if (pos->core.nr_members > 1) {
-				perf_evsel__group_desc(pos, buf, size);
+				evsel__group_desc(pos, buf, size);
 				evname = buf;
 			}
 		}
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 37d9562..7d03563 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2370,7 +2370,7 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel,
 
 	if (perf_evsel__is_group_event(evsel)) {
 		width *= evsel->core.nr_members;
-		perf_evsel__group_desc(evsel, buf, sizeof(buf));
+		evsel__group_desc(evsel, buf, sizeof(buf));
 		evsel_name = buf;
 	}
 
@@ -2519,7 +2519,7 @@ int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
 		goto out_free_filename;
 
 	if (perf_evsel__is_group_event(evsel)) {
-		perf_evsel__group_desc(evsel, buf, sizeof(buf));
+		evsel__group_desc(evsel, buf, sizeof(buf));
 		ev_name = buf;
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 167599e..9b3db6d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -663,7 +663,7 @@ const char *evsel__group_name(struct evsel *evsel)
  *  For record -e 'cycles,instructions' and report --group
  *    'cycles:u, instructions:u'
  */
-int perf_evsel__group_desc(struct evsel *evsel, char *buf, size_t size)
+int evsel__group_desc(struct evsel *evsel, char *buf, size_t size)
 {
 	int ret = 0;
 	struct evsel *pos;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 7160f3d..82d2d30 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -212,7 +212,7 @@ int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size
 const char *evsel__name(struct evsel *evsel);
 
 const char *evsel__group_name(struct evsel *evsel);
-int perf_evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
+int evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
 
 void __perf_evsel__set_sample_bit(struct evsel *evsel,
 				  enum perf_event_sample_format bit);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index fa77574..bce49ae 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2698,7 +2698,7 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
 	if (perf_evsel__is_group_event(evsel)) {
 		struct evsel *pos;
 
-		perf_evsel__group_desc(evsel, buf, buflen);
+		evsel__group_desc(evsel, buf, buflen);
 		ev_name = buf;
 
 		for_each_group_member(pos, evsel) {
