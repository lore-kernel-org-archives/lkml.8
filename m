Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C479FC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9592F20715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CgfWD1v9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgBJUsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:48:06 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23422 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726563AbgBJUsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581367684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=82MK79LSD5IaXAQPlCaocy2y2lapuJqiAzPviMZeGgI=;
        b=CgfWD1v9nJmG9cHBD8IRGXXbmFJ0uGN6yAiDOKyx4GYN79JQwIqvsvFRi77AGY1qmGkpQ8
        4UgTkzliLqAYjXmWrzNH3nwgpjL4654M9TVv727zUu5RFjCzDY9SI2I3gVgqI48MlbXUj6
        6BalchWoT3tt9u61oBOTP8aLAJY9d8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-uHscYX9wPNmbse9cdWZN2A-1; Mon, 10 Feb 2020 15:48:00 -0500
X-MC-Unique: uHscYX9wPNmbse9cdWZN2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A1138017DF;
        Mon, 10 Feb 2020 20:47:58 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85C9E87B01;
        Mon, 10 Feb 2020 20:47:57 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/3] locking/mutex: Enable some lock event counters
Date:   Mon, 10 Feb 2020 15:46:50 -0500
Message-Id: <20200210204651.21674-3-longman@redhat.com>
In-Reply-To: <20200210204651.21674-1-longman@redhat.com>
References: <20200210204651.21674-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a preliminary set of mutex locking event counters.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h | 9 +++++++++
 kernel/locking/mutex.c            | 9 ++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 239039d0ce21..90db996f0608 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -69,3 +69,12 @@ LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
 LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
 LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
 LOCK_EVENT(rwsem_wlock_handoff)	/* # of write lock handoffs		*/
+
+/*
+ * Locking events for  mutex
+ */
+LOCK_EVENT(mutex_slowpath)	/* # of mutex sleeping slowpaths	*/
+LOCK_EVENT(mutex_optspin)	/* # of successful optimistic spinnings	*/
+LOCK_EVENT(mutex_timeout)	/* # of mutex timeouts			*/
+LOCK_EVENT(mutex_sleep)		/* # of mutex sleeps			*/
+LOCK_EVENT(mutex_handoff)	/* # of mutex lock handoffs		*/
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 976179a4ed9e..1c5c252ce6fb 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -36,6 +36,7 @@
 #else
 # include "mutex.h"
 #endif
+#include "lock_events.h"
 
 void
 __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
@@ -996,10 +997,12 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		lock_acquired(&lock->dep_map, ip);
 		if (use_ww_ctx && ww_ctx)
 			ww_mutex_set_context_fastpath(ww, ww_ctx);
+		lockevent_inc(mutex_optspin);
 		preempt_enable();
 		return 0;
 	}
 
+	lockevent_inc(mutex_slowpath);
 	spin_lock(&lock->wait_lock);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
@@ -1069,12 +1072,14 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 				to = mutex_setup_hrtimer(&timer_sleeper,
 							 timeout);
 			if (!to || !to->task) {
+				lockevent_inc(mutex_timeout);
 				ret = -ETIMEDOUT;
 				goto err;
 			}
 		}
 
 		spin_unlock(&lock->wait_lock);
+		lockevent_inc(mutex_sleep);
 		schedule_preempt_disabled();
 
 		/*
@@ -1083,8 +1088,10 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		 */
 		if ((use_ww_ctx && ww_ctx) || !first) {
 			first = __mutex_waiter_is_first(lock, &waiter);
-			if (first)
+			if (first) {
 				__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
+				lockevent_inc(mutex_handoff);
+			}
 		}
 
 		set_current_state(state);
-- 
2.18.1

