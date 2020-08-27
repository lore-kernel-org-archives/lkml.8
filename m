Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2D0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921F120786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zl/g4SIo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sk6OXjgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbgH0H7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbgH0HyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D2DC06121B;
        Thu, 27 Aug 2020 00:54:23 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZg0MEDtwZcjzdPVjMy4lYSX+RK6YsLfItMCHIuSXWU=;
        b=zl/g4SIovYCxBujJwtYy3QC30JC82777a31WQCbeaLpQLxVbwQoB7xCtUMYOMPzDfMFJZl
        wg3t2EJDBJLBcPIrdZvZYQuMrfMWHivhPTfGCgvTsqUPSvxNhHDx8r4x+kcbYiLfyAmmZq
        Df969psCwdBLMgeeX+bxzzB5kKngx8lmxYCGkzqI3iF7JQ+YmBk0qOyOw/pFduN5RMtUYS
        9mqDELiCKZ/9hu7sBASMjAWrrE/OGXvX+1GRXaqSiVMiUzGmb37CquExCb2Cx+M2LMuhGA
        BAv/I/FEm4cS94X0pDWHxko/Ufl+3OCw1M7OsMFwVIsrEtP20kr34Nl5MCNEdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514861;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gZg0MEDtwZcjzdPVjMy4lYSX+RK6YsLfItMCHIuSXWU=;
        b=sk6OXjgYlsLJ4HImW6M8JM7Jpov0e7Ky5x5p8IuVVuQDLUJjSWZa2Ym3GmdE+3buCLIvvV
        Lbr2vuTBVJfkSUCw==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Make __bfs() visit every dependency
 until a match
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-5-boqun.feng@gmail.com>
References: <20200807074238.1632519-5-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851486108.20229.15945468647290456258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     d563bc6ead9e79be37067d58509a605b67378184
Gitweb:        https://git.kernel.org/tip/d563bc6ead9e79be37067d58509a605b67378184
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:23 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:03 +02:00

lockdep: Make __bfs() visit every dependency until a match

Currently, __bfs() will do a breadth-first search in the dependency
graph and visit each lock class in the graph exactly once, so for
example, in the following graph:

	A ---------> B
	|            ^
	|            |
	+----------> C

a __bfs() call starts at A, will visit B through dependency A -> B and
visit C through dependency A -> C and that's it, IOW, __bfs() will not
visit dependency C -> B.

This is OK for now, as we only have strong dependencies in the
dependency graph, so whenever there is a traverse path from A to B in
__bfs(), it means A has strong dependencies to B (IOW, B depends on A
strongly). So no need to visit all dependencies in the graph.

However, as we are going to add recursive-read lock into the dependency
graph, as a result, not all the paths mean strong dependencies, in the
same example above, dependency A -> B may be a weak dependency and
traverse A -> C -> B may be a strong dependency path. And with the old
way of __bfs() (i.e. visiting every lock class exactly once), we will
miss the strong dependency path, which will result into failing to find
a deadlock. To cure this for the future, we need to find a way for
__bfs() to visit each dependency, rather than each class, exactly once
in the search until we find a match.

The solution is simple:

We used to mark lock_class::lockdep_dependency_gen_id to indicate a
class has been visited in __bfs(), now we change the semantics a little
bit: we now mark lock_class::lockdep_dependency_gen_id to indicate _all
the dependencies_ in its lock_{after,before} have been visited in the
__bfs() (note we only take one direction in a __bfs() search). In this
way, every dependency is guaranteed to be visited until we find a match.

Note: the checks in mark_lock_accessed() and lock_accessed() are
removed, because after this modification, we may call these two
functions on @source_entry of __bfs(), which may not be the entry in
"list_entries"

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-5-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c | 61 ++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 462c68c..150686a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1421,23 +1421,19 @@ static inline unsigned int  __cq_get_elem_count(struct circular_queue *cq)
 	return (cq->rear - cq->front) & CQ_MASK;
 }
 
-static inline void mark_lock_accessed(struct lock_list *lock,
-					struct lock_list *parent)
+static inline void mark_lock_accessed(struct lock_list *lock)
 {
-	unsigned long nr;
+	lock->class->dep_gen_id = lockdep_dependency_gen_id;
+}
 
-	nr = lock - list_entries;
-	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
+static inline void visit_lock_entry(struct lock_list *lock,
+				    struct lock_list *parent)
+{
 	lock->parent = parent;
-	lock->class->dep_gen_id = lockdep_dependency_gen_id;
 }
 
 static inline unsigned long lock_accessed(struct lock_list *lock)
 {
-	unsigned long nr;
-
-	nr = lock - list_entries;
-	WARN_ON(nr >= ARRAY_SIZE(list_entries)); /* Out-of-bounds, input fail */
 	return lock->class->dep_gen_id == lockdep_dependency_gen_id;
 }
 
@@ -1540,26 +1536,39 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 			goto exit;
 		}
 
+		/*
+		 * If we have visited all the dependencies from this @lock to
+		 * others (iow, if we have visited all lock_list entries in
+		 * @lock->class->locks_{after,before}) we skip, otherwise go
+		 * and visit all the dependencies in the list and mark this
+		 * list accessed.
+		 */
+		if (lock_accessed(lock))
+			continue;
+		else
+			mark_lock_accessed(lock);
+
 		head = get_dep_list(lock, offset);
 
+		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
+
 		list_for_each_entry_rcu(entry, head, entry) {
-			if (!lock_accessed(entry)) {
-				unsigned int cq_depth;
-				mark_lock_accessed(entry, lock);
-				if (match(entry, data)) {
-					*target_entry = entry;
-					ret = BFS_RMATCH;
-					goto exit;
-				}
-
-				if (__cq_enqueue(cq, entry)) {
-					ret = BFS_EQUEUEFULL;
-					goto exit;
-				}
-				cq_depth = __cq_get_elem_count(cq);
-				if (max_bfs_queue_depth < cq_depth)
-					max_bfs_queue_depth = cq_depth;
+			unsigned int cq_depth;
+
+			visit_lock_entry(entry, lock);
+			if (match(entry, data)) {
+				*target_entry = entry;
+				ret = BFS_RMATCH;
+				goto exit;
+			}
+
+			if (__cq_enqueue(cq, entry)) {
+				ret = BFS_EQUEUEFULL;
+				goto exit;
 			}
+			cq_depth = __cq_get_elem_count(cq);
+			if (max_bfs_queue_depth < cq_depth)
+				max_bfs_queue_depth = cq_depth;
 		}
 	}
 exit:
