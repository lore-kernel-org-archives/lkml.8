Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712F5C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A1752068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778767;
	bh=pNcPjtBjIbBEmOz3L5hAqWcdOymhuZU9G6QhYvZTrpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yb5MXeVF4vhrUFhCgbDjK8WenXQm+fS8QBpOmCf0jlEBFXTb8N1mRb7K80xUsOEOp
	 f9mpEzEGfWG6GpV+sV4KCobQOhSrN/BNo3NLmpoQ5umD8vMv9W659abvgfu2ihSy14
	 UgI4xDSSFX3sEpHjBX+FDqhzwA6TGCsxNMdLvuro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgEFP0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730093AbgEFPZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:55 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C5AF2068E;
        Wed,  6 May 2020 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778755;
        bh=pNcPjtBjIbBEmOz3L5hAqWcdOymhuZU9G6QhYvZTrpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCfLR0TV28rCxB3NsSDJLmd+J44XrIhwWyB7hkEzrGvmdlBY1+rniWrMej81eOimT
         C3A8tGB0UYs7Z3vtWU8YyG90KBykvcaQ3/QHbY8kkI/bngpH8058oCxuzkZ9arIHUq
         UKQKZUyJRYqieCgztNqEhoTO8zLDUNGY6/kOQdXU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 56/91] perf evsel: Rename __perf_evsel__sample_size() to __evsel__sample_size()
Date:   Wed,  6 May 2020 12:21:59 -0300
Message-Id: <20200506152234.21977-57-acme@kernel.org>
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

As it is a 'struct evsel' related method, not part of tools/lib/perf/,
aka libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/sample-parsing.c | 2 +-
 tools/perf/util/evsel.c           | 4 ++--
 tools/perf/util/evsel.h           | 2 +-
 tools/perf/util/intel-bts.c       | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index 61865699c3f4..ab964db855ac 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -296,7 +296,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		goto out_free;
 	}
 
-	evsel.sample_size = __perf_evsel__sample_size(sample_type);
+	evsel.sample_size = __evsel__sample_size(sample_type);
 
 	err = perf_evsel__parse_sample(&evsel, event, &sample_out);
 	if (err) {
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 896b0b9798d8..3a16728074a9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -102,7 +102,7 @@ int perf_evsel__object_config(size_t object_size,
 
 #define FD(e, x, y) (*(int *)xyarray__entry(e->core.fd, x, y))
 
-int __perf_evsel__sample_size(u64 sample_type)
+int __evsel__sample_size(u64 sample_type)
 {
 	u64 mask = sample_type & PERF_SAMPLE_MASK;
 	int size = 0;
@@ -249,7 +249,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->bpf_fd	   = -1;
 	INIT_LIST_HEAD(&evsel->config_terms);
 	perf_evsel__object.init(evsel);
-	evsel->sample_size = __perf_evsel__sample_size(attr->sample_type);
+	evsel->sample_size = __evsel__sample_size(attr->sample_type);
 	evsel__calc_id_pos(evsel);
 	evsel->cmdline_group_boundary = false;
 	evsel->metric_expr   = NULL;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 35ad62807eaf..580975c7086a 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -193,7 +193,7 @@ void evsel__config(struct evsel *evsel, struct record_opts *opts,
 void evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
 			     struct callchain_param *callchain);
 
-int __perf_evsel__sample_size(u64 sample_type);
+int __evsel__sample_size(u64 sample_type);
 void evsel__calc_id_pos(struct evsel *evsel);
 
 bool perf_evsel__is_cache_op_valid(u8 type, u8 op);
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 506112f52619..af1e78d76228 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -825,10 +825,10 @@ static int intel_bts_synth_events(struct intel_bts *bts,
 		bts->branches_id = id;
 		/*
 		 * We only use sample types from PERF_SAMPLE_MASK so we can use
-		 * __perf_evsel__sample_size() here.
+		 * __evsel__sample_size() here.
 		 */
 		bts->branches_event_size = sizeof(struct perf_record_sample) +
-				__perf_evsel__sample_size(attr.sample_type);
+					   __evsel__sample_size(attr.sample_type);
 	}
 
 	return 0;
-- 
2.21.1

