Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DBDC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 672212078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453624;
	bh=J8VgXHUUZP2pCXXB1Ijbi0zWjJmibqmGMPN7gfP7amg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ax7GvzhszNkxvB37Uj5456KXMO1JlMml8BmEDMGzgB9Nc48ds8l2hpxXfib4b1ADQ
	 9xSEqvXgoCGTpN9ScIXwQGQbrtXHhBUJdK/49cW2K57u/5Cld/ja1cjNW1/V8frkYy
	 IiPzMPoiuQEKC+Jhv6VA9ZZRTw/rTGnlDcov/dE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgHZOxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728252AbgHZOxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:53:30 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 045DA2078D;
        Wed, 26 Aug 2020 14:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453609;
        bh=J8VgXHUUZP2pCXXB1Ijbi0zWjJmibqmGMPN7gfP7amg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QpJqNogrcmlIGvb4oSew7Gtwl5VPXjukXCXYclJ6UOVEGs06JEbRVTgRxwLro9q62
         ADpxRrdQhRq5jU8PZrmfqvjl/YGPxs25o142b1BzCgT5UUTbRXSHIdJJ8PL0kEme+y
         Fkm7I6YSAVvX2QO4Fik8Br5k9Gus3sl77yPC/kyo=
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
Subject: [PATCH 15/16] iio: light: tsl2772: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:51:52 +0200
Message-Id: <20200826145153.10444-15-krzk@kernel.org>
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
 drivers/iio/light/tsl2772.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index 735399405417..00073346ad1e 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -1776,14 +1776,9 @@ static int tsl2772_probe(struct i2c_client *clientp,
 	ret = devm_regulator_bulk_get(&clientp->dev,
 				      ARRAY_SIZE(chip->supplies),
 				      chip->supplies);
-	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&clientp->dev,
-				"Failed to get regulators: %d\n",
-				ret);
-
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&clientp->dev, ret,
+				     "Failed to get regulators\n");
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(chip->supplies), chip->supplies);
 	if (ret < 0) {
-- 
2.17.1

