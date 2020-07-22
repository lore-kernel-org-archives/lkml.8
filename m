Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07805C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A9E20709
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 07:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Q3gZ0XwF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbgGVHji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 03:39:38 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:35079 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730933AbgGVHjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595403574; x=1626939574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7JCJ+HX32tECvXeoxbtlNak3cJzwEczfjgLRmqomV70=;
  b=Q3gZ0XwFKZu+es0if0rxSYDzbxQ+I3ykhy/nYEcKwgq+am0vU+2FojEX
   yJjOnE1vEBds5QiDnBjtIYERWiYsFj0445esyNwMY0Afc1K6pAAfkhwIv
   yCpgKYa3Qhf8JA+1H90MFYxxiP0s3cwV6d6Lzw/BpfRBnPM7N9JMZziwM
   fHPu4DIRFVafLnOXHU8banNVEuYmi7VVeFOXOXnS2DnaqyKF3mRrlR85E
   r6afWL69nmVMPmWSIXqQcEUqBylPJKVYaA9BdtAZ9ToPyd1KTGu41hTiz
   q/44oBJKNf9yFEzhSLniDTGJ9b0B+LczhdyKESPfNGCK6mO3AN4yTjq4W
   A==;
IronPort-SDR: sisL6F1whRx4C4ysMVHla2DBjFO3mfQi0tWRdNvo7n4Z7at7SEhyR5BOjkcRLtgxTyUopGFQAt
 WCEWKSwhgSr4yuMdcVio+wVoKwLdTeP/9kylm0irfpF/+0h5B+2hVT4cfgxZr6rrveuotiLU7G
 PZ2JxB3gt44lrrI068/KjEHKSKeqX7amuwg6kiM05+D/j4Fe3CJk8L5BUeXUWOngsErXQyjI4r
 QcKsaSvfsrmeQ4zvIRch1wjTdphuCvORwUTxW06MQj9p/oRz7gAS81I+qjBRY/eD6eDIwqT5Fc
 Zvc=
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="20120874"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 00:39:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 00:38:55 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 22 Jul 2020 00:39:30 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Claudiu Beznea" <claudiu.beznea@microchip.com>
Subject: [PATCH v2 17/18] clk: at91: clk-utmi: add utmi support for sama7g5
Date:   Wed, 22 Jul 2020 10:38:25 +0300
Message-ID: <1595403506-8209-18-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UTMI support for SAMA7G5. SAMA7G5's UTMI control is done via
XTALF register. Values written at bits 2..0 in this register
correspond to the on board crystal oscillator frequency.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/clk/at91/clk-utmi.c  | 103 ++++++++++++++++++++++++++++++++++++++++---
 drivers/clk/at91/pmc.h       |   4 ++
 include/linux/clk/at91_pmc.h |   2 +
 3 files changed, 104 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
index f1ef4e1f41a9..df9f3fc3b6a6 100644
--- a/drivers/clk/at91/clk-utmi.c
+++ b/drivers/clk/at91/clk-utmi.c
@@ -120,9 +120,11 @@ static const struct clk_ops utmi_ops = {
 	.recalc_rate = clk_utmi_recalc_rate,
 };
 
-struct clk_hw * __init
-at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
-		       const char *name, const char *parent_name)
+static struct clk_hw * __init
+at91_clk_register_utmi_internal(struct regmap *regmap_pmc,
+				struct regmap *regmap_sfr,
+				const char *name, const char *parent_name,
+				const struct clk_ops *ops, unsigned long flags)
 {
 	struct clk_utmi *utmi;
 	struct clk_hw *hw;
@@ -134,10 +136,10 @@ at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = name;
-	init.ops = &utmi_ops;
+	init.ops = ops;
 	init.parent_names = parent_name ? &parent_name : NULL;
 	init.num_parents = parent_name ? 1 : 0;
-	init.flags = CLK_SET_RATE_GATE;
+	init.flags = flags;
 
 	utmi->hw.init = &init;
 	utmi->regmap_pmc = regmap_pmc;
@@ -152,3 +154,94 @@ at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
 
 	return hw;
 }
+
+struct clk_hw * __init
+at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
+		       const char *name, const char *parent_name)
+{
+	return at91_clk_register_utmi_internal(regmap_pmc, regmap_sfr, name,
+			parent_name, &utmi_ops, CLK_SET_RATE_GATE);
+}
+
+static int clk_utmi_sama7g5_prepare(struct clk_hw *hw)
+{
+	struct clk_utmi *utmi = to_clk_utmi(hw);
+	struct clk_hw *hw_parent;
+	unsigned long parent_rate;
+	unsigned int val;
+
+	hw_parent = clk_hw_get_parent(hw);
+	parent_rate = clk_hw_get_rate(hw_parent);
+
+	switch (parent_rate) {
+	case 16000000:
+		val = 0;
+		break;
+	case 20000000:
+		val = 2;
+		break;
+	case 24000000:
+		val = 3;
+		break;
+	case 32000000:
+		val = 5;
+		break;
+	default:
+		pr_err("UTMICK: unsupported main_xtal rate\n");
+		return -EINVAL;
+	}
+
+	regmap_write(utmi->regmap_pmc, AT91_PMC_XTALF, val);
+
+	return 0;
+
+}
+
+static int clk_utmi_sama7g5_is_prepared(struct clk_hw *hw)
+{
+	struct clk_utmi *utmi = to_clk_utmi(hw);
+	struct clk_hw *hw_parent;
+	unsigned long parent_rate;
+	unsigned int val;
+
+	hw_parent = clk_hw_get_parent(hw);
+	parent_rate = clk_hw_get_rate(hw_parent);
+
+	regmap_read(utmi->regmap_pmc, AT91_PMC_XTALF, &val);
+	switch (val & 0x7) {
+	case 0:
+		if (parent_rate == 16000000)
+			return 1;
+		break;
+	case 2:
+		if (parent_rate == 20000000)
+			return 1;
+		break;
+	case 3:
+		if (parent_rate == 24000000)
+			return 1;
+		break;
+	case 5:
+		if (parent_rate == 32000000)
+			return 1;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static const struct clk_ops sama7g5_utmi_ops = {
+	.prepare = clk_utmi_sama7g5_prepare,
+	.is_prepared = clk_utmi_sama7g5_is_prepared,
+	.recalc_rate = clk_utmi_recalc_rate,
+};
+
+struct clk_hw * __init
+at91_clk_sama7g5_register_utmi(struct regmap *regmap_pmc, const char *name,
+			       const char *parent_name)
+{
+	return at91_clk_register_utmi_internal(regmap_pmc, NULL, name,
+			parent_name, &sama7g5_utmi_ops, 0);
+}
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 6340b9be8205..7b86affc6d7c 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -236,6 +236,10 @@ struct clk_hw * __init
 at91_clk_register_utmi(struct regmap *regmap_pmc, struct regmap *regmap_sfr,
 		       const char *name, const char *parent_name);
 
+struct clk_hw * __init
+at91_clk_sama7g5_register_utmi(struct regmap *regmap, const char *name,
+			       const char *parent_name);
+
 #ifdef CONFIG_PM
 void pmc_register_id(u8 id);
 void pmc_register_pck(u8 pck);
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index dc5e85f124e0..a4f82e836a7c 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -137,6 +137,8 @@
 #define			AT91_PMC_PLLADIV2_ON		(1 << 12)
 #define		AT91_PMC_H32MXDIV	BIT(24)
 
+#define AT91_PMC_XTALF		0x34			/* Main XTAL Frequency Register [SAMA7G5 only] */
+
 #define	AT91_PMC_USB		0x38			/* USB Clock Register [some SAM9 only] */
 #define		AT91_PMC_USBS		(0x1 <<  0)		/* USB OHCI Input clock selection */
 #define			AT91_PMC_USBS_PLLA		(0 << 0)
-- 
2.7.4

