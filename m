Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F10C38A2F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 445862223D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 01:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587261506;
	bh=7Wo7rJBHP9prKBoZ2hJqLbYoAryut5A4noLd+A2t+vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tnvwo/9Tw7yx+rH5CPE0vLjLOEHS7D95j5N5gEwD7HYcuyRJ1GEGnFSwk7Z1gl7Mm
	 z2Bh2jh5nbfBtbjVQxeu30KYOHsAmxgZNs8pSVEHMFyKf/ff7Nhl7GQMkpUIR5lgHA
	 2J4eOCFbcpAG62j5Omv9s2brX4uVFEp/5V9bvm60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgDSB6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 21:58:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgDSB6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:58:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C314A22253;
        Sun, 19 Apr 2020 01:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587261493;
        bh=7Wo7rJBHP9prKBoZ2hJqLbYoAryut5A4noLd+A2t+vQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ltYAfOuu4MPeQHB160UmViI9WamDDZc0glaiAkg8IeAo38FhvplA52Wc+axWrKMNZ
         czKjLT9uyusxOzjyv8xRajDyI+95W3i0CHZz114AVIrZztzUOFiIm8y6rt3mbIbn2H
         /ee1TSVHdcSCyaMwl2BX/kVzNcTB6SmJ6QY40JL0=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 12/12] tools/lib/lockdep: switch to using lockdep_init_map_waits
Date:   Sat, 18 Apr 2020 21:57:54 -0400
Message-Id: <20200419015754.24456-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419015754.24456-1-sashal@kernel.org>
References: <20200419015754.24456-1-sashal@kernel.org>
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
index cc3d60623ca47..046570566e277 100644
--- a/tools/include/linux/kernel.h
+++ b/tools/include/linux/kernel.h
@@ -132,4 +132,6 @@ static __maybe_unused int system_state;
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
2.20.1

