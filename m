Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CC9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D643207DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rrb1P1Go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgFCPnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgFCPnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:43:42 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681DBC08C5C0;
        Wed,  3 Jun 2020 08:43:42 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id h4so2739536iob.10;
        Wed, 03 Jun 2020 08:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9qRGYE9VepujAcHZSqqCVwT3Q7eiBwVFx2pYpMwBWYk=;
        b=Rrb1P1GoH5Q+LDAxoi30RFhNeWjFTfPXPQWiOWcsYeJMBePeW6FQFzQA5s4TG1pyIL
         w4NwlyY6O6v/AflkwmEItw2IZWXFqImm2pz2jDBK316VYgXNa5etiMcuvvOeUrxx1SZn
         CLFfE0XCkUcRs+UajgHfHJ/UveMnh7dc/qesrvqzDvesPj0D1Shpvzsddz9vFQTwFPI1
         kMTbTtaxWcNJzej+LuTCfF91CnfWo1LE/fH4Dfwll2Zw96gjLhnDudDBJV7AGN9+cKRs
         vpkKFqOv6CvqOdubSjDOVzi5CcUHolY0KHYjqrcRKpaDCqTmlowT/BKnFM6bW4aR3Gtf
         4AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9qRGYE9VepujAcHZSqqCVwT3Q7eiBwVFx2pYpMwBWYk=;
        b=Fk+89yTwl8BN4V1K9YPUBtfnlVQgLv3qZ2XcrwFfWq0cekPgJaeY+06aKgoi6zeEVW
         BQUW2jjN0cXglROEWuagbBTNxrbMuJkKCZOHJr4SlOFCL+MhtJZZaFLRLp81bMcqada8
         GspSBsIgKTD8akvmnEeJwWSj99AHhjngcw0VzxinQv/38lW1wgYm0BqOZGbXZp8g2buM
         nWOSf1q5HehT1JRrCB1CqRkCIRV1PRP4eHA8D5WqNVwHGTkMAE4GxeaQcmTl4mDyOxol
         URxFfMqZf23QhEkcGeIBHAzPi2ltb6decuKC0aBqx3MOSJdGHr+Fh3SC8foQMKs5E19O
         ku1A==
X-Gm-Message-State: AOAM533/9YVbLV3zpJLolRUShgnXdVcWgVjH+SBNO7YHRSusVXO8zwQ1
        EKazFN8dTdaShphDqus9WAMXmQe9
X-Google-Smtp-Source: ABdhPJwZNRUzimYYnQ0Jqhu46D11hnpKXJuNWO8oieGYqfBR2gEjj7PW8WJl3juaPayr1R66MffajA==
X-Received: by 2002:a5e:c112:: with SMTP id v18mr329060iol.37.1591199021174;
        Wed, 03 Jun 2020 08:43:41 -0700 (PDT)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id l26sm1237027ild.59.2020.06.03.08.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 08:43:38 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/3] clk: vc5: Allow Versaclock driver to support multiple instances
Date:   Wed,  3 Jun 2020 10:43:27 -0500
Message-Id: <20200603154329.31579-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
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
V3:  Remove 'probed' message
V2:  No change

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index fa96659f8023..41e3a75963b9 100644
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
-- 
2.17.1

