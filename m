Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653ADC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326FD208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 12:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgATMKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 07:10:36 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:45944 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgATMKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 07:10:34 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: dDaz8LeM/433uASLwRvy4PnzDMlySLpXPA/+ORDmo4cPF83oyW5wmKc2l6Od5pn1feZfsdnCHJ
 BxZLitoW72z99on3u2QxH1dcDlOu1Gc1mn3LX0dPlemMYbBCvG3lfsm4Mt4xZ61E3yr42gKRut
 yAkcRG+okVEJd1pk9dW5OpEVUVgGbKlxn/2JkfVxGg7vyGnG6Xgyktn8eixU7QVP8WNzPqOLxS
 2MVgmdTUDmcdClNfhF8fJzURuL8n0Ye79K3RB87PYvrnJmoGpXddg+uwUXULbl8J9GSYeQ6hu9
 TcA=
X-IronPort-AV: E=Sophos;i="5.70,342,1574146800"; 
   d="scan'208";a="63152269"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2020 05:10:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Jan 2020 05:10:32 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Mon, 20 Jan 2020 05:10:30 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <linux@armlinux.org.uk>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 6/8] clk: at91: move sam9x60's PLL register offsets to PMC header
Date:   Mon, 20 Jan 2020 14:10:06 +0200
Message-ID: <1579522208-19523-7-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579522208-19523-1-git-send-email-claudiu.beznea@microchip.com>
References: <1579522208-19523-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move SAM9X60's PLL register offsets to PMC header so that the
definitions would also be available from arch/arm/mach-at91/pm_suspend.S.
This is necessary to disable/enable PLLA for SAM9X60 on suspend/resume.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-sam9x60-pll.c | 91 ++++++++++++++++----------------------
 include/linux/clk/at91_pmc.h       | 20 +++++++++
 2 files changed, 57 insertions(+), 54 deletions(-)

diff --git a/drivers/clk/at91/clk-sam9x60-pll.c b/drivers/clk/at91/clk-sam9x60-pll.c
index dfb354a5ff18..e699803986e5 100644
--- a/drivers/clk/at91/clk-sam9x60-pll.c
+++ b/drivers/clk/at91/clk-sam9x60-pll.c
@@ -14,27 +14,8 @@
 
 #include "pmc.h"
 
-#define PMC_PLL_CTRL0	0xc
-#define		PMC_PLL_CTRL0_DIV_MSK		GENMASK(7, 0)
-#define		PMC_PLL_CTRL0_ENPLL		BIT(28)
-#define		PMC_PLL_CTRL0_ENPLLCK		BIT(29)
-#define		PMC_PLL_CTRL0_ENLOCK		BIT(31)
-
-#define PMC_PLL_CTRL1	0x10
-#define		PMC_PLL_CTRL1_FRACR_MSK		GENMASK(21, 0)
-#define		PMC_PLL_CTRL1_MUL_MSK		GENMASK(30, 24)
-
-#define PMC_PLL_ACR	0x18
-#define		PMC_PLL_ACR_DEFAULT_UPLL	0x12020010UL
-#define		PMC_PLL_ACR_DEFAULT_PLLA	0x00020010UL
-#define		PMC_PLL_ACR_UTMIVR		BIT(12)
-#define		PMC_PLL_ACR_UTMIBG		BIT(13)
-#define		PMC_PLL_ACR_LOOP_FILTER_MSK	GENMASK(31, 24)
-
-#define PMC_PLL_UPDT	0x1c
-#define		PMC_PLL_UPDT_UPDATE		BIT(8)
-
-#define PMC_PLL_ISR0	0xec
+#define	PMC_PLL_CTRL0_DIV_MSK	GENMASK(7, 0)
+#define	PMC_PLL_CTRL1_MUL_MSK	GENMASK(30, 24)
 
 #define PLL_DIV_MAX		(FIELD_GET(PMC_PLL_CTRL0_DIV_MSK, UINT_MAX) + 1)
 #define UPLL_DIV		2
@@ -59,7 +40,7 @@ static inline bool sam9x60_pll_ready(struct regmap *regmap, int id)
 {
 	unsigned int status;
 
-	regmap_read(regmap, PMC_PLL_ISR0, &status);
+	regmap_read(regmap, AT91_PMC_PLL_ISR0, &status);
 
 	return !!(status & BIT(id));
 }
@@ -74,12 +55,12 @@ static int sam9x60_pll_prepare(struct clk_hw *hw)
 	u32 val;
 
 	spin_lock_irqsave(pll->lock, flags);
-	regmap_write(regmap, PMC_PLL_UPDT, pll->id);
+	regmap_write(regmap, AT91_PMC_PLL_UPDT, pll->id);
 
-	regmap_read(regmap, PMC_PLL_CTRL0, &val);
+	regmap_read(regmap, AT91_PMC_PLL_CTRL0, &val);
 	div = FIELD_GET(PMC_PLL_CTRL0_DIV_MSK, val);
 
-	regmap_read(regmap, PMC_PLL_CTRL1, &val);
+	regmap_read(regmap, AT91_PMC_PLL_CTRL1, &val);
 	mul = FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, val);
 
 	if (sam9x60_pll_ready(regmap, pll->id) &&
@@ -88,39 +69,39 @@ static int sam9x60_pll_prepare(struct clk_hw *hw)
 		return 0;
 	}
 
-	/* Recommended value for PMC_PLL_ACR */
+	/* Recommended value for AT91_PMC_PLL_ACR */
 	if (pll->characteristics->upll)
-		val = PMC_PLL_ACR_DEFAULT_UPLL;
+		val = AT91_PMC_PLL_ACR_DEFAULT_UPLL;
 	else
-		val = PMC_PLL_ACR_DEFAULT_PLLA;
-	regmap_write(regmap, PMC_PLL_ACR, val);
+		val = AT91_PMC_PLL_ACR_DEFAULT_PLLA;
+	regmap_write(regmap, AT91_PMC_PLL_ACR, val);
 
-	regmap_write(regmap, PMC_PLL_CTRL1,
+	regmap_write(regmap, AT91_PMC_PLL_CTRL1,
 		     FIELD_PREP(PMC_PLL_CTRL1_MUL_MSK, pll->mul));
 
 	if (pll->characteristics->upll) {
 		/* Enable the UTMI internal bandgap */
-		val |= PMC_PLL_ACR_UTMIBG;
-		regmap_write(regmap, PMC_PLL_ACR, val);
+		val |= AT91_PMC_PLL_ACR_UTMIBG;
+		regmap_write(regmap, AT91_PMC_PLL_ACR, val);
 
 		udelay(10);
 
 		/* Enable the UTMI internal regulator */
-		val |= PMC_PLL_ACR_UTMIVR;
-		regmap_write(regmap, PMC_PLL_ACR, val);
+		val |= AT91_PMC_PLL_ACR_UTMIVR;
+		regmap_write(regmap, AT91_PMC_PLL_ACR, val);
 
 		udelay(10);
 	}
 
-	regmap_update_bits(regmap, PMC_PLL_UPDT,
-			   PMC_PLL_UPDT_UPDATE, PMC_PLL_UPDT_UPDATE);
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_UPDATE, AT91_PMC_PLL_UPDT_UPDATE);
 
-	regmap_write(regmap, PMC_PLL_CTRL0,
-		     PMC_PLL_CTRL0_ENLOCK | PMC_PLL_CTRL0_ENPLL |
-		     PMC_PLL_CTRL0_ENPLLCK | pll->div);
+	regmap_write(regmap, AT91_PMC_PLL_CTRL0,
+		     AT91_PMC_PLL_CTRL0_ENLOCK | AT91_PMC_PLL_CTRL0_ENPLL |
+		     AT91_PMC_PLL_CTRL0_ENPLLCK | pll->div);
 
-	regmap_update_bits(regmap, PMC_PLL_UPDT,
-			   PMC_PLL_UPDT_UPDATE, PMC_PLL_UPDT_UPDATE);
+	regmap_update_bits(regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_UPDATE, AT91_PMC_PLL_UPDT_UPDATE);
 
 	while (!sam9x60_pll_ready(regmap, pll->id))
 		cpu_relax();
@@ -144,22 +125,24 @@ static void sam9x60_pll_unprepare(struct clk_hw *hw)
 
 	spin_lock_irqsave(pll->lock, flags);
 
-	regmap_write(pll->regmap, PMC_PLL_UPDT, pll->id);
+	regmap_write(pll->regmap, AT91_PMC_PLL_UPDT, pll->id);
 
-	regmap_update_bits(pll->regmap, PMC_PLL_CTRL0,
-			   PMC_PLL_CTRL0_ENPLLCK, 0);
+	regmap_update_bits(pll->regmap, AT91_PMC_PLL_CTRL0,
+			   AT91_PMC_PLL_CTRL0_ENPLLCK, 0);
 
-	regmap_update_bits(pll->regmap, PMC_PLL_UPDT,
-			   PMC_PLL_UPDT_UPDATE, PMC_PLL_UPDT_UPDATE);
+	regmap_update_bits(pll->regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_UPDATE, AT91_PMC_PLL_UPDT_UPDATE);
 
-	regmap_update_bits(pll->regmap, PMC_PLL_CTRL0, PMC_PLL_CTRL0_ENPLL, 0);
+	regmap_update_bits(pll->regmap, AT91_PMC_PLL_CTRL0,
+			   AT91_PMC_PLL_CTRL0_ENPLL, 0);
 
 	if (pll->characteristics->upll)
-		regmap_update_bits(pll->regmap, PMC_PLL_ACR,
-				   PMC_PLL_ACR_UTMIBG | PMC_PLL_ACR_UTMIVR, 0);
+		regmap_update_bits(pll->regmap, AT91_PMC_PLL_ACR,
+				   AT91_PMC_PLL_ACR_UTMIBG |
+				   AT91_PMC_PLL_ACR_UTMIVR, 0);
 
-	regmap_update_bits(pll->regmap, PMC_PLL_UPDT,
-			   PMC_PLL_UPDT_UPDATE, PMC_PLL_UPDT_UPDATE);
+	regmap_update_bits(pll->regmap, AT91_PMC_PLL_UPDT,
+			   AT91_PMC_PLL_UPDT_UPDATE, AT91_PMC_PLL_UPDT_UPDATE);
 
 	spin_unlock_irqrestore(pll->lock, flags);
 }
@@ -316,10 +299,10 @@ sam9x60_clk_register_pll(struct regmap *regmap, spinlock_t *lock,
 	pll->regmap = regmap;
 	pll->lock = lock;
 
-	regmap_write(regmap, PMC_PLL_UPDT, id);
-	regmap_read(regmap, PMC_PLL_CTRL0, &pllr);
+	regmap_write(regmap, AT91_PMC_PLL_UPDT, id);
+	regmap_read(regmap, AT91_PMC_PLL_CTRL0, &pllr);
 	pll->div = FIELD_GET(PMC_PLL_CTRL0_DIV_MSK, pllr);
-	regmap_read(regmap, PMC_PLL_CTRL1, &pllr);
+	regmap_read(regmap, AT91_PMC_PLL_CTRL1, &pllr);
 	pll->mul = FIELD_GET(PMC_PLL_CTRL1_MUL_MSK, pllr);
 
 	hw = &pll->hw;
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index f3d691fc5f29..49a53a137610 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -33,16 +33,34 @@
 #define		AT91_PMC_HCK0		(1 << 16)		/* AHB Clock (USB host) [AT91SAM9261 only] */
 #define		AT91_PMC_HCK1		(1 << 17)		/* AHB Clock (LCD) [AT91SAM9261 only] */
 
+#define AT91_PMC_PLL_CTRL0		0x0C		/* PLL Control Register 0 [for SAM9X60] */
+#define		AT91_PMC_PLL_CTRL0_ENPLL	(1 << 28)	/* Enable PLL */
+#define		AT91_PMC_PLL_CTRL0_ENPLLCK	(1 << 29)	/* Enable PLL clock for PMC */
+#define		AT91_PMC_PLL_CTRL0_ENLOCK	(1 << 31)	/* Enable PLL lock */
+
+#define AT91_PMC_PLL_CTRL1		0x10		/* PLL Control Register 1 [for SAM9X60] */
+
 #define	AT91_PMC_PCER		0x10			/* Peripheral Clock Enable Register */
 #define	AT91_PMC_PCDR		0x14			/* Peripheral Clock Disable Register */
 #define	AT91_PMC_PCSR		0x18			/* Peripheral Clock Status Register */
 
+#define AT91_PMC_PLL_ACR	0x18			/* PLL Analog Control Register [for SAM9X60] */
+#define		AT91_PMC_PLL_ACR_DEFAULT_UPLL	0x12020010UL	/* Default PLL ACR value for UPLL */
+#define		AT91_PMC_PLL_ACR_DEFAULT_PLLA	0x00020010UL	/* Default PLL ACR value for PLLA */
+#define		AT91_PMC_PLL_ACR_UTMIVR		(1 << 12)	/* UPLL Voltage regulator Control */
+#define		AT91_PMC_PLL_ACR_UTMIBG		(1 << 13)	/* UPLL Bandgap Control */
+
 #define	AT91_CKGR_UCKR		0x1C			/* UTMI Clock Register [some SAM9] */
 #define		AT91_PMC_UPLLEN		(1   << 16)		/* UTMI PLL Enable */
 #define		AT91_PMC_UPLLCOUNT	(0xf << 20)		/* UTMI PLL Start-up Time */
 #define		AT91_PMC_BIASEN		(1   << 24)		/* UTMI BIAS Enable */
 #define		AT91_PMC_BIASCOUNT	(0xf << 28)		/* UTMI BIAS Start-up Time */
 
+#define AT91_PMC_PLL_UPDT		0x1C		/* PMC PLL update register [for SAM9X60] */
+#define		AT91_PMC_PLL_UPDT_UPDATE	(1 << 8)	/* Update PLL settings */
+#define		AT91_PMC_PLL_UPDT_ID		(1 << 0)	/* PLL ID */
+#define		AT91_PMC_PLL_UPDT_STUPTIM	(0xff << 16)	/* Startup time */
+
 #define	AT91_CKGR_MOR		0x20			/* Main Oscillator Register [not on SAM9RL] */
 #define		AT91_PMC_MOSCEN		(1    <<  0)		/* Main Oscillator Enable */
 #define		AT91_PMC_OSCBYPASS	(1    <<  1)		/* Oscillator Bypass */
@@ -183,6 +201,8 @@
 #define		AT91_PMC_WPVS		(0x1  <<  0)		/* Write Protect Violation Status */
 #define		AT91_PMC_WPVSRC		(0xffff  <<  8)		/* Write Protect Violation Source */
 
+#define AT91_PMC_PLL_ISR0	0xEC			/* PLL Interrupt Status Register 0 [SAM9X60 only] */
+
 #define AT91_PMC_PCER1		0x100			/* Peripheral Clock Enable Register 1 [SAMA5 only]*/
 #define AT91_PMC_PCDR1		0x104			/* Peripheral Clock Enable Register 1 */
 #define AT91_PMC_PCSR1		0x108			/* Peripheral Clock Enable Register 1 */
-- 
2.7.4

