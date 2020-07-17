Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1A1C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D222920768
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQRQtoVD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGQLEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgGQLES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:04:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6848FC061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:04:18 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x8so5297080plm.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 04:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nw6Z+jEdgX4MwhkNZpBK/vRke3sTd3g/CLK5PfVY0sA=;
        b=kQRQtoVDcCe1mQO6zirmf6wtAschU12CTNXYboGLh2vva6NFBkdYCk/SNoTohn6/hr
         J1YbAEV6et1q4yr+LuYMRXOZQlz0UHb1B11OtZ6kD9aBt0tLY7qZcFbu52xQXHw8mqp9
         Vb75tH9bBzzznWRckwXqcrTJoJSu33F3FutcBSbxahK4C7leE4v0SKFa/jYOu1EmPxv4
         nr+afwobi5InW7jFU1eVTAzJogYhclPQh3XNeALhqQxuIyleGLEQ4tgQ9fQvs48y4Awr
         o72/Z5ZaemI7h/YOTeZ5q9620RTvz4oRQ/zk1TvdYrskqeZm2S1SjG650oNDY5zSPhxy
         qFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nw6Z+jEdgX4MwhkNZpBK/vRke3sTd3g/CLK5PfVY0sA=;
        b=S8qvL/u+oAyr1Q+k1ihaHKxeD/xLxPgu3tzN9DCbv4XAQlOk9+d9p6EI3CpVIexteg
         /pkm1twQsbrQe1LDtGV+3blnYk0vpeHmSIYwosp+6kFidMjWzGcvdqGWXTzjbwaGBkuZ
         WCkSPlJ7Yfm++b3xq1rjN50w2fSiffGFbTTMzbVN1jgBD4G3mRAEbH4klZCiIhVDVQnQ
         pAMrf1AnFohtKstPs3x9uVFmmcu589IqNU7dWJBm3qwk8ggBnx8mJYYdG4n1PyN/fJPh
         F2bwlpximlruwLu1T53nFqtFbrbysVhPzVH9daJa/koAMqU5xuxSfnx+b+WfCJLTurQ3
         RnZQ==
X-Gm-Message-State: AOAM530d8GyCQ3zMCwjnN5JuDNYiSy4FpaN/nADqpV6oP7D6fKLXky/q
        MU6CBKNgaONHMzKIq5kKrLqkW+9Q
X-Google-Smtp-Source: ABdhPJyq866hdU65j1dGryL6bnqc+luwNPufUNr6exbYIi+UMaZ8L/DZ4KZnLKNfQCgppPUSwiZusQ==
X-Received: by 2002:a17:90a:cb81:: with SMTP id a1mr9525703pju.11.1594983857892;
        Fri, 17 Jul 2020 04:04:17 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:469:ae36:984e:c073:9d0b:7c09])
        by smtp.gmail.com with ESMTPSA id o26sm7619183pfp.219.2020.07.17.04.04.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 04:04:17 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v2 8/9] mfd: mt6360: Fix flow which is used to check ic exist
Date:   Fri, 17 Jul 2020 19:03:30 +0800
Message-Id: <1594983811-25908-9-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1594983811-25908-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Fix flow which is used to check ic exist.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 5a68228..3186a7c 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -293,6 +293,23 @@ static const struct mfd_cell mt6360_devs[] = {
 		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
 
+static int mt6360_check_vendor_info(struct mt6360_data *data)
+{
+	u32 info;
+	int ret;
+
+	ret = regmap_read(data->regmap, MT6360_PMU_DEV_INFO, &info);
+	if (ret < 0)
+		return ret;
+
+	if ((info & CHIP_VEN_MASK) != CHIP_VEN_MT6360)
+		return -ENODEV;
+
+	data->chip_rev = info & CHIP_REV_MASK;
+
+	return 0;
+}
+
 static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 	MT6360_PMU_SLAVEID,
 	MT6360_PMIC_SLAVEID,
@@ -303,7 +320,6 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 static int mt6360_probe(struct i2c_client *client)
 {
 	struct mt6360_data *data;
-	unsigned int reg_data;
 	int i, ret;
 
 	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
@@ -319,16 +335,10 @@ static int mt6360_probe(struct i2c_client *client)
 		return PTR_ERR(data->regmap);
 	}
 
-	ret = regmap_read(data->regmap, MT6360_PMU_DEV_INFO, &reg_data);
+	ret = mt6360_check_vendor_info(data);
 	if (ret) {
-		dev_err(&client->dev, "Device not found\n");
-		return ret;
-	}
-
-	data->chip_rev = reg_data & CHIP_REV_MASK;
-	if (data->chip_rev != CHIP_VEN_MT6360) {
 		dev_err(&client->dev, "Device not supported\n");
-		return -ENODEV;
+		return ret;
 	}
 
 	ret = devm_regmap_add_irq_chip(&client->dev, data->regmap, client->irq,
-- 
2.7.4

