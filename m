Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E224DC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A20DA215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 05:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599631150;
	bh=GbbLUW0d21I6ajMJApUnkTiYr55pEF86niwiJB1ncTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ut9NhxVpkR7R0oJPWPxSaiyJIWJV3NADv8neY/coZ3lWOwyxcchhQZhrqrO164LU5
	 5UmZb5vBrhsBbtaI2JX031G50fz8pTkC6eiL0i4LT+IGiEXufSYRCR+iu7sBVglVyC
	 5dgskDkEp6IpUkX5xlueavBv676OxgzJdz1vmhp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgIIF7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 01:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIF7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 01:59:02 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74940C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 22:59:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id c196so1335434pfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 22:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HoEidOMycJsaLP58g8Hpe3MAJqwIHpofHBEolFK6f88=;
        b=Cu3K9wgAcxu8UTULBPj5kYsMpJg3raf3XlsmxsjpQNdL34dfaBFMy703YynB3DM8AB
         zEpBZLZuvwYKIgd8dLulAbSv/GvWa2DWsPX1CDZrO8WAPCm9SAEw83eSpeQXvsbH8BWW
         Ax1NccjsMcdhfkiDdQWaeTGiureFu61okkN0o3S1fqCjG2rXu1Ve39Lw3ZMDFbVcAbAD
         uaQv1DzZ5HKTuHv/ypG5sLJqlfqDzhB7NuPKdkK3aSZUg41zamsYQP1eT6hnhEnOXO7Y
         +ZriBJc/mck9ME4Oi79KmaVFmFIdZFlrE+OJI9qedvgs4BkZip/hdUzt4BcoHE2wVglp
         SUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HoEidOMycJsaLP58g8Hpe3MAJqwIHpofHBEolFK6f88=;
        b=KgrJbHP5ji7xLvGEl+xZU9zJOtaGjgMLRhcMgJLOplQxcdPySXVOcUZ2FH35siGRF+
         i82hFG0zfy8Y5TI9xhs23BvIIVqt2lpOv4pPxZIreV1SNq269EKvO5ZXE9aR221Dicxk
         B1REKAxfu6kJOgDs/qAjAAnbUjTQxdHpPS8BTHymopdR31R04r3PYGJgbJh83ula8AJ1
         YSFe07vz6K/4eIE53otH74zWkBt/6KcXXcQbX+el4euNcE3+5IYv2ms4vPPN3cBSR5YF
         Xm4FL+q38Fcz2UN/3bD8vTOevowSXJrbvE4IWx06F3X0ao3NxyHwKHe/myUPvhdFUsGz
         lijw==
X-Gm-Message-State: AOAM533ehTsk9j3HqtioYu91lDDKju0zq3FIxA9hvlOC7P8ReL4Is5p2
        z73Vi9WcLGKTfCqJY/rn7So=
X-Google-Smtp-Source: ABdhPJwvwtQYoTAZ0x3/riNy/SJ45NOc1BHiPiBkMg7l/RRJlc7a6++2XWVKrU0TXtSyZBkR0Rvwxg==
X-Received: by 2002:a63:1323:: with SMTP id i35mr1736047pgl.41.1599631142016;
        Tue, 08 Sep 2020 22:59:02 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id q3sm1267158pfb.201.2020.09.08.22.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 22:59:01 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 3/3] perf list: Add 'pfm' to list libpfm4 events
Date:   Wed,  9 Sep 2020 14:58:49 +0900
Message-Id: <20200909055849.469612-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200909055849.469612-1-namhyung@kernel.org>
References: <20200909055849.469612-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print libpfm4 events with 'perf list pfm' command like others.
When libpfm4 support is not enabled, it'd print nothing.
Also it support glob pattern matching for event name.

  $ perf list pfm

  List of pre-defined events (to be used in --pfm-events):

  ix86arch:
    UNHALTED_CORE_CYCLES
      [count core clock cycles whenever the clock signal ...
    INSTRUCTION_RETIRED
      [count the number of instructions at retirement. ...
    ...

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 10ab5e40a34f..167868053fe0 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -14,6 +14,7 @@
 #include "util/pmu.h"
 #include "util/debug.h"
 #include "util/metricgroup.h"
+#include "util/pfm.h"
 #include <subcmd/pager.h>
 #include <subcmd/parse-options.h>
 #include <stdio.h>
@@ -42,7 +43,7 @@ int cmd_list(int argc, const char **argv)
 		OPT_END()
 	};
 	const char * const list_usage[] = {
-		"perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|metric|metricgroup|event_glob]",
+		"perf list [<options>] [hw|sw|cache|tracepoint|pmu|sdt|metric|metricgroup|pfm|event_glob]",
 		NULL
 	};
 
@@ -53,7 +54,7 @@ int cmd_list(int argc, const char **argv)
 
 	setup_pager();
 
-	if (!raw_dump && pager_in_use())
+	if (!raw_dump && pager_in_use() && (argc != 1 || strcmp(argv[0], "pfm")))
 		printf("\nList of pre-defined events (to be used in -e):\n\n");
 
 	if (argc == 0) {
@@ -89,6 +90,8 @@ int cmd_list(int argc, const char **argv)
 			metricgroup__print(true, false, NULL, raw_dump, details_flag);
 		else if (strcmp(argv[i], "metricgroup") == 0 || strcmp(argv[i], "metricgroups") == 0)
 			metricgroup__print(false, true, NULL, raw_dump, details_flag);
+		else if (strcmp(argv[i], "pfm") == 0)
+			print_libpfm_events(NULL, raw_dump, long_desc_flag);
 		else if ((sep = strchr(argv[i], ':')) != NULL) {
 			int sep_idx;
 
@@ -120,6 +123,7 @@ int cmd_list(int argc, const char **argv)
 			print_tracepoint_events(NULL, s, raw_dump);
 			print_sdt_events(NULL, s, raw_dump);
 			metricgroup__print(true, true, s, raw_dump, details_flag);
+			print_libpfm_events(s, raw_dump, long_desc_flag);
 			free(s);
 		}
 	}
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 772f1057647f..ae8ab930a792 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2593,7 +2593,7 @@ static struct option __record_options[] = {
 		     "number of threads to run for event synthesis"),
 #ifdef HAVE_LIBPFM
 	OPT_CALLBACK(0, "pfm-events", &record.evlist, "event",
-		"libpfm4 event selector. use 'perf list' to list available events",
+		"libpfm4 event selector. use 'perf list pfm' to list available events",
 		parse_libpfm_events_option),
 #endif
 	OPT_CALLBACK(0, "control", &record.opts, "fd:ctl-fd[,ack-fd]",
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 483a28ef4ec4..a672d2b68e8a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1166,7 +1166,7 @@ static struct option stat_options[] = {
 		    "threads of same physical core"),
 #ifdef HAVE_LIBPFM
 	OPT_CALLBACK(0, "pfm-events", &evsel_list, "event",
-		"libpfm4 event selector. use 'perf list' to list available events",
+		"libpfm4 event selector. use 'perf list pfm' to list available events",
 		parse_libpfm_events_option),
 #endif
 	OPT_CALLBACK(0, "control", &stat_config, "fd:ctl-fd[,ack-fd]",
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 7c64134472c7..d6adc7d34210 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1578,7 +1578,7 @@ int cmd_top(int argc, const char **argv)
 		    "Enable LBR callgraph stitching approach"),
 #ifdef HAVE_LIBPFM
 	OPT_CALLBACK(0, "pfm-events", &top.evlist, "event",
-		"libpfm4 event selector. use 'perf list' to list available events",
+		"libpfm4 event selector. use 'perf list pfm' to list available events",
 		parse_libpfm_events_option),
 #endif
 	OPTS_EVSWITCH(&top.evswitch),
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c4d2394e2b2d..2d426a4f3bc7 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2899,7 +2899,7 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag,
 
 	metricgroup__print(true, true, NULL, name_only, details_flag);
 
-	print_libpfm_events(name_only, long_desc);
+	print_libpfm_events(NULL, name_only, long_desc);
 }
 
 int parse_events__is_hardcoded_term(struct parse_events_term *term)
diff --git a/tools/perf/util/pfm.c b/tools/perf/util/pfm.c
index d735acb6c29c..26ae2c8c0932 100644
--- a/tools/perf/util/pfm.c
+++ b/tools/perf/util/pfm.c
@@ -12,6 +12,7 @@
 #include "util/parse-events.h"
 #include "util/pmu.h"
 #include "util/pfm.h"
+#include "util/string2.h"
 
 #include <string.h>
 #include <linux/kernel.h>
@@ -227,7 +228,7 @@ print_libpfm_events_raw(pfm_pmu_info_t *pinfo, pfm_event_info_t *info)
 		printf("%s::%s\n", pinfo->name, info->name);
 }
 
-void print_libpfm_events(bool name_only, bool long_desc)
+void print_libpfm_events(const char *event_glob, bool name_only, bool long_desc)
 {
 	pfm_event_info_t info;
 	pfm_pmu_info_t pinfo;
@@ -265,6 +266,9 @@ void print_libpfm_events(bool name_only, bool long_desc)
 			if (ret != PFM_SUCCESS)
 				continue;
 
+			if (event_glob && !strglobmatch_nocase(info.name, event_glob))
+				continue;
+
 			if (!name_only && !printed_pmu) {
 				printf("%s:\n", pinfo.name);
 				printed_pmu = true;
diff --git a/tools/perf/util/pfm.h b/tools/perf/util/pfm.h
index 7d70dda87012..036e2d97b260 100644
--- a/tools/perf/util/pfm.h
+++ b/tools/perf/util/pfm.h
@@ -13,7 +13,7 @@
 int parse_libpfm_events_option(const struct option *opt, const char *str,
 			int unset);
 
-void print_libpfm_events(bool name_only, bool long_desc);
+void print_libpfm_events(const char *event_glob, bool name_only, bool long_desc);
 
 #else
 #include <linux/compiler.h>
@@ -26,7 +26,8 @@ static inline int parse_libpfm_events_option(
 	return 0;
 }
 
-static inline void print_libpfm_events(bool name_only __maybe_unused,
+static inline void print_libpfm_events(const char *event_glob __maybe_unused,
+				       bool name_only __maybe_unused,
 				       bool long_desc __maybe_unused)
 {
 }
-- 
2.28.0.526.ge36021eeef-goog

