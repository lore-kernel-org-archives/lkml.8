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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D65DC433E3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710E522CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeV+cPLs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHGHpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:45:49 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D6FC061575;
        Fri,  7 Aug 2020 00:45:48 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b25so674354qto.2;
        Fri, 07 Aug 2020 00:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ti7198ZO6Tw7UAENrO4tj4DQ46O0LPvCqAsxSveIfz4=;
        b=XeV+cPLsHQhJAwhQSczJa/21m/qbYCktLMSi9iJ+82AoZwMOfTUnxFLwSvE490c913
         ykINCcmKI1yaulrPQwqH+zXKfXYZuTiV3Lj1ipzYRJCoouz3nRoN9dO6Bxz2NJArv5UD
         EzL3kZnyrQoX8wjzULga5tZ4W8ad9Ttg7c7wTBc46QDKa3V1fjQYSG4nvc9TbNteUKld
         c/5oH3jyZU/myeJg10Vy9RB99WX1uMzoi2P735Iv0QJ5cdR0kwopX68Jnbyz66JBKeWd
         /Ug3La6OmifCgh0qK5mEbQTHOg1wJxJImYIa1qSTzQRMfHm1ngguOdilE4kttpw3kxJi
         Asww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ti7198ZO6Tw7UAENrO4tj4DQ46O0LPvCqAsxSveIfz4=;
        b=d9Q60TUPP6pMH0YZkbN2HWucM2sIsD2fomhb+UNavWYSnLAYnGlzdQom+iGFhDfXsZ
         ANZFHsISPz/lpaODXHATiykgy4BwAleqxqlGz7QWqRRkDKshvEVF2IP1dVM56Qm3lzqG
         5qRLYXMA3T7Hug3GfVbjzTQYvZbURec8MXRY/eiLPDrWKijBbNjtWs8Kg0MMdyI2je5v
         KKAcbhWRl6fY5IET/Wz0CWiTvsxVR14dgH5dEI+OqOhNgzzJPVpONpPOuFC5vEowHMLK
         E4VlOAPf4vwEd2E5Wn/4kN5cy/qWk43zimjwQ93DZKT3y8yfcx3qZijXWshK+bXW49aC
         +gmQ==
X-Gm-Message-State: AOAM532Pm+cEEYMp3h32oVHWZ4PO5lP/rFC9Uq0SX8YmJpGgyqDftni6
        IRs1C2qIRzf7iahvy3szrpY=
X-Google-Smtp-Source: ABdhPJwIJKP9s8cVw5vdMN1qLsrS5DpUCCqZ5sNOluCIVHtQvsU6LFR2Wg47D7MXMTZDHX79XFS0AA==
X-Received: by 2002:aed:34e2:: with SMTP id x89mr12657876qtd.313.1596786348094;
        Fri, 07 Aug 2020 00:45:48 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id k11sm5759153qkk.93.2020.08.07.00.45.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:45:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2977227C0054;
        Fri,  7 Aug 2020 03:45:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:45:47 -0400
X-ME-Sender: <xms:qwYtX3XnijwXzQNfsNhg8CjbxbKvXlx4yodyU7IlttwuTCDY16ibVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    egnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:qwYtX_nG6bDY1DJZIQal67EioH3rpZON2L6ar7ZfPhQHrJjL6qF5Mg>
    <xmx:qwYtXzbGOa9aNhB9DbIGTBVYwwxbMJ3JImNKs40FhrGOR5_tImvaww>
    <xmx:qwYtXyVVWVY626IzMYkn5SxGV_4QipKCKXFDIOwnQMZ5lSJzbPMW-g>
    <xmx:qwYtX6A_7X4cLocFAMim1E8PBLjiggaeAH6EsUQGQrE7E_0_a2ZzZg>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 27AC13060067;
        Fri,  7 Aug 2020 03:45:45 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 14/19] lockdep: Take read/write status in consideration when generate chainkey
Date:   Fri,  7 Aug 2020 15:42:33 +0800
Message-Id: <20200807074238.1632519-15-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the chainkey of a lock chain is a hash sum of the class_idx
of all the held locks, the read/write status are not taken in to
consideration while generating the chainkey. This could result into a
problem, if we have:

	P1()
	{
		read_lock(B);
		lock(A);
	}

	P2()
	{
		lock(A);
		read_lock(B);
	}

	P3()
	{
		lock(A);
		write_lock(B);
	}

, and P1(), P2(), P3() run one by one. And when running P2(), lockdep
detects such a lock chain A -> B is not a deadlock, then it's added in
the chain cache, and then when running P3(), even if it's a deadlock, we
could miss it because of the hit of chain cache. This could be confirmed
by self testcase "chain cached mixed R-L/L-W ".

To resolve this, we use concept "hlock_id" to generate the chainkey, the
hlock_id is a tuple (hlock->class_idx, hlock->read), which fits in a u16
type. With this, the chainkeys are different is the lock sequences have
the same locks but different read/write status.

Besides, since we use "hlock_id" to generate chainkeys, the chain_hlocks
array now store the "hlock_id"s rather than lock_class indexes.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 53 ++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 867199c4b85d..f332d1b9d87b 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -371,6 +371,21 @@ static struct hlist_head classhash_table[CLASSHASH_SIZE];
 
 static struct hlist_head chainhash_table[CHAINHASH_SIZE];
 
+/*
+ * the id of held_lock
+ */
+static inline u16 hlock_id(struct held_lock *hlock)
+{
+	BUILD_BUG_ON(MAX_LOCKDEP_KEYS_BITS + 2 > 16);
+
+	return (hlock->class_idx | (hlock->read << MAX_LOCKDEP_KEYS_BITS));
+}
+
+static inline unsigned int chain_hlock_class_idx(u16 hlock_id)
+{
+	return hlock_id & MAX_LOCKDEP_KEYS;
+}
+
 /*
  * The hash key of the lock dependency chains is a hash itself too:
  * it's a hash of all locks taken up to that lock, including that lock.
@@ -3202,7 +3217,10 @@ static inline void free_chain_hlocks(int base, int size)
 
 struct lock_class *lock_chain_get_class(struct lock_chain *chain, int i)
 {
-	return lock_classes + chain_hlocks[chain->base + i];
+	u16 chain_hlock = chain_hlocks[chain->base + i];
+	unsigned int class_idx = chain_hlock_class_idx(chain_hlock);
+
+	return lock_classes + class_idx - 1;
 }
 
 /*
@@ -3228,12 +3246,12 @@ static inline int get_first_held_lock(struct task_struct *curr,
 /*
  * Returns the next chain_key iteration
  */
-static u64 print_chain_key_iteration(int class_idx, u64 chain_key)
+static u64 print_chain_key_iteration(u16 hlock_id, u64 chain_key)
 {
-	u64 new_chain_key = iterate_chain_key(chain_key, class_idx);
+	u64 new_chain_key = iterate_chain_key(chain_key, hlock_id);
 
-	printk(" class_idx:%d -> chain_key:%016Lx",
-		class_idx,
+	printk(" hlock_id:%d -> chain_key:%016Lx",
+		(unsigned int)hlock_id,
 		(unsigned long long)new_chain_key);
 	return new_chain_key;
 }
@@ -3250,12 +3268,12 @@ print_chain_keys_held_locks(struct task_struct *curr, struct held_lock *hlock_ne
 		hlock_next->irq_context);
 	for (; i < depth; i++) {
 		hlock = curr->held_locks + i;
-		chain_key = print_chain_key_iteration(hlock->class_idx, chain_key);
+		chain_key = print_chain_key_iteration(hlock_id(hlock), chain_key);
 
 		print_lock(hlock);
 	}
 
-	print_chain_key_iteration(hlock_next->class_idx, chain_key);
+	print_chain_key_iteration(hlock_id(hlock_next), chain_key);
 	print_lock(hlock_next);
 }
 
@@ -3263,14 +3281,14 @@ static void print_chain_keys_chain(struct lock_chain *chain)
 {
 	int i;
 	u64 chain_key = INITIAL_CHAIN_KEY;
-	int class_id;
+	u16 hlock_id;
 
 	printk("depth: %u\n", chain->depth);
 	for (i = 0; i < chain->depth; i++) {
-		class_id = chain_hlocks[chain->base + i];
-		chain_key = print_chain_key_iteration(class_id, chain_key);
+		hlock_id = chain_hlocks[chain->base + i];
+		chain_key = print_chain_key_iteration(hlock_id, chain_key);
 
-		print_lock_name(lock_classes + class_id);
+		print_lock_name(lock_classes + chain_hlock_class_idx(hlock_id) - 1);
 		printk("\n");
 	}
 }
@@ -3319,7 +3337,7 @@ static int check_no_collision(struct task_struct *curr,
 	}
 
 	for (j = 0; j < chain->depth - 1; j++, i++) {
-		id = curr->held_locks[i].class_idx;
+		id = hlock_id(&curr->held_locks[i]);
 
 		if (DEBUG_LOCKS_WARN_ON(chain_hlocks[chain->base + j] != id)) {
 			print_collision(curr, hlock, chain);
@@ -3368,7 +3386,6 @@ static inline int add_chain_cache(struct task_struct *curr,
 				  struct held_lock *hlock,
 				  u64 chain_key)
 {
-	struct lock_class *class = hlock_class(hlock);
 	struct hlist_head *hash_head = chainhashentry(chain_key);
 	struct lock_chain *chain;
 	int i, j;
@@ -3411,11 +3428,11 @@ static inline int add_chain_cache(struct task_struct *curr,
 
 	chain->base = j;
 	for (j = 0; j < chain->depth - 1; j++, i++) {
-		int lock_id = curr->held_locks[i].class_idx;
+		int lock_id = hlock_id(curr->held_locks + i);
 
 		chain_hlocks[chain->base + j] = lock_id;
 	}
-	chain_hlocks[chain->base + j] = class - lock_classes;
+	chain_hlocks[chain->base + j] = hlock_id(hlock);
 	hlist_add_head_rcu(&chain->entry, hash_head);
 	debug_atomic_inc(chain_lookup_misses);
 	inc_chains(chain->irq_context);
@@ -3602,7 +3619,7 @@ static void check_chain_key(struct task_struct *curr)
 		if (prev_hlock && (prev_hlock->irq_context !=
 							hlock->irq_context))
 			chain_key = INITIAL_CHAIN_KEY;
-		chain_key = iterate_chain_key(chain_key, hlock->class_idx);
+		chain_key = iterate_chain_key(chain_key, hlock_id(hlock));
 		prev_hlock = hlock;
 	}
 	if (chain_key != curr->curr_chain_key) {
@@ -4702,7 +4719,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 		chain_key = INITIAL_CHAIN_KEY;
 		chain_head = 1;
 	}
-	chain_key = iterate_chain_key(chain_key, class_idx);
+	chain_key = iterate_chain_key(chain_key, hlock_id(hlock));
 
 	if (nest_lock && !__lock_is_held(nest_lock, -1)) {
 		print_lock_nested_lock_not_held(curr, hlock, ip);
@@ -5597,7 +5614,7 @@ static void remove_class_from_lock_chain(struct pending_free *pf,
 	int i;
 
 	for (i = chain->base; i < chain->base + chain->depth; i++) {
-		if (chain_hlocks[i] != class - lock_classes)
+		if (chain_hlock_class_idx(chain_hlocks[i]) != class - lock_classes)
 			continue;
 		/*
 		 * Each lock class occurs at most once in a lock chain so once
-- 
2.28.0

