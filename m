Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24056C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B2E206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 07:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JEkYkiai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgHCHZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 03:25:29 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:18596 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgHCHZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 03:25:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596439527; x=1627975527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=FiWLYOAdV1lwBOPSXO+yNFoXeb/CDTvo5oQEMUUm8Cc=;
  b=JEkYkiai3QG0Z6kEYQvS/ewuUqe2msYkavptYOTav5etrSai9rX4ghuT
   vmucjbiGe7s0D/WNlraX8CBU8kU89lTZO/f2bKaL7hZ1ZyyAhjJNGCR4H
   2SJDLbvX/6lNX5oEF1SbrPkriNN3fTzzTRv0AHocTWRD8cpEj/48/NL/H
   W9QWxPrM8CooZ2daRnIItWcvqXJcCyTph+awuM4XV9ddgBsdgBVFFr/ju
   XwkIMnu9NQNeFcU81ITQwYmB8aZ23thqUFPSuT3z40NQbkWzJRyxD3LCW
   VzDj62aNnX1ccUEG2AjM0y9ugFobUv3kNo+hvgUI6wbDW5QCXbzqjJ2TB
   w==;
IronPort-SDR: I8Aohz9CRjnZcar6IRgE7m/mykp72h0JJrg/bg02GR6/sy0Y1wMbcMqUX5MhpqmPEAv4B0ahzz
 QxMzYf74ye811wOhU35N0p/+EnsKhlhoGIsdpdhAquerN1q5UivemhHY9ovwyBa/sRUMG/8bF2
 t2WOdZvbyGaml6MmGBJvC5pveUjCIs17r1hs9dEr2zHF+/JKAyesh3/XsDzV8H4LDvVoqetA/t
 mvWbgmH3nw0X9BdhArsUJrCt+V3zeC7NUZjeYYxG+FBEQT9dwG8HfeBCK2ycdKzWc1zrohsbTq
 VQY=
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="86388015"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2020 00:25:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 3 Aug 2020 00:25:24 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 3 Aug 2020 00:25:24 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/3] ARM: at91: pm: add support for ulp0 fast mode
Date:   Mon, 3 Aug 2020 10:25:15 +0300
Message-ID: <1596439517-12993-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596439517-12993-1-git-send-email-claudiu.beznea@microchip.com>
References: <1596439517-12993-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ULP0 fast improves suspend/resume time with few milliseconds the drawback
being the power consumption. The mean values measured for suspend/resume
time are as follows (measured on SAMA5D2 Xplained board), ULP0 compared
with ULP0 fast:
- ulp0 fast: suspend time: 169 ms, resume time: 216 ms
- ulp0     : suspend time: 197 ms, resume time: 258 ms

Current consumption while suspended (measured on SAMA5D2 Xplained board):
- ulp0 fast: 730uA
- ulp0     : 270uA

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/mach-at91/pm.c         |  9 +++++----
 arch/arm/mach-at91/pm.h         |  5 +++--
 arch/arm/mach-at91/pm_suspend.S | 41 +++++++++++++++++++++++++++++++++++++----
 3 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 074bde64064e..04fdcbd57100 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -51,10 +51,11 @@ static struct at91_soc_pm soc_pm = {
 };
 
 static const match_table_t pm_modes __initconst = {
-	{ AT91_PM_STANDBY, "standby" },
-	{ AT91_PM_ULP0, "ulp0" },
-	{ AT91_PM_ULP1, "ulp1" },
-	{ AT91_PM_BACKUP, "backup" },
+	{ AT91_PM_STANDBY,	"standby" },
+	{ AT91_PM_ULP0,		"ulp0" },
+	{ AT91_PM_ULP0_FAST,    "ulp0-fast" },
+	{ AT91_PM_ULP1,		"ulp1" },
+	{ AT91_PM_BACKUP,	"backup" },
 	{ -1, NULL },
 };
 
diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
index 218e8d1a30fb..bfb260be371e 100644
--- a/arch/arm/mach-at91/pm.h
+++ b/arch/arm/mach-at91/pm.h
@@ -19,8 +19,9 @@
 
 #define	AT91_PM_STANDBY		0x00
 #define AT91_PM_ULP0		0x01
-#define AT91_PM_ULP1		0x02
-#define	AT91_PM_BACKUP		0x03
+#define AT91_PM_ULP0_FAST	0x02
+#define AT91_PM_ULP1		0x03
+#define	AT91_PM_BACKUP		0x04
 
 #ifndef __ASSEMBLY__
 struct at91_pm_data {
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index be9764e8d3fa..0184de05c1be 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -164,7 +164,22 @@ ENDPROC(at91_backup_mode)
 
 .macro at91_pm_ulp0_mode
 	ldr	pmc, .pmc_base
+	ldr	tmp2, .pm_mode
+	ldr	tmp3, .mckr_offset
+
+	/* Check if ULP0 fast variant has been requested. */
+	cmp	tmp2, #AT91_PM_ULP0_FAST
+	bne	0f
+
+	/* Set highest prescaler for power saving */
+	ldr	tmp1, [pmc, tmp3]
+	bic	tmp1, tmp1, #AT91_PMC_PRES
+	orr	tmp1, tmp1, #AT91_PMC_PRES_64
+	str	tmp1, [pmc, tmp3]
+	wait_mckrdy
+	b	1f
 
+0:
 	/* Turn off the crystal oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
 	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
@@ -192,7 +207,18 @@ ENDPROC(at91_backup_mode)
 	/* Wait for interrupt */
 1:	at91_cpu_idle
 
-	/* Restore RC oscillator state */
+	/* Check if ULP0 fast variant has been requested. */
+	cmp	tmp2, #AT91_PM_ULP0_FAST
+	bne	5f
+
+	/* Set lowest prescaler for fast resume. */
+	ldr	tmp1, [pmc, tmp3]
+	bic	tmp1, tmp1, #AT91_PMC_PRES
+	str	tmp1, [pmc, tmp3]
+	wait_mckrdy
+	b	6f
+
+5:	/* Restore RC oscillator state */
 	ldr	tmp1, .saved_osc_status
 	tst	tmp1, #AT91_PMC_MOSCRCS
 	beq	4f
@@ -216,6 +242,7 @@ ENDPROC(at91_backup_mode)
 	str	tmp1, [pmc, #AT91_CKGR_MOR]
 
 	wait_moscrdy
+6:
 .endm
 
 /**
@@ -473,23 +500,29 @@ ENDPROC(at91_backup_mode)
 ENTRY(at91_ulp_mode)
 	ldr	pmc, .pmc_base
 	ldr	tmp2, .mckr_offset
+	ldr	tmp3, .pm_mode
 
 	/* Save Master clock setting */
 	ldr	tmp1, [pmc, tmp2]
 	str	tmp1, .saved_mckr
 
 	/*
-	 * Set the Master clock source to slow clock
+	 * Set master clock source to:
+	 * - MAINCK if using ULP0 fast variant
+	 * - slow clock, otherwise
 	 */
 	bic	tmp1, tmp1, #AT91_PMC_CSS
+	cmp	tmp3, #AT91_PM_ULP0_FAST
+	bne	save_mck
+	orr	tmp1, tmp1, #AT91_PMC_CSS_MAIN
+save_mck:
 	str	tmp1, [pmc, tmp2]
 
 	wait_mckrdy
 
 	at91_plla_disable
 
-	ldr	r0, .pm_mode
-	cmp	r0, #AT91_PM_ULP1
+	cmp	tmp3, #AT91_PM_ULP1
 	beq	ulp1_mode
 
 	at91_pm_ulp0_mode
-- 
2.7.4

