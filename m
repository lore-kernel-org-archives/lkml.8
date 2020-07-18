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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E63CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35AAD20724
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:51:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvb5jLhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgGRGvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgGRGu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:50:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374B4C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:50:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so1841964pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ILcbTPlZOCIVf/7yt+0/wleV1z8z1rhYIwv+MSgreQ=;
        b=Rvb5jLhPq9FXChm3Q8qmnT3HtAsh95qrKiX0B2kiQ0v1ED80y1gvh16QIYX3HcTATB
         DgEqRjU2pQtX5jdQvM8LD9vcHmfK4GjMGK61QmrEzcIXnu3W52QBCjjy0FoCgDOi+/iQ
         TLt2Vt+1W6KWxsjU1FiLEZdYVsks2V9+l997yI6W/jShGciyu80PCAcyY4f8m97gSW1D
         Px8OtHB1uqSl8uIle54RwtIpjgzEXPwSnt73sx5tij13JkqqfXd6h/6xc56HBCLBMSm2
         WFy/S/SaZYSESTaDSAhKqpD91o/U0C4thLjKpGl0PC9D8myJkSpwt+W49xEgk/POW0HS
         8iyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ILcbTPlZOCIVf/7yt+0/wleV1z8z1rhYIwv+MSgreQ=;
        b=oanQukP1/okPL8Cpgp8BtAev20gfUH3LtQnkWwTXjps6wGkgV3lyNQRe9tXypgeUFK
         7QtCSJKTR3HSEcvn5em9EZE0moQVVsGqkUaS5vfqTiqwBEPixTQ2tIO8tlSIZQUDgVw0
         r5pFSWk7QoY5TXKK3T7te4S0ykKpop5fXU1oLYMoBMT9G1TqW7nCqkZvEE8rckAKSzfv
         KxuIOO90s1R2jkz8AVX5gc5ct4qcghy8nYH9NMNfr7b1YGK1ZT0+Pog6xTCiNOSP4YGx
         DcGQZhX/mla/2Cz54lN9XB6TCP2RamoSqdgYlDtGNkro9dJKWOwQ9XVnrz7Hlhyk3t/h
         3NLA==
X-Gm-Message-State: AOAM531Ym1GScbt9fNQg4egDKEbkE0k+PHyYY3SKBKL6CIVCi9I1wa+a
        GavKzSOZMCTZhh0UbPq/peU=
X-Google-Smtp-Source: ABdhPJz+xYhVkLu+A225MLhxoxvg3ciKP7S57sCFCmQWvDt9hPoBERqId6+BuDP22yCiHXewVvqX+g==
X-Received: by 2002:a17:90a:8e:: with SMTP id a14mr13703751pja.206.1595055058832;
        Fri, 17 Jul 2020 23:50:58 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:50:58 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 16/18] perf ftrace: add option --tid to filter by thread id
Date:   Sat, 18 Jul 2020 14:48:24 +0800
Message-Id: <20200718064826.9865-17-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
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
index 077249c979f2..546a8cd01b7e 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -38,6 +38,9 @@ OPTIONS
 --pid=::
 	Trace on existing process id (comma separated list).
 
+--tid=::
+	Trace on existing thread id (comma separated list).
+
 -D::
 --delay::
 	Time (ms) to wait before starting tracing after program start.
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 64b68331048a..b07f71722b97 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -794,6 +794,9 @@ int cmd_ftrace(int argc, const char **argv)
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

