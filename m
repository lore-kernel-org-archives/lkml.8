Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A47C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3735E2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OalkkKi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHJLY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:24:56 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:41348 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbgHJLVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 07:21:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597058504; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=xHYEdUgnHp0JS97AmayvKH+aTXL2WxGTLHvNm3560lA=; b=OalkkKi4DvotLxHQYragLDB0beZjPWXPFuCm3RLF93FMlx6o9ocgjUs2wAZ/c+HnbN69YKRV
 XeFootBv5n3OpIureXeEBfKGEn/aeKsXRVIusQQfLObSXZ8CV+8bp8v2ObjIdxcL5vtU2PXq
 9mRgzqANhxO5FnHwaU/iijtSuoQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-west-2.postgun.com with SMTP id
 5f312db32f4952907d7e0bc4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 Aug 2020 11:21:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C7767C433AD; Mon, 10 Aug 2020 11:21:22 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82918C433CB;
        Mon, 10 Aug 2020 11:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82918C433CB
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
Subject: [PATCH v4 1/7] pinctrl: qcom: Add msmgpio irqchip flags
Date:   Mon, 10 Aug 2020 16:50:54 +0530
Message-Id: <1597058460-16211-2-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597058460-16211-1-git-send-email-mkshah@codeaurora.org>
References: <1597058460-16211-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add irqchip specific flags for msmgpio irqchip to mask non wakeirqs
during suspend and mask before setting irq type.

Masking before changing type should make sure any spurious interrupt
is not detected during this operation.

Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index a2567e7..90edf61 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1243,6 +1243,8 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
 	pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
 	pctrl->irq_chip.irq_set_affinity = msm_gpio_irq_set_affinity;
 	pctrl->irq_chip.irq_set_vcpu_affinity = msm_gpio_irq_set_vcpu_affinity;
+	pctrl->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND
+				| IRQCHIP_SET_TYPE_MASKED;
 
 	np = of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
 	if (np) {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

