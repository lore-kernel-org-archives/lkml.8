Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E973BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 10:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6F32074D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 10:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2EwnWXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgEPKNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 06:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725853AbgEPKNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 06:13:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020DCC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 03:13:13 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id a13so429417pls.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 03:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=RQl1P4szH3kWTsTLG3CehhmmEmneaN+4ongdk+HLtbg=;
        b=a2EwnWXumzWFmtjiRec8COutadGxoC7GElipdSq2ttNFhcFY6DyLown1YioJJQ/6F/
         Aqin+JUfJ9UeddHm1dk5mIeutirci5Deqay1ppaYyF9QOrYRbLpEwih3t9Et9+5T/ZYj
         uZXrA762bkNc9mvs39dEtB1/auY9Sfrh4Gh/7YJJaubH4t1WlFuQb8djlcggvduoK8fU
         YnX8vI9I/Glwz0+CWBdlv+CzovnF9IOmHJ0c1+To1Is1AObMBcI0xyWOHUZQRn8dsscC
         fLU1PC1u3muhNRCjF/JfuSeASVPdtG7vXvsOx7NW2YpZa1izpTG2iQwo7MUd37zVGFKP
         /3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=RQl1P4szH3kWTsTLG3CehhmmEmneaN+4ongdk+HLtbg=;
        b=rZIqgrCmCXoSFbswg/ss9xczVJtGJJ1xSIZ/zPZPxTmcL9o9yAcPVYDmMXjUEqdyOF
         P3k69++q1mexXRcgO4x+xa1FpF8bcjnjCuVwDgvj+/ondNQVhx/JNBZrLKsWpsD8q/Kp
         szi2Rfb/gw4YmN5Cbunkmx5B8h1z3jU2Rl3GPWKwlt1jx68fsTWbnu7PhaZbqPYCkzUa
         3FdOKk9jsjBAOtSs66KEbjUbWqY4+ESUnXRCXjNrY/juGa/mwbZpe4yCLxrHhNs6l6jq
         t9U1uadjzvPnNhAeW/HohTsh/HrNbVz3cb7ufIkH1vOxv0j2xW7dg0WIkNhqeMiTIyeQ
         5frA==
X-Gm-Message-State: AOAM533m4H6jyQ44At1gyRG0db+QC6v/gD5ryvjQwi/v0pJ8UUASSzaV
        zGFOw3F4LmFAaaeoYhAdEyg=
X-Google-Smtp-Source: ABdhPJwqdKBv2E6turNh0niOoJ7tBKxME+ejhQXiS4ohG17X0V1ylvzj0rQxcVsP3P9ERvI9/7O0lA==
X-Received: by 2002:a17:90a:4d07:: with SMTP id c7mr8746446pjg.70.1589623992546;
        Sat, 16 May 2020 03:13:12 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.16])
        by smtp.gmail.com with ESMTPSA id x10sm3554542pgr.65.2020.05.16.03.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2020 03:13:11 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org, arnd@arndb.de
Cc:     broonie@kernel.org, baolin.wang7@gmail.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] soc: sprd: Add Spreadtrum special bits updating support
Date:   Sat, 16 May 2020 18:12:29 +0800
Message-Id: <e0f4cafa36f6968fa1dcec48dedf11c6e247a851.1589623456.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1589623456.git.baolin.wang7@gmail.com>
References: <cover.1589623456.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1589623456.git.baolin.wang7@gmail.com>
References: <cover.1589623456.git.baolin.wang7@gmail.com>
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
 drivers/soc/sprd/sprd_syscon.c | 86 ++++++++++++++++++++++++++++++++++
 5 files changed, 106 insertions(+)
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
index 000000000000..cdc326ef94e5
--- /dev/null
+++ b/drivers/soc/sprd/sprd_syscon.c
@@ -0,0 +1,86 @@
+//SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Spreadtrum Communications Inc.
+ */
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
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
+ *
+ * Note: there is a potential risk when users want to set and clear bits
+ * at the same time, since the set/clear method will always do bits setting
+ * before bits clearing, which may cause some unexpected results if the
+ * operation sequence is strict. Thus we recommend that do not set and
+ * clear bits at the same time if you are not sure about the results.
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
+	WARN_ONCE(set && clr, "%s: non-atomic update", __func__);
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
+struct regmap *syscon_regmap_init(struct device_node *np, void __iomem *base,
+				  struct regmap_config *syscon_config)
+{
+	if (of_device_is_compatible(np, "sprd,atomic-syscon"))
+		return regmap_init(NULL, &sprd_syscon_regmap, base,
+				   syscon_config);
+
+	return regmap_init_mmio(NULL, base, syscon_config);
+}
+
+MODULE_DESCRIPTION("Spreadtrum syscon support");
+MODULE_AUTHOR("Baolin Wang <baolin.wang@unisoc.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

