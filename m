Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DF8C2D113
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A3124927
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jrNX+vgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgEMF54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 01:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729094AbgEMF5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 01:57:32 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9CBC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 22:57:31 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id hi11so10621707pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 22:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bkpNdZ6AG8/9DWk6WHMOSn/h/G7pisG1K1FG1v/lJhc=;
        b=jrNX+vghbCHJeFGVlOvREzLB9glKvp0ymzPkip63sPSDsdUTYa25NXD8kEo8ileg3P
         slI7cz+qEXiZDhXp1XfLkCUMybE6owB95Qpn9pg21VxWJlvpyW+ZXGWC0Y5EStwz5Jr4
         kSNLRuEDwU1fvOeFj1X5WNwLG9pPx0eRKBShp3xJc1RRKf2LSn2iUyDTPAwOdVQg5/Bf
         8sempa1zIJ/nMrmTFgy8Zb84JQQelQYzUgUGbCVwdgOj9wHAH0jfB8Nag65jpTzo969n
         d5JiuA2DiqzHmLUf4Hmq/CBWjnFOutOM7TiHz01aYd8t9Q3wMDj2kpsB7NMnggse3vQw
         qxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bkpNdZ6AG8/9DWk6WHMOSn/h/G7pisG1K1FG1v/lJhc=;
        b=YdF+Z5KwcS8K+GZNWhmZQA5Ie+Sa4HaKANrzyXDYkmFYLU2yFL2Ux+O0ARSVd+jf/g
         cMGDv5x0ocwdY3jyfNOaxoHb6UTk/bOkOIZn3DgDyuZuPPHzwJ4rmU2skgPqjRcpnsso
         8h/zirjjtK5h3lypkg8k8wSRaU/KjCuyVjTHC3dFRpcOJ0YGE5Xwh1Q3EI6jIrIZlx5x
         q/S01588EyvaFzljuH9kjVjx9sA8d7DUHZtpaFBnEx+6ukBsxs58BvlqxV2IUvYXv2pR
         mhezAiif5pwTZUySnvzsZS1EHKxrLhd2tcMYZhPc7+FOFFedrgtA+aVU39MJf4r4Uupz
         Fccw==
X-Gm-Message-State: AGi0PuamQWViqF1ZQnAe8lj+CSigyLlSWagrYvsNzqT6HpfWlSQDkEXF
        ItOpGyBUz4AnGjO91Gd0Pj4BLQ==
X-Google-Smtp-Source: APiQypLwDmx3EcCq9B4hcvyQfX+E9jv/TFPblkEA1L6e+iEzZgl20qA8HO/+u4RWHy4ZjWwLonP45A==
X-Received: by 2002:a17:902:9f8a:: with SMTP id g10mr23376006plq.233.1589349451295;
        Tue, 12 May 2020 22:57:31 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w192sm14131161pff.126.2020.05.12.22.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 22:57:30 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] remoteproc: qcom: Introduce helper to store pil info in IMEM
Date:   Tue, 12 May 2020 22:56:38 -0700
Message-Id: <20200513055641.1413100-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513055641.1413100-1-bjorn.andersson@linaro.org>
References: <20200513055641.1413100-1-bjorn.andersson@linaro.org>
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

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- Replaced platform_driver by just a single helper function
- Lazy initialization of mapping
- Cleaned up search loop
- Replaced regmap access of IMEM with ioremap and normal accessors

 drivers/remoteproc/Kconfig         |   3 +
 drivers/remoteproc/Makefile        |   1 +
 drivers/remoteproc/qcom_pil_info.c | 124 +++++++++++++++++++++++++++++
 drivers/remoteproc/qcom_pil_info.h |   7 ++
 4 files changed, 135 insertions(+)
 create mode 100644 drivers/remoteproc/qcom_pil_info.c
 create mode 100644 drivers/remoteproc/qcom_pil_info.h

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index fbaed079b299..8088ca4dd6dc 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -107,6 +107,9 @@ config KEYSTONE_REMOTEPROC
 	  It's safe to say N here if you're not interested in the Keystone
 	  DSPs or just want to use a bare minimum kernel.
 
+config QCOM_PIL_INFO
+	tristate
+
 config QCOM_RPROC_COMMON
 	tristate
 
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 0effd3825035..cc0f631adb3b 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
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

