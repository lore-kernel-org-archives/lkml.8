Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DA4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 187BD22B4E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453306;
	bh=cabo5bmKA9S3Z+5Um9Eh1dxwPh2SCuYG74GJw0p4rDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GHz345i+3Fas0W6SGmcRjhms8MJq6V2igbVbB9RWQpO072tYwELiqkuu8XvyNO/TH
	 c6dczuSilWXaQo7YQiEyKI6G8QKa1Mkfe2dUbW8Pi7Af7sTEH8pL9LooZBTg/Y4isn
	 EufTXsThyQmeXRnCMEP29Uc1yvouN4pYWRUPgftM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgHZOsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:48:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbgHZOsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:48:20 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9ED42177B;
        Wed, 26 Aug 2020 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453299;
        bh=cabo5bmKA9S3Z+5Um9Eh1dxwPh2SCuYG74GJw0p4rDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zsdBJajz8wmzsUOxsIodz7vIvPB/ZBznlGLnIsKgNBBa3GWHti1ZqtGAllBtLnH4X
         JEP2pBzOPmHv1xubmR+XvhnIj61z8JpLf9HoxkYCxL92cpUa5Slmy7/SPtGXwmBybz
         rPGCt5qFkAURoM+CzgC8RK33ZqP1XzK5f8teQ6h0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/6] pwm: rockchip: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:47:44 +0200
Message-Id: <20200826144747.9436-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826144747.9436-1-krzk@kernel.org>
References: <20200826144747.9436-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pwm/pwm-rockchip.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index eb8c9cb645a6..4773969346e0 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -306,13 +306,9 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	pc->clk = devm_clk_get(&pdev->dev, "pwm");
 	if (IS_ERR(pc->clk)) {
 		pc->clk = devm_clk_get(&pdev->dev, NULL);
-		if (IS_ERR(pc->clk)) {
-			ret = PTR_ERR(pc->clk);
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev, "Can't get bus clk: %d\n",
-					ret);
-			return ret;
-		}
+		if (IS_ERR(pc->clk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
+					     "Can't get bus clk\n");
 	}
 
 	count = of_count_phandle_with_args(pdev->dev.of_node,
-- 
2.17.1

