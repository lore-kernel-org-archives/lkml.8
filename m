Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8551BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DFED20706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEPxTmEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHRDmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgHRDmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:42:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5967AC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 20:42:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 189so8472553pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 20:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gP2XQBIW2OlXbQaxhBNI3R+v0ug5AXzB6T8DWxtEbVs=;
        b=lEPxTmEF7EraOgHtYBxcToel/d9zf/g6f2ZwVSIkTkgPaGvEVoPRnanxHF+OsGwMNO
         NatkP786/JuJ1wN/H+X59Rs6geSCrMKUy/5N9mG4BcxE9utIudZAbo0l3lnZVtTnAvNu
         q9R4KXYZ7v8ezQewShjmU84itMGByEOtYWORkInDRpaQmGMF/uB7yYVvlbx2Wv4hLpsY
         J+rztDMwrLz70/3+XlpJn40BywkiU0eE0gANNf+DZgUughEOGfZk+jjozqovFPkHfOp7
         UlgWfHeuNhNJrjGD8tOU+dzrvg9RBGrmU4yMzTk7lcZRPIuqNQSmHUpI7S8eop6UcNaZ
         o4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gP2XQBIW2OlXbQaxhBNI3R+v0ug5AXzB6T8DWxtEbVs=;
        b=eA0XheAtx8Hq1C9z2DeJf72GHbe3Qyj4ZnK26UAcUhte1qD2fojR9k/L9mjWh9deQA
         nvPg7P0+PlIkomvbek1adFVcCsN4xncHAUmS/Na2fLyK6iJlg179L7viJH9APaGrHD83
         Em+SjJz5/ax+yKdTp8CIEY2vbfetohagODENAZCBsXyEuOTit+Gzp/58QS5G9ERmx+MM
         AHqaevMC8QDwG7P2oMTIFbdr7GASbLK3TXfj0CLm47UlkwiX4ZY3O7y28bFSIg5b/M79
         IiM6LrFOnsrcxtw6Qw/yzlwUH1iW6hNw2rPtr1wfB84VmIGi0ZffWQduFOC2i9TdCFow
         q+Mw==
X-Gm-Message-State: AOAM533CfQmXjmE4IDg+5vS7fbW/9VAb4K/20Ow49jXkezHX0LPZ6mYV
        ZxygId8AomTWSBEdPtH/Eqo=
X-Google-Smtp-Source: ABdhPJzxReQt43p2QNoE1/SLM4Qx0zcr/0WUPFmhikT9oLiZEi/65Lybu8wdi0KcrzJh7+HnS/xOGg==
X-Received: by 2002:a65:4bcf:: with SMTP id p15mr11478458pgr.81.1597722130885;
        Mon, 17 Aug 2020 20:42:10 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id a5sm21588786pfi.79.2020.08.17.20.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 20:42:10 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH v3] mfd: sprd: Add wakeup capability for PMIC irq
Date:   Tue, 18 Aug 2020 11:41:58 +0800
Message-Id: <20200818034158.28667-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang7@gmail.com>

When changing to use suspend-to-idle to save power, the PMIC irq can not
wakeup the system due to lack of wakeup capability, which will cause
the sub-irqs (such as power key) of the PMIC can not wake up the system.
Thus we can add the wakeup capability for PMIC irq to solve this issue,
as well as removing the IRQF_NO_SUSPEND flag to allow PMIC irq to be
a wakeup source.

Reported-by: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
Tested-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
Changes from v2:
* rebased on v5.9-rc1;

Changes from v1:
* addressed comments from Lee;
* added tested-by from Chunyan.
---
 drivers/mfd/sprd-sc27xx-spi.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index f8a8b918c60d..6b7956604a0f 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -189,7 +189,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
 		ddata->irqs[i].mask = BIT(i);
 
 	ret = devm_regmap_add_irq_chip(&spi->dev, ddata->regmap, ddata->irq,
-				       IRQF_ONESHOT | IRQF_NO_SUSPEND, 0,
+				       IRQF_ONESHOT, 0,
 				       &ddata->irq_chip, &ddata->irq_data);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to add PMIC irq chip %d\n", ret);
@@ -202,9 +202,34 @@ static int sprd_pmic_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	device_init_wakeup(&spi->dev, true);
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int sprd_pmic_suspend(struct device *dev)
+{
+	struct sprd_pmic *ddata = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(ddata->irq);
+
+	return 0;
+}
+
+static int sprd_pmic_resume(struct device *dev)
+{
+	struct sprd_pmic *ddata = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(ddata->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(sprd_pmic_pm_ops, sprd_pmic_suspend, sprd_pmic_resume);
+
 static const struct of_device_id sprd_pmic_match[] = {
 	{ .compatible = "sprd,sc2731", .data = &sc2731_data },
 	{},
@@ -215,6 +240,7 @@ static struct spi_driver sprd_pmic_driver = {
 	.driver = {
 		.name = "sc27xx-pmic",
 		.of_match_table = sprd_pmic_match,
+		.pm = &sprd_pmic_pm_ops,
 	},
 	.probe = sprd_pmic_probe,
 };
-- 
2.20.1

