Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EA1C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322D52073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585064216;
	bh=BUHldg+uHWPMoaQQxKAqgDLVXAxhSWfg2Skor2EJDJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uzXwbJTxKWaVKvPRQpqYeev8s1dSgonatHBC+tvwYeC2rcuBSmzHJZiKwDjVNv7yl
	 6CUp+N9ZTxjVmlx+ceni19OyU8uhTCzVAGKI2iKFNfElXGjC8fHRHacrHzxuEo0atm
	 qL3R1+Xz/NjUZQPwd+x5eIQ10zbYjEpdkbqnxH1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgCXPgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:36:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbgCXPgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:36:54 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B24B320788;
        Tue, 24 Mar 2020 15:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064213;
        bh=BUHldg+uHWPMoaQQxKAqgDLVXAxhSWfg2Skor2EJDJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P4WUrxomxUjXLQ55G79FEXsia4jVbj/FyMmNGUtO5rB6aRs6GC2p4eXU79n+i0dS3
         JJ7iZvQS2mTvMGK8oWhM8HrzfM8TBNf118/tWXwjOLlwEWJMjvTnPJnr/4b8W4os23
         d3iXDnXYlCQrqwHtfhwPduvfQjOsUg4r1fFCkDqY=
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
Subject: [RFC PATCH 01/21] list: Remove hlist_unhashed_lockless()
Date:   Tue, 24 Mar 2020 15:36:23 +0000
Message-Id: <20200324153643.15527-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324153643.15527-1-will@kernel.org>
References: <20200324153643.15527-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c54a2744497d ("list: Add hlist_unhashed_lockless()") added a
"lockless" variant of hlist_unhashed() that uses READ_ONCE() to access
the 'pprev' pointer of the 'hlist_node', the intention being that this
could be used by 'timer_pending()' to silence a KCSAN warning. As well
as forgetting to add the caller, the patch also sprinkles
{READ,WRITE}_ONCE() invocations over the standard (i.e. non-RCU) hlist
code, which is undesirable for a number of reasons:

  1. It gives the misleading impression that the non-RCU hlist code is
     in some way lock-free (despite the notable absence of any memory
     barriers!) and silences KCSAN in such cases.

  2. It unnecessarily penalises code generation for non-RCU hlist users

  3. It makes it difficult to introduce list integrity checks because
     of the possibility of concurrent callers.

Retain the {READ,WRITE}_ONCE() invocations for the RCU hlist code, but
remove them from the non-RCU implementation. Remove the unused
'hlist_unhashed_lockless()' function entirely and add the READ_ONCE()
to hlist_unhashed(), as we do already for hlist_empty() already.

Cc: Eric Dumazet <edumazet@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/list.h | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 884216db3246..4fed5a0f9b77 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -777,19 +777,6 @@ static inline void INIT_HLIST_NODE(struct hlist_node *h)
  * node in unhashed state, but hlist_nulls_del() does not.
  */
 static inline int hlist_unhashed(const struct hlist_node *h)
-{
-	return !h->pprev;
-}
-
-/**
- * hlist_unhashed_lockless - Version of hlist_unhashed for lockless use
- * @h: Node to be checked
- *
- * This variant of hlist_unhashed() must be used in lockless contexts
- * to avoid potential load-tearing.  The READ_ONCE() is paired with the
- * various WRITE_ONCE() in hlist helpers that are defined below.
- */
-static inline int hlist_unhashed_lockless(const struct hlist_node *h)
 {
 	return !READ_ONCE(h->pprev);
 }
@@ -852,11 +839,11 @@ static inline void hlist_del_init(struct hlist_node *n)
 static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 {
 	struct hlist_node *first = h->first;
-	WRITE_ONCE(n->next, first);
+	n->next = first;
 	if (first)
-		WRITE_ONCE(first->pprev, &n->next);
+		first->pprev = &n->next;
 	WRITE_ONCE(h->first, n);
-	WRITE_ONCE(n->pprev, &h->first);
+	n->pprev = &h->first;
 }
 
 /**
@@ -867,9 +854,9 @@ static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 static inline void hlist_add_before(struct hlist_node *n,
 				    struct hlist_node *next)
 {
-	WRITE_ONCE(n->pprev, next->pprev);
-	WRITE_ONCE(n->next, next);
-	WRITE_ONCE(next->pprev, &n->next);
+	n->pprev = next->pprev;
+	n->next = next;
+	next->pprev = &n->next;
 	WRITE_ONCE(*(n->pprev), n);
 }
 
@@ -881,12 +868,12 @@ static inline void hlist_add_before(struct hlist_node *n,
 static inline void hlist_add_behind(struct hlist_node *n,
 				    struct hlist_node *prev)
 {
-	WRITE_ONCE(n->next, prev->next);
-	WRITE_ONCE(prev->next, n);
-	WRITE_ONCE(n->pprev, &prev->next);
+	n->next = prev->next;
+	prev->next = n;
+	n->pprev = &prev->next;
 
 	if (n->next)
-		WRITE_ONCE(n->next->pprev, &n->next);
+		n->next->pprev  = &n->next;
 }
 
 /**
-- 
2.20.1

