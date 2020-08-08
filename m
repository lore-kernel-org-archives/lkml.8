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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82935C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4681A221E5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwy0z6or"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHHCj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHCjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:39:53 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8055AC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:39:53 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b79so3499756qkg.9
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kW4G0zGaMrzoXRdoWpPfrvRSRKYz4wc1F/qThm1mflM=;
        b=iwy0z6orqAwmkflEtMsZRO521q9Q+ADX2T46VZ1FUO394n5whOvK+psDbcTSH4nPuw
         nWJbv/cJo8Eyz8W+g/v42h63HdIQuQbwDnbJR/fYypZbhualndH5tdCGBvB2cNlxR/uT
         b4ckdNzSU1zIZAbnyzx+zH7yJ3nOwTtuKmHZd0uSX6MhB+GEwn8xLdMWDpcEjHO9Ssga
         o/nUvCqLypxR+Ioh6DILL9g4HIj20Fd9u+sQAKqU7xUhiLRzLPZBzXePS1cvbRgcITWC
         uTL5qKFBmwC/wvqkOT2gzP6kA7HIJgaZ4S29n3T7O8zt4jWaTdCMJJhrY9IJlDRyXouT
         0cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kW4G0zGaMrzoXRdoWpPfrvRSRKYz4wc1F/qThm1mflM=;
        b=TSg2A/B/y4EqRQ5rxegmadCZakWkvCNlf9Jq/6YnmPdsvQo9G5pcqopTdOJunYmtJY
         5Yh9hBOAy4ekdnP5qSU1NGsBNV3qIQrQnfPGgtynHXGgKP5C8oSj5g9xlUilkFqWKHMh
         uQ6bnD79WwaELohCFcRKKWhT03YvAXDdrVeVcvzA2NkmsDJ4SW3nUv/gXIEP3REx4ejt
         m1AFnKprn/Sw05WbdgkvpOfj4NZ5CXO4jYvOGSu+6zdZrfbwgzhvt/ectTHYRqqKvAo1
         u1DaRVKDq+ZN72oTvmUO0luZsg9Q/VQHdQafJVg7YZNgc7ukqgMb6gKVEijxv8/f6PaT
         k5JQ==
X-Gm-Message-State: AOAM531yX24koPm/A5ccKh0E6M6pe4wwEwjNsJWW0j4vglV0VXZD29AE
        yjRm+Mw1hEVFt8XDVSDS4DE=
X-Google-Smtp-Source: ABdhPJzG0x1RiVb5zH11Z3QZRZE0UEgf4FspyZBysYqnIAuRqppYpIb8fU/B1BajCKg0P6Z3bPOzEw==
X-Received: by 2002:a37:9c58:: with SMTP id f85mr15492512qke.345.1596854392791;
        Fri, 07 Aug 2020 19:39:52 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:39:52 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 14/18] perf: ftrace: allow set graph depth by '--graph-opts'
Date:   Sat,  8 Aug 2020 10:31:37 +0800
Message-Id: <20200808023141.14227-15-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
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
index 6fa927e5971b..08216634d2bc 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -98,16 +98,13 @@ OPTIONS
 	specify multiple functions. It will be passed to 'set_graph_notrace'
 	in tracefs.
 
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
index ca61f8b8bbf6..bc3b35d18167 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -751,6 +751,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "noirqs",		.value_ptr = &ftrace->graph_noirqs },
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
 		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
+		{ .name = "depth",		.value_ptr = &ftrace->graph_depth },
 		{ .name = NULL, }
 	};
 
@@ -819,10 +820,8 @@ int cmd_ftrace(int argc, const char **argv)
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

