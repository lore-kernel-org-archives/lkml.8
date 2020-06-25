Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E577DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA48F20781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 13:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405089AbgFYN1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:27:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48403 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404872AbgFYN1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:27:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1joRui-0000Py-C0; Thu, 25 Jun 2020 13:27:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] clk: vc5: fix use of memory after it has been kfree'd
Date:   Thu, 25 Jun 2020 14:27:36 +0100
Message-Id: <20200625132736.88832-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are a several places where printing an error message of
init.name occurs after init.name has been kfree'd. Also the failure
message is duplicated each time in the code. Fix this by adding
a registration error failure path for these cases, moving the
duplicated error messages to one common point and kfree'ing init.name
only after it has been used.

Changes also shrink the object code size by 171 bytes (x86-64, gcc 9.3):

Before:
   text	   data	    bss	    dec	    hex	filename
  21057	   3960	     64	  25081	   61f9	drivers/clk/clk-versaclock5.o

After:
   text	   data	    bss	    dec	    hex	filename
  20886	   3960	     64	  24910	   614e	drivers/clk/clk-versaclock5.o

Addresses-Coverity: ("Use after free")
Fixes: f491276a5168 ("clk: vc5: Allow Versaclock driver to support multiple instances")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clk/clk-versaclock5.c | 51 +++++++++++++----------------------
 1 file changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 9a5fb3834b9a..1d8ee4b8b1f5 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -882,11 +882,9 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	init.parent_names = parent_names;
 	vc5->clk_mux.init = &init;
 	ret = devm_clk_hw_register(&client->dev, &vc5->clk_mux);
+	if (ret)
+		goto err_clk_register;
 	kfree(init.name);	/* clock framework made a copy of the name */
-	if (ret) {
-		dev_err(&client->dev, "unable to register %s\n", init.name);
-		goto err_clk;
-	}
 
 	if (vc5->chip_info->flags & VC5_HAS_PFD_FREQ_DBL) {
 		/* Register frequency doubler */
@@ -900,12 +898,9 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		init.num_parents = 1;
 		vc5->clk_mul.init = &init;
 		ret = devm_clk_hw_register(&client->dev, &vc5->clk_mul);
+		if (ret)
+			goto err_clk_register;
 		kfree(init.name); /* clock framework made a copy of the name */
-		if (ret) {
-			dev_err(&client->dev, "unable to register %s\n",
-				init.name);
-			goto err_clk;
-		}
 	}
 
 	/* Register PFD */
@@ -921,11 +916,9 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	init.num_parents = 1;
 	vc5->clk_pfd.init = &init;
 	ret = devm_clk_hw_register(&client->dev, &vc5->clk_pfd);
+	if (ret)
+		goto err_clk_register;
 	kfree(init.name);	/* clock framework made a copy of the name */
-	if (ret) {
-		dev_err(&client->dev, "unable to register %s\n", init.name);
-		goto err_clk;
-	}
 
 	/* Register PLL */
 	memset(&init, 0, sizeof(init));
@@ -939,11 +932,9 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	vc5->clk_pll.vc5 = vc5;
 	vc5->clk_pll.hw.init = &init;
 	ret = devm_clk_hw_register(&client->dev, &vc5->clk_pll.hw);
+	if (ret)
+		goto err_clk_register;
 	kfree(init.name); /* clock framework made a copy of the name */
-	if (ret) {
-		dev_err(&client->dev, "unable to register %s\n", init.name);
-		goto err_clk;
-	}
 
 	/* Register FODs */
 	for (n = 0; n < vc5->chip_info->clk_fod_cnt; n++) {
@@ -960,12 +951,9 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		vc5->clk_fod[n].vc5 = vc5;
 		vc5->clk_fod[n].hw.init = &init;
 		ret = devm_clk_hw_register(&client->dev, &vc5->clk_fod[n].hw);
+		if (ret)
+			goto err_clk_register;
 		kfree(init.name); /* clock framework made a copy of the name */
-		if (ret) {
-			dev_err(&client->dev, "unable to register %s\n",
-				init.name);
-			goto err_clk;
-		}
 	}
 
 	/* Register MUX-connected OUT0_I2C_SELB output */
@@ -981,11 +969,9 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	vc5->clk_out[0].vc5 = vc5;
 	vc5->clk_out[0].hw.init = &init;
 	ret = devm_clk_hw_register(&client->dev, &vc5->clk_out[0].hw);
-	kfree(init.name);	/* clock framework made a copy of the name */
-	if (ret) {
-		dev_err(&client->dev, "unable to register %s\n", init.name);
-		goto err_clk;
-	}
+	if (ret)
+		goto err_clk_register;
+	kfree(init.name); /* clock framework made a copy of the name */
 
 	/* Register FOD-connected OUTx outputs */
 	for (n = 1; n < vc5->chip_info->clk_out_cnt; n++) {
@@ -1008,17 +994,15 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		vc5->clk_out[n].vc5 = vc5;
 		vc5->clk_out[n].hw.init = &init;
 		ret = devm_clk_hw_register(&client->dev, &vc5->clk_out[n].hw);
+		if (ret)
+			goto err_clk_register;
 		kfree(init.name); /* clock framework made a copy of the name */
-		if (ret) {
-			dev_err(&client->dev, "unable to register %s\n",
-				init.name);
-			goto err_clk;
-		}
 
 		/* Fetch Clock Output configuration from DT (if specified) */
 		ret = vc5_get_output_config(client, &vc5->clk_out[n]);
 		if (ret)
 			goto err_clk;
+
 	}
 
 	ret = of_clk_add_hw_provider(client->dev.of_node, vc5_of_clk_get, vc5);
@@ -1029,6 +1013,9 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	return 0;
 
+err_clk_register:
+	dev_err(&client->dev, "unable to register %s\n", init.name);
+	kfree(init.name); /* clock framework made a copy of the name */
 err_clk:
 	if (vc5->chip_info->flags & VC5_HAS_INTERNAL_XTAL)
 		clk_unregister_fixed_rate(vc5->pin_xin);
-- 
2.27.0

