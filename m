Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4079C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8FD22522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgAUKiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:38:24 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:38378 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgAUKh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:37:28 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id sydS210075USYZQ06ydSnr; Tue, 21 Jan 2020 11:37:26 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquU-00011A-12; Tue, 21 Jan 2020 11:37:26 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itquT-0000Tq-W8; Tue, 21 Jan 2020 11:37:25 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Oleksij Rempel <linux@rempel-privat.de>
Subject: [PATCH 03/20] ARM: asm9260: Drop unneeded select of GENERIC_CLOCKEVENTS
Date:   Tue, 21 Jan 2020 11:37:05 +0100
Message-Id: <20200121103722.1781-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121103722.1781-1-geert+renesas@glider.be>
References: <20200121103413.1337-1-geert+renesas@glider.be>
 <20200121103722.1781-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for the Alphascale ASM9260 platform depends on ARCH_MULTI_V5,
and thus on ARCH_MULTIPLATFORM.
As the latter selects GENERIC_CLOCKEVENTS, there is no need for
MACH_ASM9260 to select GENERIC_CLOCKEVENTS.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Oleksij Rempel <linux@rempel-privat.de>
---
All patches in this series are independent of each other.
Cover letter at https://lore.kernel.org/r/20200121103413.1337-1-geert+renesas@glider.be

 arch/arm/mach-asm9260/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-asm9260/Kconfig b/arch/arm/mach-asm9260/Kconfig
index e42dbaa53bc61b20..a2e1d0aaf2529aa5 100644
--- a/arch/arm/mach-asm9260/Kconfig
+++ b/arch/arm/mach-asm9260/Kconfig
@@ -4,6 +4,5 @@ config MACH_ASM9260
 	depends on ARCH_MULTI_V5
 	select CPU_ARM926T
 	select ASM9260_TIMER
-	select GENERIC_CLOCKEVENTS
 	help
 	  Support for Alphascale ASM9260 based platform.
-- 
2.17.1

