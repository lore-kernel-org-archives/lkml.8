Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D049C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4094822522
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3TUXDLF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgATQax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:30:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43105 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbgATQav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:30:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so61960wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nTFFco0gWzvhgT9KdZyGts1IZHmn3ADc6A60yVAjcjA=;
        b=E3TUXDLFsRf1DDHWwkKh7tckR0wSSQmYwx7t2OpjARissZgKnYrJ/ZSN7y8mj9ZxJK
         SPb/Uwj1ZoYSJtQWV04eIYbHRTFMVXAxCrS0tzNJnSHEZwKTlLg/JOg4p/2WOVe90Ksl
         tLwyAdhOiQsJyrf3GAS0wOK/vWnvek13HtVnymYsZ7+wSUkdK6HWPoBt7eE+s7wYF26D
         qOeMrFrCSi2Hy/gmtRWe//9MGWj9Td0DnEShAMcRRwJktAuTyfBnOF+x+w56mLA2bDac
         Mf4PmJwc6ZZTRIK6N2QNrfsP6qcaimBat6dycGo86hUR9oPUyqXLS4p+7mFMVkPVBGaS
         24dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nTFFco0gWzvhgT9KdZyGts1IZHmn3ADc6A60yVAjcjA=;
        b=E5LnPgasIwFqXsu8LbGtN2q91Xvb6BTdDZer+Q6sPSzvVPpssJ/EUrjCX0uU81lNUW
         vLFux87MzSdPkFSuvIa9NIVVMzk0tWxr2zX+G9CoRTNL+co0seJsYKhGtzg/U74M3zqp
         rs50FDxNbjgTcGGeBnLwQbvO0LuaF9UlqW/E4qH9uRSghcLb6TfgD1l58kgCx87peTiK
         UnTFIFWORLvYqNl+Y36yahhZkrTb3Kk0VuwwaY0/R97TfG0VCQa2vF7xCI6lzywt1dmU
         4cV9sSLNqa1loL9bgnNLLGXqbGptkghi69Etijh3PxZf/ad8rKaTAXsFKxjhjWEYf11E
         PhLA==
X-Gm-Message-State: APjAAAXDQfpr05wiRSEqVr3NWBzREVTImkmof0dxxEVgT+ShAwRLPvyX
        wOLgtAVjujNRp9rTj3cUsXL9aQ==
X-Google-Smtp-Source: APXvYqwQd9Ak+wLCPW1MjhuwABPMU2OcpO5+S4zND3DZkbpw3Va8L9RDfryhgP5CaMmMUnDRqPlwwg==
X-Received: by 2002:adf:f508:: with SMTP id q8mr341639wro.334.1579537849345;
        Mon, 20 Jan 2020 08:30:49 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id p26sm22631756wmc.24.2020.01.20.08.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:30:48 -0800 (PST)
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
Subject: [PATCH v2 02/19] dt-bindings: phy: Add Qualcomm Synopsys Hi-Speed USB PHY binding
Date:   Mon, 20 Jan 2020 16:30:59 +0000
Message-Id: <20200120163116.1197682-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200120163116.1197682-1-bryan.odonoghue@linaro.org>
References: <20200120163116.1197682-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sriharsha Allenki <sallenki@codeaurora.org>

Adds bindings for QCS404 USB PHY supporting Low-Speed, Full-Speed and
Hi-Speed USB connectivity on Qualcomm chipsets.

[bod: Converted to YAML. Changed name dropping snps, 28nm components]

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
 .../bindings/phy/qcom,qcs404-usb-hs.yaml      | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,qcs404-usb-hs.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,qcs404-usb-hs.yaml b/Documentation/devicetree/bindings/phy/qcom,qcs404-usb-hs.yaml
new file mode 100644
index 000000000000..d71beb822ae2
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,qcs404-usb-hs.yaml
@@ -0,0 +1,77 @@
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
+    minItems: 3
+    maxItems: 3
+    description: phandles to rpmcc ref clock, PHY AHB clock, rentention clock.
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
+      - const: phy
+      - const: por
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
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-qcs404.h>
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    usb2_phy_prim: phy@7a000 {
+        compatible = "qcom,qcs404-usb-hsphy";
+        reg = <0x0007a000 0x200>;
+        #phy-cells = <0>;
+        clocks = <&rpmcc RPM_SMD_LN_BB_CLK>,
+                 <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
+                 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
+        clock-names = "ref", "phy", "sleep";
+        resets = <&gcc GCC_USB_HS_PHY_CFG_AHB_BCR>,
+                 <&gcc GCC_USB2A_PHY_BCR>;
+        reset-names = "phy", "por";
+    };
+...
-- 
2.25.0

