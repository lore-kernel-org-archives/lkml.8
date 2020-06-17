Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5438C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC6120C09
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 08:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TKxqhw0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgFQIlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 04:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFQIlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:41:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AC1C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 01:41:44 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so1367869wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZMa6DET1qb3XpdgoNbeTgpSZ2dO/+nB5dNSP35ZNe0=;
        b=TKxqhw0Jcu71I/x6Ep+yjYVaT07kQc900R6ef8apklQGlr/MjfDbo04wbE9kuS9Cs8
         57EVYUFjBEMJs+BftJD3oD4bxmDMsrh5gyA1oVaDpGOuqQYutoBDtVd98ZmIZrl8KLVS
         z2/nJ5Kxyz7UD3mz0+jGd3YNysk/lab3vq0tzi8GUmPCd6ZGcKjb/jyD3mHkprZZQd8l
         /xuKRurE3oGyxNB4dVClC0QgyePKySvFsF1NJwl0U5E/XNJyNnyiowKWt8Knn0umPoFp
         2Ib+0mEMgD8zSIQ/JWysGmWy9RncnoFwhJdvF79XKpEme2JIDlAn5mgjS0hpx5E+AIfg
         Opgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DZMa6DET1qb3XpdgoNbeTgpSZ2dO/+nB5dNSP35ZNe0=;
        b=CXd/EGDkbilF9t4dwAM2Ko+x8CcSNFh6IXXB1pus+6LNRFnhAfwxQjoNZGVt7Nukm0
         iD3H76VTbyv8sPIptoB6C9IjFBbskXm5L2d6LmQjeFbCH+otbB8xmNCxYBVOC0s+WFjS
         GQSsJ05EADkHYYyoHmN6xIfpyTMCTY+s8cZhmm8ALI5K/IUDKAple4GkgqZt73fnFjCe
         jSeXdXWKg4E8V4/cQgOezruy1ILmOgII8Fanege/0Pgk7C68zY71HmjqWDOm722NX+w5
         W/B/1OP4LmOmuJ0BRzjY7kdjKAdazbOAb9o/hUhMFU3UjutZtzX7oxH1wwAFxalKN1Ge
         8Hew==
X-Gm-Message-State: AOAM532CyVHqV2aAKwzx62BKeRkSL8TCwuNV/a/czvxY36a/VmuS/Cnl
        DRj3T6dJYF39VeeXadYwctDS7g==
X-Google-Smtp-Source: ABdhPJyDYeOK6KU2e/POLcV+YDEeExmRMQdYE6NEwAD8K3mAvZyIodfGhIDKQqOIPcb+xqzcx+am9w==
X-Received: by 2002:adf:9ccf:: with SMTP id h15mr7360121wre.275.1592383303080;
        Wed, 17 Jun 2020 01:41:43 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.65])
        by smtp.gmail.com with ESMTPSA id k14sm31635998wrq.97.2020.06.17.01.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 01:41:42 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     michael@walle.cc, robh+dt@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 1/1] mfd: Add I2C based System Configuaration (SYSCON) access
Date:   Wed, 17 Jun 2020 09:41:32 +0100
Message-Id: <20200617084132.704549-1-lee.jones@linaro.org>
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
Change log:

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
index 0000000000000..e9ded6a363234
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

