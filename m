Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A689BC11D24
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 04:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACA820716
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 04:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrToi28i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgBUEOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 23:14:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55968 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgBUEOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 23:14:54 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so246281wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 20:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9We5vy/l9P/Ri+Ph4ZVgFjqxMHkDZoduDyBXJBx3doU=;
        b=MrToi28iduq8cQzloB8McvPDPGeRopxaGkOOJ3by7d2XFDfxWBluCznBOj+gVV0z6c
         jp8ocJxTLtQFpVh4y5rTvcj9IrnVWKleL22dRPqF0ADN1WjlxFsq6Uq25btUKh2P8lSV
         R0+n6x+Iuk9zkdDxqhyeFe4vkOMgc5V8NjzVaYw/gEmKlBsbqPv5Vti2kPRUWV4GP0j6
         5GFNiuljjJjxQ6t/0JTzl7EWDeVPm8BMk3uc37rvWUvbEWAJ8HmVjm14lCUoWLm5Kbx9
         0HwAqBmxkKrfX59zAERCdrOz7oeWUW7oZtAt1HNgC0RZIBOSqjjKZoGnmaWRbg09rG9E
         heZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9We5vy/l9P/Ri+Ph4ZVgFjqxMHkDZoduDyBXJBx3doU=;
        b=GZB1qz+ENRbFqwuLIn/AZ2a/U9yAM3Kb5rRITRh1Hnt1V0XQ8K2LaIfnNVzePg+pz3
         VgLY91KQkr12KTXSVZ1JtpaMxZhDZS+ItTk1KsJQWyIZ7zKGWI4XAtn03MbJlT0OmnOH
         8lClEIH0iTWBRIGsM/Cf0A2vpIzhsxlc7JwYxuWJSxwKTjrm0tScuFWful+v08KcN2Va
         5SGYOM4ug/kdQDjn43QIT2umk5pgJ1Vm8jx1kDIdUU3E/1YYFEKA7WZmSfYERWB0FxFD
         Edv4VbNATrFOT5Y2wxMwgQi7DVk+Tkd/Fj4P77L+MmHOo27KpgLMDRM3CHrkYbKXal2N
         PrQg==
X-Gm-Message-State: APjAAAUzBdacMXMmgT2ebhNXgwEQVPx3P+8Ai5yRniBDeeYkTWaqvHtb
        7FvFPWdB8eg4YN9Ys1I12+x7lKNH
X-Google-Smtp-Source: APXvYqwZGxxMJjqGWPM16py8xSQ2TUroyY6BWKfRazuk7AWpb2qONkXCYGaBWQtdGAvR2iW+xCme/A==
X-Received: by 2002:a1c:1c7:: with SMTP id 190mr859228wmb.121.1582258490655;
        Thu, 20 Feb 2020 20:14:50 -0800 (PST)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f207sm2159855wme.9.2020.02.20.20.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 20:14:49 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org, kishon@ti.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Jaedon Shin <jaedon.shin@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH fixes v2] phy: brcm-sata: Correct MDIO operations for 40nm platforms
Date:   Thu, 20 Feb 2020 20:14:23 -0800
Message-Id: <1582258465-11378-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logic to write to MDIO registers on 40nm platforms was wrong
because it would use the port number as an offset from the base address
rather than the bank address of the PHY. This is hardly noticeable
because the only programming we do is enabling SSC or not, which is not
really causing an observable functional change.

Correct that mistake by passing down the struct brcm_sata_port structure
down to the brcm_sata_mdio_wr() and brcm_sata_mdio_rd() functions and do
the proper offseting for 28nm, respectively 40nm platforms from there.
This means that brcm_sata_pcb_base() is now useless and is therefore
removed.

Fixes: c1602a1a0fbe ("phy: phy_brcmstb_sata: add support for MIPS-based platforms")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes in v2:

- added missing changes to the Stingray function

 drivers/phy/broadcom/phy-brcm-sata.c | 148 +++++++++++++++--------------------
 1 file changed, 65 insertions(+), 83 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-sata.c b/drivers/phy/broadcom/phy-brcm-sata.c
index 4710cfcc3037..18251f232172 100644
--- a/drivers/phy/broadcom/phy-brcm-sata.c
+++ b/drivers/phy/broadcom/phy-brcm-sata.c
@@ -186,29 +186,6 @@ enum sata_phy_ctrl_regs {
 	PHY_CTRL_1_RESET			= BIT(0),
 };
 
-static inline void __iomem *brcm_sata_pcb_base(struct brcm_sata_port *port)
-{
-	struct brcm_sata_phy *priv = port->phy_priv;
-	u32 size = 0;
-
-	switch (priv->version) {
-	case BRCM_SATA_PHY_STB_16NM:
-	case BRCM_SATA_PHY_STB_28NM:
-	case BRCM_SATA_PHY_IPROC_NS2:
-	case BRCM_SATA_PHY_DSL_28NM:
-		size = SATA_PCB_REG_28NM_SPACE_SIZE;
-		break;
-	case BRCM_SATA_PHY_STB_40NM:
-		size = SATA_PCB_REG_40NM_SPACE_SIZE;
-		break;
-	default:
-		dev_err(priv->dev, "invalid phy version\n");
-		break;
-	}
-
-	return priv->phy_base + (port->portnum * size);
-}
-
 static inline void __iomem *brcm_sata_ctrl_base(struct brcm_sata_port *port)
 {
 	struct brcm_sata_phy *priv = port->phy_priv;
@@ -226,19 +203,34 @@ static inline void __iomem *brcm_sata_ctrl_base(struct brcm_sata_port *port)
 	return priv->ctrl_base + (port->portnum * size);
 }
 
-static void brcm_sata_phy_wr(void __iomem *pcb_base, u32 bank,
+static void brcm_sata_phy_wr(struct brcm_sata_port *port, u32 bank,
 			     u32 ofs, u32 msk, u32 value)
 {
+	struct brcm_sata_phy *priv = port->phy_priv;
+	void __iomem *pcb_base = priv->phy_base;
 	u32 tmp;
 
+	if (priv->version == BRCM_SATA_PHY_STB_40NM)
+		bank += (port->portnum * SATA_PCB_REG_40NM_SPACE_SIZE);
+	else
+		pcb_base += (port->portnum * SATA_PCB_REG_28NM_SPACE_SIZE);
+
 	writel(bank, pcb_base + SATA_PCB_BANK_OFFSET);
 	tmp = readl(pcb_base + SATA_PCB_REG_OFFSET(ofs));
 	tmp = (tmp & msk) | value;
 	writel(tmp, pcb_base + SATA_PCB_REG_OFFSET(ofs));
 }
 
-static u32 brcm_sata_phy_rd(void __iomem *pcb_base, u32 bank, u32 ofs)
+static u32 brcm_sata_phy_rd(struct brcm_sata_port *port, u32 bank, u32 ofs)
 {
+	struct brcm_sata_phy *priv = port->phy_priv;
+	void __iomem *pcb_base = priv->phy_base;
+
+	if (priv->version == BRCM_SATA_PHY_STB_40NM)
+		bank += (port->portnum * SATA_PCB_REG_40NM_SPACE_SIZE);
+	else
+		pcb_base += (port->portnum * SATA_PCB_REG_28NM_SPACE_SIZE);
+
 	writel(bank, pcb_base + SATA_PCB_BANK_OFFSET);
 	return readl(pcb_base + SATA_PCB_REG_OFFSET(ofs));
 }
@@ -250,16 +242,15 @@ static u32 brcm_sata_phy_rd(void __iomem *pcb_base, u32 bank, u32 ofs)
 
 static void brcm_stb_sata_ssc_init(struct brcm_sata_port *port)
 {
-	void __iomem *base = brcm_sata_pcb_base(port);
 	struct brcm_sata_phy *priv = port->phy_priv;
 	u32 tmp;
 
 	/* override the TX spread spectrum setting */
 	tmp = TXPMD_CONTROL1_TX_SSC_EN_FRC_VAL | TXPMD_CONTROL1_TX_SSC_EN_FRC;
-	brcm_sata_phy_wr(base, TXPMD_REG_BANK, TXPMD_CONTROL1, ~tmp, tmp);
+	brcm_sata_phy_wr(port, TXPMD_REG_BANK, TXPMD_CONTROL1, ~tmp, tmp);
 
 	/* set fixed min freq */
-	brcm_sata_phy_wr(base, TXPMD_REG_BANK, TXPMD_TX_FREQ_CTRL_CONTROL2,
+	brcm_sata_phy_wr(port, TXPMD_REG_BANK, TXPMD_TX_FREQ_CTRL_CONTROL2,
 			 ~TXPMD_TX_FREQ_CTRL_CONTROL2_FMIN_MASK,
 			 STB_FMIN_VAL_DEFAULT);
 
@@ -271,7 +262,7 @@ static void brcm_stb_sata_ssc_init(struct brcm_sata_port *port)
 		tmp = STB_FMAX_VAL_DEFAULT;
 	}
 
-	brcm_sata_phy_wr(base, TXPMD_REG_BANK, TXPMD_TX_FREQ_CTRL_CONTROL3,
+	brcm_sata_phy_wr(port, TXPMD_REG_BANK, TXPMD_TX_FREQ_CTRL_CONTROL3,
 			  ~TXPMD_TX_FREQ_CTRL_CONTROL3_FMAX_MASK, tmp);
 }
 
@@ -280,7 +271,6 @@ static void brcm_stb_sata_ssc_init(struct brcm_sata_port *port)
 
 static int brcm_stb_sata_rxaeq_init(struct brcm_sata_port *port)
 {
-	void __iomem *base = brcm_sata_pcb_base(port);
 	u32 tmp = 0, reg = 0;
 
 	switch (port->rxaeq_mode) {
@@ -301,8 +291,8 @@ static int brcm_stb_sata_rxaeq_init(struct brcm_sata_port *port)
 		break;
 	}
 
-	brcm_sata_phy_wr(base, AEQRX_REG_BANK_0, reg, ~tmp, tmp);
-	brcm_sata_phy_wr(base, AEQRX_REG_BANK_1, reg, ~tmp, tmp);
+	brcm_sata_phy_wr(port, AEQRX_REG_BANK_0, reg, ~tmp, tmp);
+	brcm_sata_phy_wr(port, AEQRX_REG_BANK_1, reg, ~tmp, tmp);
 
 	return 0;
 }
@@ -316,18 +306,17 @@ static int brcm_stb_sata_init(struct brcm_sata_port *port)
 
 static int brcm_stb_sata_16nm_ssc_init(struct brcm_sata_port *port)
 {
-	void __iomem *base = brcm_sata_pcb_base(port);
 	u32 tmp, value;
 
 	/* Reduce CP tail current to 1/16th of its default value */
-	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL6, 0, 0x141);
+	brcm_sata_phy_wr(port, PLL1_REG_BANK, PLL1_ACTRL6, 0, 0x141);
 
 	/* Turn off CP tail current boost */
-	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL8, 0, 0xc006);
+	brcm_sata_phy_wr(port, PLL1_REG_BANK, PLL1_ACTRL8, 0, 0xc006);
 
 	/* Set a specific AEQ equalizer value */
 	tmp = AEQ_FRC_EQ_FORCE_VAL | AEQ_FRC_EQ_FORCE;
-	brcm_sata_phy_wr(base, AEQRX_REG_BANK_0, AEQ_FRC_EQ,
+	brcm_sata_phy_wr(port, AEQRX_REG_BANK_0, AEQ_FRC_EQ,
 			 ~(tmp | AEQ_RFZ_FRC_VAL |
 			   AEQ_FRC_EQ_VAL_MASK << AEQ_FRC_EQ_VAL_SHIFT),
 			 tmp | 32 << AEQ_FRC_EQ_VAL_SHIFT);
@@ -337,7 +326,7 @@ static int brcm_stb_sata_16nm_ssc_init(struct brcm_sata_port *port)
 		value = 0x52;
 	else
 		value = 0;
-	brcm_sata_phy_wr(base, RXPMD_REG_BANK, RXPMD_RX_CDR_CONTROL1,
+	brcm_sata_phy_wr(port, RXPMD_REG_BANK, RXPMD_RX_CDR_CONTROL1,
 			 ~RXPMD_RX_PPM_VAL_MASK, value);
 
 	/* Set proportional loop bandwith Gen1/2/3 */
@@ -352,7 +341,7 @@ static int brcm_stb_sata_16nm_ssc_init(struct brcm_sata_port *port)
 		value = 1 << RXPMD_G1_CDR_PROP_BW_SHIFT |
 			1 << RXPMD_G2_CDR_PROP_BW_SHIFT |
 			1 << RXPMD_G3_CDR_PROB_BW_SHIFT;
-	brcm_sata_phy_wr(base, RXPMD_REG_BANK, RXPMD_RX_CDR_CDR_PROP_BW, ~tmp,
+	brcm_sata_phy_wr(port, RXPMD_REG_BANK, RXPMD_RX_CDR_CDR_PROP_BW, ~tmp,
 			 value);
 
 	/* Set CDR integral loop acquisition bandwidth for Gen1/2/3 */
@@ -365,7 +354,7 @@ static int brcm_stb_sata_16nm_ssc_init(struct brcm_sata_port *port)
 			1 << RXPMD_G3_CDR_ACQ_INT_BW_SHIFT;
 	else
 		value = 0;
-	brcm_sata_phy_wr(base, RXPMD_REG_BANK, RXPMD_RX_CDR_CDR_ACQ_INTEG_BW,
+	brcm_sata_phy_wr(port, RXPMD_REG_BANK, RXPMD_RX_CDR_CDR_ACQ_INTEG_BW,
 			 ~tmp, value);
 
 	/* Set CDR integral loop locking bandwidth to 1 for Gen 1/2/3 */
@@ -378,7 +367,7 @@ static int brcm_stb_sata_16nm_ssc_init(struct brcm_sata_port *port)
 			1 << RXPMD_G3_CDR_LOCK_INT_BW_SHIFT;
 	else
 		value = 0;
-	brcm_sata_phy_wr(base, RXPMD_REG_BANK, RXPMD_RX_CDR_CDR_LOCK_INTEG_BW,
+	brcm_sata_phy_wr(port, RXPMD_REG_BANK, RXPMD_RX_CDR_CDR_LOCK_INTEG_BW,
 			 ~tmp, value);
 
 	/* Set no guard band and clamp CDR */
@@ -387,11 +376,11 @@ static int brcm_stb_sata_16nm_ssc_init(struct brcm_sata_port *port)
 		value = 0x51;
 	else
 		value = 0;
-	brcm_sata_phy_wr(base, RXPMD_REG_BANK, RXPMD_RX_FREQ_MON_CONTROL1,
+	brcm_sata_phy_wr(port, RXPMD_REG_BANK, RXPMD_RX_FREQ_MON_CONTROL1,
 			 ~tmp, RXPMD_MON_CORRECT_EN | value);
 
 	/* Turn on/off SSC */
-	brcm_sata_phy_wr(base, TX_REG_BANK, TX_ACTRL5, ~TX_ACTRL5_SSC_EN,
+	brcm_sata_phy_wr(port, TX_REG_BANK, TX_ACTRL5, ~TX_ACTRL5_SSC_EN,
 			 port->ssc_en ? TX_ACTRL5_SSC_EN : 0);
 
 	return 0;
@@ -411,7 +400,6 @@ static int brcm_ns2_sata_init(struct brcm_sata_port *port)
 {
 	int try;
 	unsigned int val;
-	void __iomem *base = brcm_sata_pcb_base(port);
 	void __iomem *ctrl_base = brcm_sata_ctrl_base(port);
 	struct device *dev = port->phy_priv->dev;
 
@@ -421,24 +409,24 @@ static int brcm_ns2_sata_init(struct brcm_sata_port *port)
 	val |= (0x4 << OOB_CTRL1_BURST_MIN_SHIFT);
 	val |= (0x9 << OOB_CTRL1_WAKE_IDLE_MAX_SHIFT);
 	val |= (0x3 << OOB_CTRL1_WAKE_IDLE_MIN_SHIFT);
-	brcm_sata_phy_wr(base, OOB_REG_BANK, OOB_CTRL1, 0x0, val);
+	brcm_sata_phy_wr(port, OOB_REG_BANK, OOB_CTRL1, 0x0, val);
 	val = 0x0;
 	val |= (0x1b << OOB_CTRL2_RESET_IDLE_MAX_SHIFT);
 	val |= (0x2 << OOB_CTRL2_BURST_CNT_SHIFT);
 	val |= (0x9 << OOB_CTRL2_RESET_IDLE_MIN_SHIFT);
-	brcm_sata_phy_wr(base, OOB_REG_BANK, OOB_CTRL2, 0x0, val);
+	brcm_sata_phy_wr(port, OOB_REG_BANK, OOB_CTRL2, 0x0, val);
 
 	/* Configure PHY PLL register bank 1 */
 	val = NS2_PLL1_ACTRL2_MAGIC;
-	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL2, 0x0, val);
+	brcm_sata_phy_wr(port, PLL1_REG_BANK, PLL1_ACTRL2, 0x0, val);
 	val = NS2_PLL1_ACTRL3_MAGIC;
-	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL3, 0x0, val);
+	brcm_sata_phy_wr(port, PLL1_REG_BANK, PLL1_ACTRL3, 0x0, val);
 	val = NS2_PLL1_ACTRL4_MAGIC;
-	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL4, 0x0, val);
+	brcm_sata_phy_wr(port, PLL1_REG_BANK, PLL1_ACTRL4, 0x0, val);
 
 	/* Configure PHY BLOCK0 register bank */
 	/* Set oob_clk_sel to refclk/2 */
-	brcm_sata_phy_wr(base, BLOCK0_REG_BANK, BLOCK0_SPARE,
+	brcm_sata_phy_wr(port, BLOCK0_REG_BANK, BLOCK0_SPARE,
 			 ~BLOCK0_SPARE_OOB_CLK_SEL_MASK,
 			 BLOCK0_SPARE_OOB_CLK_SEL_REFBY2);
 
@@ -451,7 +439,7 @@ static int brcm_ns2_sata_init(struct brcm_sata_port *port)
 	/* Wait for PHY PLL lock by polling pll_lock bit */
 	try = 50;
 	while (try) {
-		val = brcm_sata_phy_rd(base, BLOCK0_REG_BANK,
+		val = brcm_sata_phy_rd(port, BLOCK0_REG_BANK,
 					BLOCK0_XGXSSTATUS);
 		if (val & BLOCK0_XGXSSTATUS_PLL_LOCK)
 			break;
@@ -471,9 +459,7 @@ static int brcm_ns2_sata_init(struct brcm_sata_port *port)
 
 static int brcm_nsp_sata_init(struct brcm_sata_port *port)
 {
-	struct brcm_sata_phy *priv = port->phy_priv;
 	struct device *dev = port->phy_priv->dev;
-	void __iomem *base = priv->phy_base;
 	unsigned int oob_bank;
 	unsigned int val, try;
 
@@ -490,36 +476,36 @@ static int brcm_nsp_sata_init(struct brcm_sata_port *port)
 	val |= (0x06 << OOB_CTRL1_BURST_MIN_SHIFT);
 	val |= (0x0f << OOB_CTRL1_WAKE_IDLE_MAX_SHIFT);
 	val |= (0x06 << OOB_CTRL1_WAKE_IDLE_MIN_SHIFT);
-	brcm_sata_phy_wr(base, oob_bank, OOB_CTRL1, 0x0, val);
+	brcm_sata_phy_wr(port, oob_bank, OOB_CTRL1, 0x0, val);
 
 	val = 0x0;
 	val |= (0x2e << OOB_CTRL2_RESET_IDLE_MAX_SHIFT);
 	val |= (0x02 << OOB_CTRL2_BURST_CNT_SHIFT);
 	val |= (0x16 << OOB_CTRL2_RESET_IDLE_MIN_SHIFT);
-	brcm_sata_phy_wr(base, oob_bank, OOB_CTRL2, 0x0, val);
+	brcm_sata_phy_wr(port, oob_bank, OOB_CTRL2, 0x0, val);
 
 
-	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_ACTRL2,
+	brcm_sata_phy_wr(port, PLL_REG_BANK_0, PLL_ACTRL2,
 		~(PLL_ACTRL2_SELDIV_MASK << PLL_ACTRL2_SELDIV_SHIFT),
 		0x0c << PLL_ACTRL2_SELDIV_SHIFT);
 
-	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_CAP_CONTROL,
+	brcm_sata_phy_wr(port, PLL_REG_BANK_0, PLL_CAP_CONTROL,
 						0xff0, 0x4f0);
 
 	val = PLLCONTROL_0_FREQ_DET_RESTART | PLLCONTROL_0_FREQ_MONITOR;
-	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
+	brcm_sata_phy_wr(port, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
 								~val, val);
 	val = PLLCONTROL_0_SEQ_START;
-	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
+	brcm_sata_phy_wr(port, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
 								~val, 0);
 	mdelay(10);
-	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
+	brcm_sata_phy_wr(port, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
 								~val, val);
 
 	/* Wait for pll_seq_done bit */
 	try = 50;
 	while (--try) {
-		val = brcm_sata_phy_rd(base, BLOCK0_REG_BANK,
+		val = brcm_sata_phy_rd(port, BLOCK0_REG_BANK,
 					BLOCK0_XGXSSTATUS);
 		if (val & BLOCK0_XGXSSTATUS_PLL_LOCK)
 			break;
@@ -546,27 +532,25 @@ static int brcm_nsp_sata_init(struct brcm_sata_port *port)
 
 static int brcm_sr_sata_init(struct brcm_sata_port *port)
 {
-	struct brcm_sata_phy *priv = port->phy_priv;
 	struct device *dev = port->phy_priv->dev;
-	void __iomem *base = priv->phy_base;
 	unsigned int val, try;
 
 	/* Configure PHY PLL register bank 1 */
 	val = SR_PLL1_ACTRL2_MAGIC;
-	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL2, 0x0, val);
+	brcm_sata_phy_wr(port, PLL1_REG_BANK, PLL1_ACTRL2, 0x0, val);
 	val = SR_PLL1_ACTRL3_MAGIC;
-	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL3, 0x0, val);
+	brcm_sata_phy_wr(port, PLL1_REG_BANK, PLL1_ACTRL3, 0x0, val);
 	val = SR_PLL1_ACTRL4_MAGIC;
-	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL4, 0x0, val);
+	brcm_sata_phy_wr(port, PLL1_REG_BANK, PLL1_ACTRL4, 0x0, val);
 
 	/* Configure PHY PLL register bank 0 */
 	val = SR_PLL0_ACTRL6_MAGIC;
-	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_ACTRL6, 0x0, val);
+	brcm_sata_phy_wr(port, PLL_REG_BANK_0, PLL_ACTRL6, 0x0, val);
 
 	/* Wait for PHY PLL lock by polling pll_lock bit */
 	try = 50;
 	do {
-		val = brcm_sata_phy_rd(base, BLOCK0_REG_BANK,
+		val = brcm_sata_phy_rd(port, BLOCK0_REG_BANK,
 					BLOCK0_XGXSSTATUS);
 		if (val & BLOCK0_XGXSSTATUS_PLL_LOCK)
 			break;
@@ -581,7 +565,7 @@ static int brcm_sr_sata_init(struct brcm_sata_port *port)
 	}
 
 	/* Invert Tx polarity */
-	brcm_sata_phy_wr(base, TX_REG_BANK, TX_ACTRL0,
+	brcm_sata_phy_wr(port, TX_REG_BANK, TX_ACTRL0,
 			 ~TX_ACTRL0_TXPOL_FLIP, TX_ACTRL0_TXPOL_FLIP);
 
 	/* Configure OOB control to handle 100MHz reference clock */
@@ -589,52 +573,51 @@ static int brcm_sr_sata_init(struct brcm_sata_port *port)
 		(0x4 << OOB_CTRL1_BURST_MIN_SHIFT) |
 		(0x8 << OOB_CTRL1_WAKE_IDLE_MAX_SHIFT) |
 		(0x3 << OOB_CTRL1_WAKE_IDLE_MIN_SHIFT));
-	brcm_sata_phy_wr(base, OOB_REG_BANK, OOB_CTRL1, 0x0, val);
+	brcm_sata_phy_wr(port, OOB_REG_BANK, OOB_CTRL1, 0x0, val);
 	val = ((0x1b << OOB_CTRL2_RESET_IDLE_MAX_SHIFT) |
 		(0x2 << OOB_CTRL2_BURST_CNT_SHIFT) |
 		(0x9 << OOB_CTRL2_RESET_IDLE_MIN_SHIFT));
-	brcm_sata_phy_wr(base, OOB_REG_BANK, OOB_CTRL2, 0x0, val);
+	brcm_sata_phy_wr(port, OOB_REG_BANK, OOB_CTRL2, 0x0, val);
 
 	return 0;
 }
 
 static int brcm_dsl_sata_init(struct brcm_sata_port *port)
 {
-	void __iomem *base = brcm_sata_pcb_base(port);
 	struct device *dev = port->phy_priv->dev;
 	unsigned int try;
 	u32 tmp;
 
-	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL7, 0, 0x873);
+	brcm_sata_phy_wr(port, PLL1_REG_BANK, PLL1_ACTRL7, 0, 0x873);
 
-	brcm_sata_phy_wr(base, PLL1_REG_BANK, PLL1_ACTRL6, 0, 0xc000);
+	brcm_sata_phy_wr(port, PLL1_REG_BANK, PLL1_ACTRL6, 0, 0xc000);
 
-	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
+	brcm_sata_phy_wr(port, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
 			 0, 0x3089);
 	usleep_range(1000, 2000);
 
-	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
+	brcm_sata_phy_wr(port, PLL_REG_BANK_0, PLL_REG_BANK_0_PLLCONTROL_0,
 			 0, 0x3088);
 	usleep_range(1000, 2000);
 
-	brcm_sata_phy_wr(base, AEQRX_REG_BANK_1, AEQRX_SLCAL0_CTRL0,
+	brcm_sata_phy_wr(port, AEQRX_REG_BANK_1, AEQRX_SLCAL0_CTRL0,
 			 0, 0x3000);
 
-	brcm_sata_phy_wr(base, AEQRX_REG_BANK_1, AEQRX_SLCAL1_CTRL0,
+	brcm_sata_phy_wr(port, AEQRX_REG_BANK_1, AEQRX_SLCAL1_CTRL0,
 			 0, 0x3000);
 	usleep_range(1000, 2000);
 
-	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_CAP_CHARGE_TIME, 0, 0x32);
+	brcm_sata_phy_wr(port, PLL_REG_BANK_0, PLL_CAP_CHARGE_TIME, 0, 0x32);
 
-	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_VCO_CAL_THRESH, 0, 0xa);
+	brcm_sata_phy_wr(port, PLL_REG_BANK_0, PLL_VCO_CAL_THRESH, 0, 0xa);
 
-	brcm_sata_phy_wr(base, PLL_REG_BANK_0, PLL_FREQ_DET_TIME, 0, 0x64);
+	brcm_sata_phy_wr(port, PLL_REG_BANK_0, PLL_FREQ_DET_TIME, 0, 0x64);
 	usleep_range(1000, 2000);
 
 	/* Acquire PLL lock */
 	try = 50;
 	while (try) {
-		tmp = brcm_sata_phy_rd(base, BLOCK0_REG_BANK,
+		tmp = brcm_sata_phy_rd(port, BLOCK0_REG_BANK,
 				       BLOCK0_XGXSSTATUS);
 		if (tmp & BLOCK0_XGXSSTATUS_PLL_LOCK)
 			break;
@@ -687,10 +670,9 @@ static int brcm_sata_phy_init(struct phy *phy)
 
 static void brcm_stb_sata_calibrate(struct brcm_sata_port *port)
 {
-	void __iomem *base = brcm_sata_pcb_base(port);
 	u32 tmp = BIT(8);
 
-	brcm_sata_phy_wr(base, RXPMD_REG_BANK, RXPMD_RX_FREQ_MON_CONTROL1,
+	brcm_sata_phy_wr(port, RXPMD_REG_BANK, RXPMD_RX_FREQ_MON_CONTROL1,
 			 ~tmp, tmp);
 }
 
-- 
2.7.4

