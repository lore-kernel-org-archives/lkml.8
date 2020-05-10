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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F4FC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F267208CA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJBHmSbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbgEJPKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgEJPKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:10:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAFAC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:10:35 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so2811308plo.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UwWrCXO3EiMCCi/VR56OQtOH8VL67AQVe2Td23eGNBo=;
        b=XJBHmSbmFs4/mmJZsFtukL3kXcrxNpRmnKfwTujxxb8wey3PABRkXjNovoopXXO15u
         //e2mT7jWi5e2rJh2ZUOKhrwYPjTUnE5mDStAqgUaMGOzKQ+49N1lUNFVZP2zkIDjdxH
         JUGGzGN2stZbpteYGlh5cTGHxOitMQbML3yHcUHlJTgBdFoQvYm/Uy5lryDViYqKlgiM
         RQjc472sd5n89XH6n4Ps7SA2PXvfy/U5pwFgT3QtUj2CHX0aloHLzPF8R/62Q8p74Lak
         R3a0NzlchvFHtE5EOo6tM8ScMOevbIHJ6p9YsGF6oJzlfpQGYTq+bOa++EF0praSyDym
         5e2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UwWrCXO3EiMCCi/VR56OQtOH8VL67AQVe2Td23eGNBo=;
        b=KVdhEnZGRpJSCu7f2Nfr2OZ9950HUudelgCBxlHeua1m91UNVjFiZyMxpo9+CdfTMB
         +1wvqJyLLCXyG4h+zpluXw3LNwHDu8xSzcFR3sOzUl2p3knou+U99MDvN/mx6GlHBps5
         5bYdmiuunrDzaYdXZLEOs80wjHWArpTdFONGtasHmEMtlixcosq3LbWIB7T7EuZhzufU
         T9kvuYv2v62xmyTbROvBOmhn4lgCTXAsJPdGU19+3ebbIMsRuDPHgjw/L+LCOt6LR/OB
         643I9zOiU6hTCWSBcgOF0CJNfEOVuQH8W+5EekL5Db4tA1xxi2QOr4LojSYLL1OC3BfY
         +dCw==
X-Gm-Message-State: AGi0PuZRMj8oPZt59DTs7OsZhbWz1rIesHwbUdQbvkDqu+4cyByt8SjZ
        JJTF91HGw256K89Tz0u1nYgJjUNDjGY=
X-Google-Smtp-Source: APiQypJeAHZ1fUexZr4VTzdBZ6eMQm78ghNqz0DshJFEqxmXyV4QxZIc14/yUzeecEDKlw0KO4zRxw==
X-Received: by 2002:a17:902:207:: with SMTP id 7mr10881495plc.331.1589123434717;
        Sun, 10 May 2020 08:10:34 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:10:34 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 18/19] perf ftrace: add option --latency-format to display more info about delay
Date:   Sun, 10 May 2020 23:06:27 +0800
Message-Id: <20200510150628.16610-19-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is for the function graph tracer to display more info about latency.
The execution context is shown in this case.

$ sudo perf ftrace -G --latency-format
\# tracer: function_graph
\#
 1)  .... |   0.992 us    |  mutex_unlock();
 1)  .... |   1.404 us    |  __fsnotify_parent();
 1)  .... |   1.023 us    |  fsnotify();
 1)  .... |   0.335 us    |  __sb_end_write();
 1)  d... |   0.439 us    |  fpregs_assert_state_consistent();
 1)  d... |               |  do_syscall_64() {
 1)  .... |               |    __x64_sys_close() {

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index d376b37c53fc..fd8e2f305136 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -44,6 +44,7 @@ struct perf_ftrace {
 	bool			nosleep_time;
 	bool			nofuncgraph_irqs;
 	bool			funcgraph_tail;
+	bool			latency_format;
 	bool			long_info;
 	unsigned		tracing_thresh;
 	bool			trace_children;
@@ -217,6 +218,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("sleep-time", "1");
 	write_tracing_option_file("funcgraph-irqs", "1");
 	write_tracing_option_file("funcgraph-tail", "0");
+	write_tracing_option_file("latency-format", "0");
 	write_tracing_option_file("funcgraph-proc", "0");
 	write_tracing_option_file("funcgraph-abstime", "0");
 	write_tracing_option_file("irq-info", "0");
@@ -456,6 +458,17 @@ static int set_tracing_funcgraph_tail(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_latency_format(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->latency_format)
+		return 0;
+
+	if (write_tracing_option_file("latency-format", "1") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int set_tracing_trace_children(struct perf_ftrace *ftrace)
 {
 	if (!ftrace->trace_children)
@@ -579,6 +592,11 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		goto out_reset;
 	}
 
+	if (set_tracing_latency_format(ftrace) < 0) {
+		pr_err("failed to set tracing option latency-format\n");
+		goto out_reset;
+	}
+
 	if (set_tracing_trace_children(ftrace) < 0) {
 		pr_err("failed to set tracing option function-fork\n");
 		goto out_reset;
@@ -748,6 +766,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Ignore functions that happen inside interrupt (function_graph only)"),
 	OPT_BOOLEAN(0, "funcgraph-tail", &ftrace.funcgraph_tail,
 		    "Show function tails comment (function_graph only)"),
+	OPT_BOOLEAN(0, "latency-format", &ftrace.latency_format,
+		    "displays additional information about the latency (function_graph only)"),
 	OPT_BOOLEAN('l', "long-info", &ftrace.long_info,
 		    "Show process names, PIDs, timestamps, irq-info if available"),
 	OPT_UINTEGER(0, "tracing-thresh", &ftrace.tracing_thresh,
-- 
2.25.1

