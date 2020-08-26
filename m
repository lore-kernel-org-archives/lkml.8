Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5849C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A542078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453637;
	bh=v/Zb3PmGpo5l2DvxNKoEoZ/zVbV6OtENUtPofNroKvs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WNCdRBAtwgqWwJE1Z2y03hQO2W9vDTFQT4bINZ/QZRvvpC0zBPa7S4HT3XRu788K4
	 ekVoQrZOGdjf+m0Weu+At7MNEZLhsW92sW5SC6U3MZGis92a3FR8sVjVJUUsRGVM81
	 84DP2jTl95W5DlYSvuC3bC2gubK7uvdgrZYjvJHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHZOxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:53:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbgHZOxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:53:36 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06B9A2177B;
        Wed, 26 Aug 2020 14:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453615;
        bh=v/Zb3PmGpo5l2DvxNKoEoZ/zVbV6OtENUtPofNroKvs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=G1yTKeODAnBmqu0tCCEEeOyfX9WSgWuaRVB3SQP1H4qDRVlOSt+hpoRkjYlGCBeok
         gmAK8tht/DTIU8dviczhNyYxIUUm3LiA3INTKD5WTXuyCsmJyzN0tD+pJ8COzkkiWo
         7i/+1mvilt2zqVD/ofW0B8ni0jFzO+qcRjHUi2ro=
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
Subject: [PATCH 16/16] iio: magnetometer: ak8974: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:51:53 +0200
Message-Id: <20200826145153.10444-16-krzk@kernel.org>
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
 drivers/iio/magnetometer/ak8974.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index cbb44e401c0a..fa6a8e1a815c 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -843,15 +843,9 @@ static int ak8974_probe(struct i2c_client *i2c,
 	ret = devm_regulator_bulk_get(&i2c->dev,
 				      ARRAY_SIZE(ak8974->regs),
 				      ak8974->regs);
-	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&i2c->dev, "cannot get regulators: %d\n", ret);
-		else
-			dev_dbg(&i2c->dev,
-				"regulators unavailable, deferring probe\n");
-
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&i2c->dev, ret,
+				     "cannot get regulators\n");
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(ak8974->regs), ak8974->regs);
 	if (ret < 0) {
-- 
2.17.1

