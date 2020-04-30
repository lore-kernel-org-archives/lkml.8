Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF26C83009
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A096C214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iWfP66op"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD3HwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgD3HwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:52:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F61C08E859
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:52:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d206so6781602ybh.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sO5BGMnC3muRvVqxOCgNBH4Ftq8H2ieY1lBwILjyo+Y=;
        b=iWfP66opqu/6m9OFsmapPj7vQ0nAygVMj9AbB6MvVz6Lqwq67+pWxjJvmy/O2QxSb3
         F/OyHjxRGoemdnQre4MkndxjuT2DWeWyERGvGEHpYSbwMyp2kH3Z9uIASIq7J54IP3Yo
         BSg9OPhFoNEDTfE1HMDm1c3pKWHMfsFT6GQzhIGyV+hx/iW034Gn4FsHED1Ryh9NOKsT
         lXROzQux6Tv72xaRsiXww6ngAWYRJd89TrldaggOQFj/rGqeIk98YL7vdov6S84J20Sh
         EbDTa0B470bgw3GHsb7vPt26pn3VGyT3u43FUmurK//qrJo8gMxGVGYoOaMelM8e2VnX
         aKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sO5BGMnC3muRvVqxOCgNBH4Ftq8H2ieY1lBwILjyo+Y=;
        b=LT9ifMv04rYj/YawiB3CgZUfAysl1Q0bzOUHqZyClCioebCi4oVbKPk4VRC0rW/lh6
         xEdMcGdPukxBMRS8iqzET4s20o6MO0GLpgx51rHmXmPLL+9O/RAWnrYIRnTkam/tLjtT
         Qie71kxw1c/4u0vpoE6MQ9/vbePoxGSaS2Y22Af1cCyyNTp3XLYaWqTvqIq3LDMCysnc
         O3UJi1kWLFGZNo3ybm58eG2aFRi6qQyYTIYJ8Cif/94ba4nmCnSNM0o1hkUpIe1z87h+
         C4+DCDsCT84Zf75BD4SLhSVqTiDak7Jv7wWPkNcavoa/wqZYAftYoY1Yy/HrHEx7h6Sf
         uVAg==
X-Gm-Message-State: AGi0PuaYNOt5R3Z00c0zki25fIv5hc820jgf2Vkh697q2n/0Mqfnnq7r
        XLWAfgpFTbTgMnAgsa4caROIiKImiyNB
X-Google-Smtp-Source: APiQypIn3eB2pOEd0OmoPGLUSkobU3LKaOPQtkbK940g/ZkTpZU/FcUZaeDGne+OEryY+ti0RqD3HYwyELUk
X-Received: by 2002:a25:6b06:: with SMTP id g6mr3682977ybc.506.1588233120753;
 Thu, 30 Apr 2020 00:52:00 -0700 (PDT)
Date:   Thu, 30 Apr 2020 00:51:39 -0700
In-Reply-To: <20200430075144.132716-1-irogers@google.com>
Message-Id: <20200430075144.132716-8-irogers@google.com>
Mime-Version: 1.0
References: <20200430075144.132716-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v3 07/12] perf expr: debug lex if debugging yacc
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

Only effects parser debugging (disabled by default). Enables displaying
'--accepting rule at line .. ("...").

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index c3382d58cf40..8694bec86f1a 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -44,6 +44,7 @@ __expr__parse(double *val, struct expr_parse_ctx *ctx, const char *expr,
 
 #ifdef PARSER_DEBUG
 	expr_debug = 1;
+	expr_set_debug(1, scanner);
 #endif
 
 	ret = expr_parse(val, ctx, scanner);
-- 
2.26.2.303.gf8c07b1a785-goog

