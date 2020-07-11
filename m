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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CCEC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BCA5207D4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7Bhox7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgGKMma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGKMm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:42:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D722C08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:42:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so3741127pge.12
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oR1iCdyjqdW0rpMyzFcXJYpdaFj2hk3nZIS6lcn/OyQ=;
        b=T7Bhox7ofulwsbETIPGGFK7F1UMSiwKt9NyrXamJhZecsP3w30qZP6gV8cXiquRsDN
         DBvB7iDCycid/EniXSn+VS9WK87DjN/UfwG/xsm11W6qgq8o4/KPWTCPJJf2CFTNCRO7
         nVvbQeDT0ce9c5oJMZZ3oKRYAqk5Dj+d6Zylg5NcAtNTcZyvcDNnvVdYWDv18tPKXGfy
         z92Rp8nsiyLBV0tfQZmjWcUZF49CNXzKnve0glJxSKKGgr1PzUXF6vTdS/yCYueaBJxU
         unga80+ibLh0B4hfptP3kelSATPWvohpmEdPueC1CN7OCkL6LN5NoEQKFlrqym0fQ/it
         L6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oR1iCdyjqdW0rpMyzFcXJYpdaFj2hk3nZIS6lcn/OyQ=;
        b=keL/7L/aSZxa5t21eUL6KMPqKWVOVwUQktxM3LMXZoNTWCWyljaoQK6sKZtZJbs4oo
         N1qX1x/XnKcx8fr0WzDShQn8YVQOrc1Lw598XPdsIyrJaSCro8AEFtaODmyR2KAZxxXP
         rsknPcgjcniT9q8UGxh9zIs8qht8iBf1M5iVaJ59OxiOHRtaiL7UMd4HTzGRRoZ/Wsdp
         dw+BeqCmFbRK36Pa8WatCzb/Nf7ffncPtqmXtsub+IMuL00s1BcR+aj/YHtCqtFjBCnn
         aHR8MTma9kR8lC9KVKIpupa+ASybp+GYFSwJ9X17Qk/vdtFUqn0/Frn3mIRM+mtT2bnA
         45OA==
X-Gm-Message-State: AOAM530/qhQ1/BSgxEdjav6sjV45zvci7cUgcRO5IkDiw06cgM6iOlkz
        Ft7lNNZG0HHwRjGHi30yoHM=
X-Google-Smtp-Source: ABdhPJzAtjQDpUqfxW+P1UMTko7RRBcldd+RIzzKbwzFLk06mpdwULfl725Cl2vHx0NagK80AxmuGQ==
X-Received: by 2002:a63:d30a:: with SMTP id b10mr61219517pgg.430.1594471346858;
        Sat, 11 Jul 2020 05:42:26 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c19sm8352899pjs.11.2020.07.11.05.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:42:26 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 03/17] perf ftrace: add option -t/--tid to filter by thread id
Date:   Sat, 11 Jul 2020 20:40:21 +0800
Message-Id: <20200711124035.6513-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200711124035.6513-1-changbin.du@gmail.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
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

