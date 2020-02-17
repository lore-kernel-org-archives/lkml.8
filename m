Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAC6C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0207220578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 13:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="JoJKdeAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgBQNCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 08:02:08 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:28818 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728297AbgBQNCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:02:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581944528; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=FXVCV46lgahgiiYf9qIKrggfQv2a2+GVkFrWuvKO1qU=; b=JoJKdeAICSfF1clO6wnsYFw/5UCVZn/nrxDJTcHAKxO8MYOnItnGaFI/GpS6sI0wU2y+loYi
 zIKYepitkR5BkWzMB8sQyH1+L3ukCiZeDotwnovzm6unnP/M6Ichp1Ubx1RX7MypDj95HVVn
 BdjoQjF3ur69WQR88WB1gY0D+MU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e4a8ea0.7ff9f8ec8500-smtp-out-n02;
 Mon, 17 Feb 2020 13:01:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 721E3C43383; Mon, 17 Feb 2020 13:01:19 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05EF6C447A2;
        Mon, 17 Feb 2020 13:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05EF6C447A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, linus.walleij@linaro.org, tglx@linutronix.de,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, Maulik Shah <mkshah@codeaurora.org>
Subject: [RFC 2/2] pinctrl: qcom: Remove forwarding irq_disable and irq_enable call to parent
Date:   Mon, 17 Feb 2020 18:30:08 +0530
Message-Id: <1581944408-7656-3-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581944408-7656-1-git-send-email-mkshah@codeaurora.org>
References: <1581944408-7656-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop forwarding irq_disable and irq_enable from msmgpio to parent PDC.

The irq gets enabled/disabled at wakeup capable parent PDC when wakeup
capability changes with enable_irq_wake or disable_irq_wake.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 9a8daa2..a8973d2 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -803,10 +803,8 @@ static void msm_gpio_irq_enable(struct irq_data *d)
 	 * the interrupt from being latched at the GIC. The state at
 	 * GIC needs to be cleared before enabling.
 	 */
-	if (d->parent_data) {
+	if (d->parent_data)
 		irq_chip_set_parent_state(d, IRQCHIP_STATE_PENDING, 0);
-		irq_chip_enable_parent(d);
-	}
 
 	msm_gpio_irq_clear_unmask(d, true);
 }
@@ -816,9 +814,6 @@ static void msm_gpio_irq_disable(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
 
-	if (d->parent_data)
-		irq_chip_disable_parent(d);
-
 	if (!test_bit(d->hwirq, pctrl->skip_wake_irqs))
 		msm_gpio_irq_mask(d);
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
