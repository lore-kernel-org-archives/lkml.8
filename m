Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A4CC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A6F20A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgCXJTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:19:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43976 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbgCXJQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfg0-00082x-EV; Tue, 24 Mar 2020 10:16:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 815231C0451;
        Tue, 24 Mar 2020 10:16:39 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:39 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Fix __call_srcu()/process_srcu() datarace
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139916.28353.3509934736900696325.tip-bot2@tip-bot2>
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

Commit-ID:     7ff8b4502bc0f576450d4ecbda97fa30e8002ed1
Gitweb:        https://git.kernel.org/tip/7ff8b4502bc0f576450d4ecbda97fa30e8002ed1
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 22 Dec 2019 19:32:54 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:01:11 -08:00

srcu: Fix __call_srcu()/process_srcu() datarace

The srcu_node structure's ->srcu_gp_seq_needed_exp field is accessed
locklessly, so updates must use WRITE_ONCE().  This commit therefore
adds the needed WRITE_ONCE() invocations.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 657e6a7..b1edac9 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -550,7 +550,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 		snp->srcu_have_cbs[idx] = gpseq;
 		rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
 		if (ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, gpseq))
-			snp->srcu_gp_seq_needed_exp = gpseq;
+			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
 		mask = snp->srcu_data_have_cbs[idx];
 		snp->srcu_data_have_cbs[idx] = 0;
 		spin_unlock_irq_rcu_node(snp);
@@ -660,7 +660,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		if (snp == sdp->mynode)
 			snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
 		if (!do_norm && ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, s))
-			snp->srcu_gp_seq_needed_exp = s;
+			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, s);
 		spin_unlock_irqrestore_rcu_node(snp, flags);
 	}
 
