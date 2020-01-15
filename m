Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C6BC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3732467D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I31EknCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgAOONQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:13:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44434 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbgAOONM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:13:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so15889232wrm.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nWgJuKnKe2SBn73azCS8u4UiAG88rfUFNWE/ANlTpX0=;
        b=I31EknCzD3TH7Es/RpEGkKg1eeUwbESGqgoiUxv6yx7BRJW761w2kObfINWKdWsiz/
         geYIDDnxuwLo6JlgBkJ/gY/ygWzRL/vU6bBsL5yf5ppFYHkt3FUXhnpdiymrQiklzonU
         BgYmELJVIjtkO4YRqCLkZpPZlXoEVDNmFJ2RZzw2yThBRrfcB4hk8hHtpx1T+X8TFT9L
         rNJXsiFi9+mJfIdELLw3OatJR1NvyXmn/smMRhP0JEZIhb43r05iD8ottHPxKWUz0KwV
         tG5TJWCE7MXUMZDbudzLyeGwbNsqg65Cdom26V4Se0RZJHb3TCLQt/28UaXCp+RafkSb
         bwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nWgJuKnKe2SBn73azCS8u4UiAG88rfUFNWE/ANlTpX0=;
        b=esIx0DUqbFk4uO83O0RU6UakPPnGrvSNBF0CwM9CDtsd91LYIZZi3a97is1RXOZYBu
         hw581DCWlOx5kxpAyggeE/bQoeRb3/tcyZdBaGkm0LAnGlaAhwPgPb/bXLASHiMukUmB
         +d41P5nU+MXZvZtRAbbZ3Zc5liOC1LE7aHSQ5AcjkOMYWoucxKRJ8lxJyAB0QAfSiRQu
         WwLlMHak/58BHGys1l8V0+PvF+CjANBFEglY9DG0XGyLljMhy2+6MtFh/JoxmOQBk3Qp
         YC/kSlojC5n4MicSKD6Kd6q33eUQcRadRif9/OYq9XAAtSCSkwvVKvzy01+RylZE5p7v
         yLWA==
X-Gm-Message-State: APjAAAUQeFgvVPm5MpCjGzpHw6WOQpue7Yaw+GEyDshIJifsGqCvpl2g
        /Yj6m9VSt55yi+Qsv7M5NqFOzw==
X-Google-Smtp-Source: APXvYqyU468zJql6OZKrz6H/3JbxwJjaJTcbgNPPhW1aN1w4uMkl7DYGnYit+BmPBPF2MrRCcROo5A==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr32580311wrq.348.1579097590717;
        Wed, 15 Jan 2020 06:13:10 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id m21sm23730720wmi.27.2020.01.15.06.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:13:10 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 04/19] dt-bindings: Add Qualcomm USB SuperSpeed PHY bindings
Date:   Wed, 15 Jan 2020 14:13:18 +0000
Message-Id: <20200115141333.1222676-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
References: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Binding description for Qualcomm's Synopsys 1.0.0 SuperSpeed phy
controller embedded in QCS404.

Based on Sriharsha Allenki's <sallenki@codeaurora.org> original
definitions.

[bod: converted to yaml format]

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../devicetree/bindings/qcom,usb-ss.yaml      | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/qcom,usb-ss.yaml

diff --git a/Documentation/devicetree/bindings/qcom,usb-ss.yaml b/Documentation/devicetree/bindings/qcom,usb-ss.yaml
new file mode 100644
index 000000000000..fb0e399d64a0
--- /dev/null
+++ b/Documentation/devicetree/bindings/qcom,usb-ss.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/qcom,usb-ss.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Synopsys 1.0.0 SuperSpeed USB PHY
+
+maintainers:
+  - Bryan O'Donoghue <bryan.odonoghue@linaro.org>
+
+description: |
+  Qualcomm Synopsys 1.0.0 SuperSpeed USB PHY.
+
+properties:
+
+- compatible:
+    enum:
+      - qcom,usb-ssphy
+
+  reg:
+    maxItems: 1
+    description: USB PHY base address and length of the register map.
+
+  "#phy-cells":
+    const: 0
+    description: Should be 0. See phy/phy-bindings.txt for details.
+
+  clocks:
+    items:
+      - description: Block reference clock
+      - description: PHY AHB clock
+      - description: SuperSpeed pipe clock
+
+  clock-names:
+    items:
+      - const: ref
+      - const: phy
+      - const: sleep
+
+  vdd-supply:
+    maxItems: 1
+    description: phandle to the regulator VDD supply node.
+
+  vdda1p8-supply:
+    maxItems: 1
+    description: phandle to the regulator 1.8V supply node.
+
+  resets:
+    items:
+      - description: COM reset
+      - description: PHY reset line
+
+  reset-names:
+    items:
+      - description: com
+      - description: phy
+
+Example:
+
+usb3_phy: usb3-phy@78000 {
+	compatible = "qcom,usb-ssphy";
+	reg = <0x78000 0x400>;
+	#phy-cells = <0>;
+	clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+		 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+		 <&gcc GCC_USB3_PHY_PIPE_CLK>;
+	clock-names = "ref", "phy", "pipe";
+	resets = <&gcc GCC_USB3_PHY_BCR>,
+		 <&gcc GCC_USB3PHY_PHY_BCR>;
+	reset-names = "com", "phy";
+	vdd-supply = <&vreg_l3_1p05>;
+	vdda1p8-supply = <&vreg_l5_1p8>;
+};
-- 
2.24.0

