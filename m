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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291DFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0522206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMkMSgFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgGHQrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgGHQrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:47:06 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04819C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:47:06 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so18171585pfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oR1iCdyjqdW0rpMyzFcXJYpdaFj2hk3nZIS6lcn/OyQ=;
        b=DMkMSgFWQ8FAY3UxRHLWekLRnaVBj2W501LzZyyJDFvGF0R84ZjOqra7dp65mCloku
         y5pzsmYzQmwBnxefO4IX86CiBGn1bE6dPpwk6DuUA12hPk4gjIzNDMmp6uxtRP9ZtuHc
         M1TN1KZlzUwESK5lvYtlMiBAgBICU0+/mqCTiSWe07gYvWOguIEOHEqnUQDHdX97qZk1
         y4xQwiXBvgdXtaG3OCFk70WgHKFocl4sJZYqXpi2vOg6Tm4RGH9oZyVw1pijteGs0Na9
         6OlAbbgHhuP4B6ECLsdoPqFaEzHClOSRzux3C/sg7KDc8e/dWmk2HnUROj+otL9XZnGS
         DSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oR1iCdyjqdW0rpMyzFcXJYpdaFj2hk3nZIS6lcn/OyQ=;
        b=BLEm5em7vv9nrSMQ76HQPezClweH6xhE9cxXrcu7L3JubzujdvEpUinbWqaaNgvZsx
         g5m0boFflE7vnO4GbUO4qYNSOouT8QTWr6Ly6TXvGGF0EXKA8UisLqdz0jIijtCeOO8/
         Ob2qpPJLYHKwhYfwGGiExIsU6ieQDgX0MHO+bmcOYxARTEseodAmIVp62ZsawbrblImD
         TCdMSQv5NHpXLz/Sv7HCprO+iDgGbgODtqM/vHZfjp6QAdxUB3g/5sCuA+d8IiaQSs1a
         Fw3hbXg2wRhI+pT5SWmBEOVx4qgFcSUifj2tsyBXHqpt5smSRz0XHzMpBnyqghIuic7w
         aoLw==
X-Gm-Message-State: AOAM531UgNVJ0yDbQ3yw3UUzwufuZbbzhYdRsHpCAkmm7AZFPQyMFHFr
        plNoliBIe+WcVETSlELkGZ3BrzNRJWs=
X-Google-Smtp-Source: ABdhPJyVnPqb4GPnDtxfnp+A2qjCijZr1Y1ZAcXS+VphtuEC6f4GYbnn516pT9lFRPmqHL86KM1Imw==
X-Received: by 2002:a63:135b:: with SMTP id 27mr42757024pgt.37.1594226825632;
        Wed, 08 Jul 2020 09:47:05 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id r8sm310803pfg.147.2020.07.08.09.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 09:47:04 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 03/17] perf ftrace: add option -t/--tid to filter by thread id
Date:   Thu,  9 Jul 2020 00:45:51 +0800
Message-Id: <20200708164605.31245-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708164605.31245-1-changbin.du@gmail.com>
References: <20200708164605.31245-1-changbin.du@gmail.com>
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

