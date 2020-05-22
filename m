Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FEFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB5F2222E7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159059;
	bh=kDllSztfZKlfNu9g1yBHYHaBq64UTXWIu8Dp188I4qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bvv2nbNu+tVm3ez7EPD9YAKaYcDqPkMtb97Si6O4+nWvYhAhS6o6a3BUqO7OQ1oqD
	 HJ2kpOO+r3LaD9KhNYfX3g0+QlG47iuaSz0VxKQrQd6VK42EOe3wUPvh16SfXZGmwZ
	 RZ4911U4hJH8cevnwONAcAEtAoCMdZ7FWuoeJCDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbgEVOu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730789AbgEVOuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:50:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13CE8221FF;
        Fri, 22 May 2020 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159053;
        bh=kDllSztfZKlfNu9g1yBHYHaBq64UTXWIu8Dp188I4qU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vDy2Fr/kteGdoUcY+oRbAX5dtbNkMWhD4nFFYm9ow4LfVb//MnDuy5Ei07A1oSvuL
         MVq3IoFxVySvi1vR18HRUbOgRZPUUCFg1p8Yc2dQRMTYZQWoZbmx/dNrsHYdm94eAL
         bXhqVFgqQJOvqKMUHapAIBCxC2Uv8ja4tOm1jLg0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stephen Warren <swarren@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 07/32] gpio: tegra: mask GPIO IRQs during IRQ shutdown
Date:   Fri, 22 May 2020 10:50:19 -0400
Message-Id: <20200522145044.434677-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522145044.434677-1-sashal@kernel.org>
References: <20200522145044.434677-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Warren <swarren@nvidia.com>

[ Upstream commit 0cf253eed5d2bdf7bb3152457b38f39b012955f7 ]

The driver currently leaves GPIO IRQs unmasked even when the GPIO IRQ
client has released the GPIO IRQ. This allows the HW to raise IRQs, and
SW to process them, after shutdown. Fix this by masking the IRQ when it's
shut down. This is usually taken care of by the irqchip core, but since
this driver has a custom irq_shutdown implementation, it must do this
explicitly itself.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Link: https://lore.kernel.org/r/20200427232605.11608-1-swarren@wwwdotorg.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-tegra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 8a01d3694b28..cecde5440a39 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -365,6 +365,7 @@ static void tegra_gpio_irq_shutdown(struct irq_data *d)
 	struct tegra_gpio_info *tgi = bank->tgi;
 	unsigned int gpio = d->hwirq;
 
+	tegra_gpio_irq_mask(d);
 	gpiochip_unlock_as_irq(&tgi->gc, gpio);
 }
 
-- 
2.25.1

