Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14790C35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB13F20735
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 22:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R58jahGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgEGWGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 18:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgEGWGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 18:06:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D6BC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 15:06:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id h185so8824245ybg.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 15:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=C0M8mvfyEUZvTcioRQRnaCRWnyjcT72VP+TTzmJsK1M=;
        b=R58jahGKuB9YinvgsU7BS0qmRDU8XVonWfVuZpQ4T17QBOXhNTDDGkDfpBm89cN3dn
         AhQhXBGP+xRqMQZgSvVZMamjJCpw9LVn6QuRENGyA0U5g5A93kFbgu+BaSk7VwzbdcrC
         aPdNy1l2HtZlJ95qZC9fnShYZM10XU5L5VPKZau/6sjQhOqBTKBBDkZaFOSld/zMYqz6
         bZ5IqshyxLhQZpd8Fka7ndIr4g31ayysKbdJvbwjZw3M3uogamOot1hrlICH2yAlgOG8
         a4NkqUzDeZJN37iIkFEMe6I0uw232hAbzRY0fxA03vsFYOc0hFyft57YBuhxX2MAMxYz
         kAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=C0M8mvfyEUZvTcioRQRnaCRWnyjcT72VP+TTzmJsK1M=;
        b=nqSv1b5vUz1dPMMu4KY6AuEmzPoNE+WvBKBPvG1mzlbpwabGxhnovkH0gQyu334N6F
         jG6S5kJYeN8xjsZmRHmQ+GTFZuQRrP9yv3r2vvmsUjeUeGRYVEKym0ef/Y7xdXHeo0SY
         fGKLz6K/RH+/Hbm5dOevRaF4zShrlYcts/OGgw205SAwwwFo4d8W+vRKEIf9/fCS2pPr
         MYlXx7UROFVgbuvGVVbunXj5WPM4RmvCk3RSHmJhA7DU7y0cfIOjnj/Tiwffwr4IpMld
         OCZ3OqaArQymieuMaQSi6S8jcPCC9ENuOWSY8DenpPVL4qpGrc1ToKwGn0hWg7zNGAFB
         AxaA==
X-Gm-Message-State: AGi0PubYrMMaJ1CbKSIASExlxZgWZZFRq5a7MEpOpbYH+QYyWeKe+fef
        KBSTrkyWlhEPLUcAznlHOWg9l9DhQ/yG
X-Google-Smtp-Source: APiQypJrV3nRSZb8Vt+OMi4aaLlKHiSXe3x9yE0PSy+oGxRuFAtIZFQm3uXyK4aBM/ZLJmSQuH47tmYKY+30
X-Received: by 2002:a25:af0e:: with SMTP id a14mr25775770ybh.275.1588889177875;
 Thu, 07 May 2020 15:06:17 -0700 (PDT)
Date:   Thu,  7 May 2020 15:06:04 -0700
Message-Id: <20200507220604.3391-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH v3] perf c2c: fix '-e list'
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the event is passed as list, the default events should be listed as
per 'perf mem record -e list'. Previous behavior is:

$ perf c2c record -e list
failed: event 'list' not found, use '-e list' to get list of available events

 Usage: perf c2c record [<options>] [<command>]
    or: perf c2c record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. Use 'perf mem record -e list' to list available events

New behavior:

$ perf c2c record -e list
ldlat-loads  : available
ldlat-stores : available

v3: is a rebase.
v2: addresses review comments by Jiri Olsa.
https://lore.kernel.org/lkml/20191127081844.GH32367@krava/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-c2c.txt |  2 +-
 tools/perf/builtin-c2c.c              |  9 ++++++++-
 tools/perf/builtin-mem.c              | 24 +++++++-----------------
 tools/perf/util/mem-events.c          | 15 +++++++++++++++
 tools/perf/util/mem-events.h          |  2 ++
 5 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 2133eb320cb0..98efdab5fbd4 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -40,7 +40,7 @@ RECORD OPTIONS
 --------------
 -e::
 --event=::
-	Select the PMU event. Use 'perf mem record -e list'
+	Select the PMU event. Use 'perf c2c record -e list'
 	to list available events.
 
 -v::
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 1baf4cae086f..d617d5682c68 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2887,8 +2887,15 @@ static int parse_record_events(const struct option *opt,
 {
 	bool *event_set = (bool *) opt->value;
 
+	if (!strcmp(str, "list")) {
+		perf_mem_events__list();
+		exit(0);
+	}
+	if (perf_mem_events__parse(str))
+		exit(-1);
+
 	*event_set = true;
-	return perf_mem_events__parse(str);
+	return 0;
 }
 
 
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 68a7eb84561a..3523279af6af 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -38,26 +38,16 @@ static int parse_record_events(const struct option *opt,
 			       const char *str, int unset __maybe_unused)
 {
 	struct perf_mem *mem = *(struct perf_mem **)opt->value;
-	int j;
 
-	if (strcmp(str, "list")) {
-		if (!perf_mem_events__parse(str)) {
-			mem->operation = 0;
-			return 0;
-		}
-		exit(-1);
+	if (!strcmp(str, "list")) {
+		perf_mem_events__list();
+		exit(0);
 	}
+	if (perf_mem_events__parse(str))
+		exit(-1);
 
-	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
-		struct perf_mem_event *e = &perf_mem_events[j];
-
-		fprintf(stderr, "%-13s%-*s%s\n",
-			e->tag,
-			verbose > 0 ? 25 : 0,
-			verbose > 0 ? perf_mem_events__name(j) : "",
-			e->supported ? ": available" : "");
-	}
-	exit(0);
+	mem->operation = 0;
+	return 0;
 }
 
 static const char * const __usage[] = {
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index aa29589f6904..ea0af0bc4314 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -103,6 +103,21 @@ int perf_mem_events__init(void)
 	return found ? 0 : -ENOENT;
 }
 
+void perf_mem_events__list(void)
+{
+	int j;
+
+	for (j = 0; j < PERF_MEM_EVENTS__MAX; j++) {
+		struct perf_mem_event *e = &perf_mem_events[j];
+
+		fprintf(stderr, "%-13s%-*s%s\n",
+			e->tag,
+			verbose > 0 ? 25 : 0,
+			verbose > 0 ? perf_mem_events__name(j) : "",
+			e->supported ? ": available" : "");
+	}
+}
+
 static const char * const tlb_access[] = {
 	"N/A",
 	"HIT",
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index f1389bdae7bf..904dad34f7f7 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -39,6 +39,8 @@ int perf_mem_events__init(void);
 
 char *perf_mem_events__name(int i);
 
+void perf_mem_events__list(void);
+
 struct mem_info;
 int perf_mem__tlb_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
 int perf_mem__lvl_scnprintf(char *out, size_t sz, struct mem_info *mem_info);
-- 
2.26.2.645.ge9eca65c58-goog

