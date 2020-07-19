Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD91C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277C622B4D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JV5FjxVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgGSOdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 10:33:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38442 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725988AbgGSOdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 10:33:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595169216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=FyiYf7saiQ+lnFL+5g2tZxRVLu1/jpY1NSVk9IVEuBg=;
        b=JV5FjxVFkenlMweenDW9bmciAMeg2VCle2PvkYrXSi6SNb7hUeyAZreJ4Th32Rc2+x+Mzs
        JMjbZwqGwsmjY6i7z//uk+tMGfuowZ23LpwY80o235VGPdmCZJwi978salD7V7Dwk5jz8C
        XmsmkmOPCi/9GxN9ad/0iPQU1qdG0kM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-wN2nx_odMR-KG7M6nfvgFA-1; Sun, 19 Jul 2020 10:33:33 -0400
X-MC-Unique: wN2nx_odMR-KG7M6nfvgFA-1
Received: by mail-qv1-f69.google.com with SMTP id v10so8489806qvm.17
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 07:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FyiYf7saiQ+lnFL+5g2tZxRVLu1/jpY1NSVk9IVEuBg=;
        b=a6qWUsDehPTQeDJSsbq4/wTxPAgBQ7MDa+vxaWP2dcWOxCMAQhyc5CTfDG80QGMVtx
         XgJgr+logfumz3sJEbOxQ02Q47CXGf+aLaDzfjsq2uLX2DnZXPvq4HFsg5xbyLFjneUT
         ijhsV7IZDMlyu4Y7f5PHAzeIJpV7dGEiLAU3FVnxvoC3xiJMqXyXnD+DTVpyzSbhaEHA
         4vrG8+Hr2a3BrVeDtJcWSeXplTOh0IW9HW9Jz05Vm5IAe7ydTx+qTeDIFVYX6khfmwz+
         xCBJ6IyRFW6tBW1LYdhTK6kSUD+HRc+F+SlR4vGOq/FhHOnxagIUmuyVrC4tIWa0kY6i
         VYUQ==
X-Gm-Message-State: AOAM531bfIxcP+rDEjJdbqbz9u1drOUYjW5lzu8c0MvQhNuahlODY94G
        RUkWm3UpaD5eY7EQtudqsmAdIJQJnAgtzfFlOUtIUaH5gFxz0Lr9aa4o0QxYVoq6SYuO2OdItXQ
        nRmZD9qCV6Wv4b09cpnx0Kxei
X-Received: by 2002:ad4:4f09:: with SMTP id fb9mr17250531qvb.20.1595169212884;
        Sun, 19 Jul 2020 07:33:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzi7p1xDCZGMj4FKiOdczP97V5VcHle0hQN2BLGNy3t4tTkTZgtftdVso1X5/6IzyIR935qBA==
X-Received: by 2002:ad4:4f09:: with SMTP id fb9mr17250486qvb.20.1595169212266;
        Sun, 19 Jul 2020 07:33:32 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t187sm7504970qkf.73.2020.07.19.07.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 07:33:31 -0700 (PDT)
From:   trix@redhat.com
To:     marek.vasut@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        aford173@gmail.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] clk: vc5: Fix use after free in vc5_probe
Date:   Sun, 19 Jul 2020 07:33:24 -0700
Message-Id: <20200719143324.25695-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this error

clk-versaclock5.c:887:3: warning: Use of memory after it is freed
  [unix.Malloc]
      dev_err(&client->dev, "unable to register %s\n", init.name);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A representative problem block of code is

ret = devm_clk_hw_register(&client->dev, &vc5->clk_mux);
kfree(init.name);	/* clock framework made a copy of the name */
if (ret) {
	dev_err(&client->dev, "unable to register %s\n", init.name);
	goto err_clk;
}

init.name is freed and then used.

So reorder the free.

Fixes: f491276a5168 ("clk: vc5: Allow Versaclock driver to support multiple instances")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/clk/clk-versaclock5.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 9a5fb3834b9a..72c9ae460a01 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -882,11 +882,12 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	init.parent_names = parent_names;
 	vc5->clk_mux.init = &init;
 	ret = devm_clk_hw_register(&client->dev, &vc5->clk_mux);
-	kfree(init.name);	/* clock framework made a copy of the name */
 	if (ret) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
+		kfree(init.name);
 		goto err_clk;
 	}
+	kfree(init.name);	/* clock framework made a copy of the name */
 
 	if (vc5->chip_info->flags & VC5_HAS_PFD_FREQ_DBL) {
 		/* Register frequency doubler */
@@ -900,12 +901,13 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		init.num_parents = 1;
 		vc5->clk_mul.init = &init;
 		ret = devm_clk_hw_register(&client->dev, &vc5->clk_mul);
-		kfree(init.name); /* clock framework made a copy of the name */
 		if (ret) {
 			dev_err(&client->dev, "unable to register %s\n",
 				init.name);
+			kfree(init.name);
 			goto err_clk;
 		}
+		kfree(init.name); /* clock framework made a copy of the name */
 	}
 
 	/* Register PFD */
@@ -921,11 +923,12 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	init.num_parents = 1;
 	vc5->clk_pfd.init = &init;
 	ret = devm_clk_hw_register(&client->dev, &vc5->clk_pfd);
-	kfree(init.name);	/* clock framework made a copy of the name */
 	if (ret) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
+		kfree(init.name);
 		goto err_clk;
 	}
+	kfree(init.name);	/* clock framework made a copy of the name */
 
 	/* Register PLL */
 	memset(&init, 0, sizeof(init));
@@ -939,11 +942,12 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	vc5->clk_pll.vc5 = vc5;
 	vc5->clk_pll.hw.init = &init;
 	ret = devm_clk_hw_register(&client->dev, &vc5->clk_pll.hw);
-	kfree(init.name); /* clock framework made a copy of the name */
 	if (ret) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
+		kfree(init.name);
 		goto err_clk;
 	}
+	kfree(init.name); /* clock framework made a copy of the name */
 
 	/* Register FODs */
 	for (n = 0; n < vc5->chip_info->clk_fod_cnt; n++) {
@@ -960,12 +964,13 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		vc5->clk_fod[n].vc5 = vc5;
 		vc5->clk_fod[n].hw.init = &init;
 		ret = devm_clk_hw_register(&client->dev, &vc5->clk_fod[n].hw);
-		kfree(init.name); /* clock framework made a copy of the name */
 		if (ret) {
 			dev_err(&client->dev, "unable to register %s\n",
 				init.name);
+			kfree(init.name);
 			goto err_clk;
 		}
+		kfree(init.name); /* clock framework made a copy of the name */
 	}
 
 	/* Register MUX-connected OUT0_I2C_SELB output */
@@ -981,11 +986,12 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	vc5->clk_out[0].vc5 = vc5;
 	vc5->clk_out[0].hw.init = &init;
 	ret = devm_clk_hw_register(&client->dev, &vc5->clk_out[0].hw);
-	kfree(init.name);	/* clock framework made a copy of the name */
 	if (ret) {
 		dev_err(&client->dev, "unable to register %s\n", init.name);
+		kfree(init.name);
 		goto err_clk;
 	}
+	kfree(init.name); /* clock framework made a copy of the name */
 
 	/* Register FOD-connected OUTx outputs */
 	for (n = 1; n < vc5->chip_info->clk_out_cnt; n++) {
@@ -1008,12 +1014,13 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		vc5->clk_out[n].vc5 = vc5;
 		vc5->clk_out[n].hw.init = &init;
 		ret = devm_clk_hw_register(&client->dev, &vc5->clk_out[n].hw);
-		kfree(init.name); /* clock framework made a copy of the name */
 		if (ret) {
 			dev_err(&client->dev, "unable to register %s\n",
 				init.name);
+			kfree(init.name);
 			goto err_clk;
 		}
+		kfree(init.name); /* clock framework made a copy of the name */
 
 		/* Fetch Clock Output configuration from DT (if specified) */
 		ret = vc5_get_output_config(client, &vc5->clk_out[n]);
-- 
2.18.1

