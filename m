Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A51C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538F32071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luDP2Jgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgIAIjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgIAIiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:38:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC9DC061249
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:38:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a9so316948wmm.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ArComxmicdikxkIe1JcffH3BldcX53EJaFpYbE3tDXk=;
        b=luDP2Jgxutwk/q6yDEuVpF9ywwS8K7sSBQ/A9kg7jRRWgPqWDTmK6xY4YFwo9cAtzR
         OUXzwKsVc+8xeyUh72uZcTISb98dGG8bqlIayphyJydeKO5IXVyjVoTka9uo7l3suffj
         55f6XZV233tzV5Y5dDcY8//O9+EQq1aYewTyNHWhg5OiHB66ruIqKiSimbegJUSM1N9z
         Lz1Sv446nJc1KwrAi8YbMtstbELGsFOguL3qR28XvJGoYqeq9djjY1KwIEVNHtdFbIIW
         o0Du1Pyf5j20UAMfyKxqPncbI7KpJ+wVaFjyAxnbcUXrMOc5SKuJLJyvVr3Sc4bHwFpk
         QnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ArComxmicdikxkIe1JcffH3BldcX53EJaFpYbE3tDXk=;
        b=oMWAGtqdawy6JiIUAybixGPwXu55P0ZPqCeRVz57mc436V3UA7T0ThhztMVQ/CfMVc
         p8SDKH69wstZaBOkF7GFUIoI+83aFgEMcXz+zBzl2xr1z/1zBJQ1e7tkZngfbX+TFP4Y
         HbMfrAdq5+EqRuCYUOS3IXGCAPG2Hz1Vul7I8nW50AMtrbBgK3ZN83Umbo+1aCdRFQhY
         IlVSJkb+nKysfkR3xGhtydvagG/z9o87m8jfnXxCq/gtCcPeMHaCYWZS9oIL/slvwsxk
         AuIyMw4Nj6ck0/ZcwclsUAt77U5uIHg5BOHCtGnKxUISzYp2JA9Vv42HRE8xx7Ud4bsH
         bs5g==
X-Gm-Message-State: AOAM531yVsZtjUUfaJpol8NicIWGgcg1L9Zvemz+5wVFU1rXUsO3LzU6
        Z2WVGGOnS0XaL40eVqe/LyVOag==
X-Google-Smtp-Source: ABdhPJwGIqji6s3zacMAWeqXla3l98z/pWCBDGhkEuQcaGBgPmOMaEkTtlzddgnI4tQCwrnviy/2iQ==
X-Received: by 2002:a1c:6445:: with SMTP id y66mr757245wmb.12.1598949529415;
        Tue, 01 Sep 2020 01:38:49 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id d190sm911260wmd.23.2020.09.01.01.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:38:48 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>, Al Grant <Al.Grant@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 14/14] perf mem: Document options introduced by Arm SPE
Date:   Tue,  1 Sep 2020 09:38:15 +0100
Message-Id: <20200901083815.13755-15-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901083815.13755-1-leo.yan@linaro.org>
References: <20200901083815.13755-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document new options which is introduced by Arm SPE, the event type
'ldst' is added for recording both load and store memory operations;
and adds the information for '--itrace=M' which can be used to
synthesize memory samples for Arm SPE.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/Documentation/perf-mem.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
index 199ea0f0a6c0..2455d485044f 100644
--- a/tools/perf/Documentation/perf-mem.txt
+++ b/tools/perf/Documentation/perf-mem.txt
@@ -38,7 +38,12 @@ OPTIONS
 
 -t::
 --type=<type>::
-	Select the memory operation type: load or store (default: load,store)
+	Select the memory operation type: load, store, ldst (default: load,store).
+	The type 'ldst' means the single event can record both for load and store
+	operations; on Intel and PowerPC systems, the types 'load' and 'store' are
+        supported but misses the type 'ldst'; on Arm64 system, it uses SPE AUX
+	trace data to generate memory events, so need to specify one of these
+	three types.
 
 -D::
 --dump-raw-samples::
@@ -84,6 +89,9 @@ RECORD OPTIONS
 --ldlat <n>::
 	Specify desired latency for loads event. (x86 only)
 
+--itrace=M::
+	Synthesize memory samples from the AUX trace data. (Arm SPE only)
+
 In addition, for report all perf report options are valid, and for record
 all perf record options.
 
-- 
2.20.1

