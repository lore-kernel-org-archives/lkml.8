Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB46C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 00:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E67620758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 00:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjwVvKkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgGMAZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 20:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbgGMAZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 20:25:23 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B7DC061794;
        Sun, 12 Jul 2020 17:25:22 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x62so8800365qtd.3;
        Sun, 12 Jul 2020 17:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=okBx7c23F7f5k4i72k982zu3s0srBhuRGGNWTz+lcgU=;
        b=kjwVvKkn8vMu0rcKHnD7nAhnOJ/IC2+HXBKgQmVAk/GUbw2JvY82qR9o6bkywcsB5e
         goKgi+zdC/oi0BRYDaNJqfNkCvewYgcd/3hdmLPxLWeMuSyd6D1PZAM5sfk8MSg7jH7D
         YDZb2fQlObK5vqkdViegI3UTNGYLl18SCNVGiTK6kOkDxU3DroVXslJteLkb61h+QK3m
         qGB86o8swJG6Vdxid92hFBB6geXiYgZIMyLRfFo4wT/lG24k9uotXGjvdqhDIetrqGAO
         pHmpwvQf2OnXf16ElVaqsbxAPO9b+UlVcjYsqy/yCf92ny5s86r9gg2VUaTnzhDWpDv1
         +GVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=okBx7c23F7f5k4i72k982zu3s0srBhuRGGNWTz+lcgU=;
        b=k+dtVJX28mVOXjIWgsM2RO4S94+GpywRLPS5uxdNZKBSyZE/t4fd+HT9EkWLZG9LC8
         RrHBS7GGBcNXsUeZeZPgavdukqGwCTUJr7/tq90g69z13NF2B5jGARRW7YSpHX1rUtkK
         pNwCnrDhz99iiyfqj4Y5Oj1V2qLRL6U0SCTifxfOWHvxpHy20NhninxbmZWP054EpoSK
         KxezJACP7fhDAm9R6lY6EeNSjJaky1iA7nWJPrXqwqlxqxpfpwuiWy43SWAasOK9U9bC
         D9WbPZ3a27sCvuOYWxTTokJjGQaPDDNZmuA82AtO7KayL8Q0yHC6h/7ePsBJdHyP+Wx2
         20/g==
X-Gm-Message-State: AOAM5306zx23m9vykDibkv6NVEk14Dw3W1Hngo477x6J/6JbaLn18U+s
        VtAKibUyuqQMhrz0KN2PGvY=
X-Google-Smtp-Source: ABdhPJwoixAe+QV/qqPel2PVdPE3MD9StGNsTAnpK4/qV7nab60fb7jYsACC3Yop/zfPb59z3l5KNA==
X-Received: by 2002:ac8:4ccb:: with SMTP id l11mr79978575qtv.18.1594599921681;
        Sun, 12 Jul 2020 17:25:21 -0700 (PDT)
Received: from localhost.localdomain ([72.53.229.195])
        by smtp.gmail.com with ESMTPSA id u5sm17044309qke.32.2020.07.12.17.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 17:25:21 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v1 5/5] ARM: dts: imx6qp: support improved enet clocking on QuadPlus
Date:   Sun, 12 Jul 2020 20:25:12 -0400
Message-Id: <20200713002512.28742-6-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200713002512.28742-1-TheSven73@gmail.com>
References: <20200713002512.28742-1-TheSven73@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Board designers are now able to choose between all three supported
enet clocking methods, by changing the clocktree via the devicetree:

a) route enet_ref externally from pad to pad (the default):

no clock tree changes required

b) route internally on SoC from enet_ref

&fec {
    assigned-clocks = <&clks IMX6QDL_CLK_ENET_PTP>,
                      <&clks IMX6QDL_CLK_ENET_REF>;
    assigned-clock-parents = <&clks IMX6QDL_CLK_ENET_REF>;
    assigned-clock-rates = <0>, <125000000>;
};

c) route external clock (from PHY or oscillator) via pad

/ {
    clocks {
        phy_osc: anaclk3 {
            compatible = "fixed-clock";
            #clock-cells = <0>;
            clock-frequency = <125000000>;
       };
   };
};

&fec {
    assigned-clocks = <&clks IMX6QDL_CLK_ENET_PTP>,
                      <&clks IMX6QDL_CLK_ENET_PAD>;
    assigned-clock-parents = <&clks IMX6QDL_CLK_ENET_PAD>,
                             <&clks IMX6QDL_CLK_ANACLK3>;
};

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---

Tree: v5.8-rc4

To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-clk@vger.kernel.org

 arch/arm/boot/dts/imx6qp.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
index b310f13a53f2..7f81d35f56c9 100644
--- a/arch/arm/boot/dts/imx6qp.dtsi
+++ b/arch/arm/boot/dts/imx6qp.dtsi
@@ -79,6 +79,9 @@
 &fec {
 	interrupts = <0 118 IRQ_TYPE_LEVEL_HIGH>,
 		     <0 119 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clks IMX6QDL_CLK_ENET>,
+		 <&clks IMX6QDL_CLK_ENET>,
+		 <&clks IMX6QDL_CLK_ENET_PTP>;
 };
 
 &gpc {
-- 
2.17.1

