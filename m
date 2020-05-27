Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A9EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2486221508
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387774AbgE0IMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387755AbgE0IMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:12:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66767C03E97A;
        Wed, 27 May 2020 01:12:20 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jdrAQ-0002eW-OO; Wed, 27 May 2020 10:12:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6790B1C070D;
        Wed, 27 May 2020 10:11:58 +0200 (CEST)
Date:   Wed, 27 May 2020 08:11:58 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] genirq: Provide __irq_enter/exit_raw()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521202117.671682341@linutronix.de>
References: <20200521202117.671682341@linutronix.de>
MIME-Version: 1.0
Message-ID: <159056711827.17951.14893427079916825731.tip-bot2@tip-bot2>
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

Commit-ID:     355e1262d6038b37f0dbf5f3cfe64cc85d471b7b
Gitweb:        https://git.kernel.org/tip/355e1262d6038b37f0dbf5f3cfe64cc85d471b7b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 21 May 2020 22:05:22 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 26 May 2020 19:06:27 +02:00

genirq: Provide __irq_enter/exit_raw()

Like __irq_enter/exit() but without time accounting. To be used for "empty"
system vectors like the scheduler IPI to avoid the overhead.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20200521202117.671682341@linutronix.de
---
 include/linux/hardirq.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 3dc9102..03c9fec 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -38,6 +38,17 @@ static __always_inline void rcu_irq_enter_check_tick(void)
 	} while (0)
 
 /*
+ * Like __irq_enter() without time accounting for fast
+ * interrupts, e.g. reschedule IPI where time accounting
+ * is more expensive than the actual interrupt.
+ */
+#define __irq_enter_raw()				\
+	do {						\
+		preempt_count_add(HARDIRQ_OFFSET);	\
+		lockdep_hardirq_enter();		\
+	} while (0)
+
+/*
  * Enter irq context (on NO_HZ, update jiffies):
  */
 void irq_enter(void);
@@ -57,6 +68,15 @@ void irq_enter_rcu(void);
 	} while (0)
 
 /*
+ * Like __irq_exit() without time accounting
+ */
+#define __irq_exit_raw()				\
+	do {						\
+		lockdep_hardirq_exit();			\
+		preempt_count_sub(HARDIRQ_OFFSET);	\
+	} while (0)
+
+/*
  * Exit irq context and process softirqs if needed:
  */
 void irq_exit(void);
