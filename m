Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE09C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D4E22B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V+qgAlc5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xNAdz3Wz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbgGaJZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:25:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732516AbgGaJXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:38 -0400
Date:   Fri, 31 Jul 2020 09:23:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187417;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RPUCWoiWPLGIuGOWuPDFPzJTn22g+3FWYR5i7NbE78s=;
        b=V+qgAlc5BJOgBOsg2f/DYn4nnzcrwr9tUcDN4vRtgc22QHLUVFsos0RpSqPUtloOfFdaji
        Ej3lbtQtw8RQVpHSpXr23/nhc8f00OjxSxUtZ5JnWKOnXqcXJ5NZl5PmSA23mYn4L4pNj5
        a9ODsZJkvU77LOBQuJYZW5OCK0CA9Cf678iCabDA972CyK6gs4E1yiuHbWsN36yxZWaBy7
        pnZxB28Z+LvJJSPEtS6gaEWApXHUMyPcQVT+TvJwoYyTdLsxkmzXUi/b6/ufa5lZvvdY4V
        6UrQqD0XqT09EQoPCGAugveRobTQKa1mLJjls/RS5hDrc4WP64guRkiOqJq9Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187417;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RPUCWoiWPLGIuGOWuPDFPzJTn22g+3FWYR5i7NbE78s=;
        b=xNAdz3WzT0IdMBcgwlWLOIKijQaGiQ1shlrODVaI2duo9nfph8KcvGvgbnZIWadvudDAqW
        SZR4FEJWh75i2ABQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Grace-period-kthread related sleeps to idle priority
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618741664.4006.5002771308562337292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     77865dea25c4f45ce0c5bf61a8470af01fccd944
Gitweb:        https://git.kernel.org/tip/77865dea25c4f45ce0c5bf61a8470af01fccd944
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 07 May 2020 15:44:46 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:49 -07:00

rcu: Grace-period-kthread related sleeps to idle priority

This commit converts the long-standing schedule_timeout_interruptible()
and schedule_timeout_uninterruptible() calls used by RCU's grace-period
kthread to schedule_timeout_idle().  This conversion avoids polluting
the load-average with RCU-related sleeping.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 874c831..feb31c2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1638,7 +1638,7 @@ static void rcu_gp_slow(int delay)
 	if (delay > 0 &&
 	    !(rcu_seq_ctr(rcu_state.gp_seq) %
 	      (rcu_num_nodes * PER_RCU_NODE_PERIOD * delay)))
-		schedule_timeout_uninterruptible(delay);
+		schedule_timeout_idle(delay);
 }
 
 static unsigned long sleep_duration;
@@ -1661,7 +1661,7 @@ static void rcu_gp_torture_wait(void)
 	duration = xchg(&sleep_duration, 0UL);
 	if (duration > 0) {
 		pr_alert("%s: Waiting %lu jiffies\n", __func__, duration);
-		schedule_timeout_uninterruptible(duration);
+		schedule_timeout_idle(duration);
 		pr_alert("%s: Wait complete\n", __func__);
 	}
 }
@@ -2727,7 +2727,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
 	}
 	*statusp = RCU_KTHREAD_YIELDING;
 	trace_rcu_utilization(TPS("Start CPU kthread@rcu_yield"));
-	schedule_timeout_interruptible(2);
+	schedule_timeout_idle(2);
 	trace_rcu_utilization(TPS("End CPU kthread@rcu_yield"));
 	*statusp = RCU_KTHREAD_WAITING;
 }
