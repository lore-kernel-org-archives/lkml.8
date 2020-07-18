Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF65AC433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B342C20724
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 06:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+w06+08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgGRGvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 02:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgGRGvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 02:51:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5BDC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:51:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc9so7481474pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 23:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F4H/ElZZ4sihq4Yns/hOmCv5Nr8HG3u3hNrN0OJ1/Hw=;
        b=o+w06+08v61QtTYAKZM55o1vn6pvQM8+uKMEM2BLgxy5oe9Baepuv6i8DS30MaNDaD
         XB7G8fJjQVJkm5H00/Bpyy1y61dYm6RUqulyD+Rc4XLEhFkLZpH2l+OKhRIyfrDiDQKL
         G99Hw9cI4hjh9qvbT9aSQ1od4Yk0FBEwbhp8fkwAC6Wn2dK2y2OxcKdSo/K89lh2hg59
         /vMv8L5iB1f/fnOZ6G+JN6H8GEbVW7kEAyITQbn/yBBNTDbr7fvHQaifsnLlXJeR9kVq
         Vu4S+l992sccj7qDPDLWQGkZlJkTJ+VFxlsZTYHYzbbtyT0eIBjYpvgilxDRGgC7T5CY
         YB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F4H/ElZZ4sihq4Yns/hOmCv5Nr8HG3u3hNrN0OJ1/Hw=;
        b=lauuQmEExRu19+6+ATzi3B7VE10zZAFHWnl09ukbx/iXrTny0TPHyds/cCe89eZVwF
         bcwxWbzSe2pt5tu1X0/X6iIQZ5ux0A4i5poBdZqOkbBiB1CCJnMLKd+3DVQfYG2kyDXv
         AaXcfT8dZ6tiZT1mRTkUGZBZIvDUAD/uq1XPcczuLlTWjkPbH98uauVKsdjeVmfjjlKI
         stTa+HmzzNka02X6/uez2utdRW5iCkIV+L+R6n0OsXEjISDPJfYLZFyKP6F1lei3QfQl
         +AAfoOom8mZUc0d9lCFd0NAj/C9mzbENLvJaRJHQ4lqfzzwRagW/pwSz9I6bSaR6ch1P
         wc/Q==
X-Gm-Message-State: AOAM531arwjyBilnjRugH62YKWO35vkCw/DURKn9H8xU7YfKHcV85GK5
        zaHZ2W6nP9wS2soQ1/OOrG8=
X-Google-Smtp-Source: ABdhPJwTAAJOvgFf5Mm7j5IWOU/8eQNhjAdZ4Lf3j6TJV1mxWGNuxyhgrCLheoKVrmC+/77vE6Qb6w==
X-Received: by 2002:a17:90b:3683:: with SMTP id mj3mr13220992pjb.91.1595055072592;
        Fri, 17 Jul 2020 23:51:12 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id q10sm10422781pfk.86.2020.07.17.23.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 23:51:11 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v7 18/18] perf ftrace: add change log
Date:   Sat, 18 Jul 2020 14:48:26 +0800
Message-Id: <20200718064826.9865-19-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200718064826.9865-1-changbin.du@gmail.com>
References: <20200718064826.9865-1-changbin.du@gmail.com>
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
index 4551d4d4bcc5..9213fb9777c4 100644
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

