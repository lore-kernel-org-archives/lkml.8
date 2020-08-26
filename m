Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC49CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D3A214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598465897;
	bh=/d4BjFY2ap9+l6rWTJFZn1Ski4MoGXTAYNl4MMOq0gs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bdhDHTL8ANs9dwrWXgVq9107G/2KWAUdFqoZ9CMrvkhNls1RT5rO7X03VkvQdJG3C
	 YcwXd8ACmoUVIlx91XmUFoISLTFejWCIVEzZI6PD/cYo4Uf958eoHn5VpTf6M1fgF4
	 LciAi6UIjbZh5yyGn+2we+352deh8SWE7hrX9prM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgHZSSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgHZSSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:18:00 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4167C22B47;
        Wed, 26 Aug 2020 18:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598465880;
        bh=/d4BjFY2ap9+l6rWTJFZn1Ski4MoGXTAYNl4MMOq0gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qSWpCUOKvobJmpH0O/23WwT/S7TFqh3Db4hqmp1qTMMEi0xx+gdN5JeZrmSmWzGpZ
         aCAkk9KVnvnpvYzArP7MOiyrKnuQ+XBfABs47/UtyPAeJrSQyUrpaXdR6hWqkiUH6c
         +9YPeScx7dfXKaYermxU71Js8+4n6If50x7WbQQM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bastien Nocera <hadess@hadess.net>,
        Sangwon Jee <jeesw@melfas.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 09/24] Input: bu21013_ts - Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 20:16:51 +0200
Message-Id: <20200826181706.11098-9-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826181706.11098-1-krzk@kernel.org>
References: <20200826181706.11098-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/input/touchscreen/bu21013_ts.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index 2f1f0d7607f8..bb99405b5dac 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -497,11 +497,9 @@ static int bu21013_probe(struct i2c_client *client,
 	/* Named "CS" on the chip, DT binding is "reset" */
 	ts->cs_gpiod = devm_gpiod_get(&client->dev, "reset", GPIOD_OUT_HIGH);
 	error = PTR_ERR_OR_ZERO(ts->cs_gpiod);
-	if (error) {
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev, "failed to get CS GPIO\n");
-		return error;
-	}
+	if (error)
+		return dev_err_probe(&client->dev, error, "failed to get CS GPIO\n");
+
 	gpiod_set_consumer_name(ts->cs_gpiod, "BU21013 CS");
 
 	error = devm_add_action_or_reset(&client->dev,
@@ -516,11 +514,8 @@ static int bu21013_probe(struct i2c_client *client,
 	ts->int_gpiod = devm_gpiod_get_optional(&client->dev,
 						"touch", GPIOD_IN);
 	error = PTR_ERR_OR_ZERO(ts->int_gpiod);
-	if (error) {
-		if (error != -EPROBE_DEFER)
-			dev_err(&client->dev, "failed to get INT GPIO\n");
-		return error;
-	}
+	if (error)
+		return dev_err_probe(&client->dev, error, "failed to get INT GPIO\n");
 
 	if (ts->int_gpiod)
 		gpiod_set_consumer_name(ts->int_gpiod, "BU21013 INT");
-- 
2.17.1

