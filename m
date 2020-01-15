Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94695C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69DC424656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nEY82/y0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgAOOPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:15:08 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43453 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbgAOONJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:13:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id d16so15892000wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 06:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCdwe+dsjnxv3bml7N0qDZxbZ4I8SN1UrysTU8U3ets=;
        b=nEY82/y0BNZg4ZPeORMiuXFe/3DgtX+U5lo1ZtJ3hn5e08nKkdJbBqUlLNvOYjrZc+
         7ioEe0dTNAVDXPeWAR5n4202QgN6RV3Hct0i0HfCu1UGMI7f3VPvXyUbD2s6Z9E6L1U3
         kAcoO6GbwWhQ+KhRrBmMiBtX03QSLSiigmXMOEBTfDuGovHeOB0z9sFdkzftXdN7S2k3
         o/ESFR8PgVT5RBaDIVu8nFRcP9QafJAO6PUSV3ioLDTBqBX/Tc5qlhYxVXzpxtPTnV4M
         8RMZyG7IKrBNEnPJC5vt4TOX7Eq4cNHgfCVbRqJNiLR8ZtV2KSqXAiIkAt+f/VV8kqs7
         9oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCdwe+dsjnxv3bml7N0qDZxbZ4I8SN1UrysTU8U3ets=;
        b=HDjYShszO2vaaVwoawjy3ZnPa+s7c1VZTAD6vFXm1bCF97rgoE5J2JotWWD1g8nsvk
         1Oqym33h3pqxpMYbTRfDw2RH7H/2dY2mvG+zOKUTR3UoO6SXp3XOnwRFek692tyiUVOu
         TacxP5FR+bmxfb2iyC1PyFL5P1eznUyat6lerBy+f1UtFW37AifbLHVU108ZQ4/cmPxR
         z7eifk/lVgfaaE11lr7vreRNEcanb9aQmQgu/Ad7/BxH3IVPs2lX7r4AFjSQJqV8r8vu
         6Q/gSyTp+415Y870joMRgzHLDs/fcUY3xqZeEr3xHcCFVwiNTJzLzQUEaHtPs8L+h/4x
         Uw2g==
X-Gm-Message-State: APjAAAXK8Zu6+92H4ooL/dq3hK7BnmJ2DQ69KxlVoFt9Lyk2kbO8ovb4
        7fLtqd97UYsgUro6NbahHyCpPA==
X-Google-Smtp-Source: APXvYqyFCs8W824zav4mO7iW6IJZ2oMXu8EgcO0ACxcSO5xMO78O+j9I88X7j/y/aOwE8yO8BrTnKw==
X-Received: by 2002:adf:f484:: with SMTP id l4mr31381219wro.207.1579097587939;
        Wed, 15 Jan 2020 06:13:07 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id m21sm23730720wmi.27.2020.01.15.06.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:13:07 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
        devicetree@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 02/19] dt-bindings: phy: Add Qualcomm Synopsys Hi-Speed USB PHY binding
Date:   Wed, 15 Jan 2020 14:13:16 +0000
Message-Id: <20200115141333.1222676-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
References: <20200115141333.1222676-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sriharsha Allenki <sallenki@codeaurora.org>

Adds bindings for QCS404 USB PHY supporting Low-Speed, Full-Speed and
Hi-Speed USB connectivity on Qualcomm chipsets.

[bod: Converted to YAML. Changed name dropping snps component]

Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../bindings/phy/qcom,qcs404-usb-hs.yaml      | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qcs404-usb-hs.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,qcs404-usb-hs.yaml b/Documentation/devicetree/bindings/phy/qcom,qcs404-usb-hs.yaml
new file mode 100644
index 000000000000..4bc7a3334b54
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,qcs404-usb-hs.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/qcom,qcs404-usb-hs.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Synopsys QCS-404 High-Speed PHY
+
+maintainers:
+  - Bryan O'Donoghue <bryan.odonoghue@linaro.org>
+
+description: |
+  Qualcomm QCS-404 Low-Speed, Full-Speed, Hi-Speed USB PHY
+
+properties:
+  compatible:
+    enum:
+      - qcom,qcs404-usb-hsphy
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
+      - description: Rescource Power Management clock
+      - descirption: PHY AHB clock
+      - description: Retention clock
+
+  clock-names:
+    items:
+      - const: ref
+      - const: phy
+      - const: sleep
+
+  resets:
+    items:
+      - description: PHY core reset
+      - description: POR reset
+
+  reset-names:
+    items:
+      - description: phy
+      - description: por
+
+  vdd-supply:
+    maxItems: 1
+    description: phandle to the regulator VDD supply node.
+
+  vdda1p8-supply:
+    maxItems: 1
+    description: phandle to the regulator 1.8V supply node.
+
+  vdda3p3-supply:
+    maxItems: 1
+    description: phandle to the regulator 3.3V supply node.
+
+Example:
+
+	phy@7a000 {
+		compatible = "qcom,qcs404-usb-hsphy";
+		reg = <0x7a000 0x200>;
+		#phy-cells = <0>;
+		clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+			 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+			 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
+		clock-names = "ref", "phy", "sleep";
+		resets = <&gcc GCC_USB_HS_PHY_CFG_AHB_BCR>,
+			 <&gcc GCC_USB2A_PHY_BCR>;
+		reset-names = "phy", "por";
+		vdd-supply = <&vreg_l4_1p2>;
+		vdda1p8-supply = <&vreg_l5_1p8>;
+		vdda3p3-supply = <&vreg_l12_3p3>;
+	};
-- 
2.24.0

