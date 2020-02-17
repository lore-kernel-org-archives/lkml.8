Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EA6C33FA1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D84D20578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XcLoP/Ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgBQNBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:01:30 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:28818 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728836AbgBQNBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:01:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581944489; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=sG89boOD+ZTEKtSXFwLkgYqnXxWQBkZUG4IMHwlHLA0=; b=XcLoP/EelScYnidhUH/1qj7Sxbgi9si3nnS9JdyTdYleFQQoqEHvSvEwCEA/gsX5c4kUYhJT
 gPaZqscCrzRcEQf4mlW756VyMEXWUGN/k84uwIY4owkoJk6ZRGHZkIFZQu1Mmna9nHElSs8f
 4Dj/EW/07lyAPFBK4AvPxuyM/WE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4a8e9b.7f951dc650a0-smtp-out-n01;
 Mon, 17 Feb 2020 13:01:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EADB3C433A2; Mon, 17 Feb 2020 13:01:14 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3FC22C4479D;
        Mon, 17 Feb 2020 13:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3FC22C4479D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, linus.walleij@linaro.org, tglx@linutronix.de,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, Maulik Shah <mkshah@codeaurora.org>
Subject: [RFC 1/2] irqchip: qcom: pdc: Introduce irq_set_wake call
Date:   Mon, 17 Feb 2020 18:30:07 +0530
Message-Id: <1581944408-7656-2-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581944408-7656-1-git-send-email-mkshah@codeaurora.org>
References: <1581944408-7656-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the way interrupts get enabled at wakeup capable PDC irq chip.
Introduce irq_set_wake call which lets interrupts enabled at PDC with
enable_irq_wake and disabled with disable_irq_wake.

Remove irq_disable and irq_enable calls which now will default to irq_mask
and irq_unmask.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/irqchip/qcom-pdc.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 6ae9e1f..145d4ae 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2017-2020, The Linux Foundation. All rights reserved.
  */
 
 #include <linux/err.h>
@@ -87,22 +87,17 @@ static void pdc_enable_intr(struct irq_data *d, bool on)
 	raw_spin_unlock(&pdc_lock);
 }
 
-static void qcom_pdc_gic_disable(struct irq_data *d)
+static int qcom_pdc_gic_set_wake(struct irq_data *d, unsigned int on)
 {
 	if (d->hwirq == GPIO_NO_WAKE_IRQ)
-		return;
-
-	pdc_enable_intr(d, false);
-	irq_chip_disable_parent(d);
-}
+		return 0;
 
-static void qcom_pdc_gic_enable(struct irq_data *d)
-{
-	if (d->hwirq == GPIO_NO_WAKE_IRQ)
-		return;
+	if (on)
+		pdc_enable_intr(d, true);
+	else
+		pdc_enable_intr(d, false);
 
-	pdc_enable_intr(d, true);
-	irq_chip_enable_parent(d);
+	return irq_chip_set_wake_parent(d, on);
 }
 
 static void qcom_pdc_gic_mask(struct irq_data *d)
@@ -197,15 +192,13 @@ static struct irq_chip qcom_pdc_gic_chip = {
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_mask		= qcom_pdc_gic_mask,
 	.irq_unmask		= qcom_pdc_gic_unmask,
-	.irq_disable		= qcom_pdc_gic_disable,
-	.irq_enable		= qcom_pdc_gic_enable,
 	.irq_get_irqchip_state	= qcom_pdc_gic_get_irqchip_state,
 	.irq_set_irqchip_state	= qcom_pdc_gic_set_irqchip_state,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_type		= qcom_pdc_gic_set_type,
+	.irq_set_wake		= qcom_pdc_gic_set_wake,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND |
-				  IRQCHIP_SET_TYPE_MASKED |
-				  IRQCHIP_SKIP_SET_WAKE,
+				  IRQCHIP_SET_TYPE_MASKED,
 	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
