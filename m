Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2811C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB6F206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgaapTg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgCLOau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:30:50 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:43517 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgCLOar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:30:47 -0400
Received: by mail-wr1-f46.google.com with SMTP id b2so1528141wrj.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YwUqcbSkfiGcYWBIGYa6fyAd0dVAA7TWBNYQrjCfOhE=;
        b=DgaapTg5RX+RM/6VrRELTPI3+/XW/sUo7nLw+QWisSsj0esPnFTRxK06CDNVuS6dk0
         wETGh5t0ExN2ajH6UrJSEU0XQSf0F9wx63May9wtKWq/qW8oWeroPbVznFuDKJw2iNHO
         pSsiqxvr/KVgWfLDNcbpF8SYaRBoUeFVkixCm1jXJGvZYQM0u4irTOucpPcvpfT4eTlk
         eanB9yuViFYQphQTu0I/T9vH2IDD4OpN74UTpXmcJw9EzWwcOU7+hf3CSjaR7LTtkOeh
         d6yJA1HRSNNMksR4UmlMsFsJfw3Va/liICmyuMjJXGBFLOmagMqfzwiAvTSj1V25JfUm
         ZKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwUqcbSkfiGcYWBIGYa6fyAd0dVAA7TWBNYQrjCfOhE=;
        b=KcBu0Z7Ac+yMqpLcuzG9V+Fhz9Sa56eGVTfYR3Eg+U0SS/JuDSpDyFqBjJpw9jhVHK
         GnLoHolqSyKeJHVyebsz+332SMOz8i4XQAD/HwwUvVQXHjxavk7mriewgVfhI1liCT1u
         dqobOLNa+j4D8pl/LKcE+I9bYT2Lbb5InG46Zu7FoAKTt7K3WXnfTdRFz+8PBIfeb2rs
         W+1XtJuK6qX3xyR0P/62mEkCmrZ4WXVAswPSCbo9zwMUtvAKZakNiZZ6CLWl1DHYRKFq
         0qvNYGmZ+yKx5wXK3N21FLr5NpiNrj84IBwUCR6uqSSO2axAQrCJiBVmjIA4EJO3ALEe
         TyPA==
X-Gm-Message-State: ANhLgQ3gFbQ4WRwaDsoSSYC83er06ItACVOcYMqdZsDF6r73HTZ3wUX5
        /PLsEKheVMLRyUfQI7yuAR251Q==
X-Google-Smtp-Source: ADFU+vtNye5LXYq43J99KhyYyK+mxSC1U8QCons7K7iPov/Ue1YnNXFCphoEgn8CM88EVDQV1vPf+Q==
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr907979wrm.247.1584023446356;
        Thu, 12 Mar 2020 07:30:46 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id v8sm72860454wrw.2.2020.03.12.07.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 07:30:44 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     bjorn.andersson@linaro.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/5] arm64: dts: qcom: sdm845: add pinctrl nodes for quat i2s
Date:   Thu, 12 Mar 2020 14:30:23 +0000
Message-Id: <20200312143024.11059-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200312143024.11059-1-srinivas.kandagatla@linaro.org>
References: <20200312143024.11059-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl nodes required for QUAT I2S

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 136 +++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 5b7626f2a27b..c565948e322f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2152,6 +2152,142 @@
 					function = "qup15";
 				};
 			};
+
+			quat_mi2s_sleep: quat_mi2s_sleep {
+				mux {
+					pins = "gpio58", "gpio59";
+					function = "gpio";
+				};
+
+				config {
+					pins = "gpio58", "gpio59";
+					drive-strength = <2>;
+					bias-pull-down;
+					input-enable;
+				};
+			};
+
+			quat_mi2s_active: quat_mi2s_active {
+				mux {
+					pins = "gpio58", "gpio59";
+					function = "qua_mi2s";
+				};
+
+				config {
+					pins = "gpio58", "gpio59";
+					drive-strength = <8>;
+					bias-disable;
+					output-high;
+				};
+			};
+
+			quat_mi2s_sd0_sleep: quat_mi2s_sd0_sleep {
+				mux {
+					pins = "gpio60";
+					function = "gpio";
+				};
+
+				config {
+					pins = "gpio60";
+					drive-strength = <2>;
+					bias-pull-down;
+					input-enable;
+				};
+			};
+
+			quat_mi2s_sd0_active: quat_mi2s_sd0_active {
+				mux {
+					pins = "gpio60";
+					function = "qua_mi2s";
+				};
+
+				config {
+					pins = "gpio60";
+					drive-strength = <8>;
+					bias-disable;
+				};
+			};
+
+			quat_mi2s_sd1_sleep: quat_mi2s_sd1_sleep {
+				mux {
+					pins = "gpio61";
+					function = "gpio";
+				};
+
+				config {
+					pins = "gpio61";
+					drive-strength = <2>;
+					bias-pull-down;
+					input-enable;
+				};
+			};
+
+			quat_mi2s_sd1_active: quat_mi2s_sd1_active {
+				mux {
+					pins = "gpio61";
+					function = "qua_mi2s";
+				};
+
+				config {
+					pins = "gpio61";
+					drive-strength = <8>;
+					bias-disable;
+				};
+			};
+
+			quat_mi2s_sd2_sleep: quat_mi2s_sd2_sleep {
+				mux {
+					pins = "gpio62";
+					function = "gpio";
+				};
+
+				config {
+					pins = "gpio62";
+					drive-strength = <2>;
+					bias-pull-down;
+					input-enable;
+				};
+			};
+
+			quat_mi2s_sd2_active: quat_mi2s_sd2_active {
+				mux {
+					pins = "gpio62";
+					function = "qua_mi2s";
+				};
+
+				config {
+					pins = "gpio62";
+					drive-strength = <8>;
+					bias-disable;
+				};
+			};
+
+			quat_mi2s_sd3_sleep: quat_mi2s_sd3_sleep {
+				mux {
+					pins = "gpio63";
+					function = "gpio";
+				};
+
+				config {
+					pins = "gpio63";
+					drive-strength = <2>;
+					bias-pull-down;
+					input-enable;
+				};
+			};
+
+			quat_mi2s_sd3_active: quat_mi2s_sd3_active {
+				mux {
+					pins = "gpio63";
+					function = "qua_mi2s";
+				};
+
+				config {
+					pins = "gpio63";
+					drive-strength = <8>;
+					bias-disable;
+				};
+			};
 		};
 
 		mss_pil: remoteproc@4080000 {
-- 
2.21.0

