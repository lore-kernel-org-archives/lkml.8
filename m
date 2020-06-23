Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631C2C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3953320663
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946482;
	bh=3ALKqSb//yNIIQlkl8NRcrYMmxqeQWP1nF4+ZNgu8uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2qaCNQTsuhIS7Y+GQbAO2xolluRLZvbVgJoQCAa0642MOBgNsiZngOZW1OEiDbvwp
	 1x6voqIB2GIdI0f5xJ0IdQmHrTwGWRXt0Qt2u0WHPQrdoZxqWoMmyk/rAZDwgCBHWi
	 fU83vNClDtpDAdFZaAmJiDaV/uSqvObTNSQvBxmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389775AbgFWUe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403811AbgFWUes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:34:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 344AB206C3;
        Tue, 23 Jun 2020 20:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944488;
        bh=3ALKqSb//yNIIQlkl8NRcrYMmxqeQWP1nF4+ZNgu8uA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0pAKK3x2JXlKBzUPGp4JnCEsW+qYvL70cIpqaodR6uKcO/ktDi9kSmrN5VQwhjWfD
         3raouc27LzrcI9weGfyEY5GHjfY/ZpZdYdt7w8OsTBHfxrxruz0i1oPlZfNL0huXVe
         xFWazA3EenaHuysSL3lYHd4bEgDlLTUm8Mw53928=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 010/206] ARM: integrator: Add some Kconfig selections
Date:   Tue, 23 Jun 2020 21:55:38 +0200
Message-Id: <20200623195317.453311970@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit d2854bbe5f5c4b4bec8061caf4f2e603d8819446 ]

The CMA and DMA_CMA Kconfig options need to be selected
by the Integrator in order to produce boot console on some
Integrator systems.

The REGULATOR and REGULATOR_FIXED_VOLTAGE need to be
selected in order to boot the system from an external
MMC card when using MMCI/PL181 from the device tree
probe path.

Select these things directly from the Kconfig so we are
sure to be able to bring the systems up with console
from any device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-integrator/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index cefe44f6889bd..ba124f8704fac 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -3,6 +3,8 @@ menuconfig ARCH_INTEGRATOR
 	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V6
 	select ARM_AMBA
 	select COMMON_CLK_VERSATILE
+	select CMA
+	select DMA_CMA
 	select HAVE_TCM
 	select ICST
 	select MFD_SYSCON
@@ -34,14 +36,13 @@ config INTEGRATOR_IMPD1
 	select ARM_VIC
 	select GPIO_PL061
 	select GPIOLIB
+	select REGULATOR
+	select REGULATOR_FIXED_VOLTAGE
 	help
 	  The IM-PD1 is an add-on logic module for the Integrator which
 	  allows ARM(R) Ltd PrimeCells to be developed and evaluated.
 	  The IM-PD1 can be found on the Integrator/PP2 platform.
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called impd1.
-
 config INTEGRATOR_CM7TDMI
 	bool "Integrator/CM7TDMI core module"
 	depends on ARCH_INTEGRATOR_AP
-- 
2.25.1



