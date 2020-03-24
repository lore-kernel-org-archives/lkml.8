Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032DCC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A7E20A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgCXJRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:17:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44137 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgCXJRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgP-0008IU-Ha; Tue, 24 Mar 2020 10:17:13 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2B7C91C07F3;
        Tue, 24 Mar 2020 10:16:54 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:53 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add WRITE_ONCE() to rcu_state ->gp_req_activity
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504141385.28353.5264533813185522124.tip-bot2@tip-bot2>
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

Commit-ID:     2906d2154cd6ad6e4452cc25315d3cea7bb7f2d7
Gitweb:        https://git.kernel.org/tip/2906d2154cd6ad6e4452cc25315d3cea7bb7f2d7
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 03 Jan 2020 15:17:12 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:22 -08:00

rcu: Add WRITE_ONCE() to rcu_state ->gp_req_activity

The rcu_state structure's ->gp_req_activity field is read locklessly,
so this commit adds the WRITE_ONCE() to an update in order to provide
proper documentation and READ_ONCE()/WRITE_ONCE() pairing.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 236692d..9443909 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1200,7 +1200,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 	}
 	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedroot"));
 	WRITE_ONCE(rcu_state.gp_flags, rcu_state.gp_flags | RCU_GP_FLAG_INIT);
-	rcu_state.gp_req_activity = jiffies;
+	WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
 	if (!rcu_state.gp_kthread) {
 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("NoGPkthread"));
 		goto unlock_out;
@@ -1775,7 +1775,7 @@ static void rcu_gp_cleanup(void)
 		    rcu_segcblist_is_offloaded(&rdp->cblist);
 	if ((offloaded || !rcu_accelerate_cbs(rnp, rdp)) && needgp) {
 		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
-		rcu_state.gp_req_activity = jiffies;
+		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
 		trace_rcu_grace_period(rcu_state.name,
 				       READ_ONCE(rcu_state.gp_seq),
 				       TPS("newreq"));
