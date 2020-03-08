Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04B2C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D13F206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 10:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgCHKO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 06:14:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56465 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgCHKOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 06:14:34 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAsx6-0004na-1P; Sun, 08 Mar 2020 11:14:32 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B1F5F1C2211;
        Sun,  8 Mar 2020 11:14:29 +0100 (CET)
Date:   Sun, 08 Mar 2020 10:14:29 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Sanitize state handling in check_irq_resend()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200306130623.882129117@linutronix.de>
References: <20200306130623.882129117@linutronix.de>
MIME-Version: 1.0
Message-ID: <158366246945.28353.16966446675179068982.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     da90921acc62c71d27729ae211ccfda5370bf75b
Gitweb:        https://git.kernel.org/tip/da90921acc62c71d27729ae211ccfda5370bf75b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 06 Mar 2020 14:03:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 08 Mar 2020 11:06:41 +01:00

genirq: Sanitize state handling in check_irq_resend()

The code sets IRQS_REPLAY unconditionally whether the resend happens or
not. That doesn't have bad side effects right now, but inconsistent state
is always a latent source of problems.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lkml.kernel.org/r/20200306130623.882129117@linutronix.de

---
 kernel/irq/resend.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index a21fc4e..bef72dc 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -93,6 +93,8 @@ static int irq_sw_resend(struct irq_desc *desc)
  */
 int check_irq_resend(struct irq_desc *desc)
 {
+	int err = 0;
+
 	/*
 	 * We do not resend level type interrupts. Level type interrupts
 	 * are resent by hardware when they are still active. Clear the
@@ -106,13 +108,17 @@ int check_irq_resend(struct irq_desc *desc)
 	if (desc->istate & IRQS_REPLAY)
 		return -EBUSY;
 
-	if (desc->istate & IRQS_PENDING) {
-		desc->istate &= ~IRQS_PENDING;
-		desc->istate |= IRQS_REPLAY;
+	if (!(desc->istate & IRQS_PENDING))
+		return 0;
 
-		if (!desc->irq_data.chip->irq_retrigger ||
-		    !desc->irq_data.chip->irq_retrigger(&desc->irq_data))
-		    return irq_sw_resend(desc);
-	}
-	return 0;
+	desc->istate &= ~IRQS_PENDING;
+
+	if (!desc->irq_data.chip->irq_retrigger ||
+	    !desc->irq_data.chip->irq_retrigger(&desc->irq_data))
+		err = irq_sw_resend(desc);
+
+	/* If the retrigger was successfull, mark it with the REPLAY bit */
+	if (!err)
+		desc->istate |= IRQS_REPLAY;
+	return err;
 }
