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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97261C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70B3422D00
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoX1IhZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgHHCkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHCkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:40:03 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C94BC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:40:03 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s23so2773132qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IWSxyHgRGMtaTnOrzJW2QC3+VdqmDel3IxSs33RL4c4=;
        b=UoX1IhZNYZ32XrE9giZbmYawQsQuxREOq3ZF2kYecSswoa55sCwryQvdnjsZntSe46
         bDE+SxumE4b7JXS+jT90dlnzmfD+FyrvBzJFqNCCxM1cpOMJiDGn8xfPluJekbPvxNo+
         6ED0qjfBBhAQ5+jsLqpLRK9ju+vPC6ZT0E5VMxqYXYRlejRPPz6UzI337jG3xi2JwZTi
         HkW8Y9omgdIm52BTGcJHavhVse09jmWaClLW+EPJEbMvxQAE1+0v2wfyaqQzNjiCTByL
         6F9bssH+wCjNzP8klFfkY6FgrU6mmTnC4PuV4efACvRtQuo4Sq7uQb+VBdOefbt9veUW
         HR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IWSxyHgRGMtaTnOrzJW2QC3+VdqmDel3IxSs33RL4c4=;
        b=LF9lmKZlRTGPVarGv6BLp7iSEPBH2aO2DvJY47GPkI18GcudiCTEb8dYvyibo7avHB
         swWkGjJtgDz5pzyvN12lTaGGWDFiFOrpfsblFeBPN+VUrAZDWDx3taI7lFaSG8zDvJeS
         qd+0V93srTr0oXKmdhZR+hICz+zEnfRizbmsX3IWABMgTVrJzY+LLmB6lSjROFr7rnBW
         eaHyeuCXEmTH1X25r0pFrGL1LED4sdo4n8QoT2JJFEwz6IZsvJPxoikQt7RXLs20TfZ1
         YL7b+k8kkP5zVnKxf6jg+/t4K9hIMPe/0B5OSEaDXHyMn6PtS0lzISkwVuH0fIW6loi9
         YQCw==
X-Gm-Message-State: AOAM530Z1SY2WGG44Y+WLAahBhc68i8DEtHKR5kD3wCgZjB5vBjTEzjL
        Gg3W8nz+94PYDzYxHNKXvoQ=
X-Google-Smtp-Source: ABdhPJyZfa0B2zyVIQS3oq8srIbbP+4uO6X+JXLKQDgaA0t+9mxKir0ceCL3UWdxl+SPTRWFsfR/ww==
X-Received: by 2002:ac8:429d:: with SMTP id o29mr17677840qtl.230.1596854402776;
        Fri, 07 Aug 2020 19:40:02 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:40:02 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 16/18] perf ftrace: add option --tid to filter by thread id
Date:   Sat,  8 Aug 2020 10:31:39 +0800
Message-Id: <20200808023141.14227-17-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to trace single thread instead of the whole process.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt | 3 +++
 tools/perf/builtin-ftrace.c              | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 29c684b3b3fd..78358af9a1c4 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -39,6 +39,9 @@ OPTIONS
 --pid=::
 	Trace on existing process id (comma separated list).
 
+--tid=::
+	Trace on existing thread id (comma separated list).
+
 -D::
 --delay::
 	Time (ms) to wait before starting tracing after program start.
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 5f9a9ebea0a2..13abb737fd12 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -812,6 +812,9 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Show available functions to filter"),
 	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
 		   "trace on existing process id"),
+	/* TODO: Add short option -t after -t/--tracer can be removed. */
+	OPT_STRING(0, "tid", &ftrace.target.tid, "tid",
+		   "trace on existing thread id (exclusive to --pid)"),
 	OPT_INCR('v', "verbose", &verbose,
 		 "be more verbose"),
 	OPT_BOOLEAN('a', "all-cpus", &ftrace.target.system_wide,
-- 
2.25.1

