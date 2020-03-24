Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DD7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF7A208DB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585064254;
	bh=cYOrYm3TU8Oaswi/PS0pKnS4rYXUoN3KS4S87l1Oy2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rH676aYPjOpUETqn/kfkyKmU9cfPQ6Tu0IU1/n2fwO+1c/73MZVype8UPResOWbTc
	 q/7dJSDw/+mFFV1Cdquoxdz7ItZ8zDARlzQK83CELUzcIGoUcbayzMRdWAo2EqT5dQ
	 GnDyEnS30SMM2mRxU7lvHbcDddoFg86RH3Q/UKyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgCXPhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:60278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728579AbgCXPh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:37:26 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C7EB20788;
        Tue, 24 Mar 2020 15:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064245;
        bh=cYOrYm3TU8Oaswi/PS0pKnS4rYXUoN3KS4S87l1Oy2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k1XBzan/+CO0dNlXvcPznHNdfatVBYZOF2k+EJWIN6NK17dCPQN8YBP/j2MLYpnw9
         36DjGr7A4vTTVusW6h+pJZOKRPw+Nri81DI5ucdV4f80MStPpEW1IHqvNk9TR/0+ng
         JsaIpAaRWrlZQz5WqbDP93q07FZrFb6SFT1a8zmw=
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
Subject: [RFC PATCH 14/21] plist: Use CHECK_DATA_CORRUPTION instead of explicit {BUG,WARN}_ON()
Date:   Tue, 24 Mar 2020 15:36:36 +0000
Message-Id: <20200324153643.15527-15-will@kernel.org>
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

Use CHECK_DATA_CORRUPTION() to report plist integrity checking failures,
rather than explicit use of BUG_ON() and WARN_ON().

Cc: Kees Cook <keescook@chromium.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 lib/plist.c | 63 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/lib/plist.c b/lib/plist.c
index c06e98e78259..eb127eaab235 100644
--- a/lib/plist.c
+++ b/lib/plist.c
@@ -29,39 +29,46 @@
 
 static struct plist_head test_head;
 
-static void plist_check_prev_next(struct list_head *t, struct list_head *p,
-				  struct list_head *n)
+static bool plist_prev_next_invalid(struct list_head *t, struct list_head *p,
+				    struct list_head *n)
 {
-	WARN(n->prev != p || p->next != n,
-			"top: %p, n: %p, p: %p\n"
-			"prev: %p, n: %p, p: %p\n"
-			"next: %p, n: %p, p: %p\n",
+	return CHECK_DATA_CORRUPTION(n->prev != p || p->next != n,
+			"plist corruption:\n"
+			"\ttop: %p, n: %p, p: %p\n"
+			"\tprev: %p, n: %p, p: %p\n"
+			"\tnext: %p, n: %p, p: %p\n",
 			 t, t->next, t->prev,
 			p, p->next, p->prev,
 			n, n->next, n->prev);
 }
 
-static void plist_check_list(struct list_head *top)
+static bool plist_list_invalid(struct list_head *top)
 {
 	struct list_head *prev = top, *next = top->next;
+	bool corruption;
 
-	plist_check_prev_next(top, prev, next);
+	corruption = plist_prev_next_invalid(top, prev, next);
 	while (next != top) {
 		prev = next;
 		next = prev->next;
-		plist_check_prev_next(top, prev, next);
+		corruption |= plist_prev_next_invalid(top, prev, next);
 	}
+
+	return corruption;
 }
 
-static void plist_check_head(struct plist_head *head)
+static bool plist_head_valid(struct plist_head *head)
 {
+	bool corruption = false;
+
 	if (!plist_head_empty(head))
-		plist_check_list(&plist_first(head)->prio_list);
-	plist_check_list(&head->node_list);
+		corruption |= plist_list_invalid(&plist_first(head)->prio_list);
+	corruption |= plist_list_invalid(&head->node_list);
+	return !corruption;
 }
 
 #else
-# define plist_check_head(h)	do { } while (0)
+# define plist_head_valid(h)	(true)
 #endif
 
 /**
@@ -75,9 +82,12 @@ void plist_add(struct plist_node *node, struct plist_head *head)
 	struct plist_node *first, *iter, *prev = NULL;
 	struct list_head *node_next = &head->node_list;
 
-	plist_check_head(head);
-	WARN_ON(!plist_node_empty(node));
-	WARN_ON(!list_empty(&node->prio_list));
+	if (!plist_head_valid(head) ||
+	    CHECK_DATA_CORRUPTION(!plist_node_empty(node),
+			"plist_add corruption. node list is not empty.\n") ||
+	    CHECK_DATA_CORRUPTION(!list_empty(&node->prio_list),
+			"plist_add corruption. node prio list is not empty.\n"))
+		return;
 
 	if (plist_head_empty(head))
 		goto ins_node;
@@ -100,7 +110,8 @@ void plist_add(struct plist_node *node, struct plist_head *head)
 ins_node:
 	list_add_tail(&node->node_list, node_next);
 
-	plist_check_head(head);
+	if (!plist_head_valid(head))
+		return;
 }
 
 /**
@@ -111,7 +122,8 @@ void plist_add(struct plist_node *node, struct plist_head *head)
  */
 void plist_del(struct plist_node *node, struct plist_head *head)
 {
-	plist_check_head(head);
+	if (!plist_head_valid(head))
+		return;
 
 	if (!list_empty(&node->prio_list)) {
 		if (node->node_list.next != &head->node_list) {
@@ -129,7 +141,8 @@ void plist_del(struct plist_node *node, struct plist_head *head)
 
 	list_del_init(&node->node_list);
 
-	plist_check_head(head);
+	if (!plist_head_valid(head))
+		return;
 }
 
 /**
@@ -147,9 +160,12 @@ void plist_requeue(struct plist_node *node, struct plist_head *head)
 	struct plist_node *iter;
 	struct list_head *node_next = &head->node_list;
 
-	plist_check_head(head);
-	BUG_ON(plist_head_empty(head));
-	BUG_ON(plist_node_empty(node));
+	if (!plist_head_valid(head) ||
+	    CHECK_DATA_CORRUPTION(plist_head_empty(head),
+			"plist_requeue corruption. head list is empty.\n") ||
+	    CHECK_DATA_CORRUPTION(plist_node_empty(node),
+			"plist_requeue corruption. node list is empty.\n"))
+		return;
 
 	if (node == plist_last(head))
 		return;
@@ -169,7 +185,8 @@ void plist_requeue(struct plist_node *node, struct plist_head *head)
 	}
 	list_add_tail(&node->node_list, node_next);
 
-	plist_check_head(head);
+	if (!plist_head_valid(head))
+		return;
 }
 
 #ifdef CONFIG_CHECK_INTEGRITY_PLIST
-- 
2.20.1

