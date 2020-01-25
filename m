Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCBDC35243
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F59C20880
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgAYKnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:43:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44178 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgAYKm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:56 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItx-0008T7-OT; Sat, 25 Jan 2020 11:42:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E78AA1C1A7F;
        Sat, 25 Jan 2020 11:42:46 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:46 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add a hlist_nulls_unhashed_lockless() function
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896674.396.10350805017692383753.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     02b99b38f3d96c77cf0a368d99952aa372dfe58a
Gitweb:        https://git.kernel.org/tip/02b99b38f3d96c77cf0a368d99952aa372dfe58a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 09 Nov 2019 10:45:47 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 10 Jan 2020 14:00:57 -08:00

rcu: Add a hlist_nulls_unhashed_lockless() function

This commit adds an hlist_nulls_unhashed_lockless() to allow lockless
checking for whether or note an hlist_nulls_node is hashed or not.
While in the area, this commit also adds a docbook comment to the existing
hlist_nulls_unhashed() function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/list_nulls.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
index 1ecd356..fa6e847 100644
--- a/include/linux/list_nulls.h
+++ b/include/linux/list_nulls.h
@@ -56,11 +56,33 @@ static inline unsigned long get_nulls_value(const struct hlist_nulls_node *ptr)
 	return ((unsigned long)ptr) >> 1;
 }
 
+/**
+ * hlist_nulls_unhashed - Has node been removed and reinitialized?
+ * @h: Node to be checked
+ *
+ * Not that not all removal functions will leave a node in unhashed state.
+ * For example, hlist_del_init_rcu() leaves the node in unhashed state,
+ * but hlist_nulls_del() does not.
+ */
 static inline int hlist_nulls_unhashed(const struct hlist_nulls_node *h)
 {
 	return !h->pprev;
 }
 
+/**
+ * hlist_nulls_unhashed_lockless - Has node been removed and reinitialized?
+ * @h: Node to be checked
+ *
+ * Not that not all removal functions will leave a node in unhashed state.
+ * For example, hlist_del_init_rcu() leaves the node in unhashed state,
+ * but hlist_nulls_del() does not.  Unlike hlist_nulls_unhashed(), this
+ * function may be used locklessly.
+ */
+static inline int hlist_nulls_unhashed_lockless(const struct hlist_nulls_node *h)
+{
+	return !READ_ONCE(h->pprev);
+}
+
 static inline int hlist_nulls_empty(const struct hlist_nulls_head *h)
 {
 	return is_a_nulls(READ_ONCE(h->first));
