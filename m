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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258CFC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2FE721655
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2G9JOCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgF0Ni3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgF0Ni2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:38:28 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7103C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:28 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a127so5882796pfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u0+OmxdHEjOGGxCcz+Jp0B57qPRpqHeg+mZqgwHq4SM=;
        b=i2G9JOCA3F6HTT+S4l1gWV2tZ3vjnUYaD2tZMepAiMr/6r3aBiX3niHh//adN2N5OU
         Z/x/q2Nw83MeaT54CVPql6zG9ijLviF/FqMrBxUpw94f9Aw2JtLhohoZxpcn9gyzcgIv
         nTss2aXWLXUaf9pOuIgTqZXu+Fp7GT0vsu15E3hrdeMoHG/HP/27zgVIUyAE+j3nEEu8
         ZoKHl9JY4/gc6CfJ+jOQaRGrRP8ySx4ng/BqNiXZ2kaZDY632/pwXopnJW0zVl2gZrHR
         c/Pzwxpne62mXEFhPVZeQwzueWFEhEteK/suiCtewgF5GIkJEL8fqNLtCUWyHkoHkdoF
         rgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u0+OmxdHEjOGGxCcz+Jp0B57qPRpqHeg+mZqgwHq4SM=;
        b=Pic7wVzw5L5U7TbSsFqzxoPufIeQ+0koLVQJJ9DZo+TYQMyBMFPgetG20/uSHPsdfw
         ar70YCpaTOS2mBlJtifi10Nt7CxuhNEUptrkkNnSCz4rZUiPvFb3CVCcbfJDlrP33wgm
         RF2mPhjltaX5+GQoBwBhEAAOTuZNo88U/KkASt7AoBQrXbj5ZhNFQnYPE7EPLFqftF+7
         dHwLq88V+wEpcaINOR9y/sTetotaAMIP4Uul9ZOJl4NkTWOnavqr0HfjfC0bv1BMuQm0
         +9rE1gmo6Rcgp8ngEALVE8BPzIU3Lm2QxGL44RE+8OKdE1QwuCyrpO+ZUKrh3pd3HGFf
         TN1g==
X-Gm-Message-State: AOAM533bjC9nsLmyrG2dAwWdKgZJ2VyC+6l3t4uRS+MgjXN/yX4fw6EW
        0SUwn1ZYSrAGm9N++mmMk1s=
X-Google-Smtp-Source: ABdhPJwvRoMfGls7Dsrh5vzzfQCgJtothBWl5DPCuThHmWLwlUZvrM5ga4yXmzrwK1uzz030z70TFw==
X-Received: by 2002:a63:7f5a:: with SMTP id p26mr3324544pgn.117.1593265108431;
        Sat, 27 Jun 2020 06:38:28 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x8sm15060086pje.31.2020.06.27.06.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 06:38:27 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 10/15] perf ftrace: add support for trace option sleep-time
Date:   Sat, 27 Jun 2020 21:36:49 +0800
Message-Id: <20200627133654.64863-11-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627133654.64863-1-changbin.du@gmail.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an option '--graph-nosleep-time' which allow us only to measure
on-CPU time. This option is function_graph tracer only.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2: option name '--nosleep-time' -> '--graph-nosleep-time'.
---
 tools/perf/Documentation/perf-ftrace.txt |  3 +++
 tools/perf/builtin-ftrace.c              | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 94cdb2ebdf34..a3000436f80b 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -104,6 +104,9 @@ OPTIONS
 --graph-depth=::
 	Set max depth for function graph tracer to follow
 
+--graph-nosleep-time::
+	Measure on-CPU time only for function_graph tracer.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-trace[1]
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index bbfa7973b4fa..eba125a60820 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -42,6 +42,7 @@ struct perf_ftrace {
 	unsigned		buffer_size_kb;
 	bool			inherit;
 	bool			func_stack_trace;
+	bool			graph_nosleep_time;
 };
 
 struct filter_entry {
@@ -200,6 +201,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 {
 	write_tracing_option_file("function-fork", "0");
 	write_tracing_option_file("func_stack_trace", "0");
+	write_tracing_option_file("sleep-time", "1");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -380,6 +382,17 @@ static int set_tracing_trace_inherit(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_sleep_time(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->graph_nosleep_time)
+		return 0;
+
+	if (write_tracing_option_file("sleep-time", "0") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -459,6 +472,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_sleep_time(ftrace) < 0) {
+		pr_err("failed to set tracing option sleep-time\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -638,6 +656,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     "size of per cpu buffer in kb"),
 	OPT_BOOLEAN(0, "inherit", &ftrace.inherit,
 		    "trace children processes"),
+	OPT_BOOLEAN(0, "graph-nosleep-time", &ftrace.graph_nosleep_time,
+		    "measure on-CPU time only for function_graph tracer"),
 	OPT_END()
 	};
 
-- 
2.25.1

