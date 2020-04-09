Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8B4C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0C02082D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586414696;
	bh=J+GeXfiCzFFO7mDslriUKKDucExeUS2dHChanjrxLIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Opzya3A5LOnLRrooL0XCtKpA+13bPJt67MzvDc2Xw9dRfpgRQDH3qD6gDIq9J6BJt
	 54gCpefuCbb+8s3hvUaoXLuzjAaahZHjlOL6RXQaPruwOCazruAZjHZnkFvpdgXsGE
	 OEIXxo4/47s/rasDDOuGs8hCQtz9TB+tYlltjfPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgDIGoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:44:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDIGoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:44:19 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05BB420B1F;
        Thu,  9 Apr 2020 06:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586414659;
        bh=J+GeXfiCzFFO7mDslriUKKDucExeUS2dHChanjrxLIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gisbdcRg0Zj7k1O4uKiNFoKUUSGs0uWX4AC/Xk372PjhTEF+AThaoex5uMHlonZei
         1MHWLxJ5pa8o3Pl2Lgg/sd2U1xeXRNNwEmZ6m9A4gRfCvzq9DX6h1GeS+D9OKgguGU
         cfFC/r9lX7PvbeFkRHq9hsP3k2SBBl8q7tc179tA=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Tony Prisk <linux@prisktech.co.nz>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 02/10] ARM: Remove redundant CLKDEV_LOOKUP selects
Date:   Wed,  8 Apr 2020 23:44:08 -0700
Message-Id: <20200409064416.83340-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200409064416.83340-1-sboyd@kernel.org>
References: <20200409064416.83340-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These platforms select COMMON_CLK indirectly through use of the
ARCH_MULTIPLATFORM config option that they depend on implicitly via some
V7/V6/V5 multi platform config option. The COMMON_CLK config option
already selects CLKDEV_LOOKUP so it's redundant to have this selected
again.

Cc: Tony Prisk <linux@prisktech.co.nz>
Cc: Russell King <linux@armlinux.org.uk>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 arch/arm/Kconfig             | 3 ---
 arch/arm/mach-vt8500/Kconfig | 1 -
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 97864aabc2a6..eeabdc5a3dd2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -435,7 +435,6 @@ config ARCH_PXA
 	select ARM_CPU_SUSPEND if PM
 	select AUTO_ZRELADDR
 	select COMMON_CLK
-	select CLKDEV_LOOKUP
 	select CLKSRC_PXA
 	select CLKSRC_MMIO
 	select TIMER_OF
@@ -474,7 +473,6 @@ config ARCH_SA1100
 	bool "SA1100-based"
 	select ARCH_MTD_XIP
 	select ARCH_SPARSEMEM_ENABLE
-	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select CLKSRC_PXA
 	select TIMER_OF if OF
@@ -495,7 +493,6 @@ config ARCH_SA1100
 config ARCH_S3C24XX
 	bool "Samsung S3C24XX SoCs"
 	select ATAGS
-	select CLKDEV_LOOKUP
 	select CLKSRC_SAMSUNG_PWM
 	select GENERIC_CLOCKEVENTS
 	select GPIO_SAMSUNG
diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
index 8841199058ea..d01cdd9ad9c7 100644
--- a/arch/arm/mach-vt8500/Kconfig
+++ b/arch/arm/mach-vt8500/Kconfig
@@ -2,7 +2,6 @@
 config ARCH_VT8500
 	bool
 	select GPIOLIB
-	select CLKDEV_LOOKUP
 	select VT8500_TIMER
 	select PINCTRL
 	help
-- 
Sent by a computer, using git, on the internet

