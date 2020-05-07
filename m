Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D037C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE5792084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLwhxmxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgEGOLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgEGOIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:08:34 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78728C05BD0A
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:08:34 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id v18so6842409qtq.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8gUq3gZyaZ+fW8XLtscPZL56CqBcOzYoWmQ7LuAcGtI=;
        b=FLwhxmxE9Kn4GfmG3U0Yu/lCaNdW9kqc5eEffkTMYlq/SKBA3xID+QyQlgMVnGZpKT
         1IVUVw8AwjP3otNHvUElNrbz+jFr5KZZcYsXD5Voy2RHdAYqhcA32TncU80mhVoJq/RI
         gRXz5+FThd7TkwHO5sGBJvyrx6VImw+GqXJMLdt9mGZpVV9U8QtsQWp+Om0zJNssRyIC
         w7JuUSiWokcGnQqAcRjWv9Lm0PbI/SQmlFHMH+LXozd1NnyZO1ecYk6EIwJiQFPl1IRE
         TGu1VmFv7sLEhafn2v43RJwToe0dzQfULG1451Ok9KrizD2ONEPyDOgtRRhIJfckxgHf
         jowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8gUq3gZyaZ+fW8XLtscPZL56CqBcOzYoWmQ7LuAcGtI=;
        b=B0YmpFNQ86VrN18XHoQRFhFbIr4MlWYPhudh6UapZ56KQyQ8+BOVu7e3o8fFb84OWh
         +8IY574AWPRroCIxvhR85rQvLvGpjQ2vwKG/cgZ6ULUfe5am/mgyF7AiaFaaYFHw0xD9
         mBoyTlsRvbLHOs3SSDGxEEPCYCHIqGa+Ap/y+Ri4y+LO9veD219CEO9rQru+JS3qaVbs
         XruiFj/yI6IuTHA73YTnStCWZEYDco19CrCBwsg+ezAtlLPdQayHhldW/mdpRB9oMg6y
         JUBTJoRo8yKPsReVq1f/irqqvD0jMpN25/52+xeOLGyEcNwKR7JnbPMWBgLM/iSAbS6l
         0M+Q==
X-Gm-Message-State: AGi0PuYp5+P5LGI5V1J2AXRt+MSwEtkMec73+ZbU/hKZ8KGinhhzej+p
        t5Re3a5lQLS224p8gNPufqAIkggyhgnI
X-Google-Smtp-Source: APiQypICenctDKpj6LjD3iDGO0rD+FnV+zbkXnX+hjhzB2QyYx7BvIYqsNnoM/UlfDMRcSCq+58JuDfWQxm3
X-Received: by 2002:a0c:aa51:: with SMTP id e17mr13227862qvb.95.1588860513634;
 Thu, 07 May 2020 07:08:33 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:01 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-6-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 05/23] perf expr: increase max other
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
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
index 87d627bb699b..40fc452b0f2b 100644
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
2.26.2.526.g744177e7f7-goog

