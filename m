Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7560AC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7342080C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="lDQLoSbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgIJD2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbgIJD0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:26:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B653C061757
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 20:26:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id v3so4108290ybb.22
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 20:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=s1b7E0huzhjO63i42S0YmedtL3oR6qijaC60+IFuPgk=;
        b=lDQLoSbqZVvAgbDpz1vvz4awAiq2k2TMGbIXn5KxMuYHB4wRhSSqIzr1WbvoWfbKh2
         6KBr01hsZ98thjEZnoXFvEeXUZGz1O02RjIs6n6xxkHLHGV5uThZ8ya86LSnwsmbMlhP
         h+wF1ZwU5WfYfcYFGBgFhBo3DD0zdMnMWkRxclFmGouZhboB2sX7IPaSdxoxJDjRRfzO
         xdLU3kRHlQ6htYJJtZm0vMKq8th4YZ16N9yEMizP4WgHyhFmlG82V3e9W+Ese3zR1t+j
         XLAM3UUspgVGV6MrpHmD2aTaR+Kk5iY5siwt16ZYXWeDFshnZ5PWHnHg80Hm3wBTNaO0
         r84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s1b7E0huzhjO63i42S0YmedtL3oR6qijaC60+IFuPgk=;
        b=ScgPGTXPaLOhRnzB76FWI9D9YAkDnsdGpHPl1fVbR4w3eH5DHzb7xn7oCw3wSs6OCh
         wemAyJBIlyMjGQYbVojmLDGGQPcQ9+YavlDe8/S68R/T78Ml5w88hC6f8kbz1k3Ood4J
         RQofghpdJqfSd1qinO4sVUs8LHlrNTB25L9V+0Hfm+uVWYw+sAkUnmZKJrVASDXirx8+
         8ZlUF6SYbx4zvv88UI2hDVU1Vr0YM7xR2E740+2vw/RP9IdVI58Pi2XYRW+gBuGB6our
         K1JYtT9ycLx+UEcfiCwirQLMJp4layoo3D+EadVK2ViCgqSzG72rdFLifiW+Pc9Nu8oo
         4NjA==
X-Gm-Message-State: AOAM533HsAlZnIMZ/efPVQheierY13zOdoacN2j3Ma+De3z67MXLuzUy
        mPy8rkclZSYP2YcUJO1xVP3A4tyQ63VQ
X-Google-Smtp-Source: ABdhPJwzVOWe3M5Y3U3FN+0SL5A6O0J4pWgkpcVSLpBV8nZ+0b+gODgxIl6eL3xldI0fyRCrNgekgtXwhAG/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:d2cf:: with SMTP id
 j198mr10048036ybg.418.1599708400805; Wed, 09 Sep 2020 20:26:40 -0700 (PDT)
Date:   Wed,  9 Sep 2020 20:26:32 -0700
In-Reply-To: <20200910032632.511566-1-irogers@google.com>
Message-Id: <20200910032632.511566-3-irogers@google.com>
Mime-Version: 1.0
References: <20200910032632.511566-1-irogers@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 3/3] perf metricgroup: Fix uncore metric expressions
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A metric like DRAM_BW_Use has on SkylakeX events uncore_imc/cas_count_read/
and uncore_imc/case_count_write/. These events open 6 events per socket
with pmu names of uncore_imc_[0-5]. The current metric setup code in
find_evsel_group assumes one ID will map to 1 event to be recorded in
metric_events. For events with multiple matches, the first event is
recorded in metric_events (avoiding matching >1 event with the same
name) and the evlist_used updated so that duplicate events aren't
removed when the evlist has unused events removed.

Before this change:
$ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1

 Performance counter stats for 'system wide':

             41.14 MiB  uncore_imc/cas_count_read/
     1,002,614,251 ns   duration_time

       1.002614251 seconds time elapsed

After this change:
$ /tmp/perf/perf stat -M DRAM_BW_Use -a -- sleep 1

 Performance counter stats for 'system wide':

            157.47 MiB  uncore_imc/cas_count_read/ #     0.00 DRAM_BW_Use
            126.97 MiB  uncore_imc/cas_count_write/
     1,003,019,728 ns   duration_time

v2. avoids iterating over the whole evlist as suggested by
    namhyung@kernel.org. It also fixes the metric_leader computation
    that was broken in the same commits.

Erroneous duplication introduced in:
commit 2440689d62e9 ("perf metricgroup: Remove duped metric group events").

Fixes: ded80bda8bc9 ("perf expr: Migrate expr ids table to a hashmap").
Reported-by: Jin Yao <yao.jin@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 45 ++++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 662f4e8777d5..79080de9217d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -206,6 +206,18 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				sizeof(struct evsel *) * idnum);
 			current_leader = ev->leader;
 		}
+		/*
+		 * Check for duplicate events with the same name. For example,
+		 * uncore_imc/cas_count_read/ will turn into 6 events per socket
+		 * on skylakex. Only the first such event is placed in
+		 * metric_events.
+		 */
+		for (i = 0; i < matched_events; i++) {
+			if (!strcmp(metric_events[i]->name, ev->name))
+				break;
+		}
+		if (i != matched_events)
+			continue;
 		if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr)) {
 			if (has_constraint) {
 				/*
@@ -245,9 +257,36 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 	metric_events[idnum] = NULL;
 
 	for (i = 0; i < idnum; i++) {
-		ev = metric_events[i];
-		ev->metric_leader = ev;
-		set_bit(ev->idx, evlist_used);
+		/* Don't free used events. */
+		set_bit(metric_events[i]->idx, evlist_used);
+		/*
+		 * The metric leader points to the identically named event in
+		 * metric_events.
+		 */
+		metric_events[i]->metric_leader = metric_events[i];
+		/*
+		 * Mark two events with identical names in the same group (or
+		 * globally) as being in use as uncore events may be duplicated
+		 * for each pmu. Set the metric leader to be the event that
+		 * appears in metric_events.
+		 */
+		if (!has_constraint) {
+			for_each_group_evsel(ev, metric_events[i]->leader) {
+				if (ev != metric_events[i] &&
+				    !strcmp(metric_events[i]->name, ev->name)) {
+					set_bit(ev->idx, evlist_used);
+					ev->metric_leader = metric_events[i];
+				}
+			}
+		} else {
+			evlist__for_each_entry(perf_evlist, ev) {
+				if (ev != metric_events[i] &&
+				    !strcmp(metric_events[i]->name, ev->name)) {
+					set_bit(ev->idx, evlist_used);
+					ev->metric_leader = metric_events[i];
+				}
+			}
+		}
 	}
 
 	return metric_events[0];
-- 
2.28.0.526.ge36021eeef-goog

