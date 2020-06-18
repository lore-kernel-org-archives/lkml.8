Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96393C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C376206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447794;
	bh=L+2u2x+M17UPWRFkAT8mRWoi6IoHPRAravkJ2WX2OFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CL1rTREUkroA0D46c5Z6USkRk8V/GB7mxv3Xc1WCa4tarjQGurXd3X7QLGJ9gwJR4
	 cXBm9tWZqZH/ay2PXHzBzhtI7r5md1/nklZETI4DOz04rgDt3zb57HNfKFwscv5vmp
	 pW5jTxh0dhuG0kJox/ukt5Jc3VzA8kGrxCaoQBFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbgFRCgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729239AbgFRBN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:13:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9FCD21924;
        Thu, 18 Jun 2020 01:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442835;
        bh=L+2u2x+M17UPWRFkAT8mRWoi6IoHPRAravkJ2WX2OFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQ3nCr3SHpbkua+1tYSTYfI+OkILvLU1HiP0imX4P6ckqBtyXu/xrsebVoRpHELqV
         PQ1N4MmsBTyuCOxFAlmvpDq/zqlymqUBTZpVg7diDTaxUZO1NfYDt/B7z7ZMA+ZiIj
         R4Ikc2Zulgo+gsvWW60av4m01qMHDAhouKUFx8Ok=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 269/388] pinctrl: Fix return value about devm_platform_ioremap_resource()
Date:   Wed, 17 Jun 2020 21:06:06 -0400
Message-Id: <20200618010805.600873-269-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit b5d9ff10dca49f4d4b7846c3751c6bec50d07375 ]

When call function devm_platform_ioremap_resource(), we should use IS_ERR()
to check the return value and return PTR_ERR() if failed.

Fixes: 4b024225c4a8 ("pinctrl: use devm_platform_ioremap_resource() to simplify code")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Link: https://lore.kernel.org/r/1590234326-2194-1-git-send-email-yangtiezhu@loongson.cn
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/bcm/pinctrl-bcm281xx.c | 2 +-
 drivers/pinctrl/pinctrl-at91-pio4.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
index f690fc5cd688..71e666178300 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm281xx.c
@@ -1406,7 +1406,7 @@ static int __init bcm281xx_pinctrl_probe(struct platform_device *pdev)
 	pdata->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pdata->reg_base)) {
 		dev_err(&pdev->dev, "Failed to ioremap MEM resource\n");
-		return -ENODEV;
+		return PTR_ERR(pdata->reg_base);
 	}
 
 	/* Initialize the dynamic part of pinctrl_desc */
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 694912409fd9..54222ccddfb1 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -1019,7 +1019,7 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 
 	atmel_pioctrl->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(atmel_pioctrl->reg_base))
-		return -EINVAL;
+		return PTR_ERR(atmel_pioctrl->reg_base);
 
 	atmel_pioctrl->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(atmel_pioctrl->clk)) {
-- 
2.25.1

