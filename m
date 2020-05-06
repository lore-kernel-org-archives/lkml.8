Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD6AC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA6524955
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778893;
	bh=aeWBUBWeRr6delzKTXK7RaODizKMIgDD1pPEz3w4ua4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gXd6s1XjPE9sJvI7E3qhfSgzBfDMHN6EvoNLFVKkXBPjHqIh5tEMbTpoJ+LksHCgE
	 YAn9p3FitKtKnp1L/Z3TMcSzzadkN2FJKSG8GH6lwEDsAskorrBBj/bdItE8S0Wgsl
	 csXrGVuJL+B42rUnIdYIqc6SCdoL/W4CO+redEz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgEFP2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730276AbgEFP1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:27:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51C26215A4;
        Wed,  6 May 2020 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778825;
        bh=aeWBUBWeRr6delzKTXK7RaODizKMIgDD1pPEz3w4ua4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sdbRbodPNhaoAOfaq9+iNx+fPhGOmNjRUHqLzhsBhlONAl3iDFlD5vHhEvS/HrgZ9
         bEGoA++dFajAYGUiFWk3QV4AgP5Kr+hgP4P2hvVn5KSssvJwVW/BviuhEoA3BcwSGE
         DoLdz+2PpIgIXV50ODwGMAt/UGVpEC4P43A9EwXc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 78/91] perf kmem: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
Date:   Wed,  6 May 2020 12:22:21 -0300
Message-Id: <20200506152234.21977-79-acme@kernel.org>
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
index 0a296fbf9194..38a5ab683ebc 100644
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
-- 
2.21.1

