Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732FCC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444CC20855
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="h9DCawh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgHVQRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:17:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:20655 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728417AbgHVQRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:17:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598113053; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=kdsRTXM0DUlEJ9sRazCvpkF8bYZszMfyNl5R84rwOm0=; b=h9DCawh8KSAnii7M4zq9EF5cpkAcgrtc8WAwzy+BYP1xy553+pswk7DhPsvG48fyOf3lXhxn
 0+1DA2ReZV/NG6Rn910YsS3qZgjYe3RZNzL3hCDxclewmsSQeLwy26KMeuwG5ThRk24cNNIR
 eO0JxlxneIDempiVxSQUkEluedE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f414519f30e9e75c148222f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 22 Aug 2020 16:17:29
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88160C4339C; Sat, 22 Aug 2020 16:17:29 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F738C43387;
        Sat, 22 Aug 2020 16:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F738C43387
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
Subject: [PATCH v5 2/6] pinctrl: qcom: Use return value from irq_set_wake() call
Date:   Sat, 22 Aug 2020 21:46:57 +0530
Message-Id: <1598113021-4149-3-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598113021-4149-1-git-send-email-mkshah@codeaurora.org>
References: <1598113021-4149-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msmgpio irqchip was not using return value of irq_set_irq_wake() callback
since previously GIC-v3 irqchip neither had IRQCHIP_SKIP_SET_WAKE flag nor
it implemented .irq_set_wake callback. This lead to irq_set_irq_wake()
return error -ENXIO.

However from 'commit 4110b5cbb014 ("irqchip/gic-v3: Allow interrupt to be
configured as wake-up sources")' GIC irqchip has IRQCHIP_SKIP_SET_WAKE
flag.

Use return value from irq_set_irq_wake() and irq_chip_set_wake_parent()
instead of always returning success.

Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 1c23f5c..1df2322 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1077,12 +1077,10 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	 * when TLMM is powered on. To allow that, enable the GPIO
 	 * summary line to be wakeup capable at GIC.
 	 */
-	if (d->parent_data)
-		irq_chip_set_wake_parent(d, on);
-
-	irq_set_irq_wake(pctrl->irq, on);
+	if (d->parent_data && test_bit(d->hwirq, pctrl->skip_wake_irqs))
+		return irq_chip_set_wake_parent(d, on);
 
-	return 0;
+	return irq_set_irq_wake(pctrl->irq, on);
 }
 
 static int msm_gpio_irq_reqres(struct irq_data *d)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

