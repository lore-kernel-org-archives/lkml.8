Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A83C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED53C205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x08FyS2T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgCQN55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:57:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38508 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQN5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:57:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id t13so15761016wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gE0E48YTccXbLL7Wbu4iPyqHzH6s/0ICIW3f6yKP+/M=;
        b=x08FyS2T11lS2rzYbZquOz72b/VYEhQW0IYOEhRHdIaWKC7c6IH50zqHBkykkzCS2z
         tlqO3+fvtycThLWxdLJ8ORoW7YLVdBWSNPgFDPxjaDPVoWT1M0z9XLu8AExRZtroGelh
         wjDC4HZRwOkeqdUcoTqMlGdUoVwrCtD0HV6C0AZZ2sPcVmOBtjHrfMqQck/DfqJx/1Qv
         vrsxAn+O2zmYJzq0MB+pwNCheLxJ+6wb/tpV7v0vmU5Kh81Gttp0XBMHuougn+cNcRjT
         mOnkCuzfDhMXhDrBvNh+Clc2n+2RNsZLQgFtryQ5Q+aI6721wxo/NS2w3EqFEqD0+IFJ
         fiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gE0E48YTccXbLL7Wbu4iPyqHzH6s/0ICIW3f6yKP+/M=;
        b=TQCRREn8S29Ogu8Kzwf6LmowQHXNEztszWDgRtvpd60VA98a9V+VkfvLnCcN/MSZ+x
         9MA/nfYOIxpqMFA6cbT7xAaZyczMwzrUjzNuxZ6lLLk6p8WSYNGBzTg/mZ0LicLQuA3E
         Re/VLwWYKEXJvnGjNF4l0UjzbrFo2fYJzxJXQNiHQA1wl37fT+rYhiv/D+4AqOZ9fyxD
         KCLR4orIWoloMk1h9MzihAXGKqoaFswC47AvMGxbqIX80Dd9m68IgwjTyaJyira8N8Pm
         y6XOvlfaXnMxYJKDlz+WGMksM6vfcizSF4CyVcfcMHtk2wwwmgpNmkT7GZSkUmUOXVsZ
         k4AQ==
X-Gm-Message-State: ANhLgQ3Qp63L5hFAOpy3SrJo/6sDdrKMz6bSh5XgBzlFkoRLD6LrpK8u
        Tbj7GutSWL0iLlSQztEcXStX1g==
X-Google-Smtp-Source: ADFU+vu0XS8SjB4/Yw6xnU/f/BoTF8gd2wERlztERMFvMKS5J+6ajXkkC526BVd31HEWQoXRWNZptg==
X-Received: by 2002:a1c:6a07:: with SMTP id f7mr5331001wmc.38.1584453471765;
        Tue, 17 Mar 2020 06:57:51 -0700 (PDT)
Received: from xps7590.local ([2a02:2450:102f:13b8:84f7:5c25:a9d8:81a1])
        by smtp.gmail.com with ESMTPSA id r3sm2976558wrn.35.2020.03.17.06.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 06:57:51 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, olof@lixom.net, maxime@cerno.tech,
        Anson.Huang@nxp.com, dinguyen@kernel.org, leonard.crestez@nxp.com,
        marcin.juszkiewicz@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [v2 1/6] arm64: dts: msm8916: Add i2c-qcom-cci node
Date:   Tue, 17 Mar 2020 14:57:35 +0100
Message-Id: <20200317135740.19412-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317135740.19412-1-robert.foss@linaro.org>
References: <20200317135740.19412-1-robert.foss@linaro.org>
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
@@ -1584,6 +1584,33 @@
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
2.20.1

