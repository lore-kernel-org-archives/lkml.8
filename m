Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAF2C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B0820882
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgATMKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:10:23 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:63221 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgATMKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:10:21 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: z5Svyt4kryU+HvM3cYYLHgM64ZD5LyY8uzXwVJKsnPqWzm7wNX+zp8e3mTO178GmTWv28SDRsF
 wW+svgV3VJ0aYqrxsFAILV65iD1pali87MxCQQhrYep+ZrgNbwnDICHKU+SayuFWZeIzbHcwhL
 ZUNuPb7hrsAYzGFl1O3BI6JnNaPkJiX1m07oAWAekNgBiEazaVkP84emfA/bJUMgZYOdSOfHIk
 zQxki3bb9lsYtZC4x5kdEfao5XBjKQ9kf1PzLfwtcXha91D9xSIgj3pyBzfniamygyD9B0Ubtl
 0xY=
X-IronPort-AV: E=Sophos;i="5.70,341,1574146800"; 
   d="scan'208";a="62468535"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2020 05:10:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Jan 2020 05:10:20 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Mon, 20 Jan 2020 05:10:17 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux@armlinux.org.uk>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/8] Revert "ARM: at91: pm: do not disable/enable PLLA for ULP modes"
Date:   Mon, 20 Jan 2020 14:10:02 +0200
Message-ID: <1579522208-19523-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579522208-19523-1-git-send-email-claudiu.beznea@microchip.com>
References: <1579522208-19523-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 2725d70aa5138284ba2cebf0ef51dd23e0c9ea21
("ARM: at91: pm: do not disable/enable PLLA for ULP modes").
This is because PLLA is the clock source for CPU, PLLA should
be disabled/enabled in the final/first phase of suspend/resume
so that the power consumption in suspend/resume to be minimal
and suspend/resume time to be minimized.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm_suspend.S | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index 52b262d56cfd..bfb3aab8859e 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -47,6 +47,15 @@ tmp2	.req	r5
 	.endm
 
 /*
+ * Wait until PLLA has locked.
+ */
+	.macro wait_pllalock
+1:	ldr	tmp1, [pmc, #AT91_PMC_SR]
+	tst	tmp1, #AT91_PMC_LOCKA
+	beq	1b
+	.endm
+
+/*
  * Put the processor to enter the idle state
  */
 	.macro at91_cpu_idle
@@ -343,6 +352,14 @@ ENTRY(at91_ulp_mode)
 
 	wait_mckrdy
 
+	/* Save PLLA setting and disable it */
+	ldr	tmp1, [pmc, #AT91_CKGR_PLLAR]
+	str	tmp1, .saved_pllar
+
+	mov	tmp1, #AT91_PMC_PLLCOUNT
+	orr	tmp1, tmp1, #(1 << 29)		/* bit 29 always set */
+	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
+
 	ldr	r0, .pm_mode
 	cmp	r0, #AT91_PM_ULP1
 	beq	ulp1_mode
@@ -357,6 +374,18 @@ ulp1_mode:
 ulp_exit:
 	ldr	pmc, .pmc_base
 
+	/* Restore PLLA setting */
+	ldr	tmp1, .saved_pllar
+	str	tmp1, [pmc, #AT91_CKGR_PLLAR]
+
+	tst	tmp1, #(AT91_PMC_MUL &  0xff0000)
+	bne	3f
+	tst	tmp1, #(AT91_PMC_MUL & ~0xff0000)
+	beq	4f
+3:
+	wait_pllalock
+4:
+
 	/*
 	 * Restore master clock setting
 	 */
@@ -512,6 +541,8 @@ ENDPROC(at91_sramc_self_refresh)
 	.word 0
 .saved_mckr:
 	.word 0
+.saved_pllar:
+	.word 0
 .saved_sam9_lpr:
 	.word 0
 .saved_sam9_lpr1:
-- 
2.7.4

