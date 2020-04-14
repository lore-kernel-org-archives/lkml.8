Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED18C3815B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D85206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouFvZ19W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504988AbgDNTip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504928AbgDNThA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:37:00 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42D2C061A10;
        Tue, 14 Apr 2020 12:37:00 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x2so11298160qtr.0;
        Tue, 14 Apr 2020 12:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/x+59wQD9qt9jVTB3z6iHmEFF7JHhCgx/hYlUVzL/CE=;
        b=ouFvZ19WZE6FIrXgBiOAvzefMfOTA/9N+8QZJGURxDuyXKcv674CLUt5FLv2dsTSRc
         JnKnJbJCXwCHCDqlpSXiH+eSPtc8Yd/3mOt2U17swQm/cwdE+XWdXvN/7ZXz8QEGGQIZ
         2lVWqWoTovre9qwlQ0YCkY+bHSZ2Ww11doNNQwHZT9BP9VHUqyh7RBlbtotKjtbIQ/vM
         BEF80jJCX5zlygfAoRXYxh7lVoTURTLzyqhW1tz61uPlglogPsO7S8YnQX4Jiy8m40wP
         N6FG+By+cWoD7To5sAQO/aFiDF8JP871D1FO0GIM7AVj+N46C0wouexCJpHSs2tbcS0W
         3J0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/x+59wQD9qt9jVTB3z6iHmEFF7JHhCgx/hYlUVzL/CE=;
        b=CP+LetDqujyEMxFab8O94lWHt4/yvwSs7OL6gG2EY6WkrkIxzMjr12T9UGQ5AwnjLU
         VBBQKbluHQVokRXdW3fh8KhNIa53fBxvrIa8XuVRiLs5IJZTPR4ffV6kPsLByuDSqbaH
         P/SbRnqOv9L51/ojHUNQNIMc80PLK6cL+mUhKhSD1wEnUOt21MoJoqOd8Go+r8V+2TVi
         3mSnYOS430e3Khbek7IsEA4fMYRzeLyE1iunDQsEEs0hxvad/Escq+YFqnqbRI3oQXZL
         8Koyi4H8Qf6rZCYGKHiLaSbb5i6fiGrreh+BEyKs3b8SH2b315J87EXvXTtrx9wufY/0
         nEvQ==
X-Gm-Message-State: AGi0PuYCquUTBWRKoUcDJz2n81jYDOLMiDYv2SdVv/EcKE62hQYEUZwp
        M5LhewqR+hoxTkHr7J15OhOAswdC/jY=
X-Google-Smtp-Source: APiQypKcNHIW372nQRoj76+O69JmPgnHAWxxkDjPGIyJ8esh/xMgfqvjqK8vvBNsnNBcGYah6Jp2rg==
X-Received: by 2002:ac8:51cb:: with SMTP id d11mr17156350qtn.370.1586893019278;
        Tue, 14 Apr 2020 12:36:59 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id t15sm11960197qtc.64.2020.04.14.12.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 12:36:58 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, charles.stevens@logicpd.com,
        Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] clk: vc5: Allow Versaclock driver to support multiple instances
Date:   Tue, 14 Apr 2020 14:36:14 -0500
Message-Id: <20200414193616.1368209-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the Versaclock driver is only expecting one instance and
uses hard-coded names for the various clock names.  Unfortunately,
this is a problem when there is more than one instance of the driver,
because the subsequent instantiations of the driver use the identical
name.  Each clock after the fist fails to load, because the clock
subsystem cannot handle two clocks with identical name.

This patch removes the hard-coded name arrays and uses kasprintf to
assign clock names based on names of their respective node and parent
node which gives each clock a unique identifying name.

For a verasaclock node with a name like:
   versaclock5: versaclock_som@6a

The updated clock names would appear like:
    versaclock_som.mux
       versaclock_som.out0_sel_i2cb
       versaclock_som.pfd
          versaclock_som.pll
             versaclock_som.fod3
                versaclock_som.out4
             versaclock_som.fod2
                versaclock_som.out3
             versaclock_som.fod1
                versaclock_som.out2
             versaclock_som.fod0
                versaclock_som.out1

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index fa96659f8023..6e4b09f1f074 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -161,30 +161,6 @@ struct vc5_driver_data {
 	struct vc5_hw_data	clk_out[VC5_MAX_CLK_OUT_NUM];
 };
 
-static const char * const vc5_mux_names[] = {
-	"mux"
-};
-
-static const char * const vc5_dbl_names[] = {
-	"dbl"
-};
-
-static const char * const vc5_pfd_names[] = {
-	"pfd"
-};
-
-static const char * const vc5_pll_names[] = {
-	"pll"
-};
-
-static const char * const vc5_fod_names[] = {
-	"fod0", "fod1", "fod2", "fod3",
-};
-
-static const char * const vc5_clk_out_names[] = {
-	"out0_sel_i2cb", "out1", "out2", "out3", "out4",
-};
-
 /*
  * VersaClock5 i2c regmap
  */
@@ -750,12 +726,13 @@ static int vc5_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	init.name = vc5_mux_names[0];
+	init.name = kasprintf(GFP_KERNEL, "%pOFn.mux", client->dev.of_node);
 	init.ops = &vc5_mux_ops;
 	init.flags = 0;
 	init.parent_names = parent_names;
 	vc5->clk_mux.init = &init;
 	ret = devm_clk_hw_register(&client->dev, &vc5->clk_mux);
+	kfree(init.name); /* clock framework made a copy of the name */
 	if (ret) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
 		goto err_clk;
@@ -764,13 +741,16 @@ static int vc5_probe(struct i2c_client *client,
 	if (vc5->chip_info->flags & VC5_HAS_PFD_FREQ_DBL) {
 		/* Register frequency doubler */
 		memset(&init, 0, sizeof(init));
-		init.name = vc5_dbl_names[0];
+		init.name = kasprintf(GFP_KERNEL, "%pOFn.dbl",
+				       client->dev.of_node);
 		init.ops = &vc5_dbl_ops;
 		init.flags = CLK_SET_RATE_PARENT;
-		init.parent_names = vc5_mux_names;
+		init.parent_names = parent_names;
+		parent_names[0] = clk_hw_get_name(&vc5->clk_mux);
 		init.num_parents = 1;
 		vc5->clk_mul.init = &init;
 		ret = devm_clk_hw_register(&client->dev, &vc5->clk_mul);
+		kfree(init.name); /* clock framework made a copy of the name */
 		if (ret) {
 			dev_err(&client->dev, "unable to register %s\n",
 				init.name);
@@ -780,16 +760,18 @@ static int vc5_probe(struct i2c_client *client,
 
 	/* Register PFD */
 	memset(&init, 0, sizeof(init));
-	init.name = vc5_pfd_names[0];
+	init.name = kasprintf(GFP_KERNEL, "%pOFn.pfd", client->dev.of_node);
 	init.ops = &vc5_pfd_ops;
 	init.flags = CLK_SET_RATE_PARENT;
+	init.parent_names = parent_names;
 	if (vc5->chip_info->flags & VC5_HAS_PFD_FREQ_DBL)
-		init.parent_names = vc5_dbl_names;
+		parent_names[0] = clk_hw_get_name(&vc5->clk_mul);
 	else
-		init.parent_names = vc5_mux_names;
+		parent_names[0] = clk_hw_get_name(&vc5->clk_mux);
 	init.num_parents = 1;
 	vc5->clk_pfd.init = &init;
 	ret = devm_clk_hw_register(&client->dev, &vc5->clk_pfd);
+	kfree(init.name); /* clock framework made a copy of the name */
 	if (ret) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
 		goto err_clk;
@@ -797,15 +779,17 @@ static int vc5_probe(struct i2c_client *client,
 
 	/* Register PLL */
 	memset(&init, 0, sizeof(init));
-	init.name = vc5_pll_names[0];
+	init.name = kasprintf(GFP_KERNEL, "%pOFn.pll", client->dev.of_node);
 	init.ops = &vc5_pll_ops;
 	init.flags = CLK_SET_RATE_PARENT;
-	init.parent_names = vc5_pfd_names;
+	init.parent_names = parent_names;
+	parent_names[0] = clk_hw_get_name(&vc5->clk_pfd);
 	init.num_parents = 1;
 	vc5->clk_pll.num = 0;
 	vc5->clk_pll.vc5 = vc5;
 	vc5->clk_pll.hw.init = &init;
 	ret = devm_clk_hw_register(&client->dev, &vc5->clk_pll.hw);
+	kfree(init.name); /* clock framework made a copy of the name */
 	if (ret) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
 		goto err_clk;
@@ -815,15 +799,18 @@ static int vc5_probe(struct i2c_client *client,
 	for (n = 0; n < vc5->chip_info->clk_fod_cnt; n++) {
 		idx = vc5_map_index_to_output(vc5->chip_info->model, n);
 		memset(&init, 0, sizeof(init));
-		init.name = vc5_fod_names[idx];
+		init.name = kasprintf(GFP_KERNEL, "%pOFn.fod%d",
+				       client->dev.of_node, idx);
 		init.ops = &vc5_fod_ops;
 		init.flags = CLK_SET_RATE_PARENT;
-		init.parent_names = vc5_pll_names;
+		init.parent_names = parent_names;
+		parent_names[0] = clk_hw_get_name(&vc5->clk_pll.hw);
 		init.num_parents = 1;
 		vc5->clk_fod[n].num = idx;
 		vc5->clk_fod[n].vc5 = vc5;
 		vc5->clk_fod[n].hw.init = &init;
 		ret = devm_clk_hw_register(&client->dev, &vc5->clk_fod[n].hw);
+		kfree(init.name); /* clock framework made a copy of the name */
 		if (ret) {
 			dev_err(&client->dev, "unable to register %s\n",
 				init.name);
@@ -833,15 +820,18 @@ static int vc5_probe(struct i2c_client *client,
 
 	/* Register MUX-connected OUT0_I2C_SELB output */
 	memset(&init, 0, sizeof(init));
-	init.name = vc5_clk_out_names[0];
+	init.name = kasprintf(GFP_KERNEL, "%pOFn.out0_sel_i2cb",
+			       client->dev.of_node);
 	init.ops = &vc5_clk_out_ops;
 	init.flags = CLK_SET_RATE_PARENT;
-	init.parent_names = vc5_mux_names;
+	init.parent_names = parent_names;
+	parent_names[0] = clk_hw_get_name(&vc5->clk_mux);
 	init.num_parents = 1;
 	vc5->clk_out[0].num = idx;
 	vc5->clk_out[0].vc5 = vc5;
 	vc5->clk_out[0].hw.init = &init;
 	ret = devm_clk_hw_register(&client->dev, &vc5->clk_out[0].hw);
+	kfree(init.name); /* clock framework made a copy of the name */
 	if (ret) {
 		dev_err(&client->dev, "unable to register %s\n",
 			init.name);
@@ -851,14 +841,15 @@ static int vc5_probe(struct i2c_client *client,
 	/* Register FOD-connected OUTx outputs */
 	for (n = 1; n < vc5->chip_info->clk_out_cnt; n++) {
 		idx = vc5_map_index_to_output(vc5->chip_info->model, n - 1);
-		parent_names[0] = vc5_fod_names[idx];
+		parent_names[0] = clk_hw_get_name(&vc5->clk_fod[idx].hw);
 		if (n == 1)
-			parent_names[1] = vc5_mux_names[0];
+			parent_names[1] = clk_hw_get_name(&vc5->clk_mux);
 		else
-			parent_names[1] = vc5_clk_out_names[n - 1];
+			parent_names[1] = clk_hw_get_name(&vc5->clk_out[n-1].hw);
 
 		memset(&init, 0, sizeof(init));
-		init.name = vc5_clk_out_names[idx + 1];
+		init.name = kasprintf(GFP_KERNEL, "%pOFn.out%d",
+				       client->dev.of_node, idx + 1);
 		init.ops = &vc5_clk_out_ops;
 		init.flags = CLK_SET_RATE_PARENT;
 		init.parent_names = parent_names;
@@ -868,6 +859,7 @@ static int vc5_probe(struct i2c_client *client,
 		vc5->clk_out[n].hw.init = &init;
 		ret = devm_clk_hw_register(&client->dev,
 					   &vc5->clk_out[n].hw);
+		kfree(init.name); /* clock framework made a copy of the name */
 		if (ret) {
 			dev_err(&client->dev, "unable to register %s\n",
 				init.name);
-- 
2.25.1

