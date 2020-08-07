Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117B2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15E6206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 07:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQq1beFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHGHoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 03:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGHob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 03:44:31 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF71C061574;
        Fri,  7 Aug 2020 00:44:30 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id d14so919407qke.13;
        Fri, 07 Aug 2020 00:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t7AButfdzi6cMBNZ58j1heasr0CXQukxKuORdIsBaQw=;
        b=SQq1beFmd2ZJKm3fO7j1izIYCZH+ptiNMmUVDKWCqoVVmLpoEbFGUMYOQh9JFUgo3c
         GXUYEpYuLR/sG+ha1Bgunc4cvo/3zdoOlqxb1uOUubaqI+udnw1oW63QYVVbiB/xtu7K
         Cli/QLm9yKXrIWBmTiG+kd09MymI0gzmjNxcQndOAvJZ2d8HX/I8owkEsCA7RSCtR/c4
         0edrvWNEfqlpWAMZqwcYM2S9XuEaGX86PJzSSay1cOjIQGsFBOtLY+NjiZgnfESKA3Se
         UzB/oee0IrOlLefeA4/MTpvR4cfxlDwIuor7wDsuYgISNEILVAbvx9qZv8eDX7ijbZZ2
         3Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t7AButfdzi6cMBNZ58j1heasr0CXQukxKuORdIsBaQw=;
        b=DAm4RkK4FE4e5YBr7FzfZngDd23GKRMOGkVt8PpV9tErFGUMSFDoUTuKhowNCrkfWa
         xFfBIwm9LIYW0jZYYi2bDhQX6ZodC6s9GJLOsFpRxzJ3s9p+pWu53Q1XSIn6PxnQP3Z+
         AxuMbtDhEYd718G9ReRwSKgycGwG7AeLmzFklEum1YVN1lFwSBqb/KmLsxZ2QiNWzPCN
         vaY/df/F8jqRFOX7t/L8ua6uxxeA1lZgLKi5+zbyv0cUBobXGsn+Ael3R8nG0gI/H/Kl
         oBVabeGfvsSKlKPTkjCKsCtAP6Ym+3X7PZd35bGXcSPKb9g69OGL3Kp1w2di+cDHSK2F
         Sv1w==
X-Gm-Message-State: AOAM530MBS3VVV2Ag2RnGMca/CA5QwrL4qbkzjT/TL7q5qDt+fliJVFI
        KtG1TcH5kJQk0heOvwUIBEg=
X-Google-Smtp-Source: ABdhPJyhvQ7EWaYqt0tkx1dcdppKY+wXih2X29VIPuSCZQg74rtDoVJzngV6UgxNKNgosovSxExN0w==
X-Received: by 2002:a37:8301:: with SMTP id f1mr12276566qkd.86.1596786269736;
        Fri, 07 Aug 2020 00:44:29 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id j61sm6778737qtd.52.2020.08.07.00.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2020 00:44:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id E3E8327C0054;
        Fri,  7 Aug 2020 03:44:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 03:44:28 -0400
X-ME-Sender: <xms:XAYtX8I604ow3MSOBmOB2Y588N-KEy2hAlr7rquYGEYgwXZkFitXQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedugdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedvveetfefgiedutedtfeevvddvleekjeeuffffleeguefhhfejteekieeu
    ueelnecukfhppeduudegrdekhedrudektddrvdduheenucevlhhushhtvghrufhiiigvpe
    einecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnpe
    epfhhigihmvgdrnhgrmhgvsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:XAYtX8JsiJEM7THIDX6DPKxYIgi82Ecaa1svgezI7jtagIKePiPhlg>
    <xmx:XAYtX8vyBP9ZPCGiBD07yFCHYUBbnVFAWwAbf93pMlyseNN4ul3osQ>
    <xmx:XAYtX5YuRSmIiR_9T8wEBsJOB0Iixy7eGO95I-Hky1VbGprykY6OVg>
    <xmx:XAYtXyXYoTEY9YJo-xyPQmJsgc2Jyv630G-TgkIbUPoftYEUgwM_ZQ>
Received: from localhost (unknown [114.85.180.215])
        by mail.messagingengine.com (Postfix) with ESMTPA id E1EA83280059;
        Fri,  7 Aug 2020 03:44:27 -0400 (EDT)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v7 08/19] lockdep: Make __bfs(.match) return bool
Date:   Fri,  7 Aug 2020 15:42:27 +0800
Message-Id: <20200807074238.1632519-9-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807074238.1632519-1-boqun.feng@gmail.com>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "match" parameter of __bfs() is used for checking whether we hit a
match in the search, therefore it should return a boolean value rather
than an integer for better readability.

This patch then changes the return type of the function parameter and the
match functions to bool.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/lockdep.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index bb8b7e42c154..62f7f88e3673 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1620,7 +1620,7 @@ static inline void bfs_init_rootb(struct lock_list *lock,
  */
 static enum bfs_result __bfs(struct lock_list *source_entry,
 			     void *data,
-			     int (*match)(struct lock_list *entry, void *data),
+			     bool (*match)(struct lock_list *entry, void *data),
 			     struct lock_list **target_entry,
 			     int offset)
 {
@@ -1711,7 +1711,7 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
 static inline enum bfs_result
 __bfs_forwards(struct lock_list *src_entry,
 	       void *data,
-	       int (*match)(struct lock_list *entry, void *data),
+	       bool (*match)(struct lock_list *entry, void *data),
 	       struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry,
@@ -1722,7 +1722,7 @@ __bfs_forwards(struct lock_list *src_entry,
 static inline enum bfs_result
 __bfs_backwards(struct lock_list *src_entry,
 		void *data,
-		int (*match)(struct lock_list *entry, void *data),
+		bool (*match)(struct lock_list *entry, void *data),
 		struct lock_list **target_entry)
 {
 	return __bfs(src_entry, data, match, target_entry,
@@ -1833,7 +1833,7 @@ print_circular_bug_header(struct lock_list *entry, unsigned int depth,
 	print_circular_bug_entry(entry, depth);
 }
 
-static inline int class_equal(struct lock_list *entry, void *data)
+static inline bool class_equal(struct lock_list *entry, void *data)
 {
 	return entry->class == data;
 }
@@ -1888,10 +1888,10 @@ static noinline void print_bfs_bug(int ret)
 	WARN(1, "lockdep bfs error:%d\n", ret);
 }
 
-static int noop_count(struct lock_list *entry, void *data)
+static bool noop_count(struct lock_list *entry, void *data)
 {
 	(*(unsigned long *)data)++;
-	return 0;
+	return false;
 }
 
 static unsigned long __lockdep_count_forward_deps(struct lock_list *this)
@@ -2032,11 +2032,11 @@ check_redundant(struct held_lock *src, struct held_lock *target)
 
 #ifdef CONFIG_TRACE_IRQFLAGS
 
-static inline int usage_accumulate(struct lock_list *entry, void *mask)
+static inline bool usage_accumulate(struct lock_list *entry, void *mask)
 {
 	*(unsigned long *)mask |= entry->class->usage_mask;
 
-	return 0;
+	return false;
 }
 
 /*
@@ -2045,9 +2045,9 @@ static inline int usage_accumulate(struct lock_list *entry, void *mask)
  * without creating any illegal irq-safe -> irq-unsafe lock dependency.
  */
 
-static inline int usage_match(struct lock_list *entry, void *mask)
+static inline bool usage_match(struct lock_list *entry, void *mask)
 {
-	return entry->class->usage_mask & *(unsigned long *)mask;
+	return !!(entry->class->usage_mask & *(unsigned long *)mask);
 }
 
 /*
-- 
2.28.0

