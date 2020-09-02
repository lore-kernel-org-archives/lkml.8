Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72532C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DD7E20773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599059530;
	bh=d/sTQ5yzFwXEJEHgq/56l3IhxWk0SqmDdAYgZ97oGLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u+mxteYdzXcexNSUi8rLmuGc6U3t06EKZ6dmTicDcKvyAwPFbDwdQ7PJhkInh+EF+
	 TDi5B1gGC3iSOgeiXCEs3BwX9gRjQZ17DiRjIjpuNRA2hPbPPRF/aRcbYogfq19VU7
	 tDY4gWYkBHRUwkQ973jEn0ifw5HkWhDcCD8qMo0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgIBPL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgIBPHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:07:07 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5904D207D3;
        Wed,  2 Sep 2020 15:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599059226;
        bh=d/sTQ5yzFwXEJEHgq/56l3IhxWk0SqmDdAYgZ97oGLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/zUDBdIP3PPMqY7dOzPHDAvrIyHmr5a94+wMAA+GArrXXeEutxsJgbYxbLyqq5/C
         E2uOTwHJpDZFD5orZyyIdP/7KY/VvPScasiEZgLWJhPj6XZph3ID7VW5AQpWQN1KXo
         nVLBNNpMdVGH9BOe6mD+vAdrJJcxgsrNTQ+15lZ8=
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
Subject: [PATCH 3/9] i2c: bcm2835: Simplify with dev_err_probe()
Date:   Wed,  2 Sep 2020 17:06:37 +0200
Message-Id: <20200902150643.14839-3-krzk@kernel.org>
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
 drivers/i2c/busses/i2c-bcm2835.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
index 5dc519516292..37443edbf754 100644
--- a/drivers/i2c/busses/i2c-bcm2835.c
+++ b/drivers/i2c/busses/i2c-bcm2835.c
@@ -421,11 +421,9 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c_dev->regs);
 
 	mclk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(mclk)) {
-		if (PTR_ERR(mclk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get clock\n");
-		return PTR_ERR(mclk);
-	}
+	if (IS_ERR(mclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(mclk),
+				     "Could not get clock\n");
 
 	i2c_dev->bus_clk = bcm2835_i2c_register_div(&pdev->dev, mclk, i2c_dev);
 
-- 
2.17.1

