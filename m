Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A2FC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D342071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 07:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPVFrVjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732008AbgDAHM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:12:27 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:46892 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731725AbgDAHM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 03:12:26 -0400
Received: by mail-pl1-f179.google.com with SMTP id s23so9233718plq.13;
        Wed, 01 Apr 2020 00:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5KAdQlZkZucdmB3trGRi9PLnnMN8nfwPNpw1u3apZq4=;
        b=dPVFrVjWbj9FLuvfYXpdX4zfEnHNrCL65Wmxp/7L5+gmHoKpHxqZrLLicmOFTwn6LG
         sTU7vvtxJ7y0crwfBqjknTuq/hExS2W5MUbuidaUmPCcm0fj20WU0/b+MSNBZmPQRLyx
         4eN8Q6i0jcd/PD8X/RC0E1x8F7aQnjQXg70TkJx1TEDUoPF0sKIIWJI2WAV575t/GNt9
         UurBqLO0z3mGuyD5kp9sorAiebw0qqBlzwBIYsqLrKBLIgAaC6b6cGhQ9SBIDTGlgD9X
         at5QB6oyW44HOZn1K/jUZRCNAcvIhorPEHb6US5AsXFT33Ry+VSiS+Jc+IWdXradWEyQ
         DrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KAdQlZkZucdmB3trGRi9PLnnMN8nfwPNpw1u3apZq4=;
        b=AzvFOh1jMKxgVZcVpxPTLrzpkxZZk/1wBE+h9hqe2EXIHqNHx/oSKlMPulvdL6y0ki
         DASRMSKAV9VcFSTFk6W177G5UP8PlIbtlbZL4plliWreRuyZH507Ahxx5k++nuUt/0wp
         f/SKSQJJKEw8RnzNCozH92l83dUQMfX/rm6LERY05Tvi5IsVilqB4hpwOsSth7TGuyIR
         T//fYr94/4ZdMNG6gk3/W0WxclvOHbk1whsRyPEhjmbI0/hMCSQZPWLEMX+PS4I56kFt
         5qqCoiyPsKybzP5Ua7CazW0LA1WsTrLw3EgSqiBx3YczrylS8+9FB13pnmKlYYXhcryg
         qhzg==
X-Gm-Message-State: ANhLgQ1QpVQvIdOZ60n6L0aK1zzn2MGyQc2qZ5p5+iXn15bToBU4j8Dq
        LXje2QdrG6ayCKwHNJBCvCo=
X-Google-Smtp-Source: ADFU+vsTb7yMmocQDiYbBd/Q7D2CwqHGG0zydGcYlu5fuPasG/DB5HZiGDr+ZHizQxmbo705d7eCYQ==
X-Received: by 2002:a17:902:9b95:: with SMTP id y21mr21218346plp.101.1585725144667;
        Wed, 01 Apr 2020 00:12:24 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id n7sm784519pgm.28.2020.04.01.00.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 00:12:24 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 1/2] arm64: dts: Add SC9863A clock nodes
Date:   Wed,  1 Apr 2020 15:11:43 +0800
Message-Id: <20200401071144.10424-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401071144.10424-1-zhang.lyra@gmail.com>
References: <20200401071144.10424-1-zhang.lyra@gmail.com>
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
index cd80756c888d..586c7488c12b 100644
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

