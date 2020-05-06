Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC610C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B21221744
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778830;
	bh=6/MZLryqsguiqHUYd5D/S1PSMtmBuk2KDAFGXptidJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ccwvGDwl5OvRhlPpwlGxFb+j04XTByVpZpw7tjw2aEuWe1lMIfN3mZx2vNrl7UmIi
	 6vvFVCcAhrCaIbcwwQNhjWgnmRpTZkInpY1s3wtA4dGZ5CoMyh9bIvNNev8kWJLE3p
	 yUxHa+DDGOPnX89hTofG2M/WRHR0w+dRd3eVWRQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgEFP1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:27:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbgEFP1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:27:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C34F421744;
        Wed,  6 May 2020 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778822;
        bh=6/MZLryqsguiqHUYd5D/S1PSMtmBuk2KDAFGXptidJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dWx0DFu0FtmMb8LVtvxfUKFdNkZshYZlzNLp5U4FGCRgfpQQUDhA2RvH+AWZv49cK
         ddoJdHKRIC4Gi3eGQd6gffYwDQqqPFSE5FkbJjRxeHcVmJRZT0bu78gznheGvuRNby
         2zm4lFVrYlHyftc6sUHF7hTBky+ycQGhIiz6uxtk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 77/91] perf stat: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
Date:   Wed,  6 May 2020 12:22:20 -0300
Message-Id: <20200506152234.21977-78-acme@kernel.org>
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
 tools/perf/builtin-stat.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b2a971961364..e0c1ad23c768 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -238,9 +238,8 @@ static int write_stat_round_event(u64 tm, u64 type)
 
 #define SID(e, x, y) xyarray__entry(e->core.sample_id, x, y)
 
-static int
-perf_evsel__write_stat_event(struct evsel *counter, u32 cpu, u32 thread,
-			     struct perf_counts_values *count)
+static int evsel__write_stat_event(struct evsel *counter, u32 cpu, u32 thread,
+				   struct perf_counts_values *count)
 {
 	struct perf_sample_id *sid = SID(counter, cpu, thread);
 
@@ -297,7 +296,7 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu)
 		perf_counts__set_loaded(counter->counts, cpu, thread, false);
 
 		if (STAT_RECORD) {
-			if (perf_evsel__write_stat_event(counter, cpu, thread, count)) {
+			if (evsel__write_stat_event(counter, cpu, thread, count)) {
 				pr_err("failed to write stat event\n");
 				return -1;
 			}
@@ -410,7 +409,7 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 	workload_exec_errno = info->si_value.sival_int;
 }
 
-static bool perf_evsel__should_store_id(struct evsel *counter)
+static bool evsel__should_store_id(struct evsel *counter)
 {
 	return STAT_RECORD || counter->core.attr.read_format & PERF_FORMAT_ID;
 }
@@ -635,7 +634,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (l > stat_config.unit_width)
 			stat_config.unit_width = l;
 
-		if (perf_evsel__should_store_id(counter) &&
+		if (evsel__should_store_id(counter) &&
 		    evsel__store_ids(counter, evsel_list))
 			return -1;
 	}
-- 
2.21.1

