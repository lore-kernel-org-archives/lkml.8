Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4A6C54E4A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2412208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgEHNKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730427AbgEHNFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73375C05BD09;
        Fri,  8 May 2020 06:05:07 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gZ-0007S3-8C; Fri, 08 May 2020 15:05:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B1C111C04DF;
        Fri,  8 May 2020 15:04:54 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:54 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename perf_evsel__is_aux_event() to
 evsel__is_aux_event()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894309461.8414.5220166258016908195.tip-bot2@tip-bot2>
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

Commit-ID:     39453ed55973cb386ff58bf8a5eca3a65403da74
Gitweb:        https://git.kernel.org/tip/39453ed55973cb386ff58bf8a5eca3a65403da74
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 29 Apr 2020 15:51:38 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:30 -03:00

perf evsel: Rename perf_evsel__is_aux_event() to evsel__is_aux_event()

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
index cddd1d3..bd27f73 100644
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
@@ -769,7 +769,7 @@ no_opt:
 	aux_evsel = NULL;
 	/* Override with aux_sample_size from config term */
 	evlist__for_each_entry(evlist, evsel) {
-		if (perf_evsel__is_aux_event(evsel))
+		if (evsel__is_aux_event(evsel))
 			aux_evsel = evsel;
 		term = perf_evsel__get_config_term(evsel, AUX_SAMPLE_SIZE);
 		if (term) {
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 868e2be..6187dba 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -159,7 +159,7 @@ int perf_evsel__object_config(size_t object_size,
 			      void (*fini)(struct evsel *evsel));
 
 struct perf_pmu *evsel__find_pmu(struct evsel *evsel);
-bool perf_evsel__is_aux_event(struct evsel *evsel);
+bool evsel__is_aux_event(struct evsel *evsel);
 
 struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx);
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 2dd3d6b..5642de7 100644
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
index c2c8cce..97e2c0c 100644
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
