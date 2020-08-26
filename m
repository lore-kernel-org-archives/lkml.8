Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AF4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3418A2224D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453310;
	bh=vQ5Zu72e2TzwYVaZX1BdryKwmtf97ebh0hkJi39RFDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wgGetZ1+Ow7i55zbGuTJnS0hHwjtivP3liZPz1lYlQaLB6GciQTz3DCQSREGXbmjp
	 L+s3f+u8L6Zq/vHgo742dhAZi5BdUfwaXEoJPY0NDTEtQ69xezeVsG/6djdz9TaqkK
	 nluFaYP+t8XQm4o2pl810q7n3a/OL1ipOKGhuU+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgHZOs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgHZOsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:48:25 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2E2214F1;
        Wed, 26 Aug 2020 14:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453304;
        bh=vQ5Zu72e2TzwYVaZX1BdryKwmtf97ebh0hkJi39RFDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QL57HJOfx0q3AoZ3G+ZrkuUZvrgY68YohwpgADn3uo8gpl56X0nhjVLon65/xsSLa
         4SBFMzwwKOlRsKt4IzdizknK4jU9wKTVItzUHrTTUkmDzNJz780+GVEM7S1Z4ZBx0S
         tR4WgYBwqR6u6fzWBIUrz974zl8wvUYaH67myEos=
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
Subject: [PATCH 4/6] pwm: sifive: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:47:45 +0200
Message-Id: <20200826144747.9436-4-krzk@kernel.org>
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
 drivers/pwm/pwm-sifive.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 62de0bb85921..2485fbaaead2 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -254,11 +254,9 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 		return PTR_ERR(ddata->regs);
 
 	ddata->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(ddata->clk)) {
-		if (PTR_ERR(ddata->clk) != -EPROBE_DEFER)
-			dev_err(dev, "Unable to find controller clock\n");
-		return PTR_ERR(ddata->clk);
-	}
+	if (IS_ERR(ddata->clk))
+		return dev_err_probe(dev, PTR_ERR(ddata->clk),
+				     "Unable to find controller clock\n");
 
 	ret = clk_prepare_enable(ddata->clk);
 	if (ret) {
-- 
2.17.1

