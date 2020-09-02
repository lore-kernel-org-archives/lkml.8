Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D169C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4BF220767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WeC0rKuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgIBNsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgIBNcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:32:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A796C061249
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 06:21:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so5243240wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dp9RzDfRoyGirVF9rnp5ThGeOxcnpzQ3a8srsa+1lUU=;
        b=WeC0rKuBWXZP6A+4Id+ZPil00at0EmiJ4asfA+iD1ym96Gmxa0/Y0qhsBm+FdBdlUn
         I/xdOfz9reyrToCMyI3WxdDTo+86BXSslEzXCcUOQmxb1ANwsi4RGHBNC6vR+Fo00v2y
         PjE8FBFLFVZ0fQuUwdrtFFTxXikhxXKMR337+049gbCmKlkcbG7gZ3o4WUbm0UHWlcrA
         FsJmSnjhUDiSHqCEIUrAQImVSOJ+vKGzZwD1joOAZ1q513bxLYpfp4xjyTQ6CattV+ya
         svr8A4brwcRTktNZU+4K5FHmCzih3HsVm8uM966wqmuZVBrE8ixA0TzN3CGRHJr8FdhD
         rFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dp9RzDfRoyGirVF9rnp5ThGeOxcnpzQ3a8srsa+1lUU=;
        b=px25B1UvXZ9fh+rCw5hL8f7Reid15Lj3ZcjUJ5eNv7mZRVIOxTlxicQXOR/iVupgmM
         htbb1u2CexYQem7hIzHDterlfvrxsIy/MJRv41v3IT6cDuoqhKj2ASRMwszKmny361WA
         kqmwQxLMi48V6xKBvOS/eA+gg4QGB5cPn47V9e3i0vUAmFWnu2p0Qr/5OzWJSBOD4NGU
         vUiavocniM+4CabH/q1ll+9hJqB2XHzRB1NJRWDJMwAjYLSJZGVlmcVnwxY0gOwUqPdq
         A10eeP4Mx5ukfD40rVlrHXko6LCx9DEAQINVOCHHfXk5YiQX/d30g3xct8lFbDJ1kHgs
         6FPQ==
X-Gm-Message-State: AOAM532RZIDo/yGfSOyOzskjN7lZbeuNHwMg97OPit67uBc1/VnNAGaD
        8dV1gM6VfIKHmT4ae+t2lUQJ0g==
X-Google-Smtp-Source: ABdhPJytVOjNeECBJYodcv/4duI7Vpy8B8hgJ6H1Lzi3VUv+p+Z3EMBVFamYkAYQMk4LAlvEEcFt/A==
X-Received: by 2002:adf:80c7:: with SMTP id 65mr7008202wrl.35.1599052908669;
        Wed, 02 Sep 2020 06:21:48 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q4sm2520403wru.65.2020.09.02.06.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 06:21:48 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Wei Li <liwei391@huawei.com>,
        Al Grant <al.grant@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 2/6] perf tsc: Add rdtsc() for Arm64
Date:   Wed,  2 Sep 2020 14:21:27 +0100
Message-Id: <20200902132131.36304-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902132131.36304-1-leo.yan@linaro.org>
References: <20200902132131.36304-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system register CNTVCT_EL0 can be used to retrieve the counter from
user space.  Add rdtsc() for Arm64.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/Build |  1 +
 tools/perf/arch/arm64/util/tsc.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 tools/perf/arch/arm64/util/tsc.c

diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 5c13438c7bd4..b53294d74b01 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -1,6 +1,7 @@
 perf-y += header.o
 perf-y += machine.o
 perf-y += perf_regs.o
+perf-y += tsc.o
 perf-$(CONFIG_DWARF)     += dwarf-regs.o
 perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/arm64/util/tsc.c b/tools/perf/arch/arm64/util/tsc.c
new file mode 100644
index 000000000000..53c6adf8ea6e
--- /dev/null
+++ b/tools/perf/arch/arm64/util/tsc.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/types.h>
+
+#include "../../../util/tsc.h"
+
+u64 rdtsc(void)
+{
+	u64 val;
+
+	asm volatile("mrs %0, cntvct_el0" : "=r" (val));
+
+	return val;
+}
-- 
2.17.1

