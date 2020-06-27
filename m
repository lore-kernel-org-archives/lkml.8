Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D192C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77AD92158C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5W+8UiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgF0Nit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgF0Nis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:38:48 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E98C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:48 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t6so6275165pgq.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NsLJGbXipZRby2dRrFjoiSEZL0RmxKph7eOLD/owQ6o=;
        b=M5W+8UiKUw2VGgK5sqy3qWAj+RfTLoVA0B05jfGbFgSaSl4iWjcr/qLiiKAk9WPuJM
         P0lPoiKbkJoFJr9n0qv3DfbudPC6I0KPGpthbgYaf8W+H5uR1POkdrQpcb8YNdz4h998
         vJdoYrsibj1FNCqu9zBhSrnPmltrAOHD63XGPmQPBbs2PrxSBeZFeUBJ2hsA01DB2hPK
         03GQ3zo8Frj18IQIhKtFjLhyFru6qbpUXmXLTTCo9KMxuTCUvX39hD4kaPD/Qrk7lFuZ
         2LyCqCCAdsKVGQZd2xbwu0nkOsy4w1JtllulZhh7rBIcJBb5Egqu9kX9gU7YZlYFL36i
         U4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NsLJGbXipZRby2dRrFjoiSEZL0RmxKph7eOLD/owQ6o=;
        b=Pk/cR2obffSIZzdJ8qiY8cCMCqbZFDVfnTHiOUBdvCJL9bxepjAMjVMYlCieOXe4tD
         i7JpT/0U4FzTZnQktxc6m/ll9kwQl4j6lcaYir4QwTlKc6L80/LxsMNsg5y3gwIzNRa0
         6RoiVUsQNqN36J1SriYBfdpWmaZci3uN0ElJxWNj3WmB3ayPut3QYydr5+tC1qaxevB4
         Et9mBmvCNCCDa19R5vlPi0K3T2mqq5A0amDXPRlDPQbiQ3Y7IYekiGG7l851CN5giUr2
         jEAGUqcQJvE14y/pRdrxSa54Vr1RqTTIXC17C1SGhuJuJRmbodxrS4RTZA1CIDVuuLcg
         UzAg==
X-Gm-Message-State: AOAM532P6bahzQSANkjguTsCjPMA5Qu5ND9/jAjDmgUG+yLCf4f2JDsr
        /Ay+n4fXhA8hDpCRrKC9lEg=
X-Google-Smtp-Source: ABdhPJwErGLDRGGqijolNYDfTlMkSIM5EbrUkH+Czd26T05YvR0gPrcuIdYyJmgByemz1VDacYbgvg==
X-Received: by 2002:a63:560f:: with SMTP id k15mr3250755pgb.162.1593265128032;
        Sat, 27 Jun 2020 06:38:48 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x8sm15060086pje.31.2020.06.27.06.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 06:38:47 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 14/15] perf ftrace: add support for trace option tracing_thresh
Date:   Sat, 27 Jun 2020 21:36:53 +0800
Message-Id: <20200627133654.64863-15-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627133654.64863-1-changbin.du@gmail.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '--graph-thresh' to setup trace duration threshold
for funcgraph tracer.

$ sudo ./perf ftrace -G --graph-thresh 100
 3) ! 184.060 us  |    } /* schedule */
 3) ! 185.600 us  |  } /* exit_to_usermode_loop */
 2) ! 225.989 us  |    } /* schedule_idle */
 2) # 4140.051 us |  } /* do_idle */

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt |  3 +++
 tools/perf/builtin-ftrace.c              | 25 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index cc770fc0a1e8..64843d0cdc45 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -116,6 +116,9 @@ OPTIONS
 --graph-verbose::
 	Show process names, PIDs, timestamps for function_graph tracer.
 
+--graph-thresh::
+	Setup trace duration threshold for funcgraph tracer.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-trace[1]
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index e037fe7abd47..0f8716ea0da4 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -46,6 +46,7 @@ struct perf_ftrace {
 	bool			graph_nosleep_time;
 	bool			graph_noirqs;
 	bool			graph_verbose;
+	unsigned		graph_thresh;
 };
 
 struct filter_entry {
@@ -229,6 +230,9 @@ static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
 	if (write_tracing_file("max_graph_depth", "0") < 0)
 		return -1;
 
+	if (write_tracing_file("tracing_thresh", "0") < 0)
+		return -1;
+
 	reset_tracing_filters();
 	reset_tracing_options(ftrace);
 	return 0;
@@ -440,6 +444,20 @@ static int set_tracing_funcgraph_verbose(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_thresh(struct perf_ftrace *ftrace)
+{
+	int ret;
+
+	if (ftrace->graph_thresh == 0)
+		return 0;
+
+	ret = write_tracing_file_int("tracing_thresh", ftrace->graph_thresh);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -539,6 +557,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_thresh(ftrace) < 0) {
+		pr_err("failed to set tracing thresh\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -726,6 +749,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "ignore functions that happen inside interrupt for function_graph tracer"),
 	OPT_BOOLEAN(0, "graph-verbose", &ftrace.graph_verbose,
 		    "show process names, PIDs, timestamps for function_graph tracer"),
+	OPT_UINTEGER(0, "graph-thresh", &ftrace.graph_thresh,
+		     "only show functions of which the duration is greater than <n>µs"),
 	OPT_END()
 	};
 
-- 
2.25.1

