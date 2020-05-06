Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08690C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61A22145D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778677;
	bh=eB6fBXsPW39tDgdTNZ/eSqggobjtSV0MAqnl8iAoFVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A6OiO1vvO0r8q2PZ+uq4A7fyTQ1rhzeuBv0gkMN1xFe/CJcsPvvRLud/lcVjD1/mE
	 /QLPrft7cYCFe7pvXaxg+jp4HksWSEKaShkF+SLkQI0m/WuGfJFnutPyUo1RAMWhGd
	 KPM7QgEDb+V9v6hWe5IIACqMPPbvEmDDRtlmPvoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgEFPYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729856AbgEFPYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:24:31 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ADC421582;
        Wed,  6 May 2020 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778670;
        bh=eB6fBXsPW39tDgdTNZ/eSqggobjtSV0MAqnl8iAoFVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+JQ2VY5kEbFjRAEUwPrX4Ibt1xZnAcJm1IE82hfKpX4h73T7/yih4ef9uRFCcMr6
         G2TMeuZvTGkD+JyoltWHeoBEF0TFH7H3iuYi1kiuxDMjuNMCLcWpgW5aUGrUSrSkBi
         Cexph099Ab3J5JVKWmREdqyjClDfoKP1Tpr1z6z4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 28/91] perf evlist: Allow reusing the side band thread for more purposes
Date:   Wed,  6 May 2020 12:21:31 -0300
Message-Id: <20200506152234.21977-29-acme@kernel.org>
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
index a9d01a11570a..93de63e2a247 100644
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
index 073d201bb6ea..1d6f470d64c4 100644
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
-- 
2.21.1

