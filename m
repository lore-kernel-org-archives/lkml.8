Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F15C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D860C2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCe2KSeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgGPM0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgGPM0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:26:33 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59073C061755;
        Thu, 16 Jul 2020 05:26:33 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id c16so5747556ioi.9;
        Thu, 16 Jul 2020 05:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=doFUSPu+F9XWVoD0er+QTsCiGOPKHkPF6UHj7R181iw=;
        b=mCe2KSeUnzmk3A8gQQiBEhYjSIGSvpLq2JzMLdPPyPKgIJSHIhvnuOc9gfCKTOX4vg
         8yrjJnNByYOAtKATSSwAgY+8Q5gq+xAy4sdJx9RujTXUREBm76w30qbFW1tdz9vnsN+Y
         tDJoGU3A6uJWPOl2dXB2G1UOxfcvv9W1W0LAYInw7GW8T6j5gVd2LQNshWa7oSWyWmeS
         wjCGqa7j0DbICJBi5uKkTjTS8qsW6PHSv6CWhHrBnkue4HupvWLsO+qGcEqw/Xzc7RfH
         pJ+hlojFQ9+WL/lH80WVuAnGtoPN3hd9uc4QeveINvwewCgKBXG8bY+v52f2AFkIZw7p
         sqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=doFUSPu+F9XWVoD0er+QTsCiGOPKHkPF6UHj7R181iw=;
        b=Sr9VKWltC+znnIrBdH/khIq0n8Q6tr/5sCAlHphe5V12dH0gtq1gzbHFTXQEnI8fze
         X7/h5/vrGklokwCAAY4lkaIGHMNsHQHN7Ba8CJ3seoP1uCdcKLZly456c2dIX7RAsweG
         H3Dy56oXX72bIa8yW02ZvAnLkwzCEj70Wb74hYpUXI82NeqBTbYYFygRPw8PViXS8IKT
         U9LQSzBlZvtqRAsib4CieKHNjGJcFPT5z1ZVyN0k2SD0uNy5QvuT1QXDFqADJDYywt1C
         u+8lx+W1KgAnHym6Yj5iveBRRENFfJqyExVnLoB92ZqtCR64WMMWr6n3si/ZU642cqbR
         M06w==
X-Gm-Message-State: AOAM530YouTi7SaY5ElJ99VTV2uisVNunB8Uf4VONAqZGkW3lv+P9BHS
        AYNcMVxQPMjzF8AEXnc78Cuq4PR6
X-Google-Smtp-Source: ABdhPJxiuNMoaGJIohrtAZ/TChqlgCmzOk5riegFW+xC5Gq8hkCNMIkfjUhjgF9PW9V0O776vPLbDQ==
X-Received: by 2002:a6b:c9c4:: with SMTP id z187mr4285455iof.27.1594902392215;
        Thu, 16 Jul 2020 05:26:32 -0700 (PDT)
Received: from aford-OptiPlex-7050.logicpd.com ([174.46.170.158])
        by smtp.gmail.com with ESMTPSA id o67sm2568708ila.25.2020.07.16.05.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 05:26:31 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     dan.carpenter@oracle.com, luca@lucaceresoli.net,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V3] clk: vc5: Add memory check to prevent oops
Date:   Thu, 16 Jul 2020 07:26:20 -0500
Message-Id: <20200716122620.4538-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When getting the names of the child nodes, kasprintf is used to
allocate memory which is used to create the string for the node
name.  Unfortunately, there is no memory check to determine
if this allocation fails, it may cause an error when trying
to get child node name.

This patch will check if the memory allocation fails, and returns
and -ENOMEM error instead of blindly moving on.

Fixes: 260249f929e8 ("clk: vc5: Enable addition output configurations of the Versaclock")

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>
---
V3:   Fix spelling error, and use the style of checking (!variable) instead of
      (variable == NULL)

V2:   Fix an issue where a goto was going to use an unitialized variable.

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
index 9a5fb3834b9a..9a37168c4afc 100644
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -789,10 +789,13 @@ static int vc5_get_output_config(struct i2c_client *client,
 	int ret = 0;
 
 	child_name = kasprintf(GFP_KERNEL, "OUT%d", clk_out->num + 1);
+	if (!child_name)
+		return -ENOMEM;
+
 	np_output = of_get_child_by_name(client->dev.of_node, child_name);
 	kfree(child_name);
 	if (!np_output)
-		goto output_done;
+		return 0;
 
 	ret = vc5_update_mode(np_output, clk_out);
 	if (ret)
@@ -813,7 +816,6 @@ static int vc5_get_output_config(struct i2c_client *client,
 
 	of_node_put(np_output);
 
-output_done:
 	return ret;
 }
 
@@ -828,7 +830,7 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	int ret;
 
 	vc5 = devm_kzalloc(&client->dev, sizeof(*vc5), GFP_KERNEL);
-	if (vc5 == NULL)
+	if (!vc5)
 		return -ENOMEM;
 
 	i2c_set_clientdata(client, vc5);
-- 
2.17.1

