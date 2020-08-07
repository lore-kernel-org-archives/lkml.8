Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69442C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 419AF206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUQNOlH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgHGHnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:43:40 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFCFC061574;
        Fri,  7 Aug 2020 00:43:40 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so674825qtp.1;
        Fri, 07 Aug 2020 00:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J2yDvrGcRomvDIZCEhBiZtIPeC0YjamKTb4jWK/ybyM=;
        b=UUQNOlH7lH720JLQsLiXMovG8Mua45qWj9vr3J4Y1g0hZuweaD5hNsCCy7oR6OBDTF
         8qiOQrOAhLlYKk/aG8OO7Wo4vL4ch7ugPz+CKULRzyZTgjgNR4lwP0/lfJPskabxkJkB
         yjWPBa3PS7xYoWWuxouRBW1V5SIg7iqHCfz8BAXSAQWMZ/hGNMPu3Z/iIswibMXAbuuA
         sI26egEUNMoWW4V6vjiAp40myQ2mgOzImLnuJMMAGWNfJTwVHdUVYv37s3wOcJ/xISPJ
         5qTcWRatJyyf/Ur29rFD1vXblS8gYel+2ArfBOjObUfXnWOsfyxhfhkmuopZ/fu5FB0D
         BjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J2yDvrGcRomvDIZCEhBiZtIPeC0YjamKTb4jWK/ybyM=;
        b=OM19On85HDm7EnEnrNV2ayCMH4iOsyWe8uZ2d3qqgn6hFkomGkiNlO2RgWnvNfEzvX
         FTB6zwYYwrSlm1WuqyyQ7XW2i4JAfo88y5CEmmXYc0HTxFSZMChgQZyLS9OQhPEbtAou
         bF5Pvxs1S9ThihEtxDhTa58H/alDNYG4jejNmhHrn0ByWZ24M1JH7TDh76lhdO7/af4E
         WcJG4Zh5UpQWWqFbXSSN4qLFN1asiBFvBq0NLp682UJxT4f9wVVlbB6CRxEbTxQzUBGU
         9pywHwJUteL78iUmPF32+XSS9c1V9w1pcbJ796l01Ct6g/sNE4Nbkj2pPTR4PfD4RmyM
         DQww==
X-Gm-Message-State: AOAM530bMfELWMtDoTtSy+epzpizjXwDrSaHMQyOeT5CaUbB65QVPN5w
        7eI+pvkqO2SrnpqV3lldt6o=
X-Google-Smtp-Source: ABdhPJzTK8gBjQX4RS/sk/pdy/0Vfa47L4RMWzN2J0oiwj4J+h1ovxX2G6bwQBvl9EZ7bBGuxl6gTQ==
X-Received: by 2002:ac8:7402:: with SMTP id p2mr12661780qtq.19.1596786218585;
        Fri, 07 Aug 2020 00:43:38 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id c22sm6208601qke.2.2020.08.07.00.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:43:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id B7CFB27C0054;
        Fri,  7 Aug 2020 03:43:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:43:37 -0400
X-ME-Sender: <xms:KQYtXwF7ctr8cuCKIYTVRg0eUAcsHwtIGFbQGSzl68DO3TMWZ_l2Ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    dvnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:KQYtX5VhI2i_BxA-e8sNsqIaNPnJQ_V6K3CT52wfbndtoSXF-2085Q>
    <xmx:KQYtX6LCeENcqu9eQEWkzdWu8TxBMOEPyZdmPAArG_LVWoXk0PLDkA>
    <xmx:KQYtXyHXg2c_PUmRoK_iP0htdotZ_GWcwaNOZxHavC8EjSynC6B-Aw>
    <xmx:KQYtX0xQs-P7G8KqSHAVQ2RVfSmOE874cMoVcq8Z6cAhmaYqj9aqig>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id B1F71328005D;
        Fri,  7 Aug 2020 03:43:36 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 04/19] lockdep: Make __bfs() visit every dependency until a match
Date:   Fri,  7 Aug 2020 15:42:23 +0800
Message-Id: <20200807074238.1632519-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/locking/lockdep.c | 61 +++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 8fba156db5ba..2d9798b71f74 100644
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
-- 
2.28.0

