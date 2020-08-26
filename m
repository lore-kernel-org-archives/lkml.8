Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18116C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D794D21741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453567;
	bh=mbBY3f6IkcYP5UmsdfBs0Q121Pfo6ZsXqMxj84C8/3I=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LWjPrVtYrwRRlboFdtXJQUS8EFY+Pt/SM3AbJukmUT5zD60VvHEThujbex6VEkvlE
	 W38Kcah//feLEclt8rituqZUMhjmOsVbRcYAb5U9GdXon1HzRq755TcEQ+u51KM1nG
	 TmTKihQ5bw0AYYMenMqMipkR7bA3qlj7zfSK79no=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgHZOwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:52:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgHZOwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:52:30 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ABD422B47;
        Wed, 26 Aug 2020 14:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453550;
        bh=mbBY3f6IkcYP5UmsdfBs0Q121Pfo6ZsXqMxj84C8/3I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rB7PYhCcZUbVXTNWIxUq3/hcQjjDTXkjrfU3ygh4GZvyLFhEW1z8v4VlGLqOqeQ6u
         66XzLFpv+MgP3RqBh/tnxe6osJhbstejzE0wboV5gK1fGX9LzGAXwIFpjlciotio6E
         xH+Yfg9ZhHN9H/nprX/O+zTjHcjpap6WjiYFSHvI=
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
Subject: [PATCH 05/16] iio: adc: ltc2497: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:51:42 +0200
Message-Id: <20200826145153.10444-5-krzk@kernel.org>
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
 drivers/iio/adc/ltc2497-core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 9b8fd9c32364..2a485c8a1940 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -180,13 +180,9 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 		return ret;
 
 	ddata->ref = devm_regulator_get(dev, "vref");
-	if (IS_ERR(ddata->ref)) {
-		if (PTR_ERR(ddata->ref) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get vref regulator: %pe\n",
-				ddata->ref);
-
-		return PTR_ERR(ddata->ref);
-	}
+	if (IS_ERR(ddata->ref))
+		return dev_err_probe(dev, PTR_ERR(ddata->ref),
+				     "Failed to get vref regulator\n");
 
 	ret = regulator_enable(ddata->ref);
 	if (ret < 0) {
-- 
2.17.1

