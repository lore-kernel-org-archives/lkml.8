Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BBCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631522072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597647707;
	bh=VLk66Gcfw65cI8H3iqrAuNUGmvgQ8gBD623S8yCZ7BA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f6jgwT9IIuhJRvRx75viNK+QmbdAB+wdBeQrJcVKMtKoU7mIHviRd6U+IwT3tjJVl
	 yUqN2g5uvQ2FqIxVTvRtLco428pbp6OVfna1bY86o1/IAeBBA5yQXsUwcye5BOW+kY
	 KnEODDNmX57j0jOddsEKUqXdDM6UiHrWOf+V361E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgHQHBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:42356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgHQHAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:00:38 -0400
Received: from localhost.localdomain (unknown [194.230.155.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04DC7207FF;
        Mon, 17 Aug 2020 07:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597647638;
        bh=VLk66Gcfw65cI8H3iqrAuNUGmvgQ8gBD623S8yCZ7BA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TMsdTpZyCmmCaNBe5kUZzOG7Kl+Pj8ROVMSo8VBf6qpyWMlqG4P1H7rsk8AAH+w2M
         77ax78tJsIjeuEmJnMlfcxjUvFz/iiew/dNqq/D6TxVynX4hVNfb5TbjVLyKbDW0gr
         IfbvwsLVyTmVEcROq9ZnEY33UvLmeXhLaqR/LgQA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 10/13] extcon: ptn5150: Reduce the amount of logs on deferred probe
Date:   Mon, 17 Aug 2020 09:00:06 +0200
Message-Id: <20200817070009.4631-11-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817070009.4631-1-krzk@kernel.org>
References: <20200817070009.4631-1-krzk@kernel.org>
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
index 008e664d8d56..c8611ff90990 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -243,7 +243,7 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 			dev_info(dev, "No VBUS GPIO, ignoring VBUS control\n");
 			info->vbus_gpiod = NULL;
 		} else {
-			dev_err(dev, "failed to get VBUS GPIO\n");
+			dev_err_probe(dev, ret, "failed to get VBUS GPIO\n");
 			return ret;
 		}
 	}
@@ -255,8 +255,8 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
 	info->regmap = devm_regmap_init_i2c(i2c, &ptn5150_regmap_config);
 	if (IS_ERR(info->regmap)) {
 		ret = PTR_ERR(info->regmap);
-		dev_err(info->dev, "failed to allocate register map: %d\n",
-				   ret);
+		dev_err_probe(info->dev, ret, "failed to allocate register map: %d\n",
+			      ret);
 		return ret;
 	}
 
@@ -265,8 +265,9 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c,
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

