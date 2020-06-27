Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247C0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF5B721582
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 13:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HD+NUZbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgF0Niy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgF0Nix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 09:38:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8CCC061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f2so5339915plr.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CJNHqa8gvcLLhfALNMkMRlCHFKoxj8TZvfmU4UMdGP0=;
        b=HD+NUZboFHju7L3cLkxvtPxs7weFWcnAISy5wk3hqIj4pUdGsKZLNLODE+32CU7pQd
         rPqyaaoWt+BhroPoapGsv9dGU9hrMp5y90nbF1v3lrDpCSXXx7KmjNjKfxeuWFv77n//
         TjGIU2CqPwwJxqgdnBSc1BJ05xn765SwejklRMHgcJ1gCHEK7zvG5tEeheXMK1RJx8WA
         fcZO7ZanVcVYELGCUYKGWaSbIz5eGys4D90ZTFoDCedRkmW2yYm/K7hW9l3qmXjbZAl/
         pgVV2vrQT483Py/vm0OTp9XM+fxzkx2SwZ7awY6ld6cDKY/TsBSlCqNgBO/XTh054liM
         UrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CJNHqa8gvcLLhfALNMkMRlCHFKoxj8TZvfmU4UMdGP0=;
        b=MZ1CnZtJFIncV7Thfd4BTFL0f4v8ZV1jbxhiZHYx5V97RrES29B7D31ITMt+Y/WGfb
         RadBHW8Aas9CKxfk9P6jhsHZS7C5vNlZ9WO6mPiCYZJ0PeKyl7NTK/xW5oLCSfmtb3Fe
         MglyPqV8RzqUM/M17qb7RZs6dxf74ca6ZaSCjAVGaFZQxsMMYxvaT4W38AreznnrBnU7
         meAqWxifWIweg4FfsFXGKXeEoZxmDerpfQDMepSBjCbieUxHlNfpvyWS+oMvfph3pEuW
         BX8nim0H3j1xxUm1SpMGFOCkgHH0jheZqjg8yvXne056oqbqLAN/zB8qIjLIlbjerbn4
         3big==
X-Gm-Message-State: AOAM532/OJ2xL4EQPy/Pv+rwiJigWPZlo0fWY7e+0xluuyOjgvIp6Uys
        I1dDKNgi6/0AQqmVe3isRz8=
X-Google-Smtp-Source: ABdhPJwVFRaTxXhMwPo5Xgv2yRikW8rqSlbwTtdcRs6qtcjsAlkmA6lRcFB+12Fn3RFj5FA2vU07Xg==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr6113812plp.299.1593265132982;
        Sat, 27 Jun 2020 06:38:52 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id x8sm15060086pje.31.2020.06.27.06.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 06:38:52 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 15/15] perf ftrace: add change log
Date:   Sat, 27 Jun 2020 21:36:54 +0800
Message-Id: <20200627133654.64863-16-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200627133654.64863-1-changbin.du@gmail.com>
References: <20200627133654.64863-1-changbin.du@gmail.com>
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
index 0f8716ea0da4..3d73809150c8 100644
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

