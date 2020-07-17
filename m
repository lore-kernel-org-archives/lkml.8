Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F318C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36DDA20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up1N9x1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgGQOjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgGQOi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:38:58 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CC2C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:38:58 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t11so5460387pfq.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nXezF5jJMP/dgjGdNrV9oT3sL6C+VWCPHOSSzy8uOcE=;
        b=Up1N9x1N91TMncSewDheY6XcgP2CR4ewAHLl1Jp6YOqoR5TMknHIWmEgye4ODBiYFt
         ycSA1wJGNlP+BxX3y36ajb8ES06dEOnuPfG2twI3Buc54rFoVjbcqOn3DYisAaJTRwSP
         8CHnCQaUDvfHgFzv6VNjontfp+sMSwVrSISf7OsgJBMKLRu1oZsQQtfMCzk2VQCVWyJw
         Gg/Rr6bpVo7vBPmM7o6/qGu/G0RToI9eSScblOq2JyB/jEARN6EwO/Z9GvhOXiAOU5bq
         bem3XdG/qBLvTZ6x0HmFWijdoj6tgn9M101spxJsVll9dIb4EWSYUwTB0Ai4067P0JEJ
         q5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nXezF5jJMP/dgjGdNrV9oT3sL6C+VWCPHOSSzy8uOcE=;
        b=E+J6sCP8PNAKJ4dsEXigrQXOJfDTN5XfGuQ2vQ7DoqtXAiB3ANg6FgbSVNCjdD/dlT
         7GJbU0b+lNXzNqYm+UHIxekTz50uZK0zbR5RQSU4TznDjPtzvMUihSmDU0hTaX+KFbcx
         v3gzoiykAi6gT60XoR2nr0sehPSRFpsnFKr2ltx4aGVJLOzZrunPXjaWRKyIDYLPzL46
         zNYHvQffgW8V2rjfKLh5pFch58oJmPLE1EGV7JIX2g3w14WFzlRYn+PbTw0wtEEpqEzt
         TrwZqAa/MAdg4+552Z0s8StFIz6tfQy6E7+c0VItNGIPQGxBjy/NwoRUL5tznpjcaUNt
         625Q==
X-Gm-Message-State: AOAM531alrA9N0YJbTgpGF2zYgvOE74DReAOdp0KvMcqvlVGMnWtJ3Hv
        qo/frKmuSW4yEDUBlhsrVUWRu0/edA8=
X-Google-Smtp-Source: ABdhPJxKtzA/B30/neMItGQK1Aj0I4xGjsZPMeuMaMsTMcSx0+p+FQHhLQqFV0lwev7CEzMwLRvvYw==
X-Received: by 2002:a63:2146:: with SMTP id s6mr8797077pgm.411.1594996738288;
        Fri, 17 Jul 2020 07:38:58 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id a68sm3214689pje.35.2020.07.17.07.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:38:57 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 17/17] perf ftrace: add change log
Date:   Fri, 17 Jul 2020 22:36:28 +0800
Message-Id: <20200717143628.47721-18-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200717143628.47721-1-changbin.du@gmail.com>
References: <20200717143628.47721-1-changbin.du@gmail.com>
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
index edf307f7d716..326fd03396d5 100644
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

