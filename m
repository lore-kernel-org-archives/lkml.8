Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4198BC2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8AE20757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tyq9CXmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgDII6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:58:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45069 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgDII6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:58:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id w11so516355pga.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 01:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=F0ACReDDXyB1e3rDm9tW2ll6mYCnGmbPCAy1ftlmerU=;
        b=Tyq9CXmqBwPpBB85O0EL/PpIkIK83jQRajU9LLThG/fQ7jCqLfeKIWUYufwkue4iYe
         wE7eo4PelA4pYuPjGv32Cj51Kj61/yC/bvP1H2JxlBLmnuthevgMEb3+7sKwtPP07wWb
         KT104WI1wT69I0wi70SG7VDQvxk1kDVfNYoet0gi/0zQDErt0L6qW8fRw0RLFpBgqQzo
         gIQjHnBJspaHfRMBumWJl8AX10YG8+bn7krw6j806yERHIsHmD0chNV8I0MVsPh1S891
         diM2cB/eDTo/aaII2ieCuGenav8mi3qNiesSwCQrHiLX+3Lw8gDxfHZdEM0DQDzZ8/6a
         He8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=F0ACReDDXyB1e3rDm9tW2ll6mYCnGmbPCAy1ftlmerU=;
        b=nyTAl3qFXoorMdRcKxCExfVwWnD14aoyYdiX8ryh29waaLz6HzM4jbXzj+nvPXZ7FI
         tvw/gw3C86GVlZPm/Ek0ZxtHXp9sz0YvSz8NhB4c3sQsQ6/rPWPItDaUUE2To3VfbODq
         gXu1bhBnuVNI+S0D5kYjAWXZwq8osvOwsxuZdWxvLcwQK6id+qs/X9vRnRLMpm3PpH8/
         0smUi+LcmaWg6NPomecNfyqMbdSYpHsT7VMtQc87nbf9C5ZQ9hgJwgxTxqS6ayKJrymM
         nqI6S3VwJsjoFfNAgvpPHjRes6+dld9eEBUYviqy2a1B8Z33MOZe/LWU/rmRlThJRxF1
         x3LQ==
X-Gm-Message-State: AGi0PuYoNd85Wd2JdH7BsMTC+gSfGjF+liH4ucBkrj+BnXvp33EJLmo0
        SOr4r5u5KQK13qmSb/baYYY=
X-Google-Smtp-Source: APiQypLrXqd8YDLICbl0unqbo3zgagVzPQmnCL5ybOdzS7ZysyLk50HJ/t0TvJgQE9tSYAb+DBRWIA==
X-Received: by 2002:a62:3888:: with SMTP id f130mr11821952pfa.141.1586422703960;
        Thu, 09 Apr 2020 01:58:23 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id s9sm1561712pjr.5.2020.04.09.01.58.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 01:58:23 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org, arnd@arndb.de, broonie@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] soc: sprd: Add Spreadtrum special bits updating support
Date:   Thu,  9 Apr 2020 16:57:59 +0800
Message-Id: <5abbab3c8c6a85c63e534a600190369b3539f016.1586422035.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1586422035.git.baolin.wang7@gmail.com>
References: <cover.1586422035.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1586422035.git.baolin.wang7@gmail.com>
References: <cover.1586422035.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spreadtrum platform uses a special set/clear method to update
registers' bits, which can remove the race of updating the global
registers between the multiple subsystems.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/soc/Kconfig            |  1 +
 drivers/soc/Makefile           |  1 +
 drivers/soc/sprd/Kconfig       | 16 +++++++++++++
 drivers/soc/sprd/Makefile      |  2 ++
 drivers/soc/sprd/sprd_syscon.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 71 insertions(+)
 create mode 100644 drivers/soc/sprd/Kconfig
 create mode 100644 drivers/soc/sprd/Makefile
 create mode 100644 drivers/soc/sprd/sprd_syscon.c

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 1778f8c..a19cead 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -22,5 +22,6 @@ source "drivers/soc/ux500/Kconfig"
 source "drivers/soc/versatile/Kconfig"
 source "drivers/soc/xilinx/Kconfig"
 source "drivers/soc/zte/Kconfig"
+source "drivers/soc/sprd/Kconfig"
 
 endmenu
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index a39f17c..e3f6b1c 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_ARCH_U8500)	+= ux500/
 obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
 obj-y				+= xilinx/
 obj-$(CONFIG_ARCH_ZX)		+= zte/
+obj-$(CONFIG_ARCH_SPRD)		+= sprd/
diff --git a/drivers/soc/sprd/Kconfig b/drivers/soc/sprd/Kconfig
new file mode 100644
index 0000000..38d1f59
--- /dev/null
+++ b/drivers/soc/sprd/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# SPRD SoC drivers
+#
+
+menu "Spreadtrum SoC drivers"
+	depends on ARCH_SPRD || COMPILE_TEST
+
+config SPRD_SYSCON
+	tristate "Spreadtrum syscon support"
+	depends on ARCH_SPRD || COMPILE_TEST
+	help
+	  Say yes here to add support for the Spreadtrum syscon driver,
+	  which is used to implement the atomic method of bits updating.
+
+endmenu
diff --git a/drivers/soc/sprd/Makefile b/drivers/soc/sprd/Makefile
new file mode 100644
index 0000000..4d77155
--- /dev/null
+++ b/drivers/soc/sprd/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SPRD_SYSCON) += sprd_syscon.o
diff --git a/drivers/soc/sprd/sprd_syscon.c b/drivers/soc/sprd/sprd_syscon.c
new file mode 100644
index 0000000..00acf88
--- /dev/null
+++ b/drivers/soc/sprd/sprd_syscon.c
@@ -0,0 +1,51 @@
+//SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Spreadtrum Communications Inc.
+ */
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+
+#define SPRD_REG_SET_OFFSET	0x1000
+#define SPRD_REG_CLR_OFFSET	0x2000
+
+/*
+ * The Spreadtrum platform defines a special set/clear method to update
+ * registers' bits, which means it can write values to the register's SET
+ * address (offset is 0x1000) to set bits, and write values to the register's
+ * CLEAR address (offset is 0x2000) to clear bits.
+ *
+ * This set/clear method can help to remove the race of accessing the global
+ * registers between the multiple subsystems instead of using hardware
+ * spinlocks.
+ */
+static int sprd_syscon_update_bits(void *context, unsigned int reg,
+				   unsigned int mask, unsigned int val)
+{
+	void __iomem *base = context;
+	unsigned int set, clr;
+
+	set = val & mask;
+	clr = ~set & mask;
+
+	if (set)
+		writel(set, base + reg + SPRD_REG_SET_OFFSET);
+
+	if (clr)
+		writel(clr, base + reg + SPRD_REG_CLR_OFFSET);
+
+	return 0;
+}
+
+static int sprd_syscon_init(void)
+{
+	syscon_register_reg_update_bits(sprd_syscon_update_bits);
+
+	return 0;
+}
+core_initcall_sync(sprd_syscon_init);
+
+MODULE_DESCRIPTION("Spreadtrum syscon support");
+MODULE_AUTHOR("Baolin Wang <baolin.wang@unisoc.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

