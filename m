Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAAAC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F2602082E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 15:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOyaXBeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbgEJPKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 11:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbgEJPKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:10:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1B8C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:10:43 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a7so6499937pju.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DdKThAFo5i3EeaIla8I972Z4kJMfuus/AHP62b9JxPE=;
        b=lOyaXBeLH2SzZd1X/R44gLrgCWdolRgZ3GDKTHUtwUraKQ7CH4CrYghTs0Q+2i9h7t
         sOzG5gBedKzKilGr8qjVUFbNI1pc/B3oIf+c7NiEVbsny/E/EqGQY8nVGplIrskHUaim
         b+vyNJ9tWLfBAImJ8cV3tb8upWNGOK+EgU0kJtw2cnBua5kPF13wxzSJawlAPZx4GXkB
         fZRB+aDNwb40D+5MyFG9vUMIyAHAo90LRmx0DF2aX0Afs1GukLT00SApAGhVUe9BNmfX
         2d/0tB1SxsESt4kjSpIoi+iWqJIsQs20BP1QJokLz4pOoSB+P2l9rv8LUUZTUcz/rzcQ
         kXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DdKThAFo5i3EeaIla8I972Z4kJMfuus/AHP62b9JxPE=;
        b=JTf0vnW/pLl4ieZ23HnjJ1nu87M8hX71l17PbDGP+cXrexRXZK8YOwvOipJM0lukyC
         dxmTJZRVEdoe9Bk/9Dw4aff17H+GFmsu9jX6uSHkI5dsu044mivdY+UutP+YVdhiqCU/
         mD4N1doR6ff1Nqfht3x8MM1L8ytRiXwRdc+h85eOdoXf3wg/htTAf/D2CYnD4dCDKHXy
         9ubF+E0syOjllXLw7I8SUqeqROySpauAyUflQuBjxxXfFUwFz2mwOmfL/9KvTH6JEJQF
         NaarTW64X2QI90zkPVm4qyv6HrPhepbKo0akxdhtgXgb8kVcTcXP4s2MZv4NsG9BRPD7
         S75A==
X-Gm-Message-State: AGi0PuaqDnMq2l7AUj/MCvACT3dkc8X/1EoguMQF29gN10R3lrUveZ+v
        b5+hSxjv5jUmUw5EhzZsnmI=
X-Google-Smtp-Source: APiQypInqi92M43bcl5lj8erSbyMpJGNfWsaVGxGzwpHpCfeb8QFpRkvi0iX5o/oH5ksrcVKuy52xw==
X-Received: by 2002:a17:90b:2388:: with SMTP id mr8mr17507309pjb.107.1589123443415;
        Sun, 10 May 2020 08:10:43 -0700 (PDT)
Received: from vultr.guest ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id v7sm6870909pfm.146.2020.05.10.08.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 08:10:42 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 19/19] perf ftrace: add change log
Date:   Sun, 10 May 2020 23:06:28 +0800
Message-Id: <20200510150628.16610-20-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200510150628.16610-1-changbin.du@gmail.com>
References: <20200510150628.16610-1-changbin.du@gmail.com>
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
index fd8e2f305136..8170746f94fd 100644
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

