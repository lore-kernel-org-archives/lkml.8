Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E165FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B443E22B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ou+Awsa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZXtviY9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbgGaJ1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732410AbgGaJXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4891C061574;
        Fri, 31 Jul 2020 02:23:15 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:23:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+AhZ83rScIbJ4rlxI2njPEzDwd/0anHUrr5iVxs4/KY=;
        b=1ou+AwsaJbcr3W3M26D7MmUjeNLyngGcvbbzQBMY4/AzFYgH88zrdulHNqM8VBV/Y1pwJr
        bNh3/8j/N2NCP74bW0LKNplbMofPmn2G1BSSC+VyUPeCcup5lcKiIuxkkNfMrNzOcTs2Hn
        K8dE+bTbZOAYLoUpycOJ6B67CfWUQ9p5uW9PuRv7Z9fkL1Fab1xMK3TkxSHoeIYIgAEvrs
        sjQKtmmPX2fMXuLuTsx7W/YIRa0aMRhdCJabvNOJhotMU+X7nTdLivHg1vgKxg/+DquWUU
        PN0J6oXB26YtmlBnUBoqQ/TAeICQNaPqTm/pG9g75TZaUhcg4dmSyhgWMIlxIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+AhZ83rScIbJ4rlxI2njPEzDwd/0anHUrr5iVxs4/KY=;
        b=ZXtviY9/EiCc5ugkPVTYshYS3DidHASulAETnPiHi0wwjqK/6hZVS2Aka+8UBEl+5KhoCX
        sWR46RH6V7Flk3Bw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Convert sleeps to idle priority
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618739387.4006.1540485796816983638.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ea6eed9f7d7382c7230202d4c3bf74185f193394
Gitweb:        https://git.kernel.org/tip/ea6eed9f7d7382c7230202d4c3bf74185f193394
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 07 May 2020 16:47:13 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:22 -07:00

rcu-tasks: Convert sleeps to idle priority

This commit converts the long-standing schedule_timeout_interruptible()
and schedule_timeout_uninterruptible() calls used by the various Tasks
RCU's grace-period kthreads to schedule_timeout_idle().  This conversion
avoids polluting the load-average with Tasks-RCU-related sleeping.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ce23f6c..91fee81 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -205,7 +205,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 			if (!rtp->cbs_head) {
 				WARN_ON(signal_pending(current));
 				set_tasks_gp_state(rtp, RTGS_WAIT_WAIT_CBS);
-				schedule_timeout_interruptible(HZ/10);
+				schedule_timeout_idle(HZ/10);
 			}
 			continue;
 		}
@@ -227,7 +227,7 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 			cond_resched();
 		}
 		/* Paranoid sleep to keep this from entering a tight loop */
-		schedule_timeout_uninterruptible(HZ/10);
+		schedule_timeout_idle(HZ/10);
 
 		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 	}
@@ -336,7 +336,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 
 		/* Slowly back off waiting for holdouts */
 		set_tasks_gp_state(rtp, RTGS_WAIT_SCAN_HOLDOUTS);
-		schedule_timeout_interruptible(HZ/fract);
+		schedule_timeout_idle(HZ/fract);
 
 		if (fract > 1)
 			fract--;
