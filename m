Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ED0C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EF9215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583780713;
	bh=h8NlL0BNWOOzGjbattsQHdPTR/D98Gipr0p/Cf1gauo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a+XvVHyUyOFajQR6rAj11o0JszK3dQA++BGZjhwTuCrDiHLt3rjTqKf8oZYI5u4P9
	 ehE0htTu27klUlN4YFWblnuWySoOP/MIR57+UgUhSG0vkn4nRqK4J8hMhuua+t+QTj
	 YG26NZ/UNNhiF7vpbTQcD98yRvEn0cZk0zzeGBDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgCITFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:05:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbgCITE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:04:27 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF29021655;
        Mon,  9 Mar 2020 19:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780667;
        bh=h8NlL0BNWOOzGjbattsQHdPTR/D98Gipr0p/Cf1gauo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IAd2hde4Obj2yUyEKiuD+RNlHhu9QkfyY8Nth3FZj/IclaMTSj/ebOWqxlv45Y85D
         blN8y9OUDB9g57RMkn0YUQDlHK1g1sl0hr/mMJJvzeclAp/H4QLxlLtmjsd2ivSoIL
         mZcz2bxPEMPjZJcSyDIdXq+KYMU3BAEG+l6rCRes=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 19/32] kcsan: Expose core configuration parameters as module params
Date:   Mon,  9 Mar 2020 12:04:07 -0700
Message-Id: <20200309190420.6100-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200309190359.GA5822@paulmck-ThinkPad-P72>
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 87ef01e..498b1eb 100644
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
2.9.5

