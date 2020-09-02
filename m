Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C79C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABB221548
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxEbMn96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgIBSNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgIBSMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:12:46 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF63C061244;
        Wed,  2 Sep 2020 11:12:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so121040plk.10;
        Wed, 02 Sep 2020 11:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pWsykbGqpNMPIeS7QNwd3DXqT62rEDsUA7ZuK6mgUe0=;
        b=WxEbMn96nCk7Orng83K51j8Z5PKJ9KBE+VZFpMKQg1zItgEdlE5fb874SHvpQrwAit
         SsgCm9niapZV1Ckync4r6AJUaWqV7vEqU1DsPhePPIGwyYTlCfVE3d45AI9uu4F8xq95
         aGyStOm02q7L1uu5sP0lUw8mjtbCM8aWce+JU79s43HWXPsy7h+O0DsSEBzBxfLhcrOg
         K3A2dLiT1P2mRaOr45eZX/vFm8gJMMxpL3t71f3DsQDyUFl/jQR8vadSI4cIuP85j+nh
         dLOacYC/MKkd+ULJm7aFyIz7s4qXwa+06jo0VA9D3w55sQ8c7sucBBUvz86+fec6jWKd
         Y3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pWsykbGqpNMPIeS7QNwd3DXqT62rEDsUA7ZuK6mgUe0=;
        b=XRZxucb3rpeyADfl2uO7LaZXQWmS1ZD9/YSsjgA8D8bMbDmumbncwXxKmEfv0KzLgz
         ++1e2Ym3eRrFDcQEpig5tFC/UokIff+IkdvoqCpn/BfcxBlrgnJgGcsS/onXtw53XnM8
         2IWih1oiQG9HdCPEq0sHQ7m/XfFqSmvp4lfHP/v0sRRV0DtRHp0l0HDYfK2adj0yQIpF
         ZfuWn5dOkfd3nzdu6QyflJ9/gGWPicJv32QITcw4nw0xdH+DTF1trBj9x95vHGobxnyv
         R4BblHe9DMq9TrGjpiNfQkGvQHWjZHBDrp1LFpLE3zqJydQJB/ixGDtcE5z+0e9ub5dr
         R3rQ==
X-Gm-Message-State: AOAM5311PZCb+7J+XPkQFGLAOhayPUxicBLNagb/4AkxJkcSaqyyYXCJ
        5FjF4Pjyz9KEEYvxkfneJ0LtcqqVrBk=
X-Google-Smtp-Source: ABdhPJxfIMd3Dxc0t5DBZ8DoFvzrqabA5XaOKtJi8gxVtfxxTzZWmi0Av3BLO0zZJWZGUBl0axRREg==
X-Received: by 2002:a17:90b:20d1:: with SMTP id ju17mr3065949pjb.134.1599070365290;
        Wed, 02 Sep 2020 11:12:45 -0700 (PDT)
Received: from localhost.localdomain (cpe-172-112-234-200.socal.res.rr.com. [172.112.234.200])
        by smtp.gmail.com with ESMTPSA id u123sm148993pfb.209.2020.09.02.11.12.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2020 11:12:44 -0700 (PDT)
From:   lindsey.stanpoor@gmail.com
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, heiko@sntech.de,
        balbi@kernel.org, cnemo@tutanota.com
Subject: [PATCH v4 3/4] arm64: dts: rockchip: rk3328 usb3 controller node
Date:   Wed,  2 Sep 2020 11:12:33 -0700
Message-Id: <20200902181234.13955-3-lindsey.stanpoor@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902181234.13955-1-lindsey.stanpoor@gmail.com>
References: <20200902181234.13955-1-lindsey.stanpoor@gmail.com>
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

