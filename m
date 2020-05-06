Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C130C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EE8520B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778819;
	bh=TGMHakzZB54hdIX61wfyR9JlTxF4XsuILHwpiIkEIbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UjD8l4i5erl+aH+4QxWMM1waJulyLW6RlgbXVaIba9HrTSMAVx85pn9OH/SyR4Fqz
	 X6IUFK0zVAJPb549SQyxMCvo5iw6vD7Cwbt6xQDVnV9SuZxDiR7umMdwcvDmLrG323
	 UbA+tUGZNy8T5MGqVvPCfG1x1Ua6IFmJKtvR6FqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbgEFP06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:26:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729774AbgEFP04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:26:56 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 410622145D;
        Wed,  6 May 2020 15:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778815;
        bh=TGMHakzZB54hdIX61wfyR9JlTxF4XsuILHwpiIkEIbY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vpv9vHawYN1ZILU70CE/0fkH1ndm/4CB55sBJF00JKcsCBxjgtTsT53qF27s/kC1F
         Yqj0HyeBsZU/bFmNNEQCVwByq97XRRyNvcYiFnfFzYpUsiaAW68nq1imlcMVOs5XE8
         XMDS0RtQz9OfpnLzVUQHwbVtwHV10bAf7dT+Y+kI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 74/91] perf evsel: Rename perf_evsel__group_idx() to evsel__group_idx()
Date:   Wed,  6 May 2020 12:22:17 -0300
Message-Id: <20200506152234.21977-75-acme@kernel.org>
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

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c     |  3 +--
 tools/perf/builtin-stat.c       |  3 +--
 tools/perf/builtin-top.c        |  3 +--
 tools/perf/tests/parse-events.c | 44 ++++++++++++++++-----------------
 tools/perf/ui/hist.c            | 10 ++++----
 tools/perf/util/evsel.c         |  7 +++---
 tools/perf/util/evsel.h         |  6 ++---
 7 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 46aaa6b14ca1..e4efdbf1a81e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -857,8 +857,7 @@ static int record__open(struct record *rec)
 				goto try_again;
 			}
 			rc = -errno;
-			perf_evsel__open_strerror(pos, &opts->target,
-						  errno, msg, sizeof(msg));
+			evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
 			ui__error("%s\n", msg);
 			goto out;
 		}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 92a59f08db71..188b2f957856 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -484,8 +484,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 		}
 	}
 
-	perf_evsel__open_strerror(counter, &target,
-				  errno, msg, sizeof(msg));
+	evsel__open_strerror(counter, &target, errno, msg, sizeof(msg));
 	ui__error("%s\n", msg);
 
 	if (child_pid != -1)
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d5bfffed2843..372c38254654 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1051,8 +1051,7 @@ static int perf_top__start_counters(struct perf_top *top)
 				goto try_again;
 			}
 
-			perf_evsel__open_strerror(counter, &opts->target,
-						  errno, msg, sizeof(msg));
+			evsel__open_strerror(counter, &opts->target, errno, msg, sizeof(msg));
 			ui__error("%s\n", msg);
 			goto out_err;
 		}
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 5b90ee3eda71..895188b63f96 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -654,7 +654,7 @@ static int test__group1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* cycles:upp */
@@ -670,7 +670,7 @@ static int test__group1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 2);
 	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	return 0;
@@ -696,7 +696,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* cache-references + :u modifier */
@@ -711,7 +711,7 @@ static int test__group2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* cycles:k */
@@ -754,7 +754,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong group name",
 		!strcmp(leader->group_name, "group1"));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* group1 cycles:kppp */
@@ -771,7 +771,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 3);
 	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* group2 cycles + G modifier */
@@ -789,7 +789,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong group name",
 		!strcmp(leader->group_name, "group2"));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* group2 1:3 + G modifier */
@@ -803,7 +803,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* instructions:u */
@@ -845,7 +845,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* instructions:kp + p */
@@ -861,7 +861,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 2);
 	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	return 0;
@@ -888,7 +888,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* instructions + G */
@@ -903,7 +903,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* cycles:G */
@@ -920,7 +920,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 	TEST_ASSERT_VAL("wrong sample_read", !evsel->sample_read);
 
 	/* instructions:G */
@@ -935,7 +935,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
 	TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
 	/* cycles */
 	evsel = evsel__next(evsel);
@@ -974,7 +974,7 @@ static int test__group_gh1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 
 	/* cache-misses:G + :H group modifier */
 	evsel = evsel__next(evsel);
@@ -988,7 +988,7 @@ static int test__group_gh1(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
 	return 0;
 }
@@ -1014,7 +1014,7 @@ static int test__group_gh2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 
 	/* cache-misses:H + :G group modifier */
 	evsel = evsel__next(evsel);
@@ -1028,7 +1028,7 @@ static int test__group_gh2(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
 	return 0;
 }
@@ -1054,7 +1054,7 @@ static int test__group_gh3(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 
 	/* cache-misses:H + :u group modifier */
 	evsel = evsel__next(evsel);
@@ -1068,7 +1068,7 @@ static int test__group_gh3(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
 	return 0;
 }
@@ -1094,7 +1094,7 @@ static int test__group_gh4(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
 	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
 	TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 0);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
 
 	/* cache-misses:H + :uG group modifier */
 	evsel = evsel__next(evsel);
@@ -1108,7 +1108,7 @@ static int test__group_gh4(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong leader", evsel->leader == leader);
-	TEST_ASSERT_VAL("wrong group_idx", perf_evsel__group_idx(evsel) == 1);
+	TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
 
 	return 0;
 }
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 1a83614901a4..c1f24d004852 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -48,7 +48,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 		struct hist_entry *pair;
 		int nr_members = evsel->core.nr_members;
 
-		prev_idx = perf_evsel__group_idx(evsel);
+		prev_idx = evsel__group_idx(evsel);
 
 		list_for_each_entry(pair, &he->pairs.head, pairs.node) {
 			u64 period = get_field(pair);
@@ -58,7 +58,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 				continue;
 
 			evsel = hists_to_evsel(pair->hists);
-			idx_delta = perf_evsel__group_idx(evsel) - prev_idx - 1;
+			idx_delta = evsel__group_idx(evsel) - prev_idx - 1;
 
 			while (idx_delta--) {
 				/*
@@ -82,7 +82,7 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 							  len, period);
 			}
 
-			prev_idx = perf_evsel__group_idx(evsel);
+			prev_idx = evsel__group_idx(evsel);
 		}
 
 		idx_delta = nr_members - prev_idx - 1;
@@ -164,12 +164,12 @@ static int hist_entry__new_pair(struct hist_entry *a, struct hist_entry *b,
 
 	list_for_each_entry(pair, &a->pairs.head, pairs.node) {
 		struct evsel *evsel = hists_to_evsel(pair->hists);
-		fa[perf_evsel__group_idx(evsel)] = get_field(pair);
+		fa[evsel__group_idx(evsel)] = get_field(pair);
 	}
 
 	list_for_each_entry(pair, &b->pairs.head, pairs.node) {
 		struct evsel *evsel = hists_to_evsel(pair->hists);
-		fb[perf_evsel__group_idx(evsel)] = get_field(pair);
+		fb[evsel__group_idx(evsel)] = get_field(pair);
 	}
 
 	*fields_a = fa;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a75bcb95bf23..5908cd8761d9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1721,8 +1721,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			/*
 			 * If we succeeded but had to kill clockid, fail and
-			 * have perf_evsel__open_strerror() print us a nice
-			 * error.
+			 * have evsel__open_strerror() print us a nice error.
 			 */
 			if (perf_missing_features.clockid ||
 			    perf_missing_features.clockid_wrong) {
@@ -2474,8 +2473,8 @@ static bool find_process(const char *name)
 	return ret ? false : true;
 }
 
-int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
-			      int err, char *msg, size_t size)
+int evsel__open_strerror(struct evsel *evsel, struct target *target,
+			 int err, char *msg, size_t size)
 {
 	char sbuf[STRERR_BUFSIZE];
 	int printed = 0;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 783246bf8d0d..9de7efb83ffc 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -351,10 +351,10 @@ static inline bool evsel__is_clock(struct evsel *evsel)
 }
 
 bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize);
-int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
-			      int err, char *msg, size_t size);
+int evsel__open_strerror(struct evsel *evsel, struct target *target,
+			 int err, char *msg, size_t size);
 
-static inline int perf_evsel__group_idx(struct evsel *evsel)
+static inline int evsel__group_idx(struct evsel *evsel)
 {
 	return evsel->idx - evsel->leader->idx;
 }
-- 
2.21.1

