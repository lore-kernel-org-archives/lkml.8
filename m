Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61F2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87172073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPtZjkUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgFVTT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbgFVTTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:19:37 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D96C061797
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:19:36 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a137so16665611oii.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YDklUAlI6bHbMEfvS3rwfyZb5ytTzpIXJfmJrHuuOsM=;
        b=OPtZjkUSGtiBYUCUGNcJAwEiuhXja+slcfyFtGDUFWt2uhdHFQcecKAJtq/5Jby1mG
         bKkc7dFIcHEXAJRNhHBLqz3miAhjkDemNqHN93iblDtrGduNnVmJy/qODLPFTuFeR3kP
         rmw9rtt2DA7M4q9guToFp5koAdIJ/6220rjcghPh9DN4O1gCMZjpyII+P3ayJZgf+3NC
         +tMKZGkt+/otEnsJkMfuFYwIeLlLAspjEUN+99NC40xpSQNRYQ1iv/KF/WpzV1uYp0X1
         nRMyCh87ZqCYqqc6IndFK9LuTdSgTJxadMLc+7/1jJjuXUZYahKfbn0nuC58geE9LU6k
         Yecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YDklUAlI6bHbMEfvS3rwfyZb5ytTzpIXJfmJrHuuOsM=;
        b=ouj2pW4vDNaX0E6/qc6UIZdgSZ+CFpsYhSYFOka0veO/WwgAbBKOYvZeyvF0b6upVs
         qdOEIyUQ5VYQkKHr65O6MYuRedL+YbokurNdzrJ3VtKwDi9BIDXG86j+4cBDbJh2di+y
         s8abGdaMzGafWgO75WfRWTa7ZXTIIoKyk3IaeC52+JQqi3TODtIr4xZCTi9i+Xs7sZ5n
         Xgaq3ISmnSPkCW3an/WKnwv4X2R90Ccws3JnqwxD2buSGAAPZfT0WXqia1GF+qHzhXmY
         uKtUyx446GPY2GDyRtO1R5diQKH7D907FKuqm9KtPI4LFEF8/aR0pFPLGJ50UV5YGiME
         08jw==
X-Gm-Message-State: AOAM530g3xkNYZszF3IbauKhpS/VRLFVi5Ge1g+mEhxjxuF8Tu0uhFM+
        3fGvBsYHAcK8oKzssB/4WNyBpw==
X-Google-Smtp-Source: ABdhPJx7t3TqZVcy5yeIwugnMO5BGpCYHhl19+pD2ZyaKB8+aVzJJhzGQBCWgTWUsQi1HddAOxzJ5g==
X-Received: by 2002:aca:6c6:: with SMTP id 189mr13217866oig.134.1592853575882;
        Mon, 22 Jun 2020 12:19:35 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m84sm3348294oif.32.2020.06.22.12.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:19:35 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v7 2/5] remoteproc: qcom: Introduce helper to store pil info in IMEM
Date:   Mon, 22 Jun 2020 12:19:39 -0700
Message-Id: <20200622191942.255460-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622191942.255460-1-bjorn.andersson@linaro.org>
References: <20200622191942.255460-1-bjorn.andersson@linaro.org>
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

Changes since v6:
- Replaced entry struct and usage of offset_of with a comment and defined offsets
- Renamed pil_reloc_lock
- Write out upper 32 bits of the address
- Include header from implementation
- Add linux/types.h to the header file

 drivers/remoteproc/Kconfig         |   3 +
 drivers/remoteproc/Makefile        |   1 +
 drivers/remoteproc/qcom_pil_info.c | 129 +++++++++++++++++++++++++++++
 drivers/remoteproc/qcom_pil_info.h |   9 ++
 4 files changed, 142 insertions(+)
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
index 000000000000..0536e3904669
--- /dev/null
+++ b/drivers/remoteproc/qcom_pil_info.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020 Linaro Ltd.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_address.h>
+#include "qcom_pil_info.h"
+
+/*
+ * The PIL relocation information region is used to communicate memory regions
+ * occupied by co-processor firmware for post mortem crash analysis.
+ *
+ * It consists of an array of entries with an 8 byte textual identifier of the
+ * region followed by a 64 bit base address and 32 bit size, both little
+ * endian.
+ */
+#define PIL_RELOC_NAME_LEN	8
+#define PIL_RELOC_ENTRY_SIZE	(PIL_RELOC_NAME_LEN + sizeof(__le64) + sizeof(__le32))
+
+struct pil_reloc {
+	void __iomem *base;
+	size_t num_entries;
+};
+
+static struct pil_reloc _reloc __read_mostly;
+static DEFINE_MUTEX(pil_reloc_lock);
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
+	_reloc.num_entries = resource_size(&imem) / PIL_RELOC_ENTRY_SIZE;
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
+	mutex_lock(&pil_reloc_lock);
+	ret = qcom_pil_info_init();
+	if (ret < 0) {
+		mutex_unlock(&pil_reloc_lock);
+		return ret;
+	}
+
+	for (i = 0; i < _reloc.num_entries; i++) {
+		entry = _reloc.base + i * PIL_RELOC_ENTRY_SIZE;
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
+	mutex_unlock(&pil_reloc_lock);
+	return -ENOMEM;
+
+found_unused:
+	memcpy_toio(entry, image, PIL_RELOC_NAME_LEN);
+found_existing:
+	/* Use two writel() as base is only aligned to 4 bytes on odd entries */
+	writel(base, entry + PIL_RELOC_NAME_LEN);
+	writel(base >> 32, entry + PIL_RELOC_NAME_LEN + 4);
+	writel(size, entry + PIL_RELOC_NAME_LEN + sizeof(__le64));
+	mutex_unlock(&pil_reloc_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_pil_info_store);
+
+static void __exit pil_reloc_exit(void)
+{
+	mutex_lock(&pil_reloc_lock);
+	iounmap(_reloc.base);
+	_reloc.base = NULL;
+	mutex_unlock(&pil_reloc_lock);
+}
+module_exit(pil_reloc_exit);
+
+MODULE_DESCRIPTION("Qualcomm PIL relocation info");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/remoteproc/qcom_pil_info.h b/drivers/remoteproc/qcom_pil_info.h
new file mode 100644
index 000000000000..0dce6142935e
--- /dev/null
+++ b/drivers/remoteproc/qcom_pil_info.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __QCOM_PIL_INFO_H__
+#define __QCOM_PIL_INFO_H__
+
+#include <linux/types.h>
+
+int qcom_pil_info_store(const char *image, phys_addr_t base, size_t size);
+
+#endif
-- 
2.26.2

