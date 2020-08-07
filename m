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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B34C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7D9206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhERx0ld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHGHo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:44:25 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E32C061574;
        Fri,  7 Aug 2020 00:44:25 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id t6so361770qvw.1;
        Fri, 07 Aug 2020 00:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YoWZu7deZusQ4AggwKwmLNQ+ekQIbNVqH9V7+ZDf/IQ=;
        b=OhERx0ldA0qTJQECZZUdTRYj0Fkvh/PeoqkDdLydTBDsqg7bIBfNn4bHu1a7AfPBO8
         SGHSwwJ6vzvpFCWUDcnqIb5YF236RL10p2ap9n+fnOyY7xMv4woeA0MLZOsrNPAx4rhO
         itKhv9I5UFktjpQ6bEr2jseMCkcBz4uA8BOyzGm0ICc/Os2lrk+8PHD2xKQWdPK5iZIu
         WBaEOo2OKXGX0ffKumKlfQp/8JapikkQOQmahU9a66RKg1XxgKy8L8KdqNFwRqtjHM8k
         wNT1AcEgE47ootH4Q+PS8iRG6DmM0INNypJn+JMHe2SxTR5650z6hLS6vgxaZ1HjGvLn
         ONOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YoWZu7deZusQ4AggwKwmLNQ+ekQIbNVqH9V7+ZDf/IQ=;
        b=NxSJSHR8vYrOP8VvirKe1dCRcVUPCTmoVRPoL+dFLIcm2XRu1wwopaNMvCzAwd+RvA
         rJqoq1KHX/d0ekLRACPffh//U7sS0FDWXXear8hEvNqiBJbtBbJS5tIB/FRPYf3hm4TW
         GRIq5PH+abBR8Wv3ygtOAcd00qKjaez3YTfAk0K0fB/5Xs0T2OKSWA2j42AAmHM3ZDLw
         5PEwaf5k6Dysa9tMEcI8l+IYuuiuWQ4GjsiS/8bN7m11zn6SdpHzBu7jWa8Bm42HDU3n
         Y5n3ARE3x9FTNWFuO5HBZ4rsI0TvANJwmRcGP226T6XK2CUqtn5AyTXvgxYgnc2tABw/
         qoaw==
X-Gm-Message-State: AOAM531HhhbFb/gzPKldhxeyCfk+ywhNfifkd0TRZcM263yI1o9xEi3v
        xsFARLMLhE3UaRaGxBk8Gy4=
X-Google-Smtp-Source: ABdhPJzIE1h5yd0wxPZwx/AxLawn/CVR23NO9+98eaK1KK6YXBW/uJK6ZtU+IDNydGTqLmYhHrzbEw==
X-Received: by 2002:a0c:9cc4:: with SMTP id j4mr13021052qvf.230.1596786264155;
        Fri, 07 Aug 2020 00:44:24 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id y7sm7243411qta.36.2020.08.07.00.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:44:23 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 3177E27C0058;
        Fri,  7 Aug 2020 03:44:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:44:23 -0400
X-ME-Sender: <xms:VwYtX9VbzZnn1MF9u-_Pmy4TvCEu07y3l-HG32eczScihJOoGpWgbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    ehnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:VwYtX9mTQ6PmV6zwnpP7EE4etmZ4JZ27DVKW7wgNX6s5k4ShVgeKPw>
    <xmx:VwYtX5ZBB6wndRZ9277Wy6K1t5ln6uTAMt1HKaxsv85pY9LWwbNDxA>
    <xmx:VwYtXwUdL5Nv-hyIuhwW4kl_XXxZ88EJD9cuh2xJr7E7yyS9r4Dv-w>
    <xmx:VwYtXwDdf9PsYAcyjHh46BdUJ8Mzy0IjBi_fJ8AJN-rPkRttLKR6Fw>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 59CFA30600B9;
        Fri,  7 Aug 2020 03:44:20 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 07/19] lockdep: Extend __bfs() to work with multiple types of dependencies
Date:   Fri,  7 Aug 2020 15:42:26 +0800
Message-Id: <20200807074238.1632519-8-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we have four types of dependencies in the dependency graph, and not
all the pathes carry real dependencies (the dependencies that may cause
a deadlock), for example:

	Given lock A and B, if we have:

	CPU1			CPU2
	=============		==============
	write_lock(A);		read_lock(B);
	read_lock(B);		write_lock(A);

	(assuming read_lock(B) is a recursive reader)

	then we have dependencies A -(ER)-> B, and B -(SN)-> A, and a
	dependency path A -(ER)-> B -(SN)-> A.

	In lockdep w/o recursive locks, a dependency path from A to A
	means a deadlock. However, the above case is obviously not a
	deadlock, because no one holds B exclusively, therefore no one
	waits for the other to release B, so who get A first in CPU1 and
	CPU2 will run non-blockingly.

	As a result, dependency path A -(ER)-> B -(SN)-> A is not a
	real/strong dependency that could cause a deadlock.

From the observation above, we know that for a dependency path to be
real/strong, no two adjacent dependencies can be as -(*R)-> -(S*)->.

Now our mission is to make __bfs() traverse only the strong dependency
paths, which is simple: we record whether we only have -(*R)-> for the
previous lock_list of the path in lock_list::only_xr, and when we pick a
dependency in the traverse, we 1) filter out -(S*)-> dependency if the
previous lock_list only has -(*R)-> dependency (i.e. ->only_xr is true)
and 2) set the next lock_list::only_xr to true if we only have -(*R)->
left after we filter out dependencies based on 1), otherwise, set it to
false.

With this extension for __bfs(), we now need to initialize the root of
__bfs() properly (with a correct ->only_xr), to do so, we introduce some
helper functions, which also cleans up a little bit for the __bfs() root
initialization code.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/lockdep.h  |   2 +
 kernel/locking/lockdep.c | 113 ++++++++++++++++++++++++++++++++-------
 2 files changed, 96 insertions(+), 19 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 6ca0315d92c4..0b26d5d26411 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -215,6 +215,8 @@ struct lock_list {
 	u16				distance;
 	/* bitmap of different dependencies from head to this */
 	u8				dep;
+	/* used by BFS to record whether "prev -> this" only has -(*R)-> */
+	u8				only_xr;
 
 	/*
 	 * The parent field is used to implement breadth-first search, and the
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index edf0cc261e8e..bb8b7e42c154 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1551,8 +1551,72 @@ static inline u8 calc_depb(struct held_lock *prev, struct held_lock *next)
 }
 
 /*
- * Forward- or backward-dependency search, used for both circular dependency
- * checking and hardirq-unsafe/softirq-unsafe checking.
+ * Initialize a lock_list entry @lock belonging to @class as the root for a BFS
+ * search.
+ */
+static inline void __bfs_init_root(struct lock_list *lock,
+				   struct lock_class *class)
+{
+	lock->class = class;
+	lock->parent = NULL;
+	lock->only_xr = 0;
+}
+
+/*
+ * Initialize a lock_list entry @lock based on a lock acquisition @hlock as the
+ * root for a BFS search.
+ *
+ * ->only_xr of the initial lock node is set to @hlock->read == 2, to make sure
+ * that <prev> -> @hlock and @hlock -> <whatever __bfs() found> is not -(*R)->
+ * and -(S*)->.
+ */
+static inline void bfs_init_root(struct lock_list *lock,
+				 struct held_lock *hlock)
+{
+	__bfs_init_root(lock, hlock_class(hlock));
+	lock->only_xr = (hlock->read == 2);
+}
+
+/*
+ * Similar to bfs_init_root() but initialize the root for backwards BFS.
+ *
+ * ->only_xr of the initial lock node is set to @hlock->read != 0, to make sure
+ * that <next> -> @hlock and @hlock -> <whatever backwards BFS found> is not
+ * -(*S)-> and -(R*)-> (reverse order of -(*R)-> and -(S*)->).
+ */
+static inline void bfs_init_rootb(struct lock_list *lock,
+				  struct held_lock *hlock)
+{
+	__bfs_init_root(lock, hlock_class(hlock));
+	lock->only_xr = (hlock->read != 0);
+}
+
+/*
+ * Breadth-First Search to find a strong path in the dependency graph.
+ *
+ * @source_entry: the source of the path we are searching for.
+ * @data: data used for the second parameter of @match function
+ * @match: match function for the search
+ * @target_entry: pointer to the target of a matched path
+ * @offset: the offset to struct lock_class to determine whether it is
+ *          locks_after or locks_before
+ *
+ * We may have multiple edges (considering different kinds of dependencies,
+ * e.g. ER and SN) between two nodes in the dependency graph. But
+ * only the strong dependency path in the graph is relevant to deadlocks. A
+ * strong dependency path is a dependency path that doesn't have two adjacent
+ * dependencies as -(*R)-> -(S*)->, please see:
+ *
+ *         Documentation/locking/lockdep-design.rst
+ *
+ * for more explanation of the definition of strong dependency paths
+ *
+ * In __bfs(), we only traverse in the strong dependency path:
+ *
+ *     In lock_list::only_xr, we record whether the previous dependency only
+ *     has -(*R)-> in the search, and if it does (prev only has -(*R)->), we
+ *     filter out any -(S*)-> in the current dependency and after that, the
+ *     ->only_xr is set according to whether we only have -(*R)-> left.
  */
 static enum bfs_result __bfs(struct lock_list *source_entry,
 			     void *data,
@@ -1582,6 +1646,7 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 	__cq_enqueue(cq, source_entry);
 
 	while ((lock = __cq_dequeue(cq))) {
+		bool prev_only_xr;
 
 		if (!lock->class) {
 			ret = BFS_EINVALIDNODE;
@@ -1602,10 +1667,26 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 
 		head = get_dep_list(lock, offset);
 
-		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
+		prev_only_xr = lock->only_xr;
 
 		list_for_each_entry_rcu(entry, head, entry) {
 			unsigned int cq_depth;
+			u8 dep = entry->dep;
+
+			/*
+			 * Mask out all -(S*)-> if we only have *R in previous
+			 * step, because -(*R)-> -(S*)-> don't make up a strong
+			 * dependency.
+			 */
+			if (prev_only_xr)
+				dep &= ~(DEP_SR_MASK | DEP_SN_MASK);
+
+			/* If nothing left, we skip */
+			if (!dep)
+				continue;
+
+			/* If there are only -(*R)-> left, set that for the next step */
+			entry->only_xr = !(dep & (DEP_SN_MASK | DEP_EN_MASK));
 
 			visit_lock_entry(entry, lock);
 			if (match(entry, data)) {
@@ -1827,8 +1908,7 @@ unsigned long lockdep_count_forward_deps(struct lock_class *class)
 	unsigned long ret, flags;
 	struct lock_list this;
 
-	this.parent = NULL;
-	this.class = class;
+	__bfs_init_root(&this, class);
 
 	raw_local_irq_save(flags);
 	lockdep_lock();
@@ -1854,8 +1934,7 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
 	unsigned long ret, flags;
 	struct lock_list this;
 
-	this.parent = NULL;
-	this.class = class;
+	__bfs_init_root(&this, class);
 
 	raw_local_irq_save(flags);
 	lockdep_lock();
@@ -1898,10 +1977,9 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
 {
 	enum bfs_result ret;
 	struct lock_list *uninitialized_var(target_entry);
-	struct lock_list src_entry = {
-		.class = hlock_class(src),
-		.parent = NULL,
-	};
+	struct lock_list src_entry;
+
+	bfs_init_root(&src_entry, src);
 
 	debug_atomic_inc(nr_cyclic_checks);
 
@@ -1937,10 +2015,9 @@ check_redundant(struct held_lock *src, struct held_lock *target)
 {
 	enum bfs_result ret;
 	struct lock_list *uninitialized_var(target_entry);
-	struct lock_list src_entry = {
-		.class = hlock_class(src),
-		.parent = NULL,
-	};
+	struct lock_list src_entry;
+
+	bfs_init_root(&src_entry, src);
 
 	debug_atomic_inc(nr_redundant_checks);
 
@@ -3556,8 +3633,7 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
 
-	root.parent = NULL;
-	root.class = hlock_class(this);
+	bfs_init_root(&root, this);
 	ret = find_usage_forwards(&root, lock_flag(bit), &target_entry);
 	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
@@ -3583,8 +3659,7 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
 
-	root.parent = NULL;
-	root.class = hlock_class(this);
+	bfs_init_rootb(&root, this);
 	ret = find_usage_backwards(&root, lock_flag(bit), &target_entry);
 	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
-- 
2.28.0

