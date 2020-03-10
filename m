Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB92C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9EBF2467C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wn9aBLzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgCJGfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:35:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34984 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgCJGfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:35:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id g6so5055551plt.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 23:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oEdceuMhJ/HWHgIlQMkR5aDha0iNThcthMTFsgY4X6o=;
        b=Wn9aBLzl+UnCqOuPciLOdUfwithSf1cBD3QTBcZmRt7LLyceodJXjpMk9R/GMVgQmu
         9Ghfravd8LjJOCCwIOY59WYEH2x+Nd6rHBis5AVKVaG13UxXBsnJ62DK5sZESDvUYtjm
         UrToKmrBOh/hZsy0E/wPDNTym5ImlRs6WZh1/glLAPYZADcXEcPSatabnFochKrOMTQf
         6xPip5Ald/4wXcWWtQCuGM1fGsdq8mkSHqEgW+sOiAewmBj8z9LXAkbuzVJW8b5A9hZV
         L5rejfeMPnsPZDwotdeDlhJkSSXnIvfzZ/bNTKPUBRpiXLc+lZSCK4BjS7VZ31poeS4x
         wvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oEdceuMhJ/HWHgIlQMkR5aDha0iNThcthMTFsgY4X6o=;
        b=aD+mlzELgRgqmftXpkyjWQgL5C/HvpmZKZRNqN9QBXM7evvbIHe11Pcg8BkVhJkUvo
         MHfq9o1nNl13uSt9OJQ0iLprJjG+tBuCyy5G4D7KmkzW0tExuSCy+tfPMjH7R+dMTMR9
         laUGVKZUMdITytr9ZwcHX/00dSizzobDPugz4ACNMjkn9/u75CFJ6hTtsqsMCw5VuzCG
         O/gwat5tPCaBahQ7/lWC3QVaL9OHOBoBnZIAcvo8B5Hb/Y7uwuVh2xjzQpcuiTR4SLT9
         DhaIdI/S3retm+fSa4+HoYPfmLObDDhOM52w09Uf4Gfo2XylmIGlOF4oHFJPXU2+Ww3t
         KbMA==
X-Gm-Message-State: ANhLgQ2ySUmfl5kV4p3U6JgOvAj6wZJNlAw2IJq+2EcnYPk7g+1M6eRF
        HvgTvUFpN+hSQpTMwKzvYu4m7w==
X-Google-Smtp-Source: ADFU+vtTbY65DQ+Qj2qzyPvbhEfVp7bzjfKAe2cRm9jV8N/6Hpb5FN9vUHjqE2ElGi7xHDhvKDjGiQ==
X-Received: by 2002:a17:90a:9311:: with SMTP id p17mr198377pjo.140.1583822113511;
        Mon, 09 Mar 2020 23:35:13 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v8sm1388029pjr.10.2020.03.09.23.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 23:35:12 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v4 2/5] remoteproc: qcom: Introduce driver to store pil info in IMEM
Date:   Mon,  9 Mar 2020 23:33:35 -0700
Message-Id: <20200310063338.3344582-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200310063338.3344582-1-bjorn.andersson@linaro.org>
References: <20200310063338.3344582-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A region in IMEM is used to communicate load addresses of remoteproc to
post mortem debug tools. Implement a driver that can be used to store
this information in order to enable these tools to process collected
ramdumps.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
- Don't carry shadow of all entries
- Reworked indexing of entries in qcom_pil_info_store()
- Marked global __read_mostly

Stephen requested, in v3, that the driver should be turned into a library that,
in the context of the remoteproc drivers, would resolve the pil info region and
update an appropriate entry, preferably a statically assigned one.

Unfortunately the entries must be packed, so it's not possible to pre-assign
entries for each remoteproc, in case some of them aren't booted. Further more,
it turns out that the IMEM region must be zero-initialized in order to have a
reliable way to determining which entries are available.

We therefor have the need for global mutual exclusion and a mechanism that is
guaranteed to run before any clients attempt to update the content - so the
previously proposed design is maintained.

 drivers/remoteproc/Kconfig         |   3 +
 drivers/remoteproc/Makefile        |   1 +
 drivers/remoteproc/qcom_pil_info.c | 180 +++++++++++++++++++++++++++++
 drivers/remoteproc/qcom_pil_info.h |   8 ++
 4 files changed, 192 insertions(+)
 create mode 100644 drivers/remoteproc/qcom_pil_info.c
 create mode 100644 drivers/remoteproc/qcom_pil_info.h

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index de3862c15fcc..20c8194e610e 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -95,6 +95,9 @@ config KEYSTONE_REMOTEPROC
 	  It's safe to say N here if you're not interested in the Keystone
 	  DSPs or just want to use a bare minimum kernel.
 
+config QCOM_PIL_INFO
+	tristate
+
 config QCOM_RPROC_COMMON
 	tristate
 
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index e30a1b15fbac..2ab32bd41b44 100644
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
index 000000000000..0ddfb2639b7f
--- /dev/null
+++ b/drivers/remoteproc/qcom_pil_info.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019-2020 Linaro Ltd.
+ */
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
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
+	struct regmap *map;
+	size_t offset;
+	size_t num_entries;
+	size_t entry_size;
+};
+
+static struct pil_reloc *_reloc __read_mostly;
+static DEFINE_MUTEX(reloc_mutex);
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
+	struct pil_reloc_entry entry;
+	unsigned int offset;
+	int selected = -1;
+	int ret;
+	int i;
+
+	offset = _reloc->offset;
+
+	mutex_lock(&reloc_mutex);
+	for (i = 0; i < _reloc->num_entries; i++) {
+		ret = regmap_bulk_read(_reloc->map, offset, &entry, _reloc->entry_size);
+		if (ret < 0)
+			continue;
+
+		if (!entry.name[0]) {
+			if (selected == -1)
+				selected = offset;
+			continue;
+		}
+
+		if (!strncmp(entry.name, image, sizeof(entry.name))) {
+			selected = offset;
+			goto found;
+		}
+
+		offset += sizeof(entry);
+	}
+
+	if (selected == -1) {
+		dev_warn(_reloc->dev, "insufficient PIL info slots\n");
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+found:
+	strscpy(entry.name, image, ARRAY_SIZE(entry.name));
+	entry.base = base;
+	entry.size = size;
+
+	ret = regmap_bulk_write(_reloc->map, selected, &entry, _reloc->entry_size);
+unlock:
+	mutex_unlock(&reloc_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(qcom_pil_info_store);
+
+/**
+ * qcom_pil_info_available() - query if the pil info is probed
+ *
+ * Return: boolean indicating if the pil info device is probed
+ */
+bool qcom_pil_info_available(void)
+{
+	return !!_reloc;
+}
+EXPORT_SYMBOL_GPL(qcom_pil_info_available);
+
+static int pil_reloc_probe(struct platform_device *pdev)
+{
+	struct pil_reloc_entry entry = {0};
+	struct pil_reloc *reloc;
+	struct resource *res;
+	struct resource imem;
+	unsigned int offset;
+	int ret;
+	int i;
+
+	reloc = devm_kzalloc(&pdev->dev, sizeof(*reloc), GFP_KERNEL);
+	if (!reloc)
+		return -ENOMEM;
+
+	reloc->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	/* reloc->offset is relative to parent (IMEM) base address */
+	ret = of_address_to_resource(pdev->dev.of_node->parent, 0, &imem);
+	if (ret < 0)
+		return ret;
+
+	reloc->offset = res->start - imem.start;
+	reloc->num_entries = resource_size(res) / sizeof(entry);
+
+	reloc->map = syscon_node_to_regmap(pdev->dev.parent->of_node);
+	if (IS_ERR(reloc->map))
+		return PTR_ERR(reloc->map);
+
+	ret = regmap_get_val_bytes(reloc->map);
+	if (ret < 0)
+		return -EINVAL;
+	reloc->entry_size = sizeof(entry) / ret;
+
+	offset = reloc->offset;
+	for (i = 0; i < reloc->num_entries; i++, offset += sizeof(entry)) {
+		ret = regmap_bulk_write(reloc->map, offset, &entry,
+					reloc->entry_size);
+		if (ret < 0)
+			return ret;
+	}
+
+	mutex_lock(&reloc_mutex);
+	_reloc = reloc;
+	mutex_unlock(&reloc_mutex);
+
+	return 0;
+}
+
+static int pil_reloc_remove(struct platform_device *pdev)
+{
+	mutex_lock(&reloc_mutex);
+	_reloc = NULL;
+	mutex_unlock(&reloc_mutex);
+
+	return 0;
+}
+
+static const struct of_device_id pil_reloc_of_match[] = {
+	{ .compatible = "qcom,pil-reloc-info" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pil_reloc_of_match);
+
+static struct platform_driver pil_reloc_driver = {
+	.probe = pil_reloc_probe,
+	.remove = pil_reloc_remove,
+	.driver = {
+		.name = "qcom-pil-reloc-info",
+		.of_match_table = pil_reloc_of_match,
+	},
+};
+module_platform_driver(pil_reloc_driver);
+
+MODULE_DESCRIPTION("Qualcomm PIL relocation info");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/remoteproc/qcom_pil_info.h b/drivers/remoteproc/qcom_pil_info.h
new file mode 100644
index 000000000000..93aaaca8aed2
--- /dev/null
+++ b/drivers/remoteproc/qcom_pil_info.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __QCOM_PIL_INFO_H__
+#define __QCOM_PIL_INFO_H__
+
+int qcom_pil_info_store(const char *image, phys_addr_t base, size_t size);
+bool qcom_pil_info_available(void);
+
+#endif
-- 
2.24.0

