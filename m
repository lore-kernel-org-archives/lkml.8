Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105A1C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83D0206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979182;
	bh=YN6z6t1igdxdmPtWM9p/oZkiYtSvg0xJAQvZjA5iT0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kx4657teqdXM5dyl7XIXIUZ6E3kQjIQ9DotY/a266xjeIkLqvv6gOMgNSXH38bvuk
	 /+4sikB5TRsIoKqCxximBqW3Xs1MlEtfvYfGEb+yENcR3DZDW/dSA7psErWdt1aiO8
	 sKeGSrC5TB2dwpfCunJ5XUu12gUSG77b1Zbi6XFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbgIAQxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbgIAPZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:25:30 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63CA6206FA;
        Tue,  1 Sep 2020 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973930;
        bh=YN6z6t1igdxdmPtWM9p/oZkiYtSvg0xJAQvZjA5iT0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktkVQIX+G1hrOiRhMl7LCmFfvykxTBFMjXx9w/D1nbZKObX3SNQ+ad8Zle6bbD1Qt
         4En5F01vNCnidjo6IX3+N1xMWRFCNqGir1ZvngYHlgh9tzo0q20O6XZjoWB4qZbYD7
         lyaXuHHgHWSxGb3RRI8YUSjAHe4tk0vGw6D4RUK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, qiuguorui1 <qiuguorui1@huawei.com>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 4.19 104/125] irqchip/stm32-exti: Avoid losing interrupts due to clearing pending bits by mistake
Date:   Tue,  1 Sep 2020 17:10:59 +0200
Message-Id: <20200901150939.704632067@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: qiuguorui1 <qiuguorui1@huawei.com>

commit e579076ac0a3bebb440fab101aef3c42c9f4c709 upstream.

In the current code, when the eoi callback of the exti clears the pending
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

Fixes: 927abfc4461e7 ("irqchip/stm32: Add stm32mp1 support with hierarchy domain")
Signed-off-by: qiuguorui1 <qiuguorui1@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org # v4.18+
Link: https://lore.kernel.org/r/20200820031629.15582-1-qiuguorui1@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-stm32-exti.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -382,6 +382,16 @@ static void stm32_irq_ack(struct irq_dat
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
@@ -415,9 +425,9 @@ static void stm32_exti_h_eoi(struct irq_
 
 	raw_spin_lock(&chip_data->rlock);
 
-	stm32_exti_set_bit(d, stm32_bank->rpr_ofst);
+	stm32_exti_write_bit(d, stm32_bank->rpr_ofst);
 	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		stm32_exti_set_bit(d, stm32_bank->fpr_ofst);
+		stm32_exti_write_bit(d, stm32_bank->fpr_ofst);
 
 	raw_spin_unlock(&chip_data->rlock);
 


