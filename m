Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448FFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBD22080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgH0PUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:20:30 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58451 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbgH0PUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:20:15 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 07RFK9UG015546;
        Fri, 28 Aug 2020 00:20:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Fri, 28 Aug 2020 00:20:09 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 07RFK9M2015540
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 28 Aug 2020 00:20:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: [PATCH v2] lockdep: Allow tuning tracing capacity constants.
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>,
        syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>,
        syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <384ce711-25c5-553b-8d22-965847132fbd@i-love.sakura.ne.jp>
Date:   Fri, 28 Aug 2020 00:20:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since syzkaller continues various test cases until the kernel crashes,
syzkaller tends to examine more locking dependencies than normal systems.
As a result, syzbot is reporting that the fuzz testing was terminated
due to hitting upper limits lockdep can track [1] [2] [3].

Let's allow individually tuning upper limits via kernel config options
(based on an assumption that there is no inter-dependency among these
constants).

[1] https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
[2] https://syzkaller.appspot.com/bug?id=381cb436fe60dc03d7fd2a092b46d7f09542a72a
[3] https://syzkaller.appspot.com/bug?id=a588183ac34c1437fc0785e8f220e88282e5a29f

Reported-by: syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>
Reported-by: syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 kernel/locking/lockdep.c           |  2 +-
 kernel/locking/lockdep_internals.h |  8 +++---
 lib/Kconfig.debug                  | 40 ++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2fad21d345b0..5a058fcec435 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1349,7 +1349,7 @@ static int add_lock_to_list(struct lock_class *this,
 /*
  * For good efficiency of modular, we use power of 2
  */
-#define MAX_CIRCULAR_QUEUE_SIZE		4096UL
+#define MAX_CIRCULAR_QUEUE_SIZE		(1UL << CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS)
 #define CQ_MASK				(MAX_CIRCULAR_QUEUE_SIZE-1)
 
 /*
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index baca699b94e9..8435a11bf456 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -94,16 +94,16 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 #define MAX_STACK_TRACE_ENTRIES	262144UL
 #define STACK_TRACE_HASH_SIZE	8192
 #else
-#define MAX_LOCKDEP_ENTRIES	32768UL
+#define MAX_LOCKDEP_ENTRIES	(1UL << CONFIG_LOCKDEP_BITS)
 
-#define MAX_LOCKDEP_CHAINS_BITS	16
+#define MAX_LOCKDEP_CHAINS_BITS	CONFIG_LOCKDEP_CHAINS_BITS
 
 /*
  * Stack-trace: tightly packed array of stack backtrace
  * addresses. Protected by the hash_lock.
  */
-#define MAX_STACK_TRACE_ENTRIES	524288UL
-#define STACK_TRACE_HASH_SIZE	16384
+#define MAX_STACK_TRACE_ENTRIES	(1UL << CONFIG_LOCKDEP_STACK_TRACE_BITS)
+#define STACK_TRACE_HASH_SIZE	(1 << CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS)
 #endif
 
 /*
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e068c3c7189a..d7612e132986 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1311,6 +1311,46 @@ config LOCKDEP
 config LOCKDEP_SMALL
 	bool
 
+config LOCKDEP_BITS
+	int "Bitsize for MAX_LOCKDEP_ENTRIES"
+	depends on LOCKDEP && !LOCKDEP_SMALL
+	range 10 30
+	default 15
+	help
+	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
+
+config LOCKDEP_CHAINS_BITS
+	int "Bitsize for MAX_LOCKDEP_CHAINS"
+	depends on LOCKDEP && !LOCKDEP_SMALL
+	range 10 30
+	default 16
+	help
+	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
+
+config LOCKDEP_STACK_TRACE_BITS
+	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
+	depends on LOCKDEP && !LOCKDEP_SMALL
+	range 10 30
+	default 19
+	help
+	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
+
+config LOCKDEP_STACK_TRACE_HASH_BITS
+	int "Bitsize for STACK_TRACE_HASH_SIZE"
+	depends on LOCKDEP && !LOCKDEP_SMALL
+	range 10 30
+	default 14
+	help
+	  Try increasing this value if you need large MAX_STACK_TRACE_ENTRIES.
+
+config LOCKDEP_CIRCULAR_QUEUE_BITS
+	int "Bitsize for elements in circular_queue struct"
+	depends on LOCKDEP
+	range 10 30
+	default 12
+	help
+	  Try increasing this value if you hit "lockdep bfs error:-1" warning due to __cq_enqueue() failure.
+
 config DEBUG_LOCKDEP
 	bool "Lock dependency engine debugging"
 	depends on DEBUG_KERNEL && LOCKDEP
-- 
2.18.4


