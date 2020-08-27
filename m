Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CCDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 20:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1755208C9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 20:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598558934;
	bh=HjZ45Ea8Nex20zUFNvtFaU1eRcozwjjKB1eLAew+OQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZzozZ41AeXWBd3bLy/QW2Pjzlasvz3vjssh1qYlGqIXGPaxYZRsNzei0o03JguMtw
	 +QgVCogYthaPxjk4eDE/QcrbBfblzlMhwmuHEQejYVN6HGKLmhuAybUhqBPJJhRbx1
	 aLJIU34bxuvah/n0P8n6wdkKxvoWsSoAw+/vhAAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgH0UIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 16:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgH0UIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 16:08:52 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6543520737;
        Thu, 27 Aug 2020 20:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598558931;
        bh=HjZ45Ea8Nex20zUFNvtFaU1eRcozwjjKB1eLAew+OQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sCPSmc9RxrMHbIf6S8DABmPBVlWx8Ssyvwkq6fqtZgQ4sPo1puCHk3yqn4Jhj0CfV
         4ut/br5MNdIKoFME0nJm9+dMCdSXmVHF8pKuMZJ+qgVlKu3KSC6Iq8q2JBSEb4+Y8W
         IXv0MI8WvrzwzNgPoCG63B4mZtcC0EieIcoaOhTQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ray Jui <rjui@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, Keerthy <j-keerthy@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/6] gpio: pisosr: Simplify with dev_err_probe()
Date:   Thu, 27 Aug 2020 22:08:26 +0200
Message-Id: <20200827200827.26462-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827200827.26462-1-krzk@kernel.org>
References: <20200827200827.26462-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpio/gpio-pisosr.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
index 6698feabaced..8e04054cf07e 100644
--- a/drivers/gpio/gpio-pisosr.c
+++ b/drivers/gpio/gpio-pisosr.c
@@ -148,12 +148,9 @@ static int pisosr_gpio_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	gpio->load_gpio = devm_gpiod_get_optional(dev, "load", GPIOD_OUT_LOW);
-	if (IS_ERR(gpio->load_gpio)) {
-		ret = PTR_ERR(gpio->load_gpio);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Unable to allocate load GPIO\n");
-		return ret;
-	}
+	if (IS_ERR(gpio->load_gpio))
+		return dev_err_probe(dev, PTR_ERR(gpio->load_gpio),
+				     "Unable to allocate load GPIO\n");
 
 	mutex_init(&gpio->lock);
 
-- 
2.17.1

