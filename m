Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A0AC47257
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEE5820663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778940;
	bh=j3mvAd4AWMOd0sc588HMig1+0l2dK7bH8kj3WD0uJwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gI6xjIyMF5T+rfK3aCP8qTuMdOSSn0kNSN53VLMA05e58+MIhyv32iUE7wTCIc5pH
	 4dDpWyVek9Y05fwTvtBYag0JtCl2l4BWvHxb7tLs50xhSrvdaxiKgqpxwI0yzNmuGd
	 iQQGIyflhBY0zHgaB3VQKRCSybzq+h5xg2Ybldw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgEFP24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730088AbgEFPZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92AEB20CC7;
        Wed,  6 May 2020 15:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778752;
        bh=j3mvAd4AWMOd0sc588HMig1+0l2dK7bH8kj3WD0uJwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbc0bG5DgBytRgq6iHoy9XE1kjf9KXdMFNv7wYxIJk/w/3EPlhStRXVNU9m273GOq
         f82Ft5dkFTnROMaHvWb56Irs2LY37Q111NtURv/AHWwEUV8VJ9JOHEd/5cwngTgLwk
         fb0mFvGvPBcUq4+A4Z/X1UUIohSHedH7OeWGE5ZM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 55/91] perf evsel: Rename perf_evsel__calc_id_pos() to evsel__calc_id_pos()
Date:   Wed,  6 May 2020 12:21:58 -0300
Message-Id: <20200506152234.21977-56-acme@kernel.org>
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
 tools/perf/util/evlist.c | 2 +-
 tools/perf/util/evsel.c  | 8 ++++----
 tools/perf/util/evsel.h  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 6d902c02fd95..8b691151bae3 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -119,7 +119,7 @@ static void perf_evlist__update_id_pos(struct evlist *evlist)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(evlist, evsel)
-		perf_evsel__calc_id_pos(evsel);
+		evsel__calc_id_pos(evsel);
 
 	perf_evlist__set_id_pos(evlist);
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f88cf7961d49..896b0b9798d8 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -178,7 +178,7 @@ static int __perf_evsel__calc_is_pos(u64 sample_type)
 	return idx;
 }
 
-void perf_evsel__calc_id_pos(struct evsel *evsel)
+void evsel__calc_id_pos(struct evsel *evsel)
 {
 	evsel->id_pos = __perf_evsel__calc_id_pos(evsel->core.attr.sample_type);
 	evsel->is_pos = __perf_evsel__calc_is_pos(evsel->core.attr.sample_type);
@@ -190,7 +190,7 @@ void __perf_evsel__set_sample_bit(struct evsel *evsel,
 	if (!(evsel->core.attr.sample_type & bit)) {
 		evsel->core.attr.sample_type |= bit;
 		evsel->sample_size += sizeof(u64);
-		perf_evsel__calc_id_pos(evsel);
+		evsel__calc_id_pos(evsel);
 	}
 }
 
@@ -200,7 +200,7 @@ void __perf_evsel__reset_sample_bit(struct evsel *evsel,
 	if (evsel->core.attr.sample_type & bit) {
 		evsel->core.attr.sample_type &= ~bit;
 		evsel->sample_size -= sizeof(u64);
-		perf_evsel__calc_id_pos(evsel);
+		evsel__calc_id_pos(evsel);
 	}
 }
 
@@ -250,7 +250,7 @@ void evsel__init(struct evsel *evsel,
 	INIT_LIST_HEAD(&evsel->config_terms);
 	perf_evsel__object.init(evsel);
 	evsel->sample_size = __perf_evsel__sample_size(attr->sample_type);
-	perf_evsel__calc_id_pos(evsel);
+	evsel__calc_id_pos(evsel);
 	evsel->cmdline_group_boundary = false;
 	evsel->metric_expr   = NULL;
 	evsel->metric_name   = NULL;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 617cb3fa0353..35ad62807eaf 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -194,7 +194,7 @@ void evsel__config_callchain(struct evsel *evsel, struct record_opts *opts,
 			     struct callchain_param *callchain);
 
 int __perf_evsel__sample_size(u64 sample_type);
-void perf_evsel__calc_id_pos(struct evsel *evsel);
+void evsel__calc_id_pos(struct evsel *evsel);
 
 bool perf_evsel__is_cache_op_valid(u8 type, u8 op);
 
-- 
2.21.1

