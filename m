Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042BBC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB47E2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453805;
	bh=kkISLubLn02Pqd4uTanIQMpVWj7X3BN+1/yofvSuWc8=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LSkbIpyQa5ls9Hm3kTpq0CmP2EbtvC5u4Nu1havMtjW/uAO/Z/1CiDFBBDd97x0L2
	 i4HC3l3GpV1Q36nvxBTCUuRUKAn5qx1Xjn+8ohL5kftO5DUxdO1ZQ5Fx0iB9RZ5+RB
	 KrO0t+buhxBegFJKCoQu3m0rMvc3j4KS2cX21gwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgHZOx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbgHZOwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:52:53 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FABE2177B;
        Wed, 26 Aug 2020 14:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453572;
        bh=kkISLubLn02Pqd4uTanIQMpVWj7X3BN+1/yofvSuWc8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=H83nW6V5S3urOUpULphtz3zccovbw9g0fFCefrjuYoLXand4Ge+9p3+Qyf/Srtffc
         YmReJ+BHI1bG1UUo4u3E1DyrY/ZG2fhUgi/JEZbJBWLnHhmG2Rw6sbUKkSHiVsfKm3
         XeueJ6nAcItK/oN4JmekPru4Me0xq7pfmGDQHOR8=
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
Subject: [PATCH 09/16] iio: afe: iio-rescale: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:51:46 +0200
Message-Id: <20200826145153.10444-9-krzk@kernel.org>
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
 drivers/iio/afe/iio-rescale.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 69c0f277ada0..e42ea2b1707d 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -276,11 +276,9 @@ static int rescale_probe(struct platform_device *pdev)
 	int ret;
 
 	source = devm_iio_channel_get(dev, NULL);
-	if (IS_ERR(source)) {
-		if (PTR_ERR(source) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get source channel\n");
-		return PTR_ERR(source);
-	}
+	if (IS_ERR(source))
+		return dev_err_probe(dev, PTR_ERR(source),
+				     "failed to get source channel\n");
 
 	sizeof_ext_info = iio_get_channel_ext_info_count(source);
 	if (sizeof_ext_info) {
-- 
2.17.1

