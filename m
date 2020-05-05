Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05710C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F3D21655
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgEEPHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729910AbgEEPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:07:32 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0F0C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:07:32 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:bd97:8453:3b10:1832])
        by laurent.telenet-ops.be with bizsmtp
        id b37U220043VwRR30137UmL; Tue, 05 May 2020 17:07:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzAN-00028R-VI; Tue, 05 May 2020 17:07:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jVzAN-0000Qt-T7; Tue, 05 May 2020 17:07:27 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 10/15] ARM: mmp: Drop unneeded select of COMMON_CLK
Date:   Tue,  5 May 2020 17:07:17 +0200
Message-Id: <20200505150722.1575-11-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505150722.1575-1-geert+renesas@glider.be>
References: <20200505150722.1575-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for Marvell MMP ARMv5 platforms depends on ARCH_MULTI_V5, and
thus on ARCH_MULTIPLATFORM.
As the latter selects COMMON_CLK, there is no need for MACH_MMP_DT to
select COMMON_CLK.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Lubomir Rintel <lkundrak@v3.sk>
---
v2:
  - Add Acked-by.
---
 arch/arm/mach-mmp/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index b58a03b18bdef14c..6fe1550f43ec6aef 100644
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
2.17.1

