Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65294C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357E620737
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o1ZWF37M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgCLOak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:30:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39417 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbgCLOai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:30:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id f7so6566812wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hBXPWLtpelw+nY/LZOxH+qmAA9K7eLUZ7Wq/7/BkEO4=;
        b=o1ZWF37MxgjQAr/NGtbotHA0HyhQKxcepooGBHi1c28euwuBPp010CPFsms+PYs/Rv
         Z88aGw/b/0UERM2StdBnELgH7WsH0LA+3Z2PXvPmJsUkokbLkpl+8bRXIwWxZZRLD8Lk
         s3cXvIKtnWDJndGNjfnyCO3gK7ZGRum/wvTtML6Nh4T7w4gaaOpfjv1yNDr0pmNn3M2X
         mEi0GS5BOVfZz7RyC/R5EIesUhB+CEYTHZ/mxkzARbEb/gn5E3FSGydEkRfbKUfWxdOs
         KWv6UQAG1qpmQGarBr/c9u58LU7G7EjpygLvsLELKWahMy5ilCXMWP+BaZq6p+eDyUR+
         jNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hBXPWLtpelw+nY/LZOxH+qmAA9K7eLUZ7Wq/7/BkEO4=;
        b=Vs5GQLy3EXRPPoRwxzmVPAlDpOLJuQ7ceC8uorjwx1WMAOmMeAQDeHoiIt80PaHYRG
         2GOGdu+M2gXsbhKLTjHLhMvl2dBpUgiocP3XwFgnHFnxIWW4qAPaTk0OuJME0ADzg/kV
         FByRP5kd3fSr43qqCOcVDGVEa8eQiqCa5yPylpgRg+yKylQ9wqCCr8ZTJdty1tKpsKmU
         h9fP9CUSD+dKCk95hf+8+de4hMvCCbCyVrqjloj+HBVdVOBQQ379mcmYmPNT1hJVGWr0
         it3wbX/cQD2ZC9k9a3HSj0W/D0vmJjVBnRlFkNiWDNZOZqccC7YouZKDlubCcCzF0YR0
         bEMw==
X-Gm-Message-State: ANhLgQ2c95bKrb1m9xgpOcSSNGTnrhtKDgDkuGYthbVJEBGPmAB1ZDZz
        87Y9nQfzo1uz7vAa48LzG4JfVw==
X-Google-Smtp-Source: ADFU+vszacSrrYCqDnuXEegLa5Dey9rPmnEFWaW9TRWiYpa8u7G+L5dPmOvEn9MsrZAcEP72NArz0A==
X-Received: by 2002:a1c:b4d4:: with SMTP id d203mr5234251wmf.85.1584023437473;
        Thu, 12 Mar 2020 07:30:37 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id v8sm72860454wrw.2.2020.03.12.07.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 07:30:36 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/5] arm64: dts: qcom: sdm845: add slimbus nodes
Date:   Thu, 12 Mar 2020 14:30:20 +0000
Message-Id: <20200312143024.11059-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200312143024.11059-1-srinivas.kandagatla@linaro.org>
References: <20200312143024.11059-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 93 ++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 8798df6a1a7c..3f9fb719bfaa 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2653,6 +2653,87 @@
 			status = "disabled";
 		};
 
+		slim: slim@171c0000 {
+			compatible = "qcom,slim-ngd-v2.1.0";
+			reg = <0 0x171c0000 0 0x2c000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+
+			qcom,apps-ch-pipes = <0x780000>;
+			qcom,ea-pc = <0x270>;
+			status = "okay";
+			dmas =	<&slimbam 3>, <&slimbam 4>,
+				<&slimbam 5>, <&slimbam 6>;
+			dma-names = "rx", "tx", "tx2", "rx2";
+
+			iommus = <&apps_smmu 0x1806 0x0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ngd@1 {
+				reg = <1>;
+				#address-cells = <2>;
+				#size-cells = <0>;
+
+				wcd9340_ifd: ifd@0{
+					compatible = "slim217,250";
+					reg  = <0 0>;
+				};
+
+				wcd9340: codec@1{
+					compatible = "slim217,250";
+					reg  = <1 0>;
+					slim-ifc-dev  = <&wcd9340_ifd>;
+
+					#sound-dai-cells = <1>;
+
+					interrupts-extended = <&tlmm 54 IRQ_TYPE_LEVEL_HIGH>;
+					interrupt-controller;
+					#interrupt-cells = <1>;
+
+					#clock-cells = <0>;
+					clock-frequency = <9600000>;
+					clock-output-names = "mclk";
+					qcom,micbias1-millivolt = <1800>;
+					qcom,micbias2-millivolt = <1800>;
+					qcom,micbias3-millivolt = <1800>;
+					qcom,micbias4-millivolt = <1800>;
+
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					wcdgpio: gpio-controller@42 {
+						compatible = "qcom,wcd9340-gpio";
+						gpio-controller;
+						#gpio-cells = <2>;
+						reg = <0x42 0x2>;
+					};
+
+					swm: swm@c85 {
+						compatible = "qcom,soundwire-v1.3.0";
+						reg = <0xc85 0x40>;
+						interrupts-extended = <&wcd9340 20>;
+
+						qcom,dout-ports	= <6>;
+						qcom,din-ports	= <2>;
+						qcom,ports-sinterval-low =/bits/ 8  <0x07 0x1F 0x3F 0x7 0x1F 0x3F 0x0F 0x0F>;
+						qcom,ports-offset1 = /bits/ 8 <0x01 0x02 0x0C 0x6 0x12 0x0D 0x07 0x0A >;
+						qcom,ports-offset2 = /bits/ 8 <0x00 0x00 0x1F 0x00 0x00 0x1F 0x00 0x00>;
+
+						#sound-dai-cells = <1>;
+						clocks = <&wcd9340>;
+						clock-names = "iface";
+						#address-cells = <2>;
+						#size-cells = <0>;
+
+
+					};
+				};
+			};
+		};
+
+		sound: sound {
+		};
+
 		usb_1_hsphy: phy@88e2000 {
 			compatible = "qcom,sdm845-qusb2-phy";
 			reg = <0 0x088e2000 0 0x400>;
@@ -3497,6 +3578,18 @@
 			};
 		};
 
+		slimbam: dma@17184000 {
+			compatible = "qcom,bam-v1.7.0";
+			qcom,controlled-remotely;
+			reg = <0 0x17184000 0 0x2a000>;
+			num-channels  = <31>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <1>;
+			qcom,num-ees = <2>;
+			iommus = <&apps_smmu 0x1806 0x0>;
+		};
+
 		timer@17c90000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
-- 
2.21.0

