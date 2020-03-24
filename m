Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF103C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C864220B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585064319;
	bh=ePC0KcHwaeG27HJefCMue14nRgQlh3QPrh4rpDBAm+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lT+KRsY8EMO9vbke2BH0AKzdLy/oZk7g9m+zBBDKXF+6BBzKGffzToGBOPPYaJIsj
	 NUWxkODhwSdj0hPMPmTWYWyLd1GW5356jMReLM4VYM1NM5mmnlv3BozRoprBtZjvCv
	 jpOe4aKErQZAaGqjI9oY+Ovv2FlpeXZq9BBNnmjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgCXPii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:38:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbgCXPh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:37:28 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E56B6208CA;
        Tue, 24 Mar 2020 15:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064247;
        bh=ePC0KcHwaeG27HJefCMue14nRgQlh3QPrh4rpDBAm+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ySrv9lDoir/ctvuoDCC59S/NRJYM3saGztZut9HosJtQrud9DmO2rEQYmy4m2Y3Uf
         8/4lOkxE55lxjrkjgXa/MPyc+LGVBrLqSSxuS/aQ1xgM1o6Jpqe5meS7XeiNPV9her
         ptPCVWPMtE3vx0DYOli+qNSrP71EXJv5Re6PsHZA=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: [RFC PATCH 15/21] list_bl: Use CHECK_DATA_CORRUPTION instead of custom BUG_ON() wrapper
Date:   Tue, 24 Mar 2020 15:36:37 +0000
Message-Id: <20200324153643.15527-16-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324153643.15527-1-will@kernel.org>
References: <20200324153643.15527-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CHECK_DATA_CORRUPTION() allows detected data corruption to result
consistently in either a BUG() or a WARN() depending on
CONFIG_BUG_ON_DATA_CORRUPTION.

Use CHECK_DATA_CORRUPTION() to report list_bl integrity checking failures,
rather than a custom wrapper around BUG_ON().

Cc: Kees Cook <keescook@chromium.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/list_bl.h    | 55 +++++++++++++++++++++++++-------------
 include/linux/rculist_bl.h | 17 ++++--------
 2 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index 9f8e29142324..f48d8acb15b4 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -24,13 +24,6 @@
 #define LIST_BL_LOCKMASK	0UL
 #endif
 
-#ifdef CONFIG_CHECK_INTEGRITY_LIST
-#define LIST_BL_BUG_ON(x) BUG_ON(x)
-#else
-#define LIST_BL_BUG_ON(x)
-#endif
-
-
 struct hlist_bl_head {
 	struct hlist_bl_node *first;
 };
@@ -38,6 +31,37 @@ struct hlist_bl_head {
 struct hlist_bl_node {
 	struct hlist_bl_node *next, **pprev;
 };
+
+#ifdef CONFIG_CHECK_INTEGRITY_LIST
+static inline bool __hlist_bl_add_head_valid(struct hlist_bl_head *h,
+					     struct hlist_bl_node *n)
+{
+	unsigned long hlock = (unsigned long)h->first & LIST_BL_LOCKMASK;
+	unsigned long nlock = (unsigned long)n & LIST_BL_LOCKMASK;
+
+	return !(CHECK_DATA_CORRUPTION(nlock,
+			"hlist_bl_add_head: node is locked\n") ||
+		 CHECK_DATA_CORRUPTION(hlock != LIST_BL_LOCKMASK,
+			"hlist_bl_add_head: head is unlocked\n"));
+}
+
+static inline bool __hlist_bl_del_valid(struct hlist_bl_node *n)
+{
+	unsigned long nlock = (unsigned long)n & LIST_BL_LOCKMASK;
+	return !CHECK_DATA_CORRUPTION(nlock, "hlist_bl_del_valid: node locked");
+}
+#else
+static inline bool __hlist_bl_add_head_valid(struct hlist_bl_head *h,
+					     struct hlist_bl_node *n)
+{
+	return true;
+}
+static inline bool __hlist_bl_del_valid(struct hlist_bl_node *n)
+{
+	return true;
+}
+#endif
+
 #define INIT_HLIST_BL_HEAD(ptr) \
 	((ptr)->first = NULL)
 
@@ -60,15 +84,6 @@ static inline struct hlist_bl_node *hlist_bl_first(struct hlist_bl_head *h)
 		((unsigned long)h->first & ~LIST_BL_LOCKMASK);
 }
 
-static inline void hlist_bl_set_first(struct hlist_bl_head *h,
-					struct hlist_bl_node *n)
-{
-	LIST_BL_BUG_ON((unsigned long)n & LIST_BL_LOCKMASK);
-	LIST_BL_BUG_ON(((unsigned long)h->first & LIST_BL_LOCKMASK) !=
-							LIST_BL_LOCKMASK);
-	h->first = (struct hlist_bl_node *)((unsigned long)n | LIST_BL_LOCKMASK);
-}
-
 static inline bool hlist_bl_empty(const struct hlist_bl_head *h)
 {
 	unsigned long first = data_race((unsigned long)READ_ONCE(h->first));
@@ -80,11 +95,14 @@ static inline void hlist_bl_add_head(struct hlist_bl_node *n,
 {
 	struct hlist_bl_node *first = hlist_bl_first(h);
 
+	if (!__hlist_bl_add_head_valid(h, n))
+		return;
+
 	n->next = first;
 	if (first)
 		first->pprev = &n->next;
 	n->pprev = &h->first;
-	hlist_bl_set_first(h, n);
+	h->first = (struct hlist_bl_node *)((unsigned long)n | LIST_BL_LOCKMASK);
 }
 
 static inline void hlist_bl_add_before(struct hlist_bl_node *n,
@@ -118,7 +136,8 @@ static inline void __hlist_bl_del(struct hlist_bl_node *n)
 	struct hlist_bl_node *next = n->next;
 	struct hlist_bl_node **pprev = n->pprev;
 
-	LIST_BL_BUG_ON((unsigned long)n & LIST_BL_LOCKMASK);
+	if (!__hlist_bl_del_valid(n))
+		return;
 
 	/* pprev may be `first`, so be careful not to lose the lock bit */
 	WRITE_ONCE(*pprev,
diff --git a/include/linux/rculist_bl.h b/include/linux/rculist_bl.h
index 0b952d06eb0b..553ce3cde104 100644
--- a/include/linux/rculist_bl.h
+++ b/include/linux/rculist_bl.h
@@ -8,16 +8,6 @@
 #include <linux/list_bl.h>
 #include <linux/rcupdate.h>
 
-static inline void hlist_bl_set_first_rcu(struct hlist_bl_head *h,
-					struct hlist_bl_node *n)
-{
-	LIST_BL_BUG_ON((unsigned long)n & LIST_BL_LOCKMASK);
-	LIST_BL_BUG_ON(((unsigned long)h->first & LIST_BL_LOCKMASK) !=
-							LIST_BL_LOCKMASK);
-	rcu_assign_pointer(h->first,
-		(struct hlist_bl_node *)((unsigned long)n | LIST_BL_LOCKMASK));
-}
-
 static inline struct hlist_bl_node *hlist_bl_first_rcu(struct hlist_bl_head *h)
 {
 	return (struct hlist_bl_node *)
@@ -73,6 +63,9 @@ static inline void hlist_bl_add_head_rcu(struct hlist_bl_node *n,
 {
 	struct hlist_bl_node *first;
 
+	if (!__hlist_bl_add_head_valid(h, n))
+		return;
+
 	/* don't need hlist_bl_first_rcu because we're under lock */
 	first = hlist_bl_first(h);
 
@@ -81,8 +74,8 @@ static inline void hlist_bl_add_head_rcu(struct hlist_bl_node *n,
 		first->pprev = &n->next;
 	n->pprev = &h->first;
 
-	/* need _rcu because we can have concurrent lock free readers */
-	hlist_bl_set_first_rcu(h, n);
+	rcu_assign_pointer(h->first,
+		(struct hlist_bl_node *)((unsigned long)n | LIST_BL_LOCKMASK));
 }
 /**
  * hlist_bl_for_each_entry_rcu - iterate over rcu list of given type
-- 
2.20.1

