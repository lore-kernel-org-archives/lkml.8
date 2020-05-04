Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1C0C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59BEF206A5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yNlSGZ2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgEDL4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 07:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEDL4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:56:48 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673BEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 04:56:48 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id y6so3668356pjc.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 04:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VjxC6yar2pkOPDjFHi+N3zsczn/g58x93twk4LhJqJY=;
        b=yNlSGZ2hjNuslp0mc3MIjz3ht1xvPrJSZ6G/6CHlsizSc+Hp9R6kh6jNzcbaqrXLgt
         Af3cFoLPjTm/bHZri3/t2L+n47cslLjI6sG5ezJGpW7j5jMgb5cIGPS95OrI1t8BAq5j
         JPrQJt9MNYm3+h6bqMbYNUjPmz5R5LqXNWv1KMtHDLaJxHwUXkqaBcZpY0wo9qg/xvuj
         JKPC0Q4sJe7gUYBLHZCxkabQYMl0HxtfMkizoBBYmEcDWvhwFzpmJ3Bq2gEu/OHKW19Q
         xaWk8yvFG71MTEdKkE9AkUB6nt0jsWY3Dc8cBiyZWpZQir1OyALnMlmYNhuoY6q1stEf
         yotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VjxC6yar2pkOPDjFHi+N3zsczn/g58x93twk4LhJqJY=;
        b=ObuJxOKBfiI03C4t7dcftl1G4BbTTZdZUFJrxDvE5ds458VVfQKBr0dTlI7RlRkQOa
         cUn3uqwWgFuXVyrbyVW5T4IZT1Yde6X92DiZ9/iUCG2YCQ2VcdpXigrg+SVozgmOgeI8
         5rFXDoNAO1yd7JiPmDe2Y/g+KT5sxUZ6+OHCzgFgsz95s1phWEjNLzdoaXJqwI2uNoFv
         fQPrkVUI0wzYyOuK1bTOoHDnGE1X638TOzlFmRg91qh/rk3sNQowPOjBnw8M6uUcO3JA
         PdWhoQy/ySf7l9+ISDmoCzq/jhWCwl1zEHQzcTx+0qJO38xQFGD3AljQJSJ5S010vFZV
         s4Lw==
X-Gm-Message-State: AGi0PubumxoctAJcGVXed1gKGgqh7hImaFTQ1XsH5OmXW6gEAZf4N3Rd
        byGqlYyiz5T3Y8LzKUwZs4FGpA==
X-Google-Smtp-Source: APiQypIvcDK+NL5FERdEoAlT+n/SbuYUlWoJTlo3xaAi8kbBrMP/Vm6C+hhqPqKPa3ytgy9nUEuNwg==
X-Received: by 2002:a17:902:b186:: with SMTP id s6mr18538615plr.16.1588593407935;
        Mon, 04 May 2020 04:56:47 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id y24sm8693921pfn.211.2020.05.04.04.56.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 May 2020 04:56:47 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Tan Xiaojun <tanxiaojun@huawei.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v7 1/3] perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
Date:   Mon,  4 May 2020 19:56:23 +0800
Message-Id: <20200504115625.12589-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504115625.12589-1-leo.yan@linaro.org>
References: <20200504115625.12589-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tan Xiaojun <tanxiaojun@huawei.com>

Create a new arm-spe-decoder directory for subsequent extensions and
move arm-spe-pkt-decoder.h/c to this directory. No code changes.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
Tested-by: Qi Liu <liuqi115@hisilicon.com>
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/Build                                       | 2 +-
 tools/perf/util/arm-spe-decoder/Build                       | 1 +
 tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c | 0
 tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h | 0
 tools/perf/util/arm-spe.c                                   | 2 +-
 5 files changed, 3 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/util/arm-spe-decoder/Build
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (100%)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index c0cf8dff694e..cfda4204bb51 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -104,7 +104,7 @@ perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
 perf-$(CONFIG_AUXTRACE) += intel-pt.o
 perf-$(CONFIG_AUXTRACE) += intel-bts.o
 perf-$(CONFIG_AUXTRACE) += arm-spe.o
-perf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
+perf-$(CONFIG_AUXTRACE) += arm-spe-decoder/
 perf-$(CONFIG_AUXTRACE) += s390-cpumsf.o
 
 ifdef CONFIG_LIBOPENCSD
diff --git a/tools/perf/util/arm-spe-decoder/Build b/tools/perf/util/arm-spe-decoder/Build
new file mode 100644
index 000000000000..16efbc245028
--- /dev/null
+++ b/tools/perf/util/arm-spe-decoder/Build
@@ -0,0 +1 @@
+perf-$(CONFIG_AUXTRACE) += arm-spe-pkt-decoder.o
diff --git a/tools/perf/util/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
similarity index 100%
rename from tools/perf/util/arm-spe-pkt-decoder.c
rename to tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
diff --git a/tools/perf/util/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
similarity index 100%
rename from tools/perf/util/arm-spe-pkt-decoder.h
rename to tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 875a0dd540e5..235de3d0b062 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -23,7 +23,7 @@
 #include "debug.h"
 #include "auxtrace.h"
 #include "arm-spe.h"
-#include "arm-spe-pkt-decoder.h"
+#include "arm-spe-decoder/arm-spe-pkt-decoder.h"
 
 struct arm_spe {
 	struct auxtrace			auxtrace;
-- 
2.17.1

