Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5286EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B9CA20707
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M/uiV1Ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgFPR3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbgFPR3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:29:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAF1C06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:29:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r15so3931317wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 10:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LOu0n3RUGeuxEjMp2F5UGa7yErDx6HF4q3voQT9ZrEk=;
        b=M/uiV1HtnpmWa6vznTJVZhsTnLtWaYLlOM0rCpKzs/0JNSLepkO5b6P2CRRDpTvgqL
         5ymoNqekfqFvZFBk2I2yaxh3Erh6jKFRshf+X/waUBGuopFQLDxhs37bFqEcED95mUIg
         7z02rAV/LzLm050rUf6eVq0p7yvVXJSXIbtTVYHe0pRp+/51qF4JUri4K5RCoinUXMqD
         L7ao4BoWXcWn3P3h4GVD/Qcf90fBEroysgqmFizS1TgKyiQkO9joOsdstLXoZ3Y7EyAd
         ylhCLneIMe2fyFpoUoId6F2lgrPknUm3FmHMldlVsKYbCZaNTG9xIpmOrgnXIiYVcynA
         JTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LOu0n3RUGeuxEjMp2F5UGa7yErDx6HF4q3voQT9ZrEk=;
        b=cQxoVr302ARciOQ1H0c9n8BMU57uwsY+BSz0bPhGxwyZRuqZUYEJYHtzKDupCsj2O3
         z2Z7mS8PrrqUoirgS6KjOGgjsJiWFiHQvQoMFSRrEVtXqRKNIpNZZrqzW6FEvqHIz52h
         ShzkmNk4ZFckQAMX1RXoClv8X77nb945BKPYQpVWSr2S3qvW9fkkuTG9kP6P8BLvuryf
         +yvWYdHRyGCiRNN/m6X2SHQZTYduZr8nwpd//f/Qi2lBpxyrmmTnlLbxRYNJESxDIIJJ
         L9fwc9b7y6xr2We8UYZB+SneQ3qLjhX0h6i3+KDjli21j6fd0iVY/clILY9UHOIWQdcx
         C5Gg==
X-Gm-Message-State: AOAM532kTxoCD3mu487VgvhCT/pq0vtslibeugzzKa4uGQAztQIyhyXp
        UlQISI+kBa2WES1ZTBuZbvwsTw==
X-Google-Smtp-Source: ABdhPJxjIS/eDvr9cU2j95v4CdQVYG3A3JM5PZLfD5mYzD4jjBMoqson+Wrwa5YWxruNQtFvyJBMVw==
X-Received: by 2002:a1c:4857:: with SMTP id v84mr4194000wma.96.1592328553695;
        Tue, 16 Jun 2020 10:29:13 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.65])
        by smtp.gmail.com with ESMTPSA id z6sm29444739wrh.79.2020.06.16.10.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 10:29:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     michael@walle.cc, robh+dt@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/1] mfd: Add I2C based System Configuaration (SYSCON) access
Date:   Tue, 16 Jun 2020 18:29:04 +0100
Message-Id: <20200616172904.373045-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing SYSCON implementation only supports MMIO (memory mapped)
accesses, facilitated by Regmap.  This extends support for registers
held behind I2C busses.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/Kconfig            |  7 +++
 drivers/mfd/Makefile           |  1 +
 drivers/mfd/syscon-i2c.c       | 89 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/syscon-i2c.h | 26 ++++++++++
 4 files changed, 123 insertions(+)
 create mode 100644 drivers/mfd/syscon-i2c.c
 create mode 100644 include/linux/mfd/syscon-i2c.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 0a59249198d34..63ae78b92b086 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1300,6 +1300,13 @@ config MFD_SYSCON
 	  Select this option to enable accessing system control registers
 	  via regmap.
 
+config MFD_SYSCON_I2C
+	bool "System Controller Register R/W Based on I2C Regmap"
+	select REGMAP_I2C
+	help
+	  Select this option to enable accessing system control registers
+	  via I2C using regmap.
+
 config MFD_DAVINCI_VOICECODEC
 	tristate
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f935d10cbf0fc..0aec1f42ac979 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -219,6 +219,7 @@ obj-$(CONFIG_MFD_RK808)		+= rk808.o
 obj-$(CONFIG_MFD_RN5T618)	+= rn5t618.o
 obj-$(CONFIG_MFD_SEC_CORE)	+= sec-core.o sec-irq.o
 obj-$(CONFIG_MFD_SYSCON)	+= syscon.o
+obj-$(CONFIG_MFD_SYSCON_I2C)	+= syscon-i2c.o
 obj-$(CONFIG_MFD_LM3533)	+= lm3533-core.o lm3533-ctrlbank.o
 obj-$(CONFIG_MFD_VEXPRESS_SYSREG)	+= vexpress-sysreg.o
 obj-$(CONFIG_MFD_RETU)		+= retu-mfd.o
diff --git a/drivers/mfd/syscon-i2c.c b/drivers/mfd/syscon-i2c.c
new file mode 100644
index 0000000000000..404e595d7646c
--- /dev/null
+++ b/drivers/mfd/syscon-i2c.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * System Control Driver accessed over I2C
+ *
+ * Copyright (C) 2020 Linaro Ltd.
+ *
+ * Author: Lee Jones <lee.jones@linaro.org>
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/list.h>
+#include <linux/mfd/syscon-i2c.h>
+#include <linux/regmap.h>
+
+static DEFINE_SPINLOCK(syscon_i2c_list_slock);
+static LIST_HEAD(syscon_i2c_list);
+
+struct syscon {
+	struct device_node *np;
+	struct regmap *regmap;
+	struct list_head list;
+};
+
+static const struct regmap_config syscon_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static struct syscon *of_syscon_i2c_register(struct i2c_client *client)
+{
+	struct regmap_config syscon_config = syscon_i2c_regmap_config;
+	struct device_node *np = client->dev.of_node;
+	struct syscon *syscon;
+	struct regmap *regmap;
+	int ret;
+
+	syscon = devm_kzalloc(&client->dev, sizeof(*syscon), GFP_KERNEL);
+	if (!syscon)
+		return ERR_PTR(-ENOMEM);
+
+	syscon_config.name = of_node_full_name(np);
+
+	regmap = devm_regmap_init_i2c(client, &syscon_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Failed to initialise Regmap I2C\n");
+		ret = PTR_ERR(regmap);
+		return ERR_PTR(ret);
+	}
+
+	syscon->regmap = regmap;
+	syscon->np = np;
+
+	spin_lock(&syscon_i2c_list_slock);
+	list_add_tail(&syscon->list, &syscon_i2c_list);
+	spin_unlock(&syscon_i2c_list_slock);
+
+	return syscon;
+}
+
+static struct regmap *i2c_device_node_get_regmap(struct i2c_client *client)
+{
+	struct device_node *np = client->dev.of_node;
+	struct syscon *entry, *syscon = NULL;
+
+	spin_lock(&syscon_i2c_list_slock);
+
+	list_for_each_entry(entry, &syscon_i2c_list, list)
+		if (entry->np == np) {
+			syscon = entry;
+			break;
+		}
+
+	spin_unlock(&syscon_i2c_list_slock);
+
+	if (!syscon)
+		syscon = of_syscon_i2c_register(client);
+
+	if (IS_ERR(syscon))
+		return ERR_CAST(syscon);
+
+	return syscon->regmap;
+}
+
+struct regmap *i2c_device_node_to_regmap(struct i2c_client *client)
+{
+	return i2c_device_node_get_regmap(client);
+}
+EXPORT_SYMBOL_GPL(i2c_device_node_to_regmap);
diff --git a/include/linux/mfd/syscon-i2c.h b/include/linux/mfd/syscon-i2c.h
new file mode 100644
index 0000000000000..854e316fec93e
--- /dev/null
+++ b/include/linux/mfd/syscon-i2c.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * System Control Driver accessed via I2C
+ *
+ * Copyright (C) 2020 Linaro Ltd.
+ *
+ * Author: Lee Jones <lee.jones@linaro.org>
+ */
+
+#ifndef __LINUX_MFD_SYSCON_I2C_H__
+#define __LINUX_MFD_SYSCON_I2C_H__
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+
+#ifdef CONFIG_MFD_SYSCON_I2C
+extern struct regmap *i2c_device_node_to_regmap(struct i2c_client *client);
+#else
+static inline struct regmap *i2c_device_node_to_regmap(struct i2c_client *client)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+#endif
+
+#endif /* __LINUX_MFD_SYSCON_I2C_H__ */
-- 
2.25.1

