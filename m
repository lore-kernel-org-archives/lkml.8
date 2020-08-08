Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41D5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D3DC22D00
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAtBAnCZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgHHCj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHCj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:39:58 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9A3C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:39:58 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k18so2772507qtm.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFO8kF7KY0H8YMabulg7L5DF0WB2til4KAilIupZocM=;
        b=XAtBAnCZz+k9lwxvUKdC/qPRqBCfvilxOgMoRvIYpcpSkldLNj6D1thSX6wNCS8IWW
         JwYnuN9DBTw9PZ2FIYfb/eD7uMiXTXGY2STWhNAchrqbxt0LM//IWisjR+iJJiAmPd9R
         A58k+SUhpeEfTxG1IYejTaTIsF/tSQ0RjAChiACsx7cQgN/gbTNuckGrB+IeIjBN4LLm
         GO9B6wXNzlrofJDy4zmn65ftIwiSxdCQOIdRrg5xdM1QP1HdWzksR2Z7OOxoLbOrpxuw
         9UMW0CpqLXHfd1FUK3yTBVVPs9UGv6el7WBiKklDiFltfqe7PNZ1Y04IDAfGzFYdjEjG
         PLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFO8kF7KY0H8YMabulg7L5DF0WB2til4KAilIupZocM=;
        b=aHOmDwKd5AWsSP60kAqlg3eDtM7LvNc1qBXkRw+qWiwgVPBB0kfWoWuHN7vp2nnytv
         ZHxR4dlfoNBu+uQHHD33H3Wn6fIT1akD0tDWp2PYxbSGyVCvjIO1BZxWS8rBTxY4QliS
         esTJZPWXL32jkcxC3yfJwRl9Tjg4Ahdm8TANhn7kIB7X3XcmOuVqGvc3oFzSmahZSKoT
         P0R+AU9fZiityvklIpu0A8AcD2OX1ya7/OdO1FxrYqm9kg+OkIPZwEAOPSxKCNAZJX41
         PEFFoFzA99fxYY7OP2amGwl2jvHZY4N0S5e9eII7RG5fDiLZSwq10pN4kxs1gquS2hU6
         Tb3Q==
X-Gm-Message-State: AOAM530J/II+hRTZtEtKp7Rd3vnFUUbtB8o/Qp6a86LZfqAhcV1voVG7
        swK3MRnFxv8fhTv82fHFZZk=
X-Google-Smtp-Source: ABdhPJxDIV1ufowRxQfl9AQiCYzev0wZHeq+2nrMal9w2RSeeTrZJ2ykvoWBzA1F8s3LTBQMBOgKiA==
X-Received: by 2002:ac8:6e9b:: with SMTP id c27mr17065262qtv.189.1596854397860;
        Fri, 07 Aug 2020 19:39:57 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:39:57 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 15/18] perf ftrace: add option -D/--delay to delay tracing
Date:   Sat,  8 Aug 2020 10:31:38 +0800
Message-Id: <20200808023141.14227-16-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
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
index 08216634d2bc..29c684b3b3fd 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -39,6 +39,10 @@ OPTIONS
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
index bc3b35d18167..5f9a9ebea0a2 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -49,6 +49,7 @@ struct perf_ftrace {
 	int			graph_noirqs;
 	int			graph_verbose;
 	int			graph_thresh;
+	unsigned int		initial_delay;
 };
 
 struct filter_entry {
@@ -596,13 +597,23 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
@@ -827,6 +838,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "size of per cpu buffer", parse_buffer_size),
 	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
 		    "trace children processes"),
+	OPT_UINTEGER('D', "delay", &ftrace.initial_delay,
+		     "ms to wait before starting tracing after program start"),
 	OPT_END()
 	};
 
-- 
2.25.1

