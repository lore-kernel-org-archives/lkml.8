Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64598C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36FBF20787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbgupYIY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgE0GV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgE0GV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:21:57 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EEDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:21:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p30so11297116pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fiK0INUw8B7R0yDMdP5nlqcIqTmeGxN+EFZsT075Bcw=;
        b=PbgupYIY2WPachR2z86Ztm9j9ZD7dDlDlGoD/UY+b0aCAc8ipbP3CN1cNBwC5bLpS6
         0zH5ZdGfuZuhHzVPFxEw6ykBQF5EQ5rBAszb2uWlNj0cAqsWdtPYLv3FIxEuL8TovYEB
         dI3vXxgn2H8hisGS9APaEbJa7iH7tCtEtrW/U0fc8IFr/Zfc/+4sbesRwGeqkr89QAUS
         My5bePkskYtyII5/5tfdxNGAZtKLWrpCD8k2KqFD7kqGN0H70AIZmRJnnDV099vbj3EI
         IejM/qM4Tf1VpJ6OX1Rm3Dbu4NI7taDJpFxOdfL/3EpYE4/1xSSfa58zggwZCHdi9uUI
         3kaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fiK0INUw8B7R0yDMdP5nlqcIqTmeGxN+EFZsT075Bcw=;
        b=hPbUopcOG5DwriuZE+kYY+/D70gecqskJtk2PTtEmxVkbZV7Lkou2gMWlfgaSO7GMC
         KHbX/TID/jYsIibSV/SpquIKGPqz1yBSHtXJgCiwjmYOCty7Wn5N+U13U69eCWZeR4kO
         TmXrsGGquqUCtjivB5kRTPY/gPnG3nWrPolTvVf+NOrtMtGSjFg7JhYymFMK8qUngo3U
         Wfc8wsjpdLbCfGOam9i8Sb3BBVLCT2B6x8WjMRQaFSXBK+b5zDeMlyNTbrkw7rMRiGez
         JAQf5llbJdIvn1ame9nKsEJa3BsY+a5llZi7U4Kys4S+6wKWYg3fB2UFYEc4Dn+RtGKZ
         +wKw==
X-Gm-Message-State: AOAM531Mcn94Ntt+1+h+xmUoQfZPf5hxPxZE5wUUa8N20LPgIe6VI5UQ
        MNPTrzcTLib8i+PePOXpSSm+eoZPojg=
X-Google-Smtp-Source: ABdhPJwVCVgYa8XfGwZk1frfJ3bAQwhjDT95WS6L2PXRTwFyLpUEQMDMrjehp6yNCUcXNPGFe+6GUg==
X-Received: by 2002:a63:792:: with SMTP id 140mr2453308pgh.65.1590560516277;
        Tue, 26 May 2020 23:21:56 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w21sm1259992pfu.47.2020.05.26.23.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 23:21:55 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V2] mfd: sprd: Add wakeup capability for PMIC irq
Date:   Wed, 27 May 2020 14:21:47 +0800
Message-Id: <20200527062147.680-1-zhang.lyra@gmail.com>
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
Changes from v1:
* addressed comments from Lee;
* added tested-by from Chunyan.
(This patch is rebased on branch for-mfd-next)
---
 drivers/mfd/sprd-sc27xx-spi.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index 33336cde4724..adb4a1b13332 100644
--- a/drivers/mfd/sprd-sc27xx-spi.c
+++ b/drivers/mfd/sprd-sc27xx-spi.c
@@ -256,7 +256,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
 	}
 
 	ret = devm_regmap_add_irq_chip(&spi->dev, ddata->regmap, ddata->irq,
-				       IRQF_ONESHOT | IRQF_NO_SUSPEND, 0,
+				       IRQF_ONESHOT, 0,
 				       &ddata->irq_chip, &ddata->irq_data);
 	if (ret) {
 		dev_err(&spi->dev, "Failed to add PMIC irq chip %d\n", ret);
@@ -272,9 +272,34 @@ static int sprd_pmic_probe(struct spi_device *spi)
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
@@ -285,6 +310,7 @@ static struct spi_driver sprd_pmic_driver = {
 	.driver = {
 		.name = "sc27xx-pmic",
 		.of_match_table = sprd_pmic_match,
+		.pm = &sprd_pmic_pm_ops,
 	},
 	.probe = sprd_pmic_probe,
 };
-- 
2.20.1

