Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E557C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AC420724
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCB9DrBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgGRGuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgGRGuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:50:51 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B864C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:50:51 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mn17so7488273pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGmY2yM7IBrhvEVueqg0kykP3l1lO9dWCgs8ldRYKD4=;
        b=CCB9DrBTBmpG5KzJuUiSjbgH2HRbHpskA/9SulNN83P//qRqUXEqweWhZtzPuj3o86
         rpFhDSogj2BYRZrm2aVjWqAuYluTbT1KzKuf+BTqRjc1fdTeMA9zvZbO+5iAzrJhR+7L
         nvjUHvUuZchuwKB9UKCMn3yOQWDfrVMV+eP7FB6gsyCAsTJ44I0gQMlCr5Ow5wJ8yRtb
         5iarU3BjKeXYZyk6jkq61rSXoRIMyxMVEMJ3gyDHZ2w2p/9QMKRYJz6R7AdH2Zm9Oq7z
         AD6CYqNw0V4FKoTX6M3C2IPugWfpAgn+/fqIobEz8/VMn77cr/QyLmx0GBktTZ7n8ShJ
         s9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGmY2yM7IBrhvEVueqg0kykP3l1lO9dWCgs8ldRYKD4=;
        b=SdT2zT4L94xvyrWnRbBMRwFnwFAuGrvillRe8QaZrnK6VSg5+pk8M9KAkY3G7FGtVv
         YjsFJa/nr6Q+Xaxap4q57Mz1hh2m5hMn04NFM6vgDrqNPkIwnYutiZDtpYRoRvtOWfFJ
         zWoN96SwyFeOa3fxjGKGkzygYtu3dxbQRJWsG/rABgTiKOHKVFyD4GaEzFO1A5YaA3Si
         tNLeX/DkIZIFynd3etNQ/Aj9Zdk81GiL8Ma2Mg1TDwsr4jJ0LO9uChayJ720jqE70VE8
         9CUOlpHQJHYZ0glp2X0UHUBRmvSMGstVX6+EUoZajAOiI3KxiZxojispHPejdokM+jgL
         P1IA==
X-Gm-Message-State: AOAM530y+eW4tBdX+BDfl5vCB2+bYFE4eu/5ylqunYRRFs2PInfwS362
        6x766RKmXrjmc6IAsDIFiNI=
X-Google-Smtp-Source: ABdhPJwKZSwTrUsfBnwkwq6ogfkke2DOF8a15GkCVscx3apTtsidgtJ/kOrDsBxsQG3c0Y0i3cNx9Q==
X-Received: by 2002:a17:90a:e7cd:: with SMTP id kb13mr13193956pjb.138.1595055051200;
        Fri, 17 Jul 2020 23:50:51 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:50:50 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 15/18] perf ftrace: add option -D/--delay to delay tracing
Date:   Sat, 18 Jul 2020 14:48:23 +0800
Message-Id: <20200718064826.9865-16-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
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
index 6f17939b8789..077249c979f2 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -38,6 +38,10 @@ OPTIONS
 --pid=::
 	Trace on existing process id (comma separated list).
 
+-D::
+--delay::
+	Time (ms) to wait before starting tracing after program start.
+
 -a::
 --all-cpus::
 	Force system-wide collection.  Scripts run without a <command>
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 3ddd7568b456..64b68331048a 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -47,6 +47,7 @@ struct perf_ftrace {
 	int			graph_noirqs;
 	int			graph_verbose;
 	int			graph_thresh;
+	unsigned int		initial_delay;
 };
 
 struct filter_entry {
@@ -594,13 +595,23 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -809,6 +820,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "size of per cpu buffer", parse_buffer_size),
 	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
 		    "trace children processes"),
+	OPT_UINTEGER('D', "delay", &ftrace.initial_delay,
+		     "ms to wait before starting tracing after program start"),
 	OPT_END()
 	};
 
-- 
2.25.1

