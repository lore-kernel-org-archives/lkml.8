Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E92DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14654249CF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730550AbgEHNFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730460AbgEHNFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A2BC05BD0C;
        Fri,  8 May 2020 06:05:14 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gc-0007Qe-4j; Fri, 08 May 2020 15:05:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 721B71C0080;
        Fri,  8 May 2020 15:04:53 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:53 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename perf_evsel__calc_id_pos() to
 evsel__calc_id_pos()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894309339.8414.10851705335701633027.tip-bot2@tip-bot2>
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

Commit-ID:     4b5e87b741f63a9e988236bc1a1050402f2c27a3
Gitweb:        https://git.kernel.org/tip/4b5e87b741f63a9e988236bc1a1050402f2c27a3
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 29 Apr 2020 15:58:40 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:30 -03:00

perf evsel: Rename perf_evsel__calc_id_pos() to evsel__calc_id_pos()

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 2 +-
 tools/perf/util/evsel.c  | 8 ++++----
 tools/perf/util/evsel.h  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6d902c0..8b69115 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -119,7 +119,7 @@ static void perf_evlist__update_id_pos(struct evlist *evlist)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel)
-		perf_evsel__calc_id_pos(evsel);
+		evsel__calc_id_pos(evsel);
 
 	perf_evlist__set_id_pos(evlist);
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f88cf79..896b0b9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -178,7 +178,7 @@ static int __perf_evsel__calc_is_pos(u64 sample_type)
 	return idx;
 }
 
-void perf_evsel__calc_id_pos(struct evsel *evsel)
+void evsel__calc_id_pos(struct evsel *evsel)
 {
 	evsel->id_pos = __perf_evsel__calc_id_pos(evsel->core.attr.sample_type);
 	evsel->is_pos = __perf_evsel__calc_is_pos(evsel->core.attr.sample_type);
@@ -190,7 +190,7 @@ void __perf_evsel__set_sample_bit(struct evsel *evsel,
 	if (!(evsel->core.attr.sample_type & bit)) {
 		evsel->core.attr.sample_type |= bit;
 		evsel->sample_size += sizeof(u64);
-		perf_evsel__calc_id_pos(evsel);
+		evsel__calc_id_pos(evsel);
 	}
 }
 
@@ -200,7 +200,7 @@ void __perf_evsel__reset_sample_bit(struct evsel *evsel,
 	if (evsel->core.attr.sample_type & bit) {
 		evsel->core.attr.sample_type &= ~bit;
 		evsel->sample_size -= sizeof(u64);
-		perf_evsel__calc_id_pos(evsel);
+		evsel__calc_id_pos(evsel);
 	}
 }
 
@@ -250,7 +250,7 @@ void evsel__init(struct evsel *evsel,
 	INIT_LIST_HEAD(&evsel->config_terms);
 	perf_evsel__object.init(evsel);
 	evsel->sample_size = __perf_evsel__sample_size(attr->sample_type);
-	perf_evsel__calc_id_pos(evsel);
+	evsel__calc_id_pos(evsel);
 	evsel->cmdline_group_boundary = false;
 	evsel->metric_expr   = NULL;
 	evsel->metric_name   = NULL;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 617cb3f..35ad628 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -194,7 +194,7 @@ void evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
 			     struct callchain_param *callchain);
 
 int __perf_evsel__sample_size(u64 sample_type);
-void perf_evsel__calc_id_pos(struct evsel *evsel);
+void evsel__calc_id_pos(struct evsel *evsel);
 
 bool perf_evsel__is_cache_op_valid(u8 type, u8 op);
 
