Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D1CC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CED20757
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 13:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aFWPOjD+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgDHNKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:10:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40776 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgDHNKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 09:10:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id a81so5367761wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NlDlRv555GH3IWzPThM2PIkVo5dnbd1J1aXXNjhdRgU=;
        b=aFWPOjD+POZxqE+i+gRicc1Ttn6UlDSIUKWVEXYrw6mfX2v20gZgt82l4KRhjiIe9A
         b7eh6/OF5TAIN8zLoLVxFZu6TXaYtFE7/efNaS8sZKDyPnHEaYTT/n35OdxMY05APuOt
         rlWYwUne8HTx4HnFmTSaPsuQsXqpfgebNO4ZoJARRorQ9DkoYG3cYPagjmaYqCRxy/5p
         rnFMxw1K+6Rzmgrq1DW3Fnq4at0dmmS01p0cbFLJdKNnxjXp8BkfZrycWl7oUXu+s+cK
         d/adjUK3FZcpZfWktEdbNJoad3EocqLejBbg1sRQ265bF0LqSaopWWshBlwmpvodh1TX
         BEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NlDlRv555GH3IWzPThM2PIkVo5dnbd1J1aXXNjhdRgU=;
        b=VqXgVOWQ2F9AOLlaKXdcsxKHwTnIXZVmZV1GoocjFEmucK1trN4CIhRjAxmG6XV6Ru
         liuJTDrO5y000OI3eQ3qyHigUeZu7e4Eo9zq3/zzK1+GzOBy0tmd5edJYc3wYX749JoP
         NWoCShVquq9Qj2qmNVxYaFVa8NDVFzR8RRpScqTwI1f5FaAPQbKdQG6x6qVTtqdB9ieW
         4Thb7n50GLBkYG3vxc50E45X3XOG5wEHn6J+H7vuEBrp/2G2sjNFlWXF3v/W7FeY4+od
         2VdPRK115GMn/fU0Cz9IA8+tXLcmnlVewlUxzaQrkMFzvi7CJ/bTb2TmYE7Vy4crt849
         vWVQ==
X-Gm-Message-State: AGi0PuYKshItEYHN8pb3dp4TH1UJbXTScs0BMlIpXICMyjFJ6wq/YNWl
        syS20wf6+BRqAVQ5oT126RMW6Q==
X-Google-Smtp-Source: APiQypKFGiJ+gX60BLbUE1LDlC51Duk6XfC5j/frP0y9C+JdDx5KsdFSZwr18YptOjMFQlBlrJHuCg==
X-Received: by 2002:a7b:c1da:: with SMTP id a26mr3107514wmj.125.1586351446839;
        Wed, 08 Apr 2020 06:10:46 -0700 (PDT)
Received: from localhost.localdomain ([37.120.50.78])
        by smtp.gmail.com with ESMTPSA id f4sm18428044wrp.80.2020.04.08.06.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 06:10:46 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, Anson.Huang@nxp.com, olof@lixom.net,
        leonard.crestez@nxp.com, geert+renesas@glider.be,
        marcin.juszkiewicz@linaro.org, valentin.schneider@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v4 1/6] arm64: dts: msm8916: Add i2c-qcom-cci node
Date:   Wed,  8 Apr 2020 15:09:54 +0200
Message-Id: <20200408130959.2717409-2-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200408130959.2717409-1-robert.foss@linaro.org>
References: <20200408130959.2717409-1-robert.foss@linaro.org>
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
index a88a15f2352b..cad0ac482367 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1603,6 +1603,33 @@ ports {
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

