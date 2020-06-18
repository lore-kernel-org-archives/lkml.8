Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1F9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F1F20853
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446349;
	bh=pa5xwxs/YMVeg48Xp1oAklH4xCcH4s/8Z/abaSwieRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eUt7OH85bo3YiNcZxGPx4s26W9kTMvUEmu2srPn3tBftFAcr/O7YcRoM2mi6wWziB
	 9QN+hEK6PFKsrysHuqXhN9eSp5ggrQv6x9tRUOpkonNZEGQjV+KrmCdmUuz6jVRQ9u
	 O/mt7zMPrg2RgbY1zVc0iUUTD3n4ywCbgLoF5jeQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgFRCM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbgFRBVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:21:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA773214DB;
        Thu, 18 Jun 2020 01:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443280;
        bh=pa5xwxs/YMVeg48Xp1oAklH4xCcH4s/8Z/abaSwieRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ub8SSKzs1CjhBG2BQLBlO1tKbwJJ40lC5yLytrFLAfaLoyFEI3zLfC4iVB0+95+e6
         r1AWPdD/KCUGqRcOUXXT8aIQN1BsfQz8veIzSVTBv0V7n+0Q5Usum2mqqc+DhJyF5e
         tPydOaMujpuLa+Fv3Tvybi0cd2VW22K1dBgAXYvE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 224/266] pinctrl: freescale: imx: Use 'devm_of_iomap()' to avoid a resource leak in case of error in 'imx_pinctrl_probe()'
Date:   Wed, 17 Jun 2020 21:15:49 -0400
Message-Id: <20200618011631.604574-224-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit ba403242615c2c99e27af7984b1650771a2cc2c9 ]

Use 'devm_of_iomap()' instead 'of_iomap()' to avoid a resource leak in
case of error.

Update the error handling code accordingly.

Fixes: 26d8cde5260b ("pinctrl: freescale: imx: add shared input select reg support")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20200602200626.677981-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 1f81569c7ae3..cb7e0f08d2cf 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -824,12 +824,13 @@ int imx_pinctrl_probe(struct platform_device *pdev,
 				return -EINVAL;
 			}
 
-			ipctl->input_sel_base = of_iomap(np, 0);
+			ipctl->input_sel_base = devm_of_iomap(&pdev->dev, np,
+							      0, NULL);
 			of_node_put(np);
-			if (!ipctl->input_sel_base) {
+			if (IS_ERR(ipctl->input_sel_base)) {
 				dev_err(&pdev->dev,
 					"iomuxc input select base address not found\n");
-				return -ENOMEM;
+				return PTR_ERR(ipctl->input_sel_base);
 			}
 		}
 	}
-- 
2.25.1

