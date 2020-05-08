Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4C7C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B71BD24973
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbgEHNFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730510AbgEHNF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:26 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575F8C05BD09;
        Fri,  8 May 2020 06:05:26 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2go-0007gF-SR; Fri, 08 May 2020 15:05:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B0D2B1C0845;
        Fri,  8 May 2020 15:05:04 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:04 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evlist: Allow reusing the side band thread for
 more purposes
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200429131106.27974-6-acme@kernel.org>
References: <20200429131106.27974-6-acme@kernel.org>
MIME-Version: 1.0
Message-ID: <158894310460.8414.16136724605045953143.tip-bot2@tip-bot2>
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

Commit-ID:     976be84504b8285d43dc890b02ceff432cd0dd4b
Gitweb:        https://git.kernel.org/tip/976be84504b8285d43dc890b02ceff432cd0dd4b
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 27 Apr 2020 17:54:27 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:29 -03:00

perf evlist: Allow reusing the side band thread for more purposes

I.e. so far we had just one event in that side band thread, a dummy one
with attr.bpf_event set, so that 'perf record' can go ahead and ask the
kernel for further information about BPF programs being loaded.

Allow for more than one event to be there, so that we can use it as
well for the upcoming --switch-output-event feature.

Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200429131106.27974-6-acme@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.h          |  1 +
 tools/perf/util/sideband_evlist.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index a9d01a1..93de63e 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -111,6 +111,7 @@ int perf_evlist__add_sb_event(struct evlist *evlist,
 			      struct perf_event_attr *attr,
 			      perf_evsel__sb_cb_t cb,
 			      void *data);
+void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb, void *data);
 int perf_evlist__start_sb_thread(struct evlist *evlist,
 				 struct target *target);
 void perf_evlist__stop_sb_thread(struct evlist *evlist);
diff --git a/tools/perf/util/sideband_evlist.c b/tools/perf/util/sideband_evlist.c
index 073d201..1d6f470 100644
--- a/tools/perf/util/sideband_evlist.c
+++ b/tools/perf/util/sideband_evlist.c
@@ -4,6 +4,7 @@
 #include "util/evlist.h"
 #include "util/evsel.h"
 #include "util/mmap.h"
+#include "util/perf_api_probe.h"
 #include <perf/mmap.h>
 #include <linux/perf_event.h>
 #include <limits.h>
@@ -80,6 +81,19 @@ static void *perf_evlist__poll_thread(void *arg)
 	return NULL;
 }
 
+void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb, void *data)
+{
+	struct evsel *evsel;
+
+	evlist__for_each_entry(evlist, evsel) {
+		evsel->core.attr.sample_id_all    = 1;
+		evsel->core.attr.watermark        = 1;
+		evsel->core.attr.wakeup_watermark = 1;
+		evsel->side_band.cb   = cb;
+		evsel->side_band.data = data;
+      }
+}
+
 int perf_evlist__start_sb_thread(struct evlist *evlist, struct target *target)
 {
 	struct evsel *counter;
@@ -90,6 +104,15 @@ int perf_evlist__start_sb_thread(struct evlist *evlist, struct target *target)
 	if (perf_evlist__create_maps(evlist, target))
 		goto out_delete_evlist;
 
+	if (evlist->core.nr_entries > 1) {
+		bool can_sample_identifier = perf_can_sample_identifier();
+
+		evlist__for_each_entry(evlist, counter)
+			perf_evsel__set_sample_id(counter, can_sample_identifier);
+
+		perf_evlist__set_id_pos(evlist);
+	}
+
 	evlist__for_each_entry(evlist, counter) {
 		if (evsel__open(counter, evlist->core.cpus, evlist->core.threads) < 0)
 			goto out_delete_evlist;
