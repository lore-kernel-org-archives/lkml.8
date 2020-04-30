Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D1E5C83006
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DD202082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKO8TYUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgD3Hw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgD3Hv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:51:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96AAC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:51:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h185so6779068ybg.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YbCEU+/XsZxx/Rjj0tjknUqMeudJ748gHpjse82lZTo=;
        b=ZKO8TYUmzjvuaszWFSk5LRgsC1xtDSx7sjoZwDgCd5aca3k6KAUVsSwLx29dP98UJZ
         TVp6bm3kYhN17S9kMry6kJuq8T+6nMtw78WDVuAzix4QvEMSC4zWlFl8MgJOguaSw4hL
         cEhnggLhuT4P0D+y2IYhExF0GAnL5VIT1UepqTbU0U9B+Yu2ij4dmGfMW3aUMOc8vGFO
         Q9cOhRiE5D+tyAJhtgxhXXOHwEQGGXuRCaUjsDPFIb9h0OzkFfx7GOZMiw74HY+14Fb0
         PF9rry1TH6cqPa/+cULKhHD84Jm/Yo3uBEsHFQazLphg7uIW5Slo770R28RfogKC7p2H
         a5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YbCEU+/XsZxx/Rjj0tjknUqMeudJ748gHpjse82lZTo=;
        b=tYHgrd9ZUDCsbRD+V702IuJlhT0w032wmn3APUcXKsYZiNl0Bn/WuVNuey/Ju7PPgl
         u1cC1aOtRKUlriTONyLTTARddo+jjwAcQdz8BMVMsHT1wwGl990rrwEnzraaJtcQiQNk
         9lAR7o3fkyaAnli6JSHqcCZ2dGKLFihqP5csN6vvIsL06MwxET48Rtx18GAPO/0WQVp2
         xuM+1/uQJER7Yx1AC+SBKSWdso6Nij+AZF1joPhSZ9FT9zh51oMod+Cq5ghIMZ1K77MW
         sG/HJICxXKRFcfiIA7B3nhYyFbs7eZr2Yfk0b2JNGW91ESGRokYhIPydg+lwYT0K58VH
         OEIw==
X-Gm-Message-State: AGi0PuYFvWkAlnQPI7y4eVLRMWR0UhGyBpWROKCFwya8uuLUWKW+nVZ+
        csbLAEK/ND/fA/KNEEf6/xfkZNfa53yS
X-Google-Smtp-Source: APiQypKOwjk9/1Bbl0chZSmyL5tt6ggPNkBkMaGCcBnLAuCskkQeb1J8OjR+CaI9kWJ/Pg7tcCl25TNF4B86
X-Received: by 2002:a25:b8f:: with SMTP id 137mr3853386ybl.21.1588233117049;
 Thu, 30 Apr 2020 00:51:57 -0700 (PDT)
Date:   Thu, 30 Apr 2020 00:51:37 -0700
In-Reply-To: <20200430075144.132716-1-irogers@google.com>
Message-Id: <20200430075144.132716-6-irogers@google.com>
Mime-Version: 1.0
References: <20200430075144.132716-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v3 05/12] perf expr: increase max other
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
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        kajoljain <kjain@linux.ibm.com>, linux-perf-users@vger.kernel.org
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

