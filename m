Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6242FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F67B221E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453615;
	bh=OTM2oBQoZiAlV+XAfIAKT7r/gquf8Xx7bYhHoSUNzOQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I2Lp2xm03hWRshGZVQiHD4rb509dTmuYt/NWqy02sMU+2ZxOfQUdRBf0vhX/8g98u
	 s2xqVI6dUwHEUBaPqYc4aIq33vTKHgZWEpwJXl99EXyASUD0nu73nYdkShXn23wlF8
	 c2iO7hg1rqQTmr6EQTa2b5JBYkzPYVo1ae9nkdao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgHZOxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727783AbgHZOxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:53:04 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9CD2221E2;
        Wed, 26 Aug 2020 14:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453583;
        bh=OTM2oBQoZiAlV+XAfIAKT7r/gquf8Xx7bYhHoSUNzOQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cPny5w0b1gWvr3veWEmXDwmzRaVz/k83PcuL7utLmHw6zWfvrjQ1r6J/30m+cS/GT
         l8d8fx/q4VeNxkCTanQP2tmfPr3jbjSoj4hZNCmUnTX8UfXBB6p6FCgjtLO6rbQ0yE
         KjkIP9LM/fH97f44ri+rZextJ4xkzG56osJMHMac=
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
Subject: [PATCH 11/16] iio: chemical: scd30: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:51:48 +0200
Message-Id: <20200826145153.10444-11-krzk@kernel.org>
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
 drivers/iio/chemical/scd30_core.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index eac76972f83e..92358797796d 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -705,13 +705,9 @@ int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
 	indio_dev->available_scan_masks = scd30_scan_masks;
 
 	state->vdd = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(state->vdd)) {
-		if (PTR_ERR(state->vdd) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-
-		dev_err(dev, "failed to get regulator\n");
-		return PTR_ERR(state->vdd);
-	}
+	if (IS_ERR(state->vdd))
+		return dev_err_probe(dev, PTR_ERR(state->vdd),
+				     "failed to get regulator\n");
 
 	ret = regulator_enable(state->vdd);
 	if (ret)
-- 
2.17.1

