Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A44C433EC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA92E207BC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI9LD59T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgGKMnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgGKMnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:43:47 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E51C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:47 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f16so3774459pjt.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nOXWUmqCKgzFvKP1q3KS/DuB4NZonBw3LPsVGjHfXdo=;
        b=eI9LD59T2k58X7twHTISTAkFP5gCTFwuWmlJKAIP/sh2vmAA3N2RYuBvtV/uxM5mMV
         yHsb3RQ6EM3fDl59ydPysyeO1x8V2u6t6b4+koEA2yw6qu6Q8qKiybfKtQoejThh86m5
         bwgcqObfCih4E7opV2k7IqPKTJY1CIc9ffZ6fVvx9JQrzn1JIYNND76nGGbxJiNdE0rl
         J5DVGFGxJwVM0bA8407ahYYDhAkdSZQqszRkr8m+KGJP9qSxxNQk+MpRv5gDw388zxlq
         Rq3lG85GCkoPiWZcNsoo1hAvt866mPvmMGafp4oHO8jsVuzBtf0v9W+aA/4M8FqzYSpp
         TFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nOXWUmqCKgzFvKP1q3KS/DuB4NZonBw3LPsVGjHfXdo=;
        b=no2mE1GWWUC87YdObRgs+3uAqu5e47GOFnU7rEiw8rbYJND6mBRE3+RlrkDKTJgOh/
         CzGUlM1FvUPa2W+XcF2gS1J6Kj7aiH3GGi+uc1PHAnDi7G6ZVxN4LqVsNRTF+PUqi99I
         3rs30FPRf/D76JI2A9QxNVm9o3nakptGct6Kla66CLNderw4cmYeSvkYKQxiSBNSlCku
         i5HuG8qtqopkzb2IDQ71kWKmYqiHaiMhHii3KmcBkandXCJhRFWRaj6OPLb2Iy+Nwf6b
         JVUnuz9FVmLu0IDfSvHNlT1WFD5HO4OqH7QQQOaQLkAIeVWls8hlaRWpNJM64Fp80oKV
         Zd7g==
X-Gm-Message-State: AOAM532EFguEsKN3GejqoQredwflDKuJzpCS/YrYnXSLD9N2BNWoi95l
        0ErRxfKcrBd8DzEmczq/IXs=
X-Google-Smtp-Source: ABdhPJytEYSvdanoa4ZHgaUBY8G28UnB9lLpWEZGHqeaH7rx4LqZpD58gBh6iIsgCF1YYCI6sPRHgg==
X-Received: by 2002:a17:90b:1296:: with SMTP id fw22mr10680996pjb.20.1594471426829;
        Sat, 11 Jul 2020 05:43:46 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c19sm8352899pjs.11.2020.07.11.05.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:43:46 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 16/17] perf ftrace: add option -D/--delay to delay tracing
Date:   Sat, 11 Jul 2020 20:40:34 +0800
Message-Id: <20200711124035.6513-17-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200711124035.6513-1-changbin.du@gmail.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '-D/--delay' to allow us to start tracing some
times later after workload is launched.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  4 ++++
 tools/perf/builtin-ftrace.c              | 19 ++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 97d89478ff5f..62f56058de54 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -42,6 +42,10 @@ OPTIONS
 --tid=::
 	Trace on existing thread id (comma separated list).
 
+-D::
+--delay::
+	Time (ms) to wait before starting tracing after program start.
+
 -a::
 --all-cpus::
 	Force system-wide collection.  Scripts run without a <command>
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 86fc5d466e97..a70951938308 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -47,6 +47,7 @@ struct perf_ftrace {
 	int			graph_noirqs;
 	int			graph_verbose;
 	int			graph_thresh;
+	unsigned int		initial_delay;
 };
 
 struct filter_entry {
@@ -591,13 +592,23 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	/* display column headers */
 	read_tracing_file_to_stdout("trace");
 
-	if (write_tracing_file("tracing_on", "1") < 0) {
-		pr_err("can't enable tracing\n");
-		goto out_close_fd;
+	if (!ftrace->initial_delay) {
+		if (write_tracing_file("tracing_on", "1") < 0) {
+			pr_err("can't enable tracing\n");
+			goto out_close_fd;
+		}
 	}
 
 	perf_evlist__start_workload(ftrace->evlist);
 
+	if (ftrace->initial_delay) {
+		usleep(ftrace->initial_delay * 1000);
+		if (write_tracing_file("tracing_on", "1") < 0) {
+			pr_err("can't enable tracing\n");
+			goto out_close_fd;
+		}
+	}
+
 	while (!done) {
 		if (poll(&pollfd, 1, -1) < 0)
 			break;
@@ -808,6 +819,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "size of per cpu buffer", parse_buffer_size),
 	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
 		    "trace children processes"),
+	OPT_UINTEGER('D', "delay", &ftrace.initial_delay,
+		     "ms to wait before starting tracing after program start"),
 	OPT_END()
 	};
 
-- 
2.25.1

