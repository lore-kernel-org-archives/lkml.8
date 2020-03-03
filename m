Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D20C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E066D214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oJGEbw49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgCCRL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:11:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50597 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbgCCRLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:11:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so4173104wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 09:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WG9OW47c/SOzcUAJmIFO7wHxMk/qQfRkSNCfV4wOk3o=;
        b=oJGEbw492oMwRTCW1exJvY3UGI70SPkKQU3oZd9bqOrwEAoOpiCD+bEj5o+u3D0IQo
         Orcd6DwJO4jy1pSzI1mMTCQIZqirG+x9Kbwe6fymvFx9ndBDWLeBHb2O9uFQO8yDhRH4
         SZV7t+ySHbK1ZuJG6N3krGfj8+HAyVAaHab5s//S81D0hNcgRasoCllbjlNdPY5sVDDf
         a2o5nsnbTpSCuDzIx9YwMQIitBWiMlweTzB2TB884+Nn3fMYHT0tPtRvo8jp79VLZYZJ
         3krHJaWHrGWZf1RtrDA2IdNy7VTKh1mKx4Wph+U7FGVLjn1/yQIzD/BjDZazoxs/Qs+f
         qg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WG9OW47c/SOzcUAJmIFO7wHxMk/qQfRkSNCfV4wOk3o=;
        b=JmLeSMYJ0i5g9Ff5C/GTmYnmYpufYnKXQ+3G3Ruwv+ddv87kDDKqz5lEiM204M+/MC
         UvPUReLIS9I7ve2t8oYS5svTVga8HNmw6cPfVGXxgnUc07I/XO9/ca+1Ed7XAS3eAjA1
         HhVbnPYT5ei2MPbSG2NSr1oMJTwJAvtfmpyywmaOqF18NJf8No0om+ulxipknXAsupQL
         zT0ytMZGfJYCKUviO7L9QivvzLaOE5917JceO4y3AlwXa2QEHN7kh3TRWnpPpGNRW3LI
         diFHSXjYk3jKbZoRt/Rq54gabxsWlQ3DpnWh4MYTNoYJyDQAsVqyNsD2D8Gq8VxIrRSZ
         EYBA==
X-Gm-Message-State: ANhLgQ1K+x6QU26HQW3/RPx1mAiSmuEy/TExlxFba08kT9A7l7tVEqTX
        991NX4LUJlB45jxPfzZrp2MYjQ==
X-Google-Smtp-Source: ADFU+vvOjVRFm/QXN6OLeEKElNVNpdE0fdGMJkLkZuJBIblhB7yphzOzBdKQjMpfGEjh+j2WKaQJAw==
X-Received: by 2002:a1c:a70a:: with SMTP id q10mr5145324wme.88.1583255513206;
        Tue, 03 Mar 2020 09:11:53 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id z13sm5425319wrw.88.2020.03.03.09.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:11:52 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
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
Subject: [PATCH v7 02/18] dt-bindings: phy: Add Qualcomm Synopsys Hi-Speed USB PHY binding
Date:   Tue,  3 Mar 2020 17:11:43 +0000
Message-Id: <20200303171159.246992-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303171159.246992-1-bryan.odonoghue@linaro.org>
References: <20200303171159.246992-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sriharsha Allenki <sallenki@codeaurora.org>

Adds bindings for Qualcomm's 28 nm USB PHY supporting Low-Speed, Full-Speed
and Hi-Speed USB connectivity on Qualcomm chipsets.

[bod: Converted to YAML. Changed name dropping snps, 28nm components]

Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
Signed-off-by: Anu Ramanathan <anur@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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
 .../bindings/phy/qcom,usb-hs-28nm.yaml        | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml
new file mode 100644
index 000000000000..ca6a0836b53c
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-28nm.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/qcom,usb-hs-28nm.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Synopsys DesignWare Core 28nm High-Speed PHY
+
+maintainers:
+  - Bryan O'Donoghue <bryan.odonoghue@linaro.org>
+
+description: |
+  Qualcomm Low-Speed, Full-Speed, Hi-Speed 28nm USB PHY
+
+properties:
+  compatible:
+    enum:
+      - qcom,usb-hs-28nm-femtophy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  clocks:
+    items:
+      - description: rpmcc ref clock
+      - description: PHY AHB clock
+      - description: Rentention clock
+
+  clock-names:
+    items:
+      - const: ref
+      - const: ahb
+      - const: sleep
+
+  resets:
+    items:
+      - description: PHY core reset
+      - description: POR reset
+
+  reset-names:
+    items:
+      - const: phy
+      - const: por
+
+  vdd-supply:
+    description: phandle to the regulator VDD supply node.
+
+  vdda1p8-supply:
+    description: phandle to the regulator 1.8V supply node.
+
+  vdda3p3-supply:
+    description: phandle to the regulator 3.3V supply node.
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - vdd-supply
+  - vdda1p8-supply
+  - vdda3p3-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-qcs404.h>
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    usb2_phy_prim: phy@7a000 {
+        compatible = "qcom,usb-hs-28nm-femtophy";
+        reg = <0x0007a000 0x200>;
+        #phy-cells = <0>;
+        clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+                 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+                 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
+        clock-names = "ref", "ahb", "sleep";
+        resets = <&gcc GCC_USB_HS_PHY_CFG_AHB_BCR>,
+                 <&gcc GCC_USB2A_PHY_BCR>;
+        reset-names = "phy", "por";
+        vdd-supply = <&vreg_l4_1p2>;
+        vdda1p8-supply = <&vreg_l5_1p8>;
+        vdda3p3-supply = <&vreg_l12_3p3>;
+    };
+...
-- 
2.25.1

