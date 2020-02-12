Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA7EC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B482073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 15:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dG5wrawF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgBLPjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 10:39:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26948 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727026AbgBLPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 10:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581521936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=2YEslZPhP18g4Rp7UueQO3wJPsjA+JWs+ANOpmXAkRg=;
        b=dG5wrawFJpjZH533uXobNzh5U6eKqliGn44+fI1HHtqgXoG5TfVc9h5qWOVtrzysqcAuUy
        vUuqEySg3V6T7HS1JntV0GtcvPRSwi+KLyK45Q73vwrCEF4KjcoETTtXiIWE2sFF5I9SMm
        wuDKgYKMGuH9kVmoOOkofinOZAc9sDs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-4tNYdBAWO1W2YludDTKmsg-1; Wed, 12 Feb 2020 10:38:54 -0500
X-MC-Unique: 4tNYdBAWO1W2YludDTKmsg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5C0B800D41;
        Wed, 12 Feb 2020 15:38:52 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F332A6E40A;
        Wed, 12 Feb 2020 15:38:51 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-tip 3/3] locking/lockdep: Consolidate CONFIG_DEBUG_LOCKDEP code
Date:   Wed, 12 Feb 2020 10:38:28 -0500
Message-Id: <20200212153828.346-4-longman@redhat.com>
In-Reply-To: <20200212153828.346-1-longman@redhat.com>
References: <20200212153828.346-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the CONFIG_DEBUG_LOCKDEP code in lockdep.c together in one place.
This is a code relocation patch. There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c | 118 +++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 61 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 417c0616d791..eb1bb8ffd777 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -454,13 +454,6 @@ unsigned int nr_softirq_chains;
 unsigned int nr_process_chains;
 unsigned int max_lockdep_depth;
 
-#ifdef CONFIG_DEBUG_LOCKDEP
-/*
- * Various lockdep statistics:
- */
-DEFINE_PER_CPU(struct lockdep_stats, lockdep_stats);
-#endif
-
 const char *__get_key_name(const struct lockdep_subclass_key *key, char *str)
 {
 	return kallsyms_lookup((unsigned long)key, NULL, NULL, NULL, str);
@@ -802,6 +795,10 @@ static inline void remove_class_from_lock_chains(struct pending_free *pf,
 #endif /* CONFIG_PROVE_LOCKING */
 
 #ifdef CONFIG_DEBUG_LOCKDEP
+/*
+ * Various lockdep statistics:
+ */
+DEFINE_PER_CPU(struct lockdep_stats, lockdep_stats);
 
 #ifndef check_lock_chain_key
 static inline bool check_lock_chain_key(struct lock_chain *chain)
@@ -961,9 +958,61 @@ static void check_data_structures(void)
 	}
 }
 
+/*
+ * We are building curr_chain_key incrementally, so double-check
+ * it from scratch, to make sure that it's done correctly:
+ */
+static void check_chain_key(struct task_struct *curr)
+{
+	struct held_lock *hlock, *prev_hlock = NULL;
+	unsigned int i;
+	u64 chain_key = INITIAL_CHAIN_KEY;
+
+	for (i = 0; i < curr->lockdep_depth; i++) {
+		hlock = curr->held_locks + i;
+		if (chain_key != hlock->prev_chain_key) {
+			debug_locks_off();
+			/*
+			 * We got mighty confused, our chain keys don't match
+			 * with what we expect, someone trample on our task state?
+			 */
+			WARN(1, "hm#1, depth: %u [%u], %016Lx != %016Lx\n",
+				curr->lockdep_depth, i,
+				(unsigned long long)chain_key,
+				(unsigned long long)hlock->prev_chain_key);
+			return;
+		}
+
+		/*
+		 * hlock->class_idx can't go beyond MAX_LOCKDEP_KEYS, but is
+		 * it registered lock class index?
+		 */
+		if (DEBUG_LOCKS_WARN_ON(!test_bit(hlock->class_idx, lock_classes_in_use)))
+			return;
+
+		if (prev_hlock && (prev_hlock->irq_context !=
+							hlock->irq_context))
+			chain_key = INITIAL_CHAIN_KEY;
+		chain_key = iterate_chain_key(chain_key, hlock->class_idx);
+		prev_hlock = hlock;
+	}
+	if (chain_key != curr->curr_chain_key) {
+		debug_locks_off();
+		/*
+		 * More smoking hash instead of calculating it, damn see these
+		 * numbers float.. I bet that a pink elephant stepped on my memory.
+		 */
+		WARN(1, "hm#2, depth: %u [%u], %016Lx != %016Lx\n",
+			curr->lockdep_depth, i,
+			(unsigned long long)chain_key,
+			(unsigned long long)curr->curr_chain_key);
+	}
+}
+
 #else /* CONFIG_DEBUG_LOCKDEP */
 
-static inline void check_data_structures(void) { }
+static inline void check_data_structures(void)			{ }
+static inline void check_chain_key(struct task_struct *curr)	{ }
 
 #endif /* CONFIG_DEBUG_LOCKDEP */
 
@@ -1173,59 +1222,6 @@ register_lock_class(struct lockdep_map *lock, unsigned int subclass, int force)
 	return class;
 }
 
-/*
- * We are building curr_chain_key incrementally, so double-check
- * it from scratch, to make sure that it's done correctly:
- */
-static void check_chain_key(struct task_struct *curr)
-{
-#ifdef CONFIG_DEBUG_LOCKDEP
-	struct held_lock *hlock, *prev_hlock = NULL;
-	unsigned int i;
-	u64 chain_key = INITIAL_CHAIN_KEY;
-
-	for (i = 0; i < curr->lockdep_depth; i++) {
-		hlock = curr->held_locks + i;
-		if (chain_key != hlock->prev_chain_key) {
-			debug_locks_off();
-			/*
-			 * We got mighty confused, our chain keys don't match
-			 * with what we expect, someone trample on our task state?
-			 */
-			WARN(1, "hm#1, depth: %u [%u], %016Lx != %016Lx\n",
-				curr->lockdep_depth, i,
-				(unsigned long long)chain_key,
-				(unsigned long long)hlock->prev_chain_key);
-			return;
-		}
-
-		/*
-		 * hlock->class_idx can't go beyond MAX_LOCKDEP_KEYS, but is
-		 * it registered lock class index?
-		 */
-		if (DEBUG_LOCKS_WARN_ON(!test_bit(hlock->class_idx, lock_classes_in_use)))
-			return;
-
-		if (prev_hlock && (prev_hlock->irq_context !=
-							hlock->irq_context))
-			chain_key = INITIAL_CHAIN_KEY;
-		chain_key = iterate_chain_key(chain_key, hlock->class_idx);
-		prev_hlock = hlock;
-	}
-	if (chain_key != curr->curr_chain_key) {
-		debug_locks_off();
-		/*
-		 * More smoking hash instead of calculating it, damn see these
-		 * numbers float.. I bet that a pink elephant stepped on my memory.
-		 */
-		WARN(1, "hm#2, depth: %u [%u], %016Lx != %016Lx\n",
-			curr->lockdep_depth, i,
-			(unsigned long long)chain_key,
-			(unsigned long long)curr->curr_chain_key);
-	}
-#endif
-}
-
 /*
  * Initialize a lock instance's lock-class mapping info:
  */
-- 
2.18.1

