Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5621C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C45092078E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948111;
	bh=SEcET0AxlMfL6QfmuPnxAdQ1ykxeLmO0WQ+DElGKUlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d9GPg8B9fJ5WrHykFdSqKEDBSP3AiVLifBFNZmTVf99ri+eomtnfqoH1R1eoM33gt
	 HZ/q+a2MSI4RdoQN4ra1qpsMLQdtaGk9dyj5PRbAuAEcSqBfJiMoZsRtmSswhWkEYz
	 kR2r+rD5pA9KPM+wdW/rkx+NDjMuJbK9E0CfnCoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388812AbgFWUKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:10:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:50854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388161AbgFWUJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:09:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CAB6206C3;
        Tue, 23 Jun 2020 20:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942980;
        bh=SEcET0AxlMfL6QfmuPnxAdQ1ykxeLmO0WQ+DElGKUlE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T7MlG0odxUbJ9mmrbrpZeptbpa92ZEzCA7+3ytauSy+/JU6ZBZ30I+QxEkwux7ANJ
         A2/I0Ttd/jF/HJPN7LZT1WiHNYjWHpShoPANbVPKaPJuNzz6pzdsP3zD/zXHOBaw+x
         bW0qNF81ABr4R7Vd0+KrRCNWKI0KkAQvUkQ0Cc5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 212/477] pinctrl: ocelot: Always register GPIO driver
Date:   Tue, 23 Jun 2020 21:53:29 +0200
Message-Id: <20200623195417.605264176@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Povlsen <lars.povlsen@microchip.com>

[ Upstream commit 550713e33f4338c8596776828a936fd1e3bf35de ]

This fixes the situation where the GPIO controller is not
used as an interrupt controller as well.

Previously, the driver would silently fail to register even the
GPIO's. With this change, the driver will only register as an
interrupt controller if a parent interrupt is provided.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
Link: https://lore.kernel.org/r/20200513125532.24585-2-lars.povlsen@microchip.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-ocelot.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-ocelot.c b/drivers/pinctrl/pinctrl-ocelot.c
index 4b99922d6c7e7..b1bf46ec207fd 100644
--- a/drivers/pinctrl/pinctrl-ocelot.c
+++ b/drivers/pinctrl/pinctrl-ocelot.c
@@ -752,21 +752,21 @@ static int ocelot_gpiochip_register(struct platform_device *pdev,
 	gc->of_node = info->dev->of_node;
 	gc->label = "ocelot-gpio";
 
-	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
-	if (irq <= 0)
-		return irq;
-
-	girq = &gc->irq;
-	girq->chip = &ocelot_irqchip;
-	girq->parent_handler = ocelot_irq_handler;
-	girq->num_parents = 1;
-	girq->parents = devm_kcalloc(&pdev->dev, 1, sizeof(*girq->parents),
-				     GFP_KERNEL);
-	if (!girq->parents)
-		return -ENOMEM;
-	girq->parents[0] = irq;
-	girq->default_type = IRQ_TYPE_NONE;
-	girq->handler = handle_edge_irq;
+	irq = irq_of_parse_and_map(gc->of_node, 0);
+	if (irq) {
+		girq = &gc->irq;
+		girq->chip = &ocelot_irqchip;
+		girq->parent_handler = ocelot_irq_handler;
+		girq->num_parents = 1;
+		girq->parents = devm_kcalloc(&pdev->dev, 1,
+					     sizeof(*girq->parents),
+					     GFP_KERNEL);
+		if (!girq->parents)
+			return -ENOMEM;
+		girq->parents[0] = irq;
+		girq->default_type = IRQ_TYPE_NONE;
+		girq->handler = handle_edge_irq;
+	}
 
 	ret = devm_gpiochip_add_data(&pdev->dev, gc, info);
 	if (ret)
-- 
2.25.1



