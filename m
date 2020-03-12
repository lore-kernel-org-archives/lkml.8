Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F293DC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C965220663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="UaMwx1b7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCLNX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:23:27 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:50178 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgCLNX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:23:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584019406; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=d2Q0lpDfCcmsJqb0M+G4gmffrM2e4pqallkTAPF/tQM=; b=UaMwx1b7krcjiHiEHjWE4NG+YdGAjhGrdL8oCzrPUUPwIaIlthJnVoBmVbL7CydJVhgLT4wA
 5JONEWZaznr1IjoIlkoktgzioE1ShY3htifZNJDJ8KYc9wgvpwoWAF2/usuV3G0kNr6EMm69
 DmaCQJ57skk+NN/ZHP6a2HFwQyk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a37c5.7f76a71c6e30-smtp-out-n04;
 Thu, 12 Mar 2020 13:23:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6B120C433BA; Thu, 12 Mar 2020 13:23:16 +0000 (UTC)
Received: from mkshah-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A6B5AC433D2;
        Thu, 12 Mar 2020 13:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A6B5AC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
To:     swboyd@chromium.org, mka@chromium.org, evgreen@chromium.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, linus.walleij@linaro.org, tglx@linutronix.de,
        maz@kernel.org, jason@lakedaemon.net, dianders@chromium.org,
        rnayak@codeaurora.org, ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
Subject: [RFC v2] pdc: Introduce irq_set_wake call
Date:   Thu, 12 Mar 2020 18:52:58 +0530
Message-Id: <1584019379-12085-1-git-send-email-mkshah@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
- Drop pinctrl irqchip change and update in PDC irqchip change
- Include more details for .irq_set_wake introduction
- Address Stephen's comments for CPUidle need not call enable_irq_wake
- Update cover letter inline to add more detail on problem and solution

irqchip: qcom: pdc: Introduce irq_set_wake call

Some drivers using gpio interrupts want to configure gpio for wakeup using
enable_irq_wake() but during suspend entry disables irq and expects system
to resume when interrupt occurs. In the driver resume call interrupt is
re-enabled and removes wakeup capability using disable_irq_wake() one such
example is cros ec driver.

With [1] in documentation saying "An irq can be disabled with disable_irq()
and still wake the system as long as the irq has wake enabled".

In such scenario the gpio irq stays disabled at gpio irqchip but needs to
keep enabled in the hierarchy for wakeup capable parent PDC and GIC irqchip
to be able to detect and forward wake capable interrupt to CPU when system
is in sleep state like suspend.

The final status at PDC irq_chip should be an "OR" of "enable" and "wake" calls.
(i.e. same per below table)
|--------------------------------------------------|
| ENABLE in SW | WAKE in SW | PDC & GIC HW Status  |
|      0       |     0      |     0	           |
|      0       |     1      |     1	           |
|      1       |     0      |     1		   |
|      1       |     1      |     1	           |
|--------------------------------------------------|

Sending this as an RFC since this series attempts to add support for [1] by
introducing irq_set_wake call for PDC irqchip from which interrupt can be
enabled/disabled at PDC (and its parent GIC) hardware.

Note that *ALL* drivers using wakeup capable interrupt with enable_irq_wake()
and want to disable irq with disable_irq() need to call disable_irq_wake()
also if they want to stop wakeup capability at parent PDC irqchip.
Not doing so will lead to system getting woken up from sleep states if wakeup
capable IRQ comes in.

[1] https://www.spinics.net/lists/kernel/msg3398294.html

Maulik Shah (1):
  irqchip: qcom: pdc: Introduce irq_set_wake call

 drivers/irqchip/qcom-pdc.c | 115 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 108 insertions(+), 7 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
