Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1117AC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E568D2223D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgDQOut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:50:49 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:37340 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727850AbgDQOut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:50:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TvqMba0_1587135046;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TvqMba0_1587135046)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 17 Apr 2020 22:50:46 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] locking/rtmutex: Remove unused rt_mutex_cmpxchg_relaxed()
Date:   Fri, 17 Apr 2020 22:50:31 +0800
Message-Id: <1587135032-188866-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This macro isn't interested by anyone, so remove it.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 kernel/locking/rtmutex.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index c9f090d64f00..cfdd5b93264d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -141,7 +141,6 @@ static void fixup_rt_mutex_waiters(struct rt_mutex *lock)
  * set up.
  */
 #ifndef CONFIG_DEBUG_RT_MUTEXES
-# define rt_mutex_cmpxchg_relaxed(l,c,n) (cmpxchg_relaxed(&l->owner, c, n) == c)
 # define rt_mutex_cmpxchg_acquire(l,c,n) (cmpxchg_acquire(&l->owner, c, n) == c)
 # define rt_mutex_cmpxchg_release(l,c,n) (cmpxchg_release(&l->owner, c, n) == c)
 
@@ -202,7 +201,6 @@ static inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
 }
 
 #else
-# define rt_mutex_cmpxchg_relaxed(l,c,n)	(0)
 # define rt_mutex_cmpxchg_acquire(l,c,n)	(0)
 # define rt_mutex_cmpxchg_release(l,c,n)	(0)
 
-- 
1.8.3.1

