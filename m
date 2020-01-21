Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F532C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9AF20661
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgAUIez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:34:55 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:58024 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727220AbgAUIex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:34:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ToHXA56_1579595691;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHXA56_1579595691)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 16:34:51 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] locking/selftest: remove unused macros
Date:   Tue, 21 Jan 2020 16:34:49 +0800
Message-Id: <1579595689-251576-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WLU is never used. and DO_TESTCASE_6_SUCCESS isn't used from
commit cfb6133399a4 ("locking/selftest: Remove the bad unlock ordering test")

So better to remove them.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org> 
Cc: Ingo Molnar <mingo@redhat.com> 
Cc: Will Deacon <will@kernel.org> 
Cc: linux-kernel@vger.kernel.org 
---
 lib/locking-selftest.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 14f44f59e733..6b0f55581485 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -216,7 +216,6 @@ static void init_shared_classes(void)
 
 #define WL(x)			write_lock(&rwlock_##x)
 #define WU(x)			write_unlock(&rwlock_##x)
-#define WLU(x)			WL(x); WU(x)
 
 #define RL(x)			read_lock(&rwlock_##x)
 #define RU(x)			read_unlock(&rwlock_##x)
@@ -1224,17 +1223,6 @@ static inline void print_testname(const char *testname)
 	dotest_rt(name##_rtmutex, FAILURE, LOCKTYPE_RTMUTEX);	\
 	pr_cont("\n");
 
-#define DO_TESTCASE_6_SUCCESS(desc, name)			\
-	print_testname(desc);					\
-	dotest(name##_spin, SUCCESS, LOCKTYPE_SPIN);		\
-	dotest(name##_wlock, SUCCESS, LOCKTYPE_RWLOCK);		\
-	dotest(name##_rlock, SUCCESS, LOCKTYPE_RWLOCK);		\
-	dotest(name##_mutex, SUCCESS, LOCKTYPE_MUTEX);		\
-	dotest(name##_wsem, SUCCESS, LOCKTYPE_RWSEM);		\
-	dotest(name##_rsem, SUCCESS, LOCKTYPE_RWSEM);		\
-	dotest_rt(name##_rtmutex, SUCCESS, LOCKTYPE_RTMUTEX);	\
-	pr_cont("\n");
-
 /*
  * 'read' variant: rlocks must not trigger.
  */
-- 
1.8.3.1

