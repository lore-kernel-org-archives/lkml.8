Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83FBC10F28
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B076C208C3
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 16:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCHQcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 12:32:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:44876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgCHQcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 12:32:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4F375B01F;
        Sun,  8 Mar 2020 16:32:46 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Wells=20Lu=20=E5=91=82=E8=8A=B3=E9=A8=B0?= 
        <wells.lu@sunplus.com>, Dvorkin Dmitry <dvorkin@tibbo.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Russell King <linux@armlinux.org.uk>
Subject: [RFC 03/11] ARM: Prepare Sunplus Plus1 SoC family
Date:   Sun,  8 Mar 2020 17:32:21 +0100
Message-Id: <20200308163230.4002-4-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200308163230.4002-1-afaerber@suse.de>
References: <20200308163230.4002-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/arm/Kconfig              |  2 ++
 arch/arm/Makefile             |  1 +
 arch/arm/mach-sunplus/Kconfig | 10 ++++++++++
 3 files changed, 13 insertions(+)
 create mode 100644 arch/arm/mach-sunplus/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1dcc64bd3621..f946140952b6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -722,6 +722,8 @@ source "arch/arm/mach-sti/Kconfig"
 
 source "arch/arm/mach-stm32/Kconfig"
 
+source "arch/arm/mach-sunplus/Kconfig"
+
 source "arch/arm/mach-sunxi/Kconfig"
 
 source "arch/arm/mach-tango/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 9397fe766b31..f050eca6b3b6 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -158,6 +158,7 @@ textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
 textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
 textofs-$(CONFIG_ARCH_MESON) := 0x00208000
 textofs-$(CONFIG_ARCH_AXXIA) := 0x00308000
+textofs-$(CONFIG_ARCH_SUNPLUS) := 0x00308000
 
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
diff --git a/arch/arm/mach-sunplus/Kconfig b/arch/arm/mach-sunplus/Kconfig
new file mode 100644
index 000000000000..c20b338e50c8
--- /dev/null
+++ b/arch/arm/mach-sunplus/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+menuconfig ARCH_SUNPLUS
+	bool "Sunplus SoCs"
+	depends on ARCH_MULTI_V7
+	select ARM_GIC
+	select ARM_GLOBAL_TIMER
+	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
+	select GENERIC_IRQ_CHIP
+	help
+	  This enables support for the Sunplus Plus1 (SP7021) SoC family.
-- 
2.16.4

