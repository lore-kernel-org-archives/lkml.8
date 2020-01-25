Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC067C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29E7218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgAYKqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:46:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44175 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbgAYKm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:56 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItx-0008SO-44; Sat, 25 Jan 2020 11:42:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 647241C1A7E;
        Sat, 25 Jan 2020 11:42:46 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:46 -0000
From:   "tip-bot2 for Madhuparna Bhowmik" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rculist_nulls: Change docbook comment headers
Cc:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896618.396.14151817890854231962.tip-bot2@tip-bot2>
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

Commit-ID:     459b5287066f53c4b91569c070780a540de90b85
Gitweb:        https://git.kernel.org/tip/459b5287066f53c4b91569c070780a540de90b85
Author:        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
AuthorDate:    Fri, 06 Dec 2019 00:23:52 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 10 Jan 2020 14:00:58 -08:00

rculist_nulls: Change docbook comment headers

This patch changes the docbook comment "head for your list"
to "head of the list".

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist_nulls.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index 25952c4..409a86b 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -112,7 +112,7 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
  * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
  * @tpos:	the type * to use as a loop cursor.
  * @pos:	the &struct hlist_nulls_node to use as a loop cursor.
- * @head:	the head for your list.
+ * @head:	the head of the list.
  * @member:	the name of the hlist_nulls_node within the struct.
  *
  * The barrier() is needed to make sure compiler doesn't cache first element [1],
@@ -132,7 +132,7 @@ static inline void hlist_nulls_add_head_rcu(struct hlist_nulls_node *n,
  *   iterate over list of given type safe against removal of list entry
  * @tpos:	the type * to use as a loop cursor.
  * @pos:	the &struct hlist_nulls_node to use as a loop cursor.
- * @head:	the head for your list.
+ * @head:	the head of the list.
  * @member:	the name of the hlist_nulls_node within the struct.
  */
 #define hlist_nulls_for_each_entry_safe(tpos, pos, head, member)		\
