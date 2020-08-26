Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2DEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C85A120737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8qHUgT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgHZRMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZRMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:12:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3F4C061574;
        Wed, 26 Aug 2020 10:12:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t9so1299707pfq.8;
        Wed, 26 Aug 2020 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pWsykbGqpNMPIeS7QNwd3DXqT62rEDsUA7ZuK6mgUe0=;
        b=P8qHUgT/f8YdQmri0xIKdziJ9BrKLY8EfuwXZP+P4eJFebIj1t77notUk34Cj2fsDz
         +RGw/2XWJZ4uriB+kRhgSapQjqCiKIzRv4ZiXg08MVw2OY8RwEep7vDFRpCZqjaFbMWQ
         J5Eyuo6ttyknfG1Bvc8/+d7lgInTRE75WVJE5E9ieWf09+G2lzeb9ietAY3XWJRSYW9b
         lHyjl8NvMBY7y09OfeA/kw9bsY6yrU4xnGPkqFipGV2hcIOAxEimXoT+tXUf8itkTWbw
         nvfIituZBRqHF58AL9l8UONAO8kOujGjvPeyrKeAb3ViUDE0ae5xIYOE++8uPd7F1bOL
         EyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pWsykbGqpNMPIeS7QNwd3DXqT62rEDsUA7ZuK6mgUe0=;
        b=oVMCvB81VjwhJz9oZnarlxXwOuslzCdVlhS1h6Cs+WceczK4cRzlNmTnm2fTC6iFtd
         Vvs3/PKEg2tfM4TLfHMQ9DaH185SFp9rDVJCNPnja+704RDMbEUhCK7VaxrDJCpoCIsQ
         5LdPYZlhvGOgayel2694l85l/UmRqISRkrcEwbTXGITfesYaESV9yrbjR/yF1K0iOJiF
         xoZ+7nh57y9gyJTbSOk5972CkLm4/VKCEsO0tWeCz/w+h4p2ENR8EiDkKItwgAcmJShU
         Lc3MUKjFw5HEPaS4S0MRa7isHr05OAGz1nMn6ZCbeGwwuhGxwqB7kmtlJ2xO6WPmcgO7
         EMcg==
X-Gm-Message-State: AOAM5308xbwDWUqwCb3er8yOz4fQLwrmb3tE7ehRUMJCcbCBLvDjVSJB
        rzS5NJjOHAKX5njEfRYwogh7Ovxkd08=
X-Google-Smtp-Source: ABdhPJzt+yaCKzMdYl1Uj7hSMNvSFk2qRYcVY1aIh0m33TdWEHtaHj8uxb3pEdTD3pOEXLiaDY/JKQ==
X-Received: by 2002:a62:52d6:: with SMTP id g205mr13357990pfb.144.1598461959475;
        Wed, 26 Aug 2020 10:12:39 -0700 (PDT)
Received: from localhost.localdomain (cpe-172-112-234-200.socal.res.rr.com. [172.112.234.200])
        by smtp.gmail.com with ESMTPSA id z10sm1957870pjt.30.2020.08.26.10.12.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 10:12:39 -0700 (PDT)
From:   lindsey.stanpoor@gmail.com
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, heiko@sntech.de,
        balbi@kernel.org, cnemo@tutanota.com
Subject: [PATCH 3/4] arm64: dts: rockchip: rk3328 usb3 controller node
Date:   Wed, 26 Aug 2020 10:12:29 -0700
Message-Id: <20200826171230.17041-1-lindsey.stanpoor@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826170623.15469-1-travelvia@airmail.cc>
References: <20200826170623.15469-1-travelvia@airmail.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cameron Nemo <cnemo@tutanota.com>

RK3328 SoCs have one USB 3.0 OTG controller which uses DWC_USB3
core's general architecture. It can act as static xHCI host
controller, static device controller, USB 3.0/2.0 OTG basing
on ID of USB3.0 PHY.

Signed-off-by: William Wu <william.wu@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index bbdb19a3e85d..27e86bf06d3e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -983,6 +983,33 @@ usb_host0_ohci: usb@ff5d0000 {
 		status = "disabled";
 	};
 
+	usbdrd3: usb@ff600000 {
+		compatible = "rockchip,rk3328-dwc3";
+		clocks = <&cru SCLK_USB3OTG_REF>, <&cru SCLK_USB3OTG_SUSPEND>,
+			 <&cru ACLK_USB3OTG>;
+		clock-names = "ref_clk", "suspend_clk",
+			      "bus_clk";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		status = "disabled";
+
+		usbdrd_dwc3: dwc3@ff600000 {
+			compatible = "snps,dwc3";
+			reg = <0x0 0xff600000 0x0 0x100000>;
+			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			dr_mode = "otg";
+			phy_type = "utmi_wide";
+			snps,dis_enblslpm_quirk;
+			snps,dis-u2-freeclk-exists-quirk;
+			snps,dis_u2_susphy_quirk;
+			snps,dis_u3_susphy_quirk;
+			snps,dis-del-phy-power-chg-quirk;
+			snps,dis-tx-ipgap-linecheck-quirk;
+			status = "disabled";
+		};
+	};
+
 	gic: interrupt-controller@ff811000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
-- 
2.28.0

