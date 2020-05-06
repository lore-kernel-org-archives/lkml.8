Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FD0C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9EB20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778740;
	bh=742wxQ2igPA+GjM19lJE9hkbv2XeuzJALJfduoyb7WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0pa9gOzhoRjfDiUzy3M0LuUrtC6Vr8Z52GMApXooz+eRisLAL6sx3FPZQfgDjNm/P
	 DydxAyxXBVY8Crp3N1GZmqm8jhLn+pCFWsLl/ATUhiSemYvRVVWyGZKwTC8baBaDyn
	 K4DH8kaavNl3A8RHDK1VfhTO5L+S+7b1MyA9Kn3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgEFPZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730047AbgEFPZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:35 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E48221835;
        Wed,  6 May 2020 15:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778735;
        bh=742wxQ2igPA+GjM19lJE9hkbv2XeuzJALJfduoyb7WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O5ti17sUVC9Q/k33a9VjNzsKxJQ4SILch8yajdkdr7ztyPO54qW1yuf2yaL7eH3HQ
         i4BoQOjhaEXynyNybn0iqmTQi1msnAjYkxzs9JQR+vK0KpdXFd4XVV5eossshfDCoF
         KN5/YUPqh4dePy5ruv1Ci8GGq7t9rCwuvHxwjKL0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 48/91] perf evsel: Rename 'struct perf_evsel__sb_cb_t' to 'struct evsel__sb_cb_t'
Date:   Wed,  6 May 2020 12:21:51 -0300
Message-Id: <20200506152234.21977-49-acme@kernel.org>
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

As the "perf_" prefix should be restricted to functions and types in
tools/lib/perf/, aka libperf, this way we reduce a bit the confusion for
types only in libperf or the ones in the more contained tools/perf/
project.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.h          | 4 ++--
 tools/perf/util/evsel.h           | 6 +++---
 tools/perf/util/sideband_evlist.c | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 93de63e2a247..b6f325dfb4d2 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -109,9 +109,9 @@ int perf_evlist__add_dummy(struct evlist *evlist);
 
 int perf_evlist__add_sb_event(struct evlist *evlist,
 			      struct perf_event_attr *attr,
-			      perf_evsel__sb_cb_t cb,
+			      evsel__sb_cb_t cb,
 			      void *data);
-void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb, void *data);
+void evlist__set_cb(struct evlist *evlist, evsel__sb_cb_t cb, void *data);
 int perf_evlist__start_sb_thread(struct evlist *evlist,
 				 struct target *target);
 void perf_evlist__stop_sb_thread(struct evlist *evlist);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index bf999e3c50c7..7ff37c4cdf9f 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -18,7 +18,7 @@ struct perf_counts;
 struct perf_stat_evsel;
 union perf_event;
 
-typedef int (perf_evsel__sb_cb_t)(union perf_event *event, void *data);
+typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
 
 enum perf_tool_event {
 	PERF_TOOL_NONE		= 0,
@@ -101,8 +101,8 @@ struct evsel {
 	int			cpu_iter;
 	const char		*pmu_name;
 	struct {
-		perf_evsel__sb_cb_t	*cb;
-		void			*data;
+		evsel__sb_cb_t	*cb;
+		void		*data;
 	} side_band;
 	/*
 	 * For reporting purposes, an evsel sample can have a callchain
diff --git a/tools/perf/util/sideband_evlist.c b/tools/perf/util/sideband_evlist.c
index 1d6f470d64c4..bb3706fbcc0c 100644
--- a/tools/perf/util/sideband_evlist.c
+++ b/tools/perf/util/sideband_evlist.c
@@ -13,7 +13,7 @@
 #include <stdbool.h>
 
 int perf_evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
-			      perf_evsel__sb_cb_t cb, void *data)
+			      evsel__sb_cb_t cb, void *data)
 {
 	struct evsel *evsel;
 
@@ -81,7 +81,7 @@ static void *perf_evlist__poll_thread(void *arg)
 	return NULL;
 }
 
-void evlist__set_cb(struct evlist *evlist, perf_evsel__sb_cb_t cb, void *data)
+void evlist__set_cb(struct evlist *evlist, evsel__sb_cb_t cb, void *data)
 {
 	struct evsel *evsel;
 
-- 
2.21.1

