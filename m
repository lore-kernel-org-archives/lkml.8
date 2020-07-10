Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17976C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D480D20775
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="F92s58MV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgGJJqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgGJJqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:46:20 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6E0C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:46:20 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so2326050pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/qLCTDKT97RegvoxMjbs2u6kPwgi/lEYfy74zNQUpW4=;
        b=F92s58MVcvj2/M3PBmKtwrBVjCHSxph92nRpbBoF4l0jZJpDJ8SvoWZhI6eYKYGtBN
         sw5FEC21Ww4vbWB+isXpupV+LDVgti9yiIBEk9B/sK1DWOkIxyfuURk/oL8BPjt/upc1
         TjqEqYhHmAwfLgG7CUsIemIFUFQDctVGasDSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/qLCTDKT97RegvoxMjbs2u6kPwgi/lEYfy74zNQUpW4=;
        b=DME8nDzpJkX3Q0bmZxhGkUhe7Hxp/ULVvYwPec/EFg+PtZFrBPLo88Zy3d29j9ETnZ
         yifNMASIu/xmlweBN7Swr9kQS4FMcHKxdNC+oNGV6iin4r6/CLrEJGw9rX/6grDHPnzQ
         TFsUnQIyWr3nz1Tbar0qcKE0bBKEtFzun45ue/eeveuJXT6lfNjOaPgW3tLAmZuY14Lq
         VqT158cV+vPfmo7TUbK6f7TUk5UDujCo/ORMFCgzL7LEGP9wAxH8cOfXxXwGaSfJ8/xU
         MP0mHE0hFWEgEjU9dXwbXEdnO+F1kGGuzjLlpkouGR4QlWjiGvZJ3ea6WbBM0LSwGNUP
         HaZw==
X-Gm-Message-State: AOAM5323VzgbGd7uwUVhVeost+MH0AXM0JgRZ/x0xMDb6dZabmIXBEV2
        4BDprBRRMweJpFVIivkWsW1MhQ==
X-Google-Smtp-Source: ABdhPJwmVXaJGMLUEHD5XIjxT6Jj/59NuCvK8+O+kAoA8tOD5UeRok7zK0QPPLTFizLcesaQSScBeQ==
X-Received: by 2002:a63:fc59:: with SMTP id r25mr34393986pgk.336.1594374380085;
        Fri, 10 Jul 2020 02:46:20 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id z9sm5133213pgh.94.2020.07.10.02.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 02:46:19 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux@armlinux.org.uk, arnd@arndb.de,
        afaerber@suse.de, maz@kernel.org, w@1wt.eu,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v5 06/12] ARM: mstar: Add machine for MStar/Sigmastar Armv7 SoCs
Date:   Fri, 10 Jul 2020 18:45:38 +0900
Message-Id: <20200710094544.430258-7-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710094544.430258-1-daniel@0x0f.com>
References: <20200710094544.430258-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the MStar/Sigmastar Armv7 based IP camera
and dashcam SoCs.

These chips are interesting in that they contain a Cortex-A7,
peripherals and system memory in a single tiny QFN package that
can be hand soldered allowing almost anyone to embed Linux
in their projects.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 MAINTAINERS                   |  1 +
 arch/arm/Kconfig              |  2 +
 arch/arm/Makefile             |  1 +
 arch/arm/mach-mstar/Kconfig   | 26 ++++++++++++
 arch/arm/mach-mstar/Makefile  |  1 +
 arch/arm/mach-mstar/mstarv7.c | 80 +++++++++++++++++++++++++++++++++++
 6 files changed, 111 insertions(+)
 create mode 100644 arch/arm/mach-mstar/Kconfig
 create mode 100644 arch/arm/mach-mstar/Makefile
 create mode 100644 arch/arm/mach-mstar/mstarv7.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 96110ee8a41c..e433847a7446 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2123,6 +2123,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://linux-chenxing.org/
 F:	Documentation/devicetree/bindings/arm/mstar.yaml
+F:	arch/arm/mach-mstar/
 
 ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
 M:	Michael Petchkovsky <mkpetch@internode.on.net>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2ac74904a3ce..d54c413ad937 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -668,6 +668,8 @@ source "arch/arm/mach-mmp/Kconfig"
 
 source "arch/arm/mach-moxart/Kconfig"
 
+source "arch/arm/mach-mstar/Kconfig"
+
 source "arch/arm/mach-mv78xx0/Kconfig"
 
 source "arch/arm/mach-mvebu/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 59fde2d598d8..e7f4ca060c0f 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -197,6 +197,7 @@ machine-$(CONFIG_ARCH_MXC)		+= imx
 machine-$(CONFIG_ARCH_MEDIATEK)		+= mediatek
 machine-$(CONFIG_ARCH_MILBEAUT)		+= milbeaut
 machine-$(CONFIG_ARCH_MXS)		+= mxs
+machine-$(CONFIG_ARCH_MSTARV7)		+= mstar
 machine-$(CONFIG_ARCH_NOMADIK)		+= nomadik
 machine-$(CONFIG_ARCH_NPCM)		+= npcm
 machine-$(CONFIG_ARCH_NSPIRE)		+= nspire
diff --git a/arch/arm/mach-mstar/Kconfig b/arch/arm/mach-mstar/Kconfig
new file mode 100644
index 000000000000..52744fe32368
--- /dev/null
+++ b/arch/arm/mach-mstar/Kconfig
@@ -0,0 +1,26 @@
+menuconfig ARCH_MSTARV7
+	bool "MStar/Sigmastar Armv7 SoC Support"
+	depends on ARCH_MULTI_V7
+	select ARM_GIC
+	select ARM_HEAVY_MB
+	help
+	  Support for newer MStar/Sigmastar SoC families that are
+	  based on Armv7 cores like the Cortex A7 and share the same
+	  basic hardware like the infinity and mercury series.
+
+if ARCH_MSTARV7
+
+config MACH_INFINITY
+	bool "MStar/Sigmastar infinity SoC support"
+	default ARCH_MSTARV7
+	help
+	  Support for MStar/Sigmastar infinity IP camera SoCs.
+
+config MACH_MERCURY
+	bool "MStar/Sigmastar mercury SoC support"
+	default ARCH_MSTARV7
+	help
+	  Support for MStar/Sigmastar mercury dash camera SoCs.
+	  Note that older Mercury2 SoCs are ARM9 based and not supported.
+
+endif
diff --git a/arch/arm/mach-mstar/Makefile b/arch/arm/mach-mstar/Makefile
new file mode 100644
index 000000000000..93b0391ede7e
--- /dev/null
+++ b/arch/arm/mach-mstar/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_ARCH_MSTARV7) += mstarv7.o
diff --git a/arch/arm/mach-mstar/mstarv7.c b/arch/arm/mach-mstar/mstarv7.c
new file mode 100644
index 000000000000..81a4cbcab206
--- /dev/null
+++ b/arch/arm/mach-mstar/mstarv7.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree support for MStar/Sigmastar Armv7 SoCs
+ *
+ * Copyright (c) 2020 thingy.jp
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include <linux/init.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+
+/*
+ * In the u-boot code the area these registers are in is
+ * called "L3 bridge" and there are register descriptions
+ * for something in the same area called "AXI".
+ *
+ * It's not exactly known what this is but the vendor code
+ * for both u-boot and linux share calls to "flush the miu pipe".
+ * This seems to be to force pending CPU writes to memory so that
+ * the state is right before DMA capable devices try to read
+ * descriptors and data the CPU has prepared. Without doing this
+ * ethernet doesn't work reliably for example.
+ */
+
+#define MSTARV7_L3BRIDGE_FLUSH		0x14
+#define MSTARV7_L3BRIDGE_STATUS		0x40
+#define MSTARV7_L3BRIDGE_FLUSH_TRIGGER	BIT(0)
+#define MSTARV7_L3BRIDGE_STATUS_DONE	BIT(12)
+
+static void __iomem *l3bridge;
+
+static const char * const mstarv7_board_dt_compat[] __initconst = {
+	"mstar,infinity",
+	"mstar,infinity3",
+	"mstar,mercury5",
+	NULL,
+};
+
+/*
+ * This may need locking to deal with situations where an interrupt
+ * happens while we are in here and mb() gets called by the interrupt handler.
+ *
+ * The vendor code did have a spin lock but it doesn't seem to be needed and
+ * removing it hasn't caused any side effects so far.
+ *
+ * [writel|readl]_relaxed have to be used here because otherwise
+ * we'd end up right back in here.
+ */
+static void mstarv7_mb(void)
+{
+	/* toggle the flush miu pipe fire bit */
+	writel_relaxed(0, l3bridge + MSTARV7_L3BRIDGE_FLUSH);
+	writel_relaxed(MSTARV7_L3BRIDGE_FLUSH_TRIGGER, l3bridge
+			+ MSTARV7_L3BRIDGE_FLUSH);
+	while (!(readl_relaxed(l3bridge + MSTARV7_L3BRIDGE_STATUS)
+			& MSTARV7_L3BRIDGE_STATUS_DONE)) {
+		/* wait for flush to complete */
+	}
+}
+
+static void __init mstarv7_init(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "mstar,l3bridge");
+	l3bridge = of_iomap(np, 0);
+	if (l3bridge)
+		soc_mb = mstarv7_mb;
+	else
+		pr_warn("Failed to install memory barrier, DMA will be broken!\n");
+}
+
+DT_MACHINE_START(MSTARV7_DT, "MStar/Sigmastar Armv7 (Device Tree)")
+	.dt_compat	= mstarv7_board_dt_compat,
+	.init_machine	= mstarv7_init,
+MACHINE_END
-- 
2.27.0

