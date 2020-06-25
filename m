Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC579C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8086120768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/N1volu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgFYXe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgFYXeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:34:37 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B88C08C5DB;
        Thu, 25 Jun 2020 16:34:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id rk21so7633146ejb.2;
        Thu, 25 Jun 2020 16:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fWdpO4GnBs7BEt8G3PHlb+jDJVr2O1LVzT1H9YOtCB0=;
        b=l/N1voluvfY5KulvQYX4NBS5Fnr1UcFA79PNCheJwzmUcMrzwT26S1XhVzKXRUi3EC
         EHKNzGeVAjmY2YVIZkHrOmk+nJNLKWfor/ZHgNIR946wbXmmx2fJqry8UpVhO9qPTb3h
         qRcDdYLrm6vJQDprbd7wwWa7pIGTju7JSxcYykjMPGA+eDN9PJI5wa2DvgaiGzlIB89e
         a7icQ64ksBpUPoZd4WzT5rS7zcaFu6O97cEafVU/2sR1/PPzuvKnBNGfLUgdennMAI30
         NbnE809GtF8GD4qtnPyDBfFr60ky0Q+Q5fQrE8OrK8H2e5G782iIzfrpV35/zz6QI761
         Nsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fWdpO4GnBs7BEt8G3PHlb+jDJVr2O1LVzT1H9YOtCB0=;
        b=aF7aXUGQw999on1tcSi3J/DdL6KABwDrhM8OALTwd1W5drHDKzMlQ6mPUl2d7ZqkWv
         xRLGHLMSROotSsr1NcWMwitrS0sso94f5Ozz8BJNEjF5+qoPwYwyjwbj0NINCGRx7Evi
         VckS4p94l99MnLHP+C9SzvX5jA/zYAOW+Acq+gBj99GTyUy0R7vPKL3TkFNz/UL5znsI
         qFVxaE3ckDV8PB8jC9sY18HPhkLvm2r6OuID3jVJVFlGj3fuUk7Urp35fr7c1ZRBs09/
         77FvDJVegBnZl9rb0oC41Ya07f2VtAoB/vJmfLApFgh9rsDeasg8L1UDg6opnzsdpmsM
         TlHg==
X-Gm-Message-State: AOAM532aOCdV7engQgUEOL4cpxFJ59JSjVmeerJq3WTyK3b/NCVI8801
        tLEwJ6xgNPCrGSyO7u2DWec=
X-Google-Smtp-Source: ABdhPJwjKmxIjrokXff6nUkVfnswmEOAIDkK+2CuPK482Wjo/DRn6nylKDQMf++BY0EuGJ68xEeGpg==
X-Received: by 2002:a17:906:c259:: with SMTP id bl25mr163087ejb.303.1593128075498;
        Thu, 25 Jun 2020 16:34:35 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id u2sm13699184edq.29.2020.06.25.16.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:34:35 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: [PATCH 09/10] arm: dts: owl-s500-roseapplepi: Add uSD support
Date:   Fri, 26 Jun 2020 02:34:21 +0300
Message-Id: <521e5024f355c006d7abc8fe30d5cae63a9601f1.1593124368.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
References: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uSD support for RoseapplePi SBC using a fixed regulator as a
temporary solution until PMIC support becomes available.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500-roseapplepi.dts | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
index 800edf5d2d12..0a916b6c83a8 100644
--- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
+++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
@@ -14,6 +14,7 @@ / {
 	model = "Roseapple Pi";
 
 	aliases {
+		mmc0 = &mmc0;
 		serial2 = &uart2;
 	};
 
@@ -25,6 +26,55 @@ memory@0 {
 		device_type = "memory";
 		reg = <0x0 0x80000000>; /* 2GB */
 	};
+
+	/* Fixed regulator used in the absence of PMIC */
+	sd_vcc: sd-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.1V";
+		regulator-min-microvolt = <3100000>;
+		regulator-max-microvolt = <3100000>;
+		regulator-always-on;
+	};
+};
+
+&pinctrl {
+	mmc0_default: mmc0_default {
+		pinmux {
+			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
+				 "sd0_cmd_mfp", "sd0_clk_mfp";
+			function = "sd0";
+		};
+
+		drv_pinconf {
+			groups = "sd0_d0_d3_drv", "sd0_cmd_drv", "sd0_clk_drv";
+			drive-strength = <8>;
+		};
+
+		bias0_pinconf {
+			pins = "sd0_d0", "sd0_d1", "sd0_d2",
+			       "sd0_d3", "sd0_cmd";
+			bias-pull-up;
+		};
+
+		bias1_pinconf {
+			pins = "sd0_clk";
+			bias-pull-down;
+		};
+	};
+};
+
+/* uSD */
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_default>;
+	no-sdio;
+	no-mmc;
+	no-1-8-v;
+	cd-gpios = <&pinctrl 117 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	vmmc-supply = <&sd_vcc>;
+	vqmmc-supply = <&sd_vcc>;
 };
 
 &twd_timer {
-- 
2.27.0

