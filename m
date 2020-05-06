Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754F6C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48D8120A8B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778890;
	bh=t/PSX9d2JGSWgwkMAUj8EglMM9hX2N42kgQRM0azjQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uOL06hXvRThWE9MyhK1rVipbm9gZR26EjPXXTw0IqrF/g0aH3M3wC/MqCA50BzBoE
	 pY7BMNZ2LBblyQzV40AGwZbr0h9U2pBN/jXVWbCQmsZNP2AOqYJFQ5coZHu1/rM58k
	 fjGH6h+3H/G7ijc8iLFZvhsXyWdI19J4lR6jERQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbgEFP1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729797AbgEFP1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:27:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 471EB2068E;
        Wed,  6 May 2020 15:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778820;
        bh=t/PSX9d2JGSWgwkMAUj8EglMM9hX2N42kgQRM0azjQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UxBvCq1QPbABqiZzqgqY306ndrg8Ks8sskd7rguOcpBG/uC5gloxF8YR/6dF9ZhVw
         ViQymqNJoaUVz2FIkxdL+ruN4HYsBPbLHqHk37gkbsCttd4EOeJAbVdhWKzokWLr0E
         zjhadBeVnLbWIwu5p+J0qvbNrW7Yf8ZMLq6FoGnQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 76/91] perf evsel: Rename perf_evsel__store_ids() to evsel__store_id()
Date:   Wed,  6 May 2020 12:22:19 -0300
Message-Id: <20200506152234.21977-77-acme@kernel.org>
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
 tools/perf/builtin-stat.c | 2 +-
 tools/perf/util/evsel.c   | 2 +-
 tools/perf/util/evsel.h   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 188b2f957856..b2a971961364 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -636,7 +636,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			stat_config.unit_width = l;
 
 		if (perf_evsel__should_store_id(counter) &&
-		    perf_evsel__store_ids(counter, evsel_list))
+		    evsel__store_ids(counter, evsel_list))
 			return -1;
 	}
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 32d178a3f933..f3e60c45d59a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2588,7 +2588,7 @@ static int store_evsel_ids(struct evsel *evsel, struct evlist *evlist)
 	return 0;
 }
 
-int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist)
+int evsel__store_ids(struct evsel *evsel, struct evlist *evlist)
 {
 	struct perf_cpu_map *cpus = evsel->core.cpus;
 	struct perf_thread_map *threads = evsel->core.threads;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d76111c2d6a8..351c0aaf2a11 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -403,5 +403,5 @@ static inline bool evsel__has_br_stack(const struct evsel *evsel)
 
 struct perf_env *evsel__env(struct evsel *evsel);
 
-int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
+int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
 #endif /* __PERF_EVSEL_H */
-- 
2.21.1

