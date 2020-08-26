Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193DCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB8D22B3F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453578;
	bh=BjFbji4PFSaomI4/2UsbpzM496UR1gTI3GZp0d8DKV8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r1D8Cip0jIDSK+O/g3ohW/rL9hAGwFKvMuyW/A3ztBpLNSqgE3+l/F/ZKA1KPDS41
	 zZAAMyoSq7VGsAWMAAjpkgerEm80/h+9qLFsA52S3i8zuY6aeXzABx8lx5XxcTqT41
	 w78NbWfPmpBu4Rv46XAzEXOfP5iM6gUxAwekSfi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHZOw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:52:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgHZOwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:52:25 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90C152224D;
        Wed, 26 Aug 2020 14:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453544;
        bh=BjFbji4PFSaomI4/2UsbpzM496UR1gTI3GZp0d8DKV8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NMEJK3RFge/3/cUnFjzfFf8aKnt72KOUHFY4NygxwM0h6c5Xzr+hqxGyVVkhidX5J
         GYrWHJDpZwj83LxeAOEEjz2k+aMkJGg3l9OfHstCnQIyrE4IFQHWw5080NSFjOnpWp
         Kr1niJu1vciNfw5xgBJBVvWdRANIBuZHBveEVIP0=
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
        Jonathan Bakker <xc-racer2@live.ca>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 04/16] iio: adc: exynos_adc: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:51:41 +0200
Message-Id: <20200826145153.10444-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826145153.10444-1-krzk@kernel.org>
References: <20200826145153.10444-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iio/adc/exynos_adc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 7d23b6c33284..20477b249f2a 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -844,13 +844,9 @@ static int exynos_adc_probe(struct platform_device *pdev)
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
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->vdd),
+				     "failed getting regulator");
 
 	ret = regulator_enable(info->vdd);
 	if (ret)
-- 
2.17.1

