Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163EBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7A622BEB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598556472;
	bh=nO07OHVtqYTYYgYXG9kFf3Gxi+yDeW2oQQkBmlm177s=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SO2moAEzzuVdrwkvi5XshU/peIwK5mjUC8jOO9QN7OU28WnoAj66Z1scxqWCganek
	 dREbCvRCAcSaLy5/v2enxvASrby7gf3VpXUMWzEFxGGHsmMangg2WLrhXS11eovQE2
	 rWg8ZBkeQ3DS+KEWWjFuGMpaZZ1uWlQELBxkmSOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgH0T1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgH0T1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:27:50 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A528207CD;
        Thu, 27 Aug 2020 19:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598556469;
        bh=nO07OHVtqYTYYgYXG9kFf3Gxi+yDeW2oQQkBmlm177s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=k2f7aVJFj4bXD51NGX2cAVppPH/aVQDanfa8llcV1nYctPMf6LmiIC/KJbJmb8WHD
         9eSWB3C7sSdZhBRMpSTtKkNtAWEc3q0dVkFWVgYs3YhXfGIR2mRl5rCiKcZJ+9oSmf
         RmEnwuBTnbt7fXl4frQrycGFpDI6oZGYa32S4y+c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 04/18] iio: adc: exynos_adc: Simplify with dev_err_probe()
Date:   Thu, 27 Aug 2020 21:26:28 +0200
Message-Id: <20200827192642.1725-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827192642.1725-1-krzk@kernel.org>
References: <20200827192642.1725-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Wrap dev_err_probe() lines at 100 character
---
 drivers/iio/adc/exynos_adc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 7d23b6c33284..40585a96c848 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -844,13 +844,8 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	}
 
 	info->vdd = devm_regulator_get(&pdev->dev, "vdd");
-	if (IS_ERR(info->vdd)) {
-		if (PTR_ERR(info->vdd) != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed getting regulator, err = %ld\n",
-				PTR_ERR(info->vdd));
-		return PTR_ERR(info->vdd);
-	}
+	if (IS_ERR(info->vdd))
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->vdd), "failed getting regulator");
 
 	ret = regulator_enable(info->vdd);
 	if (ret)
-- 
2.17.1

