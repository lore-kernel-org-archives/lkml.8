Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D3DC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A909921D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b1h+jw5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgBZVFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:05:03 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38898 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgBZVFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:05:02 -0500
Received: by mail-pj1-f67.google.com with SMTP id j17so173076pjz.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 13:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACUPnfRs+B0AixBhqicJFirvOfw04PSorPFO08K1XPM=;
        b=b1h+jw5xvLfpwa+81eovYYEJi6VmH4SIolSQZvYhQZRZvv3SjNbBbraaGJCnRspqlT
         ubFVcKmj4Whh7g1ABpck2L0sOj+vXO3iwj/pwgLpkwBzXo8W6YLDk0ulLFNDkNowBLcF
         oPWR35l4uwxwSsfVVZW7xk5m8Ng8SO4NREIus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACUPnfRs+B0AixBhqicJFirvOfw04PSorPFO08K1XPM=;
        b=dq6PVZv/zUEGV7OfyFnB6Ys/WGaem+Sz+xrla+/EKumRgPU1OA5EENuAmgdR0u7uGf
         NcXPhAaLAltW0jrpVEESaCD2H5wyk+Ch643Yvt+q6hyBoDuyWmtYu/gPWapQqHmp1g22
         /rH5ggqk4jEa+gLgFJfUNHgDxD+tuF0E0j8HqcVY2hJVT9EUU9BlZtqyHgbhnWkd3BXD
         bhYGKWA8UvzJesTJ8djUBaFnJQUwxPyhj3LULzKFeUiClIOIFWfU4ztpSofF+Bfwotvj
         2DzD5eYej/3HHvwlZfHdW9O4sQFc/tUmakFIn5CCnaFE4Hzi2uryx7DmfVEuqatHU4ax
         rLjw==
X-Gm-Message-State: APjAAAWuu3ufxbtaWh8Bp5Hs+jzLHs4VzAfLU0JM4Q2VRGKCTFjjE/WI
        MwRC63+9P2HlVey5zD7QF7Zn1w==
X-Google-Smtp-Source: APXvYqz5OZ/7iJEwlyyHRvnBC50QVZ4cl/O+psBc+djXwLFf/hH1Nx+qFYROeCDiSB4p8GzYotV3mQ==
X-Received: by 2002:a17:902:528:: with SMTP id 37mr1205955plf.322.1582751100330;
        Wed, 26 Feb 2020 13:05:00 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id v29sm3636477pgc.72.2020.02.26.13.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 13:04:58 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] arm64: dts: sc7180: Move venus node to the correct position
Date:   Wed, 26 Feb 2020 13:04:55 -0800
Message-Id: <20200226130438.v2.1.I15e0f7eff0c67a2b49d4992f9d80fc1d2fdadf63@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per convention device nodes for SC7180 should be ordered by address.
This is currently not the case for the venus node, move it to the
correct position.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Excuses for sending v2 so shortly after v1, it seems ok in this case
since v1 is obviously wrong and the patch is not likely to be
controversial otherwise.

Changes in v2:
- insert the venus node *after* the usb@a6f8800 node, not before

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 52 ++++++++++++++--------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 253274d5f04c..5f97945e16a4 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1332,6 +1332,32 @@ system-cache-controller@9200000 {
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		venus: video-codec@aa00000 {
+			compatible = "qcom,sc7180-venus";
+			reg = <0 0x0aa00000 0 0xff000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&videocc VENUS_GDSC>,
+					<&videocc VCODEC0_GDSC>;
+			power-domain-names = "venus", "vcodec0";
+			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
+				 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
+				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
+				 <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
+				 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
+			clock-names = "core", "iface", "bus",
+				      "vcodec0_core", "vcodec0_bus";
+			iommus = <&apps_smmu 0x0c00 0x60>;
+			memory-region = <&venus_mem>;
+
+			video-decoder {
+				compatible = "venus-decoder";
+			};
+
+			video-encoder {
+				compatible = "venus-encoder";
+			};
+		};
+
 		usb_1: usb@a6f8800 {
 			compatible = "qcom,sc7180-dwc3", "qcom,dwc3";
 			reg = <0 0x0a6f8800 0 0x400>;
@@ -1538,32 +1564,6 @@ dispcc: clock-controller@af00000 {
 			#power-domain-cells = <1>;
 		};
 
-		venus: video-codec@aa00000 {
-			compatible = "qcom,sc7180-venus";
-			reg = <0 0x0aa00000 0 0xff000>;
-			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
-			power-domains = <&videocc VENUS_GDSC>,
-					<&videocc VCODEC0_GDSC>;
-			power-domain-names = "venus", "vcodec0";
-			clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
-				 <&videocc VIDEO_CC_VENUS_AHB_CLK>,
-				 <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>,
-				 <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
-				 <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
-			clock-names = "core", "iface", "bus",
-				      "vcodec0_core", "vcodec0_bus";
-			iommus = <&apps_smmu 0x0c00 0x60>;
-			memory-region = <&venus_mem>;
-
-			video-decoder {
-				compatible = "venus-decoder";
-			};
-
-			video-encoder {
-				compatible = "venus-encoder";
-			};
-		};
-
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sc7180-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x30000>;
-- 
2.25.1.481.gfbce0eb801-goog

