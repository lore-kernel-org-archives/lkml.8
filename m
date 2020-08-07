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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0637FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A1E2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrbp7bxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHGHon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:44:42 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED243C061574;
        Fri,  7 Aug 2020 00:44:41 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x12so676134qtp.1;
        Fri, 07 Aug 2020 00:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bNQ/SKrs9r0Vw7ZGQck+KbBshkkEyzwGxG46EESM6ZI=;
        b=mrbp7bxcLuj/DY7OKj5ibGLzrJ2AoXdwgxb3t0TdRCl7qAyK5fCneG6pKIVAjjKzeo
         jRqSRRsJ0gaoYzXL2OzS8J90cuvTKSLft6n5ZXuXFEeKArLe9G9fwMlYeYdKYfAcNmiA
         gSDvfFnLznHr4sU8ShDwWfX3RLFo1RTj5DpVBuz8C1qkRmSx7W9HGMFOzmM9TfAzb4nm
         L11dTbj+CZWWYoj4Pf958BsdvYMBAVCfB3ET1DbjWSLbQJMd5FbACDra0KFI+fc4zpPI
         g4ezjNXCG0iwfyHYoC9Wrgk6+5Nq6G3CK7BfC84vai6bWK7QNCgT9v6G4nWmNo0cygaB
         121w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bNQ/SKrs9r0Vw7ZGQck+KbBshkkEyzwGxG46EESM6ZI=;
        b=Zue/nKpuQVOv4zLBL4GlmFxLAdfRwqoYneLlENgf8E0LuqUkHslwZWBwCQf9DX3APH
         WFqu/dUdVwPuVXrfJaZflQP6Z5vJcZ8VUV20dB3KQWYLui2d6QWmrH8zUxlLj2DFMfha
         WrlL8pJeRw5ryK2YEk9fh66j2Qj6gtQsdbCYiXDmGh2i8OaMtTNqwi/7jEo+hspTVf1J
         fx1KhI3lJJI9sM1n018TGOtkF2HtHguwV9GNVILowN7OueBFcETvIm6KA5WUMl+9+08x
         LWp9jT19JFzGkWZhxsDReFocXwb+AAWIZKB+MY3neZLNmnB/EQO+R59xRIgK22oirsE6
         dWIA==
X-Gm-Message-State: AOAM530/iw3F6GH6dMicjuJImA1++vi/3yFsLJTwIdIBWiBTDXWcAVfi
        +wVaoJie5SsrxlXeECAFCQso7ZLO
X-Google-Smtp-Source: ABdhPJyw7UwTw9WMVM32uodBWeQZlLzwHC8pjFbVk2vK1H3Ni9CZTytzhP6zyMHwjYr6SHkFfy/1tg==
X-Received: by 2002:aed:3461:: with SMTP id w88mr12674600qtd.180.1596786281235;
        Fri, 07 Aug 2020 00:44:41 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id g136sm6197111qke.82.2020.08.07.00.44.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:44:40 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4948A27C0054;
        Fri,  7 Aug 2020 03:44:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:44:40 -0400
X-ME-Sender: <xms:aAYtX4EnadFxi6JTwcfTYIltdssE6dK3pANjJ51mGNVcbw6Xqu44ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:aAYtXxXUJTQytvuGXU3L9AteZRzal8Y9PCri-JDK2w38UcfxVebaFw>
    <xmx:aAYtXyKDYuGP_K1uR4NLURA4SuM-9p_3cWJ-tsd9e91-CNNVYFUtOg>
    <xmx:aAYtX6HN_RwRjBHlENzpSB1X9-ApkpPMgTuwWtICu_MXY-RI6IlznQ>
    <xmx:aAYtX8wo2SXmbkfJzTVkCU4lbIv_ehF0S7hCq7v3zxDijAOm12aOjQ>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5F2023060067;
        Fri,  7 Aug 2020 03:44:38 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 09/19] lockdep: Support deadlock detection for recursive read locks in check_noncircular()
Date:   Fri,  7 Aug 2020 15:42:28 +0800
Message-Id: <20200807074238.1632519-10-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, lockdep only has limit support for deadlock detection for
recursive read locks.

This patch support deadlock detection for recursive read locks. The
basic idea is:

We are about to add dependency B -> A in to the dependency graph, we use
check_noncircular() to find whether we have a strong dependency path
A -> .. -> B so that we have a strong dependency circle (a closed strong
dependency path):

	 A -> .. -> B -> A

, which doesn't have two adjacent dependencies as -(*R)-> L -(S*)->.

Since A -> .. -> B is already a strong dependency path, so if either
B -> A is -(E*)-> or A -> .. -> B is -(*N)->, the circle A -> .. -> B ->
A is strong, otherwise not. So we introduce a new match function
hlock_conflict() to replace the class_equal() for the deadlock check in
check_noncircular().

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 43 ++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 62f7f88e3673..e5b2c1cf4286 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1838,10 +1838,37 @@ static inline bool class_equal(struct lock_list *entry, void *data)
 	return entry->class == data;
 }
 
+/*
+ * We are about to add B -> A into the dependency graph, and in __bfs() a
+ * strong dependency path A -> .. -> B is found: hlock_class equals
+ * entry->class.
+ *
+ * We will have a deadlock case (conflict) if A -> .. -> B -> A is a strong
+ * dependency cycle, that means:
+ *
+ * Either
+ *
+ *     a) B -> A is -(E*)->
+ *
+ * or
+ *
+ *     b) A -> .. -> B is -(*N)-> (i.e. A -> .. -(*N)-> B)
+ *
+ * as then we don't have -(*R)-> -(S*)-> in the cycle.
+ */
+static inline bool hlock_conflict(struct lock_list *entry, void *data)
+{
+	struct held_lock *hlock = (struct held_lock *)data;
+
+	return hlock_class(hlock) == entry->class && /* Found A -> .. -> B */
+	       (hlock->read == 0 || /* B -> A is -(E*)-> */
+		!entry->only_xr); /* A -> .. -> B is -(*N)-> */
+}
+
 static noinline void print_circular_bug(struct lock_list *this,
-					struct lock_list *target,
-					struct held_lock *check_src,
-					struct held_lock *check_tgt)
+				struct lock_list *target,
+				struct held_lock *check_src,
+				struct held_lock *check_tgt)
 {
 	struct task_struct *curr = current;
 	struct lock_list *parent;
@@ -1950,13 +1977,13 @@ unsigned long lockdep_count_backward_deps(struct lock_class *class)
  * <target> or not.
  */
 static noinline enum bfs_result
-check_path(struct lock_class *target, struct lock_list *src_entry,
+check_path(struct held_lock *target, struct lock_list *src_entry,
+	   bool (*match)(struct lock_list *entry, void *data),
 	   struct lock_list **target_entry)
 {
 	enum bfs_result ret;
 
-	ret = __bfs_forwards(src_entry, (void *)target, class_equal,
-			     target_entry);
+	ret = __bfs_forwards(src_entry, target, match, target_entry);
 
 	if (unlikely(bfs_error(ret)))
 		print_bfs_bug(ret);
@@ -1983,7 +2010,7 @@ check_noncircular(struct held_lock *src, struct held_lock *target,
 
 	debug_atomic_inc(nr_cyclic_checks);
 
-	ret = check_path(hlock_class(target), &src_entry, &target_entry);
+	ret = check_path(target, &src_entry, hlock_conflict, &target_entry);
 
 	if (unlikely(ret == BFS_RMATCH)) {
 		if (!*trace) {
@@ -2021,7 +2048,7 @@ check_redundant(struct held_lock *src, struct held_lock *target)
 
 	debug_atomic_inc(nr_redundant_checks);
 
-	ret = check_path(hlock_class(target), &src_entry, &target_entry);
+	ret = check_path(target, &src_entry, class_equal, &target_entry);
 
 	if (ret == BFS_RMATCH)
 		debug_atomic_inc(nr_redundant);
-- 
2.28.0

