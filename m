Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF7BC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46A4320767
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4BDeNe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgDVHsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726524AbgDVHs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:48:27 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2888EC03C1A6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:27 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id w3so1305703plz.15
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 00:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YbCEU+/XsZxx/Rjj0tjknUqMeudJ748gHpjse82lZTo=;
        b=E4BDeNe/FN965SuuyiCmlWsJ6CcW1p6ZwXf7V6gPISkBiSkBrjQP6Z8UED+oDS5rZV
         QFmQVtI8oXELCrKzpG+OQzWd5ov5j5nOCaRgCkmeBYysKNgueLFxMoptHfEicaHal6mY
         /eBeLBU0bInMUJvPCKTltYBUdRIinLmY3tuZFLVTcUXvJJiA1PuYQ1f89g8K77mn/EcV
         O2CZDic1jaxYJyQ00qqEG/NPkw1pI8M03aolEFQBfh+YGLxARNNuDLxTpp2e7oEliCc7
         XpKcj46heKfDiyHRYOAvWsjspW0bbqCtWMUamELWLSI1ExZcqawTRK0MgroKo+QhL3oA
         czeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YbCEU+/XsZxx/Rjj0tjknUqMeudJ748gHpjse82lZTo=;
        b=aHxWZNICq+NrS7xt1M+eNGpEo14nqRUVzAksISY8/iUGJcV5FA0PK5XZ1e2+COK1HU
         yj+N4oUPc5s5pD2bqvjg7LttriFVPiBAk/GDFU1jCi3xRmaptxVGeXTo3BnaJLAxjKfD
         JYZuuuesZFEKVuFfkqfo9drGOaBTKNWh5Z2EocBU4uSBPXBuAgciejPhto6rzHlUPjzj
         Uy9hSPPAVHWQsWseGGS3E7gzEoCsa7raG+IJW+49yGjRODXhPSAENEPeBe27Gj9GYkPv
         /vujoyCCQjhbmwriijf2iyl7I4umVxXB2s3A6iFySKw3MSPMHgwiQZ1QsSQCsYmJEq/l
         IAlw==
X-Gm-Message-State: AGi0PuagFJyz8aawckrK/n6PjPj8aeYcRDOuIi4Z287wNUtjJKsb8jwS
        FwyQPVfYEiTDuHIhi9doYMnvE6e2xmHx
X-Google-Smtp-Source: APiQypK5KXEyVnBJu4U/W3MnkjQIxEsv0a+GJ/hGx35lK8GgwVuRWZTMeNKb0LInOapi0w5F/WwZdlj7220b
X-Received: by 2002:a17:90b:3110:: with SMTP id gc16mr10110413pjb.155.1587541706701;
 Wed, 22 Apr 2020 00:48:26 -0700 (PDT)
Date:   Wed, 22 Apr 2020 00:48:06 -0700
In-Reply-To: <20200422074809.160248-1-irogers@google.com>
Message-Id: <20200422074809.160248-6-irogers@google.com>
Mime-Version: 1.0
References: <20200422074809.160248-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 5/8] perf expr: increase max other
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Large metrics such as Branch_Misprediction_Cost_SMT on x86 broadwell
need more space.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 0938ad166ece..4938bfc608b7 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -2,7 +2,7 @@
 #ifndef PARSE_CTX_H
 #define PARSE_CTX_H 1
 
-#define EXPR_MAX_OTHER 20
+#define EXPR_MAX_OTHER 64
 #define MAX_PARSE_ID EXPR_MAX_OTHER
 
 struct expr_parse_id {
-- 
2.26.2.303.gf8c07b1a785-goog

