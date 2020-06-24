Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1A5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E07620738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTNlK59S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405718AbgFXRsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405622AbgFXRsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:48:07 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA1DC0613ED;
        Wed, 24 Jun 2020 10:48:07 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t21so2117751edr.12;
        Wed, 24 Jun 2020 10:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QrtlUREQq2lhgOt3whoJddN27v5YME2qlHZx5rQeOQQ=;
        b=mTNlK59SgtgH3xgd7hSS4TlXWhJQfTLzCQ7KDPqXwIiiX4DNtPjVfk/IIPfpk3FK7t
         ZJH8z2wotpsqXXz0A+nwxAXR2KZjHP3E97n8v4r3CLjEKtN7/xpG+DvS1OQDEKkGB9D0
         5/bl5uqkdqxUBuX+pfL8r8Pn0Dm2qQI6Y72Nx+xiPBs063dkbVrhaJSYnhEdUZbSSVUo
         piQ+C9q+YJsDU2bw+8yLCKZHyJ6J/PBTzFD4Rc1invD38GMXTgL14E+FKunNenA3Evcl
         ei1S//3sqdbAlVKc2ok/JH/sEYhMrhaFKRftAVE475w+1g8X4KABtf2pI+Q3IkSzF9AT
         MynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QrtlUREQq2lhgOt3whoJddN27v5YME2qlHZx5rQeOQQ=;
        b=QBoKMy4rSaD9Iq4DkD0ga1FIK5+001xWZZC3BrSBpiBPfzKxpQdIJ3p2OT56cxMVBw
         AnZspKfIXc4HFDgtgSsodsFCiVMFOLFPYzDdjTFAsCnNLjw/3tOuBfnJkKzl5bRUxtmH
         q5ktFhEokkun+hp03wqW4ntI1Vds1wychARpyOomqMFk8Rx1VHv6sucCnTkjZo9E7fmQ
         w5XogSu4Cygd1uQqajjDY5fyhAbHOEkIhYrlTOwc0ImKxzhgqFzw9xLm7f7IkPF8rB2K
         yRgDrUSMIHxRvfCHnPtXIDTKh0ogleozFT4ueB7t6Qz10DXcc+fxBNm2nT1DCBZomkc4
         GeHw==
X-Gm-Message-State: AOAM531gsczE+4+73/y0Dyc/9BV1jMi1JeHBkp2fDNlyUdjgYccJaTJv
        +GYcs2KbkteH6lI2ooncElU=
X-Google-Smtp-Source: ABdhPJwcHJuThPgeqtWDTFBFLi15quHbrXpJ8gAAL5yjdhw7yYY01eVW5g/aGXwqodMR8N6IOYOkIg==
X-Received: by 2002:a50:d302:: with SMTP id g2mr28172690edh.312.1593020884180;
        Wed, 24 Jun 2020 10:48:04 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id s14sm8044146edq.36.2020.06.24.10.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 10:48:03 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v2 3/6] clk: actions: Add APB, DMAC, GPIO clock support for Actions S500 SoC
Date:   Wed, 24 Jun 2020 20:47:54 +0300
Message-Id: <c19a690f6c296dc17fe98d86c90ab8cdce4be3d4.1592941257.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
References: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the missing APB, DMAC and GPIO clocks in the Actions
Semi S500 SoC clock driver.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/clk/actions/owl-s500.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index 0eb83a0b70bc..025a8f6d6482 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -175,6 +175,8 @@ static OWL_MUX(dev_clk, "dev_clk", dev_clk_mux_p, CMU_DEVPLL, 12, 1, CLK_SET_RAT
 static OWL_MUX(ahbprediv_clk, "ahbprediv_clk", ahbprediv_clk_mux_p, CMU_BUSCLK1, 8, 3, CLK_SET_RATE_PARENT);
 
 /* gate clocks */
+static OWL_GATE(gpio_clk, "gpio_clk", "apb_clk", CMU_DEVCLKEN0, 18, 0, 0);
+static OWL_GATE(dmac_clk, "dmac_clk", "h_clk", CMU_DEVCLKEN0, 1, 0, 0);
 static OWL_GATE(spi0_clk, "spi0_clk", "ahb_clk", CMU_DEVCLKEN1, 10, 0, CLK_IGNORE_UNUSED);
 static OWL_GATE(spi1_clk, "spi1_clk", "ahb_clk", CMU_DEVCLKEN1, 11, 0, CLK_IGNORE_UNUSED);
 static OWL_GATE(spi2_clk, "spi2_clk", "ahb_clk", CMU_DEVCLKEN1, 12, 0, CLK_IGNORE_UNUSED);
@@ -184,6 +186,7 @@ static OWL_GATE(hdmi_clk, "hdmi_clk", "hosc", CMU_DEVCLKEN1, 3, 0, 0);
 
 /* divider clocks */
 static OWL_DIVIDER(h_clk, "h_clk", "ahbprediv_clk", CMU_BUSCLK1, 12, 2, NULL, 0, 0);
+static OWL_DIVIDER(apb_clk, "apb_clk", "ahb_clk", CMU_BUSCLK1, 14, 2, NULL, 0, 0);
 static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNETPLL, 1, 1, rmii_ref_div_table, 0, 0);
 
 /* factor clocks */
@@ -428,6 +431,9 @@ static struct owl_clk_common *s500_clks[] = {
 	&spdif_clk.common,
 	&nand_clk.common,
 	&ecc_clk.common,
+	&apb_clk.common,
+	&dmac_clk.common,
+	&gpio_clk.common,
 };
 
 static struct clk_hw_onecell_data s500_hw_clks = {
@@ -484,6 +490,9 @@ static struct clk_hw_onecell_data s500_hw_clks = {
 		[CLK_SPDIF]		= &spdif_clk.common.hw,
 		[CLK_NAND]		= &nand_clk.common.hw,
 		[CLK_ECC]		= &ecc_clk.common.hw,
+		[CLK_APB]		= &apb_clk.common.hw,
+		[CLK_DMAC]		= &dmac_clk.common.hw,
+		[CLK_GPIO]		= &gpio_clk.common.hw,
 	},
 	.num = CLK_NR_CLKS,
 };
-- 
2.27.0

