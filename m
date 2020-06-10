Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50FBC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73544206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="frMZKx1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgFJJId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgFJJIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:08:31 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1E4C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:08:30 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h95so634999pje.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XOjL5XtgGbA93LVXomVtFgXOXm6Sr4M6mhaTD4RYsdI=;
        b=frMZKx1zv7obfvNtum4jhtV0Zl8C3nq/5TTIvpc/k+m/mPSk8gfeEBItV5bgEu4aG5
         hg0NKtGIEhweeyzJyb3yGUcFWvfC42/6MSHR1A673/wGxIAWUTCPhWNMnlkYgg1nq96v
         pd5ftocL7i6T30U0WdZeqRUaXn+W9U3uKwhAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XOjL5XtgGbA93LVXomVtFgXOXm6Sr4M6mhaTD4RYsdI=;
        b=W0J3O//0t9j9TiQzMCXnNuSCr8jgNqnaYQDeGtA5e7NOljxuwV9XVwzcIlChs2qMh/
         6MkidhAeAEKHzeJCYygAhmDWe2PFM+giZ9PFzAt8GWOkVRECn61fwzDTGWdCpSvEdgaw
         DMJej9dfoDyvdN2VpajXDx/ce+F5TAYfP19G4g6kb7lvD23d19yXrXGW07zBVsodn2LO
         fImqA1c3zL3fZHXq3rAiu+/XMVQPfkCR8+4dVtdQa3/jZTAJ++QR//F5Ae3yt67PvN6v
         nx8U+TWVV5Pm88jVY4QysK/GeP74X92Dr4RoG6owqji5yFuxRqdc4nGIsNYDp/+oaVk8
         bI+A==
X-Gm-Message-State: AOAM533x+I3FgOayjbjp7LlMZ5Rx5Wx/Lx2WNa4AtaqDLl75xt/I5ews
        0t2DzhOz2MxYkiI+iKhQ2mlKsg==
X-Google-Smtp-Source: ABdhPJxec3qRk8ln4bsEbxkkZaxgRovh7NcnXMmOcmS2Ud1ytTcW25fm/fPQRQh+rwhcM2Jpmh1Z3g==
X-Received: by 2002:a17:902:167:: with SMTP id 94mr2194778plb.170.1591780109501;
        Wed, 10 Jun 2020 02:08:29 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id nl8sm5191620pjb.13.2020.06.10.02.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 02:08:28 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
Cc:     k@japko.eu, tim.bird@sony.com, daniel@0x0f.com,
        devicetree@vger.kernel.org, Daniel Palmer <daniel@thingy.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Maxime Ripard <mripard@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Christian Lamparter <chunkeey@gmail.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] ARM: mstar: Add machine for MStar/Sigmastar infinity/mercury family ARMv7 SoCs
Date:   Wed, 10 Jun 2020 18:04:00 +0900
Message-Id: <20200610090421.3428945-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20191014061617.10296-2-daniel@0x0f.com>
References: <20191014061617.10296-2-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the MStar/Sigmastar infinity/mercury series of ARMv7
based IP camera and dashcam SoCs.

These chips are interesting in that they contain a Cortex A7,
peripherals and system memory in a single tiny QFN package that
can be hand soldered allowing almost anyone to embed Linux
in their projects.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 MAINTAINERS                   |  1 +
 arch/arm/Kconfig              |  2 +
 arch/arm/Makefile             |  1 +
 arch/arm/mach-mstar/Kconfig   | 26 +++++++++++++
 arch/arm/mach-mstar/Makefile  |  1 +
 arch/arm/mach-mstar/mstarv7.c | 72 +++++++++++++++++++++++++++++++++++
 6 files changed, 103 insertions(+)
 create mode 100644 arch/arm/mach-mstar/Kconfig
 create mode 100644 arch/arm/mach-mstar/Makefile
 create mode 100644 arch/arm/mach-mstar/mstarv7.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ca77f97b8ee..754521938303 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2114,6 +2114,7 @@ ARM/MStar/Sigmastar ARMv7 SoC support
 M:	Daniel Palmer <daniel@thingy.jp>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	arch/arm/mach-mstar/
 F:	Documentation/devicetree/bindings/arm/mstar.yaml
 
 ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fb6c85c5d344..e466694f8486 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -669,6 +669,8 @@ source "arch/arm/mach-mmp/Kconfig"
 
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
index 000000000000..6235d0a7860a
--- /dev/null
+++ b/arch/arm/mach-mstar/Kconfig
@@ -0,0 +1,26 @@
+menuconfig ARCH_MSTARV7
+	bool "MStar/Sigmastar ARMv7 SoC Support"
+	depends on ARCH_MULTI_V7
+	select ARM_GIC
+	select ARM_HEAVY_MB
+	help
+	  Support for newer MStar/Sigmastar SoC families that are
+	  based on ARMv7 cores like the Cortex A7 and share the same
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
index 000000000000..ee96ce46cbbc
--- /dev/null
+++ b/arch/arm/mach-mstar/mstarv7.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree support for MStar/Sigmastar ARMv7 SoCs
+ *
+ * Copyright (c) 2019 thingy.jp
+ * Author: Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include <linux/init.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <linux/of.h>
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
+#define MSTARV7_L3BRIDGE_FLUSH		0x1f204414
+#define MSTARV7_L3BRIDGE_STATUS		0x1f204440
+#define MSTARV7_L3BRIDGE_FLUSH_TRIGGER	BIT(0)
+#define MSTARV7_L3BRIDGE_STATUS_DONE	BIT(12)
+
+static u32 __iomem *miu_status;
+static u32 __iomem *miu_flush;
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
+ */
+static void mstarv7_mb(void)
+{
+	/* toggle the flush miu pipe fire bit */
+	writel_relaxed(0, miu_flush);
+	writel_relaxed(MSTARV7_L3BRIDGE_FLUSH_TRIGGER, miu_flush);
+	while (!(readl_relaxed(miu_status) & MSTARV7_L3BRIDGE_STATUS_DONE)) {
+		/* wait for flush to complete */
+	}
+}
+
+static void __init mstarv7_barriers_init(void)
+{
+	miu_flush = ioremap(MSTARV7_L3BRIDGE_FLUSH, sizeof(*miu_flush));
+	miu_status = ioremap(MSTARV7_L3BRIDGE_STATUS, sizeof(*miu_status));
+	soc_mb = mstarv7_mb;
+}
+
+static void __init mstarv7_init(void)
+{
+	mstarv7_barriers_init();
+}
+
+DT_MACHINE_START(MSTARV7_DT, "MStar/Sigmastar ARMv7 (Device Tree)")
+	.dt_compat	= mstarv7_board_dt_compat,
+	.init_machine	= mstarv7_init,
+MACHINE_END
-- 
2.27.0.rc0

