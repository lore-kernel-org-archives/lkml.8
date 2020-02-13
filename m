Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8B4C3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5EF24650
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 12:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbgBMMBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 07:01:40 -0500
Received: from relay.sw.ru ([185.231.240.75]:49272 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbgBMMBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 07:01:40 -0500
Received: from [192.168.15.180] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j2DBQ-0002bF-Qt; Thu, 13 Feb 2020 15:01:29 +0300
Subject: [PATCH] rcu: Replace kfree() with kvfree() as callback for
 kfree_rcu()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     paulmck@linux.vnet.ibm.com, ktkhai@virtuozzo.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 Feb 2020 15:01:28 +0300
Message-ID: <158159527946.176207.12317029863782349826.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like Paul suggested, we start from simple replacing kfree()
with kvfree() in kfree_rcu() callbacks:

https://www.spinics.net/lists/kernel/msg2729683.html

kvfree() works both with kmalloc()'ed and vmalloc()'ed memory,
so we use it to free both of them via kfree_rcu().

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 include/linux/rcupdate.h |    2 ++
 kernel/rcu/tiny.c        |    2 +-
 kernel/rcu/tree.c        |    2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 2678a37c3169..0a42c443c203 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -842,6 +842,8 @@ do {									\
 		__kfree_rcu(&((___p)->rhf), offsetof(typeof(*(ptr)), rhf)); \
 } while (0)
 
+#define kvfree_rcu(ptr, rhf) kfree_rcu(ptr, rhf)
+
 /*
  * Place this after a lock-acquisition primitive to guarantee that
  * an UNLOCK+LOCK pair acts as a full barrier.  This guarantee applies
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index dd572ce7c747..16930c8f5749 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -86,7 +86,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 	rcu_lock_acquire(&rcu_callback_map);
 	if (__is_kfree_rcu_offset(offset)) {
 		trace_rcu_invoke_kfree_callback("", head, offset);
-		kfree((void *)head - offset);
+		kvfree((void *)head - offset);
 		rcu_lock_release(&rcu_callback_map);
 		return true;
 	}
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 16fd113796a7..cbe809bf6f4a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2879,7 +2879,7 @@ static void kfree_rcu_work(struct work_struct *work)
 		trace_rcu_invoke_kfree_callback(rcu_state.name, head, offset);
 
 		if (!WARN_ON_ONCE(!__is_kfree_rcu_offset(offset)))
-			kfree((void *)head - offset);
+			kvfree((void *)head - offset);
 
 		rcu_lock_release(&rcu_callback_map);
 		cond_resched_tasks_rcu_qs();


