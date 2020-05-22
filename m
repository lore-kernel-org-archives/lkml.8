Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2EFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00F7420679
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="TjbYVXQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgEVNUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 09:20:33 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:59174 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729046AbgEVNUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 09:20:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590153630; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Wf+Ft3GAXv6Hn11ap7JENTyHYvhs9XYIKDP7SgyDCBk=; b=TjbYVXQkEWwrceCMDQKQoamX1G0ijLhLr/5ICmy6HuSN6eX6mPSJn24iJ5iQbw+c2bSfO+vZ
 viUk3gsdu6kp7r2eIVE01LYoZ+10NGyuqcWFQ0rsd3fkGmWkqyrju1ihnqQyBY+tE+FKOQMO
 RAa4nQqnGAECZu50wAP3oDrjUCk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ec7d1872a41f3ed006fdfe5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 13:20:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 221C1C43391; Fri, 22 May 2020 13:20:07 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 68FF4C433C8;
        Fri, 22 May 2020 13:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68FF4C433C8
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
Subject: [PATCH 0/4] irqchip: qcom: pdc: Introduce irq_set_wake call
Date:   Fri, 22 May 2020 18:49:25 +0530
Message-Id: <1590153569-21706-1-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support to lazy disable pdc interrupt.

Some drivers using gpio interrupts want to configure gpio for wakeup using
enable_irq_wake() but during suspend entry disables irq and expects system
to resume when interrupt occurs. In the driver resume call interrupt is
re-enabled and removes wakeup capability using disable_irq_wake() one such
example is cros ec driver.

With [1] in documentation saying "An irq can be disabled with disable_irq()
and still wake the system as long as the irq has wake enabled".

The PDC IRQs are currently "unlazy disabled" (disable here means that it
will be masked in PDC & GIC HW GICD_ISENABLER, the moment driver invokes
disable_irq()) such IRQs can not wakeup from low power modes like suspend
to RAM since the driver chosen to disable this.

During suspend entry, no one re-enable/unmask in HW, even if its marked for
wakeup.

One solutions thought to address this problem was...During suspend entry at
last point, irq chip driver re-enable/unmask IRQs in HW that are marked for
wakeup. This was attemped in [2].

This series adds alternate solution to [2] by "lazy disable" IRQs in HW.
The genirq takes care of lazy disable in case if irqchip did not implement
irq_disable callback. Below is high level steps on how this works out..

a. During driver's disable_irq() call, IRQ will be marked disabled in SW
b. IRQ will still be enabled(read unmasked in HW)
c. The device then enters low power mode like suspend to RAM
d. The HW detects unmasked IRQs and wakesup the CPU
e. During resume after local_irq_enable() CPU goes to handle the wake IRQ
f. Generic handler comes to know that IRQ is disabled in SW
g. Generic handler marks IRQ as pending and now invokes mask callback
h. IRQ gets disabled/masked in HW now
i. When driver invokes enable_irq() the SW pending IRQ leads IRQ's handler
j. enable_irq() will again enable/unmask in HW

[1] https://www.spinics.net/lists/kernel/msg3398294.html
[2] https://patchwork.kernel.org/patch/11466021/

Maulik Shah (4):
  gpio: gpiolib: Allow GPIO IRQs to lazy disable
  pinctrl: qcom: Remove irq_disable callback from msmgpio irqchip
  pinctrl: qcom: Add msmgpio irqchip flags
  irqchip: qcom-pdc: Introduce irq_set_wake call

 drivers/gpio/gpiolib.c             | 59 ++++++++++++++++++++++++--------------
 drivers/irqchip/qcom-pdc.c         | 33 ++++++++++-----------
 drivers/pinctrl/qcom/pinctrl-msm.c | 15 ++--------
 include/linux/gpio/driver.h        | 13 +++++++++
 4 files changed, 70 insertions(+), 50 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

