Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D19BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE1E22CF8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596586290;
	bh=ebOgrmhy4UDTfGSz+pQ8kSPUYc5NrN43nmVXzf7DQJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MVPnqIJ9ShDSVGuYRI57Q54na2Uhh1ERN5ydtMnt/DJCHHqJ+T3X4asx7TkMqA1IY
	 QFKCUv+uJq/ZNBwaKpQLRqnHvzORJXU7upnCYFx4q8HJ5rx++pC5AMd5Wxj+QYteYP
	 UIHT91BOF0ZPcpUAmYg9PQLNARx0UCnQ17UbtCIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgHEALJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbgHEAK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:10:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A0E3206DA;
        Wed,  5 Aug 2020 00:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596586255;
        bh=ebOgrmhy4UDTfGSz+pQ8kSPUYc5NrN43nmVXzf7DQJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IGHRWbRXAxjj6OYEsJHvQC+papM3OFLdMWDkLduZnzgyZED9UDPeyPi6JYZ4jCOVD
         h/z7pnIVZQwj8ghZPPq0ocIXiU6m2cGbzTYhaUNyKBo5B07ci7Zbk6695FCKb/hdNH
         CHPoGd9RXZVudXVMaGJ1xDGFQnmj/0Rvi6n30DxY=
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v4 11/14] tools/lib/lockdep: switch to using lockdep_init_map_waits
Date:   Tue,  4 Aug 2020 20:10:40 -0400
Message-Id: <20200805001043.3331907-12-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200805001043.3331907-1-sashal@kernel.org>
References: <20200805001043.3331907-1-sashal@kernel.org>
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

