Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A44C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A80720DD4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 03:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEgo4t+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgIGDRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 23:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgIGDRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 23:17:47 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A73C061573;
        Sun,  6 Sep 2020 20:17:47 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s2so5773486pjr.4;
        Sun, 06 Sep 2020 20:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TbyyXAL0ZVIbCvfJHraKbkMH1ceMJBrC0mewpz/V3M4=;
        b=QEgo4t+kj1Q9tKC9RCn0PimdSizTSr24mv0V79sv+bs0Er7Dpzk9sVgI1q2cb7wsDS
         ykjHdcLhwVSYLFmSaL2LN640Av0li4OqTKjGkOMn750rFcBtytUPdkbpIOgIQdY8rTYB
         5M3GkYJiN+wHWQo40s4MRBTGNKOG/iRcEzCp6hoHAgw5awcjqMBCQrixwk+dXiX8F1f6
         cp04T9ZJIIi7DCiD1LOA1D93s/eF8vZbg7gfm220h0KzdpkBIPnKwisPpX9Nqv4m/MWz
         j8pJTzpfvPhVnfgCmB/i0bR6epD+oqH5tJi2TxgiM2SiFJv7xScrW5tc42xYZFEtZrWZ
         kPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TbyyXAL0ZVIbCvfJHraKbkMH1ceMJBrC0mewpz/V3M4=;
        b=uK2EWrL0NFeFRXe4aXe5lHCtxQnKoe2MjY4nchW2WV94k+Hih1aCvSN8aBJfPZNpdP
         BbGch+yKHdWxy6SoDlKD1cxuRcmMq2Y5x1ibGLqOvBpP+WLwMhUHdyTsJXL1FgXmpVLK
         J34BL04PQ97aWOzyf+SOGNli3SZYIk/MZzL4rS/ZujxNlbitzzp8SqCOGF6QbLb5Uhe+
         rj6Fxau2zoDBKHMipH1qannW5jac7YTraK6WIlIBMOdInAPE9oAra7fyNL3q4ePQTCqr
         I+/jQtPawPwVCOFNSSuT4Ed+oTkC4NgXC4aWmEagEviWc2SzVQ2O4ahYP5/LJsOYU+AK
         kGNQ==
X-Gm-Message-State: AOAM531NocgnBN4os4dyfWz1lFeW1hXm8Y91okSZFWAOkZ8mClDPytPx
        FrKagbUkp1LA1MZ3/FocYjw=
X-Google-Smtp-Source: ABdhPJyb+hGF5Kdu8DGX3L2+gIol8/bJnLOZrWwLTtvbjQPNQpnHWYU4VqxEfYMi84hucmWtA7qAtA==
X-Received: by 2002:a17:90a:858a:: with SMTP id m10mr17713984pjn.185.1599448666153;
        Sun, 06 Sep 2020 20:17:46 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y13sm6608675pfr.141.2020.09.06.20.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 20:17:45 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] bus: brcmstb_gisb: Add support for breakpoint interrupts
Date:   Sun,  6 Sep 2020 20:17:24 -0700
Message-Id: <20200907031724.3512099-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907031724.3512099-1-f.fainelli@gmail.com>
References: <20200907031724.3512099-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GISB breakpoint interrupts can be raised when a breakpoint has been
enabled to match a specific master and/or GISB register address. Being
able to print a message, similar to those done during target abort or
timeout greatly helps debug systems.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/bus/brcmstb_gisb.c | 96 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/brcmstb_gisb.c b/drivers/bus/brcmstb_gisb.c
index 7579439971e3..7355fa2cb439 100644
--- a/drivers/bus/brcmstb_gisb.c
+++ b/drivers/bus/brcmstb_gisb.c
@@ -30,8 +30,22 @@
 #define  ARB_ERR_CAP_STATUS_WRITE	(1 << 1)
 #define  ARB_ERR_CAP_STATUS_VALID	(1 << 0)
 
+#define  ARB_BP_CAP_CLEAR		(1 << 0)
+#define  ARB_BP_CAP_STATUS_PROT_SHIFT	14
+#define  ARB_BP_CAP_STATUS_TYPE		(1 << 13)
+#define  ARB_BP_CAP_STATUS_RSP_SHIFT	10
+#define  ARB_BP_CAP_STATUS_MASK		GENMASK(1, 0)
+#define  ARB_BP_CAP_STATUS_BS_SHIFT	2
+#define  ARB_BP_CAP_STATUS_WRITE	(1 << 1)
+#define  ARB_BP_CAP_STATUS_VALID	(1 << 0)
+
 enum {
 	ARB_TIMER,
+	ARB_BP_CAP_CLR,
+	ARB_BP_CAP_HI_ADDR,
+	ARB_BP_CAP_ADDR,
+	ARB_BP_CAP_STATUS,
+	ARB_BP_CAP_MASTER,
 	ARB_ERR_CAP_CLR,
 	ARB_ERR_CAP_HI_ADDR,
 	ARB_ERR_CAP_ADDR,
@@ -41,6 +55,11 @@ enum {
 
 static const int gisb_offsets_bcm7038[] = {
 	[ARB_TIMER]		= 0x00c,
+	[ARB_BP_CAP_CLR]	= 0x014,
+	[ARB_BP_CAP_HI_ADDR]	= -1,
+	[ARB_BP_CAP_ADDR]	= 0x0b8,
+	[ARB_BP_CAP_STATUS]	= 0x0c0,
+	[ARB_BP_CAP_MASTER]	= -1,
 	[ARB_ERR_CAP_CLR]	= 0x0c4,
 	[ARB_ERR_CAP_HI_ADDR]	= -1,
 	[ARB_ERR_CAP_ADDR]	= 0x0c8,
@@ -50,6 +69,11 @@ static const int gisb_offsets_bcm7038[] = {
 
 static const int gisb_offsets_bcm7278[] = {
 	[ARB_TIMER]		= 0x008,
+	[ARB_BP_CAP_CLR]	= 0x01c,
+	[ARB_BP_CAP_HI_ADDR]	= -1,
+	[ARB_BP_CAP_ADDR]	= 0x220,
+	[ARB_BP_CAP_STATUS]	= 0x230,
+	[ARB_BP_CAP_MASTER]	= 0x234,
 	[ARB_ERR_CAP_CLR]	= 0x7f8,
 	[ARB_ERR_CAP_HI_ADDR]	= -1,
 	[ARB_ERR_CAP_ADDR]	= 0x7e0,
@@ -59,6 +83,11 @@ static const int gisb_offsets_bcm7278[] = {
 
 static const int gisb_offsets_bcm7400[] = {
 	[ARB_TIMER]		= 0x00c,
+	[ARB_BP_CAP_CLR]	= 0x014,
+	[ARB_BP_CAP_HI_ADDR]	= -1,
+	[ARB_BP_CAP_ADDR]	= 0x0b8,
+	[ARB_BP_CAP_STATUS]	= 0x0c0,
+	[ARB_BP_CAP_MASTER]	= 0x0c4,
 	[ARB_ERR_CAP_CLR]	= 0x0c8,
 	[ARB_ERR_CAP_HI_ADDR]	= -1,
 	[ARB_ERR_CAP_ADDR]	= 0x0cc,
@@ -68,6 +97,11 @@ static const int gisb_offsets_bcm7400[] = {
 
 static const int gisb_offsets_bcm7435[] = {
 	[ARB_TIMER]		= 0x00c,
+	[ARB_BP_CAP_CLR]	= 0x014,
+	[ARB_BP_CAP_HI_ADDR]	= -1,
+	[ARB_BP_CAP_ADDR]	= 0x158,
+	[ARB_BP_CAP_STATUS]	= 0x160,
+	[ARB_BP_CAP_MASTER]	= 0x164,
 	[ARB_ERR_CAP_CLR]	= 0x168,
 	[ARB_ERR_CAP_HI_ADDR]	= -1,
 	[ARB_ERR_CAP_ADDR]	= 0x16c,
@@ -77,6 +111,11 @@ static const int gisb_offsets_bcm7435[] = {
 
 static const int gisb_offsets_bcm7445[] = {
 	[ARB_TIMER]		= 0x008,
+	[ARB_BP_CAP_CLR]	= 0x010,
+	[ARB_BP_CAP_HI_ADDR]	= -1,
+	[ARB_BP_CAP_ADDR]	= 0x1d8,
+	[ARB_BP_CAP_STATUS]	= 0x1e0,
+	[ARB_BP_CAP_MASTER]	= 0x1e4,
 	[ARB_ERR_CAP_CLR]	= 0x7e4,
 	[ARB_ERR_CAP_HI_ADDR]	= 0x7e8,
 	[ARB_ERR_CAP_ADDR]	= 0x7ec,
@@ -125,6 +164,16 @@ static u64 gisb_read_address(struct brcmstb_gisb_arb_device *gdev)
 	return value;
 }
 
+static u64 gisb_read_bp_address(struct brcmstb_gisb_arb_device *gdev)
+{
+	u64 value;
+
+	value = gisb_read(gdev, ARB_BP_CAP_ADDR);
+	value |= (u64)gisb_read(gdev, ARB_BP_CAP_HI_ADDR) << 32;
+
+	return value;
+}
+
 static void gisb_write(struct brcmstb_gisb_arb_device *gdev, u32 val, int reg)
 {
 	int offset = gdev->gisb_offsets[reg];
@@ -259,6 +308,41 @@ static irqreturn_t brcmstb_gisb_tea_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t brcmstb_gisb_bp_handler(int irq, void *dev_id)
+{
+	struct brcmstb_gisb_arb_device *gdev = dev_id;
+	const char *m_name;
+	u32 bp_status;
+	u64 arb_addr;
+	u32 master;
+	char m_fmt[11];
+
+	bp_status = gisb_read(gdev, ARB_BP_CAP_STATUS);
+
+	/* Invalid captured address, bail out */
+	if (!(bp_status & ARB_BP_CAP_STATUS_VALID))
+		return IRQ_HANDLED;
+
+	/* Read the address and master */
+	arb_addr = gisb_read_bp_address(gdev);
+	master = gisb_read(gdev, ARB_BP_CAP_MASTER);
+
+	m_name = brcmstb_gisb_master_to_str(gdev, master);
+	if (!m_name) {
+		snprintf(m_fmt, sizeof(m_fmt), "0x%08x", master);
+		m_name = m_fmt;
+	}
+
+	pr_crit("GISB: breakpoint at 0x%llx [%c], core: %s\n",
+		arb_addr, bp_status & ARB_BP_CAP_STATUS_WRITE ? 'W' : 'R',
+		m_name);
+
+	/* clear the GISB error */
+	gisb_write(gdev, ARB_ERR_CAP_CLEAR, ARB_ERR_CAP_CLR);
+
+	return IRQ_HANDLED;
+}
+
 /*
  * Dump out gisb errors on die or panic.
  */
@@ -317,13 +401,14 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 	struct brcmstb_gisb_arb_device *gdev;
 	const struct of_device_id *of_id;
 	struct resource *r;
-	int err, timeout_irq, tea_irq;
+	int err, timeout_irq, tea_irq, bp_irq;
 	unsigned int num_masters, j = 0;
 	int i, first, last;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	timeout_irq = platform_get_irq(pdev, 0);
 	tea_irq = platform_get_irq(pdev, 1);
+	bp_irq = platform_get_irq(pdev, 2);
 
 	gdev = devm_kzalloc(&pdev->dev, sizeof(*gdev), GFP_KERNEL);
 	if (!gdev)
@@ -356,6 +441,15 @@ static int __init brcmstb_gisb_arb_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
+	/* Interrupt is optional */
+	if (bp_irq > 0) {
+		err = devm_request_irq(&pdev->dev, bp_irq,
+				       brcmstb_gisb_bp_handler, 0, pdev->name,
+				       gdev);
+		if (err < 0)
+			return err;
+	}
+
 	/* If we do not have a valid mask, assume all masters are enabled */
 	if (of_property_read_u32(dn, "brcm,gisb-arb-master-mask",
 				&gdev->valid_mask))
-- 
2.25.1

