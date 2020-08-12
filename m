Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22229C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E37C8207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597249829;
	bh=eX15NLAnHkr2JM14R4rf4yZMswB6aHIybQEwZQAk2ZA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oy8VELWDh3+XNHXFOkFbj0C6iq7tgFyG/s0dvwpiOFk7gmAO8EiK+HSzcb3PalW6H
	 5PNFOwmKGtsxwRm5fRslN+78ZrfT4tWUyESQd2b7oobZ1Oc09NRiU0ZDk2N2ZvVepm
	 A8xTvNCDUopfD5EgEpSlBrQ5vNsxvx+u8cg1eBRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgHLQa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:30:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726809AbgHLQaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:30:25 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C3C920829;
        Wed, 12 Aug 2020 16:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597249824;
        bh=eX15NLAnHkr2JM14R4rf4yZMswB6aHIybQEwZQAk2ZA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fl7YEQ/YQSEEmnyYibmoqbo6vFzWQwTstwx/FHZmPW/iIDiJXmeoSHgtID1w62JTF
         cGqjWvU7KlqhOGBks7inBqAXRgf33tYo7BSrSJh7mq+J5mSjL00tCr3kRYZeyT0Of7
         PEW/GwP598iIhFp+ou3BbEYYpmuNOmDnRw6KcUJA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 10/11] extcon: ptn5150: Reduce the amount of logs on deferred probe
Date:   Wed, 12 Aug 2020 18:29:57 +0200
Message-Id: <20200812162958.6180-10-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812162958.6180-1-krzk@kernel.org>
References: <20200812162958.6180-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to print deferred probe (and its failures to get
resources) as an error.  In case of multiple probe tries this would
pollute the dmesg.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-ptn5150.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 9daf45118ffd..fd9723f86d55 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -244,7 +244,7 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 			dev_info(dev, "No VBUS GPIO, ignoring VBUS control\n");
 			info->vbus_gpiod = NULL;
 		} else {
-			dev_err(dev, "failed to get VBUS GPIO\n");
+			dev_err_probe(dev, ret, "failed to get VBUS GPIO\n");
 			return ret;
 		}
 	}
@@ -256,8 +256,8 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 	info->regmap = devm_regmap_init_i2c(i2c, &ptn5150_regmap_config);
 	if (IS_ERR(info->regmap)) {
 		ret = PTR_ERR(info->regmap);
-		dev_err(info->dev, "failed to allocate register map: %d\n",
-				   ret);
+		dev_err_probe(info->dev, ret, "failed to allocate register map: %d\n",
+			      ret);
 		return ret;
 	}
 
@@ -266,8 +266,9 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 	} else {
 		info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
 		if (IS_ERR(info->int_gpiod)) {
-			dev_err(dev, "failed to get INT GPIO\n");
-			return PTR_ERR(info->int_gpiod);
+			ret = PTR_ERR(info->int_gpiod);
+			dev_err_probe(dev, ret, "failed to get INT GPIO\n");
+			return ret;
 		}
 
 		info->irq = gpiod_to_irq(info->int_gpiod);
-- 
2.17.1

