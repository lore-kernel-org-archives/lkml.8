Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C521C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280142082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgBLKIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:08:45 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:55146 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbgBLKIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:08:43 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id 1m8Y2200Y5USYZQ06m8YgU; Wed, 12 Feb 2020 11:08:41 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1owa-0001EU-LN; Wed, 12 Feb 2020 11:08:32 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j1owa-0000MF-JR; Wed, 12 Feb 2020 11:08:32 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Russell King <linux@armlinux.org.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Heiko Stuebner <heiko@sntech.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/7] ARM: mmp: Replace <linux/clk-provider.h> by <linux/of_clk.h>
Date:   Wed, 12 Feb 2020 11:08:26 +0100
Message-Id: <20200212100830.446-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200212100830.446-1-geert+renesas@glider.be>
References: <20200212100830.446-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Marvell MMP platform code is not a clock provider, and just needs to
call of_clk_init().

Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-mmp/mmp-dt.c  | 2 +-
 arch/arm/mach-mmp/mmp2-dt.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp-dt.c b/arch/arm/mach-mmp/mmp-dt.c
index 91214996acecc9fb..3f43c0867dcae4ed 100644
--- a/arch/arm/mach-mmp/mmp-dt.c
+++ b/arch/arm/mach-mmp/mmp-dt.c
@@ -8,7 +8,7 @@
 
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
-#include <linux/clk-provider.h>
+#include <linux/of_clk.h>
 #include <linux/clocksource.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
diff --git a/arch/arm/mach-mmp/mmp2-dt.c b/arch/arm/mach-mmp/mmp2-dt.c
index 510c762ddc484c40..34a5fe4b3949167e 100644
--- a/arch/arm/mach-mmp/mmp2-dt.c
+++ b/arch/arm/mach-mmp/mmp2-dt.c
@@ -9,7 +9,7 @@
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/of_platform.h>
-#include <linux/clk-provider.h>
+#include <linux/of_clk.h>
 #include <linux/clocksource.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
-- 
2.17.1

