Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DA4C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57EE207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599059309;
	bh=5iRwtqLGIaU3uPg9BY6GBRjrupD8zIVjtKmDsp2Jg/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rnY5fqhqSlnO3WmEaQX7lcw93zCIkXdOQqx/g8o63YNy64auDZpFH72qylf191XmJ
	 WGuWaC5lpbKOYmFii/dO6oZnMsYir1jvhf+lZkjcMiC2ankXdiU1Zaa0WhZi/hrzfz
	 usnxP22+JJ/skAEQqcG07zKWJZVplaugeP1dy9IU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgIBPI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728204AbgIBPHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:07:19 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3641A2145D;
        Wed,  2 Sep 2020 15:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599059238;
        bh=5iRwtqLGIaU3uPg9BY6GBRjrupD8zIVjtKmDsp2Jg/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GNkiuU8Rl/r3xUgj/bZpKyVKzsX0Nx9oVCnPdouXwVG6rZR2yOaF7PHRgruua9nDi
         TnkASDWk8S0GyFhAqP7pw++HhJGYsGqRSBRgPqeelc8g5bSlthQm2F5s1ldnv4E87X
         J8DvKMe7sEJbzUZnKCxDCYIk3PTG96q28dwRaog8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Michal Simek <michal.simek@xilinx.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@kernel.org>,
        linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/9] i2c: davinci: Simplify with dev_err_probe()
Date:   Wed,  2 Sep 2020 17:06:39 +0200
Message-Id: <20200902150643.14839-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902150643.14839-1-krzk@kernel.org>
References: <20200902150643.14839-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/i2c/busses/i2c-davinci.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 232a7679b69b..e9d07323c604 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -768,10 +768,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	if (irq <= 0) {
 		if (!irq)
 			irq = -ENXIO;
-		if (irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"can't get irq resource ret=%d\n", irq);
-		return irq;
+		return dev_err_probe(&pdev->dev, irq, "can't get irq resource\n");
 	}
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct davinci_i2c_dev),
-- 
2.17.1

