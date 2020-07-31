Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED80C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F4522BF3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ddc7ZJPm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T+JGGIJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbgGaJZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:25:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56642 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732511AbgGaJXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:38 -0400
Date:   Fri, 31 Jul 2020 09:23:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187416;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SSGeJP12JtPWHX/H08cWrz+HuLPx1tUC/NkFVixq4HQ=;
        b=Ddc7ZJPmXDH1iK1wPNGiWvTZfk61NSgdNSpAR6pIXGdNL7xlBaYdUFS9Zy+bX3gR1732vu
        QibSng+f5ydmMkvVVpyvPMUqF9PZrOtV9Tt1xWHzFbZTAeNPmKOvKLJtRbq3xlnnyjsXQY
        PTg6eQKbQjgoKftums5GxkKGf2R13olQyGgDkqlFrqYfF30uZMWNfjmPlzfYZsPO4GuYL5
        kqMaglSiDyEFuUTZKkard2H81+7lZbcpTYn0qSOTSflLJtxU0Zyx8fAKQaEJU9G4lslloQ
        f7iVazsn+SmT6i51I+cxy94FqTC2RoSYeigeFVop5nzGBzx1vJT34T+xJ+8RXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187416;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SSGeJP12JtPWHX/H08cWrz+HuLPx1tUC/NkFVixq4HQ=;
        b=T+JGGIJOUnH/9pVsc6QS2KGnl6ZN9SX0rCHcGUqnO08LTSt8zAvxPi0bgFGxVVGJgvdzoc
        f/xzmDFyfExdyaDQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Priority-boost-related sleeps to idle priority
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618741593.4006.13637661955222840285.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a9352f72d6a9e8fe4840b9f0d97af8f5a6c52c79
Gitweb:        https://git.kernel.org/tip/a9352f72d6a9e8fe4840b9f0d97af8f5a6c52c79
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 07 May 2020 16:34:38 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:50 -07:00

rcu: Priority-boost-related sleeps to idle priority

This commit converts the long-standing schedule_timeout_interruptible()
call used by RCU's priority-boosting kthreads to schedule_timeout_idle().
This conversion avoids polluting the load-average with RCU-related
sleeping.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3522236..25296c1 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1033,7 +1033,7 @@ static int rcu_boost_kthread(void *arg)
 		if (spincnt > 10) {
 			WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_YIELDING);
 			trace_rcu_utilization(TPS("End boost kthread@rcu_yield"));
-			schedule_timeout_interruptible(2);
+			schedule_timeout_idle(2);
 			trace_rcu_utilization(TPS("Start boost kthread@rcu_yield"));
 			spincnt = 0;
 		}
