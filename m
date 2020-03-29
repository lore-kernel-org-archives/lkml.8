Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDB4C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D98720748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgC2U1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:27:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57018 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC2U00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:26 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVk-0001T6-9L; Sun, 29 Mar 2020 22:26:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8FB651C04E3;
        Sun, 29 Mar 2020 22:26:19 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:19 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/atmel-aic5: Fix irq_retrigger callback return value
Cc:     Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200310184921.23552-3-maz@kernel.org>
References: <20200310184921.23552-3-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <158551357919.28353.7781981350566804125.tip-bot2@tip-bot2>
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

Commit-ID:     4ddfc459d07a9e1b39d1ca8621d9a39408ea289a
Gitweb:        https://git.kernel.org/tip/4ddfc459d07a9e1b39d1ca8621d9a39408ea289a
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 10 Mar 2020 18:49:19 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 16 Mar 2020 15:48:54 

irqchip/atmel-aic5: Fix irq_retrigger callback return value

The irq_retrigger callback is supposed to return 0 when retrigger
has failed, and a non-zero value otherwise. Tell the core code
that the driver has succedded in using the HW to retrigger the
interrupt.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200310184921.23552-3-maz@kernel.org
---
 drivers/irqchip/irq-atmel-aic5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 2933349..fc1b3a9 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -128,7 +128,7 @@ static int aic5_retrigger(struct irq_data *d)
 	irq_reg_writel(bgc, 1, AT91_AIC5_ISCR);
 	irq_gc_unlock(bgc);
 
-	return 0;
+	return 1;
 }
 
 static int aic5_set_type(struct irq_data *d, unsigned type)
