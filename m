Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F94C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 01:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B1A42067D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 01:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgGYBat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 21:30:49 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52699 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgGYBat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 21:30:49 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06P1UlJe078212;
        Sat, 25 Jul 2020 10:30:47 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Sat, 25 Jul 2020 10:30:47 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06P1Ue80078060
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 25 Jul 2020 10:30:47 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>,
        syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>,
        syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
Subject: [PATCH] lockdep: Introduce CONFIG_LOCKDEP_LARGE
Date:   Sat, 25 Jul 2020 10:30:39 +0900
Message-Id: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since syzkaller continues various test cases until the kernel crashes,
syzkaller tends to examine more locking dependencies than normal systems.
As a result, syzbot is reporting that the fuzz testing was terminated
due to hitting upper limits lockdep can track [1] [2] [3].

Like CONFIG_LOCKDEP_SMALL which halves the upper limits, let's introduce
CONFIG_LOCKDEP_LARGE which doubles the upper limits.

[1] https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
[2] https://syzkaller.appspot.com/bug?id=381cb436fe60dc03d7fd2a092b46d7f09542a72a
[3] https://syzkaller.appspot.com/bug?id=a588183ac34c1437fc0785e8f220e88282e5a29f

Reported-by: syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/locking/lockdep.c           | 4 ++++
 kernel/locking/lockdep_internals.h | 5 +++++
 lib/Kconfig.debug                  | 8 ++++++++
 3 files changed, 17 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 29a8de4..85ba7eb 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1349,7 +1349,11 @@ static int add_lock_to_list(struct lock_class *this,
 /*
  * For good efficiency of modular, we use power of 2
  */
+#ifdef CONFIG_LOCKDEP_LARGE
+#define MAX_CIRCULAR_QUEUE_SIZE		8192UL
+#else
 #define MAX_CIRCULAR_QUEUE_SIZE		4096UL
+#endif
 #define CQ_MASK				(MAX_CIRCULAR_QUEUE_SIZE-1)
 
 /*
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index baca699..00a3ec3 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -93,6 +93,11 @@ enum {
 #define MAX_LOCKDEP_CHAINS_BITS	15
 #define MAX_STACK_TRACE_ENTRIES	262144UL
 #define STACK_TRACE_HASH_SIZE	8192
+#elif defined(CONFIG_LOCKDEP_LARGE)
+#define MAX_LOCKDEP_ENTRIES	65536UL
+#define MAX_LOCKDEP_CHAINS_BITS	17
+#define MAX_STACK_TRACE_ENTRIES	1048576UL
+#define STACK_TRACE_HASH_SIZE	32768
 #else
 #define MAX_LOCKDEP_ENTRIES	32768UL
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9ad9210..69ba624 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1266,6 +1266,14 @@ config LOCKDEP
 config LOCKDEP_SMALL
 	bool
 
+config LOCKDEP_LARGE
+	bool "Use larger buffer for tracking more locking dependencies"
+	depends on LOCKDEP && !LOCKDEP_SMALL
+	help
+	  If you say Y here, the upper limits the lock dependency engine uses will
+	  be doubled. Useful for fuzz testing which tends to test many complecated
+	  dependencies than normal systems.
+
 config DEBUG_LOCKDEP
 	bool "Lock dependency engine debugging"
 	depends on DEBUG_KERNEL && LOCKDEP
-- 
1.8.3.1

