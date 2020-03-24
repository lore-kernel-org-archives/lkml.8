Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD62C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE1020A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgCXJSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:18:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44093 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbgCXJRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgH-0008Gy-Ru; Tue, 24 Mar 2020 10:17:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 020581C0475;
        Tue, 24 Mar 2020 10:16:53 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:52 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add READ_ONCE() to rcu_segcblist ->tails[]
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504141269.28353.5838672247760719625.tip-bot2@tip-bot2>
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

Commit-ID:     bfeebe24212d374f82bbf5b005371fe13acabb93
Gitweb:        https://git.kernel.org/tip/bfeebe24212d374f82bbf5b005371fe13acabb93
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 03 Jan 2020 16:14:08 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:22 -08:00

rcu: Add READ_ONCE() to rcu_segcblist ->tails[]

The rcu_segcblist structure's ->tails[] array entries are read
locklessly, so this commit adds the READ_ONCE() to a load in order to
avoid destructive compiler optimizations.

This data race was reported by KCSAN.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu_segcblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 5f4fd3b..426a472 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -182,7 +182,7 @@ void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
 bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp)
 {
 	return rcu_segcblist_is_enabled(rsclp) &&
-	       &rsclp->head != rsclp->tails[RCU_DONE_TAIL];
+	       &rsclp->head != READ_ONCE(rsclp->tails[RCU_DONE_TAIL]);
 }
 
 /*
