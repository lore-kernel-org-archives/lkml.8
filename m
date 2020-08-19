Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C97AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDCA2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgHSQTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:19:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46736 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgHSQTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:19:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A77BF299C37
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Frank Wunderlich <linux@fw-web.de>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Saravana Kannan <saravanak@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] Revert "irqchip/mtk-sysirq: Convert to a platform driver"
Date:   Wed, 19 Aug 2020 18:19:07 +0200
Message-Id: <20200819161907.1155110-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f97dbf48ca43009e8b8bcdf07f47fc9f06149b36.

Although converting to a platform driver sounds good, doing this for the
MediaTek devices has a side effect, the probe of the driver is delayed
and the interrupt controller is not available for other drivers when
they probe. For MT8173 that means that the `systimer` and `mtk_cmdq`
drivers will fail to probe with the following errors:

  [    0.000197] Failed to map interrupt for /soc/timer@10008000
  [    0.000209] Failed to initialize '/soc/timer@10008000': -22
  [    0.067386] mtk_cmdq 10212000.mailbox: failed to register ISR (-22)

For MT8183, apart from the above errors, you will get the `pinctrl`
driver without the EINT support, because the `pinctrl` is probed before
the interrupt controller, for what is worth, then it doesn't booting
properly.

  [    0.062309] mt8183-pinctrl 10005000.pinctrl: Failed to add EINT, but pinctrl still can work

While deferring these drivers until the irqchip is available could be an
option, at this point, seems reasonable to revert this commit for now until
all these drivers are properly handling/deferring when the irqchip is not
available.

Cc: Saravana Kannan <saravanak@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Hanks Chen <hanks.chen@mediatek.com>
Fixes: f97dbf48ca43 ("irqchip/mtk-sysirq: Convert to a platform driver")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/irqchip/irq-mtk-sysirq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 7299c5ab4d10..6ff98b87e5c0 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -231,6 +231,4 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
 	kfree(chip_data);
 	return ret;
 }
-IRQCHIP_PLATFORM_DRIVER_BEGIN(mtk_sysirq)
-IRQCHIP_MATCH("mediatek,mt6577-sysirq", mtk_sysirq_of_init)
-IRQCHIP_PLATFORM_DRIVER_END(mtk_sysirq)
+IRQCHIP_DECLARE(mtk_sysirq, "mediatek,mt6577-sysirq", mtk_sysirq_of_init);
-- 
2.28.0

