Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E178C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 549FD21531
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbgE0IM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbgE0IMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:12:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE16C061A0F;
        Wed, 27 May 2020 01:12:06 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAS-0002cw-PD; Wed, 27 May 2020 10:12:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 992C51C04D5;
        Wed, 27 May 2020 10:11:56 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:56 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Split out idtentry_exit_cond_resched()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202117.962199649@linutronix.de>
References: <20200521202117.962199649@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056711648.17951.16924207554899786564.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     08f086303b4eddc61da264c2e9a8a5ee7f260604
Gitweb:        https://git.kernel.org/tip/08f086303b4eddc61da264c2e9a8a5ee7f260604
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:25 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:27 +02:00

x86/entry: Split out idtentry_exit_cond_resched()

The XEN PV hypercall requires the ability of conditional rescheduling when
preemption is disabled because some hypercalls take ages.

Split out the rescheduling code from idtentry_exit_cond_rcu() so it can
be reused for that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202117.962199649@linutronix.de
---
 arch/x86/entry/common.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 2a80e4e..066215a 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -583,6 +583,20 @@ bool noinstr idtentry_enter_cond_rcu(struct pt_regs *regs)
 	return false;
 }
 
+static void idtentry_exit_cond_resched(struct pt_regs *regs, bool may_sched)
+{
+	if (may_sched && !preempt_count()) {
+		/* Sanity check RCU and thread stack */
+		rcu_irq_exit_check_preempt();
+		if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
+			WARN_ON_ONCE(!on_thread_stack());
+		if (need_resched())
+			preempt_schedule_irq();
+	}
+	/* Covers both tracing and lockdep */
+	trace_hardirqs_on();
+}
+
 /**
  * idtentry_exit_cond_rcu - Handle return from exception with conditional RCU
  *			    handling
@@ -624,21 +638,7 @@ void noinstr idtentry_exit_cond_rcu(struct pt_regs *regs, bool rcu_exit)
 		}
 
 		instrumentation_begin();
-
-		/* Check kernel preemption, if enabled */
-		if (IS_ENABLED(CONFIG_PREEMPTION)) {
-			if (!preempt_count()) {
-				/* Sanity check RCU and thread stack */
-				rcu_irq_exit_check_preempt();
-				if (IS_ENABLED(CONFIG_DEBUG_ENTRY))
-					WARN_ON_ONCE(!on_thread_stack());
-				if (need_resched())
-					preempt_schedule_irq();
-			}
-		}
-		/* Covers both tracing and lockdep */
-		trace_hardirqs_on();
-
+		idtentry_exit_cond_resched(regs, IS_ENABLED(CONFIG_PREEMPTION));
 		instrumentation_end();
 	} else {
 		/*
