Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B20AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F602083E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNOYV4j6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgFVH74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgFVH7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:59:50 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E67DC061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:59:50 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t25so14817283oij.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wsD4JPbpu6P4JVf54PUOXffj8NM5iwWqNtOuxNrh1Ek=;
        b=BNOYV4j6OzxYc7GgjKpKV5iHhJDTcp7c44mazYdUT13aaDi4kX/kj0nSDBVIy20Kuv
         2iWXqdC8MelZ6pT8J7IMyiTr761V9lDjt40hGEj2cUegqHluLTKhW9JO/foBnKb8WbU2
         FPTMALkLdzsxrhvNkF75jEIkblhVdLIjoKKaSmvy8I+JxtUpLFNkM/wPUoR+TPwKdnme
         MFx5YdfH7JjV73EMfUZOh8BCsp3DazzPy3yLz5VRQ2duLgqhUuGVSDFz3I1ctv8fCfH2
         M8WPY5rpRck6TXr/33Onpu5U2a2hN/c5h6xux7gLdrFN5AN/3yTOAozV3wy6bYlLkajy
         jIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wsD4JPbpu6P4JVf54PUOXffj8NM5iwWqNtOuxNrh1Ek=;
        b=NJBesOGbAuoYdSGP6oUGo01HD5WEpx7gZlKdo4Ur5qjMAywDiD/5QzwdqRa4uCchL2
         RKliOTpjhU6o6kW9d7sWKjsNpC4oCN2TP8GNQLwK1NTrJ7+SVSUffrE97yiEqcMJE2OP
         zPIbpMbNfxxaVl9D4DYrG2mFC7wGjEKvt31IlA5XNz4n7OsNRGOyKeSy+1zdCXPl0fDM
         3BnymmTXlj0wKmYatJ4QRVr40hq6eSFOC82xNtGJUmeUZH++pL9mrVoMsjbBW67bsT6b
         4d1l7EAtgrK3V5Hz31WsSXEoaspNYHaL40UZoojtvQ4MAjZbtVt1jXJ40rfZpI8WMBOh
         r8+A==
X-Gm-Message-State: AOAM533UGgAZIyoJsXfAP6oNHqt8u1Ku9PkkOyU7mo+FptRVtJ1sZn45
        EE9py5bekQM424PsGRpvu2DEeQ==
X-Google-Smtp-Source: ABdhPJzzr4SQgqtDcXOQA6jIMEtE2S+/98sTWL4tFRZgSSkA+8K8Ny8EKzh9/a1r9NRfHry3qVgZfQ==
X-Received: by 2002:a05:6808:6ca:: with SMTP id m10mr11477202oih.27.1592812789939;
        Mon, 22 Jun 2020 00:59:49 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id f7sm3135396otl.60.2020.06.22.00.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 00:59:49 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v2 3/4] hwspinlock: qcom: Allow mmio usage in addition to syscon
Date:   Mon, 22 Jun 2020 00:59:55 -0700
Message-Id: <20200622075956.171058-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622075956.171058-1-bjorn.andersson@linaro.org>
References: <20200622075956.171058-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In modern Qualcomm platforms the mutex region of the TCSR is forked off
into its own block, all with a offset of 0 and stride of 4096, and in
some of these platforms no other registers in this region is accessed
from Linux.

So add support for directly memory mapping this register space, to avoid
the need to represent this block using a syscon.

Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Use devm_platform_ioremap_resource()

 drivers/hwspinlock/qcom_hwspinlock.c | 70 +++++++++++++++++++++-------
 1 file changed, 54 insertions(+), 16 deletions(-)

diff --git a/drivers/hwspinlock/qcom_hwspinlock.c b/drivers/hwspinlock/qcom_hwspinlock.c
index f0da544b14d2..364710966665 100644
--- a/drivers/hwspinlock/qcom_hwspinlock.c
+++ b/drivers/hwspinlock/qcom_hwspinlock.c
@@ -70,41 +70,79 @@ static const struct of_device_id qcom_hwspinlock_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, qcom_hwspinlock_of_match);
 
-static int qcom_hwspinlock_probe(struct platform_device *pdev)
+static struct regmap *qcom_hwspinlock_probe_syscon(struct platform_device *pdev,
+						   u32 *base, u32 *stride)
 {
-	struct hwspinlock_device *bank;
 	struct device_node *syscon;
-	struct reg_field field;
 	struct regmap *regmap;
-	size_t array_size;
-	u32 stride;
-	u32 base;
 	int ret;
-	int i;
 
 	syscon = of_parse_phandle(pdev->dev.of_node, "syscon", 0);
-	if (!syscon) {
-		dev_err(&pdev->dev, "no syscon property\n");
-		return -ENODEV;
-	}
+	if (!syscon)
+		return ERR_PTR(-ENODEV);
 
 	regmap = syscon_node_to_regmap(syscon);
 	of_node_put(syscon);
 	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+		return regmap;
 
-	ret = of_property_read_u32_index(pdev->dev.of_node, "syscon", 1, &base);
+	ret = of_property_read_u32_index(pdev->dev.of_node, "syscon", 1, base);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "no offset in syscon\n");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
-	ret = of_property_read_u32_index(pdev->dev.of_node, "syscon", 2, &stride);
+	ret = of_property_read_u32_index(pdev->dev.of_node, "syscon", 2, stride);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "no stride syscon\n");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
+	return regmap;
+}
+
+static const struct regmap_config tcsr_mutex_config = {
+	.reg_bits		= 32,
+	.reg_stride		= 4,
+	.val_bits		= 32,
+	.max_register		= 0x40000,
+	.fast_io		= true,
+};
+
+static struct regmap *qcom_hwspinlock_probe_mmio(struct platform_device *pdev,
+						 u32 *offset, u32 *stride)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+
+	/* All modern platform has offset 0 and stride of 4k */
+	*offset = 0;
+	*stride = 0x1000;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return ERR_CAST(base);
+
+	return devm_regmap_init_mmio(dev, base, &tcsr_mutex_config);
+}
+
+static int qcom_hwspinlock_probe(struct platform_device *pdev)
+{
+	struct hwspinlock_device *bank;
+	struct reg_field field;
+	struct regmap *regmap;
+	size_t array_size;
+	u32 stride;
+	u32 base;
+	int i;
+
+	regmap = qcom_hwspinlock_probe_syscon(pdev, &base, &stride);
+	if (IS_ERR(regmap) && PTR_ERR(regmap) == -ENODEV)
+		regmap = qcom_hwspinlock_probe_mmio(pdev, &base, &stride);
+
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
 	array_size = QCOM_MUTEX_NUM_LOCKS * sizeof(struct hwspinlock);
 	bank = devm_kzalloc(&pdev->dev, sizeof(*bank) + array_size, GFP_KERNEL);
 	if (!bank)
-- 
2.26.2

