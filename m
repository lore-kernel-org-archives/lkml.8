Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2D4C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BAA020675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbgEEPHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729900AbgEEPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:07:32 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0402C03C1A6
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:07:31 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:bd97:8453:3b10:1832])
        by baptiste.telenet-ops.be with bizsmtp
        id b37T2200X3VwRR30137Td9; Tue, 05 May 2020 17:07:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzAN-00027w-KX; Tue, 05 May 2020 17:07:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzAN-0000QS-JV; Tue, 05 May 2020 17:07:27 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 02/15] ARM: actions: Drop unneeded select of COMMON_CLK
Date:   Tue,  5 May 2020 17:07:09 +0200
Message-Id: <20200505150722.1575-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505150722.1575-1-geert+renesas@glider.be>
References: <20200505150722.1575-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for Actions Semi SoCs depends on ARCH_MULTI_V7, and thus on
ARCH_MULTIPLATFORM.
As the latter selects COMMON_CLK, there is no need for ARCH_ACTIONS to
select COMMON_CLK.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Andreas Färber <afaerber@suse.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Andreas Färber <afaerber@suse.de>
---
v2:
  - Add Acked-by, Reviewed-by.
---
 arch/arm/mach-actions/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-actions/Kconfig b/arch/arm/mach-actions/Kconfig
index b5e0ac965ec0dd10..00fb4babccdd991b 100644
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
-- 
2.17.1

