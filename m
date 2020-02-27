Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19912C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E422024691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M8MQI9kE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgB0R06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:26:58 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33178 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbgB0R06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:26:58 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so75197plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 09:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQPEnxEYqQKv2J8jDt8sM4BsZoYJJo7zFPvtZvyCIgk=;
        b=M8MQI9kESW8PfwE5agJLV5bI3OzTvFh8DKCAPWjqwaZe0CN9rvaLIsXYDbc/GeS7mu
         reHjzXYGp7vZDEB3M7QDSfdQBssljyNj0UfiVTBa/4LEtT7sOs7xXF4kcEMzsXvNQtNg
         NYoFURLEnX0v+AvxD9MV+kzBQMPbnkvbuuzK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fQPEnxEYqQKv2J8jDt8sM4BsZoYJJo7zFPvtZvyCIgk=;
        b=qZYuxiSwQwdOji/FX9Y07tfC3YfL2BZIOzRn5OG6nssVh9n/sjBJ35WuwJ5g11jQW+
         dM9i9AJL95haU9+d2iIXdwOfbprKFwdWzAJtATRaDLdm6OwJeo1pbjJluMb9Yv6T6dXs
         bsGj1t117V7wrJjW5zGbEta1QTsqaC7Se4ZCpXnzwTU/r39xlgqJuGJzt5Qm+IaFCANL
         gnXeVfucVxPF57RHl+jcOPPgYjTcLsyqn7G7jzDNDFwbnVOYw0C8vWZp6j02BYHKMyGe
         LQj6/giYoUPmm7k6gynblZtDxwvML01ZF2D+i2jG8FvS1NzOldaKHA0CfcSYyduKzlET
         819w==
X-Gm-Message-State: APjAAAVKMlOTC/ouqegjd0nWOQ60KMMytm4UHeZHGq3RlqbphgMSaWMM
        bQek6QbXudQCzQvRpoYppeL6fg==
X-Google-Smtp-Source: APXvYqxd8JJX/yJEscJ9jPCi0Hv0aT+HkJGkpNetjAHaTZgfz4jNcf9P6XVCoMR6bZ8KjTNnxvy9xg==
X-Received: by 2002:a17:902:8604:: with SMTP id f4mr768399plo.278.1582824416320;
        Thu, 27 Feb 2020 09:26:56 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id p18sm11436922pjo.3.2020.02.27.09.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 09:26:55 -0800 (PST)
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
Subject: [PATCH v3] arm64: dts: sc7180: Move venus node to the correct position
Date:   Thu, 27 Feb 2020 09:26:52 -0800
Message-Id: <20200227092649.v3.1.I15e0f7eff0c67a2b49d4992f9d80fc1d2fdadf63@changeid>
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

Changes in v3:
- actually insert the venus node after usb@a6f8800 and not just
  pretend to do it

Changes in v2:
- insert the venus node *after* the usb@a6f8800 node, not before

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 52 ++++++++++++++--------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 253274d5f04cb..31bf210f2e0b1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1376,6 +1376,32 @@ usb_1_dwc3: dwc3@a600000 {
 			};
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
 		videocc: clock-controller@ab00000 {
 			compatible = "qcom,sc7180-videocc";
 			reg = <0 0x0ab00000 0 0x10000>;
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

