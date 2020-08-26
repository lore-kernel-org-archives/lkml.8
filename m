Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5807BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362CE2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453832;
	bh=L62NHGTlHRmxfW0UXMzF8rz6Eg4TzDjh28d5OkWRb1E=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N6sQSilgMfs87+nrh6GJwwu+0UuNzIMpoffQys979VhDCILy3urcqCkOn72yiPycG
	 TOsVgEZGzlfOAyrbHEGsmalhPwMhPavve7zQ/SJbtlyMzLzSWHHxvMmhHJTrM0W4gm
	 jNrY34QI9/h1CFsqBv+Ov1cTp/vzUDOGR1a9kl2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgHZO47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:56:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgHZOxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:53:23 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DB7921741;
        Wed, 26 Aug 2020 14:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453602;
        bh=L62NHGTlHRmxfW0UXMzF8rz6Eg4TzDjh28d5OkWRb1E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vP/Bl97+JtTx4OaxuqQf637JfAncWM+cvwXtDyt0M8X8AQGOnemx5q4V2euAPCZtf
         WMttIrtvRRJoKWifKDkfX1+8Lk9eoqJepIe0UPQtCofwtHrOo0FSV5Ulu90tABrKky
         CgwWyQQVxz02bZRXieUrcDYksXCsOiCqHlrCVigs=
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
Subject: [PATCH 14/16] iio: light: isl29018: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:51:51 +0200
Message-Id: <20200826145153.10444-14-krzk@kernel.org>
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
 drivers/iio/light/isl29018.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
index ac8ad0f32689..2689867467a8 100644
--- a/drivers/iio/light/isl29018.c
+++ b/drivers/iio/light/isl29018.c
@@ -746,12 +746,9 @@ static int isl29018_probe(struct i2c_client *client,
 	chip->suspended = false;
 
 	chip->vcc_reg = devm_regulator_get(&client->dev, "vcc");
-	if (IS_ERR(chip->vcc_reg)) {
-		err = PTR_ERR(chip->vcc_reg);
-		if (err != -EPROBE_DEFER)
-			dev_err(&client->dev, "failed to get VCC regulator!\n");
-		return err;
-	}
+	if (IS_ERR(chip->vcc_reg))
+		return dev_err_probe(&client->dev, PTR_ERR(chip->vcc_reg),
+				     "failed to get VCC regulator!\n");
 
 	err = regulator_enable(chip->vcc_reg);
 	if (err) {
-- 
2.17.1

