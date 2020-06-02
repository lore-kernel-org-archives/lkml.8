Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C168C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46CD72074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591134521;
	bh=0cNLqOdsNJVUC2HMwWkHWd75VvTZo055yqqSsHAjaYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VHewShIt46ASn6axNriYdMzdF1XJrp4iBuE41vef8ABgA7QpjxwwiJMN8UtEjZoSY
	 m7Ce62thymWzk5iqz5YJepPql5rwE3c4kIidxivFhWNkwx98ZVbgrBc67KbtNuX9hg
	 GmRSsW6C+HxntVKqN+EXRFyM28J5PYlN7ov33Ogw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgFBVsk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:48:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34401 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728504AbgFBVsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:48:36 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183--VZqDzCeMaW9Fx5mvp9ckQ-1; Tue, 02 Jun 2020 17:48:29 -0400
X-MC-Unique: -VZqDzCeMaW9Fx5mvp9ckQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 178DB1856955;
        Tue,  2 Jun 2020 21:48:28 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67BA21BCBE;
        Tue,  2 Jun 2020 21:48:25 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 11/13] perf tools: Add test_generic_metric function
Date:   Tue,  2 Jun 2020 23:47:39 +0200
Message-Id: <20200602214741.1218986-12-jolsa@kernel.org>
In-Reply-To: <20200602214741.1218986-1-jolsa@kernel.org>
References: <20200602214741.1218986-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding test_generic_metric that prepares and runs given metric
over the data from struct runtime_stat object.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/stat-shadow.c | 14 ++++++++++++++
 tools/perf/util/stat.h        |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 27be7ce2fff4..8fdef47005e6 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -842,6 +842,20 @@ static void generic_metric(struct perf_stat_config *config,
 	expr__ctx_clear(&pctx);
 }
 
+double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_stat *st)
+{
+	struct expr_parse_ctx pctx;
+	double ratio;
+
+	if (prepare_metric(mexp->metric_events, &pctx, cpu, st) < 0)
+		return 0.;
+
+	if (expr__parse(&ratio, &pctx, mexp->metric_expr, 1))
+		return 0.;
+
+	return ratio;
+}
+
 void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 				   struct evsel *evsel,
 				   double avg, int cpu,
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index f75ae679eb28..6911c7249199 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -230,4 +230,7 @@ perf_evlist__print_counters(struct evlist *evlist,
 			    struct target *_target,
 			    struct timespec *ts,
 			    int argc, const char **argv);
+
+struct metric_expr;
+double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_stat *st);
 #endif
-- 
2.25.4

