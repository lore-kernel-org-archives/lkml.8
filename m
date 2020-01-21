Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1259C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD0E024653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgAUKGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:06:16 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:55668 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbgAUKGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:06:15 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id sy6A210035USYZQ01y6ANN; Tue, 21 Jan 2020 11:06:13 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itqQE-0000UK-24; Tue, 21 Jan 2020 11:06:10 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1itqQD-0008ON-Vk; Tue, 21 Jan 2020 11:06:10 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: arch timer: Drop unneeded select GENERIC_CLOCKEVENTS
Date:   Tue, 21 Jan 2020 11:06:08 +0100
Message-Id: <20200121100608.32218-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM Architected timer is available on ARMv7 SoCs only.
As both ARCH_MULTIPLATFORM and ARM_SINGLE_ARMV7M select
GENERIC_CLOCKEVENTS, there is no need for HAVE_ARM_ARCH_TIMER to select
GENERIC_CLOCKEVENTS.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 96dab76da3b3962b..ea3ed263d3f50bb4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1246,7 +1246,6 @@ config HAVE_ARM_ARCH_TIMER
 	bool "Architected timer support"
 	depends on CPU_V7
 	select ARM_ARCH_TIMER
-	select GENERIC_CLOCKEVENTS
 	help
 	  This option enables support for the ARM architected timer
 
-- 
2.17.1

