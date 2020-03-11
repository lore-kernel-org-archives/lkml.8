Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6C6C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B0320737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ay+QlVEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbgCKTOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:14:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40766 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731096AbgCKTOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:14:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id p2so4114919wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 12:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6TXvp/hgnbBEE+3PAwbtcQCr5QoU1b6s07axWH6/RUg=;
        b=Ay+QlVEBOL/0e7o+/gvQhcRxio+sMll2rHA1eD7ibml+VDLdgYphOUtH/iQ5bNtYww
         ClYokrdzFRv06VwEVYaigLIOSN17CKOHTB8AGg3XztYci4bEUYotC2ErvhjPbO7j3Jzx
         EuaNL5uzTnoPrNSraPlyX/VkhY3EGSC/h6+CupI3+w9orewwJTclni2BGDwGjltQ7Mzt
         dCBUxvU1HHjxC6cDL3odRauXpTPxc/bxSLCkflmeZA074Lv6HgmyLENMX+5maInPzKRI
         0P7leVsOl/6ZPMYqO3pAtpLy3I4wopkX6flmHn//a/tHSs6dhAC6sEp/YAIUuavR/lBP
         Z6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6TXvp/hgnbBEE+3PAwbtcQCr5QoU1b6s07axWH6/RUg=;
        b=YdCQbpn0yfrfDQgEGJWI6pjQd3GkU1hajh7XyvUgptrJhW2tlT0TQIOhkG80Kfdx6b
         JM3jn7zMPuGJt0bZrnEbfMyW1ohvFYp67cHfdkV2e1r2JQh4w2Mo6dt8AXzNdsAXi2+a
         nZCaX60NCiGMB0AUBJ6O/ij+TIupy6LzFdBVIk8fNL7P2ekjx1nfKPpFAidIgmfkSMGt
         ieKoXFUUN/G7d3lxIgzzmDHtVf2l7aZ5VokGnzMNu71fxNoJAgh2vjfPoEqle6d3qZ+A
         8vLyVjH2Bo5pbmV0l6178LTbTad4Mtub8Xv9EgwuQFp+XlpJpeC52SV1MY4ux1rmeylo
         a4KA==
X-Gm-Message-State: ANhLgQ1Vd7c1jVkI4yLzPmgoS5YhxK3A0d7DoMai+mfQSLU0RXyMevpP
        0ThQq6En3CZhPqVzftsIwsscCA==
X-Google-Smtp-Source: ADFU+vsbEv2tuX+E1jYdkMH5f0uMwjyU8P2rDau6VWAyG7B1QlgLDIYBiQajaZazh3TacboViVryFA==
X-Received: by 2002:adf:f2ca:: with SMTP id d10mr6207510wrp.247.1583954041879;
        Wed, 11 Mar 2020 12:14:01 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id v8sm69443919wrw.2.2020.03.11.12.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 12:14:01 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kishon@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jackp@codeaurora.org,
        robh@kernel.org, bjorn.andersson@linaro.org,
        p.zabel@pengutronix.de,
        Sriharsha Allenki <sallenki@codeaurora.org>,
        Anu Ramanathan <anur@codeaurora.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
        devicetree@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 2/5] dt-bindings: phy: Add Qualcomm Synopsys Hi-Speed USB PHY binding
Date:   Wed, 11 Mar 2020 19:13:55 +0000
Message-Id: <20200311191358.8102-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311191358.8102-1-bryan.odonoghue@linaro.org>
References: <20200311191358.8102-1-bryan.odonoghue@linaro.org>
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
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
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

