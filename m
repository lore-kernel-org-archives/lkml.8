Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC48C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F06A2072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="B4eX9Y/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgHVQSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:18:02 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:44049 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728445AbgHVQRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:17:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598113062; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=g2D5CX6PHFtAoeO/TcMtBIyamIbzmydUlaD8kWcjgZs=; b=B4eX9Y/YmB5BVT/emB5yEjczRxQnwpL8mazxwhHAIXp3xL8PFk3Ym9AyXHKFN6t8zmeUX3dE
 F7IrGnDeCQAfBzPJp/vHvxX0yPdX7yDNX/+xMEyrgAtsHj8yqoQz1AVXkcDCVMkWCwUTO1C0
 /QujG5h3ZUzGvIaWVI25aNBz/4Q=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f414524c1ce10a0514f36a9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 22 Aug 2020 16:17:40
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1739BC433CB; Sat, 22 Aug 2020 16:17:40 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1E8EC43387;
        Sat, 22 Aug 2020 16:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1E8EC43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     bjorn.andersson@linaro.org, maz@kernel.org,
        linus.walleij@linaro.org, swboyd@chromium.org,
        evgreen@chromium.org, mka@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, agross@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [PATCH v5 4/6] pinctrl: qcom: Set IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag
Date:   Sat, 22 Aug 2020 21:46:59 +0530
Message-Id: <1598113021-4149-5-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598113021-4149-1-git-send-email-mkshah@codeaurora.org>
References: <1598113021-4149-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag to enable/unmask the
wakeirqs during suspend entry.

Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 1df2322..c4bcda9 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1242,7 +1242,8 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	pctrl->irq_chip.irq_set_affinity = msm_gpio_irq_set_affinity;
 	pctrl->irq_chip.irq_set_vcpu_affinity = msm_gpio_irq_set_vcpu_affinity;
 	pctrl->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND |
-				IRQCHIP_SET_TYPE_MASKED;
+				IRQCHIP_SET_TYPE_MASKED |
+				IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND;
 
 	np = of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
 	if (np) {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

