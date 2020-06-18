Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4909C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783F1208D5
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DJkBYiuu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgFRIEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbgFRIDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:03:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B7EC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 01:03:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t13so2567292wrs.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 01:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/SU7W2GJKeHJvbcABLTspqPlvuU+fo28Kd5ODOQRwk4=;
        b=DJkBYiuucTO/DfAGSZdUlUh8cxXQmxceh05pT+8VxUyh3WiCS0DCPC7LZ5NI6Ts/lN
         ZhnlA2qGFXvIZcbpPEG8dmsGeQxWAA9sGmdLO3ShUJWOvyMq5yPT98Yq0f76kvRbs7bc
         LY+bMF5DiUWSG1frJcxziEiCdsIF11rMVLxDxmlvPTDJZwYiVwaZqNsIkS6BPnlot8o+
         Jv1xk+pOLWxVlgZQR213Enj1kOYdDufZXejqZ/Jurpzz5SnHQzQr593iQo/X+jwgAKK7
         EoHW2PG2twbHH7PZIAMHbZOejjilvUV5AEAS0ojmpCTXcar399OfEiR47tS22udQfgfK
         A2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/SU7W2GJKeHJvbcABLTspqPlvuU+fo28Kd5ODOQRwk4=;
        b=F58ChryAdYhLpvfX00ex1S8E+T5RgHgU+DucYLT4S/1Ycj4Fw7//P4XEWclJtbk4OQ
         jWF0oIc36kkbpu2HG78m7/nhswXs6IANy6ePoTnv/hMWxz1NGeP69GErRYSJan+q1YUA
         IVlmzYaFP9yUBLFUR0CyIKL5hTgj8cIZIKhDI2bbQDwelC4elkOWkx3HwuBjSUJgJJw0
         1Nsz9ej4OM4Neg5CuhdDMkZYSthsCxReBS2wnxiUiTUilyEX4gwaw0XxRSYn1Kbr1h60
         OJoHCrfmLDh2rt/Qp3wIWUi5qVSlcddVil58ERRkEmV+RsC+Tczh7Droq27PyTkrgB53
         FBzw==
X-Gm-Message-State: AOAM533cn29Ert0z976X85a4Wn0oBO0OUMT8/2/K6JMEBji+LC+f9D8W
        mFH4JhNdRTiGq+CFNsXQCizC2Q==
X-Google-Smtp-Source: ABdhPJw8crlDMOPpr0aGwPsYxTgWEqV4OSpPoGwLOBz+MSwKjw0ga6Ri2WLdBSY6VXkBi1+BubrBYQ==
X-Received: by 2002:a5d:6087:: with SMTP id w7mr3603718wrt.158.1592467405816;
        Thu, 18 Jun 2020 01:03:25 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.118])
        by smtp.gmail.com with ESMTPSA id z16sm2425174wrm.70.2020.06.18.01.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 01:03:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     michael@walle.cc, robh+dt@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, arnd@arndb.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 1/1] mfd: Add I2C based System Configuaration (SYSCON) access
Date:   Thu, 18 Jun 2020 09:02:23 +0100
Message-Id: <20200618080223.951737-1-lee.jones@linaro.org>
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
Changelog:

v2 => v3
  - Change 'is CONFIG' present check to include loadable modules
    - s/#ifdef CONFIG_MFD_SYSCON_I2C/#if IS_ENABLED(CONFIG_MFD_SYSCON_I2C)/

v1 => v2
  - Remove legacy references to OF
  - Allow building as a module (fixes h8300 0-day issue)

drivers/mfd/Kconfig            |  7 +++
 drivers/mfd/Makefile           |  1 +
 drivers/mfd/syscon-i2c.c       | 90 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/syscon-i2c.h | 26 ++++++++++
 4 files changed, 124 insertions(+)
 create mode 100644 drivers/mfd/syscon-i2c.c
 create mode 100644 include/linux/mfd/syscon-i2c.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 0a59249198d34..f25f80f68edca 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1300,6 +1300,13 @@ config MFD_SYSCON
 	  Select this option to enable accessing system control registers
 	  via regmap.
 
+config MFD_SYSCON_I2C
+	tristate "System Controller Register R/W Based on I2C Regmap"
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
index 0000000000000..be20ff45ece07
--- /dev/null
+++ b/drivers/mfd/syscon-i2c.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * System Control Driver accessed over I2C
+ *
+ * Copyright (C) 2020 Linaro Ltd.
+ *
+ * Author: Lee Jones <lee.jones@linaro.org>
+ */
+
+#include <linux/device.h>
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
+	struct device *dev;
+	struct regmap *regmap;
+	struct list_head list;
+};
+
+static const struct regmap_config syscon_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static struct syscon *syscon_i2c_register(struct i2c_client *client)
+{
+	struct regmap_config syscon_config = syscon_i2c_regmap_config;
+	struct device *dev = &client->dev;
+	struct syscon *syscon;
+	struct regmap *regmap;
+	int ret;
+
+	syscon = devm_kzalloc(dev, sizeof(*syscon), GFP_KERNEL);
+	if (!syscon)
+		return ERR_PTR(-ENOMEM);
+
+	syscon_config.name = dev_name(dev);
+
+	regmap = devm_regmap_init_i2c(client, &syscon_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to initialise Regmap I2C\n");
+		ret = PTR_ERR(regmap);
+		return ERR_PTR(ret);
+	}
+
+	syscon->regmap = regmap;
+	syscon->dev = dev;
+
+	spin_lock(&syscon_i2c_list_slock);
+	list_add_tail(&syscon->list, &syscon_i2c_list);
+	spin_unlock(&syscon_i2c_list_slock);
+
+	return syscon;
+}
+
+static struct regmap *syscon_i2c_get_regmap(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct syscon *entry, *syscon = NULL;
+
+	spin_lock(&syscon_i2c_list_slock);
+
+	list_for_each_entry(entry, &syscon_i2c_list, list)
+		if (entry->dev == dev) {
+			syscon = entry;
+			break;
+		}
+
+	spin_unlock(&syscon_i2c_list_slock);
+
+	if (!syscon)
+		syscon = syscon_i2c_register(client);
+
+	if (IS_ERR(syscon))
+		return ERR_CAST(syscon);
+
+	return syscon->regmap;
+}
+
+struct regmap *syscon_i2c_to_regmap(struct i2c_client *client)
+{
+	return syscon_i2c_get_regmap(client);
+}
+EXPORT_SYMBOL_GPL(syscon_i2c_to_regmap);
diff --git a/include/linux/mfd/syscon-i2c.h b/include/linux/mfd/syscon-i2c.h
new file mode 100644
index 0000000000000..490bc37b603cb
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
+#if IS_ENABLED(CONFIG_MFD_SYSCON_I2C)
+extern struct regmap *syscon_i2c_to_regmap(struct i2c_client *client);
+#else
+static inline struct regmap *syscon_i2c_to_regmap(struct i2c_client *client)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+#endif
+
+#endif /* __LINUX_MFD_SYSCON_I2C_H__ */
-- 
2.25.1

