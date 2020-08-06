Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDD2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B5B420823
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jNpdFAk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHFCl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgHFClR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 22:41:17 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DA6C061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 19:41:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t11so6912508plr.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 19:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KQqN1QXBA5RThrLQISqCHyorCdog+0FonNa65+qisxE=;
        b=jNpdFAk6UOm14/lGBWmsnCpJYeXdSYakyA0BagYf/5Bk/X2U48DNvVELkK+7L48xY0
         R5ZqzNXhyWC5mc8SvqWjgRlY7LJAA/0ReMXbnBzyqJiiiVEOJak9C9NOSRP3/1CVDCu/
         I8peaQ/YkCSdxWq0wZOvykeM6iZ5hzu3KD1Bn3zSlP0VI2WdPU9eSrJbFCA3/dOtcAXY
         RRlBw7oooskEFsM+eHPmpR83wm4P/UdeHt8MYI5CSOppgL7b9JDDau3pqbwjEFFTWWDz
         PzB/GazR/zmuPtKnZoQlikR3Q6XwURYwYeuPxRacoxJEoo6FTJb1oc+JR4jIc4wcdcnU
         NXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KQqN1QXBA5RThrLQISqCHyorCdog+0FonNa65+qisxE=;
        b=Rc9ITJKmabCK4i04ZNHLBDX1IKuWOQXOqJiFl0db2k+UqoGUJqd66fKmfcjwy4Q07n
         Vmq3XDpxY+xXFHHod/RLU1A2PPH8iatGNlPKYLqfNPQ940R3FMjPTEQGYGgSKaCCQPWk
         wlUetno9QoVRuoG4RmfBnuf5gB5K+yKW4pq1AD4GPXcBNGDTAfahJfuXj0+Ni7g2vMqr
         PmmK/Bjzyg1PLxoVt49EEca9RMc+5ivcSHpDa3CWOmwqaoybcLDHD7wYz4OARSis5rbU
         tmgOP9Iid8tOqNY/XEbH3bB3pjO0Oj+O4irPr8j/kgZCzOxB3OU7sOU6cJOVqOaCHx3U
         F0HA==
X-Gm-Message-State: AOAM531hlNmadLUzM/g7bHG2fbS/dDyv38mWaLhdCasC3PxbpgcYEWO7
        mI2WMAWm9L4gy7bmeb1iHA/FYg==
X-Google-Smtp-Source: ABdhPJxzn4/ryy5ICry0G1sHOc5ZurI+A7MnofFQLjdu4CZ+I1+EcgR3hY5NFV63IL4n5ST2Mk03ww==
X-Received: by 2002:a17:902:be0b:: with SMTP id r11mr5588648pls.114.1596681676833;
        Wed, 05 Aug 2020 19:41:16 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id z25sm5285488pfn.159.2020.08.05.19.41.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 19:41:16 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 03/11] perf mem: Support new memory event PERF_MEM_EVENTS__LOAD_STORE
Date:   Thu,  6 Aug 2020 10:40:33 +0800
Message-Id: <20200806024041.27475-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806024041.27475-1-leo.yan@linaro.org>
References: <20200806024041.27475-1-leo.yan@linaro.org>
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

