Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEED9C54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D83208D6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgCXJQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:16:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43915 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbgCXJQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:39 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffn-0007w8-7B; Tue, 24 Mar 2020 10:16:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CAA471C0451;
        Tue, 24 Mar 2020 10:16:29 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:29 -0000
From:   "tip-bot2 for SeongJae Park" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] doc/RCU/Design: Remove remaining HTML tags in ReST files
Cc:     Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        SeongJae Park <sjpark@amazon.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504138950.28353.14906175175398982793.tip-bot2@tip-bot2>
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

Commit-ID:     d18c265fbf19de7716e6e3054b752594133b0739
Gitweb:        https://git.kernel.org/tip/d18c265fbf19de7716e6e3054b752594133b0739
Author:        SeongJae Park <sjpark@amazon.de>
AuthorDate:    Mon, 06 Jan 2020 21:07:56 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 27 Feb 2020 07:03:13 -08:00

doc/RCU/Design: Remove remaining HTML tags in ReST files

Commit ccc9971e2147 ("docs: rcu: convert some articles from html to
ReST") has converted a few of html RCU docs into ReST files, but a few
of html tags which not supported on rst is remaining.  This commit
converts those to ReST appropriate alternatives.

Reviewed-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Signed-off-by: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 1a8b129..83ae3b7 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -4,7 +4,7 @@ A Tour Through TREE_RCU's Grace-Period Memory Ordering
 
 August 8, 2017
 
-This article was contributed by Paul E.&nbsp;McKenney
+This article was contributed by Paul E. McKenney
 
 Introduction
 ============
@@ -48,7 +48,7 @@ Tree RCU Grace Period Memory Ordering Building Blocks
 
 The workhorse for RCU's grace-period memory ordering is the
 critical section for the ``rcu_node`` structure's
-``-&gt;lock``. These critical sections use helper functions for lock
+``->lock``. These critical sections use helper functions for lock
 acquisition, including ``raw_spin_lock_rcu_node()``,
 ``raw_spin_lock_irq_rcu_node()``, and ``raw_spin_lock_irqsave_rcu_node()``.
 Their lock-release counterparts are ``raw_spin_unlock_rcu_node()``,
@@ -102,9 +102,9 @@ lock-acquisition and lock-release functions::
    23   r3 = READ_ONCE(x);
    24 }
    25
-   26 WARN_ON(r1 == 0 &amp;&amp; r2 == 0 &amp;&amp; r3 == 0);
+   26 WARN_ON(r1 == 0 && r2 == 0 && r3 == 0);
 
-The ``WARN_ON()`` is evaluated at &ldquo;the end of time&rdquo;,
+The ``WARN_ON()`` is evaluated at "the end of time",
 after all changes have propagated throughout the system.
 Without the ``smp_mb__after_unlock_lock()`` provided by the
 acquisition functions, this ``WARN_ON()`` could trigger, for example
