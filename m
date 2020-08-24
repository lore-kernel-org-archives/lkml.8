Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D89C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7188D207F7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgHYHGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:06:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:4094 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729283AbgHYHGl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:06:41 -0400
IronPort-SDR: UEqGra2R4TuoUc8c2wTAQqAeoxqm9IPLl2ydqnQWEFiJisAYRefqt3PJtpie1BVbVoxMLNJxdW
 h3RIcG4yoGnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="156050044"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="156050044"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 00:06:39 -0700
IronPort-SDR: E700qSPrI3fLe/3/L44olr2TScKG4stshlIuJ7bxwg05vD7QNGfEApVYlomelk+zgLjX8fVU18
 4vWd8ozyKQKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="322654996"
Received: from kbl-ppc.sh.intel.com ([10.239.159.55])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2020 00:06:37 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 1/7] perf util: Create streams
Date:   Tue, 25 Aug 2020 07:35:07 +0800
Message-Id: <20200824233513.16930-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824233513.16930-1-yao.jin@linux.intel.com>
References: <20200824233513.16930-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We define the stream is the branch history which is aggregated by
the branch records from perf samples. For example, the callchains
aggregated from the branch records are considered as streams.
By browsing the hot stream, we can understand the hot code path.

Now we only support the callchain for stream. For measuring the
hot level for a stream, we use the callchain_node->hit, higher
is hotter.

There may be many callchains sampled so we only focus on the top
N hottest callchains. N is a user defined parameter or predefined
default value (nr_streams_max).

This patch creates an evsel_streams array per event, and saves
the top N hottest streams in a stream array.

So now we can get the per-event top N hottest streams.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 v4:
   - Refactor the code 
   - Rename patch name from 'perf util: Create streams for managing
     top N hottest callchains' to 'perf util: Create streams'

 v2:
   - Use zfree in free_evsel_streams().

 tools/perf/util/Build    |   1 +
 tools/perf/util/stream.c | 152 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/stream.h |  30 ++++++++
 3 files changed, 183 insertions(+)
 create mode 100644 tools/perf/util/stream.c
 create mode 100644 tools/perf/util/stream.h

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index cd5e41960e64..6ffdf833cd51 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -101,6 +101,7 @@ perf-y += call-path.o
 perf-y += rwsem.o
 perf-y += thread-stack.o
 perf-y += spark.o
+perf-y += stream.o
 perf-$(CONFIG_AUXTRACE) += auxtrace.o
 perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 perf-$(CONFIG_AUXTRACE) += intel-pt.o
diff --git a/tools/perf/util/stream.c b/tools/perf/util/stream.c
new file mode 100644
index 000000000000..327a00c27ae2
--- /dev/null
+++ b/tools/perf/util/stream.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Compare and figure out the top N hottest streams
+ * Copyright (c) 2020, Intel Corporation.
+ * Author: Jin Yao
+ */
+
+#include <inttypes.h>
+#include <stdlib.h>
+#include <linux/zalloc.h>
+#include "debug.h"
+#include "hist.h"
+#include "sort.h"
+#include "stream.h"
+#include "evlist.h"
+
+static void free_evsel_streams(struct evsel_streams *es, int nr_evsel)
+{
+	for (int i = 0; i < nr_evsel; i++)
+		zfree(&es[i].streams);
+
+	free(es);
+}
+
+static struct evsel_streams *create_evsel_streams(int nr_evsel,
+						  int nr_streams_max)
+{
+	struct evsel_streams *es;
+
+	es = calloc(nr_evsel, sizeof(struct evsel_streams));
+	if (!es)
+		return NULL;
+
+	for (int i = 0; i < nr_evsel; i++) {
+		struct evsel_streams *s = &es[i];
+
+		s->streams = calloc(nr_streams_max, sizeof(struct stream));
+		if (!s->streams)
+			goto err;
+
+		s->nr_streams_max = nr_streams_max;
+		s->evsel_idx = -1;
+	}
+
+	return es;
+
+err:
+	free_evsel_streams(es, nr_evsel);
+	return NULL;
+}
+
+/*
+ * The cnodes with high hit number are hot callchains.
+ */
+static void set_hot_cnode(struct evsel_streams *es,
+			  struct callchain_node *cnode)
+{
+	int i, idx = 0;
+	u64 hit;
+
+	if (es->nr_streams < es->nr_streams_max) {
+		i = es->nr_streams;
+		es->streams[i].cnode = cnode;
+		es->nr_streams++;
+		return;
+	}
+
+	/*
+	 * Considering a few number of hot streams, only use simple
+	 * way to find the cnode with smallest hit number and replace.
+	 */
+	hit = (es->streams[0].cnode)->hit;
+	for (i = 1; i < es->nr_streams; i++) {
+		if ((es->streams[i].cnode)->hit < hit) {
+			hit = (es->streams[i].cnode)->hit;
+			idx = i;
+		}
+	}
+
+	if (cnode->hit > hit)
+		es->streams[idx].cnode = cnode;
+}
+
+static void update_hot_callchain(struct hist_entry *he,
+				 struct evsel_streams *es)
+{
+	struct rb_root *root = &he->sorted_chain;
+	struct rb_node *rb_node = rb_first(root);
+	struct callchain_node *cnode;
+
+	while (rb_node) {
+		cnode = rb_entry(rb_node, struct callchain_node, rb_node);
+		set_hot_cnode(es, cnode);
+		rb_node = rb_next(rb_node);
+	}
+}
+
+static void init_hot_callchain(struct hists *hists, struct evsel_streams *es)
+{
+	struct rb_node *next = rb_first_cached(&hists->entries);
+
+	while (next) {
+		struct hist_entry *he;
+
+		he = rb_entry(next, struct hist_entry, rb_node);
+		update_hot_callchain(he, es);
+		next = rb_next(&he->rb_node);
+	}
+}
+
+static int evlist_init_callchain_streams(struct evlist *evlist,
+					 struct evsel_streams *es, int nr_es)
+{
+	struct evsel *pos;
+	int i = 0;
+
+	BUG_ON(nr_es < evlist->core.nr_entries);
+
+	evlist__for_each_entry(evlist, pos) {
+		struct hists *hists = evsel__hists(pos);
+
+		hists__output_resort(hists, NULL);
+		init_hot_callchain(hists, &es[i]);
+		es[i].evsel_idx = pos->idx;
+		es[i].stream_type = STREAM_CALLCHAIN;
+		i++;
+	}
+
+	return 0;
+}
+
+struct evsel_streams *perf_evlist__create_streams(struct evlist *evlist,
+						  int nr_streams_max,
+						  enum stream_type type)
+{
+	struct evsel_streams *es;
+	int nr_evsel = evlist->core.nr_entries, ret = -1;
+
+	es = create_evsel_streams(nr_evsel, nr_streams_max);
+	if (!es)
+		return NULL;
+
+	if (type == STREAM_CALLCHAIN)
+		ret = evlist_init_callchain_streams(evlist, es, nr_evsel);
+
+	if (ret) {
+		free_evsel_streams(es, nr_evsel);
+		return NULL;
+	}
+
+	return es;
+}
diff --git a/tools/perf/util/stream.h b/tools/perf/util/stream.h
new file mode 100644
index 000000000000..a8a0172b4d13
--- /dev/null
+++ b/tools/perf/util/stream.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_STREAM_H
+#define __PERF_STREAM_H
+
+#include "callchain.h"
+
+enum stream_type {
+	STREAM_NONE = 0,
+	STREAM_CALLCHAIN
+};
+
+struct stream {
+	struct callchain_node	*cnode;
+};
+
+struct evsel_streams {
+	struct stream		*streams;
+	enum stream_type	stream_type;
+	int			nr_streams_max;
+	int			nr_streams;
+	int			evsel_idx;
+};
+
+struct evlist;
+
+struct evsel_streams *perf_evlist__create_streams(struct evlist *evlist,
+						  int nr_streams_max,
+						  enum stream_type type);
+
+#endif /* __PERF_STREAM_H */
-- 
2.17.1

