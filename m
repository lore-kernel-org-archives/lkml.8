Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756EBC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441332078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453863;
	bh=T5xvC4E4MsMwGEUX1i7xJJFIfrS9fUuZLYOkjgS9wJs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TC5hz5Z83mrFPcZjc5cQrRHWmRijEDTeLu8MIkBvVhjaWpo9djGy2mVYeIVigI74W
	 3tr4Va17z0t/EiXrkFU24MXsL7mBSDnO1rJVkmTWeF3uAGQMo77bDCUlwAURHMx0i1
	 Wynm55R7OniOYnC+tZqKEQNOuhjZTjhgUyha++JQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgHZO5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbgHZOxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:53:09 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 274E822B47;
        Wed, 26 Aug 2020 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453589;
        bh=T5xvC4E4MsMwGEUX1i7xJJFIfrS9fUuZLYOkjgS9wJs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TcqQ7VNMtsK+sKv7CWZAgceEyGN4b2Kv4KecHfDzf2y6sQudrL/XO+CMTh0E0YAHT
         nl4Y8124+m8Egy0EyY4N9B+q4hWpeo7q4e+KRsmcpuEW0ZA3wnnH+0gc4ebw5vvi+b
         kj8Mh0mQoca0QAp+eL6ifjaReTfgXrfyoF5MrhPE=
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
Subject: [PATCH 12/16] iio: dac: dpot-dac: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:51:49 +0200
Message-Id: <20200826145153.10444-12-krzk@kernel.org>
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
 drivers/iio/dac/dpot-dac.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index be61c3b01e8b..2258535b8a42 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -183,18 +183,14 @@ static int dpot_dac_probe(struct platform_device *pdev)
 	indio_dev->num_channels = 1;
 
 	dac->vref = devm_regulator_get(dev, "vref");
-	if (IS_ERR(dac->vref)) {
-		if (PTR_ERR(dac->vref) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get vref regulator\n");
-		return PTR_ERR(dac->vref);
-	}
+	if (IS_ERR(dac->vref))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dac->vref),
+				     "failed to get vref regulator\n");
 
 	dac->dpot = devm_iio_channel_get(dev, "dpot");
-	if (IS_ERR(dac->dpot)) {
-		if (PTR_ERR(dac->dpot) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get dpot input channel\n");
-		return PTR_ERR(dac->dpot);
-	}
+	if (IS_ERR(dac->dpot))
+		return dev_err_probe(&pdev->dev, PTR_ERR(dac->dpot),
+				     "failed to get dpot input channel\n");
 
 	ret = iio_get_channel_type(dac->dpot, &type);
 	if (ret < 0)
-- 
2.17.1

