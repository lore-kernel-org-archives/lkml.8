Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1D7C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59BBB208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgEHNF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730420AbgEHNFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B203C05BD43;
        Fri,  8 May 2020 06:05:06 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gW-0007PG-Dq; Fri, 08 May 2020 15:05:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 15D8D1C0837;
        Fri,  8 May 2020 15:04:53 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:53 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename __perf_evsel__sample_size() to
 __evsel__sample_size()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894309303.8414.13325653212889492516.tip-bot2@tip-bot2>
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

Commit-ID:     2aaefde4d98baf73ef5a6c7c09941fe5e16f5b51
Gitweb:        https://git.kernel.org/tip/2aaefde4d98baf73ef5a6c7c09941fe5e16f5b51
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 29 Apr 2020 16:00:27 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:30 -03:00

perf evsel: Rename __perf_evsel__sample_size() to __evsel__sample_size()

As it is a 'struct evsel' related method, not part of tools/lib/perf/,
aka libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/sample-parsing.c | 2 +-
 tools/perf/util/evsel.c           | 4 ++--
 tools/perf/util/evsel.h           | 2 +-
 tools/perf/util/intel-bts.c       | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 6186569..ab964db 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -296,7 +296,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		goto out_free;
 	}
 
-	evsel.sample_size = __perf_evsel__sample_size(sample_type);
+	evsel.sample_size = __evsel__sample_size(sample_type);
 
 	err = perf_evsel__parse_sample(&evsel, event, &sample_out);
 	if (err) {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 896b0b9..3a16728 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -102,7 +102,7 @@ set_methods:
 
 #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
 
-int __perf_evsel__sample_size(u64 sample_type)
+int __evsel__sample_size(u64 sample_type)
 {
 	u64 mask = sample_type & PERF_SAMPLE_MASK;
 	int size = 0;
@@ -249,7 +249,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->bpf_fd	   = -1;
 	INIT_LIST_HEAD(&evsel->config_terms);
 	perf_evsel__object.init(evsel);
-	evsel->sample_size = __perf_evsel__sample_size(attr->sample_type);
+	evsel->sample_size = __evsel__sample_size(attr->sample_type);
 	evsel__calc_id_pos(evsel);
 	evsel->cmdline_group_boundary = false;
 	evsel->metric_expr   = NULL;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 35ad628..580975c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -193,7 +193,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 void evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
 			     struct callchain_param *callchain);
 
-int __perf_evsel__sample_size(u64 sample_type);
+int __evsel__sample_size(u64 sample_type);
 void evsel__calc_id_pos(struct evsel *evsel);
 
 bool perf_evsel__is_cache_op_valid(u8 type, u8 op);
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 506112f..af1e78d 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -825,10 +825,10 @@ static int intel_bts_synth_events(struct intel_bts *bts,
 		bts->branches_id = id;
 		/*
 		 * We only use sample types from PERF_SAMPLE_MASK so we can use
-		 * __perf_evsel__sample_size() here.
+		 * __evsel__sample_size() here.
 		 */
 		bts->branches_event_size = sizeof(struct perf_record_sample) +
-				__perf_evsel__sample_size(attr.sample_type);
+					   __evsel__sample_size(attr.sample_type);
 	}
 
 	return 0;
