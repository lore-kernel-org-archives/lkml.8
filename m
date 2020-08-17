Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3277FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F130820729
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQIdGOhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgHQOb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgHQObz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:31:55 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B94C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:31:55 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id i10so2668273pgk.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SGD5CC3KWxu5GgSYIIzD+q+yRltekjz0tO2TV7TygY4=;
        b=aQIdGOhLX7dHJv92MJ6aobisTyCi4LUrWYawsQUWDAT5RaPljeXfEg/Tpqsfn/BHI1
         6moG1pBY76hMl2O4or7yOfVRyUHCmSuymNRH4obIlca1vPqyIu/KpNm8gOefZV/RcC3x
         Fkh7r0TyoBis+qe9NrTCRhcXBvH/kskEIrj/UHbn/gs9uWxJYM0MZY6iIi1FS/ZhxwfY
         z/Vzz0O7DCsNwTMh2H/Jo1Tg7vIzowZfnpw9ixgRrvPhEhBki6m52HOCPssaiMMi0Lun
         KCndeBIMY82MhQiCdPZfUmJcvtGhRu9Bik1teBxpaglvb+NtUNpoU+OoHj3y4eXqoje2
         iroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SGD5CC3KWxu5GgSYIIzD+q+yRltekjz0tO2TV7TygY4=;
        b=Sxe+Trrzex1FNLv7SUgrCfFtDSVguniw1+aGTyf4VUjKfYuDs+mcMMQ3miKp/lMr61
         WszqdUQ5OifUraPbn9hOKxo5uX84aFdyb0XIPjAIjSn+GDF9wi3n0DzMj8wqb0ynCOyB
         X9caiWWofnO8RFDfZg/3c5rpP2/B37Mv9bRWoiRAfe+ln6MYAvtW3h3a+VRXv3H1zCfF
         UO+llrPbFFxK78Ctee7knnlVpZt+OCN1t+5LxkqjspIzhksRPiH9POh1fjEBiNVUiYK0
         lVKAHKKQp7vi/2Af9wLnv0W7s1nvVUW2naOJ7WTTcgTJPG3t/2eXhNdbUSeu6/FKyKoA
         aBIg==
X-Gm-Message-State: AOAM53123ELyl+4r27EMAXMOXRaPZU54JWsPXnRpUxyebef7kuopMDyC
        xeWqfQoi151Vo+eJKTAQdnBTSA==
X-Google-Smtp-Source: ABdhPJxtCxk4VpIW6VEPNlYFEze5Jk07MY9HsHxjRl8ggkaFz3ne6yHNkyrUDGTv8YTOsi4Wkt1IcA==
X-Received: by 2002:a63:3d06:: with SMTP id k6mr10417050pga.316.1597674714654;
        Mon, 17 Aug 2020 07:31:54 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 193sm20174450pfu.169.2020.08.17.07.31.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Aug 2020 07:31:54 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Will Deacon <will@kernel.org>,
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
Subject: [PATCH v1 01/13] perf arm-spe: Include bitops.h for BIT() macro
Date:   Mon, 17 Aug 2020 22:31:02 +0800
Message-Id: <20200817143114.13393-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817143114.13393-1-leo.yan@linaro.org>
References: <20200817143114.13393-1-leo.yan@linaro.org>
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

