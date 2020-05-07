Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0834C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716B520753
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gx8vRf/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgEGGkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgEGGkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:40:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A58DC061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 23:40:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mq3so2215655pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 23:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3+XwlbQLkvjIt2vgBE4Wd2CBAjsndkRVOMAlLledpyg=;
        b=gx8vRf/a6jXgZSXu94oRh01T/B2L43CzfSwh+X5VHNboIi2WOTAtcQ/IISwABLYyUs
         3r54CqmrTqGCWV2jqej2wm30UzSLmRl7yxfakTvC8ZXXemYHIRH3NdWqDQlHh0fKTAVW
         7icmYSKoxJOmwoTvomX7qU+V/AByItooF6t4RPpTKQ5MQU0M8n0as4dvJkLH9gdXH7lA
         auFIvvhx/3iojH+vrFCfRl/w7lnnVcY78/N/8Xq/fhfaeJKVbGaymIUlWnRUCZTV3M7U
         b4sDHu80+pzWH8eC8GP268RJuvjc4z0XAKqZMcHEgEOsTprTDg5O7nEbBF8T5RD2d1cm
         kiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3+XwlbQLkvjIt2vgBE4Wd2CBAjsndkRVOMAlLledpyg=;
        b=ZjnAV4EpOF+SLIpMiuuPN1pMX2JqnFPOCjB+LYA/Ng9LSWZqomTht1csHMs5vXz656
         3qxLbtsUaDl14ewySxitAbchqVd/Z2aaMeFCWUyOq4hR5ACNrv46qjoLmlkyI4OWpMvq
         d0pjvjeyxBT1Ae0ffZgYruIyREKL65Et2JWSmpNIRjbObP0aGBjrydPeedI/SzHXxJ1b
         zQUKiseGkZI4ovNyJE/09FP9K+ctgkBjUvwArsvK9mhvLx14O01z2/jEyb86QKCqAJjp
         TzPbn0OVC5b1UfIcXHAhurirEu8J+YIWYKvj++R66LlMnTLfgfzHlxlmzLYXCz+NKNnC
         nJiQ==
X-Gm-Message-State: AGi0PuaYpwNURu7qnaO1k89T8jqzJvBZj5gJ5gThSbeK6n5K7JQiq/c1
        kwr/P0eMz6ZORLuENQ8y2OilvTbttwo=
X-Google-Smtp-Source: APiQypIHfBqavWcvLTbVW448j2qAmM0GsNf3ljSkKSWCS1VMVMFRCSak0vF8p/QiabaY6AzE+etGIg==
X-Received: by 2002:a17:90a:3aef:: with SMTP id b102mr14449068pjc.177.1588833632686;
        Wed, 06 May 2020 23:40:32 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id q21sm3870693pfg.131.2020.05.06.23.40.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 May 2020 23:40:31 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: sprd: Add wakeup capability for PMIC irq
Date:   Thu,  7 May 2020 14:40:24 +0800
Message-Id: <7361f34d712b027f0cd85dc36ee158f9b6076cef.1588833125.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When changing to use suspend-to-idle to save power, the PMIC irq can not
wakeup the system due to lack of wakeup capability, which will cause
the sub-irqs (such as power key) of the PMIC can not wake up the system.
Thus we can add the wakeup capability for PMIC irq to solve this issue,
as well as removing the IRQF_NO_SUSPEND flag to allow PMIC irq to be
a wakeup source.

Reported-by: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/mfd/sprd-sc27xx-spi.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
index ebdf2f1..3064a60 100644
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
@@ -272,9 +272,36 @@ static int sprd_pmic_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	device_init_wakeup(&spi->dev, 1);
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int sprd_pmic_suspend(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct sprd_pmic *ddata = spi_get_drvdata(spi);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(ddata->irq);
+
+	return 0;
+}
+
+static int sprd_pmic_resume(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct sprd_pmic *ddata = spi_get_drvdata(spi);
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
@@ -286,6 +313,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
 		.name = "sc27xx-pmic",
 		.bus = &spi_bus_type,
 		.of_match_table = sprd_pmic_match,
+		.pm = &sprd_pmic_pm_ops,
 	},
 	.probe = sprd_pmic_probe,
 };
-- 
1.9.1

