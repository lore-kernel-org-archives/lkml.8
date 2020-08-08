Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FC9C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6C922D00
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E45zHX5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgHHCkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHCkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:40:14 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAD2C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:40:14 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b14so3523211qkn.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 19:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THhj5iFgWxMtNikoc3f+QCgg413Vgg00KqaUvNNzEkY=;
        b=E45zHX5vwbMaCrwetlsgJ6s8EnHVNXJyYFVG2Lky5qfYew+OdKifOYA0ucQCH4Gy8O
         cSDh2btQfvJSCW/IC0mmyInX99QzpgIZstsSlfjN2FJM+19ktU+euDedifFLRwzoAxOf
         GbBDRej5K9p8w6Kdv+RiXlH9RN5NJgU73fxEFIfXpazuwxLpFJToURIkGqFpxr4NY9hV
         e5nv8kVgs4t9jbIF+3MT3ZxWwSXsq+u6yxxD1RDIVeZq1rVOy3NVtvPKeqjXJRIoseSB
         8lbOXu8cge0kf1V3ehyAZuIdJgRmP3wYmjA49R7T7VnaE8Lx6Ct/8LSBS24UzQ3fFjjh
         WheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THhj5iFgWxMtNikoc3f+QCgg413Vgg00KqaUvNNzEkY=;
        b=FlraYtaEErGSgv7JRY8gRkEE0qk3kc+HQz67FdcDsBrSBaWOxh5QE0g3ua+zo8qmYz
         wGnhR2waNl1L+mD4+WEqePlu+xoixnhGRtgPDhaPIrMmAl/dslwjGMAdeawsmL1wZkAq
         9JN72hJ7gicCuIeDnYoG1UiMHEOtumtEWR6YkIBRsTiUad9Kls85muWuHaYG3J1xmVPf
         6tKCrkjMaa/fW2xNh8zYRwZlHmBdSPU6OLes54bkEfcwLbETULs5xIN6n0ATNPEtipz+
         R+ZUlsr70c8N4Gvwm0vmWbHtWVI2bD8G6YsXqYk3j+KNZnDgfDCTkrfx1oeKYxsc+cxW
         YLVg==
X-Gm-Message-State: AOAM533oYUzz99auxqLnG0rmBi276pPkUidjlJj3mRSbzDF+BhjIMkDp
        NA66FLIbtjqLL93CtkuXdSk=
X-Google-Smtp-Source: ABdhPJyLeEh/V+Y1ZDAYlfmsGOv0x53Ws9Q/Y0Ai/3QI03vadXxLt6UePQN2KdYx4OxmL+39008x4g==
X-Received: by 2002:a37:9e48:: with SMTP id h69mr16850650qke.249.1596854413685;
        Fri, 07 Aug 2020 19:40:13 -0700 (PDT)
Received: from vultr.guest ([66.42.85.36])
        by smtp.gmail.com with ESMTPSA id n33sm7818702qtd.43.2020.08.07.19.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 19:40:13 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v8 18/18] perf ftrace: add change log
Date:   Sat,  8 Aug 2020 10:31:41 +0800
Message-Id: <20200808023141.14227-19-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808023141.14227-1-changbin.du@gmail.com>
References: <20200808023141.14227-1-changbin.du@gmail.com>
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
index 9da38dc8b542..167f1f57aba3 100644
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

