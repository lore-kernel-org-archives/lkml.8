Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCC8C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 222E120774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rpETRG8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgCXP6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:58:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32977 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727636AbgCXP6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:58:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id w25so37757wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 08:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YPXTp5qjoojtUwOKaMWOgJgogwlThEl+Qmy36Dg38C4=;
        b=rpETRG8x+xc/5PfrYyKYVF+Ev/1UU28xWSwJ/lIdcjZeII+np4CR48UpGRcAW564Nu
         g3pDbDoAxM2+wDvnkry0RFVNjw3i64fcDBHOCDJIbc4RG807J7jhcEY3e5gcIF6crN8A
         t7OTB1nM/7LsLuPvJo/9VyADD141EJCIWQbEyLxOLHQw1FISRUx9gXJ1hu/sPxDtMla4
         uhlORhEcvmPjdGcuaKIcn47ZYhs1pghTucxRC8QfH/IFJBhaUaly6Pr4YMCPZm5A4ZNM
         /wtpy1R0YfUhOWoZLsOpOeI3NPGkK/jsr5yaJoVbiZhOMhgO5r99si0CijMm/skADJW9
         EXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YPXTp5qjoojtUwOKaMWOgJgogwlThEl+Qmy36Dg38C4=;
        b=GWGorsHRjHdDykfPL8BnSiNbLyYolesQJnwChkcJy8K3SQtzcdlIdpVEqrRvKwdRqf
         LORl/PXybft+6oleYSZ2MVdkzyc+2gBjFPDIF29rwsPVmF4Fjp/sAhlMupE92WPcoZiC
         mn7l5uG6LVs9p7ZsIVE5hLIxbc+LQSl5cB0Hy/JsP6nU5H2zASqXOFtIsWA8FKgW24V1
         VS49zke+CUtZAp1MF2HSvb+IM0dQimcuLOANvBhqHvmAlCkFjBCDYoOa+Qj+wagAVqqx
         X0jQiFyUZV5rMShMdSBjRuCLTYVn3SpEbgyjxpXrXl9Vzi6Z/WfxoGVeGkXUzwF1OCqY
         mfAg==
X-Gm-Message-State: ANhLgQ1ikIdy76iUdh6iy0M1oOcOt7QIRqvFwZjPmeM+SpAWp6KmOTnz
        IsLFP3rXUwqzs2pqyHZjcyMS1w==
X-Google-Smtp-Source: ADFU+vuRoADbG3q5yu8n7Ne4gC1B+yIMrcsW6YQOOMW3QmgdTv3+DZKX3n2h4/mdvGaZ4ajDaV5cpA==
X-Received: by 2002:a7b:ca4e:: with SMTP id m14mr6099145wml.164.1585065530480;
        Tue, 24 Mar 2020 08:58:50 -0700 (PDT)
Received: from xps7590.local ([2a02:2450:102f:13b8:e15d:2127:89a:e5dc])
        by smtp.gmail.com with ESMTPSA id t124sm4993321wmg.13.2020.03.24.08.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 08:58:49 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, olof@lixom.net, Anson.Huang@nxp.com,
        dinguyen@kernel.org, leonard.crestez@nxp.com,
        marcin.juszkiewicz@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [v3 1/6] arm64: dts: msm8916: Add i2c-qcom-cci node
Date:   Tue, 24 Mar 2020 16:58:37 +0100
Message-Id: <20200324155843.10719-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324155843.10719-1-robert.foss@linaro.org>
References: <20200324155843.10719-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

The msm8916 CCI controller provides one CCI/I2C bus.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
 - Add label to cci node
 - Sort cci node by address
 - Relabel cci0 i2c bus to cci-i2c0


 arch/arm64/boot/dts/qcom/msm8916.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 9f31064f2374..1d5cb3fef906 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1584,6 +1584,33 @@ ports {
 		};
 	};
 
+	cci: cci@1b0c000 {
+		compatible = "qcom,msm8916-cci";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x1b0c000 0x1000>;
+		interrupts = <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
+		clocks = <&gcc GCC_CAMSS_TOP_AHB_CLK>,
+			<&gcc GCC_CAMSS_CCI_AHB_CLK>,
+			<&gcc GCC_CAMSS_CCI_CLK>,
+			<&gcc GCC_CAMSS_AHB_CLK>;
+		clock-names = "camss_top_ahb", "cci_ahb",
+				  "cci", "camss_ahb";
+		assigned-clocks = <&gcc GCC_CAMSS_CCI_AHB_CLK>,
+				  <&gcc GCC_CAMSS_CCI_CLK>;
+		assigned-clock-rates = <80000000>, <19200000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&cci0_default>;
+		status = "disabled";
+
+		cci_i2c0: i2c-bus@0 {
+			reg = <0>;
+			clock-frequency = <400000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
 	smd {
 		compatible = "qcom,smd";
 
-- 
2.25.1

