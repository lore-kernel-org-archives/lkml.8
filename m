Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50E4C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F67A214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778675;
	bh=sS4Nrv17EkDulY6g8Opuqq5U2Gg4lcJ8sJpFQD4Xa9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oq0yQhPlCktZlyvHYdhtNj1Jmt3JYNp17UGF++u987PaZmvQkCBV9h58LNd6Y2c/n
	 mcGLT0LL3s8RZy37tuQ9KTcbDWtkyJ8nNtIUxW6egMHx/8csmY2RH99dXcCgz1YlLU
	 mAe26F5ByVxHQCgRU8wFFtLRUDUT95/iJUtxOLEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbgEFPYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729510AbgEFPY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:24:29 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1AEE2192A;
        Wed,  6 May 2020 15:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778667;
        bh=sS4Nrv17EkDulY6g8Opuqq5U2Gg4lcJ8sJpFQD4Xa9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eyvntpcpR1Imv10wA8jhpgzF+YUDPg0K2zAKR0NW6JMxTTPuMpHxg8dtnuiADdMSy
         rs8ibzq1lR8HeVyJls615gjfJKuVKIOvt/lqqZ6cDkppy5fUNq3AcWemrz14dQET1k
         fbp5XpWZml12zV86Z6jcCqR7eZyFlnDAkS0pPl7c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 27/91] perf evlist: Move the sideband thread routines to separate object
Date:   Wed,  6 May 2020 12:21:30 -0300
Message-Id: <20200506152234.21977-28-acme@kernel.org>
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

To avoid dragging more stuff into the perf python binding in the
following csets.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build             |   1 +
 tools/perf/util/evlist.c          | 117 ----------------------------
 tools/perf/util/sideband_evlist.c | 125 ++++++++++++++++++++++++++++++
 3 files changed, 126 insertions(+), 117 deletions(-)
 create mode 100644 tools/perf/util/sideband_evlist.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 229abefed59a..ca07a162d602 100644
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
index 6fe11f4d856a..6d902c02fd95 100644
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
index 000000000000..073d201bb6ea
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
-- 
2.21.1

