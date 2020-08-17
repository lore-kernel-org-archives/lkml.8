Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F077C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AA71207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF0M9K4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgHQKth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgHQKtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:49:04 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB195C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:49:03 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id l60so7628223pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sPIOzSYU2pA/shBWLkg3uMxU0iGcVrzwOJmIFEIBLoQ=;
        b=WF0M9K4qZfloylecr5h6eHHhbZo4v4jnG3xWzd31FIRUdUPiqziOo30YtVMKjdVbnO
         WLm5UgWvlu/Cq4lQOx7z55R/76JyjUrlA+OuKLmnkpSSf5DgdqZNiDnLYEf+FbLVjcDu
         m+TuUEk2aIA2hKBtGsq/ICSaeAd6D9x1XwVzLpdbiXHLfAPpM6xbFyuwM0EggAIWFyUy
         aM0Vi6lGYnpQvbKsJ89330vL4etCKZMzQvNTtzuQmW2gRpm9WdVomF2vQlPt54OGBeEu
         ysqEfPUO/owx2GGru54j9vQmxmhY8bFbWxqIipvO3hFoGU8V2zrxBAdv8tZ9Fu/UtOJe
         1Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sPIOzSYU2pA/shBWLkg3uMxU0iGcVrzwOJmIFEIBLoQ=;
        b=TsT5cXulRjHtpt7WEm6avV2MrUMicLqpBfqaihE4Y+prEgyN1iBkj8sKPjwduNaJ68
         pSdCBMFhAI645IdAxwbr3jo/u+SJwKB0lgw5xbufnI0KMmPFDQ/9+CZsDjcw2DB6raOc
         OM1SO6uuUCB+9NZ/NjxFwgxnFE7viGNBECLRCIPW9LkiDRevc34ZToXhJw2gxHwazQa0
         XKn1Wv7aNGGs6Zx4UcxuFinhMY3Lagun3l7JOk2h2BMhBp2MDnow+L/yFkbRX5HRp797
         FrjCd0O25EnjQAUpSlCmAfrQROcnw1Khgs221VZ/b5T7IG2pndiKTfHpijEA5qIczSek
         Dylg==
X-Gm-Message-State: AOAM531GUK1c1X4Fzm5hzCllkn43EXN/TMvwpNms+UYKUPgbY9pD7h5G
        OuR6dUJc3rRnFz32V/JOZGA=
X-Google-Smtp-Source: ABdhPJwtU3+vPwn4tJgwJGNCbeJrX/lil8Kf0xZjAqRHrBlfpf+NRXRx7MGUcORPHLo8sfS+7s1Bdg==
X-Received: by 2002:a17:90a:cb08:: with SMTP id z8mr12003882pjt.41.1597661343516;
        Mon, 17 Aug 2020 03:49:03 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:c217:67e6:a40c:a3bf:1945])
        by smtp.gmail.com with ESMTPSA id k12sm16976528pjp.38.2020.08.17.03.49.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Aug 2020 03:49:03 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v4 8/9] mfd: mt6360: Fix flow which is used to check ic exist
Date:   Mon, 17 Aug 2020 18:47:56 +0800
Message-Id: <1597661277-27862-9-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1597661277-27862-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Fix flow which is used to check ic exist.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/mfd/mt6360-core.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 2356d99..677c974 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -293,6 +293,25 @@ static const struct mfd_cell mt6360_devs[] = {
 		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
 
+static int mt6360_check_vendor_info(struct mt6360_ddata *ddata)
+{
+	u32 info;
+	int ret;
+
+	ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &info);
+	if (ret < 0)
+		return ret;
+
+	if ((info & CHIP_VEN_MASK) != CHIP_VEN_MT6360) {
+		dev_err(&client->dev, "Device not supported\n");
+		return -ENODEV;
+	}
+
+	ddata->chip_rev = info & CHIP_REV_MASK;
+
+	return 0;
+}
+
 static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 	MT6360_PMU_SLAVEID,
 	MT6360_PMIC_SLAVEID,
@@ -303,7 +322,6 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
 static int mt6360_probe(struct i2c_client *client)
 {
 	struct mt6360_ddata *ddata;
-	unsigned int reg_data;
 	int i, ret;
 
 	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
@@ -319,17 +337,9 @@ static int mt6360_probe(struct i2c_client *client)
 		return PTR_ERR(ddata->regmap);
 	}
 
-	ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &reg_data);
-	if (ret) {
-		dev_err(&client->dev, "Device not found\n");
+	ret = mt6360_check_vendor_info(ddata);
+	if (ret)
 		return ret;
-	}
-
-	ddata->chip_rev = reg_data & CHIP_REV_MASK;
-	if (ddata->chip_rev != CHIP_VEN_MT6360) {
-		dev_err(&client->dev, "Device not supported\n");
-		return -ENODEV;
-	}
 
 	ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
 				       0, 0, &mt6360_irq_chip,
-- 
2.7.4

