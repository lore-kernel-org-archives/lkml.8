Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BB8C433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20244207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 12:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6QZZ99D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgGKMnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 08:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgGKMnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 08:43:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA26CC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cm21so3753128pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/sDO/bktxFNa0OYFczpZJ+pdAkpXrZFnzzqBw1rna8Q=;
        b=d6QZZ99Dsl79jmS6rJpS+z1ziMx6c9oJEQdDsbTPQBymg3g3pBoyDL2RqvMoK3wnbH
         mkkiJrc4K707rZc1aA4XA1pWIWjamPBYta1Wf7LPUD18W+iEFMg6eXYCQWZ0Vwz9zAcq
         Qf38rLWjMcX2K7GE4/tbP+eL/A+geMron2DD9lNfpNWVrSAPaV3qJX92OXEf9rHLxVDO
         WE1TWUuvOkjp17omv83YCbOtdLEEc6enOXaLtn9sTafEqfLmokBrlowJDUKTaEnw2YfP
         6xwVLPdHdZpqvRALWAE//Re58q5LGgNHVbHOmXCtNh907uHa4OM5u+zzbp2vH53lXbCB
         bSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/sDO/bktxFNa0OYFczpZJ+pdAkpXrZFnzzqBw1rna8Q=;
        b=PhbZx1/4WlKbcpWE9YT2M1qoCh9Xdj9/OXC52vMF8bB+HySt8anI8lBp8vMLIFmAQr
         4A05WYjSoU0pVkwFcYjF9a9vLbw+wz5f+vb+JyHDY5ZorCKh9cUfUt5ebjCz59LKnNcS
         iejxBkHvrt9ajLMaY4M4y1LT19qLLit68uqhGcRglcj4RkrlE6e6hzJcKeDA/6oYDMKO
         CITCjyOLyHcKEtKk1mvnpwT2+3NocKeQ5BZLe9MyWAqnDjsXsbqtjrIHgn/vqxPxRfF0
         eeqzZtmfSkhe4UZeU+DuymrQOYoIJeSlufclrrv2gmqXfhw9VRkXXZ/dT+PyJ8bhSy/s
         M3xA==
X-Gm-Message-State: AOAM533nJo6o8/6WFjkd31rwzKb+2qTvmAgFZMYMnowu5Sdcm1ikZCrL
        RyOl2FmCboJo3kHgE0KIo1g=
X-Google-Smtp-Source: ABdhPJyLwTSNYTecIe8Hp29+ZdX71bObnNkXqYjsaeAasRvSB+lY4h1cqqR+FYaKlmVwzHM4aWu1dw==
X-Received: by 2002:a17:90a:c28c:: with SMTP id f12mr10632608pjt.224.1594471432491;
        Sat, 11 Jul 2020 05:43:52 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id c19sm8352899pjs.11.2020.07.11.05.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 05:43:51 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 17/17] perf ftrace: add change log
Date:   Sat, 11 Jul 2020 20:40:35 +0800
Message-Id: <20200711124035.6513-18-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200711124035.6513-1-changbin.du@gmail.com>
References: <20200711124035.6513-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a change log after previous enhancements.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index a70951938308..56dfce646d30 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -3,6 +3,7 @@
  * builtin-ftrace.c
  *
  * Copyright (c) 2013  LG Electronics,  Namhyung Kim <namhyung@kernel.org>
+ * Copyright (c) 2020  Changbin Du <changbin.du@gmail.com>, significant enhancement.
  */
 
 #include "builtin.h"
-- 
2.25.1

