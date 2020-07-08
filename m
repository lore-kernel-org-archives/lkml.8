Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40A8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE485206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uSbZAATW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgGHQsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730915AbgGHQsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:48:36 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30F0C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:48:36 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t15so1430560pjq.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3HQGnYb9pZsxftO4JJWykAsPx8KEJzL34JEyAYFl3vA=;
        b=uSbZAATWMJ99oFvIx4aAjx5Pb4t7eZ//9WLMxAGpuWC1RGkOYktyuEk40sroUv9LpS
         MM6m1esZV1okFL7U/ICYCxDSQlxTUHaa9L4YsmcjHhV3Yr4PnxDWr/H7CTW+WkjmAA3S
         nDcgCDJNylEntdacV+E2dZGJN+n9DpEO+KcQwkTpiHV1fvzbCbGwg3Q+ZCf8eqHa1YCb
         BlgRQeHVKo7mwMJsKnLcee7nG4l/aQIGPAX0SqsF6R41N0awUkpMUSFZAGkGvDTDdLUy
         yF9n6v2DO7FcUHslGUV+DqLzT9HT/YM7uGxaItMZhKDt8lsj1Wderh7YU7UN1Z675vrs
         A+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3HQGnYb9pZsxftO4JJWykAsPx8KEJzL34JEyAYFl3vA=;
        b=R5G6HAgaD+LxhAGPt1lu7Tny468QioJA9tAmz7ld32Kgn+FrLRxlzLc+DuTrLNf5Tn
         P+82mjxRIKkEi/wubVECbEKeOIYvCNSH6iACtaMotYp/y/oe1+4uBiMgTCR46Qs0icpF
         nJd5/sHhTbuocjyyhY+F9YGAF/ER5iTiQg97QJVCPpyOAWNOlBFTPphigpog/yRb2Uls
         6uQgcOJXL5NpSevv9Ca5tX/im5ZnoguqlWKUkqeeJp6nKARjV3ipQ38y7j4r8WiBKAws
         ArMCdJ7u+3cL2oWettY4tDXNMufiJEsVED59uR46/iZiYv28hD4/sKZAQ4lltrfc93wm
         UAWg==
X-Gm-Message-State: AOAM530MViwE9mo8DhtLo/MrAoVkHPFOTnr9w/PLFXJWtTBGhpxcTXlX
        MGsTMXqiojMu++a95FPGluY=
X-Google-Smtp-Source: ABdhPJyA+VpjlbwhTsCxrL676JohpCKE5MpOitLjeXQ7QVrybQ2SvGlF1DO8dXXL1LQxFpp1BJO9zQ==
X-Received: by 2002:a17:90b:3685:: with SMTP id mj5mr10479843pjb.123.1594226916299;
        Wed, 08 Jul 2020 09:48:36 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r8sm310803pfg.147.2020.07.08.09.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:48:35 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 16/17] perf: ftrace: allow set graph depth by '--graph-opts'
Date:   Thu,  9 Jul 2020 00:46:04 +0800
Message-Id: <20200708164605.31245-17-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708164605.31245-1-changbin.du@gmail.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
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
 tools/perf/Documentation/perf-ftrace.txt | 4 +++-
 tools/perf/builtin-ftrace.c              | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index bcb1504892ef..fa99ec1ef58a 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -105,7 +105,8 @@ OPTIONS
 
 -D::
 --graph-depth=::
-	Set max depth for function graph tracer to follow
+	Set max depth for function graph tracer to follow. This option is
+	deprecated, use '--graph-opts depth=<n>' instead.
 
 --graph-opts::
 	List of options allowed to set:
@@ -113,6 +114,7 @@ OPTIONS
 	  noirqs       - Ignore functions that happen inside interrupt.
 	  verbose      - Show process names, PIDs, timestamps, etc.
 	  thresh=<n>   - Setup trace duration threshold in microseconds.
+	  depth=<n>    - Set max depth for function graph tracer to follow.
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 21d6d6791dc3..a20187b1556a 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -758,6 +758,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
 		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
+		{ .name = "depth",		.value_ptr = &ftrace->graph_depth },
 		{ .name = NULL, }
 	};
 
@@ -812,9 +813,9 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_CALLBACK('g', "nograph-funcs", &ftrace.nograph_funcs, "func",
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_INTEGER('D', "graph-depth", &ftrace.graph_depth,
-		    "Max depth for function graph tracer"),
+		    "Max depth for function graph tracer (This option is deprecated)"),
 	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
-		     "graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>",
+		     "graph tracer options, available options: nosleep-time,noirqs,verbose,thresh=<n>,depth=<n>",
 		     parse_graph_tracer_opts),
 	OPT_UINTEGER('d', "delay", &ftrace.initial_delay,
 		     "ms to wait before starting tracing after program start"),
-- 
2.25.1

