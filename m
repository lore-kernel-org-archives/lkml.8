Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40723C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A8224673
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgAUKh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:37:28 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:58112 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbgAUKh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:37:27 -0500
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id sydS2100j5USYZQ01ydSpa; Tue, 21 Jan 2020 11:37:26 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquU-00011a-AX; Tue, 21 Jan 2020 11:37:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquU-0000UI-9Q; Tue, 21 Jan 2020 11:37:26 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 12/20] ARM: meson: Drop unneeded select of COMMON_CLK
Date:   Tue, 21 Jan 2020 11:37:14 +0100
Message-Id: <20200121103722.1781-12-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121103722.1781-1-geert+renesas@glider.be>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for Amlogic Meson SoCs depends on ARCH_MULTI_V7, and thus on
ARCH_MULTIPLATFORM.
As the latter selects COMMON_CLK, there is no need for ARCH_MESON to
select COMMON_CLK.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic@lists.infradead.org
---
All patches in this series are independent of each other.
Cover letter at https://lore.kernel.org/r/20200121103413.1337-1-geert+renesas@glider.be

 arch/arm/mach-meson/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 01f0f4b765e00c98..75034fe197e3be0d 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -9,7 +9,6 @@ menuconfig ARCH_MESON
 	select CACHE_L2X0
 	select PINCTRL
 	select PINCTRL_MESON
-	select COMMON_CLK
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 
-- 
2.17.1

