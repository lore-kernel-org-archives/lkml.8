Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661A5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 03:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3697520739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 03:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txUx2+hU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgFODr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 23:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgFODr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 23:47:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFD4C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 20:47:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id h10so3296794pgq.10
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 20:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UwnaA6QeqBUDsspxXweQuQ3UPq2pKZ17ofuPROkPA+U=;
        b=txUx2+hUNAAn2ODwvxiFBMzw/kcL2QLoFiCfUtJyRwYnG1vQFPEaF3+mCTuD8jJPNM
         F4s3ysD9YZtinBtpiprt+9n38nxe/i7WitgpMs0o+icNAbSh6HOvLCXEitNvF3mmFbNp
         5VYedw/xTg8qtGBpiADhuILsgp54ML9L76vhf5VMdy81lRf0QFWdYgA/Zt3amaHiy2JC
         TK0pCfqRgaY71j1Q6og85gK4ey99N5qyyIbRPQw91UV8TAMQNGeYyNLYzxLq19Lgh25s
         /XG+GClr+Ub5+fq10h4Hb3fV7xAinxFDi9lRfNqU5MK33xz39QpmokLzDUN6/iXKNgR1
         iSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UwnaA6QeqBUDsspxXweQuQ3UPq2pKZ17ofuPROkPA+U=;
        b=XpufkWLdNuTjJaYRoYEhvwAzcxP4/+eTcVTS9mB9XpVo+OZTGvP51IWByTq0wIMyI0
         MaIqLjE9eWFySPg1cpED/jDyd0tlIKY1f4IhrIrmHg2ph+ZZQNjtI702qIZi+wKgAmCC
         KXciaAc934YPcFZi9eOtMN2MvI4YbM6DKKp5AYNLnsXjO0ES2v5M5aFQQdFze36x+YQ4
         H+A6CKqksXxKJWPVwgV83U8ptvsGyvFhqNo0TZRgPF9DPRPyCZ7Kkv+WLc6vIt23Hot6
         NobZHMW+L/W7NDIHTsjoRvf1PWNVfnhdG2ktfZy00zyUCQoLZkjJf9itrlRszwtXMr9b
         BPHw==
X-Gm-Message-State: AOAM531NK190NqunylRjfFCdESNv+yPmx6HIexGMJEPyvYCqesnu55KP
        8jJk4d3Cysv8QRKM+FljZaw=
X-Google-Smtp-Source: ABdhPJyqJyo3IItzLbAlWC4ERParwZf+ewo0ZZqHOZbxxZi9iwP3PvOAaGn/sc/e7ddzkV8dnT6UDw==
X-Received: by 2002:a62:2d0:: with SMTP id 199mr15737723pfc.4.1592192846896;
        Sun, 14 Jun 2020 20:47:26 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g19sm12114636pfo.209.2020.06.14.20.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 20:47:26 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] mfd: sprd: get subdevices from DT instead for SC27XX SPI
Date:   Mon, 15 Jun 2020 11:47:15 +0800
Message-Id: <20200615034715.11438-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

SC27XX-SPI added subdevices according to a pre-defined mfd_cell array,
no matter these devices were really included on board. So with this
patch we switch to a new way of detecting subdevices which are
defined in the devicetree.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/mfd/sprd-sc27xx-spi.c | 102 +++++++++++-----------------------
 1 file changed, 31 insertions(+), 71 deletions(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index 33336cde4724..aa3daa0cfcf5 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -93,73 +93,6 @@ enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(sprd_pmic_detect_charger_type);
 
-static const struct mfd_cell sprd_pmic_devs[] = {
-	{
-		.name = "sc27xx-wdt",
-		.of_compatible = "sprd,sc2731-wdt",
-	}, {
-		.name = "sc27xx-rtc",
-		.of_compatible = "sprd,sc2731-rtc",
-	}, {
-		.name = "sc27xx-charger",
-		.of_compatible = "sprd,sc2731-charger",
-	}, {
-		.name = "sc27xx-chg-timer",
-		.of_compatible = "sprd,sc2731-chg-timer",
-	}, {
-		.name = "sc27xx-fast-chg",
-		.of_compatible = "sprd,sc2731-fast-chg",
-	}, {
-		.name = "sc27xx-chg-wdt",
-		.of_compatible = "sprd,sc2731-chg-wdt",
-	}, {
-		.name = "sc27xx-typec",
-		.of_compatible = "sprd,sc2731-typec",
-	}, {
-		.name = "sc27xx-flash",
-		.of_compatible = "sprd,sc2731-flash",
-	}, {
-		.name = "sc27xx-eic",
-		.of_compatible = "sprd,sc2731-eic",
-	}, {
-		.name = "sc27xx-efuse",
-		.of_compatible = "sprd,sc2731-efuse",
-	}, {
-		.name = "sc27xx-thermal",
-		.of_compatible = "sprd,sc2731-thermal",
-	}, {
-		.name = "sc27xx-adc",
-		.of_compatible = "sprd,sc2731-adc",
-	}, {
-		.name = "sc27xx-audio-codec",
-		.of_compatible = "sprd,sc2731-audio-codec",
-	}, {
-		.name = "sc27xx-regulator",
-		.of_compatible = "sprd,sc2731-regulator",
-	}, {
-		.name = "sc27xx-vibrator",
-		.of_compatible = "sprd,sc2731-vibrator",
-	}, {
-		.name = "sc27xx-keypad-led",
-		.of_compatible = "sprd,sc2731-keypad-led",
-	}, {
-		.name = "sc27xx-bltc",
-		.of_compatible = "sprd,sc2731-bltc",
-	}, {
-		.name = "sc27xx-fgu",
-		.of_compatible = "sprd,sc2731-fgu",
-	}, {
-		.name = "sc27xx-7sreset",
-		.of_compatible = "sprd,sc2731-7sreset",
-	}, {
-		.name = "sc27xx-poweroff",
-		.of_compatible = "sprd,sc2731-poweroff",
-	}, {
-		.name = "sc27xx-syscon",
-		.of_compatible = "sprd,sc2731-syscon",
-	},
-};
-
 static int sprd_pmic_spi_write(void *context, const void *data, size_t count)
 {
 	struct device *dev = context;
@@ -205,6 +138,35 @@ static const struct regmap_config sprd_pmic_config = {
 	.max_register = 0xffff,
 };
 
+static int sprd_pmic_add_subdevices(struct device *dev, int id,
+			 struct irq_domain *domain)
+{
+	int ret = 0;
+	struct device_node *child, *parent = dev->of_node;
+	struct mfd_cell cell = {0};
+	const char *comp;
+	unsigned int prefix_len = strlen("sprd,");
+	char buf[30];
+
+	for_each_child_of_node(parent, child) {
+		comp = of_get_property(child, "compatible", NULL);
+		if (!comp || strncmp("sprd,", comp, prefix_len))
+			return -EINVAL;
+
+		memcpy(buf, comp, strlen(comp) + 1);
+		cell.of_compatible = buf;
+		cell.name = buf + prefix_len;
+
+		ret = devm_mfd_add_devices(dev, id, &cell, 1, NULL, 0, domain);
+		if (ret) {
+			pr_err("devm_mfd_add_devices return fail ret=%d\n", ret);
+			break;
+		}
+	}
+
+	return ret;
+}
+
 static int sprd_pmic_probe(struct spi_device *spi)
 {
 	struct sprd_pmic *ddata;
@@ -263,10 +225,8 @@ static int sprd_pmic_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	ret = devm_mfd_add_devices(&spi->dev, PLATFORM_DEVID_AUTO,
-				   sprd_pmic_devs, ARRAY_SIZE(sprd_pmic_devs),
-				   NULL, 0,
-				   regmap_irq_get_domain(ddata->irq_data));
+	ret = sprd_pmic_add_subdevices(&spi->dev, PLATFORM_DEVID_AUTO,
+				       regmap_irq_get_domain(ddata->irq_data));
 	if (ret) {
 		dev_err(&spi->dev, "Failed to register device %d\n", ret);
 		return ret;
-- 
2.20.1

