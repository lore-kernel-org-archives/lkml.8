Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A97C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F48E20748
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uE9lvoqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729063AbgHQOyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHQOyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:54:16 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769E8C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:15 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l2so15304003wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SGD5CC3KWxu5GgSYIIzD+q+yRltekjz0tO2TV7TygY4=;
        b=uE9lvoqDhRfcFVwZMEizliu7UXlxZacWu6FkcaSiohkgPN5GnI0XnWVyZP69XFq6nG
         8dLS27iM8jNrOCh7EBBs0vJzUZk54CNATkbsmthUt7d9VSv9A7SEgYb11XIonBT78rH+
         8soB4cGGqKxF0N7eP/1GcgCTr29he4sv91OyV82/gPVEact37a/Te8zNhs+FSKy/TxXS
         xSar/tcAyOWT4iWg++N5ZUdbwLhkW9snEQIsTuampeex4nvEa1TfgPuhW5EqBYemNpfh
         PC5bSSQsZVl9cjIy0fekAlyEdP4Wo9Q6UIWYoio0tl6Sg3bkS4oN/ELQzZe/B8W2HPQh
         jMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SGD5CC3KWxu5GgSYIIzD+q+yRltekjz0tO2TV7TygY4=;
        b=hmXtyqEqLcw4t67oNnZtWZKdnscMHNtTVkxlnPn8rLLd0hTwzG52Bzd97747lx2zKG
         wPfJ9hmDTzPqU3lcm6VZ3JGPVGgZvuBxk9LguHSwFY2CBqicT2dF62lABUSv4sBwF0cv
         GIW6uS6+gTqXxuW46ZzQPha1AVXP2NsGPrcENXIzF5RSfCCxstDurBCGk8W733XQyRlr
         ENqOdW36YbIAPRaW0xcIUCOBFEwbctS5ORp8FJftP3HBtgicKqfLkHK7FpoUul3abfbe
         LV6/GrMmx2/gfAR8ExgOARIlcqpMUvbYDJF0CiNfbMOhnryJRBrTiyYeUZwfsGDRhz4L
         WZRQ==
X-Gm-Message-State: AOAM533b9ClBlO+yeUzZnPJsRWMc5Yql67i5XF+zzkEaPSUL2ixcDZyA
        lvP8LWIa0rYu3TMjTeS1HWhpuw==
X-Google-Smtp-Source: ABdhPJw/j/nY/uUpct6p6QFu5O+gy9YZ5HG1eWsN4+nH/teBesPEAtDS3UHfxJ0LvK5eT4F0R0LFQQ==
X-Received: by 2002:adf:9d85:: with SMTP id p5mr15213144wre.286.1597676054068;
        Mon, 17 Aug 2020 07:54:14 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id r16sm35005678wrr.13.2020.08.17.07.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:54:13 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>, Al Grant <Al.Grant@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH RESEND v1 01/13] perf arm-spe: Include bitops.h for BIT() macro
Date:   Mon, 17 Aug 2020 15:53:36 +0100
Message-Id: <20200817145348.14461-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817145348.14461-1-leo.yan@linaro.org>
References: <20200817145348.14461-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include header linux/bitops.h, directly use its BIT() macro and remove
the self defined macros.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c     | 5 +----
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 3 +--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 93e063f22be5..cc18a1e8c212 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -12,6 +12,7 @@
 #include <string.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <linux/bitops.h>
 #include <linux/compiler.h>
 #include <linux/zalloc.h>
 
@@ -21,10 +22,6 @@
 
 #include "arm-spe-decoder.h"
 
-#ifndef BIT
-#define BIT(n)		(1UL << (n))
-#endif
-
 static u64 arm_spe_calc_ip(int index, u64 payload)
 {
 	u8 *addr = (u8 *)&payload;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index b94001b756c7..46ddb53a6457 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -8,11 +8,10 @@
 #include <string.h>
 #include <endian.h>
 #include <byteswap.h>
+#include <linux/bitops.h>
 
 #include "arm-spe-pkt-decoder.h"
 
-#define BIT(n)		(1ULL << (n))
-
 #define NS_FLAG		BIT(63)
 #define EL_FLAG		(BIT(62) | BIT(61))
 
-- 
2.17.1

