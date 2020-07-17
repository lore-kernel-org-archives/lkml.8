Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE9AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A980520734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ozKK8t4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgGQOig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgGQOif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:38:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC53DC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:38:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mn17so6617029pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cSLHeLlHnsqkzyv/gBgjnRP/gYQK1GlVe1v627QurAU=;
        b=ozKK8t4UV+Lc+qIxjiIhK9Lvsh6e6BreYiP2orBO9Xe+amJtoRQjhBNV8Mn8IMc42C
         9XW10iP3BLLcp7twntyfrQfW9LAq4m4TSk2biWhP9IiXFWMoR0t25fSk4/N82rx48KjL
         kakXKs62E9z+xFTp3xi81dUtwKXh8zShXUkjr9fd1kuhiqogG7kd0MIMsTV2hCu5DaaJ
         dwXb+mVMhL9cMOzAQ9NWiRDXuyzyB7Xeq1MPkT414ISKpW8cg+nPJI3yuam/5mxMuVZ0
         ma4ZLlKKS4IRpGs7grTRbBw2n9Dh7G+Fh4c/nTis79nmBm4+xERRjxesDrY45iG64uvy
         FvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cSLHeLlHnsqkzyv/gBgjnRP/gYQK1GlVe1v627QurAU=;
        b=TCWJ3bne4v5ssSAhJlLlKXkenuQrZGGhZL2CO3+Sug3hLFf3PXBCCc0Q/fasI67epQ
         7k4Oy6ptJ3hLC8sLLciIEU3bztc5D47PQAt9wPBmlhHW523DQECiz6rbdyKLcY/mf2VN
         LEPpZavcNFAoMRvg9PYhJ8/s9Aw9sMgfaI+SZjO4LQ8VT9HtYw4upeNl5XdiSlJRxkH4
         67zmJSE1uKLGx2w1qT1aTIoyX3jHcQTBqE0W9hA0c2NBz6AsmGcKsN18twMiyBAZ+Do/
         pmeDEWx0PGLR4twTKS3VXnzDBiwKZwCnqzzfmcx3YiwURVLAC5wORQVddXmj47VbdmsD
         2e1g==
X-Gm-Message-State: AOAM5319Lw8fXmG0tIvtf/j9UrLIR3aBnB9VrMd3LFjw23JfkVt/VpLh
        y7XSkWADUE38eB1kTjP7w60=
X-Google-Smtp-Source: ABdhPJxcZBW7rKiOj2dxRYX9OAuBl31zPqRy8oGmP8AWZTTcmNJW05C9yuM/WQLlYBpXe12Tj2K0RQ==
X-Received: by 2002:a17:902:c082:: with SMTP id j2mr8068663pld.285.1594996715269;
        Fri, 17 Jul 2020 07:38:35 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id a68sm3214689pje.35.2020.07.17.07.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:38:34 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 14/17] perf: ftrace: allow set graph depth by '--graph-opts'
Date:   Fri, 17 Jul 2020 22:36:25 +0800
Message-Id: <20200717143628.47721-15-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717143628.47721-1-changbin.du@gmail.com>
References: <20200717143628.47721-1-changbin.du@gmail.com>
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

