Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA70C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D6820820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2ufl/fF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgEJPJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgEJPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:09:44 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420F3C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:09:44 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v63so3493681pfb.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QP7r6jCu/3Y2anj//gYieTEq5giPkfGcSxKsR1cc0OE=;
        b=k2ufl/fF6Cs8HAbTBtiNniwCZNrWvrplxIzLxFf5mLGJlbE/8sHN5N7mLT8jz9yeMD
         lWwlkEBYnz5IyZHQCuvBogfTuj7kRtda+TFHSAKHMTnYjs8Z6BoVDE38aWrAhkSobTrB
         tSkWLxt/ubvMU4fc5IFgMx36F11KHS9Z2YmmR/qAaXkJd8ok4fcqiRphyrs2QyKgc9bU
         NFsdMH3eVsAyLRq2QbChy9bclKVrU0WzW9m9VGDzv1E1HWgWBeF3dhsWQxQL2zer1bDf
         lh/9VqIBYwX9JhOrAczove41WDFQptTeut5uyDTUL+r9blocURlT6WG93Oreco8VIY87
         HfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QP7r6jCu/3Y2anj//gYieTEq5giPkfGcSxKsR1cc0OE=;
        b=b6OvzODoUkXk7QOwCbxfg9bTPJkHEDq8xGf5YH5KeHhj27EtRNcnVxcuhNt1u3gp70
         7Es6xcvzUsjGThx+/o/a9/AdPJLdOE2dgyCOY47o6tSZm0kwDn+rbqJeVcWK4Gcv8+Re
         uTsYldt1oQzmtaWJaloIuFQv4mWIPpMdEhGGrzgdWpR81BRUAaGO22YOVE48PZ7LzWxm
         SCHx3B69NW6PaiJzPOZXdmLhba/svGJmGE6Wx2ZafE0HO4AeLikQY/09+YafTJIDTZ02
         Ns5e5nyJDLKkAXNgj2m9I8DIoQ8UdtKg3kaniaG0S/lAikCerzdCRcKKZ+JLcdNsEYAM
         uZFw==
X-Gm-Message-State: AGi0PuYhzYh4hs0S4E/A571KAGwzeW57mlGhzFB4tbSyrAfrsvOcNFwb
        bhPVxPphAKRunnxBDK6Ne0Q=
X-Google-Smtp-Source: APiQypL/Hzxra/wqIJpDTvm69VUjrjRzJziMO2c2Zx84iZP3Q9OONKi+L5pY4JJ//6HQT7jyQ7nPGA==
X-Received: by 2002:a62:35c1:: with SMTP id c184mr11478109pfa.120.1589123383843;
        Sun, 10 May 2020 08:09:43 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:09:43 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 13/19] perf ftrace: add option '-b/--buffer-size' to set per-cpu buffer size
Date:   Sun, 10 May 2020 23:06:22 +0800
Message-Id: <20200510150628.16610-14-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '-b/--buffer-size' to allow us set the size of per-cpu
tracing buffer.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 45 ++++++++++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 8fd95c109fe8..a93fbdac6aa4 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -47,6 +47,7 @@ struct perf_ftrace {
 	bool			long_info;
 	unsigned		tracing_thresh;
 	bool			trace_children;
+	unsigned		buffer_size_kb;
 };
 
 struct filter_entry {
@@ -187,6 +188,17 @@ static int read_tracing_file_to_stdout(const char *name)
 	return ret;
 }
 
+static int write_tracing_file_int(const char *name, int value)
+{
+	char buf[16];
+
+	snprintf(buf, sizeof(buf), "%d", value);
+	if (write_tracing_file(name, buf) < 0)
+		return -1;
+
+	return 0;
+}
+
 static int reset_tracing_cpu(void);
 static void reset_tracing_filters(void);
 
@@ -360,8 +372,6 @@ static void reset_tracing_filters(void)
 
 static int set_tracing_depth(struct perf_ftrace *ftrace)
 {
-	char buf[16];
-
 	if (ftrace->graph_depth == 0)
 		return 0;
 
@@ -370,9 +380,7 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
 		return -1;
 	}
 
-	snprintf(buf, sizeof(buf), "%d", ftrace->graph_depth);
-
-	if (write_tracing_file("max_graph_depth", buf) < 0)
+	if (write_tracing_file_int("max_graph_depth", ftrace->graph_depth) < 0)
 		return -1;
 
 	return 0;
@@ -419,14 +427,10 @@ static int set_tracing_long_info(struct perf_ftrace *ftrace)
 
 static int set_tracing_thresh(struct perf_ftrace *ftrace)
 {
-	char buf[16];
-
 	if (ftrace->tracing_thresh == 0)
 		return 0;
 
-	snprintf(buf, sizeof(buf), "%d", ftrace->tracing_thresh);
-
-	if (write_tracing_file("tracing_thresh", buf) < 0)
+	if (write_tracing_file_int("tracing_thresh", ftrace->tracing_thresh) < 0)
 		return -1;
 
 	return 0;
@@ -454,6 +458,20 @@ static int set_tracing_trace_children(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_buffer_size_kb(struct perf_ftrace *ftrace)
+{
+	int ret;
+
+	if (ftrace->buffer_size_kb == 0)
+		return 0;
+
+	ret = write_tracing_file_int("buffer_size_kb", ftrace->buffer_size_kb);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -557,6 +575,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_buffer_size_kb(ftrace) < 0) {
+		pr_err("failed to set tracing per-cpu buffer size\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -706,6 +729,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "Only show functions of which the duration is greater than <n>µs"),
 	OPT_BOOLEAN(0, "trace-children", &ftrace.trace_children,
 		    "Trace children processes"),
+	OPT_UINTEGER('b', "buffer-size", &ftrace.buffer_size_kb,
+		     "size of per cpu buffer in kb"),
 	OPT_END()
 	};
 
-- 
2.25.1

