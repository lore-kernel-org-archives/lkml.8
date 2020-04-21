Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41EBC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B8F52076C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mxh+FOHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgDUGLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725901AbgDUGLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:11:12 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5E2C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:11:12 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id y16so5583877pfe.16
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=RIzLyqeAMPKNRSCa+Pxy4bSho+loHaH+gAhJkVKfA5Y=;
        b=Mxh+FOHSuTGPIsi3vI2gW3Lm8pG1MOCPmVHz9PyNfTi3V6ndicS3DB/1zjVDb01zCt
         LpOcrMoD67cjCrcVvlSP8xDLt9pYMvcGkSVAiDIuZWfh2+dcIw7LZOGjXUM7H4cZ33hX
         9aOxDYdzQX5c99Ny/T8w4pZK+vSHIRJgq4tQATI4WScsn/lN0qwTa4/PDSTqROmB8KJU
         LIUWg6BXgM1Pw15kzsot4HbO5RpHh44ZPCT44WrlxlWwGHWMUz/eofG9zT0jYFTps20I
         1Ll2JrPuvp2dRQrOKxEJdtQLhvxibKmXOh9pg6sddpBzUF03L2Xc/Rem52Lw9N5b86jz
         UZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=RIzLyqeAMPKNRSCa+Pxy4bSho+loHaH+gAhJkVKfA5Y=;
        b=dXXtfSCm2H692ZBODtcSViUC8yeokqwypL1PhzE+PBwDRFlvvn0kDlP/OPD3Pmz4Vk
         4doNfm9EHWOuIBpfw7OYRIumOc/QOOrELW2E6JuZMv9Pbosb6THRx0CcWAU9mIoFYCIv
         j8TgT3DUJiEKFSVzpTUsBdPHOPoBLA7GgMqeBYa1GJ9p2iQ191vQbcLnOiTvsRWlz/jz
         GvmrHTko1UVNFwUD20DHJ8A4rTfixiajgrGtvCOKdLLYaPnmeEtyt4wLRHAO3NOvE0tx
         L2teDWEbkZdWAUqX7xQoDx7ipix/3bKs1wPEVFAwrSlyGDkdVwOOeQVjQeuwFe7d+bqP
         otuw==
X-Gm-Message-State: AGi0Pub+S5elxOUkWyfpRoRmNjt2xVt/RG9yqnIrYYlxTQlmbAsFsxeE
        AV9DgJMpaUME8X1fzPY6Vz2Gqm9mmFn7
X-Google-Smtp-Source: APiQypIxr0m0nQ0jBLEpmzBcq42GXMZFGfmg8vcWBLqYV57RlP7DaRXzsml6ZDEFuSaGKnj3visuyLu7WSRQ
X-Received: by 2002:a63:4646:: with SMTP id v6mr20985099pgk.426.1587449471545;
 Mon, 20 Apr 2020 23:11:11 -0700 (PDT)
Date:   Mon, 20 Apr 2020 23:11:03 -0700
Message-Id: <20200421061103.109440-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH v2] perf record: add dummy event during system wide synthesis
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the processing of /proc during event synthesis new processes may
start. Add a dummy event if /proc is to be processed, to capture mmaps
for starting processes. This reuses the existing logic for
initial-delay.

v2 fixes the dummy event configuration and a branch stack issue.

Suggested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 19 ++++++++++++++-----
 tools/perf/util/evsel.c     |  5 ++++-
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1ab349abe904..8d1e93351298 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -805,19 +805,28 @@ static int record__open(struct record *rec)
 	int rc = 0;
 
 	/*
-	 * For initial_delay we need to add a dummy event so that we can track
-	 * PERF_RECORD_MMAP while we wait for the initial delay to enable the
-	 * real events, the ones asked by the user.
+	 * For initial_delay or system wide, we need to add a dummy event so
+	 * that we can track PERF_RECORD_MMAP to cover the delay of waiting or
+	 * event synthesis.
 	 */
-	if (opts->initial_delay) {
+	if (opts->initial_delay || target__has_cpu(&opts->target)) {
 		if (perf_evlist__add_dummy(evlist))
 			return -ENOMEM;
 
+		/* Disable tracking of mmaps on lead event. */
 		pos = evlist__first(evlist);
 		pos->tracking = 0;
+		/* Set up dummy event. */
 		pos = evlist__last(evlist);
 		pos->tracking = 1;
-		pos->core.attr.enable_on_exec = 1;
+		/*
+		 * Enable the dummy event when the process is forked for
+		 * initial_delay, immediately for system wide.
+		 */
+		if (opts->initial_delay)
+			pos->core.attr.enable_on_exec = 1;
+		else
+			pos->immediate = 1;
 	}
 
 	perf_evlist__config(evlist, opts, &callchain_param);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6a571d322bb2..ca8f9533d8f9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1163,11 +1163,14 @@ void perf_evsel__config(struct evsel *evsel, struct record_opts *opts,
 	}
 
 	/*
+	 * A dummy event never triggers any actual counter and therefore
+	 * cannot be used with branch_stack.
+	 *
 	 * For initial_delay, a dummy event is added implicitly.
 	 * The software event will trigger -EOPNOTSUPP error out,
 	 * if BRANCH_STACK bit is set.
 	 */
-	if (opts->initial_delay && is_dummy_event(evsel))
+	if (is_dummy_event(evsel))
 		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
 }
 
-- 
2.26.1.301.g55bc3eb7cb9-goog

