Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A715C83009
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D4221D7A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C1EG6HhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgD3HwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgD3Hv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:51:57 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309A5C08E859
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:51:56 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id f11so5607057qkk.16
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OXZleKkWZzKKnBm05g6e7Gyf0CCs6T7oZwd1F3IVZx4=;
        b=C1EG6HhUQ5D15iyeuJcwxudDHk6qhacqj5n4mQFO6tI0bfeP20qfPVb9ijMjXsMqWH
         gvW23rVkDh7/o/ryFZpKB2sxt0t3etH76T1HzskMlXKWtC+bGaw75xRBEK71EXbXALzn
         x794TFWnO0FxH/KFEaE6QvHkr1Va0gDyJQg7mAEALgcqUFxvB9RSv3FYI2VErZt22O6Q
         Gh9LxMLUDOatqBCpy8aPSpz+/mjqGIu9vWC3Ujog47tPs064V1M81xLBC/MZ0yJSM4+r
         QM/ZNmTnsgNlpddMRE7konL6s229HcJu7qJUlh/jGUayibM+l73NVUYiygWZ6fBDnehg
         bLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OXZleKkWZzKKnBm05g6e7Gyf0CCs6T7oZwd1F3IVZx4=;
        b=Ak3N5FnLG0haTYsOwPXeOqfCnN9WTJm+/lbF6mhtiABQqL1MR9ewe0s1DnfuArkTPR
         caxyngBWyDOyK6phJELtkg5MP9hfncFP7fK+3nqEgJ2Pcm2b/Vg7UYFsJFmDkJ3PwT3v
         QApvAbp59hUbdQhsXOjOT0xM6wg/3wWS5L2p3VW7Bixt8DXxy2AoJ7fZzYosbpGjttMW
         z8udd5IjjUjmY33i7Dqp4bMdT8d5JTjMbYb5IEECKy/PljPo6+36Hg6JOaG0h1eFEDUS
         vCqMI2dtRPK9PfgJRDnR4dK3wLgPuGx9nWiFNk5LN2AtvVX8mfJ58Y2mdJEUYDkcApc8
         RF7w==
X-Gm-Message-State: AGi0PuY6cQUFdI3AAN24sxtsUVaIld8EZu3bl6CRtI4TlrUCOSmScFji
        SlhUMzTmOhGpj7OSTNvsrprciK6aJKkS
X-Google-Smtp-Source: APiQypIojP4DrIlirV7kdIoUxGsRMdepHKr7XyHfku5l94Rx8mPKVgjFX9aNiU2zmgw/YI0mZckqIU8P9kHg
X-Received: by 2002:ad4:45ae:: with SMTP id y14mr1737378qvu.145.1588233115263;
 Thu, 30 Apr 2020 00:51:55 -0700 (PDT)
Date:   Thu, 30 Apr 2020 00:51:36 -0700
In-Reply-To: <20200430075144.132716-1-irogers@google.com>
Message-Id: <20200430075144.132716-5-irogers@google.com>
Mime-Version: 1.0
References: <20200430075144.132716-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v3 04/12] perf expr: allow ',' to be an other token
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

Corrects parse errors in expr__find_other of expressions with min.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.y | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index cd17486c1c5d..54260094b947 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -80,7 +80,7 @@ other: ID
 	ctx->ids[ctx->num_ids++].name = $1;
 }
 |
-MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')'
+MIN | MAX | IF | ELSE | SMT_ON | NUMBER | '|' | '^' | '&' | '-' | '+' | '*' | '/' | '%' | '(' | ')' | ','
 
 
 all_expr: if_expr			{ *final_val = $1; }
-- 
2.26.2.303.gf8c07b1a785-goog

