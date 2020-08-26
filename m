Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A23C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88264221E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453548;
	bh=lwcapEqh1mnH2bnwZTOp+jWQ1z3sGCNA5lWoA1rbyV4=;
	h=From:To:Subject:Date:List-ID:From;
	b=jCfSJeE48+NYrdDTmIyZdAndTJuFxLnox8X7unceMNhb3VzsGiu9p5GCr9Tiek5fB
	 3GIvrnH2U+ChI3iljOUtCTrkFRjNczCT+McH5bKh4lvoHDwS3BRs6mGloR5XCTkaP8
	 lY+ihLIVWbNQSeedkzytHrfwrDnoEt3GYWURMe+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgHZOwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:52:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbgHZOwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:52:08 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CE2B21741;
        Wed, 26 Aug 2020 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453528;
        bh=lwcapEqh1mnH2bnwZTOp+jWQ1z3sGCNA5lWoA1rbyV4=;
        h=From:To:Subject:Date:From;
        b=W5poQ48UfnSWvBecbti9ouY3yxhCPYG7lJ2YWTWVuAvPzu89EU7+uxyv8YXTofPQB
         3gXzjtXyB8/4Ngg7w+SKJToYcj5ZxCKpk+/tsTswwQXNhHScaZm2HPq2MnZV/thjFq
         k/Zgr1eJS8cgJ8XzHei6NU7DBymAvV//O1xoQWec=
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
Subject: [PATCH 01/16] iio: accel: bma180: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:51:38 +0200
Message-Id: <20200826145153.10444-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/iio/accel/bma180.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 5b7a467c7b27..448faed001fd 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -1000,19 +1000,15 @@ static int bma180_probe(struct i2c_client *client,
 		return ret;
 
 	data->vdd_supply = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(data->vdd_supply)) {
-		if (PTR_ERR(data->vdd_supply) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get vdd regulator %d\n",
-				(int)PTR_ERR(data->vdd_supply));
-		return PTR_ERR(data->vdd_supply);
-	}
+	if (IS_ERR(data->vdd_supply))
+		return dev_err_probe(dev, PTR_ERR(data->vdd_supply),
+				     "Failed to get vdd regulator\n");
+
 	data->vddio_supply = devm_regulator_get(dev, "vddio");
-	if (IS_ERR(data->vddio_supply)) {
-		if (PTR_ERR(data->vddio_supply) != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get vddio regulator %d\n",
-				(int)PTR_ERR(data->vddio_supply));
-		return PTR_ERR(data->vddio_supply);
-	}
+	if (IS_ERR(data->vddio_supply))
+		return dev_err_probe(dev, PTR_ERR(data->vddio_supply),
+				     "Failed to get vddio regulator\n");
+
 	/* Typical voltage 2.4V these are min and max */
 	ret = regulator_set_voltage(data->vdd_supply, 1620000, 3600000);
 	if (ret)
-- 
2.17.1

