Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD4DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1954D221E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453884;
	bh=0BJzEKvQ44LGzPY9kSUrwxv7Ki3QbBPW0SdS15oQN5E=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GTxUCiOmM3pf5Pk7QKloDYdoXMDYE3sF+hymqLQwH7rjMCxt/fnEOmch/C269js8V
	 0NlTRSvFckwyYRFiUbAfdcmEN/BJCiOfkx/UdUZ9HZIP5RxtutQWoEqed+Cwzad8aQ
	 RtV6A14s+KnjLZsqNDZMM02f9n3912+21w5/yOkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgHZOwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgHZOwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:52:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44A8022B40;
        Wed, 26 Aug 2020 14:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453539;
        bh=0BJzEKvQ44LGzPY9kSUrwxv7Ki3QbBPW0SdS15oQN5E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vLeiuX8dqkF1ILp+s6YfKWBeEPj1isB94J2AOD4ZWu4h9uuQ+odO28g6fwvx62i3j
         JhRBQwWv+pGHNl1x/53Y1mCgqfMXMx0XoMqp+jNA2yIBgbDPrRqzQ75bfGIhXF8gTU
         +Dbct08w/0wIm+JwqVTyud5Aw0G3kXEuhO697oH0=
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
Subject: [PATCH 03/16] iio: adc: envelope-detector: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:51:40 +0200
Message-Id: <20200826145153.10444-3-krzk@kernel.org>
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
 drivers/iio/adc/envelope-detector.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
index 2a4fd3bb64cf..d73eac36153f 100644
--- a/drivers/iio/adc/envelope-detector.c
+++ b/drivers/iio/adc/envelope-detector.c
@@ -348,11 +348,9 @@ static int envelope_detector_probe(struct platform_device *pdev)
 	indio_dev->num_channels = 1;
 
 	env->dac = devm_iio_channel_get(dev, "dac");
-	if (IS_ERR(env->dac)) {
-		if (PTR_ERR(env->dac) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get dac input channel\n");
-		return PTR_ERR(env->dac);
-	}
+	if (IS_ERR(env->dac))
+		return dev_err_probe(dev, PTR_ERR(env->dac),
+				     "failed to get dac input channel\n");
 
 	env->comp_irq = platform_get_irq_byname(pdev, "comp");
 	if (env->comp_irq < 0)
@@ -360,11 +358,9 @@ static int envelope_detector_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(dev, env->comp_irq, envelope_detector_comp_isr,
 			       0, "envelope-detector", env);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to request interrupt\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request interrupt\n");
+
 	env->comp_irq_trigger = irq_get_trigger_type(env->comp_irq);
 	if (env->comp_irq_trigger & IRQF_TRIGGER_RISING)
 		env->comp_irq_trigger_inv |= IRQF_TRIGGER_FALLING;
-- 
2.17.1

