Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4C7C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D7424999
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbgEHNL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729205AbgEHNEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:04:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1A7C05BD09;
        Fri,  8 May 2020 06:04:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gL-00079f-5m; Fri, 08 May 2020 15:04:49 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CFDD41C0475;
        Fri,  8 May 2020 15:04:43 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:43 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf kmem: Rename perf_evsel__*() operating on
 'struct evsel *' to evsel__*()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894308377.8414.10816844105228642452.tip-bot2@tip-bot2>
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

Commit-ID:     8cf5d0e09df3176f9afd334b77b216cbc6daf239
Gitweb:        https://git.kernel.org/tip/8cf5d0e09df3176f9afd334b77b216cbc6daf239
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 04 May 2020 13:56:02 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:31 -03:00

perf kmem: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()

As those is a 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kmem.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 0a296fb..38a5ab6 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -169,8 +169,7 @@ static int insert_caller_stat(unsigned long call_site,
 	return 0;
 }
 
-static int perf_evsel__process_alloc_event(struct evsel *evsel,
-					   struct perf_sample *sample)
+static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *sample)
 {
 	unsigned long ptr = evsel__intval(evsel, sample, "ptr"),
 		      call_site = evsel__intval(evsel, sample, "call_site");
@@ -188,10 +187,9 @@ static int perf_evsel__process_alloc_event(struct evsel *evsel,
 	return 0;
 }
 
-static int perf_evsel__process_alloc_node_event(struct evsel *evsel,
-						struct perf_sample *sample)
+static int evsel__process_alloc_node_event(struct evsel *evsel, struct perf_sample *sample)
 {
-	int ret = perf_evsel__process_alloc_event(evsel, sample);
+	int ret = evsel__process_alloc_event(evsel, sample);
 
 	if (!ret) {
 		int node1 = cpu__get_node(sample->cpu),
@@ -232,8 +230,7 @@ static struct alloc_stat *search_alloc_stat(unsigned long ptr,
 	return NULL;
 }
 
-static int perf_evsel__process_free_event(struct evsel *evsel,
-					  struct perf_sample *sample)
+static int evsel__process_free_event(struct evsel *evsel, struct perf_sample *sample)
 {
 	unsigned long ptr = evsel__intval(evsel, sample, "ptr");
 	struct alloc_stat *s_alloc, *s_caller;
@@ -784,8 +781,7 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
 	return 0;
 }
 
-static int perf_evsel__process_page_alloc_event(struct evsel *evsel,
-						struct perf_sample *sample)
+static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_sample *sample)
 {
 	u64 page;
 	unsigned int order = evsel__intval(evsel, sample, "order");
@@ -857,8 +853,7 @@ static int perf_evsel__process_page_alloc_event(struct evsel *evsel,
 	return 0;
 }
 
-static int perf_evsel__process_page_free_event(struct evsel *evsel,
-						struct perf_sample *sample)
+static int evsel__process_page_free_event(struct evsel *evsel, struct perf_sample *sample)
 {
 	u64 page;
 	unsigned int order = evsel__intval(evsel, sample, "order");
@@ -1371,15 +1366,15 @@ static int __cmd_kmem(struct perf_session *session)
 	struct evsel *evsel;
 	const struct evsel_str_handler kmem_tracepoints[] = {
 		/* slab allocator */
-		{ "kmem:kmalloc",		perf_evsel__process_alloc_event, },
-    		{ "kmem:kmem_cache_alloc",	perf_evsel__process_alloc_event, },
-		{ "kmem:kmalloc_node",		perf_evsel__process_alloc_node_event, },
-    		{ "kmem:kmem_cache_alloc_node", perf_evsel__process_alloc_node_event, },
-		{ "kmem:kfree",			perf_evsel__process_free_event, },
-    		{ "kmem:kmem_cache_free",	perf_evsel__process_free_event, },
+		{ "kmem:kmalloc",		evsel__process_alloc_event, },
+		{ "kmem:kmem_cache_alloc",	evsel__process_alloc_event, },
+		{ "kmem:kmalloc_node",		evsel__process_alloc_node_event, },
+		{ "kmem:kmem_cache_alloc_node", evsel__process_alloc_node_event, },
+		{ "kmem:kfree",			evsel__process_free_event, },
+		{ "kmem:kmem_cache_free",	evsel__process_free_event, },
 		/* page allocator */
-		{ "kmem:mm_page_alloc",		perf_evsel__process_page_alloc_event, },
-		{ "kmem:mm_page_free",		perf_evsel__process_page_free_event, },
+		{ "kmem:mm_page_alloc",		evsel__process_page_alloc_event, },
+		{ "kmem:mm_page_free",		evsel__process_page_free_event, },
 	};
 
 	if (!perf_session__has_traces(session, "kmem record"))
