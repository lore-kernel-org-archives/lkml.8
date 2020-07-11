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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1946CC433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE599207FB
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzhcimjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgGKMnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgGKMnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:43:41 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88065C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:41 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j20so3765802pfe.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=li49iVWviGqS3VLMjcwZhSBcEz5HMh5QY3AlCy5JCOY=;
        b=pzhcimjS1d/khyFMWPIn6qbTYhgumcrLk0CZq2lEqmmKCyZ3ChQHfQq0nj7FRwRY3a
         GTpUsnX9+5/u9VFXeJ0Kqv9YQfjXtzf1xgNm1f1EvwgrJNmkYcdTKGyRNr6O7J+gGDaV
         74GFvxiK1Lp/ESqMYN4b7z2uRzR3uR1bYHu3WTP1YW93KTyjLZA148Pi50+MUh1y+Dea
         pCgIakzS7A4ei4/eNUCK6/KxqYS1OzZkXIteJp5qM2wO0HHxfI0mnNiem+ji0aN/ZHQW
         g6cnaPHvTzHtCuWnlODq2h8bNSU4b2FU8jN6V/qqxSmxH9BJ5sDEO6m/RXyhcH5sYr9/
         UK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=li49iVWviGqS3VLMjcwZhSBcEz5HMh5QY3AlCy5JCOY=;
        b=oe4yFhd1kQxOVO/jd4QN1LMyv/Y5XoVN0BixIKkMabMEh7/z3N2PLlR3TiEIR1w4KB
         ECZHWfGinv44BBttllk212L3km426LNOHrM5cwegmDB8JbeUb+Ih/havgzbZj0jzHFTb
         YtbBg99XRjde8q8DjRGO95DKgo53Mther+BSOUKOJjzT5rLLhBInb1ZBWqJpL7mIKEYh
         Fml1dJKZPgLRwyFsuTgncJQ0x53XpbOYwTa27rhXNI27QPrHA54XT0COWUvgO5/v0Jq/
         cfsaggGEpuNpZ2d9Jnedu02UA4rFvxDPC3sVUbNXTb7v1tso+p+RA5Ctv0RA0lwAhy4B
         6MTg==
X-Gm-Message-State: AOAM53079dIUbS57Sp/zPqZUxtY5CoaT/LjRvy4B1mJ06f5bt1wKQ8sF
        /Ju1sQqRuZ7ATEJ7WNGV66bxv5wV
X-Google-Smtp-Source: ABdhPJwdu8jbywt76OfavFP3gWNVu9LwwIkDAOAV8/1DNdtRPZRL6e7135iv4EdjUi2C+PPrbKBRTA==
X-Received: by 2002:a63:3005:: with SMTP id w5mr61075567pgw.441.1594471421132;
        Sat, 11 Jul 2020 05:43:41 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c19sm8352899pjs.11.2020.07.11.05.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:43:40 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 15/17] perf: ftrace: allow set graph depth by '--graph-opts'
Date:   Sat, 11 Jul 2020 20:40:33 +0800
Message-Id: <20200711124035.6513-16-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200711124035.6513-1-changbin.du@gmail.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
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
index a103e3fd8d42..97d89478ff5f 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -99,16 +99,13 @@ OPTIONS
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
index c6d0194e4d0e..86fc5d466e97 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -747,6 +747,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
 		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
+		{ .name = "depth",		.value_ptr = &ftrace->graph_depth },
 		{ .name = NULL, }
 	};
 
@@ -800,10 +801,8 @@ int cmd_ftrace(int argc, const char **argv)
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

