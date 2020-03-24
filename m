Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE87C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE05020658
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgCXJTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:19:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43959 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgCXJQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:46 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGffx-00082l-1B; Tue, 24 Mar 2020 10:16:45 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 18F881C04D0;
        Tue, 24 Mar 2020 10:16:39 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:38 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] srcu: Fix __call_srcu()/srcu_get_delay() datarace
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504139878.28353.2467527074990549522.tip-bot2@tip-bot2>
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

Commit-ID:     8c9e0cb32315835825ea1ad725a858a2d2ce4a8e
Gitweb:        https://git.kernel.org/tip/8c9e0cb32315835825ea1ad725a858a2d2ce4a8e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 22 Dec 2019 19:36:33 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:01:11 -08:00

srcu: Fix __call_srcu()/srcu_get_delay() datarace

The srcu_struct structure's ->srcu_gp_seq_needed_exp field is accessed
locklessly, so updates must use WRITE_ONCE().  This commit therefore
adds the needed WRITE_ONCE() invocations.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b1edac9..79848f7 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -534,7 +534,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	rcu_seq_end(&ssp->srcu_gp_seq);
 	gpseq = rcu_seq_current(&ssp->srcu_gp_seq);
 	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, gpseq))
-		ssp->srcu_gp_seq_needed_exp = gpseq;
+		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, gpseq);
 	spin_unlock_irq_rcu_node(ssp);
 	mutex_unlock(&ssp->srcu_gp_mutex);
 	/* A new grace period can start at this point.  But only one. */
@@ -614,7 +614,7 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
 	}
 	spin_lock_irqsave_rcu_node(ssp, flags);
 	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, s))
-		ssp->srcu_gp_seq_needed_exp = s;
+		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, s);
 	spin_unlock_irqrestore_rcu_node(ssp, flags);
 }
 
@@ -674,7 +674,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		smp_store_release(&ssp->srcu_gp_seq_needed, s); /*^^^*/
 	}
 	if (!do_norm && ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, s))
-		ssp->srcu_gp_seq_needed_exp = s;
+		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, s);
 
 	/* If grace period not already done and none in progress, start it. */
 	if (!rcu_seq_done(&ssp->srcu_gp_seq, s) &&
