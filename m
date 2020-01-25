Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C686C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59B521556
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgAYKnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:43:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44171 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbgAYKmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:42:55 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivItw-0008Rk-B0; Sat, 25 Jan 2020 11:42:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 18BB41C1A7D;
        Sat, 25 Jan 2020 11:42:46 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:45 -0000
From:   "tip-bot2 for Madhuparna Bhowmik" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rculist.h: Add list_tail_rcu()
Cc:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994896590.396.3306704147213805892.tip-bot2@tip-bot2>
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

Commit-ID:     afa47fdfa29ffd3324e7b89551d1a6e54ccc042b
Gitweb:        https://git.kernel.org/tip/afa47fdfa29ffd3324e7b89551d1a6e54ccc042b
Author:        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
AuthorDate:    Mon, 09 Dec 2019 13:20:43 +05:30
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 10 Jan 2020 14:00:58 -08:00

rculist.h: Add list_tail_rcu()

This patch adds the macro list_tail_rcu() and documents it.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
[ paulmck: Reword a bit. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rculist.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 4b7ae1b..9f313e4 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -40,6 +40,16 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
  */
 #define list_next_rcu(list)	(*((struct list_head __rcu **)(&(list)->next)))
 
+/**
+ * list_tail_rcu - returns the prev pointer of the head of the list
+ * @head: the head of the list
+ *
+ * Note: This should only be used with the list header, and even then
+ * only if list_del() and similar primitives are not also used on the
+ * list header.
+ */
+#define list_tail_rcu(head)	(*((struct list_head __rcu **)(&(head)->prev)))
+
 /*
  * Check during list traversal that we are within an RCU reader
  */
