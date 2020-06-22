Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA2AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475EC2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592865815;
	bh=ebOgrmhy4UDTfGSz+pQ8kSPUYc5NrN43nmVXzf7DQJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jH+l+idSqH441K+ku07HQu5tZn+n3R81p6y+tsUFYbQlkNUSpWsSYPKaM59rLhvbZ
	 O1FE4yG2WVFInn3Kd8YHnDZUDMEatBNjRuEYbAzx+VvMPMEnuLrRIJXtmXvrk+fmS5
	 DfsI1JVwrc29M4HK4C7XEMEDYyEngI4ZxApzB5sM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbgFVWnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:43:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731332AbgFVWnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCC142078E;
        Mon, 22 Jun 2020 22:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592865796;
        bh=ebOgrmhy4UDTfGSz+pQ8kSPUYc5NrN43nmVXzf7DQJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=REnP7qq/PSkeF637/tyYRmE7Lj1c3g3tQ27RK1tMsa/yNuau8LghjqBrbFnvUYMhk
         qKPvUtfT0ChbQXXduC3fTriwYicCA6JQEsQh6vrqu5L2fq4ue7OtJWlOoBUo9gFzmA
         /cR0kSSTYycvSCPkgrW7NaNRy8LI0qQo48qqe6ck=
From:   Sasha Levin <sashal@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, alexey.budankov@linux.intel.com,
        songliubraving@fb.com, acme@redhat.com, allison@lohutok.net,
        sashal@kernel.org
Subject: [PATCH v3 11/14] tools/lib/lockdep: switch to using lockdep_init_map_waits
Date:   Mon, 22 Jun 2020 18:42:55 -0400
Message-Id: <20200622224258.1208588-12-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622224258.1208588-1-sashal@kernel.org>
References: <20200622224258.1208588-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of de8f5e4f2dc1 ("lockdep: Introduce wait-type checks") lockdep
exports lockdep_init_map_waits() instead of lockdep_init_map() for
initialization.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/kernel.h                  | 2 ++
 tools/include/linux/lockdep.h                 | 1 +
 tools/lib/lockdep/include/liblockdep/common.h | 4 ++--
 tools/lib/lockdep/include/liblockdep/mutex.h  | 2 +-
 tools/lib/lockdep/include/liblockdep/rwlock.h | 2 +-
 tools/lib/lockdep/preload.c                   | 2 +-
 6 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
index 902d3b9ab4c17..5ac493eef4237 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -124,4 +124,6 @@ static __maybe_unused int system_state;
 #define rcu_read_lock()
 #define rcu_read_unlock()
 
+#define in_nmi() 0
+
 #endif
diff --git a/tools/include/linux/lockdep.h b/tools/include/linux/lockdep.h
index 3a9924d6d3ae8..4e5f31f28ca3e 100644
--- a/tools/include/linux/lockdep.h
+++ b/tools/include/linux/lockdep.h
@@ -34,6 +34,7 @@ struct task_struct {
 	int pid;
 	int state;
 	int softirqs_enabled, hardirqs_enabled, softirqs_disabled, hardirqs_disabled, irq_events;
+	int hardirq_threaded, irq_config;
 	unsigned long softirq_disable_ip, softirq_enable_ip;
 	unsigned int softirq_disable_event, softirq_enable_event;
 	unsigned long hardirq_disable_ip, hardirq_enable_ip;
diff --git a/tools/lib/lockdep/include/liblockdep/common.h b/tools/lib/lockdep/include/liblockdep/common.h
index a6d7ee5f18ba9..5f698671f45c2 100644
--- a/tools/lib/lockdep/include/liblockdep/common.h
+++ b/tools/lib/lockdep/include/liblockdep/common.h
@@ -37,8 +37,8 @@ struct lockdep_map {
 #endif
 };
 
-void lockdep_init_map(struct lockdep_map *lock, const char *name,
-			struct lock_class_key *key, int subclass);
+void lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
+	struct lock_class_key *key, int subclass, short inner, short outer);
 void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 			int trylock, int read, int check,
 			struct lockdep_map *nest_lock, unsigned long ip);
diff --git a/tools/lib/lockdep/include/liblockdep/mutex.h b/tools/lib/lockdep/include/liblockdep/mutex.h
index bd106b82759b7..6106fc73da687 100644
--- a/tools/lib/lockdep/include/liblockdep/mutex.h
+++ b/tools/lib/lockdep/include/liblockdep/mutex.h
@@ -24,7 +24,7 @@ static inline int __mutex_init(liblockdep_pthread_mutex_t *lock,
 				struct lock_class_key *key,
 				const pthread_mutexattr_t *__mutexattr)
 {
-	lockdep_init_map(&lock->dep_map, name, key, 0);
+	lockdep_init_map_waits(&lock->dep_map, name, key, 0, 0, 0);
 	return pthread_mutex_init(&lock->mutex, __mutexattr);
 }
 
diff --git a/tools/lib/lockdep/include/liblockdep/rwlock.h b/tools/lib/lockdep/include/liblockdep/rwlock.h
index 6d5d2932bf4d9..222748d04219d 100644
--- a/tools/lib/lockdep/include/liblockdep/rwlock.h
+++ b/tools/lib/lockdep/include/liblockdep/rwlock.h
@@ -23,7 +23,7 @@ static inline int __rwlock_init(liblockdep_pthread_rwlock_t *lock,
 				struct lock_class_key *key,
 				const pthread_rwlockattr_t *attr)
 {
-	lockdep_init_map(&lock->dep_map, name, key, 0);
+	lockdep_init_map_waits(&lock->dep_map, name, key, 0, 0, 0);
 
 	return pthread_rwlock_init(&lock->rwlock, attr);
 }
diff --git a/tools/lib/lockdep/preload.c b/tools/lib/lockdep/preload.c
index 578fdeda9422c..5bd58c51066c4 100644
--- a/tools/lib/lockdep/preload.c
+++ b/tools/lib/lockdep/preload.c
@@ -199,7 +199,7 @@ static struct lock_lookup *__get_lock(void *lock)
 	 * TODO: Get the real name of the lock using libdwarf
 	 */
 	sprintf(l->name, "%p", lock);
-	lockdep_init_map(&l->dep_map, l->name, &l->key, 0);
+//	lockdep_init_map_waits(&l->dep_map, l->name, &l->key, 0, 0, 0);
 
 	ll_pthread_rwlock_wrlock(&locks_rwlock);
 	/* This might have changed since the last time we fetched it */
-- 
2.25.1

