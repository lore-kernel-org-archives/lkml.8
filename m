Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DA8C433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 498EA20775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="EPsfShj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgG1Cj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbgG1Cjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:39:55 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBD7C0619D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:39:55 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b79so17359615qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kN6yLyMpOehEyeJ3iaaFNYcw5cQVfv7fXSI67+KIjis=;
        b=EPsfShj9QdRRc1tvzRdbAXFiYd2JKJXXS/9vY5ucKpThsDSfYIQOfN0h4xILxlqx/h
         HSekU2l4vEnU5fcL5AD8P3PvMD8N7T3sQ8T512/tIjEJ+E0kMeuXORq9H8hqfBvYox1O
         gn9NogxnzGdF7a4xnTuZ9M7iQAv0FgrdLZuD64Lxtvg/grsvUZQJFsxUaFhi11uyJwj8
         YEYGj/zP0E9eE89pXCisqaBjBBonTFNviOFocI/1GFKSGi6d8HMQYN5lMfROmAIK/Dbw
         NUdzblBIOx1xe1PVK+fTBIkCor++FGVDfCz67I7ArJGABwUJNJsherCIs+yy8G1mdXHC
         H8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kN6yLyMpOehEyeJ3iaaFNYcw5cQVfv7fXSI67+KIjis=;
        b=kp+HY0xzeWHo9VomiRzk570K0cf3adV29zUTmlFELt82luzt9AjByJSFQfQA7uTh9G
         xm6NHkKJ2Lax1d2KrWKc2LVGFjy2Sa36gkPurQDFaonf4c2Sf83GeV1slbl9j+tQps4f
         Y0wkoXR/hvs7LUedg88tj7yy2GcaceUsu8IeSV8HfM7dxWUr6wjSpQsWJx2bBEO/aAy3
         WNyr2BbcvV3zbPqlmF7kXUo8smYYz3JfZKEPT4TqtzqTSHi6AgTQHXuiN4UVBiOqt5F1
         xc13oKaNofwzYyHYfLNSGnSFLIXMWIhddBoKjieWk1WeBoi4jWsNmtC3lHP8VsGfZfhw
         OI0Q==
X-Gm-Message-State: AOAM533T8FGWCzPlHEO89hHStcgtOUiw6xWB7DxK0DO5UKfTKSWPtLkm
        7B9dCXdK3yHmLrPiNkJXRwGHOw==
X-Google-Smtp-Source: ABdhPJwg68e5KiC5QtsTaPX4HnIMS+cqo+gah4iuIIRk0rJ5ve6QQ/BIYRDgX9V/LFe2AWvonhGyRQ==
X-Received: by 2002:a37:9682:: with SMTP id y124mr25704979qkd.442.1595903994243;
        Mon, 27 Jul 2020 19:39:54 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id z3sm13885548qkc.4.2020.07.27.19.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 19:39:53 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 6/7] arm64: dts: qcom: sm8150: add interconnect nodes
Date:   Mon, 27 Jul 2020 22:38:05 -0400
Message-Id: <20200728023811.5607-7-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200728023811.5607-1-jonathan@marek.ca>
References: <20200728023811.5607-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the interconnect dts nodes for sm8150.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 82 ++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 33ff99132f4f..e4689c27224b 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,gcc-sm8150.h>
 #include <dt-bindings/clock/qcom,gpucc-sm8150.h>
+#include <dt-bindings/interconnect/qcom,sm8150.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -440,6 +441,55 @@ uart2: serial@a90000 {
 			};
 		};
 
+		config_noc: interconnect@1500000 {
+			compatible = "qcom,sm8150-config-noc";
+			reg = <0 0x01500000 0 0x7400>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		system_noc: interconnect@1620000 {
+			compatible = "qcom,sm8150-system-noc";
+			reg = <0 0x01620000 0 0x19400>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mc_virt: interconnect@163a000 {
+			compatible = "qcom,sm8150-mc-virt";
+			reg = <0 0x0163a000 0 0x1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre1_noc: interconnect@16e0000 {
+			compatible = "qcom,sm8150-aggre1-noc";
+			reg = <0 0x016e0000 0 0xd080>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		aggre2_noc: interconnect@1700000 {
+			compatible = "qcom,sm8150-aggre2-noc";
+			reg = <0 0x01700000 0 0x20000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		compute_noc: interconnect@1720000 {
+			compatible = "qcom,sm8150-compute-noc";
+			reg = <0 0x01720000 0 0x7000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		mmss_noc: interconnect@1740000 {
+			compatible = "qcom,sm8150-mmss-noc";
+			reg = <0 0x01740000 0 0x1c100>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sm8150-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
@@ -510,6 +560,13 @@ ufs_mem_phy_lanes: lanes@1d87400 {
 			};
 		};
 
+		ipa_virt: interconnect@1e00000 {
+			compatible = "qcom,sm8150-ipa-virt";
+			reg = <0 0x01e00000 0 0x1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		tcsr_mutex_regs: syscon@1f40000 {
 			compatible = "syscon";
 			reg = <0x0 0x01f40000 0x0 0x40000>;
@@ -860,6 +917,20 @@ usb_2_ssphy: lane@88eb200 {
 			};
 		};
 
+		dc_noc: interconnect@9160000 {
+			compatible = "qcom,sm8150-dc-noc";
+			reg = <0 0x09160000 0 0x3200>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
+		gem_noc: interconnect@9680000 {
+			compatible = "qcom,sm8150-gem-noc";
+			reg = <0 0x09680000 0 0x3e200>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		usb_1: usb@a6f8800 {
 			compatible = "qcom,sm8150-dwc3", "qcom,dwc3";
 			reg = <0 0x0a6f8800 0 0x400>;
@@ -950,6 +1021,13 @@ usb_2_dwc3: dwc3@a800000 {
 			};
 		};
 
+		camnoc_virt: interconnect@ac00000 {
+			compatible = "qcom,sm8150-camnoc-virt";
+			reg = <0 0x0ac00000 0 0x1000>;
+			#interconnect-cells = <1>;
+			qcom,bcm-voters = <&apps_bcm_voter>;
+		};
+
 		aoss_qmp: power-controller@c300000 {
 			compatible = "qcom,sm8150-aoss-qmp";
 			reg = <0x0 0x0c300000 0x0 0x100000>;
@@ -1280,6 +1358,10 @@ rpmhpd_opp_turbo_l1: opp11 {
 					};
 				};
 			};
+
+			apps_bcm_voter: bcm_voter {
+				compatible = "qcom,bcm-voter";
+			};
 		};
 
 		cpufreq_hw: cpufreq@18323000 {
-- 
2.26.1

