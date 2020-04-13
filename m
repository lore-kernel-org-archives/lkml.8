Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3B8C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:14:06 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF4120735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7y1bs+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF4120735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgDMGOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 02:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgDMGOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 02:14:03 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA93C0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 23:14:02 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n24so325681plp.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 23:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=lwW9dDHboCKlwty3GK0oBbeC2zYSo6LldkhEtYkcgDM=;
        b=g7y1bs+BFxl81E84mu1n/MJ/hbN3SNQaxrh4Hfg8oyQJ71yxSAn2PL5f+REf6pjCRm
         QoC1IRJwAma0lavJVbSj8eD7nb+Z0P6bgLtMCexrSmeojZkNvtYU2qhipQ/PO2leUZ3I
         VWlFtuS5bkBpXuKX8fdNmW7X3DoYZ8W5Z5/U80Q8qTjyNRvpNW8JrkcH1sNFcdQRIoOd
         Yjxu7WueKR+BZKiHdieCNeH38ILT349Ah60DKdzQjPEsdOx2gXy8HGVm7TCgZks+08uk
         kUQgkgbllinaeoEYsbwGPyVWOvcvFKoyjdD9FfNzAHJHmzj5tjka//fbMoiBFimLY49E
         mG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=lwW9dDHboCKlwty3GK0oBbeC2zYSo6LldkhEtYkcgDM=;
        b=Wq92G/yqnHKJoKnIvDs6WFvDJ4fc8qM0stq1T6UTDajBOAGwPBAx8DvFnKydL8MOOF
         wILcm1igRuwv1AqPmzB+WcRoSjRh5hiKhHg5eSAyYaKwa3T88xWHycWJmAxLTTh/9m/G
         G1YM8fd4TMVFtvlZHixY7kKGkBuduCe8+51R4nR4f7LW5NSuIJ2OCXUycb0014AAlK/r
         LsICuxKTX+25AVweUbh6jxm7cyWWI8jm8gN06UhuUXGR6XYwpwumRw9LrcTXLhSyivzI
         xmSUzjyrPwbASyrsaNSBx26R9cjXhNMncJaECSY25Z8xqzFe4JZwKWqsoioZNknX4qNy
         hT4g==
X-Gm-Message-State: AGi0PuYPZFg3+7AgMfZCss6TsbaTGSxw2lFQBQRMlffAGW+vPbMyi8Uh
        ytzLglAMSeVmcBJRa4hqIxU=
X-Google-Smtp-Source: APiQypIDtWYZGzVQBXG6hKaoTe8SA/lCU1E00DKCRq5BjOV2IquAw6vDL4yTUAe/Tf/CD2tDd5ox5A==
X-Received: by 2002:a17:902:6503:: with SMTP id b3mr6797296plk.20.1586758441630;
        Sun, 12 Apr 2020 23:14:01 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.19])
        by smtp.gmail.com with ESMTPSA id w5sm7712645pfw.154.2020.04.12.23.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 23:14:01 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org, arnd@arndb.de, broonie@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/3] soc: sprd: Add Spreadtrum special bits updating support
Date:   Mon, 13 Apr 2020 14:13:21 +0800
Message-Id: <ca403b816af38eae68ca7399640c82d0345a2296.1586757922.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1586757922.git.baolin.wang7@gmail.com>
References: <cover.1586757922.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1586757922.git.baolin.wang7@gmail.com>
References: <cover.1586757922.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spreadtrum platform uses a special set/clear method to update
registers' bits, which can remove the race of updating the global
registers between the multiple subsystems. Thus we can register
a physical regmap bus into syscon core to support this.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/soc/Kconfig            |  1 +
 drivers/soc/Makefile           |  1 +
 drivers/soc/sprd/Kconfig       | 16 +++++++
 drivers/soc/sprd/Makefile      |  2 +
 drivers/soc/sprd/sprd_syscon.c | 76 ++++++++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+)
 create mode 100644 drivers/soc/sprd/Kconfig
 create mode 100644 drivers/soc/sprd/Makefile
 create mode 100644 drivers/soc/sprd/sprd_syscon.c

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 425ab6f7e375..8cfbf2dc518d 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -23,5 +23,6 @@ source "drivers/soc/versatile/Kconfig"
 source "drivers/soc/xilinx/Kconfig"
 source "drivers/soc/zte/Kconfig"
 source "drivers/soc/kendryte/Kconfig"
+source "drivers/soc/sprd/Kconfig"
 
 endmenu
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 36452bed86ef..7d156a6dd536 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -29,3 +29,4 @@ obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
 obj-y				+= xilinx/
 obj-$(CONFIG_ARCH_ZX)		+= zte/
 obj-$(CONFIG_SOC_KENDRYTE)	+= kendryte/
+obj-$(CONFIG_ARCH_SPRD)		+= sprd/
diff --git a/drivers/soc/sprd/Kconfig b/drivers/soc/sprd/Kconfig
new file mode 100644
index 000000000000..38d1f5971a28
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
index 000000000000..4d7715553cf6
--- /dev/null
+++ b/drivers/soc/sprd/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SPRD_SYSCON) += sprd_syscon.o
diff --git a/drivers/soc/sprd/sprd_syscon.c b/drivers/soc/sprd/sprd_syscon.c
new file mode 100644
index 000000000000..0cfd43afeaff
--- /dev/null
+++ b/drivers/soc/sprd/sprd_syscon.c
@@ -0,0 +1,76 @@
+//SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Spreadtrum Communications Inc.
+ */
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
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
+static int sprd_syscon_read(void *context, unsigned int reg, unsigned int *val)
+{
+	void __iomem *base = context;
+
+	*val = readl(base + reg);
+	return 0;
+}
+
+static int sprd_syscon_write(void *context, unsigned int reg, unsigned int val)
+{
+	void __iomem *base = context;
+
+	writel(val, base + reg);
+	return 0;
+}
+
+static struct regmap_bus sprd_syscon_regmap = {
+	.fast_io = true,
+	.reg_write = sprd_syscon_write,
+	.reg_read = sprd_syscon_read,
+	.reg_update_bits = sprd_syscon_update_bits,
+	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
+};
+
+static int sprd_syscon_init(void)
+{
+	syscon_register_phys_regmap_bus(&sprd_syscon_regmap);
+
+	return 0;
+}
+core_initcall_sync(sprd_syscon_init);
+
+MODULE_DESCRIPTION("Spreadtrum syscon support");
+MODULE_AUTHOR("Baolin Wang <baolin.wang@unisoc.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

