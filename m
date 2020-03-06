Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72FDC3F2D6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD32F2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKbC/jwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgCFHLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:11:25 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:37976 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgCFHLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:11:24 -0500
Received: by mail-pg1-f202.google.com with SMTP id x16so746247pgg.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 23:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EFDfR47gVlLUvIlHBB9ZAmoLLzU3NF/d8WQj5hzKyHo=;
        b=TKbC/jwdyYv1AVpphT2qIfMJnibF2h+da7mI4c7IZwHc4kKNTX59AwQKCAstOljl+X
         P6xCr5RpUP7HajuaXTaRcS91/Hood11aMU7xA7f91w93fBVa7J4fcBIgXvPOH4o+Ibl1
         6lN8teMLu916djOTlPKSl4nkTDfQGK4u3CIfvyiR2HXsJHGmYLBrjy8EcbAiU3+E8CUV
         pcsCUVTVAqRnJdaVTGvHdfx+J97IQy9nF7Zheifie8V6qgrIq/l0kpgN0HgsN382VbN6
         CkjdvohA5imu/t/uLJG/MdwiYb4kvqGCNxrS66qLnKCmUU6wFom9cOkrlX3+iegvI2+G
         Frqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EFDfR47gVlLUvIlHBB9ZAmoLLzU3NF/d8WQj5hzKyHo=;
        b=qPbCSIe+J2kkeWh/zxkI563HLBWre/qn89M9Pnz8Ms5mZYSnAK7TZ/2pUxgxP41wkM
         MgIbGPBIxjyqu98ywAMUBmnr7Dmtt2+/KoU0FTAteo4DXgOdwRlruTyroWTRFUMt6j3C
         XWwvEFLsDUrmAd3GWJV8RIaYRyaRsL9V9B0aIufobYEe3dCR4rF21Xy3Sb7bpN2EyY7w
         Jm2kf8FelluIUy+a0RX7krcH1IocdDEkJVKfCZDfnB1lugxudf9cPw+9JkjwWCrs+N+j
         MiRdBAvg/ioLkvGmOtsSDHXggoGpXyntDiTstG0UGyF154FeJC2VBMHRIUjn+npO7oap
         C8pg==
X-Gm-Message-State: ANhLgQ1SeQlmBHFaoeck0H3lXO+m9gOvP28dw5bvC5RFqwjoHIJBrToj
        rbER6gckEmyFVyrLjAJOs3dnllkNy3qf
X-Google-Smtp-Source: ADFU+vvFuzx3B+d6LQnmdYqxyJwh3HYJldsluKMp8OcS2ZT9Cj0+tab19zvn83gX1Ql9j1PJzWxX0vxFrI6d
X-Received: by 2002:a17:90b:3542:: with SMTP id lt2mr2063138pjb.96.1583478682961;
 Thu, 05 Mar 2020 23:11:22 -0800 (PST)
Date:   Thu,  5 Mar 2020 23:11:09 -0800
In-Reply-To: <20200306071110.130202-1-irogers@google.com>
Message-Id: <20200306071110.130202-3-irogers@google.com>
Mime-Version: 1.0
References: <20200306071110.130202-1-irogers@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH 2/3] libperf: avoid redefining _GNU_SOURCE in test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Li <liwei391@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

_GNU_SOURCE needs to be globally defined to pick up features like
asprintf. Add a guard against redefinition in this test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/tests/test-evlist.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index 6d8ebe0c2504..5a5ff104b668 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE // needed for sched.h to get sched_[gs]etaffinity and CPU_(ZERO,SET)
+#endif
 #include <sched.h>
 #include <stdio.h>
 #include <stdarg.h>
-- 
2.25.1.481.gfbce0eb801-goog

