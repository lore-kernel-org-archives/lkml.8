Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308B9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E898207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 05:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nz2Qeh2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgE0FuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 01:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgE0Fty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 01:49:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E22C03E96E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 22:49:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t7so9734863plr.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 22:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MyuiQtsGOm2RNXiobo7aogyF18iHW8FoOP+MspWK4MQ=;
        b=Nz2Qeh2GMSZcE/zDLdtU1D52O+L6ej8pBqq4pD6OwEZjyLbVZvaiXkzkO+YLLGYJW2
         u+98ecPl31iJlMZD+GzPdU/IjPiO/1yfubeLzbaESWI/SMgrnohhPOIEW0kHFuTLKcxF
         e/eA2IBHLsYQ5gxNb5x2a7XQy4P234yifiReBvRTjSR7DazLPgF19UHal109YhNR0PPD
         4hT4ubt1JKf/Q4KyMb5G3IV02KizRIqppM4Uf7geR+ziZ0p6wk+pACBcJskP5zFDFV+E
         WgoWRjcUwxqnrazraK9ivqpdf8GMcSoO1tly9i+B1DFMo1g5XsLFx2RqDsVkuh6pAUP5
         EwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MyuiQtsGOm2RNXiobo7aogyF18iHW8FoOP+MspWK4MQ=;
        b=hwJVNyuZ9+eVmHe9Nz5huKnlN4PaC7xogh9cdbDA/uyUtZ8tS6B62gB23s3fK5briv
         dJJqpK1/04gREPCxygcABnnAz7MsWugF5L7znOygWc1S8yFAxwUfUxyYp8hMlZyP5Sq2
         gLigqJb/+BzjnTN3FX6YzagwTahm2Xz0TYfGLN1PZxfYAKPzwovhMDnH4HoMFSbvgINg
         HddxAEIS4M5lak/cug4F10i7XbXd07DLPGsql03e3NpmoBqHxQt87pDYu02eBi6iE8ow
         5gz959FSUOv7bIosk3mVZvUcd3IKRUnf86DAT3Itf0+ALsIZDyQOWtAay6LvAYyzVYw6
         2ecA==
X-Gm-Message-State: AOAM532vYM9m+fbJiaqpQBgCuBNEVmKE2VFSRhlRcJYYdJufCJVYGksJ
        5Rj0P/Xeu/4r7PdHX8FplGG3tg==
X-Google-Smtp-Source: ABdhPJwHmuFsTys0q6ulNape8ep95x/slYY7/w3k7vtPkxRhmwZEe1wIzl7ALfKxTUR7fHUyhcFsAg==
X-Received: by 2002:a17:902:bf02:: with SMTP id bi2mr4425100plb.330.1590558593405;
        Tue, 26 May 2020 22:49:53 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 206sm1015873pfy.97.2020.05.26.22.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 22:49:52 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v6 2/5] remoteproc: qcom: Introduce helper to store pil info in IMEM
Date:   Tue, 26 May 2020 22:48:46 -0700
Message-Id: <20200527054850.2067032-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527054850.2067032-1-bjorn.andersson@linaro.org>
References: <20200527054850.2067032-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A region in IMEM is used to communicate load addresses of remoteproc to
post mortem debug tools. Implement a helper function that can be used to
store this information in order to enable these tools to process
collected ramdumps.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v5:
- Picked up reviewed-bys

 drivers/remoteproc/Kconfig         |   3 +
 drivers/remoteproc/Makefile        |   1 +
 drivers/remoteproc/qcom_pil_info.c | 124 +++++++++++++++++++++++++++++
 drivers/remoteproc/qcom_pil_info.h |   7 ++
 4 files changed, 135 insertions(+)
 create mode 100644 drivers/remoteproc/qcom_pil_info.c
 create mode 100644 drivers/remoteproc/qcom_pil_info.h

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index c4d1731295eb..f4bd96d1a1a3 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -116,6 +116,9 @@ config KEYSTONE_REMOTEPROC
 	  It's safe to say N here if you're not interested in the Keystone
 	  DSPs or just want to use a bare minimum kernel.
 
+config QCOM_PIL_INFO
+	tristate
+
 config QCOM_RPROC_COMMON
 	tristate
 
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index e8b886e511f0..fe398f82d550 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
 obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
 obj-$(CONFIG_KEYSTONE_REMOTEPROC)	+= keystone_remoteproc.o
+obj-$(CONFIG_QCOM_PIL_INFO)		+= qcom_pil_info.o
 obj-$(CONFIG_QCOM_RPROC_COMMON)		+= qcom_common.o
 obj-$(CONFIG_QCOM_Q6V5_COMMON)		+= qcom_q6v5.o
 obj-$(CONFIG_QCOM_Q6V5_ADSP)		+= qcom_q6v5_adsp.o
diff --git a/drivers/remoteproc/qcom_pil_info.c b/drivers/remoteproc/qcom_pil_info.c
new file mode 100644
index 000000000000..0785c7cde2d3
--- /dev/null
+++ b/drivers/remoteproc/qcom_pil_info.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020 Linaro Ltd.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_address.h>
+
+#define PIL_RELOC_NAME_LEN	8
+
+struct pil_reloc_entry {
+	char name[PIL_RELOC_NAME_LEN];
+	__le64 base;
+	__le32 size;
+} __packed;
+
+struct pil_reloc {
+	struct device *dev;
+	void __iomem *base;
+	size_t num_entries;
+};
+
+static struct pil_reloc _reloc __read_mostly;
+static DEFINE_MUTEX(reloc_mutex);
+
+static int qcom_pil_info_init(void)
+{
+	struct device_node *np;
+	struct resource imem;
+	void __iomem *base;
+	int ret;
+
+	/* Already initialized? */
+	if (_reloc.base)
+		return 0;
+
+	np = of_find_compatible_node(NULL, NULL, "qcom,pil-reloc-info");
+	if (!np)
+		return -ENOENT;
+
+	ret = of_address_to_resource(np, 0, &imem);
+	of_node_put(np);
+	if (ret < 0)
+		return ret;
+
+	base = ioremap(imem.start, resource_size(&imem));
+	if (!base) {
+		pr_err("failed to map PIL relocation info region\n");
+		return -ENOMEM;
+	}
+
+	memset_io(base, 0, resource_size(&imem));
+
+	_reloc.base = base;
+	_reloc.num_entries = resource_size(&imem) / sizeof(struct pil_reloc_entry);
+
+	return 0;
+}
+
+/**
+ * qcom_pil_info_store() - store PIL information of image in IMEM
+ * @image:	name of the image
+ * @base:	base address of the loaded image
+ * @size:	size of the loaded image
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int qcom_pil_info_store(const char *image, phys_addr_t base, size_t size)
+{
+	char buf[PIL_RELOC_NAME_LEN];
+	void __iomem *entry;
+	int ret;
+	int i;
+
+	mutex_lock(&reloc_mutex);
+	ret = qcom_pil_info_init();
+	if (ret < 0) {
+		mutex_unlock(&reloc_mutex);
+		return ret;
+	}
+
+	for (i = 0; i < _reloc.num_entries; i++) {
+		entry = _reloc.base + i * sizeof(struct pil_reloc_entry);
+
+		memcpy_fromio(buf, entry, PIL_RELOC_NAME_LEN);
+
+		/*
+		 * An empty record means we didn't find it, given that the
+		 * records are packed.
+		 */
+		if (!buf[0])
+			goto found_unused;
+
+		if (!strncmp(buf, image, PIL_RELOC_NAME_LEN))
+			goto found_existing;
+	}
+
+	pr_warn("insufficient PIL info slots\n");
+	mutex_unlock(&reloc_mutex);
+	return -ENOMEM;
+
+found_unused:
+	memcpy_toio(entry, image, PIL_RELOC_NAME_LEN);
+found_existing:
+	writel(base, entry + offsetof(struct pil_reloc_entry, base));
+	writel(size, entry + offsetof(struct pil_reloc_entry, size));
+	mutex_unlock(&reloc_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_pil_info_store);
+
+static void __exit pil_reloc_exit(void)
+{
+	mutex_lock(&reloc_mutex);
+	iounmap(_reloc.base);
+	_reloc.base = NULL;
+	mutex_unlock(&reloc_mutex);
+}
+module_exit(pil_reloc_exit);
+
+MODULE_DESCRIPTION("Qualcomm PIL relocation info");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/remoteproc/qcom_pil_info.h b/drivers/remoteproc/qcom_pil_info.h
new file mode 100644
index 000000000000..1b89a63ba82f
--- /dev/null
+++ b/drivers/remoteproc/qcom_pil_info.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __QCOM_PIL_INFO_H__
+#define __QCOM_PIL_INFO_H__
+
+int qcom_pil_info_store(const char *image, phys_addr_t base, size_t size);
+
+#endif
-- 
2.26.2

