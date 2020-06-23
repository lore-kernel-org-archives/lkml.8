Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C978CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9755820738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947363;
	bh=Su3a4FMJKqxjEDGcxDd9SXYLpEOQqK4yUuCllM+3hWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ArZgTJs+kzgH0b30ZaujKiyIKFcSXOUSWal9dyFpFmyY7PtGcF27h1QyZe8+VQ+1M
	 eBPbFhBTZM2JH4SxahGZzLBtP+mHcHOSexSiYRg2RKNvmigQo99gD27rMSmDnJ9SJD
	 2roLVYvj1b3fnsGFsFyxSvxRZt1js7aUNmLoU3ng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390070AbgFWUVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390042AbgFWUVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:21:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B28942070E;
        Tue, 23 Jun 2020 20:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943691;
        bh=Su3a4FMJKqxjEDGcxDd9SXYLpEOQqK4yUuCllM+3hWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqM+8rhv644yXnOB1pNJVx+RtBuKcg3FUWQaRfYsMUHtSeaXajAptCHI8jvkAbzDn
         PPIo9zYO9nD0EdDjxp38qNAFfClv1MsjrdnSD00oc4kBSNUthnf/4BdRfmp7iB4w07
         jJb0fkSe3FMTRJTUTBZ3Wc19Hgz3HP/faOJCS2pk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 013/314] ARM: integrator: Add some Kconfig selections
Date:   Tue, 23 Jun 2020 21:53:28 +0200
Message-Id: <20200623195339.420762343@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
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
index 982eabc361635..2406cab73835a 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -4,6 +4,8 @@ menuconfig ARCH_INTEGRATOR
 	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V6
 	select ARM_AMBA
 	select COMMON_CLK_VERSATILE
+	select CMA
+	select DMA_CMA
 	select HAVE_TCM
 	select ICST
 	select MFD_SYSCON
@@ -35,14 +37,13 @@ config INTEGRATOR_IMPD1
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



