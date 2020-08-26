Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3F1C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A3C22B3F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453584;
	bh=63gj/uTCsFYMkt/AT+w/CDkwgSGu5Zbr+ERRB5p1wnM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aY5jiLqOASxdPkTJWuvkYEyLzSjZpWSlYOWHZr7prMa9W2A6BO3helZ/rjl1ySfTj
	 AmpRKDYyOSizwG6KrENEnuoE189FG/XwkI4Lvkhc+R7mDWPh33KjkfH/T0cTXjGxp6
	 4XP9GHCmSJnfVrCIKXS36WBij2LJSTe0afbIJGsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgHZOxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgHZOwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:52:36 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB1AE22B49;
        Wed, 26 Aug 2020 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453556;
        bh=63gj/uTCsFYMkt/AT+w/CDkwgSGu5Zbr+ERRB5p1wnM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=scRXfuu4/yARMyjVu4iOTRUPGt1hx6peEuIk9y8eFtgIVQYLomR53puCOev9UkHHJ
         EyjYbSqVxfgLxRuXiNTv70BbRe4hgcfzIfnnMbBDQx+hwWmna8crZUBjRme5mKaV1S
         2sU/mqv4LdijkoZN0cS4IuKctuQF3Jkf+P02J/tI=
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
Subject: [PATCH 06/16] iio: adc: meson_saradc: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:51:43 +0200
Message-Id: <20200826145153.10444-6-krzk@kernel.org>
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
 drivers/iio/adc/meson_saradc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 93c2252c0b89..a9d06e8a576a 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -719,11 +719,8 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
 		if (ret == -ENODEV)
 			return 0;
 
-		if (ret != -EPROBE_DEFER)
-			dev_err(indio_dev->dev.parent,
-				"failed to get temperature_calib cell\n");
-
-		return ret;
+		return dev_err_probe(indio_dev->dev.parent, ret,
+				     "failed to get temperature_calib cell\n");
 	}
 
 	priv->tsc_regmap =
-- 
2.17.1

