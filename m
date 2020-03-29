Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBA7C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B82620781
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgC2U0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:26:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57086 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728934AbgC2U0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVr-0001Xc-OE; Sun, 29 Mar 2020 22:26:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 05DE51C04E3;
        Sun, 29 Mar 2020 22:26:25 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:24 -0000
From:   "tip-bot2 for Alexandre Torgue" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/stm32: Add irq retrigger support
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Marc Zyngier <maz@kernel.org>, Marek Vasut <marex@denx.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200219143229.18084-2-alexandre.torgue@st.com>
References: <20200219143229.18084-2-alexandre.torgue@st.com>
MIME-Version: 1.0
Message-ID: <158551358456.28353.6069975380249902216.tip-bot2@tip-bot2>
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

Commit-ID:     25591d4c6459ce416a319832ce806be7b86183dc
Gitweb:        https://git.kernel.org/tip/25591d4c6459ce416a319832ce806be7b86183dc
Author:        Alexandre Torgue <alexandre.torgue@st.com>
AuthorDate:    Wed, 19 Feb 2020 15:32:28 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 08 Mar 2020 14:25:45 

irqchip/stm32: Add irq retrigger support

This commit introduces retrigger support for stm32_ext_h chip.
It consists to rise the GIC interrupt mapped to an EXTI line.

Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Marek Vasut <marex@denx.de>
Link: https://lore.kernel.org/r/20200219143229.18084-2-alexandre.torgue@st.com
---
 drivers/irqchip/irq-stm32-exti.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index e00f2fa..faa8482 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -604,12 +604,24 @@ static void stm32_exti_h_syscore_deinit(void)
 	unregister_syscore_ops(&stm32_exti_h_syscore_ops);
 }
 
+static int stm32_exti_h_retrigger(struct irq_data *d)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	void __iomem *base = chip_data->host_data->base;
+	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
+
+	writel_relaxed(mask, base + stm32_bank->swier_ofst);
+
+	return 0;
+}
+
 static struct irq_chip stm32_exti_h_chip = {
 	.name			= "stm32-exti-h",
 	.irq_eoi		= stm32_exti_h_eoi,
 	.irq_mask		= stm32_exti_h_mask,
 	.irq_unmask		= stm32_exti_h_unmask,
-	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_retrigger		= stm32_exti_h_retrigger,
 	.irq_set_type		= stm32_exti_h_set_type,
 	.irq_set_wake		= stm32_exti_h_set_wake,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND,
