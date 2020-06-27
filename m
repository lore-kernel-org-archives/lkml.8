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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA9FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51CB02158C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guoXZ4AP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgF0Nhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgF0Nhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:37:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338E0C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:37:42 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e8so6269857pgc.5
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t+mGbz+jBKo9dHNxI3C3wVTjmOKtqRlnc8Twc3V90cY=;
        b=guoXZ4APiOya6AozC6bNh5rbpfaVz3kRq2xsWVZAqnqQGRR1YQ8dzA5st8aIlP2t6T
         4DfyeuOgD5Q2lDXUbfmNT9/fz6dMMPZxWKj7JHVg+QNpfsZUqlpANrPDrEdVbrCT/XFw
         4mAtd7tXrSe00la0wwl2AiAXdjZYaM+xTR6C+JTSzUZp3w5fRepLzP9PJBDZo3Cqx7wj
         LD6HKuWYctHJ0YinTtG5Ih15plg6xQAEBycuVZ6FKY2NWeakf7hHLw1PckjBVoxs6WUx
         IlOYz89swHIcFh3JlHGEcE5iGdSR6b9LDKu+WkPGUbgAgivrg0MhJVp8lK+7WpUAY5W9
         ZujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t+mGbz+jBKo9dHNxI3C3wVTjmOKtqRlnc8Twc3V90cY=;
        b=K3VUrc2YlXeeDynSe7Sj9fxfjpk0Lx4SDgwbE/KIkHsfgzqPFs2raV7PlYzcaZeoQ5
         xs7We8WqEO87vzhU+KAzEqZ7Ll+ReDyRkgNx9TepseZnYREXLtLmQdg1uu5TEvXWuNdh
         yOFpdDnAkFVZozkdsxoCwcgJYhI8UOfz4HJBwS0QCr8LCuqJb/lmub6u4eHPajDJl+9j
         u1ES1FnDtu7U61JaUal1p4Nwv8zBTglELp7oYguTW0loqq7ESOjCQzWmDOUnizhTQiHR
         vpWJJ6yn34GEaCgnqYKo7Kc/Ke93mpmf875mzzDBtnpsj4Pq2MoNsiE7S/LW1K4J0xf6
         s80w==
X-Gm-Message-State: AOAM532yuU5T8eC1dLc/dcx5EmtuY7ADqLgJT6s0FWqYDBjuRjlID5yD
        Zn1tv3/LV7jHk1MRvVWytvw=
X-Google-Smtp-Source: ABdhPJwECGOPvZCRAEupd/99mpS3PPR2n82GKZGOK7EHvvs8fldJVNJm41Not5D+TqfSZ4y21OpcwA==
X-Received: by 2002:a63:fd03:: with SMTP id d3mr3346641pgh.76.1593265061737;
        Sat, 27 Jun 2020 06:37:41 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x8sm15060086pje.31.2020.06.27.06.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 06:37:41 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 03/15] perf ftrace: add option -t/--tid to filter by thread id
Date:   Sat, 27 Jun 2020 21:36:42 +0800
Message-Id: <20200627133654.64863-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627133654.64863-1-changbin.du@gmail.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to trace single thread instead of the whole process.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/Documentation/perf-ftrace.txt | 4 ++++
 tools/perf/builtin-ftrace.c              | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index d79560dea19f..e204bf6d50d8 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -38,6 +38,10 @@ OPTIONS
 --pid=::
 	Trace on existing process id (comma separated list).
 
+-t::
+--tid=::
+	Trace on existing thread id (comma separated list).
+
 -a::
 --all-cpus::
 	Force system-wide collection.  Scripts run without a <command>
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index e793118e83a9..b427ab3977ad 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -515,6 +515,8 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Show available functions to filter"),
 	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
 		   "trace on existing process id"),
+	OPT_STRING('t', "tid", &ftrace.target.tid, "tid",
+		   "trace on existing thread id (exclusive to --pid)"),
 	OPT_INCR('v', "verbose", &verbose,
 		 "be more verbose"),
 	OPT_BOOLEAN('a', "all-cpus", &ftrace.target.system_wide,
-- 
2.25.1

