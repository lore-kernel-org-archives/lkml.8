Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05998C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2EC208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585064218;
	bh=neEUpG858SvJc0NfbvvctYu868B2urEcRa1OZnEdi/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KBTSi4LGV/fDt4Qhms4wTdjMK1fb1UmVc9R5qoI7CNWu3+RPLtl2aW7Js0y9Hcslq
	 XZKHq/68FladapfRIirqwcxUdJR4pnWl2bQTt0v2RNjhTidV9OT6qikZdfmDOaLwv9
	 oGxCrMGKGDRMQYUHcO8HOA13lg2tPkiaqNDbj7fE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgCXPg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbgCXPg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:36:56 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 287812080C;
        Tue, 24 Mar 2020 15:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064216;
        bh=neEUpG858SvJc0NfbvvctYu868B2urEcRa1OZnEdi/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g5YPnlnldLX5FxEmCV5nU6OMxrr4aQRvL63Qf/IymntooM+N8SKCiS315iO4HYjLS
         OSzRmaE590qXuylBXKE8gVCA5Jq25Oq6QiB5CSl7fB4nqiXo+JVZM5bCw8OL+TYUfr
         xw+cubwn5lk1k1QcAZQqIPrJzxXq/tib0vsm0DRQ=
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
Subject: [RFC PATCH 02/21] list: Remove hlist_nulls_unhashed_lockless()
Date:   Tue, 24 Mar 2020 15:36:24 +0000
Message-Id: <20200324153643.15527-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324153643.15527-1-will@kernel.org>
References: <20200324153643.15527-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 02b99b38f3d9 ("rcu: Add a hlist_nulls_unhashed_lockless() function")
introduced the (as yet unused) hlist_nulls_unhashed_lockless() function
to avoid KCSAN reports when an RCU reader checks the 'hashed' status
of an 'hlist_nulls' concurrently undergoing modification.

Remove the unused function and add a READ_ONCE() to hlist_nulls_unhashed(),
just like we do already for hlist_nulls_empty().

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/list_nulls.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
index fa6e8471bd22..3a9ff01e9a11 100644
--- a/include/linux/list_nulls.h
+++ b/include/linux/list_nulls.h
@@ -65,20 +65,6 @@ static inline unsigned long get_nulls_value(const struct hlist_nulls_node *ptr)
  * but hlist_nulls_del() does not.
  */
 static inline int hlist_nulls_unhashed(const struct hlist_nulls_node *h)
-{
-	return !h->pprev;
-}
-
-/**
- * hlist_nulls_unhashed_lockless - Has node been removed and reinitialized?
- * @h: Node to be checked
- *
- * Not that not all removal functions will leave a node in unhashed state.
- * For example, hlist_del_init_rcu() leaves the node in unhashed state,
- * but hlist_nulls_del() does not.  Unlike hlist_nulls_unhashed(), this
- * function may be used locklessly.
- */
-static inline int hlist_nulls_unhashed_lockless(const struct hlist_nulls_node *h)
 {
 	return !READ_ONCE(h->pprev);
 }
-- 
2.20.1

