Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8753AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E73C20738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZlKQmE5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgHUKig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728706AbgHUKhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:37:03 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93828C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:37:03 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id r4so702623pls.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ogu4zyI9T8PI1xsyrjjgzgW28SyITF1aMpk9WZWLBQ=;
        b=ZlKQmE5huNd3UC53+O+Z+U4Qjo+JXEG8uEmbtaFdRBZ6vfyId9xLnIiSmQBMFiaSCw
         OpJoP4ZvIjPV1X5EmqOuc0/oJ78KXHxxWHukmwYwHMLZTiJ38A0Y/4IA51915uLewcAD
         8IKcKsIwyModqp0ppwQtyBh+5CXGDdjO8HkAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ogu4zyI9T8PI1xsyrjjgzgW28SyITF1aMpk9WZWLBQ=;
        b=GaygGZWf1VNqvoR2t1lVQpV0XFwpc+OyS4YW7mdu85kCuojJNZFes3cK8zvTzvMW+2
         USUuAHGJA5ecm7AapVnpYh0DxBI4FJ7f3/FYn6x41owE/9jLISgo8sGPUhaCvhRZ18JI
         NP3G07o5jcjks8iyEM9lN7F2//qatB89g7Ir6FABwXrfeE+TcKdW+5FcwUTlIoYqiQQE
         zwjO5Mf0bEhig2XWTllwk0ZtfSo2hLvol+xoD6volZEN3766DLk1CxD95s43qPInvNfH
         A6RFQ1I6rh0bqhbYEkwzjP/W1FM2JLQDGNPGHbTgynYKreJM6f3GZufMxPUfQKQn5+u3
         a2/g==
X-Gm-Message-State: AOAM530wOplLswttUivYft6fxH7Vd/h936UcfbDJ4cIeU8TXqbMCWlX/
        6VRKkA59iBDUH0zlWc9uw2Vw9w==
X-Google-Smtp-Source: ABdhPJwzVHeP+hwx4rJ5StG4oZ7I43tyoQQQKXOz8JI7yIRHhQyvnjPhPiwUhan5FhWHmdG6bLPBig==
X-Received: by 2002:a17:902:b098:: with SMTP id p24mr1833850plr.255.1598006223130;
        Fri, 21 Aug 2020 03:37:03 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:eeb1:d7ff:fe57:b7e5])
        by smtp.gmail.com with ESMTPSA id y20sm2081525pfn.183.2020.08.21.03.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:37:02 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v4 09/17] arm64: dts: mt8183: add encoder node
Date:   Fri, 21 Aug 2020 19:36:00 +0900
Message-Id: <20200821103608.2310097-10-acourbot@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821103608.2310097-1-acourbot@chromium.org>
References: <20200821103608.2310097-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the MT8183 encoder driver is ready, add its DT node. Also pull
the iommu and scp ones, which the encoder depends upon.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   | 10 ++++++
 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 12 +++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 36 +++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index ae405bd8f06b..9e77b420eee8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -25,6 +25,16 @@ memory@40000000 {
 	chosen {
 		stdout-path = "serial0:921600n8";
 	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		scp_mem_reserved: scp_mem_region {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x2900000>;
+			no-map;
+		};
+	};
 };
 
 &auxadc {
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index f0a070535b34..3c763be658da 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -90,6 +90,18 @@ pp3300_alw: regulator6 {
 		regulator-max-microvolt = <3300000>;
 	};
 
+	reserved_memory: reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		scp_mem_reserved: scp_mem_region {
+			compatible = "shared-dma-pool";
+			reg = <0 0x50000000 0 0x2900000>;
+			no-map;
+		};
+	};
+
 	max98357a: codec0 {
 		compatible = "maxim,max98357a";
 		sdmode-gpios = <&pio 175 0>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 102105871db2..8f77eea6df27 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/mt8183-clk.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/memory/mt8183-larb-port.h>
 #include <dt-bindings/reset-controller/mt8183-resets.h>
 #include <dt-bindings/phy/phy.h>
 #include "mt8183-pinfunc.h"
@@ -339,6 +340,25 @@ pwrap: pwrap@1000d000 {
 			clock-names = "spi", "wrap";
 		};
 
+		iommu: iommu@10205000 {
+			compatible = "mediatek,mt8183-m4u";
+			reg = <0 0x10205000 0 0x1000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_LOW>;
+			#iommu-cells = <1>;
+		};
+
+		scp: scp@10500000 {
+			compatible = "mediatek,mt8183-scp";
+			reg = <0 0x10500000 0 0x80000>,
+			      <0 0x105c0000 0 0x19080>;
+			reg-names = "sram", "cfg";
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_SCPSYS>;
+			clock-names = "main";
+			memory-region = <&scp_mem_reserved>;
+			status = "disabled";
+		};
+
 		systimer: timer@10017000 {
 			compatible = "mediatek,mt8183-timer",
 				     "mediatek,mt6765-timer";
@@ -772,6 +792,22 @@ vencsys: syscon@17000000 {
 			#clock-cells = <1>;
 		};
 
+		vcodec_enc: vcodec@17020000 {
+			compatible = "mediatek,mt8183-vcodec-enc";
+			reg = <0 0x17020000 0 0x1000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_LOW>;
+			iommus = <&iommu M4U_PORT_VENC_REC>,
+				 <&iommu M4U_PORT_VENC_BSDMA>,
+				 <&iommu M4U_PORT_VENC_RD_COMV>,
+				 <&iommu M4U_PORT_VENC_CUR_LUMA>,
+				 <&iommu M4U_PORT_VENC_CUR_CHROMA>,
+				 <&iommu M4U_PORT_VENC_REF_LUMA>,
+				 <&iommu M4U_PORT_VENC_REF_CHROMA>;
+			mediatek,scp = <&scp>;
+			clocks = <&vencsys CLK_VENC_VENC>;
+			clock-names = "MT_CG_VENC";
+		};
+
 		ipu_conn: syscon@19000000 {
 			compatible = "mediatek,mt8183-ipu_conn", "syscon";
 			reg = <0 0x19000000 0 0x1000>;
-- 
2.28.0.297.g1956fa8f8d-goog

