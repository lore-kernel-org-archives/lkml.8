Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF754C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 12:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84A62137B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 12:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ivbkurcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgEBMVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 08:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727815AbgEBMVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 08:21:45 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE5DC061A0C;
        Sat,  2 May 2020 05:21:45 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id y19so6031681qvv.4;
        Sat, 02 May 2020 05:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2k4qyzEEGBm56AHUR7EpyYkIjsOwusGtjy9jkzU8bLQ=;
        b=IvbkurcvG+b6nT2bNtSD4kPcRqg9W0aNNa6PUR8R0FETBZlHY5Mg37c6Ft3dedQjX2
         QMxbtDukp7EWMQAlcCGW9Nrj0DsxBeK6/06tNblmgy9ZgCIu11VsDwCPZChkmJi9pSdv
         cCEBM6jwS5GuAARavzw1Fjl/1YObR8VagbTfX7YMJF4LLhS34dFb56M/V++VCZcnYgRZ
         lPoAAS3FiM85KTfmv767peyadmj6E9Orrk7L/UJo6sWG419mRJbzqcxLmMYlx5qKC2lR
         mL0TLpCtRi9ywbk85VdKKn9A4/E8T5ejPxAok7nb8CTnB+W+Fyz5ZyTuVlG7mx1evSNE
         Tb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2k4qyzEEGBm56AHUR7EpyYkIjsOwusGtjy9jkzU8bLQ=;
        b=ppmhO2bJXBXc/lQ7D6kRd4G/9Zgfhz9yPOwccBaIwvwsZTAoAq14Wld5/mGYiXGcqZ
         NJjmsS77oPhu6OybJ8QYie1HsamMbwSiVY8E+nRmikvN6ZYppx0L4sOqoNwSFRugF5WX
         Y7PwsqvNrF6uaBfu/90DxqJry5iCptlXxoEqwMkpuly2b3xOqtkHRg2ER1wVEKS/bHAE
         /Y+VSndqvxfnuEsqDUFrBNsS9kkGfTUA3wLLRjolzrmR1j/XvyqR/GEg8qUsD0//lpuN
         DSRJ1T086rItG5om0csOHViPtcm0h64rtPR14sQ+PNuaWyHMylWmoJg6hVJCjNQ2xFh8
         arig==
X-Gm-Message-State: AGi0PubD8PGY0sqV/U9HOT+z+1XL75mfCUysc4ILSeT0BcSmYwGZatb9
        6mFFESwiJ9Wnfo4vzmBpWC8q2Bib3FU=
X-Google-Smtp-Source: APiQypJk8FP8eNWP9xM+zejjesOVmQO8/oLIOm4dmI+EYxzE3iMTvSSePditml3aaHSJLtymraz2jA==
X-Received: by 2002:a05:6214:9b3:: with SMTP id du19mr7997819qvb.167.1588422103627;
        Sat, 02 May 2020 05:21:43 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id p47sm5256413qta.44.2020.05.02.05.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 05:21:43 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, charles.stevens@logicpd.com,
        Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] clk: vc5: Allow Versaclock driver to support multiple instances
Date:   Sat,  2 May 2020 07:21:24 -0500
Message-Id: <20200502122126.188001-1-aford173@gmail.com>
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
---
V2:  No Changes

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index fa96659f8023..81255d923f00 100644
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
@@ -692,8 +668,7 @@ static int vc5_map_index_to_output(const enum vc5_model model,
 
 static const struct of_device_id clk_vc5_of_match[];
 
-static int vc5_probe(struct i2c_client *client,
-		     const struct i2c_device_id *id)
+static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct vc5_driver_data *vc5;
 	struct clk_init_data init;
@@ -742,7 +717,7 @@ static int vc5_probe(struct i2c_client *client,
 	if (!IS_ERR(vc5->pin_clkin)) {
 		vc5->clk_mux_ins |= VC5_MUX_IN_CLKIN;
 		parent_names[init.num_parents++] =
-			__clk_get_name(vc5->pin_clkin);
+		    __clk_get_name(vc5->pin_clkin);
 	}
 
 	if (!init.num_parents) {
@@ -750,12 +725,13 @@ static int vc5_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	init.name = vc5_mux_names[0];
+	init.name = kasprintf(GFP_KERNEL, "%pOFn.mux", client->dev.of_node);
 	init.ops = &vc5_mux_ops;
 	init.flags = 0;
 	init.parent_names = parent_names;
 	vc5->clk_mux.init = &init;
 	ret = devm_clk_hw_register(&client->dev, &vc5->clk_mux);
+	kfree(init.name);	/* clock framework made a copy of the name */
 	if (ret) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
 		goto err_clk;
@@ -764,13 +740,16 @@ static int vc5_probe(struct i2c_client *client,
 	if (vc5->chip_info->flags & VC5_HAS_PFD_FREQ_DBL) {
 		/* Register frequency doubler */
 		memset(&init, 0, sizeof(init));
-		init.name = vc5_dbl_names[0];
+		init.name = kasprintf(GFP_KERNEL, "%pOFn.dbl",
+				      client->dev.of_node);
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
@@ -780,16 +759,18 @@ static int vc5_probe(struct i2c_client *client,
 
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
+	kfree(init.name);	/* clock framework made a copy of the name */
 	if (ret) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
 		goto err_clk;
@@ -797,15 +778,17 @@ static int vc5_probe(struct i2c_client *client,
 
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
@@ -815,15 +798,18 @@ static int vc5_probe(struct i2c_client *client,
 	for (n = 0; n < vc5->chip_info->clk_fod_cnt; n++) {
 		idx = vc5_map_index_to_output(vc5->chip_info->model, n);
 		memset(&init, 0, sizeof(init));
-		init.name = vc5_fod_names[idx];
+		init.name = kasprintf(GFP_KERNEL, "%pOFn.fod%d",
+				      client->dev.of_node, idx);
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
@@ -833,32 +819,36 @@ static int vc5_probe(struct i2c_client *client,
 
 	/* Register MUX-connected OUT0_I2C_SELB output */
 	memset(&init, 0, sizeof(init));
-	init.name = vc5_clk_out_names[0];
+	init.name = kasprintf(GFP_KERNEL, "%pOFn.out0_sel_i2cb",
+			      client->dev.of_node);
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
+	kfree(init.name);	/* clock framework made a copy of the name */
 	if (ret) {
-		dev_err(&client->dev, "unable to register %s\n",
-			init.name);
+		dev_err(&client->dev, "unable to register %s\n", init.name);
 		goto err_clk;
 	}
 
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
+			parent_names[1] =
+			    clk_hw_get_name(&vc5->clk_out[n - 1].hw);
 
 		memset(&init, 0, sizeof(init));
-		init.name = vc5_clk_out_names[idx + 1];
+		init.name = kasprintf(GFP_KERNEL, "%pOFn.out%d",
+				      client->dev.of_node, idx + 1);
 		init.ops = &vc5_clk_out_ops;
 		init.flags = CLK_SET_RATE_PARENT;
 		init.parent_names = parent_names;
@@ -866,8 +856,8 @@ static int vc5_probe(struct i2c_client *client,
 		vc5->clk_out[n].num = idx;
 		vc5->clk_out[n].vc5 = vc5;
 		vc5->clk_out[n].hw.init = &init;
-		ret = devm_clk_hw_register(&client->dev,
-					   &vc5->clk_out[n].hw);
+		ret = devm_clk_hw_register(&client->dev, &vc5->clk_out[n].hw);
+		kfree(init.name); /* clock framework made a copy of the name */
 		if (ret) {
 			dev_err(&client->dev, "unable to register %s\n",
 				init.name);
@@ -881,6 +871,8 @@ static int vc5_probe(struct i2c_client *client,
 		goto err_clk;
 	}
 
+	dev_info(&client->dev, "probed");
+
 	return 0;
 
 err_clk:
-- 
2.25.1

