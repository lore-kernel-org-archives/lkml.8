Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024F8C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6B7624125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgAUKhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:37:32 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:33014 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbgAUKh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:37:29 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id sydS2100P5USYZQ01ydSJy; Tue, 21 Jan 2020 11:37:27 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquU-00011n-Du; Tue, 21 Jan 2020 11:37:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquU-0000UT-CZ; Tue, 21 Jan 2020 11:37:26 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: [PATCH 16/20] ARM: orion5x: Drop unneeded select of PCI_DOMAINS_GENERIC
Date:   Tue, 21 Jan 2020 11:37:18 +0100
Message-Id: <20200121103722.1781-16-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121103722.1781-1-geert+renesas@glider.be>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for Marvell Orion SoCs depends on ARCH_MULTI_V5, and thus on
ARCH_MULTIPLATFORM.
As the latter selects GENERIC_CLOCKEVENTS and USE_OF, there is no need
for ARCH_ORION5X and ARCH_ORION5X_DT to select any of them.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>
---
All patches in this series are independent of each other.
Cover letter at https://lore.kernel.org/r/20200121103413.1337-1-geert+renesas@glider.be

 arch/arm/mach-orion5x/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index cf9cb3d2590ec19b..e94a61901ffd86b4 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -3,7 +3,6 @@ menuconfig ARCH_ORION5X
 	bool "Marvell Orion"
 	depends on MMU && ARCH_MULTI_V5
 	select CPU_FEROCEON
-	select GENERIC_CLOCKEVENTS
 	select GPIOLIB
 	select MVEBU_MBUS
 	select FORCE_PCI
@@ -18,7 +17,6 @@ if ARCH_ORION5X
 
 config ARCH_ORION5X_DT
 	bool "Marvell Orion5x Flattened Device Tree"
-	select USE_OF
 	select ORION_CLK
 	select ORION_IRQCHIP
 	select ORION_TIMER
-- 
2.17.1

