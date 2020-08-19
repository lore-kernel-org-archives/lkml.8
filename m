Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D643C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70882205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 02:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgHSCXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 22:23:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbgHSCXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 22:23:44 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F059788C4DA54FD433DF;
        Wed, 19 Aug 2020 10:23:18 +0800 (CST)
Received: from huawei.com (10.90.52.227) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 19 Aug 2020
 10:23:12 +0800
From:   qiuguorui1 <qiuguorui1@huawei.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <zengweilin@huawei.com>,
        <chenjianguo3@huawei.com>, <qiuguorui1@huawei.com>
Subject: [PATCH] irqchip/stm32-exti: avoid interrupts losing due to clearing pending bit by mistake
Date:   Wed, 19 Aug 2020 10:39:31 +0800
Message-ID: <20200819023931.28997-1-qiuguorui1@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.52.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous code, when the eoi handle of the exti clears the pending
bit of the current interrupt, it will first read the values of fpr and
rpr, then logically OR the corresponding bit of the interrupt number,
and finally write back to fpr and rpr.

We found through experiments that if two exti interrupts,
we call them int1/int2, arrive almost at the same time. in our scenario,
the time difference is 30 microseconds, assuming int1 is triggered first.

there will be an extreme scenario: both int's pending bit are set to 1,
the irq handle of int1 is executed first, and eoi handle is then executed,
at this moment, all pending bits are cleared, but the int 2 has not
finally been reported to the cpu yet, which eventually lost int2.

According to stm32's TRM description about rpr and fpr: Writing a 1 to this
bit will trigger a rising edge event on event x, Writing 0 has no
effect.

Therefore, when clearing the pending bit, we only need to clear the
pending bit of the irq.

Signed-off-by: qiuguorui1 <qiuguorui1@huawei.com>
---
 drivers/irqchip/irq-stm32-exti.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 03a36be757d8..ee4faf5c90b8 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -26,6 +26,11 @@
 
 #define HWSPNLCK_TIMEOUT	1000 /* usec */
 
+enum reg_ops {
+	REG_WRITE_ONLY,
+	REG_READ_WRITE
+};
+
 struct stm32_exti_bank {
 	u32 imr_ofst;
 	u32 emr_ofst;
@@ -416,13 +421,14 @@ static void stm32_irq_ack(struct irq_data *d)
 	irq_gc_unlock(gc);
 }
 
-static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
+static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg, enum reg_ops op)
 {
 	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
 	void __iomem *base = chip_data->host_data->base;
-	u32 val;
+	u32 val = 0;
 
-	val = readl_relaxed(base + reg);
+	if (op == REG_READ_WRITE)
+		val = readl_relaxed(base + reg);
 	val |= BIT(d->hwirq % IRQS_PER_BANK);
 	writel_relaxed(val, base + reg);
 
@@ -449,9 +455,9 @@ static void stm32_exti_h_eoi(struct irq_data *d)
 
 	raw_spin_lock(&chip_data->rlock);
 
-	stm32_exti_set_bit(d, stm32_bank->rpr_ofst);
+	stm32_exti_set_bit(d, stm32_bank->rpr_ofst, REG_WRITE_ONLY);
 	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		stm32_exti_set_bit(d, stm32_bank->fpr_ofst);
+		stm32_exti_set_bit(d, stm32_bank->fpr_ofst, REG_WRITE_ONLY);
 
 	raw_spin_unlock(&chip_data->rlock);
 
@@ -478,7 +484,7 @@ static void stm32_exti_h_unmask(struct irq_data *d)
 	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
 
 	raw_spin_lock(&chip_data->rlock);
-	chip_data->mask_cache = stm32_exti_set_bit(d, stm32_bank->imr_ofst);
+	chip_data->mask_cache = stm32_exti_set_bit(d, stm32_bank->imr_ofst, REG_READ_WRITE);
 	raw_spin_unlock(&chip_data->rlock);
 
 	if (d->parent_data->chip)
-- 
2.12.3

