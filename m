Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B938FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C94208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OWinFNey";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="21/pqFwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbgGaJ0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:26:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56410 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732306AbgGaJXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:25 -0400
Date:   Fri, 31 Jul 2020 09:23:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fdVxYbVhH0LCQObzxMHxeTxsZ1Wq0wCIzh0ci7rc6Nw=;
        b=OWinFNeyvPnzFkbKrXme7/nYTM2wWLo4mUdctVvgfcCsJO9TxhK53m1VXoKl0oshsIUtoQ
        r6RzeRBgx7lSd2X/Ia6771fDox7DKCcO9YEOc8hI3AApFttXDeqDLT+TWQ0v/JnQGWtWSj
        Gld9WC6/KbN0nova0wfrHRWvj+6gxmMfAqlGX8wa9JTJG6Gr88vWeg7aTroEIMCWAV5ROu
        UhSrSwD1bSXeUtSOpCxoFJ0OGc7Tktwp6wKg6c5eKXeHJ8TZk8q0N/KzWjHmUbFvM8julz
        EIQo+u8S/h6hPAWqYynAf5BywsOodJ7uiHrEapb+C1fjIMyMt28HVznbwLDu8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187403;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fdVxYbVhH0LCQObzxMHxeTxsZ1Wq0wCIzh0ci7rc6Nw=;
        b=21/pqFwQD2GwLvEHW2tfP+dbixKGVDJOo4OjFBCxZMjbbwiU6TSi635T9plueNHKuJ0K4B
        Lnr3b9wzFAD/GbAg==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: Repeat the monitor if any free channel is busy
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618740317.4006.10180134759285461465.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     594aa5975b9b5cfe9edaec06170e43b8c0607377
Gitweb:        https://git.kernel.org/tip/594aa5975b9b5cfe9edaec06170e43b8c0607377
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Mon, 25 May 2020 23:47:47 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:25 -07:00

rcu/tree: Repeat the monitor if any free channel is busy

It is possible that one of the channels cannot be detached
because its free channel is busy and previously queued data
has not been processed yet. On the other hand, another
channel can be successfully detached causing the monitor
work to stop.

Prevent that by rescheduling the monitor work if there are
any channels in the pending state after a detach attempt.

Fixes: 34c881745549e ("rcu: Support kfree_bulk() interface in kfree_rcu()")
Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e0425fa..5151fe4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3105,7 +3105,7 @@ static void kfree_rcu_work(struct work_struct *work)
 static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 {
 	struct kfree_rcu_cpu_work *krwp;
-	bool queued = false;
+	bool repeat = false;
 	int i;
 
 	lockdep_assert_held(&krcp->lock);
@@ -3143,11 +3143,14 @@ static inline bool queue_kfree_rcu_work(struct kfree_rcu_cpu *krcp)
 			 * been detached following each other, one by one.
 			 */
 			queue_rcu_work(system_wq, &krwp->rcu_work);
-			queued = true;
 		}
+
+		/* Repeat if any "free" corresponding channel is still busy. */
+		if (krcp->bhead || krcp->head)
+			repeat = true;
 	}
 
-	return queued;
+	return !repeat;
 }
 
 static inline void kfree_rcu_drain_unlock(struct kfree_rcu_cpu *krcp,
