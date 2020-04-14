Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929F4C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBB120644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvMNYnCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438240AbgDNKSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438198AbgDNKRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:17:21 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4ADC061A0E;
        Tue, 14 Apr 2020 03:17:21 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t40so5013171pjb.3;
        Tue, 14 Apr 2020 03:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUOLAwdQkTXgo8GxSTlp4NyKaqeAihboXxkrwgIJ9RQ=;
        b=nvMNYnCvxU6AXKDQhE4/xaM6Vq/nl6lCTgWKQvCT5tFYoJOD5/xm+34M2OplTWeqQD
         hsZ0FguECz5/A18R/Tpb8Udd/StKTYdla6NdnupKLdSmhcB6YWStf3xyFK+XnbSyVxV4
         CqrMMqKkrcgBAv2AiHhFeiSChZZ2pX/HAb90OKPHbgI0K6p14VtTmQnQN3jR1Ip1gNoy
         JHotoaZPV/ga86064t0Schj/CP/DISaD11C5y66w8Ze9JexitsaVYcGpILdy0q7ZxVb5
         9KhcZp7wscQ3pXjiB33GyQPQnIiOHmiKpcMek8qaqeaIXC+xzmJupdrUgWWg01p6H0jb
         3e+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUOLAwdQkTXgo8GxSTlp4NyKaqeAihboXxkrwgIJ9RQ=;
        b=UpoGkTBEXMdG6NvyB2M736IVQv9dSQ7TRQfB9pgpjJxI0WGszM+7wUS6GtzIXOFroH
         9um3Bf0rr079/0b1wLWCpTu6FXBnW6DdAuq9pgDX/OF2Ka6DJPgJpqUoiO+vVQVz7ARX
         7rVakZnk2B0rEA6vn+vSPm7zGp78Uj+sDHcOPvy10zhgqjnmZ7hUrnQDt5FRdtGKsxrZ
         S+8clejvcxc7JRtoaeoQ07iSoDZdrE26F7/0FD26mzsQngZpwsGDp1rCQzIBvfiOK3PA
         ssHblJ1VUVbErhpIKlnEaWGScTbrCvIBEZInwFHcBZAQ1fqL40dHOHBjq966VJnOIbT4
         oOyg==
X-Gm-Message-State: AGi0PubNa9NY04zfGc3exAAMsH9DstEBRSxV9Bl3ahfRRJLUGO1GTk50
        4F6Kv6XAXCCeRYPzOYmUbVY=
X-Google-Smtp-Source: APiQypJv1NfGPCNfYcDnmJ54hke2+5RWOeQi45K2wFlPc3nsOkE24bFzWV8H1+zcaCryc79RTgEN5g==
X-Received: by 2002:a17:90a:7784:: with SMTP id v4mr27999180pjk.30.1586859441192;
        Tue, 14 Apr 2020 03:17:21 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r189sm9870182pgr.31.2020.04.14.03.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 03:17:20 -0700 (PDT)
From:   zhang.lyra@gmail.com
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [RESEND PATCH 1/2] arm64: dts: Add SC9863A clock nodes
Date:   Tue, 14 Apr 2020 18:16:35 +0800
Message-Id: <20200414101636.24503-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414101636.24503-1-zhang.lyra@gmail.com>
References: <20200414101636.24503-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

add clock devicetree nodes for SC9863A.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 arch/arm64/boot/dts/sprd/sc9863a.dtsi |  24 ++++
 arch/arm64/boot/dts/sprd/sharkl3.dtsi | 164 ++++++++++++++++++++++++++
 2 files changed, 188 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc9863a.dtsi b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
index 2c590ca1d079..1ad6f6e95bca 100644
--- a/arch/arm64/boot/dts/sprd/sc9863a.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9863a.dtsi
@@ -159,6 +159,30 @@
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		ap_clk: clock-controller@21500000 {
+			compatible = "sprd,sc9863a-ap-clk";
+			reg = <0 0x21500000 0 0x1000>;
+			clocks = <&ext_32k>, <&ext_26m>;
+			clock-names = "ext-32k", "ext-26m";
+			#clock-cells = <1>;
+		};
+
+		aon_clk: clock-controller@402d0000 {
+			compatible = "sprd,sc9863a-aon-clk";
+			reg = <0 0x402d0000 0 0x1000>;
+			clocks = <&ext_26m>, <&rco_100m>,
+				 <&ext_32k>, <&ext_4m>;
+			clock-names = "ext-26m", "rco-100m",
+				      "ext-32k", "ext-4m";
+			#clock-cells = <1>;
+		};
+
+		mm_clk: clock-controller@60900000 {
+			compatible = "sprd,sc9863a-mm-clk";
+			reg = <0 0x60900000 0 0x1000>;
+			#clock-cells = <1>;
+		};
+
 		funnel@10001000 {
 			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 			reg = <0 0x10001000 0 0x1000>;
diff --git a/arch/arm64/boot/dts/sprd/sharkl3.dtsi b/arch/arm64/boot/dts/sprd/sharkl3.dtsi
index 0222128b10f7..206a4afdab1c 100644
--- a/arch/arm64/boot/dts/sprd/sharkl3.dtsi
+++ b/arch/arm64/boot/dts/sprd/sharkl3.dtsi
@@ -16,6 +16,149 @@
 		#size-cells = <2>;
 		ranges;
 
+		ap_ahb_regs: syscon@20e00000 {
+			compatible = "sprd,sc9863a-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x20e00000 0 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x20e00000 0x4000>;
+
+			apahb_gate: apahb-gate {
+				compatible = "sprd,sc9863a-apahb-gate";
+				reg = <0x0 0x1020>;
+				#clock-cells = <1>;
+			};
+		};
+
+		pmu_regs: syscon@402b0000 {
+			compatible = "sprd,sc9863a-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x402b0000 0 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x402b0000 0x4000>;
+
+			pmu_gate: pmu-gate {
+				compatible = "sprd,sc9863a-pmu-gate";
+				reg = <0 0x1200>;
+				clocks = <&ext_26m>;
+				clock-names = "ext-26m";
+				#clock-cells = <1>;
+			};
+		};
+
+		aon_apb_regs: syscon@402e0000 {
+			compatible = "sprd,sc9863a-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x402e0000 0 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x402e0000 0x4000>;
+
+			aonapb_gate: aonapb-gate {
+				compatible = "sprd,sc9863a-aonapb-gate";
+				reg = <0 0x1100>;
+				#clock-cells = <1>;
+			};
+		};
+
+		anlg_phy_g2_regs: syscon@40353000 {
+			compatible = "sprd,sc9863a-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x40353000 0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x40353000 0x3000>;
+
+			pll: pll {
+				compatible = "sprd,sc9863a-pll";
+				reg = <0 0x100>;
+				clocks = <&ext_26m>;
+				clock-names = "ext-26m";
+				#clock-cells = <1>;
+			};
+		};
+
+		anlg_phy_g4_regs: syscon@40359000 {
+			compatible = "sprd,sc9863a-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x40359000 0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x40359000 0x3000>;
+
+			mpll: mpll {
+				compatible = "sprd,sc9863a-mpll";
+				reg = <0 0x100>;
+				#clock-cells = <1>;
+			};
+		};
+
+		anlg_phy_g5_regs: syscon@4035c000 {
+			compatible = "sprd,sc9863a-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x4035c000 0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x4035c000 0x3000>;
+
+			rpll: rpll {
+				compatible = "sprd,sc9863a-rpll";
+				reg = <0 0x100>;
+				clocks = <&ext_26m>;
+				clock-names = "ext-26m";
+				#clock-cells = <1>;
+			};
+		};
+
+		anlg_phy_g7_regs: syscon@40363000 {
+			compatible = "sprd,sc9863a-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x40363000 0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x40363000 0x3000>;
+
+			dpll: dpll {
+				compatible = "sprd,sc9863a-dpll";
+				reg = <0 0x100>;
+				#clock-cells = <1>;
+			};
+		};
+
+		mm_ahb_regs: syscon@60800000 {
+			compatible = "sprd,sc9863a-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x60800000 0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x60800000 0x3000>;
+
+			mm_gate: mm-gate {
+				compatible = "sprd,sc9863a-mm-gate";
+				reg = <0 0x1100>;
+				#clock-cells = <1>;
+			};
+		};
+
+		ap_apb_regs: syscon@71300000 {
+			compatible = "sprd,sc9863a-glbregs", "syscon",
+				     "simple-mfd";
+			reg = <0 0x71300000 0 0x4000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0x71300000 0x4000>;
+
+			apapb_gate: apapb-gate {
+				compatible = "sprd,sc9863a-apapb-gate";
+				reg = <0 0x1000>;
+				clocks = <&ext_26m>;
+				clock-names = "ext-26m";
+				#clock-cells = <1>;
+			};
+		};
+
 		apb@70000000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -75,4 +218,25 @@
 		clock-frequency = <26000000>;
 		clock-output-names = "ext-26m";
 	};
+
+	ext_32k: ext-32k {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "ext-32k";
+	};
+
+	ext_4m: ext-4m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <4000000>;
+		clock-output-names = "ext-4m";
+	};
+
+	rco_100m: rco-100m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <100000000>;
+		clock-output-names = "rco-100m";
+	};
 };
-- 
2.20.1

