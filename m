Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C429C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76FCA22D70
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MiRPdREm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UQLkDy8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgH0Hyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbgH0HyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:54:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC3AC061232;
        Thu, 27 Aug 2020 00:54:20 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:54:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598514859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYMNlMJwEyKddcIih+qKrMbxMV/KJLEv7mwreRYwRGE=;
        b=MiRPdREmUJw/gp8yzMIC/tGUTQcOsUYXqzk3rl/Dme2ASk+rzxaFP1rxWiRhmnsJNVn689
        Pml7L4rLf4S0xqQZGZw0HKlQHDIbu/6sL42VNNnunTsVMqp4Znn8pXyVLm2Braq3mBRKBh
        h17zfm5kK+2Qj7iK/2ZDm+jntlVSAwNYA59DJI2NCN7LSC4s/i1TTz7SSPG/jJOQzY47gU
        GSEuXPARFY6vIq6EufWsA6c9Tp//REhu2bVOgYyGOyAyT6B7CPrGlVsMdkmYXuX2rZhux8
        mm2il3oID/9RbCHFm10COW7TPTEj09BPFfFPJUFEAURT9IS0F3MCOVPTK8S6IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598514859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYMNlMJwEyKddcIih+qKrMbxMV/KJLEv7mwreRYwRGE=;
        b=UQLkDy8F5G6boOPHjWiHYzRnLZMoQEvRRa13iGjCNEzBC3Hfr2liLxiQcrG17eo5fa8V2j
        MEFYr6ZamCa89JCQ==
From:   "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Adjust check_redundant() for recursive
 read change
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200807074238.1632519-11-boqun.feng@gmail.com>
References: <20200807074238.1632519-11-boqun.feng@gmail.com>
MIME-Version: 1.0
Message-ID: <159851485838.20229.17873973008590975666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     68e305678583f13a67e2ce22088c2520bd4f97b4
Gitweb:        https://git.kernel.org/tip/68e305678583f13a67e2ce22088c2520bd4f97b4
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Fri, 07 Aug 2020 15:42:29 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 26 Aug 2020 12:42:05 +02:00

lockdep: Adjust check_redundant() for recursive read change

check_redundant() will report redundancy if it finds a path could
replace the about-to-add dependency in the BFS search. With recursive
read lock changes, we certainly need to change the match function for
the check_redundant(), because the path needs to match not only the lock
class but also the dependency kinds. For example, if the about-to-add
dependency @prev -> @next is A -(SN)-> B, and we find a path A -(S*)->
.. -(*R)->B in the dependency graph with __bfs() (for simplicity, we can
also say we find an -(SR)-> path from A to B), we can not replace the
dependency with that path in the BFS search. Because the -(SN)->
dependency can make a strong path with a following -(S*)-> dependency,
however an -(SR)-> path cannot.

Further, we can replace an -(SN)-> dependency with a -(EN)-> path, that
means if we find a path which is stronger than or equal to the
about-to-add dependency, we can report the redundancy. By "stronger", it
means both the start and the end of the path are not weaker than the
start and the end of the dependency (E is "stronger" than S and N is
"stronger" than R), so that we can replace the dependency with that
path.

To make sure we find a path whose start point is not weaker than the
about-to-add dependency, we use a trick: the ->only_xr of the root
(start point) of __bfs() is initialized as @prev-> == 0, therefore if
@prev is E, __bfs() will pick only -(E*)-> for the first dependency,
otherwise, __bfs() can pick -(E*)-> or -(S*)-> for the first dependency.

To make sure we find a path whose end point is not weaker than the
about-to-add dependency, we replace the match function for __bfs()
check_redundant(), we check for the case that either @next is R
(anything is not weaker than it) or the end point of the path is N
(which is not weaker than anything).

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200807074238.1632519-11-boqun.feng@gmail.com
---
 kernel/locking/lockdep.c | 47 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 9160f1d..42e2f1f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1833,9 +1833,39 @@ print_circular_bug_header(struct lock_list *entry, unsigned int depth,
 	print_circular_bug_entry(entry, depth);
 }
 
-static inline bool class_equal(struct lock_list *entry, void *data)
+/*
+ * We are about to add A -> B into the dependency graph, and in __bfs() a
+ * strong dependency path A -> .. -> B is found: hlock_class equals
+ * entry->class.
+ *
+ * If A -> .. -> B can replace A -> B in any __bfs() search (means the former
+ * is _stronger_ than or equal to the latter), we consider A -> B as redundant.
+ * For example if A -> .. -> B is -(EN)-> (i.e. A -(E*)-> .. -(*N)-> B), and A
+ * -> B is -(ER)-> or -(EN)->, then we don't need to add A -> B into the
+ * dependency graph, as any strong path ..-> A -> B ->.. we can get with
+ * having dependency A -> B, we could already get a equivalent path ..-> A ->
+ * .. -> B -> .. with A -> .. -> B. Therefore A -> B is reduntant.
+ *
+ * We need to make sure both the start and the end of A -> .. -> B is not
+ * weaker than A -> B. For the start part, please see the comment in
+ * check_redundant(). For the end part, we need:
+ *
+ * Either
+ *
+ *     a) A -> B is -(*R)-> (everything is not weaker than that)
+ *
+ * or
+ *
+ *     b) A -> .. -> B is -(*N)-> (nothing is stronger than this)
+ *
+ */
+static inline bool hlock_equal(struct lock_list *entry, void *data)
 {
-	return entry->class == data;
+	struct held_lock *hlock = (struct held_lock *)data;
+
+	return hlock_class(hlock) == entry->class && /* Found A -> .. -> B */
+	       (hlock->read == 2 ||  /* A -> B is -(*R)-> */
+		!entry->only_xr); /* A -> .. -> B is -(*N)-> */
 }
 
 /*
@@ -2045,10 +2075,21 @@ check_redundant(struct held_lock *src, struct held_lock *target)
 	struct lock_list src_entry;
 
 	bfs_init_root(&src_entry, src);
+	/*
+	 * Special setup for check_redundant().
+	 *
+	 * To report redundant, we need to find a strong dependency path that
+	 * is equal to or stronger than <src> -> <target>. So if <src> is E,
+	 * we need to let __bfs() only search for a path starting at a -(E*)->,
+	 * we achieve this by setting the initial node's ->only_xr to true in
+	 * that case. And if <prev> is S, we set initial ->only_xr to false
+	 * because both -(S*)-> (equal) and -(E*)-> (stronger) are redundant.
+	 */
+	src_entry.only_xr = src->read == 0;
 
 	debug_atomic_inc(nr_redundant_checks);
 
-	ret = check_path(target, &src_entry, class_equal, &target_entry);
+	ret = check_path(target, &src_entry, hlock_equal, &target_entry);
 
 	if (ret == BFS_RMATCH)
 		debug_atomic_inc(nr_redundant);
