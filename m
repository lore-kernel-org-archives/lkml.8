Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22D0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D87120870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxJ/zlkh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgGCRF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgGCRFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:05:20 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765EDC061794;
        Fri,  3 Jul 2020 10:05:20 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d15so28387001edm.10;
        Fri, 03 Jul 2020 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cfJDNDiCKk3+L9P05A8vdENIHzaVIv1gfHJ7Qxk7/lY=;
        b=cxJ/zlkhVpDFRvY8eKaErKfPf453gMsXeNFz4QypzWdZi63qTNka1fMoUUEJGKRE2G
         e16WSv3Zqh49oe3xef8fFA8X9dburGZZrdUc1a1qbWuO44HpMZCqHwoU9Lb+jSsN4QWD
         /zNvN4+YmJh4feH/kKtuvXT4cMA82Y8nq/cwKRZ0dR1T/8h2o9ZXCMtHUexMVBf5JdZ2
         vyn0ovkMBowyTm8F/m19hvc7mxxf/hHFwEkpDcBJyyQIoh6sTkufmNrrJr0N0SeL1xmh
         sBXy05rDRU+Hrp/bSPqEiCur+2sWHkxR0Tp1r3CRrp05dqiz4JKZF/aG3d1jwZabPRxO
         ZgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cfJDNDiCKk3+L9P05A8vdENIHzaVIv1gfHJ7Qxk7/lY=;
        b=r2mSgbQx+Phb9LCOD8UCnpV4X2us6b0P3ROmDgW2vpzBzO8Pzl8f1e4mS6t2wVU9ox
         I2kjox936oXX35InvFtjmA2NNoZ+/uOvZ7QEn+4AhTUS/n6SvBhhHYK+pUXJQqyAExVh
         ZqHGJDnNsdGUe2OMYJu1W0/cI/q+t73wONcI0ySwiEeDZyfLU1h1o6LcHHU0ClZDmzqG
         EejKukGU+1Thcdt8Jb4q7d0zFW0bPj1Z96s46LyEp0pXXDQD4wPSTL3/HEz2a3R7m6+v
         RDH8I1BVe04FHbCjYMmdt5UVaa/SYmmlWzE1JZaOxaqYrj5143SgbMad1uUQzaawR8FI
         wnQA==
X-Gm-Message-State: AOAM531IgIwwelUL7viFsj1AaAYIDiuPtEFeS7N1fzmeo/jh7vKewMED
        +9Flxp5RuYIv32st37GOdws=
X-Google-Smtp-Source: ABdhPJzzeZaHXkjhGxP2B+tAANuxO+ql/3PcbhmTrBuwAmzzmUWITzWLBZL2KucyQAbtXpnDDQ9cUQ==
X-Received: by 2002:a05:6402:1d35:: with SMTP id dh21mr36412319edb.186.1593795919224;
        Fri, 03 Jul 2020 10:05:19 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id dg8sm14342272edb.56.2020.07.03.10.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:05:18 -0700 (PDT)
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
Subject: [PATCH v3 3/6] clk: actions: Add APB, DMAC, GPIO clock support for Actions S500 SoC
Date:   Fri,  3 Jul 2020 20:05:09 +0300
Message-Id: <87964ae012e513597b8b4c7be2e7ac332a70087a.1593788312.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
References: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
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
Changes in v3:
 - None

Changes in v2:
 - None

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

