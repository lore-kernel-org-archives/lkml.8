Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941E8C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DC0206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729723AbgDHPwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:52:37 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:36507 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729566AbgDHPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:52:37 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MYeV1-1jr9s91kW3-00Vl5c; Wed, 08 Apr 2020 17:52:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     arm@kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tejas Patel <tejas.patel@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: soc: xilinx: fix firmware driver Kconfig dependency
Date:   Wed,  8 Apr 2020 17:52:15 +0200
Message-Id: <20200408155224.2070880-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WnjyOpiNcLqQfztyx9N69btLQ1WKhu518Y0sT2WFdNsAQVcG0gG
 +IMpFcx90FHUdlOpsHgSVLr574kD3T7BW03gP4LYceY0fi7mYgDuYJsQGxdnQ2E9JGEfLEK
 hh9CvkPa6lrQzLhokD32H4hYGay0r/s77OdAcc1JFvWyebr/8s3Z62+Bv23wOJPfI9iOsug
 ii3pAoqKFen8X3+6EJ2lA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6/D6tFvb3o8=:BjFJsKWkbiLT1YWPE3bzRs
 gIhFPk/emEX0msq3g2zWyG6wkAU/79WFC5RAUVg/Unhq1EFBSRNeyHFweoKljV8Nu4zqeXHLi
 jQaA0y532dIewP8G1MwId7H5q9w26Aq50rxe1XZkZSjcG8+EvB5cWk4PF9QMOFOq2w+H39jSL
 Cb5J8h/cJo6AweK9ZW6vn9L2Gp6hyICtQD7Lg9glVkQEHucsmDc/1KPI4yo0biO6ZGd/mTGvw
 zh5BcBtMZIGllV2cCCO2fWsY7AJX1J8b4+ZN25QX3uZxa1iUpqd1Ky8/JshdOiJ3ZxbKbRD+m
 c+xtDTAF6BMpnAvxGWVKCdWwozIJBpUL6/vm3WZJx7an9CQyA0ltd5nIZb/6FibNvc0swBXrL
 ngYkjY1tzx3rlw2zqxjJrZOORlylM7zmEYnGphRXTO9Xkx+KiU/4z5sIj66Lt6mlzJyz1MyBo
 vpcIFIPHS4apIqCC7aZaCSYLObjcPf4Ta4MVxeItrIwHsIp+r8MkZC0hlW/MsxpuXM4/P0Rr/
 FVNpv/vuDlOwTwWE5iuoI3HWNVynB8A35s82x5ffxoIn6OheAuF7bnq3pzhAuwUQGqdMqgcXL
 gnKkTxhKLFhbxqGbZPnv4JdQ710pRJxZPS33Y23/KmQ4tYmF6WCPmFjqwYhNEkxs/LR6NvB9M
 9+0CAkNM7zURfB5KhTR/97FjzRXvhed3xoRMOI83NRpfWxe6P2iEV2TTN6nyrMNmX+lZpQk7l
 ygGBqN8GxwwZfxgYQmth7oRi9pvSe4YNZHexXAmScn2KcCVdzNcPNqJKuXWGf97yY0+63sFGb
 LLKfwquH1WytWDO2G/DbQBfD1NBPFGM3IiQDOma0WlCNPqQ/Tk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The firmware driver is optional, but the power driver depends on it,
which needs to be reflected in Kconfig to avoid link errors:

aarch64-linux-ld: drivers/soc/xilinx/zynqmp_power.o: in function `zynqmp_pm_isr':
zynqmp_power.c:(.text+0x284): undefined reference to `zynqmp_pm_invoke_fn'

The firmware driver can probably be allowed for compile-testing as
well, so it's best to drop the dependency on the ZYNQ platform
here and allow building as long as the firmware code is built-in.

Fixes: ab272643d723 ("drivers: soc: xilinx: Add ZynqMP PM driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/xilinx/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 223f1f9d0922..646512d7276f 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -19,7 +19,7 @@ config XILINX_VCU
 
 config ZYNQMP_POWER
 	bool "Enable Xilinx Zynq MPSoC Power Management driver"
-	depends on PM && ARCH_ZYNQMP
+	depends on PM && ZYNQMP_FIRMWARE
 	default y
 	select MAILBOX
 	select ZYNQMP_IPI_MBOX
@@ -35,7 +35,7 @@ config ZYNQMP_POWER
 config ZYNQMP_PM_DOMAINS
 	bool "Enable Zynq MPSoC generic PM domains"
 	default y
-	depends on PM && ARCH_ZYNQMP && ZYNQMP_FIRMWARE
+	depends on PM && ZYNQMP_FIRMWARE
 	select PM_GENERIC_DOMAINS
 	help
 	  Say yes to enable device power management through PM domains
-- 
2.26.0

