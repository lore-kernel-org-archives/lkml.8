Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAE8C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF4D2064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200490;
	bh=UPItCjmuo8SP4QHmFAW1NxhRC4SPqP7urVkVKQ4r+5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MRoJdaoq30LEuVtNIVYJRrDGUHJ5x8AZsgg7BEqapRhXCbIymcIi8lqTS4IHP4NVf
	 tcokPhLKWqRAyGV2b0uNykiBNSoB17LgOwwHSSxA/SPOAsCeYSWJh2/Ds+4oN52eKf
	 y7b4am7uWM8nGiERQRZR5wWfgbUenPuhiy1j+Ffk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392668AbgAPSsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:48:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389765AbgAPRJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:09:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E64FB2081E;
        Thu, 16 Jan 2020 17:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194591;
        bh=UPItCjmuo8SP4QHmFAW1NxhRC4SPqP7urVkVKQ4r+5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cRVrXFiRwPptZ6TDJZLDKVWUB6igv8gwBavagG5brF4rhrABcVHoHaZm9pCSu/gEh
         0udCxi1F+M9TCso/Mt4bceJ+dwHwm4oRAn95DHvpkejmKqfOBUPblu0BmXq+pYeOKt
         b3Wn34tVMcUFiQ/Wgu0Mg32gaA8GKSGemHO6iwRY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH AUTOSEL 4.19 462/671] ARM: stm32: use "depends on" instead of "if" after prompt
Date:   Thu, 16 Jan 2020 12:01:40 -0500
Message-Id: <20200116170509.12787-199-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 7e8a0f10899075ac2665c78c4e49dbaf32bf3346 ]

This appeared after the global fixups by commit e32465429490 ("ARM: use
"depends on" for SoC configs instead of "if" after prompt"). Fix it now.

Link: https://lore.kernel.org/r/20190710051320.8738-1-yamada.masahiro@socionext.com
Fixes: e32465429490 ("ARM: use "depends on" for SoC configs instead of "if" after prompt")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-stm32/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 713c068b953f..adca4368d67c 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -1,5 +1,6 @@
 menuconfig ARCH_STM32
-	bool "STMicroelectronics STM32 family" if ARM_SINGLE_ARMV7M || ARCH_MULTI_V7
+	bool "STMicroelectronics STM32 family"
+	depends on ARM_SINGLE_ARMV7M || ARCH_MULTI_V7
 	select ARMV7M_SYSTICK if ARM_SINGLE_ARMV7M
 	select HAVE_ARM_ARCH_TIMER if ARCH_MULTI_V7
 	select ARM_GIC if ARCH_MULTI_V7
-- 
2.20.1

