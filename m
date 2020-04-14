Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E67C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 437AE20656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TgO5s5Ul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391986AbgDNW3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391879AbgDNW3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:29:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1217FC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:29:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w15so13455571ybp.16
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 15:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l6V3U7dW8FQhAMlxw/7mM2Vqfwhiq7K4HBOf1qSKOAc=;
        b=TgO5s5UlJ4/uM4wFtCJu+NZhbygclu6fzmMpGxb7r8iB+bVsyfF93x3MCJiJng41a2
         XW2DQAM6muv6LoYuZLZR2THptu7UyXK91c5F3EaSrki8rAjxngCuauqEOKSdS5z/GiBg
         r/W6Tz5i3bF3YMbR4AkNHbxkkbe4kUWuwNQtP6uO+HUKqV3VSo8ZasgbqmFraTHmp16L
         gpyRpWOppi+m45gu6ic/M6kS2dP2MBZTI7ofRhbXtoyHNUUL2N3ypX1wL1wlMGNaD/mb
         pElTUS3oFTuv95xIzzPEhI2zGh0WGnUK3jnFi6ibsG5TJgndNVM01/q2oH0g5lZniq80
         VgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l6V3U7dW8FQhAMlxw/7mM2Vqfwhiq7K4HBOf1qSKOAc=;
        b=Lq32oBhKR1efIftxRVxacg0JZLTFpJawuWwAQrfjUVODHRCfSAm2RYVk8uLWMnbvGb
         NLv6Y9KEoxFa8U45YlVpBzthSF47nXwFxMD1H6pUREM8+qaLXlHvP65RcgrhRbd+U7h4
         9hTei/XlmKJTUTYPIodf0xErFnUAqUSchI3NhhcdYqhRpCtx1w3WhDHc5p+EPUkEXy5d
         wn+2ugJOHcOlmtcwsX8c6IIC0sL+5WlSyg9g5mdVWzTJT6WT1kOYdjcODeugjB0ke40C
         76y+IML+uAWaMTAZ5w5Qy39orT97PrKJ3KYSyXAIX5iPVW0nbshF07MywtmJCFmp2nWh
         OeYQ==
X-Gm-Message-State: AGi0PubgUmJ2OL+fYlL7xbr6fRH/tc0eZ3srFJR9veG5Hpup4yvg4Jqf
        7OA/S5hMznEP9xit3oYNJkTQmDuq
X-Google-Smtp-Source: APiQypL5Aab2OXLR0AADmfFVydjCRo8x7V9fXaPyOfYZpMTdgU3TdbJPRm0yywzOHB/u0WgTotFsa0vh
X-Received: by 2002:a25:d382:: with SMTP id e124mr3666231ybf.162.1586903371782;
 Tue, 14 Apr 2020 15:29:31 -0700 (PDT)
Date:   Tue, 14 Apr 2020 18:29:20 -0400
In-Reply-To: <20200414190351.16893-1-brho@google.com>
Message-Id: <20200414222920.121401-1-brho@google.com>
Mime-Version: 1.0
References: <20200414190351.16893-1-brho@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: perf: add cond_resched() to task_function_call()
From:   Barret Rhoden <brho@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        syzbot+bb4935a5c09b5ff79940@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under rare circumstances, task_function_call() can repeatedly fail and
cause a soft lockup.

There is a slight race where the process is no longer running on the cpu
we targeted by the time remote_function() runs.  The code will simply
try again.  If we are very unlucky, this will continue to fail, until a
watchdog fires.  This can happen in a heavily loaded, multi-core virtual
machine.

Reported-by: syzbot+bb4935a5c09b5ff79940@syzkaller.appspotmail.com
Signed-off-by: Barret Rhoden <brho@google.com>
---
 kernel/events/core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 55e44417f66d..bcafd7b992b3 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -95,11 +95,11 @@ static void remote_function(void *data)
  * @info:	the function call argument
  *
  * Calls the function @func when the task is currently running. This might
- * be on the current CPU, which just calls the function directly
+ * be on the current CPU, which just calls the function directly.  This will
+ * retry due to any failures in smp_call_function_single(), such as if the
+ * task_cpu() goes offline concurrently.
  *
- * returns: @func return value, or
- *	    -ESRCH  - when the process isn't running
- *	    -EAGAIN - when the process moved away
+ * returns @func return value or -ESRCH when the process isn't running
  */
 static int
 task_function_call(struct task_struct *p, remote_function_f func, void *info)
@@ -112,11 +112,16 @@ task_function_call(struct task_struct *p, remote_function_f func, void *info)
 	};
 	int ret;
 
-	do {
-		ret = smp_call_function_single(task_cpu(p), remote_function, &data, 1);
-		if (!ret)
-			ret = data.ret;
-	} while (ret == -EAGAIN);
+	for (;;) {
+		ret = smp_call_function_single(task_cpu(p), remote_function,
+					       &data, 1);
+		ret = !ret ? data.ret : -EAGAIN;
+
+		if (ret != -EAGAIN)
+			break;
+
+		cond_resched();
+	}
 
 	return ret;
 }
-- 
2.26.0.110.g2183baf09c-goog

