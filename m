Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C09B6C2BA18
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 02:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E6D2076E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 02:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586055087;
	bh=I7W7FJME/6CvgaEZ/xEBHMa5YsA6VclfpczMDvsnz5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AQIcbtFbEd9ZB2oNnhPVJITikAW3epqwOKOoMv4YS3Qg4JcTQVC+EaSl9trJmJU1A
	 MYk/W2v54aWIf+yy1b3lUKT4T2m8uMoZEYkoAXwraDanP+A+Kr8joFtCKQU6A3EARm
	 Q0LflJW6tjw91pwV6rMzJ4dHwFlhGvcNaQ9bSPWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgDECv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 22:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgDECv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 22:51:26 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 183AC20737;
        Sun,  5 Apr 2020 02:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586055085;
        bh=I7W7FJME/6CvgaEZ/xEBHMa5YsA6VclfpczMDvsnz5o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=peuxm+CkX3K/skuYFDcioLXovQjHlR2QlAIXU56fgsPztuSb+KxbXOoj+V5JNPrYs
         wDFLY5oW/f6CO517XXnFFVlL3wrx/ssib11FJlb1w1tKNeJEIhcD/GhdQqIXXxizrC
         JWVOYvc09R0IY9t8Tt/jdc0lpYuvszE9Bfj0V1lE=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Shiyan <shc_work@mail.ru>,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/9] ARM: Remove redundant COMMON_CLK selects
Date:   Sat,  4 Apr 2020 19:51:15 -0700
Message-Id: <20200405025123.154688-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200405025123.154688-1-sboyd@kernel.org>
References: <20200405025123.154688-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mulitplatform config already selects COMMON_CLK, so selecting it
again is not useful. Remove these selects from ARM platforms that are
part of the multiplatform build.

Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Lubomir Rintel <lkundrak@v3.sk>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/arm/mach-actions/Kconfig  | 1 -
 arch/arm/mach-clps711x/Kconfig | 1 -
 arch/arm/mach-mmp/Kconfig      | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/mach-actions/Kconfig b/arch/arm/mach-actions/Kconfig
index b5e0ac965ec0..00fb4babccdd 100644
--- a/arch/arm/mach-actions/Kconfig
+++ b/arch/arm/mach-actions/Kconfig
@@ -7,7 +7,6 @@ menuconfig ARCH_ACTIONS
 	select ARM_GLOBAL_TIMER
 	select CACHE_L2X0
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-	select COMMON_CLK
 	select GENERIC_IRQ_CHIP
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index fc9188b54dd6..ba497a2032e9 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -5,7 +5,6 @@ menuconfig ARCH_CLPS711X
 	select AUTO_ZRELADDR
 	select TIMER_OF
 	select CLPS711X_TIMER
-	select COMMON_CLK
 	select CPU_ARM720T
 	select GENERIC_CLOCKEVENTS
 	select GPIOLIB
diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index b58a03b18bde..6fe1550f43ec 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -110,7 +110,6 @@ config MACH_MMP_DT
 	depends on ARCH_MULTI_V5
 	select PINCTRL
 	select PINCTRL_SINGLE
-	select COMMON_CLK
 	select ARCH_HAS_RESET_CONTROLLER
 	select CPU_MOHAWK
 	help
-- 
Sent by a computer, using git, on the internet

