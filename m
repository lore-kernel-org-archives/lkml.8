Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31950C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120F221582
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778840;
	bh=dXhCXXY2ZW+kWGma87ESoXkSdg8h8CDl5lv+yquUJqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bcilS3618x1ZHUAi0C0Wp23w1AWy+M/3k0dR9inw1eYWUS+yHt31RV2zvEEuYi4jN
	 +n11LrPBVg0QX8bpy8857XcCnvC6jXyMlhEUIHbYUon7z1M+/9BlWiuV+NfKaKJjc6
	 RAk25zOxJUM7bvczv8JMTjzjung8Nfnv1zbD0nJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbgEFP1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729717AbgEFP1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:27:11 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5842221835;
        Wed,  6 May 2020 15:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778830;
        bh=dXhCXXY2ZW+kWGma87ESoXkSdg8h8CDl5lv+yquUJqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vk+9/XCgGD5bgu6llKhfNe7DysODaZXiL62/BEjVXxCIOIsvKrtjcqLagrp8mzi2/
         LLwtaJpxhJyjemuPH9/adHPTpSn+mzwj0bLl00XG6hINBegj+ktbnTyM1tNB3GaYQ5
         uG3wbjduOGMg72DaRHunI6lQMVTmcfE6y3Zv75P8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 80/91] perf sched: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
Date:   Wed,  6 May 2020 12:22:23 -0300
Message-Id: <20200506152234.21977-81-acme@kernel.org>
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
 tools/perf/builtin-sched.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index b99398031131..459e4229945e 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1848,7 +1848,7 @@ static inline void print_sched_time(unsigned long long nsecs, int width)
  * returns runtime data for event, allocating memory for it the
  * first time it is used.
  */
-static struct evsel_runtime *perf_evsel__get_runtime(struct evsel *evsel)
+static struct evsel_runtime *evsel__get_runtime(struct evsel *evsel)
 {
 	struct evsel_runtime *r = evsel->priv;
 
@@ -1863,10 +1863,9 @@ static struct evsel_runtime *perf_evsel__get_runtime(struct evsel *evsel)
 /*
  * save last time event was seen per cpu
  */
-static void perf_evsel__save_time(struct evsel *evsel,
-				  u64 timestamp, u32 cpu)
+static void evsel__save_time(struct evsel *evsel, u64 timestamp, u32 cpu)
 {
-	struct evsel_runtime *r = perf_evsel__get_runtime(evsel);
+	struct evsel_runtime *r = evsel__get_runtime(evsel);
 
 	if (r == NULL)
 		return;
@@ -1890,9 +1889,9 @@ static void perf_evsel__save_time(struct evsel *evsel,
 }
 
 /* returns last time this event was seen on the given cpu */
-static u64 perf_evsel__get_time(struct evsel *evsel, u32 cpu)
+static u64 evsel__get_time(struct evsel *evsel, u32 cpu)
 {
-	struct evsel_runtime *r = perf_evsel__get_runtime(evsel);
+	struct evsel_runtime *r = evsel__get_runtime(evsel);
 
 	if ((r == NULL) || (r->last_time == NULL) || (cpu >= r->ncpu))
 		return 0;
@@ -2548,7 +2547,7 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 		goto out;
 	}
 
-	tprev = perf_evsel__get_time(evsel, sample->cpu);
+	tprev = evsel__get_time(evsel, sample->cpu);
 
 	/*
 	 * If start time given:
@@ -2631,7 +2630,7 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 		tr->ready_to_run = 0;
 	}
 
-	perf_evsel__save_time(evsel, sample->time, sample->cpu);
+	evsel__save_time(evsel, sample->time, sample->cpu);
 
 	return rc;
 }
@@ -2941,7 +2940,7 @@ static int timehist_check_attr(struct perf_sched *sched,
 	struct evsel_runtime *er;
 
 	list_for_each_entry(evsel, &evlist->core.entries, core.node) {
-		er = perf_evsel__get_runtime(evsel);
+		er = evsel__get_runtime(evsel);
 		if (er == NULL) {
 			pr_err("Failed to allocate memory for evsel runtime data\n");
 			return -1;
-- 
2.21.1

