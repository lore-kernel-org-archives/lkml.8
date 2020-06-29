Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F486C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22646206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462738;
	bh=3ALKqSb//yNIIQlkl8NRcrYMmxqeQWP1nF4+ZNgu8uA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1alElWRqLDg2Nh/GLXUSLAMETdDH07ezjiAXI/TSuDtVc9E5dHeTmuvXGKI3LA6z0
	 JEm/HTkSvFOXPd9pIdemoLZkIOR5idiuENoBFoyhdlQd99VVlEK4OqmOSb+d+bYMyB
	 bQRMi2nJ+StZUEQIPE8BdHFVBbb8yazD6CGfwqIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389195AbgF2UcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:32:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732475AbgF2TZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B30625358;
        Mon, 29 Jun 2020 15:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445219;
        bh=3ALKqSb//yNIIQlkl8NRcrYMmxqeQWP1nF4+ZNgu8uA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XTs/Mp2RLBPEGm8OlqV0b9no7FybZXziCfnyS0BEG4X4ZBumFjjvI70bKuGsx/7rz
         WuFb4RjOqgi+xEWAHUqmWjmCGOTv3rV0dCgNvaYjM3TQ/0kzjIWhfcTHsozNkB4jMu
         YbNeS13pa9rsTaekcdou4tH9eIEJ6UB9tpzxu7TE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 007/191] ARM: integrator: Add some Kconfig selections
Date:   Mon, 29 Jun 2020 11:37:03 -0400
Message-Id: <20200629154007.2495120-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629154007.2495120-1-sashal@kernel.org>
References: <20200629154007.2495120-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
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

