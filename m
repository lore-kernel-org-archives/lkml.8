Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2356C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D252A2192A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778815;
	bh=9WsWM9Xa603KvtWrdVrNv3WnxgTQlk3Sr+wKK0/8K/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l4mqAYBXgolrgCVZ76PMXMqy6O0S1POT4seCZtWBIjaXDSiXC6IAYCPYNI8EE/Yuw
	 6E7uAZ6tt+D4mBxNVp8QGBUAXPfdAb4zVpmD4vC9UgEgFS4qsQdBiBk9yfWrFEtu1t
	 AazxBacECKOmqNRfe1l5CRp21mlqg1h+6O6bqttU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbgEFP0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729774AbgEFP0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:26:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7BF721835;
        Wed,  6 May 2020 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778812;
        bh=9WsWM9Xa603KvtWrdVrNv3WnxgTQlk3Sr+wKK0/8K/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aq4z/s2UVEkaT14YObIGighIRKPv3wLPCoBUGEq/H9EbxM4NDI75VomtHgw2iE7r5
         Qkj8yhy+8MHOEVxL7Oj8MyFLJOHBEkuPYQZ+WZa0OJHa/6AL44mFeoFRo0mKP1SwG2
         YAhHWIOcso10rouOAvjB61G7e1ep4uQ6d2N8xntQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 73/91] perf evsel: Rename perf_evsel__fallback() to evsel__fallback()
Date:   Wed,  6 May 2020 12:22:16 -0300
Message-Id: <20200506152234.21977-74-acme@kernel.org>
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
 tools/perf/builtin-record.c | 2 +-
 tools/perf/builtin-stat.c   | 2 +-
 tools/perf/builtin-top.c    | 2 +-
 tools/perf/util/cloexec.c   | 2 +-
 tools/perf/util/evsel.c     | 3 +--
 tools/perf/util/evsel.h     | 3 +--
 6 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ab303c4165ac..46aaa6b14ca1 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -845,7 +845,7 @@ static int record__open(struct record *rec)
 	evlist__for_each_entry(evlist, pos) {
 try_again:
 		if (evsel__open(pos, pos->core.cpus, pos->core.threads) < 0) {
-			if (perf_evsel__fallback(pos, errno, msg, sizeof(msg))) {
+			if (evsel__fallback(pos, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
 				goto try_again;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e3629ca69827..92a59f08db71 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -466,7 +466,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 		if ((counter->leader != counter) ||
 		    !(counter->leader->core.nr_members > 1))
 			return COUNTER_SKIP;
-	} else if (perf_evsel__fallback(counter, errno, msg, sizeof(msg))) {
+	} else if (evsel__fallback(counter, errno, msg, sizeof(msg))) {
 		if (verbose > 0)
 			ui__warning("%s\n", msg);
 		return COUNTER_RETRY;
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 4403a76f2047..d5bfffed2843 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1045,7 +1045,7 @@ static int perf_top__start_counters(struct perf_top *top)
 			    perf_top_overwrite_fallback(top, counter))
 				goto try_again;
 
-			if (perf_evsel__fallback(counter, errno, msg, sizeof(msg))) {
+			if (evsel__fallback(counter, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
 				goto try_again;
diff --git a/tools/perf/util/cloexec.c b/tools/perf/util/cloexec.c
index a12872f2856a..6b3988a7aba8 100644
--- a/tools/perf/util/cloexec.c
+++ b/tools/perf/util/cloexec.c
@@ -28,7 +28,7 @@ int __weak sched_getcpu(void)
 
 static int perf_flag_probe(void)
 {
-	/* use 'safest' configuration as used in perf_evsel__fallback() */
+	/* use 'safest' configuration as used in evsel__fallback() */
 	struct perf_event_attr attr = {
 		.type = PERF_TYPE_SOFTWARE,
 		.config = PERF_COUNT_SW_CPU_CLOCK,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 909e993b4dcd..a75bcb95bf23 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2382,8 +2382,7 @@ u64 evsel__intval(struct evsel *evsel, struct perf_sample *sample, const char *n
 	return field ? format_field__intval(field, sample, evsel->needs_swap) : 0;
 }
 
-bool perf_evsel__fallback(struct evsel *evsel, int err,
-			  char *msg, size_t msgsize)
+bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize)
 {
 	int paranoid;
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 101cfff647c7..783246bf8d0d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -350,8 +350,7 @@ static inline bool evsel__is_clock(struct evsel *evsel)
 	       evsel__match(evsel, SOFTWARE, SW_TASK_CLOCK);
 }
 
-bool perf_evsel__fallback(struct evsel *evsel, int err,
-			  char *msg, size_t msgsize);
+bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize);
 int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
 			      int err, char *msg, size_t size);
 
-- 
2.21.1

