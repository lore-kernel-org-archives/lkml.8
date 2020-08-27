Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD58C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F99D2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598554788;
	bh=3hmVzlm79kXWB8lCrNJXeIgLjMWsqoIQvCQOPffnOq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lJqyopStg0BdyPwHvbQMGc6JNzsm1AjmEcQIvetTAJg+Tusz++ozknBL9XhAhlwIB
	 JaYkpRNvuoVbxrFF/JgiP7iphMxKiic/C0eARIzJPLWY00XceS14V60Lvfjq+HKc3k
	 2ITYFF2ayXDcb2DKNdev5d3Lm4K34hciMJLHNGAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgH0S7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 14:59:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbgH0S7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:59:39 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E09B22BEA;
        Thu, 27 Aug 2020 18:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598554778;
        bh=3hmVzlm79kXWB8lCrNJXeIgLjMWsqoIQvCQOPffnOq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tmzbWQbTXgsJOfBxLpp43mBeKKHuFbaz7RoatvJp7WIo6yLcTFbsignuLJWWdTJ4L
         ayYVusNyf+A+AfzK1MnPtZCbTmzdslEECp3k+ovKE2bhcaxPVvhoKV6Jm7K4IrESCy
         qUBgVz1GaZxCMo3oJ/+Wga4Oaw7qLa4/TqCi14wY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Sangwon Jee <jeesw@melfas.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 17/27] Input: raydium_i2c_ts - Simplify with dev_err_probe()
Date:   Thu, 27 Aug 2020 20:58:19 +0200
Message-Id: <20200827185829.30096-18-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827185829.30096-1-krzk@kernel.org>
References: <20200827185829.30096-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 30 +++++++---------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index fe245439adee..4017775f6466 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -1015,32 +1015,20 @@ static int raydium_i2c_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, ts);
 
 	ts->avdd = devm_regulator_get(&client->dev, "avdd");
-	if (IS_ERR(ts->avdd)) {
-		error = PTR_ERR(ts->avdd);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"Failed to get 'avdd' regulator: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(ts->avdd))
+		return dev_err_probe(&client->dev, PTR_ERR(ts->avdd),
+				     "Failed to get 'avdd' regulator\n");
 
 	ts->vccio = devm_regulator_get(&client->dev, "vccio");
-	if (IS_ERR(ts->vccio)) {
-		error = PTR_ERR(ts->vccio);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"Failed to get 'vccio' regulator: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(ts->vccio))
+		return dev_err_probe(&client->dev, PTR_ERR(ts->vccio),
+				     "Failed to get 'vccio' regulator\n");
 
 	ts->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
 						 GPIOD_OUT_LOW);
-	if (IS_ERR(ts->reset_gpio)) {
-		error = PTR_ERR(ts->reset_gpio);
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev,
-				"failed to get reset gpio: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(ts->reset_gpio))
+		return dev_err_probe(&client->dev, PTR_ERR(ts->reset_gpio),
+				     "Failed to get reset gpio\n");
 
 	error = raydium_i2c_power_on(ts);
 	if (error)
-- 
2.17.1

