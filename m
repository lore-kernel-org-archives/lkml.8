Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAB2C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B952464B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 18:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nP+4sZ11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgBGS7T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 13:59:19 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:51336 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGS7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 13:59:19 -0500
Received: by mail-wr1-f73.google.com with SMTP id c6so107490wrm.18
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 10:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=nR+y9oL83JIGNZtIre6/euwCwaqJGCzYCr1D5UPHiH4=;
        b=nP+4sZ11+bPG7CKNNsIVXFVgJ9RV5HxfeJX1ANQYSQalovtR9KJ+XgtL6djX225oDc
         x58UXUaq7HZDzRZ9nuES1dj8iSUziSjL5xgYygFjwPUPyqzk7El3+awQLU3A7fBP36qd
         JKAxgMLGh7j7ynfzYadsnJ7oLZnz0TkreQkG1/AHWLk8eYX7D6bPHi9/EYzDpeG+oLKz
         SUW3eE0nnnW33XJ2+hRlc732/wuptyj6hsuyRwfbCVmA1ewjVa/FHEw1pVJNyp6toL0I
         nrZdkG5U4PQTwvH6xD7XH49QTFyX1LejcaEZ8zd+YeeU31kQcE+Is12v1vAmHKc4qbE4
         I9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=nR+y9oL83JIGNZtIre6/euwCwaqJGCzYCr1D5UPHiH4=;
        b=S0q+aNt4ZPf9w0s8+Iu0y4Z9Y24Nr4Vf4TuZ6B2bK8w7Hzl3lsMokGf0NYaAybVCwb
         gW78A53RMGtAgoaG1BtNKkG6JgoFU3OaYdv6VP38QE6BxOWqyGf4SU/yotI6vtFzfOmA
         /4ffhndOhmHMKjuOiw41Lhl9uqN3PjX6/FEYWH00P7ZCdFUwhALv9LM/8258zwofUK2O
         cazwHpRstTpJaoZVtfveuK7zFyILCPXpc/DSsE0r5P6XURYtC4lEEfWqaZhjXgYl+XwD
         +rqBU5tLQ1oZ20byIUW60ZYA/N1xR/Zsee9twzlq2d7jia/8MUz36UfZqpBcvnE3QmBg
         XO4A==
X-Gm-Message-State: APjAAAWvqkrWFWc0NbkndmanmBTfXj6fMozo18VneXOL8/bANqDCRnCb
        iM4zTFZr1dD1jJxTNpx4gcfCmgKTMQ==
X-Google-Smtp-Source: APXvYqyf/g7zk1EO7HKJUQGSGYz/6bLPHYZzw4JG7fqMMjAq1bcJGTMVNQqgTVaiEexiNoXYKWBxs6fC4g==
X-Received: by 2002:a5d:40d1:: with SMTP id b17mr400665wrq.93.1581101956137;
 Fri, 07 Feb 2020 10:59:16 -0800 (PST)
Date:   Fri,  7 Feb 2020 19:59:10 +0100
Message-Id: <20200207185910.162512-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] kcsan: Expose core configuration parameters as module params
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds early_boot, udelay_{task,interrupt}, and skip_watch as module
params. The latter parameters are useful to modify at runtime to tune
KCSAN's performance on new systems. This will also permit auto-tuning
these parameters to maximize overall system performance and KCSAN's race
detection ability.

None of the parameters are used in the fast-path and referring to them
via static variables instead of CONFIG constants will not affect
performance.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Qian Cai <cai@lca.pw>
---
 kernel/kcsan/core.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 87ef01e40199d..498b1eb3c1cda 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -6,6 +6,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/moduleparam.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
 #include <linux/random.h>
@@ -16,6 +17,20 @@
 #include "encoding.h"
 #include "kcsan.h"
 
+static bool kcsan_early_enable = IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE);
+static unsigned int kcsan_udelay_task = CONFIG_KCSAN_UDELAY_TASK;
+static unsigned int kcsan_udelay_interrupt = CONFIG_KCSAN_UDELAY_INTERRUPT;
+static long kcsan_skip_watch = CONFIG_KCSAN_SKIP_WATCH;
+
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+#define MODULE_PARAM_PREFIX "kcsan."
+module_param_named(early_enable, kcsan_early_enable, bool, 0);
+module_param_named(udelay_task, kcsan_udelay_task, uint, 0644);
+module_param_named(udelay_interrupt, kcsan_udelay_interrupt, uint, 0644);
+module_param_named(skip_watch, kcsan_skip_watch, long, 0644);
+
 bool kcsan_enabled;
 
 /* Per-CPU kcsan_ctx for interrupts */
@@ -239,9 +254,9 @@ should_watch(const volatile void *ptr, size_t size, int type)
 
 static inline void reset_kcsan_skip(void)
 {
-	long skip_count = CONFIG_KCSAN_SKIP_WATCH -
+	long skip_count = kcsan_skip_watch -
 			  (IS_ENABLED(CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE) ?
-				   prandom_u32_max(CONFIG_KCSAN_SKIP_WATCH) :
+				   prandom_u32_max(kcsan_skip_watch) :
 				   0);
 	this_cpu_write(kcsan_skip, skip_count);
 }
@@ -253,8 +268,7 @@ static __always_inline bool kcsan_is_enabled(void)
 
 static inline unsigned int get_delay(void)
 {
-	unsigned int delay = in_task() ? CONFIG_KCSAN_UDELAY_TASK :
-					 CONFIG_KCSAN_UDELAY_INTERRUPT;
+	unsigned int delay = in_task() ? kcsan_udelay_task : kcsan_udelay_interrupt;
 	return delay - (IS_ENABLED(CONFIG_KCSAN_DELAY_RANDOMIZE) ?
 				prandom_u32_max(delay) :
 				0);
@@ -527,7 +541,7 @@ void __init kcsan_init(void)
 	 * We are in the init task, and no other tasks should be running;
 	 * WRITE_ONCE without memory barrier is sufficient.
 	 */
-	if (IS_ENABLED(CONFIG_KCSAN_EARLY_ENABLE))
+	if (kcsan_early_enable)
 		WRITE_ONCE(kcsan_enabled, true);
 }
 
-- 
2.25.0.341.g760bfbb309-goog

