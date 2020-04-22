Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB69C5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F95420774
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oDW7AMfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgDVLKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725924AbgDVLKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:10:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE77C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:10:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x17so1152894wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7f32msqOiQc0JpLw4MsEw0QrRZ2lpHCE6FKLkalbvhU=;
        b=oDW7AMfFyPLs3g/zpMq2viBMk8aiY9eT4ASTGtRNfZ/GNURtr5HFv+DKOuGmhURwNx
         GR6EDrdL3h4lx7VJpQZEeHiweD8WchR/17GnC0HM9nrLRMwVFA6HY4kuQq53cqoiAL53
         mDkjEPJkQq9P+x04dN36TjDnEUEy9xVaKEnL/SXcddRNRpjwunVNbITSolUIRvdtSCRI
         judJfd45dgbj2MidVMBv4ktQjbWqPLZ7screXp/fetAlVT9bISvXZobEegwbEuoPPBc3
         gX+XheeZyB8YLvL3CragfDHRWXmTMDxQPjw3nxikD76TH1Z+emCQ/wUtg2g6n9lplUXD
         BcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7f32msqOiQc0JpLw4MsEw0QrRZ2lpHCE6FKLkalbvhU=;
        b=RxJDQf1lJcd6pIs+s8sMkgrYPZaQUf+ZFobaZOTc3oVOp14B+CQNwq+oJwDkVqUns3
         MMHjVq6gryZw1b/B5GpqXUr7BYHPCtxyXLMMS6DfSyIrD0j+BxXWRTFbjdpxcim0RMGh
         ZMgnIRKU/cK/zX7sS456aE1U4/cHMTyytivwCYamZEBAastJzFv4orxbYE9b35rgjoKT
         RX1bUq8OqxBROjexJE+9Y5212NGdSxoFZSHe2Cj7lDtoE1Y/IqZhvSRsXK03z0DHAeH3
         aU+73skvowugdTKK1qnEJCwmddTjWdVZZtu87ybD2UxMkJLzYd6hiXmRBfCY2tuaFMix
         5RKg==
X-Gm-Message-State: AGi0PuZyfJ/Qtr1rqXdIC4QRUQI7RYfAsKVwSKSrNwz98m+2xydYRBsE
        JZiIn8MDFNwfh6PZQGK7Lc0p9Q==
X-Google-Smtp-Source: APiQypINbD+SwSQX239iVL4ARcQzUpE85tcDSAX0g1f/DkT80BUmiUIIWTpHdSuEhZG7PDqB5JWNiA==
X-Received: by 2002:a5d:470a:: with SMTP id y10mr28586916wrq.63.1587553820230;
        Wed, 22 Apr 2020 04:10:20 -0700 (PDT)
Received: from localhost.localdomain ([37.120.50.78])
        by smtp.gmail.com with ESMTPSA id h188sm7993906wme.8.2020.04.22.04.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 04:10:19 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v1] arm64: dts: qcom: apq8016-sbc-d3: Add Qualcomm APQ8016 SBC + D3 mezzanine
Date:   Wed, 22 Apr 2020 13:10:14 +0200
Message-Id: <20200422111014.616233-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device treee support for the Qualcomm APQ8016 SBC, otherwise known as
the Dragonboard 410c with the D3 mezzanine expansion board.

The D3 mezzanine ships in a kit with a OmniVision 5640 sensor module,
which is what this DT targets.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/Makefile           |  1 +
 arch/arm64/boot/dts/qcom/apq8016-sbc-d3.dts | 45 +++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/apq8016-sbc-d3.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index cc103f7020fd..025362471929 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc-d3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
 dtb-$(CONFIG_ARCH_QCOM) += apq8096-ifc6640.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc-d3.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3.dts
new file mode 100644
index 000000000000..1b85adeeada1
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc-d3.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015, The Linux Foundation. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "apq8016-sbc.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. APQ 8016 SBC w/ D3 Mezzanine";
+	compatible = "qcom,apq8016-sbc", "qcom,apq8016", "qcom,sbc";
+};
+
+&cci_i2c0 {
+	/delete-node/ camera_rear@3b;
+
+	camera_rear@76 {
+		compatible = "ovti,ov5640";
+		reg = <0x76>;
+
+		enable-gpios = <&msmgpio 34 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&camera_rear_default>;
+
+		clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
+		clock-names = "xclk";
+		clock-frequency = <23880000>;
+
+		vdddo-supply = <&camera_vdddo_1v8>;
+		vdda-supply = <&camera_vdda_2v8>;
+		vddd-supply = <&camera_vddd_1v5>;
+
+		status = "ok";
+
+		port {
+			ov5640_ep: endpoint {
+				clock-lanes = <1>;
+				data-lanes = <0 2>;
+				remote-endpoint = <&csiphy0_ep>;
+			};
+		};
+	};
+};
-- 
2.25.1

