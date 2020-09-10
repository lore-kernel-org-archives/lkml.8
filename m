Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EB9C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9D5206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ddx81Q20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgIJIoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729824AbgIJInP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:43:15 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE7DC061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:43:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id c3so575151plz.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L/4Xswe1tVbEt+VyZpLZ8Ecncq7V2PHXxgjqAkpGaWM=;
        b=Ddx81Q2028XCjXda3WQUN/JfV+7gvnOmVq07tcxMEZuH5m2W9lTVzg1qfm/tui6/y8
         opDmSPbFMVgouFm7GUdLzZkvTwLlTiPQkxPk9Tr028N9kfVY3Tsz27OL8ndIU1KXI2ZX
         jqOQ8Bk4v6H040D3ts9qOQN/+ihrMvStIPOwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L/4Xswe1tVbEt+VyZpLZ8Ecncq7V2PHXxgjqAkpGaWM=;
        b=PiLt2Ut+vtN+jm9JUx+aF3JhUcxElDUvAgReKKF69zELMYNMbTwKMDuK3vnfCSgnUB
         PSmXQC27VrJ36vDB0MQRzHDPgtTvd1SANdDlg36ePfxngSA1H3AszDZNAHwbGNtxBvY6
         A5fGdwv3B6AyB1q+mmTGsozyj08MCP3zuyvWwvfHabx/q1evL5Aa1vFjanUD7ACbNLZ3
         pERK1lRWkZQD/hIO4KipKhyawHxjdgsPtR+YNtSoer7teJRthNZ60k05HMpNYooySmTN
         Cd/rWAxEeZaRgcoFQETRokt2ejYz2NCkG711Y2sgGH5m/cNQJ8L9WqZyCxjIqWBnucgt
         Gmmg==
X-Gm-Message-State: AOAM5327LGugiSJAO66Vg4SOilrhlUSpu0ziHOS7vxIFsP+v2Q5hBtVt
        RrquBZs80r7BC2juCvN0Z40UdeINpS/3YaEq
X-Google-Smtp-Source: ABdhPJyEjD3DEgOoB0pkV8GVysZA4xYfdxxHJRksSsko7ICb4IzBqS75bczDOL25rNltJZ8HZ8ggmw==
X-Received: by 2002:a17:902:aa4b:b029:d0:cbe1:e739 with SMTP id c11-20020a170902aa4bb02900d0cbe1e739mr4891936plr.20.1599727392093;
        Thu, 10 Sep 2020 01:43:12 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id x29sm4357645pga.23.2020.09.10.01.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:43:11 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2 1/2] arm64: dts: mt8173: Set uart to mmio32 iotype
Date:   Thu, 10 Sep 2020 16:43:03 +0800
Message-Id: <20200910084304.3429494-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set uart iotype to mmio32 to make earlycon work with stdout-path.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 5e046f9d48ce9..ca6ea71f5f435 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -613,6 +613,8 @@ uart0: serial@11002000 {
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&pericfg CLK_PERI_UART0_SEL>, <&pericfg CLK_PERI_UART0>;
 			clock-names = "baud", "bus";
+			reg-io-width = <4>;
+			reg-shift = <2>;
 			status = "disabled";
 		};
 
@@ -623,6 +625,8 @@ uart1: serial@11003000 {
 			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&pericfg CLK_PERI_UART1_SEL>, <&pericfg CLK_PERI_UART1>;
 			clock-names = "baud", "bus";
+			reg-io-width = <4>;
+			reg-shift = <2>;
 			status = "disabled";
 		};
 
@@ -633,6 +637,8 @@ uart2: serial@11004000 {
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&pericfg CLK_PERI_UART2_SEL>, <&pericfg CLK_PERI_UART2>;
 			clock-names = "baud", "bus";
+			reg-io-width = <4>;
+			reg-shift = <2>;
 			status = "disabled";
 		};
 
@@ -643,6 +649,8 @@ uart3: serial@11005000 {
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&pericfg CLK_PERI_UART3_SEL>, <&pericfg CLK_PERI_UART3>;
 			clock-names = "baud", "bus";
+			reg-io-width = <4>;
+			reg-shift = <2>;
 			status = "disabled";
 		};
 
-- 
2.28.0.526.ge36021eeef-goog

