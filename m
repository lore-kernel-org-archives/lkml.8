Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AE0C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226F824999
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbgEHNJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730497AbgEHNFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43C2C05BD0F;
        Fri,  8 May 2020 06:05:23 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gp-0007h9-Mb; Fri, 08 May 2020 15:05:19 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3241C1C04D3;
        Fri,  8 May 2020 15:05:05 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:05 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evlist: Move the sideband thread routines to
 separate object
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894310511.8414.8812865769346391673.tip-bot2@tip-bot2>
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

Commit-ID:     9a39994467d493eba38d8f69e42fd9c31cb1da9a
Gitweb:        https://git.kernel.org/tip/9a39994467d493eba38d8f69e42fd9c31cb1da9a
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 05 May 2020 12:18:21 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:29 -03:00

perf evlist: Move the sideband thread routines to separate object

To avoid dragging more stuff into the perf python binding in the
following csets.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build             |   1 +-
 tools/perf/util/evlist.c          | 117 +---------------------------
 tools/perf/util/sideband_evlist.c | 125 +++++++++++++++++++++++++++++-
 3 files changed, 126 insertions(+), 117 deletions(-)
 create mode 100644 tools/perf/util/sideband_evlist.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 229abef..ca07a16 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -10,6 +10,7 @@ perf-y += db-export.o
 perf-y += env.o
 perf-y += event.o
 perf-y += evlist.o
+perf-y += sideband_evlist.o
 perf-y += evsel.o
 perf-y += evsel_fprintf.o
 perf-y += perf_event_attr_fprintf.o
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6fe11f4..6d902c0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1704,120 +1704,3 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
 	}
 	return leader;
 }
-
-int perf_evlist__add_sb_event(struct evlist *evlist,
-			      struct perf_event_attr *attr,
-			      perf_evsel__sb_cb_t cb,
-			      void *data)
-{
-	struct evsel *evsel;
-
-	if (!attr->sample_id_all) {
-		pr_warning("enabling sample_id_all for all side band events\n");
-		attr->sample_id_all = 1;
-	}
-
-	evsel = perf_evsel__new_idx(attr, evlist->core.nr_entries);
-	if (!evsel)
-		return -1;
-
-	evsel->side_band.cb = cb;
-	evsel->side_band.data = data;
-	evlist__add(evlist, evsel);
-	return 0;
-}
-
-static void *perf_evlist__poll_thread(void *arg)
-{
-	struct evlist *evlist = arg;
-	bool draining = false;
-	int i, done = 0;
-	/*
-	 * In order to read symbols from other namespaces perf to needs to call
-	 * setns(2).  This isn't permitted if the struct_fs has multiple users.
-	 * unshare(2) the fs so that we may continue to setns into namespaces
-	 * that we're observing when, for instance, reading the build-ids at
-	 * the end of a 'perf record' session.
-	 */
-	unshare(CLONE_FS);
-
-	while (!done) {
-		bool got_data = false;
-
-		if (evlist->thread.done)
-			draining = true;
-
-		if (!draining)
-			evlist__poll(evlist, 1000);
-
-		for (i = 0; i < evlist->core.nr_mmaps; i++) {
-			struct mmap *map = &evlist->mmap[i];
-			union perf_event *event;
-
-			if (perf_mmap__read_init(&map->core))
-				continue;
-			while ((event = perf_mmap__read_event(&map->core)) != NULL) {
-				struct evsel *evsel = perf_evlist__event2evsel(evlist, event);
-
-				if (evsel && evsel->side_band.cb)
-					evsel->side_band.cb(event, evsel->side_band.data);
-				else
-					pr_warning("cannot locate proper evsel for the side band event\n");
-
-				perf_mmap__consume(&map->core);
-				got_data = true;
-			}
-			perf_mmap__read_done(&map->core);
-		}
-
-		if (draining && !got_data)
-			break;
-	}
-	return NULL;
-}
-
-int perf_evlist__start_sb_thread(struct evlist *evlist,
-				 struct target *target)
-{
-	struct evsel *counter;
-
-	if (!evlist)
-		return 0;
-
-	if (perf_evlist__create_maps(evlist, target))
-		goto out_delete_evlist;
-
-	evlist__for_each_entry(evlist, counter) {
-		if (evsel__open(counter, evlist->core.cpus,
-				     evlist->core.threads) < 0)
-			goto out_delete_evlist;
-	}
-
-	if (evlist__mmap(evlist, UINT_MAX))
-		goto out_delete_evlist;
-
-	evlist__for_each_entry(evlist, counter) {
-		if (evsel__enable(counter))
-			goto out_delete_evlist;
-	}
-
-	evlist->thread.done = 0;
-	if (pthread_create(&evlist->thread.th, NULL, perf_evlist__poll_thread, evlist))
-		goto out_delete_evlist;
-
-	return 0;
-
-out_delete_evlist:
-	evlist__delete(evlist);
-	evlist = NULL;
-	return -1;
-}
-
-void perf_evlist__stop_sb_thread(struct evlist *evlist)
-{
-	if (!evlist)
-		return;
-	evlist->thread.done = 1;
-	pthread_join(evlist->thread.th, NULL);
-	evlist__delete(evlist);
-}
diff --git a/tools/perf/util/sideband_evlist.c b/tools/perf/util/sideband_evlist.c
new file mode 100644
index 0000000..073d201
--- /dev/null
+++ b/tools/perf/util/sideband_evlist.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "util/debug.h"
+#include "util/evlist.h"
+#include "util/evsel.h"
+#include "util/mmap.h"
+#include <perf/mmap.h>
+#include <linux/perf_event.h>
+#include <limits.h>
+#include <pthread.h>
+#include <sched.h>
+#include <stdbool.h>
+
+int perf_evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
+			      perf_evsel__sb_cb_t cb, void *data)
+{
+	struct evsel *evsel;
+
+	if (!attr->sample_id_all) {
+		pr_warning("enabling sample_id_all for all side band events\n");
+		attr->sample_id_all = 1;
+	}
+
+	evsel = perf_evsel__new_idx(attr, evlist->core.nr_entries);
+	if (!evsel)
+		return -1;
+
+	evsel->side_band.cb = cb;
+	evsel->side_band.data = data;
+	evlist__add(evlist, evsel);
+	return 0;
+}
+
+static void *perf_evlist__poll_thread(void *arg)
+{
+	struct evlist *evlist = arg;
+	bool draining = false;
+	int i, done = 0;
+	/*
+	 * In order to read symbols from other namespaces perf to needs to call
+	 * setns(2).  This isn't permitted if the struct_fs has multiple users.
+	 * unshare(2) the fs so that we may continue to setns into namespaces
+	 * that we're observing when, for instance, reading the build-ids at
+	 * the end of a 'perf record' session.
+	 */
+	unshare(CLONE_FS);
+
+	while (!done) {
+		bool got_data = false;
+
+		if (evlist->thread.done)
+			draining = true;
+
+		if (!draining)
+			evlist__poll(evlist, 1000);
+
+		for (i = 0; i < evlist->core.nr_mmaps; i++) {
+			struct mmap *map = &evlist->mmap[i];
+			union perf_event *event;
+
+			if (perf_mmap__read_init(&map->core))
+				continue;
+			while ((event = perf_mmap__read_event(&map->core)) != NULL) {
+				struct evsel *evsel = perf_evlist__event2evsel(evlist, event);
+
+				if (evsel && evsel->side_band.cb)
+					evsel->side_band.cb(event, evsel->side_band.data);
+				else
+					pr_warning("cannot locate proper evsel for the side band event\n");
+
+				perf_mmap__consume(&map->core);
+				got_data = true;
+			}
+			perf_mmap__read_done(&map->core);
+		}
+
+		if (draining && !got_data)
+			break;
+	}
+	return NULL;
+}
+
+int perf_evlist__start_sb_thread(struct evlist *evlist, struct target *target)
+{
+	struct evsel *counter;
+
+	if (!evlist)
+		return 0;
+
+	if (perf_evlist__create_maps(evlist, target))
+		goto out_delete_evlist;
+
+	evlist__for_each_entry(evlist, counter) {
+		if (evsel__open(counter, evlist->core.cpus, evlist->core.threads) < 0)
+			goto out_delete_evlist;
+	}
+
+	if (evlist__mmap(evlist, UINT_MAX))
+		goto out_delete_evlist;
+
+	evlist__for_each_entry(evlist, counter) {
+		if (evsel__enable(counter))
+			goto out_delete_evlist;
+	}
+
+	evlist->thread.done = 0;
+	if (pthread_create(&evlist->thread.th, NULL, perf_evlist__poll_thread, evlist))
+		goto out_delete_evlist;
+
+	return 0;
+
+out_delete_evlist:
+	evlist__delete(evlist);
+	evlist = NULL;
+	return -1;
+}
+
+void perf_evlist__stop_sb_thread(struct evlist *evlist)
+{
+	if (!evlist)
+		return;
+	evlist->thread.done = 1;
+	pthread_join(evlist->thread.th, NULL);
+	evlist__delete(evlist);
+}
