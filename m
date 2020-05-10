Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9A3C54E4B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A4982082E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNZBqkM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgEJPIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgEJPI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:08:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C5DC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:08:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k19so2809199pll.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R71wv0tzjUnDdB850oLrpvurQ3EzqnCxkzexdSHqy5Y=;
        b=kNZBqkM3tnsd4pcITGtJn6/fHNoJl01xCbpxO1vvIyBYxEeAg5UkzmT1OjT/eITnwz
         7ifJKVNXhjCwzYhFPDz0oEGqgbjFUBiv87Khm8G9SZ6O5jYBPanw9RXFJCJCtRSAu/Cu
         Htv+akSQa8ggBedcA57rR797Z+aabJA5ESBj07PXivvDeAZEn7Ty9w0hmKhRrJ2Uaf//
         8WZp5kcWlwAwohHdrSbNWM37u/lVsHb+icwVOwL8D7UPvAP0eKMgbGuj0uysb/862LhB
         itndB8f7QdOQrWkLAXU7eh5qBiIVOsNhXL8HlBKIZ7IXER9pULLSr8jyv/dumazK1o/n
         wYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R71wv0tzjUnDdB850oLrpvurQ3EzqnCxkzexdSHqy5Y=;
        b=q6hwO43V5/CGWIr4CRawlfJnAptusmKbLcqxm2CuUo7RTc7BeZE7k4AcD3LAhm5J2k
         otaQejtMy9dWK4CJ4W5sZEZmX+dTw3S4K3uM8H79v9DL2MD03NYYUgoM/aP+HF8gVr/s
         QHZI0e6uCF3CeFd90Zq15O3XFcatXplRz+U8bdyi+kvOdthtCXs17PnP1gsxDFjD6i0F
         CyrdIKaLv4nxq7ee1hc0HmvBXwdlT+TygzfIMFPxemNlQ3XHQ+kE5AdOAUZaq/SB9KY1
         I8uvn7p7y691m47YjSfV7NQeHxq3F3sNYaWaC46GWWgJPvxxj3jYI6W7kcEQESpAl0AA
         ynEQ==
X-Gm-Message-State: AGi0PuYy++y7rYhDDCO7QFkAu9hzUuQF536LgVCplkPjuPYFv/ZyjDbv
        n2R/agpyCsz+gGfKLfdrLrM=
X-Google-Smtp-Source: APiQypJv2zjE6DEf9rOL6lI51CNafH7K8g4g+qowxdm4UbpLZHmNDbkMwRtIq0In60HAwDjtAXq6JQ==
X-Received: by 2002:a17:90b:70f:: with SMTP id s15mr16954860pjz.33.1589123309275;
        Sun, 10 May 2020 08:08:29 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:08:28 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 08/19] perf ftrace: add option -l/--long-info to show more info
Date:   Sun, 10 May 2020 23:06:17 +0800
Message-Id: <20200510150628.16610-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes we want ftrace display more and longer information about trace.

$ sudo perf ftrace -G -l
 6800.190937 |   4)   <...>-7683   |   2.072 us    |  mutex_unlock();
 6800.190941 |   4)   <...>-7683   |   2.171 us    |  __fsnotify_parent();
 6800.190943 |   4)   <...>-7683   |   1.497 us    |  fsnotify();
 6800.190944 |   4)   <...>-7683   |   0.775 us    |  __sb_end_write();
 6800.190945 |   4)   <...>-7683   |   0.854 us    |  fpregs_assert_state_consistent();
 6800.190947 |   4)   <...>-7683   |               |  do_syscall_64() {
 6800.190948 |   4)   <...>-7683   |               |    __x64_sys_close() {
 6800.190948 |   4)   <...>-7683   |               |      __close_fd() {
 6800.190948 |   4)   <...>-7683   |   0.322 us    |        _raw_spin_lock();
 6800.190949 |   4)   <...>-7683   |               |        filp_close() {
 6800.190949 |   4)   <...>-7683   |   0.320 us    |          dnotify_flush();
 6800.190950 |   4)   <...>-7683   |   0.325 us    |          locks_remove_posix();

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index b16600a16efa..f11f2d3431b0 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -42,6 +42,7 @@ struct perf_ftrace {
 	bool			func_stack_trace;
 	bool			nosleep_time;
 	bool			nofuncgraph_irqs;
+	bool			long_info;
 };
 
 struct filter_entry {
@@ -190,6 +191,9 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("func_stack_trace", "0");
 	write_tracing_option_file("sleep-time", "1");
 	write_tracing_option_file("funcgraph-irqs", "1");
+	write_tracing_option_file("funcgraph-proc", "0");
+	write_tracing_option_file("funcgraph-abstime", "0");
+	write_tracing_option_file("irq-info", "0");
 }
 
 static int reset_tracing_files(struct perf_ftrace *ftrace __maybe_unused)
@@ -371,6 +375,23 @@ static int set_tracing_funcgraph_irqs(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_long_info(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->long_info)
+		return 0;
+
+	if (write_tracing_option_file("funcgraph-proc", "1") < 0)
+		return -1;
+
+	if (write_tracing_option_file("funcgraph-abstime", "1") < 0)
+		return -1;
+
+	if (write_tracing_option_file("irq-info", "1") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 {
 	char *trace_file;
@@ -449,6 +470,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_long_info(ftrace) < 0) {
+		pr_err("failed to set tracing option funcgraph-proc/funcgraph-abstime/irq-info\n");
+		goto out_reset;
+	}
+
 	if (write_tracing_file("current_tracer", ftrace->tracer) < 0) {
 		pr_err("failed to set current_tracer to %s\n", ftrace->tracer);
 		goto out_reset;
@@ -588,6 +614,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Measure on-CPU time only (function_graph only)"),
 	OPT_BOOLEAN(0, "nofuncgraph-irqs", &ftrace.nofuncgraph_irqs,
 		    "Ignore functions that happen inside interrupt (function_graph only)"),
+	OPT_BOOLEAN('l', "long-info", &ftrace.long_info,
+		    "Show process names, PIDs, timestamps, irq-info if available"),
 	OPT_END()
 	};
 
-- 
2.25.1

