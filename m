Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849D6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610A2208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgATMKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:10:40 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:61402 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgATMKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:10:37 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: wVsjwRgYxpoPCNjz6v3XOvB01tWs8LM3U99MWnquZPnbuZLqcyOXSinwP+kZeHPJp4dGOMI4Ri
 PI/uSZokNUu3RPbJ8uD9EFNh8IqClgHbljsGwVnGOIsycVt6m+qTXQnnSGnBIbFBqLZgW0+JR5
 3V3I/M16waWaRoFGzVXHdtRjVBGIzzJpzv66ehzF8bhD8JppW4PX9BzgzoGPK9AxsV8afiosAb
 LvTCAsqRoORfahdykU8L1mnIHIH+G/PZwJDfp2ulBbWyz9xl15YzregYQ/EsptDQYYoz6JuwZE
 Jb0=
X-IronPort-AV: E=Sophos;i="5.70,341,1574146800"; 
   d="scan'208";a="61577379"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2020 05:10:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Jan 2020 05:10:36 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Mon, 20 Jan 2020 05:10:33 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux@armlinux.org.uk>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 7/8] ARM: at91: pm: add plla disable/enable support for sam9x60
Date:   Mon, 20 Jan 2020 14:10:07 +0200
Message-ID: <1579522208-19523-8-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579522208-19523-1-git-send-email-claudiu.beznea@microchip.com>
References: <1579522208-19523-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PLLA enable/disable support for SAM9X60.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 117 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 113 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index c898071e0c0b..4e9eb4f57f16 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -18,6 +18,7 @@
 pmc	.req	r0
 tmp1	.req	r4
 tmp2	.req	r5
+tmp3	.req	r6
 
 /*
  * Wait until master clock is ready (after switching master clock source)
@@ -331,6 +332,61 @@ ENDPROC(at91_backup_mode)
 
 .macro at91_plla_disable
 	/* Save PLLA setting and disable it */
+	ldr	tmp1, .pmc_version
+	cmp	tmp1, #AT91_PMC_V1
+	beq	1f
+
+#ifdef CONFIG_SOC_SAM9X60
+	/* Save PLLA settings. */
+	ldr	tmp2, [pmc, #AT91_PMC_PLL_UPDT]
+	bic	tmp2, tmp2, #AT91_PMC_PLL_UPDT_ID
+	str	tmp2, [pmc, #AT91_PMC_PLL_UPDT]
+
+	/* save div. */
+	mov	tmp1, #0
+	ldr	tmp2, [pmc, #AT91_PMC_PLL_CTRL0]
+	bic	tmp2, tmp2, #0xffffff00
+	orr	tmp1, tmp1, tmp2
+
+	/* save mul. */
+	ldr	tmp2, [pmc, #AT91_PMC_PLL_CTRL1]
+	bic	tmp2, tmp2, #0xffffff
+	orr	tmp1, tmp1, tmp2
+	str	tmp1, .saved_pllar
+
+	/* step 2. */
+	ldr	tmp1, [pmc, #AT91_PMC_PLL_UPDT]
+	bic	tmp1, tmp1, #AT91_PMC_PLL_UPDT_UPDATE
+	bic	tmp1, tmp1, #AT91_PMC_PLL_UPDT_ID
+	str	tmp1, [pmc, #AT91_PMC_PLL_UPDT]
+
+	/* step 3. */
+	ldr	tmp1, [pmc, #AT91_PMC_PLL_CTRL0]
+	bic	tmp1, tmp1, #AT91_PMC_PLL_CTRL0_ENPLLCK
+	orr	tmp1, tmp1, #AT91_PMC_PLL_CTRL0_ENPLL
+	str	tmp1, [pmc, #AT91_PMC_PLL_CTRL0]
+
+	/* step 4. */
+	ldr	tmp1, [pmc, #AT91_PMC_PLL_UPDT]
+	orr	tmp1, tmp1, #AT91_PMC_PLL_UPDT_UPDATE
+	bic	tmp1, tmp1, #AT91_PMC_PLL_UPDT_ID
+	str	tmp1, [pmc, #AT91_PMC_PLL_UPDT]
+
+	/* step 5. */
+	ldr	tmp1, [pmc, #AT91_PMC_PLL_CTRL0]
+	bic	tmp1, tmp1, #AT91_PMC_PLL_CTRL0_ENPLL
+	str	tmp1, [pmc, #AT91_PMC_PLL_CTRL0]
+
+	/* step 7. */
+	ldr	tmp1, [pmc, #AT91_PMC_PLL_UPDT]
+	orr	tmp1, tmp1, #AT91_PMC_PLL_UPDT_UPDATE
+	bic	tmp1, tmp1, #AT91_PMC_PLL_UPDT_ID
+	str	tmp1, [pmc, #AT91_PMC_PLL_UPDT]
+
+	b	2f
+#endif
+
+1:	/* Save PLLA setting and disable it */
 	ldr	tmp1, [pmc, #AT91_CKGR_PLLAR]
 	str	tmp1, .saved_pllar
 
@@ -338,17 +394,70 @@ ENDPROC(at91_backup_mode)
 	mov	tmp1, #AT91_PMC_PLLCOUNT
 	orr	tmp1, tmp1, #(1 << 29)		/* bit 29 always set */
 	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
+2:
 .endm
 
 .macro at91_plla_enable
+	ldr	tmp2, .saved_pllar
+	ldr	tmp3, .pmc_version
+	cmp	tmp3, #AT91_PMC_V1
+	beq	4f
+
+#ifdef CONFIG_SOC_SAM9X60
+	/* step 1. */
+	ldr	tmp1, [pmc, #AT91_PMC_PLL_UPDT]
+	bic	tmp1, tmp1, #AT91_PMC_PLL_UPDT_ID
+	bic	tmp1, tmp1, #AT91_PMC_PLL_UPDT_UPDATE
+	str	tmp1, [pmc, #AT91_PMC_PLL_UPDT]
+
+	/* step 2. */
+	ldr	tmp1, =#AT91_PMC_PLL_ACR_DEFAULT_PLLA
+	str	tmp1, [pmc, #AT91_PMC_PLL_ACR]
+
+	/* step 3. */
+	ldr	tmp1, [pmc, #AT91_PMC_PLL_CTRL1]
+	mov	tmp3, tmp2
+	bic	tmp3, tmp3, #0xffffff
+	orr	tmp1, tmp1, tmp3
+	str	tmp1, [pmc, #AT91_PMC_PLL_CTRL1]
+
+	/* step 8. */
+	ldr	tmp1, [pmc, #AT91_PMC_PLL_UPDT]
+	bic	tmp1, tmp1, #AT91_PMC_PLL_UPDT_ID
+	orr	tmp1, tmp1, #AT91_PMC_PLL_UPDT_UPDATE
+	str	tmp1, [pmc, #AT91_PMC_PLL_UPDT]
+
+	/* step 9. */
+	ldr	tmp1, [pmc, #AT91_PMC_PLL_CTRL0]
+	orr	tmp1, tmp1, #AT91_PMC_PLL_CTRL0_ENLOCK
+	orr	tmp1, tmp1, #AT91_PMC_PLL_CTRL0_ENPLL
+	orr	tmp1, tmp1, #AT91_PMC_PLL_CTRL0_ENPLLCK
+	bic	tmp1, tmp1, #0xff
+	mov	tmp3, tmp2
+	bic	tmp3, tmp3, #0xffffff00
+	orr	tmp1, tmp1, tmp3
+	str	tmp1, [pmc, #AT91_PMC_PLL_CTRL0]
+
+	/* step 10. */
+	ldr	tmp1, [pmc, #AT91_PMC_PLL_UPDT]
+	orr	tmp1, tmp1, #AT91_PMC_PLL_UPDT_UPDATE
+	bic	tmp1, tmp1, #AT91_PMC_PLL_UPDT_ID
+	str	tmp1, [pmc, #AT91_PMC_PLL_UPDT]
+
+	/* step 11. */
+3:	ldr	tmp1, [pmc, #AT91_PMC_PLL_ISR0]
+	tst	tmp1, #0x1
+	beq	3b
+	b	2f
+#endif
+
 	/* Restore PLLA setting */
-	ldr	tmp1, .saved_pllar
-	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
+4:	str	tmp2, [pmc, #AT91_CKGR_PLLAR]
 
 	/* Enable PLLA. */
-	tst	tmp1, #(AT91_PMC_MUL &  0xff0000)
+	tst	tmp2, #(AT91_PMC_MUL &  0xff0000)
 	bne	1f
-	tst	tmp1, #(AT91_PMC_MUL & ~0xff0000)
+	tst	tmp2, #(AT91_PMC_MUL & ~0xff0000)
 	beq	2f
 
 1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
-- 
2.7.4

