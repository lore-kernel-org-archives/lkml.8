Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150DAC2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECCD120578
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lydMUqD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbgCKTPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:15:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38933 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731279AbgCKTPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:15:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id r15so4126528wrx.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7bRjcqFkN2E/+4KIrK48jV+JLqx1FghcnIorb93T/eA=;
        b=lydMUqD/qQqb4NmEt19y3aDFglH7QjMpDZK4mSJnhH8fBLFNA0WVXA53okYhiBBk4L
         +EEJIE8SGvoBIABALTjx0NyYQV1iKWEBlnFVU/bia9DhSi/mQmXrHHwffILepWEwsdzd
         uevzMDFNOC8qV3GFBCs/fKtphnd2fuwV/QKcR3wY3S67pJBfG9jDVVc2mkVdS/4zAd6k
         xl7GI+Br2jiA7sZi1Kdo03MOCWbRKVdygHLYVjY2Wb6FUatpXClFSKqsu/hc3S23BxaE
         B/m+fugry0/oN0sZWsWmuF9j6NWF1lfrAj20p3aczRGDAnAVxhQSDQzx+yXYgK3OYXns
         Ln9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7bRjcqFkN2E/+4KIrK48jV+JLqx1FghcnIorb93T/eA=;
        b=mMRJdTzp9qb3tfFOcYuvvsfExwia1z+XDMJfbwv9QwhvGrk9PkZVwJDkjZFawqkOyr
         v8t0Am/7MAS34q6qpmKiIq1M1vP24/Ui5QNpqpACqIVon4ONlKuM6xAeQApw3nGwa1Ny
         ic4Fb6NBENQy54J2GP5YqX/O14PAymqgyy+LOvrJOrGmptxyu00YTuKpAnC8tz9Un/EX
         WLgdF6FizZuOUKJFi/0oLKS0IVVXb5nLrhs1U/JgIuFJCIGwq4aGi5DrpywzHVauCRua
         gJvhZfirIoiZoL+7CFJz8ywxRGQ43TcNh0o1F6avhV0uWKsYj2jNYYhvy0OLJO58zTsK
         vQPg==
X-Gm-Message-State: ANhLgQ3l9GcjEh8LbGWvEUw1D7Skeo3EfPUDm52TO19a9tRfXbZW0+Yl
        YsqDm8vddyAz0FOq+h3WrcCrug==
X-Google-Smtp-Source: ADFU+vtvAOkVEpVHj6kBiwJ5k7QJBkvLfgLVjEBQpl2Hx3I0Gy9j8faRiHWcgsgTVtDYnMGAAfxWEg==
X-Received: by 2002:adf:f504:: with SMTP id q4mr5772708wro.28.1583954109743;
        Wed, 11 Mar 2020 12:15:09 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c85sm9687437wmd.48.2020.03.11.12.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:15:09 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-usb@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org, robh@kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 6/6] arm64: dts: qcom: qcs404-evb: Enable USB controllers
Date:   Wed, 11 Mar 2020 19:15:17 +0000
Message-Id: <20200311191517.8221-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311191517.8221-1-bryan.odonoghue@linaro.org>
References: <20200311191517.8221-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables the primary and secondary USB controllers on the
qcs404-evb.

Primary:
The primary USB controller has

- One USB3 SS PHY using gpio-usb-conn
- One USB2 HS PHY in device mode only and no connector driver
  associated.

Secondary:
The second DWC3 controller which has one USB Hi-Speed PHY attached to it.

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index 44c7dda1e1fc..4dc3f45282fe 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -319,6 +319,46 @@ pinconf {
 	};
 };
 
+&usb2 {
+	status = "okay";
+};
+
+&usb2_phy_sec {
+	vdd-supply = <&vreg_l4_1p2>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+	vdda3p3-supply = <&vreg_l12_3p3>;
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+	dwc3@7580000 {
+		usb-role-switch;
+		usb_con: connector {
+			compatible = "gpio-usb-b-connector";
+			label = "USB-C";
+			id-gpios = <&tlmm 116 GPIO_ACTIVE_HIGH>;
+			vbus-supply = <&usb3_vbus_reg>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&usb3_id_pin>, <&usb3_vbus_pin>;
+			status = "okay";
+		};
+	};
+};
+
+&usb2_phy_prim {
+	vdd-supply = <&vreg_l4_1p2>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+	vdda3p3-supply = <&vreg_l12_3p3>;
+	status = "okay";
+};
+
+&usb3_phy {
+	vdd-supply = <&vreg_l3_1p05>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+	status = "okay";
+};
+
 &wifi {
 	status = "okay";
 	vdd-0.8-cx-mx-supply = <&vreg_l2_1p275>;
-- 
2.25.1

