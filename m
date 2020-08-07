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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA14C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67D6206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkC2Ql0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgHGHou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgHGHot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:44:49 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB06C061574;
        Fri,  7 Aug 2020 00:44:49 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g26so962529qka.3;
        Fri, 07 Aug 2020 00:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ABUWUryyl0WAohIly7NLWorZFay2XZMY/R0J3iEyG28=;
        b=EkC2Ql0BTGJfQWD4iNz03zQ5NK497lumoGpUVcilZzW5vvtmiH8iqk0ghqIXe4ltbO
         P4mumKsXedBA4GSRKl2Q2VilYo50ZO4924+xce1fu93tBODgnny4Um/doLMRawxenKp0
         59sA1SeQ7i1uEO54GpA3G37Y7HO00s9/eH6stK/kHGexjrbFAkzQKPYB3DFwXdD7KGRR
         pfppg/isUoHXOIVkt1v281dLuiUfPnBSiNqPgcolLi4HilJtVOVmr069+oc/JKVhmkHv
         WLCqiKTZjOhsAFQU3IYlgUo/WpDxE627MJgvw4qDVu8BIkyj1x23JXj976bWAdO+4n97
         wwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ABUWUryyl0WAohIly7NLWorZFay2XZMY/R0J3iEyG28=;
        b=pAVEEkzhBPxBu/Nh50DPfyZhfRPIx9nsyBmSsWW3SqrOeuFAfrlzrulcTC5Ys5rOKg
         /ejOCNnzaCgBtTide1B4w4N2+PddolefbRFI4/A08nhspDsU/uqyieHql2Gg45tbD8g1
         u4JzqgapEuzZy8oEYswBLHWA5edbAhAepTMRc5qTRo/VvhbXCVqcvQyrdiEZblN+X/61
         REHrdoCebMebhULCjOIeI2IHkRi9dMQDBwOCYw3sQuNJ1fr4a56Y/cHLvjNDioC6msxX
         IMRt15KSEECZMZfsENxDbWkMAVHlbRu0VHtQja8kMQLtAL7zC3F834Bjt6Uh+df5rfv2
         bgwg==
X-Gm-Message-State: AOAM531x7k73uuYAFiB8AQUallCkaHuoLg/Y0qcRQchvJqBt0EQ6CR1d
        LY4a/w1olFPEq2i8trKblTE=
X-Google-Smtp-Source: ABdhPJyqsBui8q0j3wkdfJ+TmOiZxHcN4uQrd3RNJSUNhbyDwvfKD3r0SGFX2zEpZVG/cKOqq5CPsQ==
X-Received: by 2002:a05:620a:20ca:: with SMTP id f10mr12226666qka.0.1596786288308;
        Fri, 07 Aug 2020 00:44:48 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id h13sm6956675qtu.7.2020.08.07.00.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:44:47 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6537027C0054;
        Fri,  7 Aug 2020 03:44:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:44:47 -0400
X-ME-Sender: <xms:bwYtX0XV9ckzFxdIEqUK5Be4mfcchUeWXhk5UPnPP9HGAPP23njLJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:bwYtX4no2ZQquGBu-2twQoGieoan0E5_Rk5KY-TT30nU471InUmObg>
    <xmx:bwYtX4ZwX0sO_MH3N7M8y-EIPJk3WD8VWIrWcJ1_3YrY-oB1iFLT0Q>
    <xmx:bwYtXzW5JgtsP-vbQh_FVrW86lCZnaOYqp_4oAD2n01xYyZik4K0PQ>
    <xmx:bwYtX_DYA76QUxVSvF4yWsma4NrHhY36vUam0IzITOy4riHzMIhG1A>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id 50621328005D;
        Fri,  7 Aug 2020 03:44:45 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 10/19] lockdep: Adjust check_redundant() for recursive read change
Date:   Fri,  7 Aug 2020 15:42:29 +0800
Message-Id: <20200807074238.1632519-11-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 kernel/locking/lockdep.c | 47 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e5b2c1cf4286..85a4d3539faa 100644
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
-- 
2.28.0

