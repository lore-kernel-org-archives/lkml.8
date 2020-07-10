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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA46C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E02207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jptl7hy7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgGJNoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbgGJNoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:44:12 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D221FC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:12 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m16so1070355pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ul89J2LxR5qyab2DeLgx+D64gpkzNDa9NrxPE9OXSOk=;
        b=Jptl7hy7y5ej44PfFrjfAD324OFj/lqogo7RzDj2gj8bpq6r9aKlZxUF6RUE98gtal
         PF/HXZvA8NtfPixOMwmVoy0wAduqPOwnx4vO8B10qDn20vLlOksp4HBq1kVcozc4WV+x
         rHrc74zjSdeIP4edB7ZyWewy1G1AFR5FSWmTBtLOTj3GTchiwf02olkJO+sOjUTbIXpP
         Mw6cvJM0pTIF9qJMj3oPFJCDU9lrYjTZStQbigZpl9apkQ0cVCjAdh71VBf/NCvDZfCq
         C+TobJxEcKfOi4cRfmKQYiYRG+PJshOGuQJCNfSMOC3dNSrdmk7jsrn5QEnUIOKKDy/0
         f/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ul89J2LxR5qyab2DeLgx+D64gpkzNDa9NrxPE9OXSOk=;
        b=Hgki6eGp8DxQInbMJc0QF2R1t4Wc00UfVa1e+DhBPcGCB8bIY4rqy/VIqE0p6lK77O
         Ajpb+LZo3MXTuM1q1hnw/j78LbMK13nQ1vZaqVBB0gMTO8JQwMGaOT5MUBWr9DnZc1G7
         OU89T/kiCdhgthU3UPn6vzFcJj3gXJgb/UqGYRon59iLmOItLR3ZHPTQWY2AcHX07nYA
         rNUEb+A4mQCO4IH7X6tqNN5PC0ucWCpgi443hMRJbWVTOwrjTpyv528GURjQqODx2B2Z
         igdPbFKbDB1Q+9r+vEPPyO6GK9Y3lh9AKMcuV8dZQnOzYE/zBGuh1tx643n5Z10mjW1j
         VcaA==
X-Gm-Message-State: AOAM532v8BH4uW6Fdszx4mEkEWhAt7Lm6Q6OR62cQYO4RMn4haykkjzO
        /IzkdsDNU9l7P6s4bfzx8/I=
X-Google-Smtp-Source: ABdhPJx0MmUV3wOhleaJfvRW39HHT0dZl2kvv0Svhslq0lxe2IkySUnugMqkHm+4Zn7tFZRl5uhVpw==
X-Received: by 2002:a17:90a:f014:: with SMTP id bt20mr5910798pjb.135.1594388652305;
        Fri, 10 Jul 2020 06:44:12 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id 198sm6297363pfb.27.2020.07.10.06.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:44:11 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 04/17] perf ftrace: factor out function write_tracing_file_int()
Date:   Fri, 10 Jul 2020 21:43:09 +0800
Message-Id: <20200710134322.15400-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710134322.15400-1-changbin.du@gmail.com>
References: <20200710134322.15400-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will reuse this function later.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 1188b82c6541..342861a1d152 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -165,6 +165,17 @@ static int read_tracing_file_to_stdout(const char *name)
 	return ret;
 }
 
+static int write_tracing_file_int(const char *name, int value)
+{
+	char buf[16];
+
+	snprintf(buf, sizeof(buf), "%d", value);
+	if (write_tracing_file(name, buf) < 0)
+		return -1;
+
+	return 0;
+}
+
 static int reset_tracing_cpu(void);
 static void reset_tracing_filters(void);
 
@@ -295,8 +306,6 @@ static void reset_tracing_filters(void)
 
 static int set_tracing_depth(struct perf_ftrace *ftrace)
 {
-	char buf[16];
-
 	if (ftrace->graph_depth == 0)
 		return 0;
 
@@ -305,9 +314,7 @@ static int set_tracing_depth(struct perf_ftrace *ftrace)
 		return -1;
 	}
 
-	snprintf(buf, sizeof(buf), "%d", ftrace->graph_depth);
-
-	if (write_tracing_file("max_graph_depth", buf) < 0)
+	if (write_tracing_file_int("max_graph_depth", ftrace->graph_depth) < 0)
 		return -1;
 
 	return 0;
-- 
2.25.1

