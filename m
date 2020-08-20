Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E061C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44AFA208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgHTDAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 23:00:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9856 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726851AbgHTDAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 23:00:17 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B39FA6764CA30B10BBD2;
        Thu, 20 Aug 2020 11:00:16 +0800 (CST)
Received: from huawei.com (10.90.52.227) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 20 Aug 2020
 11:00:08 +0800
From:   qiuguorui1 <qiuguorui1@huawei.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <ludovic.barre@st.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <zengweilin@huawei.com>,
        <chenjianguo3@huawei.com>, <qiuguorui1@huawei.com>
Subject: [PATCH v2] irqchip/stm32-exti: avoid interrupts losing due to clearing pending bit by mistake
Date:   Thu, 20 Aug 2020 11:16:29 +0800
Message-ID: <20200820031629.15582-1-qiuguorui1@huawei.com>
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

Changes in v2:
 - simplify the code by calling writel_relaxed directly
   in the function stm32_exti_h_eoi.

v1:https://lore.kernel.org/lkml/20200819023931.28997-1-qiuguorui1@huawei.com/

Signed-off-by: qiuguorui1 <qiuguorui1@huawei.com>
Fixes: 927abfc4461e7 ("irqchip/stm32: Add stm32mp1 support with hierarchy domain")
Cc: stable@vger.kernel.org # v4.18+
---
 drivers/irqchip/irq-stm32-exti.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 03a36be757d8..0c2c61db26b4 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -416,6 +416,16 @@ static void stm32_irq_ack(struct irq_data *d)
 	irq_gc_unlock(gc);
 }
 
+/* directly set the target bit without reading first. */
+static inline void stm32_exti_write_bit(struct irq_data *d, u32 reg)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	void __iomem *base = chip_data->host_data->base;
+	u32 val = BIT(d->hwirq % IRQS_PER_BANK);
+
+	writel_relaxed(val, base + reg);
+}
+
 static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
 {
 	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
@@ -449,9 +459,9 @@ static void stm32_exti_h_eoi(struct irq_data *d)
 
 	raw_spin_lock(&chip_data->rlock);
 
-	stm32_exti_set_bit(d, stm32_bank->rpr_ofst);
+	stm32_exti_write_bit(d, stm32_bank->rpr_ofst);
 	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		stm32_exti_set_bit(d, stm32_bank->fpr_ofst);
+		stm32_exti_write_bit(d, stm32_bank->fpr_ofst);
 
 	raw_spin_unlock(&chip_data->rlock);
 
-- 
2.12.3

