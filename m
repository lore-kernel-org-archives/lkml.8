Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DA7C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B12D2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSjdprKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgGJNoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbgGJNoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:44:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE84C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id m22so2545253pgv.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oR1iCdyjqdW0rpMyzFcXJYpdaFj2hk3nZIS6lcn/OyQ=;
        b=lSjdprKUHFRT8IktlGd4X04AGtxXKmyE36+sFI8tYWGn10Fy8tCa1ihP5ukwX70t22
         D2XPYZscGKVw0qu4dB97WU2LTfOuAU1l9GlAaP/39htpdbuJLCE2X1/501Di93vvykaG
         txSL59dcCPdLWGovy43A+lXFYt4sSdsX6YYOj/0J47naNQ2H5vTBwKVjvRUBcJjMrZet
         ZjILVYCpV5shiJuu8sa3gfOqEcjoElTJBf0/oUldoQeCDs5H7pVqH5bRUGyO33CKYSQr
         aJNZrXaZy4/GZY8uLeXsbDzcOy+Bb8ajqt/VHdCUbLZYhZjP5m3IykMfoCMkBUxdRZ27
         PwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oR1iCdyjqdW0rpMyzFcXJYpdaFj2hk3nZIS6lcn/OyQ=;
        b=UVoRRyoBNheqK0LYn65L8rHRSlzVSfaxXpMo/qQFUaE7cKwrxKgdo2tZG/4kXe/1yx
         TWZZXG7LJz7Fa/ZD61vFaIvmVlssVCO5BiQD5KHBa/nu4h8Cz+QeiBP8/C0vN8O5MyzH
         fy9p/x4wcgIzmAa1IewmEGzVKDTg/fXs2C/9k6LahiRFyHazuM4BU7Is8Pg9CaZ1ZrpL
         YdMffhOBAF2sPd3Hl6vTIHGD0enZHHpmoYAEpSJ3fbWtls/jL3RRZbL5UCfjYhGrMP6Z
         u1vbwTwCvI2Ymxjuk+8ubsSPcUO2dWPsWVjD1hzQLFhrkm8T63UTUikEk5rEEuvDTYgu
         KSAg==
X-Gm-Message-State: AOAM531RizBi5DzF2MnbgJfiKR5Bs8YfYfu/F4ouTeWphOm2+crvgzMf
        ZMyBbSN3a4lqWWBcQ3Cit7M=
X-Google-Smtp-Source: ABdhPJy4F0g6MzMSxyTZdoQ+npDJX6AQ862XRP8E1vQKCS/cCwHKsKsBBgAeckZd+OZzBRSByA760g==
X-Received: by 2002:aa7:810c:: with SMTP id b12mr20521313pfi.69.1594388647062;
        Fri, 10 Jul 2020 06:44:07 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id 198sm6297363pfb.27.2020.07.10.06.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:44:06 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 03/17] perf ftrace: add option -t/--tid to filter by thread id
Date:   Fri, 10 Jul 2020 21:43:08 +0800
Message-Id: <20200710134322.15400-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710134322.15400-1-changbin.du@gmail.com>
References: <20200710134322.15400-1-changbin.du@gmail.com>
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
index 244cc8e6bd60..1188b82c6541 100644
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

