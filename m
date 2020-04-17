Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1412C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 02:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5B2206B9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 02:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilrt8gFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgDQCOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 22:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728969AbgDQCOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 22:14:39 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC45C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 19:14:39 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b7so432901pju.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 19:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=8lQbH9bvSHqIQuui1LMcY8pJQ+re2UQkl+EFgIIzuRs=;
        b=ilrt8gFSDWzI3miTnsVe0HkjJPZ56GPGHvH+gfmUDuHG3EzVZiaDQ6NQjWVuaIq8+3
         wcGeAwFsQoQdp146gV5DoQuk4tuYqNhEHSqJs5mvD8bJMfXa2SHmlokmhS+mwmzmCnxP
         VuqnQ11k/oLpQdqwmZSnpoMP05yT606IfZNjTmLMhkl542yyZbcXxh5rrS51mNjsoQUx
         l31J0Mm3RIfn+slz8bhOgJ9/nehdcuWbhdwZdBM+6R1q28sLa9cioYOLSGEImcRUO643
         DAy2LnAoMHlVSxLgaU+NcRHk7yKN6kpCgsZ/AUpze2xuLQFyyWMhDMcIi8C2beO/ajS3
         f6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=8lQbH9bvSHqIQuui1LMcY8pJQ+re2UQkl+EFgIIzuRs=;
        b=eO56rBvOwLALBoCtYM8vnrkMiYkvBXZ1/nKu7q7U4t/V0WnhDFG0MWLa+a6rqwoK/6
         WS33p2y1dqV9ezF8zTUCVgxOimbkhc4ezlW8VK+dU+XX4isFfHJ1HAIX6hkZjl3OiemT
         7k1JRmiFqGR5oqC8TjmZxuFndoSuEgShvXTMnrCxEQMAj+BTbU6VuilWLCHs4ubZxyI8
         OtAY6mEpe0vTAC3g50OqkWk3HkmTNQCrfZYN2VgJB+YSy8ka2TBxC6l4N5ltBn0mLmjq
         ZJI+MULH5/uBXJ3+Akqbq7qG5NYZueIYg27yOnhjcMUiC3FJSsajmYFFMBMMAPkVDo4N
         +ONw==
X-Gm-Message-State: AGi0PuZQEzFw39wd4GbS1fz1kcKKUR76meqk6GInl38SHOX10Pdirn7Q
        JNbl4NI7T8IDE9o0KkbzGoY=
X-Google-Smtp-Source: APiQypKLP8hftkIKQ3QXOAaGEmsNY47eJ8TcFwrIDUR9CslPjW6SVi51D5NSCFP4SitRkAMPkntfMQ==
X-Received: by 2002:a17:902:a60d:: with SMTP id u13mr1215497plq.113.1587089678822;
        Thu, 16 Apr 2020 19:14:38 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.129])
        by smtp.gmail.com with ESMTPSA id h11sm18035319pfn.125.2020.04.16.19.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 19:14:38 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org, arnd@arndb.de, broonie@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] soc: sprd: Add Spreadtrum special bits updating support
Date:   Fri, 17 Apr 2020 10:14:15 +0800
Message-Id: <dad648071fd163140f6534295cfce76562003b5a.1587088646.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1587088646.git.baolin.wang7@gmail.com>
References: <cover.1587088646.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1587088646.git.baolin.wang7@gmail.com>
References: <cover.1587088646.git.baolin.wang7@gmail.com>
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
 drivers/soc/sprd/sprd_syscon.c | 82 ++++++++++++++++++++++++++++++++++
 5 files changed, 102 insertions(+)
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
index 000000000000..9b98127f1adb
--- /dev/null
+++ b/drivers/soc/sprd/sprd_syscon.c
@@ -0,0 +1,82 @@
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
+ *
+ * Note: there is a potential risk when users want to set and clear bits
+ * at the same time, since the set/clear method will always do bits setting
+ * before bits clearing, which may cause some unexpected results if the
+ * operation sequence is strict. Thus we recommend that do not set and
+ * clear bits at the same time if you are not sure the results.
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

