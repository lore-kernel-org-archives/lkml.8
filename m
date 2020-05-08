Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A118C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FF7208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgEHNMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728476AbgEHNEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:04:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056B0C05BD09;
        Fri,  8 May 2020 06:04:52 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gK-00078q-36; Fri, 08 May 2020 15:04:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BA1CF1C03AB;
        Fri,  8 May 2020 15:04:42 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:42 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf script: Rename perf_evsel__*() operating on
 'struct evsel *' to evsel__*()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894308270.8414.12233845197414595584.tip-bot2@tip-bot2>
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

Commit-ID:     ec98b6df37964e5c1ffab4c7e0246f4e612a4196
Gitweb:        https://git.kernel.org/tip/ec98b6df37964e5c1ffab4c7e0246f4e612a4196
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 04 May 2020 13:57:01 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:31 -03:00

perf script: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()

As those is a 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 53 ++++++++++++------------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index fee5647..56d7bcd 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -351,10 +351,8 @@ static const char *output_field2str(enum perf_output_field field)
 
 #define PRINT_FIELD(x)  (output[output_type(attr->type)].fields & PERF_OUTPUT_##x)
 
-static int perf_evsel__do_check_stype(struct evsel *evsel,
-				      u64 sample_type, const char *sample_msg,
-				      enum perf_output_field field,
-				      bool allow_user_set)
+static int evsel__do_check_stype(struct evsel *evsel, u64 sample_type, const char *sample_msg,
+				 enum perf_output_field field, bool allow_user_set)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 	int type = output_type(attr->type);
@@ -383,16 +381,13 @@ static int perf_evsel__do_check_stype(struct evsel *evsel,
 	return 0;
 }
 
-static int perf_evsel__check_stype(struct evsel *evsel,
-				   u64 sample_type, const char *sample_msg,
-				   enum perf_output_field field)
+static int evsel__check_stype(struct evsel *evsel, u64 sample_type, const char *sample_msg,
+			      enum perf_output_field field)
 {
-	return perf_evsel__do_check_stype(evsel, sample_type, sample_msg, field,
-					  false);
+	return evsel__do_check_stype(evsel, sample_type, sample_msg, field, false);
 }
 
-static int perf_evsel__check_attr(struct evsel *evsel,
-				  struct perf_session *session)
+static int perf_evsel__check_attr(struct evsel *evsel, struct perf_session *session)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
 	bool allow_user_set;
@@ -404,32 +399,28 @@ static int perf_evsel__check_attr(struct evsel *evsel,
 					       HEADER_AUXTRACE);
 
 	if (PRINT_FIELD(TRACE) &&
-		!perf_session__has_traces(session, "record -R"))
+	    !perf_session__has_traces(session, "record -R"))
 		return -EINVAL;
 
 	if (PRINT_FIELD(IP)) {
-		if (perf_evsel__check_stype(evsel, PERF_SAMPLE_IP, "IP",
-					    PERF_OUTPUT_IP))
+		if (evsel__check_stype(evsel, PERF_SAMPLE_IP, "IP", PERF_OUTPUT_IP))
 			return -EINVAL;
 	}
 
 	if (PRINT_FIELD(ADDR) &&
-		perf_evsel__do_check_stype(evsel, PERF_SAMPLE_ADDR, "ADDR",
-					   PERF_OUTPUT_ADDR, allow_user_set))
+	    evsel__do_check_stype(evsel, PERF_SAMPLE_ADDR, "ADDR", PERF_OUTPUT_ADDR, allow_user_set))
 		return -EINVAL;
 
 	if (PRINT_FIELD(DATA_SRC) &&
-		perf_evsel__check_stype(evsel, PERF_SAMPLE_DATA_SRC, "DATA_SRC",
-					PERF_OUTPUT_DATA_SRC))
+	    evsel__check_stype(evsel, PERF_SAMPLE_DATA_SRC, "DATA_SRC", PERF_OUTPUT_DATA_SRC))
 		return -EINVAL;
 
 	if (PRINT_FIELD(WEIGHT) &&
-		perf_evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT, "WEIGHT",
-					PERF_OUTPUT_WEIGHT))
+	    evsel__check_stype(evsel, PERF_SAMPLE_WEIGHT, "WEIGHT", PERF_OUTPUT_WEIGHT))
 		return -EINVAL;
 
 	if (PRINT_FIELD(SYM) &&
-		!(evsel->core.attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
+	    !(evsel->core.attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
 		pr_err("Display of symbols requested but neither sample IP nor "
 			   "sample address\navailable. Hence, no addresses to convert "
 		       "to symbols.\n");
@@ -441,7 +432,7 @@ static int perf_evsel__check_attr(struct evsel *evsel,
 		return -EINVAL;
 	}
 	if (PRINT_FIELD(DSO) &&
-		!(evsel->core.attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
+	    !(evsel->core.attr.sample_type & (PERF_SAMPLE_IP|PERF_SAMPLE_ADDR))) {
 		pr_err("Display of DSO requested but no address to convert.\n");
 		return -EINVAL;
 	}
@@ -458,33 +449,27 @@ static int perf_evsel__check_attr(struct evsel *evsel,
 		return -EINVAL;
 	}
 	if ((PRINT_FIELD(PID) || PRINT_FIELD(TID)) &&
-		perf_evsel__check_stype(evsel, PERF_SAMPLE_TID, "TID",
-					PERF_OUTPUT_TID|PERF_OUTPUT_PID))
+	    evsel__check_stype(evsel, PERF_SAMPLE_TID, "TID", PERF_OUTPUT_TID|PERF_OUTPUT_PID))
 		return -EINVAL;
 
 	if (PRINT_FIELD(TIME) &&
-		perf_evsel__check_stype(evsel, PERF_SAMPLE_TIME, "TIME",
-					PERF_OUTPUT_TIME))
+	    evsel__check_stype(evsel, PERF_SAMPLE_TIME, "TIME", PERF_OUTPUT_TIME))
 		return -EINVAL;
 
 	if (PRINT_FIELD(CPU) &&
-		perf_evsel__do_check_stype(evsel, PERF_SAMPLE_CPU, "CPU",
-					   PERF_OUTPUT_CPU, allow_user_set))
+	    evsel__do_check_stype(evsel, PERF_SAMPLE_CPU, "CPU", PERF_OUTPUT_CPU, allow_user_set))
 		return -EINVAL;
 
 	if (PRINT_FIELD(IREGS) &&
-		perf_evsel__check_stype(evsel, PERF_SAMPLE_REGS_INTR, "IREGS",
-					PERF_OUTPUT_IREGS))
+	    evsel__check_stype(evsel, PERF_SAMPLE_REGS_INTR, "IREGS", PERF_OUTPUT_IREGS))
 		return -EINVAL;
 
 	if (PRINT_FIELD(UREGS) &&
-		perf_evsel__check_stype(evsel, PERF_SAMPLE_REGS_USER, "UREGS",
-					PERF_OUTPUT_UREGS))
+	    evsel__check_stype(evsel, PERF_SAMPLE_REGS_USER, "UREGS", PERF_OUTPUT_UREGS))
 		return -EINVAL;
 
 	if (PRINT_FIELD(PHYS_ADDR) &&
-		perf_evsel__check_stype(evsel, PERF_SAMPLE_PHYS_ADDR, "PHYS_ADDR",
-					PERF_OUTPUT_PHYS_ADDR))
+	    evsel__check_stype(evsel, PERF_SAMPLE_PHYS_ADDR, "PHYS_ADDR", PERF_OUTPUT_PHYS_ADDR))
 		return -EINVAL;
 
 	return 0;
