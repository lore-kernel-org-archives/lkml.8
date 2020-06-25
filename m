Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3ADC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDEC2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iy2r5e1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388930AbgFYALF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388718AbgFYAKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:10:48 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BEEC06179A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 17:10:48 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k1so1919463pls.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 17:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1BQGhEnOTLcAnkOD6cOIMtUwarBXYNy82wKDCDvtQ90=;
        b=iy2r5e1by3FC0GuBVTzvABwS1sD4L47z2FyOAtuRL5Nw4HSH7OnFvlk/D6A4mFIYFr
         r89IOmbNP/6C05wgPfM7ACNRmBaRJ/e2ia2g+EIA4Ej5K3IE4c1uBqd90U0mEnbQ2hoO
         3VIavoCGYFVVjdBivRpG5i1uf1uEvt2eAEPRzkjB5FNpCjigxCV2y80rpo0qZSFhuWHA
         mEDDBcY4xInnbBSOa08upCkelmx6fzp7w2DO+Byrtx7O+hcgLnviBGoVmbuusHwQerqo
         5XujoVtjN5X3htlhxMhTDYFJ87eeowerl8cx9iCtGDZhU4NNpCkYmSBUCyNIWcoBMWyi
         HxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1BQGhEnOTLcAnkOD6cOIMtUwarBXYNy82wKDCDvtQ90=;
        b=VgtWXF3rbJ+DyngG1Q3o9lsEeFLnfMQMv4AgDueVwpMTBce9f6Ek075ISkhqNdXLt4
         traFLFa6e2WL61z0HlveaBSV6miBt5XFJ3L+dAjHpkGNGsIH2963CY/dIpq1y9FhZGbd
         8etgfnYwlxDi/tm2waS9yEPU+oLLc5jwKEooH1nVXUkqtUlJbt9cu/8zUGtkRlTPCe8+
         2YUPN8NbhfzNTiU+KPwvjOqa0v0uQL7uyagRYFvMnE+Eppyy0ZOkAGjQoA2/RGN+dip9
         bsgrWnXo9EKUmohtlmUEPE2W9X3K/CB+cNXnPL1W+cd/k/EBHLzqXTG4kc9G6NiTBvI6
         av2A==
X-Gm-Message-State: AOAM532JdFTb/shhuNc18Ukgani8l/wlPdyzdEl/XRl/Gf+wgzSpDkNQ
        VV0DLjUk4+3VPydxpI8ylc9cSe3qwXw=
X-Google-Smtp-Source: ABdhPJwDz2x/LmmZ4ChNgREsOBxp8f5ux0cChEqCx9b9fuxljjxzHtStIMBHmJqrHRJUwaMRnpVWew==
X-Received: by 2002:a17:902:a585:: with SMTP id az5mr30012995plb.207.1593043847478;
        Wed, 24 Jun 2020 17:10:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id n19sm17458671pgb.0.2020.06.24.17.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 17:10:47 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v2 3/5] irqchip: Allow QCOM_PDC to be loadable as a permanent module
Date:   Thu, 25 Jun 2020 00:10:37 +0000
Message-Id: <20200625001039.56174-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200625001039.56174-1-john.stultz@linaro.org>
References: <20200625001039.56174-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows qcom-pdc driver to be loaded as a permanent module

Also, due to the fact that IRQCHIP_DECLARE becomes a no-op when
building as a module, we have to add the platform driver hooks
explicitly.

Thanks to Saravana for his help on pointing out the
IRQCHIP_DECLARE issue and guidance on a solution.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Maulik Shah <mkshah@codeaurora.org>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v2: Fix spelling, include order and set suppress_bind_attrs
    suggested by Maulik Shah
---
 drivers/irqchip/Kconfig    |  2 +-
 drivers/irqchip/qcom-pdc.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 29fead208cad..12765bed08f9 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -425,7 +425,7 @@ config GOLDFISH_PIC
          for Goldfish based virtual platforms.
 
 config QCOM_PDC
-	bool "QCOM PDC"
+	tristate "QCOM PDC"
 	depends on ARCH_QCOM
 	select IRQ_DOMAIN_HIERARCHY
 	help
diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 6ae9e1f0819d..3fee8b655da1 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -11,9 +11,11 @@
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/soc/qcom/irq.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -430,4 +432,33 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 	return ret;
 }
 
+#ifdef MODULE
+static int qcom_pdc_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device_node *parent = of_irq_find_parent(np);
+
+	return qcom_pdc_init(np, parent);
+}
+
+static const struct of_device_id qcom_pdc_match_table[] = {
+	{ .compatible = "qcom,pdc" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qcom_pdc_match_table);
+
+static struct platform_driver qcom_pdc_driver = {
+	.probe = qcom_pdc_probe,
+	.driver = {
+		.name = "qcom-pdc",
+		.of_match_table = qcom_pdc_match_table,
+		.suppress_bind_attrs = true,
+	},
+};
+module_platform_driver(qcom_pdc_driver);
+#else
 IRQCHIP_DECLARE(qcom_pdc, "qcom,pdc", qcom_pdc_init);
+#endif
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Power Domain Controller");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

