Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02E3C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B030420870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgCXJUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:20:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43879 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgCXJQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffh-0007vE-0t; Tue, 24 Mar 2020 10:16:29 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9AEB91C0470;
        Tue, 24 Mar 2020 10:16:28 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:28 -0000
From:   "tip-bot2 for SeongJae Park" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc/RCU/rcu: Use ':ref:' for links to other docs
Cc:     SeongJae Park <sjpark@amazon.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504138831.28353.3508857389864335454.tip-bot2@tip-bot2>
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

Commit-ID:     be2895681d6d8b1eb5a052d4655dea0d7cc2d84d
Gitweb:        https://git.kernel.org/tip/be2895681d6d8b1eb5a052d4655dea0d7cc2d84d
Author:        SeongJae Park <sjpark@amazon.de>
AuthorDate:    Mon, 06 Jan 2020 21:07:59 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 27 Feb 2020 07:03:13 -08:00

doc/RCU/rcu: Use ':ref:' for links to other docs

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/rcu.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
index 8dfb437..a1dd71d 100644
--- a/Documentation/RCU/rcu.rst
+++ b/Documentation/RCU/rcu.rst
@@ -11,8 +11,8 @@ must be long enough that any readers accessing the item being deleted have
 since dropped their references.  For example, an RCU-protected deletion
 from a linked list would first remove the item from the list, wait for
 a grace period to elapse, then free the element.  See the
-Documentation/RCU/listRCU.rst file for more information on using RCU with
-linked lists.
+:ref:`Documentation/RCU/listRCU.rst <list_rcu_doc>` for more information on
+using RCU with linked lists.
 
 Frequently Asked Questions
 --------------------------
@@ -50,7 +50,7 @@ Frequently Asked Questions
 - If I am running on a uniprocessor kernel, which can only do one
   thing at a time, why should I wait for a grace period?
 
-  See the Documentation/RCU/UP.rst file for more information.
+  See :ref:`Documentation/RCU/UP.rst <up_doc>` for more information.
 
 - How can I see where RCU is currently used in the Linux kernel?
 
@@ -68,9 +68,9 @@ Frequently Asked Questions
 
 - Why the name "RCU"?
 
-  "RCU" stands for "read-copy update".  The file Documentation/RCU/listRCU.rst
-  has more information on where this name came from, search for
-  "read-copy update" to find it.
+  "RCU" stands for "read-copy update".
+  :ref:`Documentation/RCU/listRCU.rst <list_rcu_doc>` has more information on where
+  this name came from, search for "read-copy update" to find it.
 
 - I hear that RCU is patented?  What is with that?
 
