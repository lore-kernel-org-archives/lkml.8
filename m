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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCB3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 628DC21744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOEaPQBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHGHpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:45:10 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D31C061574;
        Fri,  7 Aug 2020 00:45:09 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id x7so354864qvi.5;
        Fri, 07 Aug 2020 00:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kp4jbiIzgmIRPUbd9BxQnw0jto/l+BqUQCH3yC0O9LY=;
        b=JOEaPQBhdIAav3NLHctGAvYL1SRdows+Rl8/G7BqsAgn1J5JsizLMGdP7qRG6bcdNB
         Onv/87oa9eGUKXPka3nV+e5wMm8oSBeSZbhhSRdxgEpusc5L4UA53wlharn+usP/ObVj
         Ba+RWeJFmS/u5wgxEDVYPv8DZk4S3mpTJlhzPfa7/ZdAU95FlIpPvh+Nc+M9i1f40LgH
         UVsWx1LHngq7cTuus+jOiUDoF8iWsN8Wpy1cepddy9/Z8rvKmQZt/tKdlDGYRhA+M4ds
         pg1W2Lo97W9WOYLr90eS2gz1sZCdiEatmVg9UCNkDDqB6kSvcLHJSy1mCb4mBMKTAdcM
         HKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kp4jbiIzgmIRPUbd9BxQnw0jto/l+BqUQCH3yC0O9LY=;
        b=heISyOt6PbVx1ewmqCwiWB+t9cdgIeAKSPEIV4L8QTb7jANs2UsmT55Q7HEwuoQetb
         LF70cqOvGCrFFSpMSNdrLiSatvJAMG3l7Vz6KSfmYukmOLddWZjOsjyjgAdg9MwUymQz
         7lo/bDvyl2SDBDdQ81+mxG+tK2NxUyjzmKEmcPkxW117ZUD/+0hU4C8EmFCakzsG7n4Y
         gcX9cXqyYpp9udV7H5xJea46Rdhvh/PLwwDccqr/cK8EQAbAhqPrRGsQVk5qBdDmqB62
         JPjnYEIO8HsOHnnfq2EPItR538TZZkcGmNC362naWUninPsXKKeiTHZpMWsDXQQkciTD
         ubNg==
X-Gm-Message-State: AOAM532JMMVPJbnY2Xbb8yU03vY3csGzN9MfTyYtUxgWdPVED+FA5krr
        C/BJ4sBvOS2LDYgfZl4XjLs=
X-Google-Smtp-Source: ABdhPJzoMhoVhd3pYILzlt/nwNWx3hwswjXfgeFS4sQBzuuU8aT+OH9ZiSLDijQbvM78qAyiGy+rlg==
X-Received: by 2002:a05:6214:11f3:: with SMTP id e19mr13340395qvu.220.1596786307519;
        Fri, 07 Aug 2020 00:45:07 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id f31sm7246395qte.35.2020.08.07.00.45.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:45:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7910C27C0058;
        Fri,  7 Aug 2020 03:45:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:45:06 -0400
X-ME-Sender: <xms:ggYtX1xU-WASzjFkhHzavA090y2qmxphi7h7m2ATXFV47ocrKsdKCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ggYtX1SvuSC_kPatAwhkgYcdb2A4h-02bHcppnM5AWaocW-QXJxEvw>
    <xmx:ggYtX_V2ZTOnYfuq5aID-Z60ZXBxdzIYW7l3xZyMQ6gSs3BQ3LLPWg>
    <xmx:ggYtX3gw02_3QAhPk_IXZJh7rEMmkl91n6Ru8pawbCE7EiIsEObt3w>
    <xmx:ggYtXy9ErbwMc8s4XJVI8rh0Xs5qn-NaLhm9lJjP5tLjJ1N1fpbInQ>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 03DD130600A3;
        Fri,  7 Aug 2020 03:45:04 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 11/19] lockdep: Fix recursive read lock related safe->unsafe detection
Date:   Fri,  7 Aug 2020 15:42:30 +0800
Message-Id: <20200807074238.1632519-12-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, in safe->unsafe detection, lockdep misses the fact that a
LOCK_ENABLED_IRQ_*_READ usage and a LOCK_USED_IN_IRQ_*_READ usage may
cause deadlock too, for example:

	P1                          P2
	<irq disabled>
	write_lock(l1);             <irq enabled>
				    read_lock(l2);
	write_lock(l2);
				    <in irq>
				    read_lock(l1);

Actually, all of the following cases may cause deadlocks:

	LOCK_USED_IN_IRQ_* -> LOCK_ENABLED_IRQ_*
	LOCK_USED_IN_IRQ_*_READ -> LOCK_ENABLED_IRQ_*
	LOCK_USED_IN_IRQ_* -> LOCK_ENABLED_IRQ_*_READ
	LOCK_USED_IN_IRQ_*_READ -> LOCK_ENABLED_IRQ_*_READ

To fix this, we need to 1) change the calculation of exclusive_mask() so
that READ bits are not dropped and 2) always call usage() in
mark_lock_irq() to check usage deadlocks, even when the new usage of the
lock is READ.

Besides, adjust usage_match() and usage_acculumate() to recursive read
lock changes.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 183 +++++++++++++++++++++++++++++----------
 1 file changed, 138 insertions(+), 45 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 85a4d3539faa..040509667798 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2100,22 +2100,72 @@ check_redundant(struct held_lock *src, struct held_lock *target)
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 
+/*
+ * Forwards and backwards subgraph searching, for the purposes of
+ * proving that two subgraphs can be connected by a new dependency
+ * without creating any illegal irq-safe -> irq-unsafe lock dependency.
+ *
+ * A irq safe->unsafe deadlock happens with the following conditions:
+ *
+ * 1) We have a strong dependency path A -> ... -> B
+ *
+ * 2) and we have ENABLED_IRQ usage of B and USED_IN_IRQ usage of A, therefore
+ *    irq can create a new dependency B -> A (consider the case that a holder
+ *    of B gets interrupted by an irq whose handler will try to acquire A).
+ *
+ * 3) the dependency circle A -> ... -> B -> A we get from 1) and 2) is a
+ *    strong circle:
+ *
+ *      For the usage bits of B:
+ *        a) if A -> B is -(*N)->, then B -> A could be any type, so any
+ *           ENABLED_IRQ usage suffices.
+ *        b) if A -> B is -(*R)->, then B -> A must be -(E*)->, so only
+ *           ENABLED_IRQ_*_READ usage suffices.
+ *
+ *      For the usage bits of A:
+ *        c) if A -> B is -(E*)->, then B -> A could be any type, so any
+ *           USED_IN_IRQ usage suffices.
+ *        d) if A -> B is -(S*)->, then B -> A must be -(*N)->, so only
+ *           USED_IN_IRQ_*_READ usage suffices.
+ */
+
+/*
+ * There is a strong dependency path in the dependency graph: A -> B, and now
+ * we need to decide which usage bit of A should be accumulated to detect
+ * safe->unsafe bugs.
+ *
+ * Note that usage_accumulate() is used in backwards search, so ->only_xr
+ * stands for whether A -> B only has -(S*)-> (in this case ->only_xr is true).
+ *
+ * As above, if only_xr is false, which means A -> B has -(E*)-> dependency
+ * path, any usage of A should be considered. Otherwise, we should only
+ * consider _READ usage.
+ */
 static inline bool usage_accumulate(struct lock_list *entry, void *mask)
 {
-	*(unsigned long *)mask |= entry->class->usage_mask;
+	if (!entry->only_xr)
+		*(unsigned long *)mask |= entry->class->usage_mask;
+	else /* Mask out _READ usage bits */
+		*(unsigned long *)mask |= (entry->class->usage_mask & LOCKF_IRQ);
 
 	return false;
 }
 
 /*
- * Forwards and backwards subgraph searching, for the purposes of
- * proving that two subgraphs can be connected by a new dependency
- * without creating any illegal irq-safe -> irq-unsafe lock dependency.
+ * There is a strong dependency path in the dependency graph: A -> B, and now
+ * we need to decide which usage bit of B conflicts with the usage bits of A,
+ * i.e. which usage bit of B may introduce safe->unsafe deadlocks.
+ *
+ * As above, if only_xr is false, which means A -> B has -(*N)-> dependency
+ * path, any usage of B should be considered. Otherwise, we should only
+ * consider _READ usage.
  */
-
 static inline bool usage_match(struct lock_list *entry, void *mask)
 {
-	return !!(entry->class->usage_mask & *(unsigned long *)mask);
+	if (!entry->only_xr)
+		return !!(entry->class->usage_mask & *(unsigned long *)mask);
+	else /* Mask out _READ usage bits */
+		return !!((entry->class->usage_mask & LOCKF_IRQ) & *(unsigned long *)mask);
 }
 
 /*
@@ -2406,17 +2456,39 @@ static unsigned long invert_dir_mask(unsigned long mask)
 }
 
 /*
- * As above, we clear bitnr0 (LOCK_*_READ off) with bitmask ops. First, for all
- * bits with bitnr0 set (LOCK_*_READ), add those with bitnr0 cleared (LOCK_*).
- * And then mask out all bitnr0.
+ * Note that a LOCK_ENABLED_IRQ_*_READ usage and a LOCK_USED_IN_IRQ_*_READ
+ * usage may cause deadlock too, for example:
+ *
+ * P1				P2
+ * <irq disabled>
+ * write_lock(l1);		<irq enabled>
+ *				read_lock(l2);
+ * write_lock(l2);
+ * 				<in irq>
+ * 				read_lock(l1);
+ *
+ * , in above case, l1 will be marked as LOCK_USED_IN_IRQ_HARDIRQ_READ and l2
+ * will marked as LOCK_ENABLE_IRQ_HARDIRQ_READ, and this is a possible
+ * deadlock.
+ *
+ * In fact, all of the following cases may cause deadlocks:
+ *
+ * 	 LOCK_USED_IN_IRQ_* -> LOCK_ENABLED_IRQ_*
+ * 	 LOCK_USED_IN_IRQ_*_READ -> LOCK_ENABLED_IRQ_*
+ * 	 LOCK_USED_IN_IRQ_* -> LOCK_ENABLED_IRQ_*_READ
+ * 	 LOCK_USED_IN_IRQ_*_READ -> LOCK_ENABLED_IRQ_*_READ
+ *
+ * As a result, to calculate the "exclusive mask", first we invert the
+ * direction (USED_IN/ENABLED) of the original mask, and 1) for all bits with
+ * bitnr0 set (LOCK_*_READ), add those with bitnr0 cleared (LOCK_*). 2) for all
+ * bits with bitnr0 cleared (LOCK_*_READ), add those with bitnr0 set (LOCK_*).
  */
 static unsigned long exclusive_mask(unsigned long mask)
 {
 	unsigned long excl = invert_dir_mask(mask);
 
-	/* Strip read */
 	excl |= (excl & LOCKF_IRQ_READ) >> LOCK_USAGE_READ_MASK;
-	excl &= ~LOCKF_IRQ_READ;
+	excl |= (excl & LOCKF_IRQ) << LOCK_USAGE_READ_MASK;
 
 	return excl;
 }
@@ -2433,6 +2505,7 @@ static unsigned long original_mask(unsigned long mask)
 	unsigned long excl = invert_dir_mask(mask);
 
 	/* Include read in existing usages */
+	excl |= (excl & LOCKF_IRQ_READ) >> LOCK_USAGE_READ_MASK;
 	excl |= (excl & LOCKF_IRQ) << LOCK_USAGE_READ_MASK;
 
 	return excl;
@@ -2447,14 +2520,24 @@ static int find_exclusive_match(unsigned long mask,
 				enum lock_usage_bit *bitp,
 				enum lock_usage_bit *excl_bitp)
 {
-	int bit, excl;
+	int bit, excl, excl_read;
 
 	for_each_set_bit(bit, &mask, LOCK_USED) {
+		/*
+		 * exclusive_bit() strips the read bit, however,
+		 * LOCK_ENABLED_IRQ_*_READ may cause deadlocks too, so we need
+		 * to search excl | LOCK_USAGE_READ_MASK as well.
+		 */
 		excl = exclusive_bit(bit);
+		excl_read = excl | LOCK_USAGE_READ_MASK;
 		if (excl_mask & lock_flag(excl)) {
 			*bitp = bit;
 			*excl_bitp = excl;
 			return 0;
+		} else if (excl_mask & lock_flag(excl_read)) {
+			*bitp = bit;
+			*excl_bitp = excl_read;
+			return 0;
 		}
 	}
 	return -1;
@@ -2480,8 +2563,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	 * Step 1: gather all hard/soft IRQs usages backward in an
 	 * accumulated usage mask.
 	 */
-	this.parent = NULL;
-	this.class = hlock_class(prev);
+	bfs_init_rootb(&this, prev);
 
 	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL);
 	if (bfs_error(ret)) {
@@ -2499,8 +2581,7 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
 	 */
 	forward_mask = exclusive_mask(usage_mask);
 
-	that.parent = NULL;
-	that.class = hlock_class(next);
+	bfs_init_root(&that, next);
 
 	ret = find_usage_forwards(&that, forward_mask, &target_entry1);
 	if (bfs_error(ret)) {
@@ -3695,14 +3776,16 @@ print_irq_inversion_bug(struct task_struct *curr,
  */
 static int
 check_usage_forwards(struct task_struct *curr, struct held_lock *this,
-		     enum lock_usage_bit bit, const char *irqclass)
+		     enum lock_usage_bit bit)
 {
 	enum bfs_result ret;
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
+	enum lock_usage_bit read_bit = bit + LOCK_USAGE_READ_MASK;
+	unsigned usage_mask = lock_flag(bit) | lock_flag(read_bit);
 
 	bfs_init_root(&root, this);
-	ret = find_usage_forwards(&root, lock_flag(bit), &target_entry);
+	ret = find_usage_forwards(&root, usage_mask, &target_entry);
 	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
@@ -3710,8 +3793,13 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
 	if (ret == BFS_RNOMATCH)
 		return 1;
 
-	print_irq_inversion_bug(curr, &root, target_entry,
-				this, 1, irqclass);
+	/* Check whether write or read usage is the match */
+	if (target_entry->class->usage_mask & lock_flag(bit))
+		print_irq_inversion_bug(curr, &root, target_entry,
+					this, 1, state_name(bit));
+	else
+		print_irq_inversion_bug(curr, &root, target_entry,
+					this, 1, state_name(read_bit));
 	return 0;
 }
 
@@ -3721,14 +3809,16 @@ check_usage_forwards(struct task_struct *curr, struct held_lock *this,
  */
 static int
 check_usage_backwards(struct task_struct *curr, struct held_lock *this,
-		      enum lock_usage_bit bit, const char *irqclass)
+		      enum lock_usage_bit bit)
 {
 	enum bfs_result ret;
 	struct lock_list root;
 	struct lock_list *uninitialized_var(target_entry);
+	enum lock_usage_bit read_bit = bit + LOCK_USAGE_READ_MASK;
+	unsigned usage_mask = lock_flag(bit) | lock_flag(read_bit);
 
 	bfs_init_rootb(&root, this);
-	ret = find_usage_backwards(&root, lock_flag(bit), &target_entry);
+	ret = find_usage_backwards(&root, usage_mask, &target_entry);
 	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
@@ -3736,8 +3826,14 @@ check_usage_backwards(struct task_struct *curr, struct held_lock *this,
 	if (ret == BFS_RNOMATCH)
 		return 1;
 
-	print_irq_inversion_bug(curr, &root, target_entry,
-				this, 0, irqclass);
+	/* Check whether write or read usage is the match */
+	if (target_entry->class->usage_mask & lock_flag(bit))
+		print_irq_inversion_bug(curr, &root, target_entry,
+					this, 0, state_name(bit));
+	else
+		print_irq_inversion_bug(curr, &root, target_entry,
+					this, 0, state_name(read_bit));
+
 	return 0;
 }
 
@@ -3800,16 +3896,6 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 	int read = new_bit & LOCK_USAGE_READ_MASK;
 	int dir = new_bit & LOCK_USAGE_DIR_MASK;
 
-	/*
-	 * mark USED_IN has to look forwards -- to ensure no dependency
-	 * has ENABLED state, which would allow recursion deadlocks.
-	 *
-	 * mark ENABLED has to look backwards -- to ensure no dependee
-	 * has USED_IN state, which, again, would allow  recursion deadlocks.
-	 */
-	check_usage_f usage = dir ?
-		check_usage_backwards : check_usage_forwards;
-
 	/*
 	 * Validate that this particular lock does not have conflicting
 	 * usage states.
@@ -3818,23 +3904,30 @@ mark_lock_irq(struct task_struct *curr, struct held_lock *this,
 		return 0;
 
 	/*
-	 * Validate that the lock dependencies don't have conflicting usage
-	 * states.
+	 * Check for read in write conflicts
 	 */
-	if ((!read || STRICT_READ_CHECKS) &&
-			!usage(curr, this, excl_bit, state_name(new_bit & ~LOCK_USAGE_READ_MASK)))
+	if (!read && !valid_state(curr, this, new_bit,
+				  excl_bit + LOCK_USAGE_READ_MASK))
 		return 0;
 
+
 	/*
-	 * Check for read in write conflicts
+	 * Validate that the lock dependencies don't have conflicting usage
+	 * states.
 	 */
-	if (!read) {
-		if (!valid_state(curr, this, new_bit, excl_bit + LOCK_USAGE_READ_MASK))
+	if (dir) {
+		/*
+		 * mark ENABLED has to look backwards -- to ensure no dependee
+		 * has USED_IN state, which, again, would allow  recursion deadlocks.
+		 */
+		if (!check_usage_backwards(curr, this, excl_bit))
 			return 0;
-
-		if (STRICT_READ_CHECKS &&
-			!usage(curr, this, excl_bit + LOCK_USAGE_READ_MASK,
-				state_name(new_bit + LOCK_USAGE_READ_MASK)))
+	} else {
+		/*
+		 * mark USED_IN has to look forwards -- to ensure no dependency
+		 * has ENABLED state, which would allow recursion deadlocks.
+		 */
+		if (!check_usage_forwards(curr, this, excl_bit))
 			return 0;
 	}
 
-- 
2.28.0

