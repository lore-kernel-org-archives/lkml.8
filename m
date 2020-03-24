Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307A4C54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F895212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgCXJRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:17:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44024 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbgCXJQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:57 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfg7-00089l-Kf; Tue, 24 Mar 2020 10:16:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 922871C0494;
        Tue, 24 Mar 2020 10:16:46 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:46 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Tighten rcu_lockdep_assert_cblist_protected() check
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140622.28353.9212973365061809180.tip-bot2@tip-bot2>
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

Commit-ID:     13817dd589f426aee9c36e3670e7cb2a7f067d23
Gitweb:        https://git.kernel.org/tip/13817dd589f426aee9c36e3670e7cb2a7f067d23
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 04 Feb 2020 08:56:41 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:23 -08:00

rcu: Tighten rcu_lockdep_assert_cblist_protected() check

The ->nocb_lock lockdep assertion is currently guarded by cpu_online(),
which is incorrect for no-CBs CPUs, whose callback lists must be
protected by ->nocb_lock regardless of whether or not the corresponding
CPU is online.  This situation could result in failure to detect bugs
resulting from failing to hold ->nocb_lock for offline CPUs.

This commit therefore removes the cpu_online() guard.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3846519..70b3c0f 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1579,8 +1579,7 @@ static void rcu_nocb_unlock_irqrestore(struct rcu_data *rdp,
 static void rcu_lockdep_assert_cblist_protected(struct rcu_data *rdp)
 {
 	lockdep_assert_irqs_disabled();
-	if (rcu_segcblist_is_offloaded(&rdp->cblist) &&
-	    cpu_online(rdp->cpu))
+	if (rcu_segcblist_is_offloaded(&rdp->cblist))
 		lockdep_assert_held(&rdp->nocb_lock);
 }
 
