Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E897C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEFB021744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SytaL+hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHFDIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgHFDII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:08:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8F2C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 20:08:08 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y206so13857209pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 20:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KQqN1QXBA5RThrLQISqCHyorCdog+0FonNa65+qisxE=;
        b=SytaL+hriwDm27Wvly5IDA5v2ojJFlTW/6kDfg9GTCbt3V2JFZEx/EyT3u2RlL72DQ
         ld4LzKEZQxMoX/EdCjxtky0iJxeqZErNgwGTTE6/CK24Xy09pGjAaoPgHGiRbDh97O8U
         y38CVew/vz725Clvsy3T11c3U3PBFfQynQqiX5t8pkF9bFkNia8lb8/oPLPl3/bIfhUm
         63UwKinRW7hqrPeTVSwsrAcw9GabFNglXiRrSUEYdA71pFcwwh1bIiafzqjUptbxZMmU
         EW6gFokr9aW9D2tRZR4Gft52frz3G3ZAEiebfNvrQStwLJCB4wd1oVPnJAY4cb0eRkvq
         qyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KQqN1QXBA5RThrLQISqCHyorCdog+0FonNa65+qisxE=;
        b=Mxp1tGQe9yv1fxjIrUXeGNBEBDf9M3XQWPxal5oDzpEPcs0uZM2ZsQwTYbXFaKcwGb
         t36iyeF0KJ2J5yyQYWAikKQsMGTwqiVHY67jsKjD6YPOHlBOVCrHEjpEjmHGFWnCzV+1
         LlGXawByC4zsnJaK46Irf3ZEUgal3QqKbXuVuuXn18xPwx8vfTLcEGNK3BifhCsUF6Bx
         mAB4A74IFm6ga/kTtGhSHU1I8/UwrgqDxV5ThXsO7nLbYDNmM2tPGwdP4XbizjF8/gM4
         PTRZ6oZyAhMq/yovJfj3qaSO9yvtQi0YkYadebMExwW1P2F6z2SUgzVchgnvlx9oXH/9
         e39w==
X-Gm-Message-State: AOAM532pO7RnLw/hokREq8SMB+G4CPWes6l5h5i1GILjHueaGxuvspKC
        NPtdhyRxTvnbP7i9yFcreCySig==
X-Google-Smtp-Source: ABdhPJwke0Y+wUfKuwowywBFOEaningSOW8XeRL3hFpv5URLR8tjQxhD+XoRQvF67T6K+eSoAiI3vw==
X-Received: by 2002:a63:7542:: with SMTP id f2mr5376480pgn.151.1596683287585;
        Wed, 05 Aug 2020 20:08:07 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id x28sm5394955pfj.73.2020.08.05.20.08.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 20:08:07 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH RESEND v1 03/11] perf mem: Support new memory event PERF_MEM_EVENTS__LOAD_STORE
Date:   Thu,  6 Aug 2020 11:07:19 +0800
Message-Id: <20200806030727.30267-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806030727.30267-1-leo.yan@linaro.org>
References: <20200806030727.30267-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existed architectures which have supported perf memory profiling,
usually it contains two types of hardware events: load and store, so if
want to profile memory for both load and store operations, the tool will
use these two events at the same time.  But this is not valid for aux
tracing event, the same event can be used with setting different
configurations for memory operation filtering, e.g the event can be used
to only trace memory load, or only memory store, or trace for both memory
load and store.

This patch introduces a new event PERF_MEM_EVENTS__LOAD_STORE, which is
used to support the event which can record both memory load and store
operations.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-mem.c     | 11 +++++++++--
 tools/perf/util/mem-events.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 9a7df8d01296..bd4229ca3685 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -19,8 +19,9 @@
 #include "util/symbol.h"
 #include <linux/err.h>
 
-#define MEM_OPERATION_LOAD	0x1
-#define MEM_OPERATION_STORE	0x2
+#define MEM_OPERATION_LOAD		0x1
+#define MEM_OPERATION_STORE		0x2
+#define MEM_OPERATION_LOAD_STORE	0x4
 
 struct perf_mem {
 	struct perf_tool	tool;
@@ -97,6 +98,11 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 		e->record = true;
 	}
 
+	if (mem->operation & MEM_OPERATION_LOAD_STORE) {
+		e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD_STORE);
+		e->record = true;
+	}
+
 	e = perf_mem_events__ptr(PERF_MEM_EVENTS__LOAD);
 	if (e->record)
 		rec_argv[i++] = "-W";
@@ -326,6 +332,7 @@ struct mem_mode {
 static const struct mem_mode mem_modes[]={
 	MEM_OPT("load", MEM_OPERATION_LOAD),
 	MEM_OPT("store", MEM_OPERATION_STORE),
+	MEM_OPT("ldst", MEM_OPERATION_LOAD_STORE),
 	MEM_END
 };
 
diff --git a/tools/perf/util/mem-events.h b/tools/perf/util/mem-events.h
index 726a9c8103e4..5ef178278909 100644
--- a/tools/perf/util/mem-events.h
+++ b/tools/perf/util/mem-events.h
@@ -28,6 +28,7 @@ struct mem_info {
 enum {
 	PERF_MEM_EVENTS__LOAD,
 	PERF_MEM_EVENTS__STORE,
+	PERF_MEM_EVENTS__LOAD_STORE,
 	PERF_MEM_EVENTS__MAX,
 };
 
-- 
2.17.1

