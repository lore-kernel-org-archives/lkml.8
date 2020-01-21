Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FA7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7138E22522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgAUKh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:37:28 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:38472 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbgAUKh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:37:27 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id sydS210185USYZQ06ydSoE; Tue, 21 Jan 2020 11:37:26 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquU-00011w-GD; Tue, 21 Jan 2020 11:37:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquU-0000Ud-F0; Tue, 21 Jan 2020 11:37:26 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 19/20] ARM: s3c64xx: Drop unneeded select of TIMER_OF
Date:   Tue, 21 Jan 2020 11:37:21 +0100
Message-Id: <20200121103722.1781-19-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121103722.1781-1-geert+renesas@glider.be>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for Samsung S3C64XX systems depends on ARCH_MULTI_V6, and thus
on ARCH_MULTIPLATFORM.
As the latter selects TIMER_OF, there is no need for MACH_S3C64XX_DT to
select TIMER_OF.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org
---
All patches in this series are independent of each other.
Cover letter at https://lore.kernel.org/r/20200121103413.1337-1-geert+renesas@glider.be

 arch/arm/mach-s3c64xx/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 5700822e3c74b8e4..ac3e3563487fc6f9 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -336,7 +336,6 @@ config MACH_WLF_CRAGG_6410
 
 config MACH_S3C64XX_DT
 	bool "Samsung S3C6400/S3C6410 machine using Device Tree"
-	select TIMER_OF
 	select CPU_S3C6400
 	select CPU_S3C6410
 	select PINCTRL
-- 
2.17.1

