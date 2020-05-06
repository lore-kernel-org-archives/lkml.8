Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A331C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE9B20575
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778948;
	bh=bv2Ns6aKlEsMUOG/ar3l8EPedmR42XFwpgmk/Jsbf0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1OFhWCuM0fV4vpthmG8ENC69RViHM2GT+d+xcdJJIlbErgmGAiLzs1LPu5pBs78Lq
	 eYTKxurP8pcr343TRq9Io+S3ja886VUYg6jEABdBO9UYNN4YZCu4fGp5lLQ4nDmYyh
	 iHTaL/dvlxa8QL89lBgLzwiS8dmnska1pH+y1Vw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgEFP3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729475AbgEFPZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:45 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1224521835;
        Wed,  6 May 2020 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778745;
        bh=bv2Ns6aKlEsMUOG/ar3l8EPedmR42XFwpgmk/Jsbf0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HHZKGpxNS1ayfDlA7EW3kDyZhtuLaXRLyq9jxCyBX3ih0aQT4gTVVBAnmnpcQBaiV
         FLT5DHPASfJCbLETw+N5VDOTj3HQf/1rGK7WIeE0kPs9i929cfZs9yWJFMGdIBZg6P
         Aqgyu2notBoj7cR/n4DoQlqzaspUA2mnp9qZiPks=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 52/91] perf evsel: Rename perf_evsel__is_aux_event() to evsel__is_aux_event()
Date:   Wed,  6 May 2020 12:21:55 -0300
Message-Id: <20200506152234.21977-53-acme@kernel.org>
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
 tools/perf/util/auxtrace.c | 6 +++---
 tools/perf/util/evsel.h    | 2 +-
 tools/perf/util/pmu.c      | 2 +-
 tools/perf/util/record.c   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index cddd1d36f724..bd27f73b6d60 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -686,7 +686,7 @@ static int auxtrace_validate_aux_sample_size(struct evlist *evlist,
 	evlist__for_each_entry(evlist, evsel) {
 		sz = evsel->core.attr.aux_sample_size;
 		if (perf_evsel__is_group_leader(evsel)) {
-			has_aux_leader = perf_evsel__is_aux_event(evsel);
+			has_aux_leader = evsel__is_aux_event(evsel);
 			if (sz) {
 				if (has_aux_leader)
 					pr_err("Cannot add AUX area sampling to an AUX area event\n");
@@ -760,7 +760,7 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr,
 	/* Set aux_sample_size based on --aux-sample option */
 	evlist__for_each_entry(evlist, evsel) {
 		if (perf_evsel__is_group_leader(evsel)) {
-			has_aux_leader = perf_evsel__is_aux_event(evsel);
+			has_aux_leader = evsel__is_aux_event(evsel);
 		} else if (has_aux_leader) {
 			evsel->core.attr.aux_sample_size = sz;
 		}
@@ -769,7 +769,7 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr,
 	aux_evsel = NULL;
 	/* Override with aux_sample_size from config term */
 	evlist__for_each_entry(evlist, evsel) {
-		if (perf_evsel__is_aux_event(evsel))
+		if (evsel__is_aux_event(evsel))
 			aux_evsel = evsel;
 		term = perf_evsel__get_config_term(evsel, AUX_SAMPLE_SIZE);
 		if (term) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 868e2be434c4..6187dba21298 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -159,7 +159,7 @@ int perf_evsel__object_config(size_t object_size,
 			      void (*fini)(struct evsel *evsel));
 
 struct perf_pmu *evsel__find_pmu(struct evsel *evsel);
-bool perf_evsel__is_aux_event(struct evsel *evsel);
+bool evsel__is_aux_event(struct evsel *evsel);
 
 struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 2dd3d6be1a61..5642de7f8be7 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -898,7 +898,7 @@ struct perf_pmu *evsel__find_pmu(struct evsel *evsel)
 	return pmu;
 }
 
-bool perf_evsel__is_aux_event(struct evsel *evsel)
+bool evsel__is_aux_event(struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel__find_pmu(evsel);
 
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index c2c8cce506b4..97e2c0cedc12 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -24,7 +24,7 @@ static struct evsel *perf_evsel__read_sampler(struct evsel *evsel,
 {
 	struct evsel *leader = evsel->leader;
 
-	if (perf_evsel__is_aux_event(leader)) {
+	if (evsel__is_aux_event(leader)) {
 		evlist__for_each_entry(evlist, evsel) {
 			if (evsel->leader == leader && evsel != evsel->leader)
 				return evsel;
-- 
2.21.1

