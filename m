Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E2FC54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C5120A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgCXJSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:18:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44044 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgCXJRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgA-0008As-1x; Tue, 24 Mar 2020 10:16:58 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 81AF11C04D4;
        Tue, 24 Mar 2020 10:16:47 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:47 -0000
From:   "tip-bot2 for Jules Irenge" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/nocb: Add missing annotation for rcu_nocb_bypass_unlock()
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140722.28353.13599324733441017238.tip-bot2@tip-bot2>
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

Commit-ID:     92c0b889f2ff6898710d49458b6eae1de50895c6
Gitweb:        https://git.kernel.org/tip/92c0b889f2ff6898710d49458b6eae1de50895c6
Author:        Jules Irenge <jbi.octave@gmail.com>
AuthorDate:    Thu, 30 Jan 2020 00:30:09 
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:23 -08:00

rcu/nocb: Add missing annotation for rcu_nocb_bypass_unlock()

Sparse reports warning at rcu_nocb_bypass_unlock()

warning: context imbalance in rcu_nocb_bypass_unlock() - unexpected unlock

The root cause is a missing annotation of rcu_nocb_bypass_unlock()
which causes the warning.

This commit therefore adds the missing __releases(&rdp->nocb_bypass_lock)
annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 6db2cad..3846519 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1530,6 +1530,7 @@ static bool rcu_nocb_bypass_trylock(struct rcu_data *rdp)
  * Release the specified rcu_data structure's ->nocb_bypass_lock.
  */
 static void rcu_nocb_bypass_unlock(struct rcu_data *rdp)
+	__releases(&rdp->nocb_bypass_lock)
 {
 	lockdep_assert_irqs_disabled();
 	raw_spin_unlock(&rdp->nocb_bypass_lock);
