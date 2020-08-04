Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52759C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E2BC22B42
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dofzX/8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgHDQdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729994AbgHDQdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:33:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17AFC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 09:33:34 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w17so23307636ply.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 09:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sPIOzSYU2pA/shBWLkg3uMxU0iGcVrzwOJmIFEIBLoQ=;
        b=dofzX/8j/y3zd4rnbPgoEyOo3X9xNcwVZZOSj+XtCWmEnMDc7DnG5c62WqfRz08+8M
         ZwrABnFgyTjIp9Fn7Fi0LdCW5ECjAbimZzTF6qvTScJRyicb/QbwyCPvBoGlbd3VZHCE
         KAsN0OuG+a4DA5yiPiegy6IS+oVaBvkOS0x/bPcCoUx56OyXz81hZiCvt3Tm9HxWViCB
         IsBriMgCt0CbCp4F4ugZknYc0mwrb0EqMLKnb2mwR45KsKDzl/5ZHpIQHFc/378MglJu
         xc1VbACdkmqqtk8BKMaHZNdap4K1k6QKGgGIhhIDjdGcydcufAXupIEFV4fcgMk+E9BS
         6XAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sPIOzSYU2pA/shBWLkg3uMxU0iGcVrzwOJmIFEIBLoQ=;
        b=rwb4do7M8d2MpXtaCz+Stk3QeZv8btRfTaO9FBlEmgeT5sQLog0XhxAW1Ksimt1/uY
         CQq9iyMDnmyl+7gAl4QHfpUCu9gJGQxz04L+zWKfYlr+r5dq48RPrHNky5vC0BDiBLx/
         nyaBf/Bo/76+g7hBLYZG1H+nzAzWgYfqe7iteAj9QNzvW2kVwnbHlXX1pXTBgdMeRbfH
         5jz7v81jF9GA/DNuSC6vpbv0xtu4I3tLhcJY47IZDaaO8CHkKFo+1p3VwNOoqLGB+vVC
         aHjgqhufZc6HAI8mTTfz8LLGuY+K1qa8kU4Z121nMGnlbbmWPNPN+GnH1miuU6zZ2B98
         AvSw==
X-Gm-Message-State: AOAM530TyM5z6hSL4/hUlr97vAKvPvdduhIDjc2Ktk6Jo5GO1C2md/0L
        QRHokHhThJRWK7cCN56nUww=
X-Google-Smtp-Source: ABdhPJxVpyamQPe8QZBWDZVCZhK6mVUocCsi7M32bZX/yUj88jF+LNTLuEoEcElYX0puGn6zuzf70Q==
X-Received: by 2002:a17:902:9a94:: with SMTP id w20mr21094155plp.59.1596558814544;
        Tue, 04 Aug 2020 09:33:34 -0700 (PDT)
Received: from localhost.localdomain ([123.110.251.138])
        by smtp.gmail.com with ESMTPSA id m16sm657253pjz.47.2020.08.04.09.33.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2020 09:33:34 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com, rafael@kernel.org
Cc:     broonie@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH 8/9] mfd: mt6360: Fix flow which is used to check ic exist
Date:   Wed,  5 Aug 2020 00:33:01 +0800
Message-Id: <1596558782-3415-10-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
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

