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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A6DC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D1A2065E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7dqtIv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgGRGun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgGRGum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:50:42 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619BFC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:50:42 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so6351370plk.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cSLHeLlHnsqkzyv/gBgjnRP/gYQK1GlVe1v627QurAU=;
        b=G7dqtIv2Cd57gGa+ocMkla7D7MvKXCuphdnk+pWcrPATC06Dpi5Vjk2O6VbGFTZXCo
         Md8Kb5e0oBCI5gfylCl5eUe3OQOjHZrxpJ1fF1N4MCs8CaWoprITXwDOvbxoNAQZiCNQ
         mUQGz83Wvtz5CLK0F/82Iq8Q8l/qaeUsjAexF8FeV7OXK9XlDrQircHgkNSj7JM/9tXN
         AHtHEEULoI7HVHkES/C/z7XJYt8xYvNKGQ+Gihkhgzl0jAR1PfWlbKgki9z8lSJy1Prh
         UjA+6oUlhW8d4ao8rrBABvVj5D9S1MQD0gMv0Qb8cEjxc9TBXYGhMIkQt8Vm2Wlplt/Y
         JRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cSLHeLlHnsqkzyv/gBgjnRP/gYQK1GlVe1v627QurAU=;
        b=t4l0A2hycOnhhRxxdvVAYVdtaW1o0h9C7FhL9R/a2yspE9wbhaz84SHyh2HZSSKohR
         R+UVPcata4GbSH+y6r1QxzWZaaDyl68WrQHI3Cb4k2a+49XlsIx+FPzndliFclPrSgUz
         aWX1vp/SuXeGdVDK52kI6FRiLfg6L6clt5AwxNg9Wt+oH64Sl2SCBi/UjUWXHkYKhFQ0
         SyaFoi2ikdEzBXxz2ofQ7SK7LYHIDq7axDDeQTj2gEKnJTIWDQA4vMhaQD686slXBlhI
         1Q58Uiri3myvvByoywBoQUNW+WjPwKxgtJi/qyAKDO3q9yqPpTjFOjHcaBho9+rA3gVH
         hrOg==
X-Gm-Message-State: AOAM533hqiuTYWNX7MOeiEoOZBuiBRdvf8yjcNA8MFKR0OXG7XDrP+6f
        8h997Q7KVsdbRMn8Z+txezM=
X-Google-Smtp-Source: ABdhPJzUgA1MaWJLiqcky3hGCoxxPnVQV5vuhWO0FkS2Xa5Z8FPv8TU+lTw2FEyPF97/uaifaj5yZA==
X-Received: by 2002:a17:90a:2b0f:: with SMTP id x15mr8330485pjc.230.1595055041937;
        Fri, 17 Jul 2020 23:50:41 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:50:41 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 14/18] perf: ftrace: allow set graph depth by '--graph-opts'
Date:   Sat, 18 Jul 2020 14:48:22 +0800
Message-Id: <20200718064826.9865-15-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to have a consistent view of all graph tracer options.
The original option '--graph-depth' is marked as deprecated.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt | 5 +----
 tools/perf/builtin-ftrace.c              | 5 ++---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 96e5e8d7f65c..6f17939b8789 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -95,16 +95,13 @@ OPTIONS
 	This can be used more than once to specify multiple functions.
 	It will be passed to 'set_graph_notrace' in tracefs.
 
--D::
---graph-depth=::
-	Set max depth for function graph tracer to follow
-
 --graph-opts::
 	List of options allowed to set:
 	  nosleep-time - Measure on-CPU time only for function_graph tracer.
 	  noirqs       - Ignore functions that happen inside interrupt.
 	  verbose      - Show process names, PIDs, timestamps, etc.
 	  thresh=<n>   - Setup trace duration threshold in microseconds.
+	  depth=<n>    - Set max depth for function graph tracer to follow.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 5d948239bd70..3ddd7568b456 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -750,6 +750,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
 		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
+		{ .name = "depth",		.value_ptr = &ftrace->graph_depth },
 		{ .name = NULL, }
 	};
 
@@ -801,10 +802,8 @@ int cmd_ftrace(int argc, const char **argv)
 		     parse_filter_func),
 	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
 		     "Set nograph filter on given functions", parse_filter_func),
-	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
-		    "Max depth for function graph tracer"),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>",
+		     "graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
 		     parse_graph_tracer_opts),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "size of per cpu buffer", parse_buffer_size),
-- 
2.25.1

