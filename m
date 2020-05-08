Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FB5C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4CE2496C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgEHNFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729403AbgEHNEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:04:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0FCC05BD43;
        Fri,  8 May 2020 06:04:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gK-0007Cd-HM; Fri, 08 May 2020 15:04:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 850891C04D0;
        Fri,  8 May 2020 15:04:45 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:45 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename perf_evsel__group_idx() to
 evsel__group_idx()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894308549.8414.5570374305019564878.tip-bot2@tip-bot2>
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

Commit-ID:     2bb72dbb826c40e2503949ea5d104c3af976d02c
Gitweb:        https://git.kernel.org/tip/2bb72dbb826c40e2503949ea5d104c3af976d02c
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 04 May 2020 13:43:03 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:31 -03:00

perf evsel: Rename perf_evsel__group_idx() to evsel__group_idx()

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
 tools/perf/tests/parse-events.c | 44 ++++++++++++++++----------------
 tools/perf/ui/hist.c            | 10 +++----
 tools/perf/util/evsel.c         |  7 ++---
 tools/perf/util/evsel.h         |  6 ++--
 7 files changed, 36 insertions(+), 40 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 46aaa6b..e4efdbf 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -857,8 +857,7 @@ try_again:
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
index 92a59f0..188b2f9 100644
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
index d5bfffe..372c382 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1051,8 +1051,7 @@ try_again:
 				goto try_again;
 			}
 
-			perf_evsel__open_strerror(counter, &opts->target,
-						  errno, msg, sizeof(msg));
+			evsel__open_strerror(counter, &opts->target, errno, msg, sizeof(msg));
 			ui__error("%s\n", msg);
 			goto out_err;
 		}
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 5b90ee3..895188b 100644
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
index 1a83614..c1f24d0 100644
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
index a75bcb9..5908cd8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1721,8 +1721,7 @@ retry_open:
 
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
index 783246b..9de7efb 100644
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
