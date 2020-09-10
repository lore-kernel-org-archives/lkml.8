Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8C9C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4179620731
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PrxFIm+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgIJVmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbgIJNBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:01:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFA8C0617A5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:01:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z1so6617879wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sqmFv2eHfj0bGsGV6vzOEYNJHRHbaIrZSb1iBx+VKQ=;
        b=PrxFIm+qcOE/pECnf7g0zilV+8j8fE3iImaK+uxbPgjn59kMBEZfMkdg4ORS781Smo
         lYYl/sJgPqyCEaARQ2FuV8iZn4IkgLY8S5J6CGi9aDUeXATZp/+Q5eV6UQmP/miEogq8
         ZQA/3HYv8K1ArxRnxNiB8N1yKMM6IgKO2ISHyOYHMYCR+oNFpwDb3i5YVB3oglVAacGM
         bX+vw9VM/NL9SuURbUIO+L6oPO8ZswxA7VKZHmYZlSuBOjKPCPEjBIlNI6rP0ON+ouG6
         D1QMY56UgRlfD3tqTVBPpsM3gfnf6I9NrDQVdAPKC5OJ6h8I5FV2JRfm6Ieo0VWAY7Vd
         KB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sqmFv2eHfj0bGsGV6vzOEYNJHRHbaIrZSb1iBx+VKQ=;
        b=Le5EWyNJW7Pyo5ZubVa8T4OkfvBKwKqsLNXIOXlZWKLeuBidqhKpe1U/nRACoNQmQL
         AA0A92sHeFpb1IDriYtCkwS1iJcUqvqyBEFrMTX7pau0eEfRn/LRNbgzqxXBGoQLYTRy
         brRTF7wbfysToBh8IoSZcYAIzQAQrtfnPn0OzKFHDZVSZAyANgWF94WJ/nHJiu1n5B3J
         3V+v2Tk7FydZQS3yLO0UVpQPBO3upGcLMjs6MW1z3pSwBW/xAgJpisF53+h1lZ3SxRGb
         6dd8GtUvlcQKceofkRnAUIdNL0V77QbJYBlJPrr4B9tRzvmNNE1XUXn26at6S1e0Tv2g
         tnuw==
X-Gm-Message-State: AOAM531/ywwM6u/qDL0kJMoITXioffbrvChLBmdqljfodkAlrEUcp5Ag
        Ed+/ARKvX3DisP/j0+0Llm45Xw==
X-Google-Smtp-Source: ABdhPJyYLi78UG6+M+KyTBE9epJZAgjW7K+uFBmHRxFPQFLB+d//S0LjdkoG9ek90bxop5qFrF9GSg==
X-Received: by 2002:adf:db43:: with SMTP id f3mr9538768wrj.219.1599742901335;
        Thu, 10 Sep 2020 06:01:41 -0700 (PDT)
Received: from alex-xps13.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y1sm9488269wru.87.2020.09.10.06.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:01:40 -0700 (PDT)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, mathieu.poirier@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stephane.leprovost@mediatek.com, gpain@baylibre.com,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v2 3/4] remoteproc: mtk_vpu_rproc: Add support of JTAG
Date:   Thu, 10 Sep 2020 15:01:47 +0200
Message-Id: <20200910130148.8734-4-abailon@baylibre.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910130148.8734-1-abailon@baylibre.com>
References: <20200910130148.8734-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSP could be debugged using JTAG.
The support of JTAG could enabled at build time and it could be enabled
using debugfs.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/remoteproc/Kconfig   |   9 +++
 drivers/remoteproc/mtk_apu.c | 151 ++++++++++++++++++++++++++++++++++-
 2 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 4ebea57bf4c8..310462346bd8 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -61,6 +61,15 @@ config MTK_APU
 
 	  It's safe to say N here.
 
+config MTK_APU_JTAG
+	bool "Enable support of JTAG"
+	depends on MTK_APU
+	help
+	  Say y to enable support of JTAG.
+	  By default, JTAG will remain disabled until it is enabled using
+	  debugfs: remoteproc/remoteproc0/jtag. Write 1 to enable it and
+	  0 to disable it.
+
 config OMAP_REMOTEPROC
 	tristate "OMAP remoteproc support"
 	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX
diff --git a/drivers/remoteproc/mtk_apu.c b/drivers/remoteproc/mtk_apu.c
index 6d2f577cfde5..07157fdc24ba 100644
--- a/drivers/remoteproc/mtk_apu.c
+++ b/drivers/remoteproc/mtk_apu.c
@@ -5,6 +5,7 @@
 
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
@@ -14,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
 
@@ -48,6 +50,11 @@
 #define CORE_DEFAULT1				(0x00000140)
 #define CORE_DEFAULT0_ARUSER_IDMA_USE_IOMMU	(0x10 << 0)
 #define CORE_DEFAULT0_AWUSER_IDMA_USE_IOMMU	(0x10 << 5)
+#define CORE_DEFAULT2				(0x00000144)
+#define CORE_DEFAULT2_DBG_EN			BIT(3)
+#define CORE_DEFAULT2_NIDEN			BIT(2)
+#define CORE_DEFAULT2_SPNIDEN			BIT(1)
+#define CORE_DEFAULT2_SPIDEN			BIT(0)
 #define CORE_XTENSA_ALTRESETVEC			(0x000001F8)
 
 struct mtk_apu_rproc {
@@ -57,6 +64,13 @@ struct mtk_apu_rproc {
 	void __iomem *base;
 	int irq;
 	struct clk_bulk_data clks[3];
+
+#ifdef CONFIG_MTK_APU_JTAG
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pinctrl_jtag;
+	bool jtag_enabled;
+	struct mutex jtag_mutex;
+#endif
 };
 
 static int mtk_apu_rproc_prepare(struct rproc *rproc)
@@ -166,6 +180,137 @@ static irqreturn_t handle_event(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_MTK_APU_JTAG
+
+static int apu_enable_jtag(struct mtk_apu_rproc *apu_rproc)
+{
+	int ret = 0;
+
+	mutex_lock(&apu_rproc->jtag_mutex);
+	if (apu_rproc->jtag_enabled) {
+		ret = -EINVAL;
+		goto err_mutex_unlock;
+	}
+
+	writel(CORE_DEFAULT2_SPNIDEN | CORE_DEFAULT2_SPIDEN |
+		CORE_DEFAULT2_NIDEN | CORE_DEFAULT2_DBG_EN,
+		apu_rproc->base + CORE_DEFAULT2);
+
+	apu_rproc->jtag_enabled = 1;
+
+err_mutex_unlock:
+	mutex_unlock(&apu_rproc->jtag_mutex);
+
+	return ret;
+}
+
+static int apu_disable_jtag(struct mtk_apu_rproc *apu_rproc)
+{
+	int ret = 0;
+
+	mutex_lock(&apu_rproc->jtag_mutex);
+	if (!apu_rproc->jtag_enabled) {
+		ret = -EINVAL;
+		goto err_mutex_unlock;
+	}
+
+	writel(0, apu_rproc->base + CORE_DEFAULT2);
+
+	apu_rproc->jtag_enabled = 0;
+
+err_mutex_unlock:
+	mutex_unlock(&apu_rproc->jtag_mutex);
+
+	return ret;
+}
+
+static ssize_t rproc_jtag_read(struct file *filp, char __user *userbuf,
+			       size_t count, loff_t *ppos)
+{
+	struct rproc *rproc = filp->private_data;
+	struct mtk_apu_rproc *apu_rproc = (struct mtk_apu_rproc *)rproc->priv;
+	char *buf = apu_rproc->jtag_enabled ? "enabled\n" : "disabled\n";
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, strlen(buf));
+}
+
+static ssize_t rproc_jtag_write(struct file *filp, const char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct rproc *rproc = filp->private_data;
+	struct mtk_apu_rproc *apu_rproc = (struct mtk_apu_rproc *)rproc->priv;
+	char buf[10];
+	int ret;
+
+	if (count < 1 || count > sizeof(buf))
+		return -EINVAL;
+
+	ret = copy_from_user(buf, user_buf, count);
+	if (ret)
+		return -EFAULT;
+
+	/* remove end of line */
+	if (buf[count - 1] == '\n')
+		buf[count - 1] = '\0';
+
+	if (!strncmp(buf, "enabled", count))
+		ret = apu_enable_jtag(apu_rproc);
+	else if (!strncmp(buf, "disabled", count))
+		ret = apu_disable_jtag(apu_rproc);
+	else
+		return -EINVAL;
+
+	return ret ? ret : count;
+}
+
+static const struct file_operations rproc_jtag_ops = {
+	.read = rproc_jtag_read,
+	.write = rproc_jtag_write,
+	.open = simple_open,
+};
+
+static int apu_jtag_probe(struct mtk_apu_rproc *apu_rproc)
+{
+	int ret;
+
+	if (!apu_rproc->rproc->dbg_dir)
+		return -ENODEV;
+
+	apu_rproc->pinctrl = devm_pinctrl_get(apu_rproc->dev);
+	if (IS_ERR(apu_rproc->pinctrl)) {
+		dev_warn(apu_rproc->dev, "Failed to find JTAG pinctrl\n");
+		return PTR_ERR(apu_rproc->pinctrl);
+	}
+
+	apu_rproc->pinctrl_jtag = pinctrl_lookup_state(apu_rproc->pinctrl,
+						       "jtag");
+	if (IS_ERR(apu_rproc->pinctrl_jtag))
+		return PTR_ERR(apu_rproc->pinctrl_jtag);
+
+	ret = pinctrl_select_state(apu_rproc->pinctrl,
+				   apu_rproc->pinctrl_jtag);
+	if (ret < 0)
+		return ret;
+
+	mutex_init(&apu_rproc->jtag_mutex);
+
+	debugfs_create_file("jtag", 0600, apu_rproc->rproc->dbg_dir,
+			    apu_rproc->rproc, &rproc_jtag_ops);
+
+	return 0;
+}
+#else
+static int apu_jtag_probe(struct mtk_apu_rproc *apu_rproc)
+{
+	return 0;
+}
+
+static int apu_disable_jtag(struct mtk_apu_rproc *apu_rproc)
+{
+	return 0;
+}
+#endif /* CONFIG_MTK_APU_JTAG */
+
 static int mtk_apu_rproc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -242,6 +387,10 @@ static int mtk_apu_rproc_probe(struct platform_device *pdev)
 		goto free_mem;
 	}
 
+	ret = apu_jtag_probe(apu_rproc);
+	if (ret)
+		dev_warn(dev, "Failed to configure jtag\n");
+
 	return 0;
 
 free_mem:
@@ -259,7 +408,7 @@ static int mtk_apu_rproc_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 
 	disable_irq(apu_rproc->irq);
-
+	apu_disable_jtag(apu_rproc);
 	rproc_del(rproc);
 	of_reserved_mem_device_release(dev);
 	rproc_free(rproc);
-- 
2.26.2

