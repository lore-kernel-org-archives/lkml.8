Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2395EC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F822072B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 12:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="FnUzzHQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgANMo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 07:44:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44226 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgANMo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 07:44:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id az3so5189463plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 04:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gd8PbOE4cCKKZ5AIhWpHLSW5IlLGXH0l0TMYEZgn+tY=;
        b=FnUzzHQooG24teHQzIZp4ZpdBkfeOyGNJ2xz+9148bkOisxZlzH/hyu6IHWil+QstD
         t2rMwPTiOEzB4YhwQ8/kgdGZ0Qdf6FGa9IseQTdHRKqj7xsqF3xSLKoFyK277qLZ70su
         zcxdSO968N7qbFRU61wgHi/PFCRLYNmVvjaFfOqwZwP9V4a1s0k9WQ4yj+MUKq5sONIV
         ORE7TF/ccUoSu7cXLyOjM+sxXjuohTxxi7CmE1QtowihORc4/98czQEESQel+TRJfNnB
         D39IiMHp3UxoN4F67sZQS2+BTVj2K0x+282S93crrCdzRM48+jrzrZjuNcB2MfnH1GWK
         DH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gd8PbOE4cCKKZ5AIhWpHLSW5IlLGXH0l0TMYEZgn+tY=;
        b=EqDYbTGkoj5q0DqapESiVKPAogIhB1xQO2ObcUu21ooKKb+B3UEOWUYKb4Jh9q6P+P
         dlCaz0s44NuUJ6yvVSOj+qNBuL+LN+5e+hLQjfy+sN8VJnHGerKLEI8T2ynBl5CwX7v6
         dKTos9Jx6AcDpQ4QdXYeYeXmhp00bBMkDdgRB7KBcfY2H+spR/RR9TusUn4COGQbD475
         PgoYai37bpTpQvM3L30zw/FTAzzjPvMV1hYMSq5XIqyeUn0mbmQ1ZaeBfZ8E+SVcuqhN
         VAZ4zWDr48GJ1sZeL0JI1v89Hv53M+JbTr2JspcZ1g905NyF9/eQw4oeoNKROSUTQ4Eh
         23zw==
X-Gm-Message-State: APjAAAVHKJaOpQZKNLccambwdtt2zL24ue1MvuBjF4GR2mYrdgb5q+jl
        1tzaRzZXk2u4eKjxhnDIKmWhDw==
X-Google-Smtp-Source: APXvYqxU294cgjoDyj1v3iNzOA/HM2JpI5iM/85yTYGiWSvCk3a2ZTRu5n0FkznBbZMha1gJgWmFqA==
X-Received: by 2002:a17:902:ab83:: with SMTP id f3mr26242935plr.106.1579005897955;
        Tue, 14 Jan 2020 04:44:57 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id a185sm17816033pge.15.2020.01.14.04.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 04:44:57 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Saravanan Sekar <sravanhome@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: mpq7920: Remove unneeded fields from struct mpq7920_regulator_info
Date:   Tue, 14 Jan 2020 20:44:48 +0800
Message-Id: <20200114124449.28408-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both *dev and *rdev are only used in .probe, so use local variable instead.
Also remove mpq7920_regulator_register() because it is so trivial and
there is only one caller.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mpq7920.c | 41 ++++++++++++-------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/regulator/mpq7920.c b/drivers/regulator/mpq7920.c
index 80f3131f0d1b..b133bab514a9 100644
--- a/drivers/regulator/mpq7920.c
+++ b/drivers/regulator/mpq7920.c
@@ -92,9 +92,7 @@ enum mpq7920_regulators {
 };
 
 struct mpq7920_regulator_info {
-	struct device *dev;
 	struct regmap *regmap;
-	struct regulator_dev *rdev[MPQ7920_MAX_REGULATORS];
 	struct regulator_desc *rdesc;
 };
 
@@ -262,40 +260,21 @@ static void mpq7920_parse_dt(struct device *dev,
 	of_node_put(np);
 }
 
-static inline int mpq7920_regulator_register(
-				struct mpq7920_regulator_info *info,
-				struct regulator_config *config)
-{
-	int i;
-	struct regulator_desc *rdesc;
-
-	for (i = 0; i < MPQ7920_MAX_REGULATORS; i++) {
-		rdesc = &info->rdesc[i];
-
-		info->rdev[i] = devm_regulator_register(info->dev, rdesc,
-					 config);
-		if (IS_ERR(info->rdev[i]))
-			return PTR_ERR(info->rdev[i]);
-	}
-
-	return 0;
-}
-
 static int mpq7920_i2c_probe(struct i2c_client *client,
 				    const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
 	struct mpq7920_regulator_info *info;
 	struct regulator_config config = { NULL, };
+	struct regulator_dev *rdev;
 	struct regmap *regmap;
-	int ret;
+	int i;
 
 	info = devm_kzalloc(dev, sizeof(struct mpq7920_regulator_info),
 				GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	info->dev = dev;
 	info->rdesc = mpq7920_regulators_desc;
 	regmap = devm_regmap_init_i2c(client, &mpq7920_regmap_config);
 	if (IS_ERR(regmap)) {
@@ -308,15 +287,21 @@ static int mpq7920_i2c_probe(struct i2c_client *client,
 	if (client->dev.of_node)
 		mpq7920_parse_dt(&client->dev, info);
 
-	config.dev = info->dev;
+	config.dev = dev;
 	config.regmap = regmap;
 	config.driver_data = info;
 
-	ret = mpq7920_regulator_register(info, &config);
-	if (ret < 0)
-		dev_err(dev, "Failed to register regulator!\n");
+	for (i = 0; i < MPQ7920_MAX_REGULATORS; i++) {
+		rdev = devm_regulator_register(dev,
+					       &mpq7920_regulators_desc[i],
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(dev, "Failed to register regulator!\n");
+			return PTR_ERR(rdev);
+		}
+	}
 
-	return ret;
+	return 0;
 }
 
 static const struct of_device_id mpq7920_of_match[] = {
-- 
2.20.1

