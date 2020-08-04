Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF54C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F184E2075D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="v4JBJI/J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgHDLTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:19:54 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:63410 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbgHDLMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596539573; x=1628075573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=gzaQqXpc5xoNczZO0vYLciqB0KCCTpW7igvgI29mYeM=;
  b=v4JBJI/JNd5ym8JJfI2Bk52FwCLTYfM0rVm/guVaGi87+HrWRCcIyfmH
   xRE6HL284MJ7RymGlASEtfAZ3alL7I6u7bUgv8yUW5lD5O/rkutNX+mxi
   obTn3z0QUfO2D92ayNIEF4i8HMRlKK+vYUanjp5tjlFkjqhT7uXNrl4K0
   5QJCLKDJAIvZ3wp3kdFjiS8eKUoJDn1l5iPZ972QvkvEkZJDknFywsg7D
   HPb8Qr+jYtXgjwsADlpn/4stjA244M40WiyyVKhuPDsx/jc7DK9wz9LT7
   yhUS5bPytpwsgImHhPkrT5NOpFbfA2OxB30n32DCXWBcY5sWH9Sfh2WyD
   Q==;
IronPort-SDR: DO28IYxIPdyOZNEpHZhQvc00vFAUYwKh+8RNxLZUCLyNJzC6BZi732EE80XiAYJAdM54R9qJM+
 JQ3QCjB73d5GGN2baumXn1bcu9PMiyOaUpO8y/QT/Ubs0peQgErX9tb7DVVBQL+Llpo1xGK3yb
 QZtUuk2Fut643hM5HkJITWHN6kER/LLwH5JrN/mronoRZ5f1NEMe/GqPhc4cYtVv6PcHlVCVf/
 3hKbheA3ixhwRMWbIP9H5PUq8lmtB69Fu1H6DlYtbad0bdCUKSojLmMHN8Wi/NleCXGGgf8dWO
 TT8=
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="21673291"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2020 04:07:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 4 Aug 2020 04:07:43 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 4 Aug 2020 04:07:40 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <wenyou.yang@atmel.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/3] ARM: at91: pm: add support for ULP0 fast wakeup
Date:   Tue, 4 Aug 2020 14:07:36 +0300
Message-ID: <1596539258-20719-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596539258-20719-1-git-send-email-claudiu.beznea@microchip.com>
References: <1596539258-20719-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ULP0 fast improves suspend/resume time with few milliseconds the drawback
being the power consumption. The mean values measured for suspend/resume
time are as follows (measured on SAMA5D2 Xplained board), ULP0 compared
with fast ULP0:
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

