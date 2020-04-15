Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AEEC2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2744020857
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="aQpWkWrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389243AbgDOPGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389395AbgDOPF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:05:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D04C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:05:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so11722220wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xuBP9KiSw+LiyttT2NfUSMQEaIQYAIyFEb6lDmiST4c=;
        b=aQpWkWrTzAUvsD7Wkh1DDjjCYMaV3utr3TO6Sl0BsOZNcb7gaDZzjUtN2e/FVX8RMZ
         44OGCA3c94cZ3ncRO5NShF6nieCD1/4EPJbt+YvibQir4SwyBqBTBFRH9Lyq2voIqdff
         XBndMyQ/BJFTGQKHpcQn6Dv808ZgFItL3naudHN+0dZ0P7e3J4IgQD11UWsCaePaCpeT
         dN1sXqXW+WYtnEEg4QjOLaYMS3X6hkj9GR14NFCnd2ng3zB4enuZO+xmC5rKETeyhSqv
         N6OiJ3veEOaaWFsarCjYLEVx/vEL5qnaELxNskVPSG2LYleksFVCf2/R4JsZf4tCUH4x
         qIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xuBP9KiSw+LiyttT2NfUSMQEaIQYAIyFEb6lDmiST4c=;
        b=TAFs2tWssTJVJo85r6FX99uBvF6lpOMk1JpRexbC8kxIS/Ag8ead04zgrKeC0JDPCB
         /alyn0etdHvStuR97gk83qYeR/bjn3zJqJWlYYD3Fllc0h3YMaEDQ5nCYPlC94D46mjs
         8VjXIsydbscsBmXXhCB9lMdH+WHiujTSbp7nDhy0d+8A9+tdL8NJq+/5rroEqw7Vsfyu
         BFImNGYhgc3kZ3+85hLxwT1EoIjLvfH7LPjojR/jnmZov33uSZ6u8pQ/YxqEuQqr3Jaf
         LfcEObfagrOYGdMuphZ0LQBD0lfjJ9aaa+xfzirn1bfBqeKhBeES/QIzcNKXY1EluMyN
         +XFw==
X-Gm-Message-State: AGi0PuaiQZnx/2rKxR7awY3FW6Dyo1JtXKO/3v/9ZcHQ5lB0UF8IzjOb
        g5LS/gNdc6cFZ/XJpuisw19qQA==
X-Google-Smtp-Source: APiQypLGJ18uxlRWZ+/jU+bOu2t7wGjpYa4tfIQVEb+GudKXVy4DgdD2IfFXJ+DWDD1LRgQJ5BEY3g==
X-Received: by 2002:a1c:7706:: with SMTP id t6mr5674184wmi.110.1586963155753;
        Wed, 15 Apr 2020 08:05:55 -0700 (PDT)
Received: from localhost.localdomain (dh207-96-108.xnet.hr. [88.207.96.108])
        by smtp.googlemail.com with ESMTPSA id s6sm22729988wmh.17.2020.04.15.08.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 08:05:55 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH v3 2/3] dt-bindings: add Qualcomm IPQ4019 MDIO bindings
Date:   Wed, 15 Apr 2020 17:02:46 +0200
Message-Id: <20200415150244.2737206-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200415150244.2737206-1-robert.marko@sartura.hr>
References: <20200415150244.2737206-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding document for the IPQ40xx MDIO driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
Changes from v2 to v3:
* Remove status from example

 .../bindings/net/qcom,ipq40xx-mdio.yaml       | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,ipq40xx-mdio.yaml

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq40xx-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq40xx-mdio.yaml
new file mode 100644
index 000000000000..8d4542ccd38c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qcom,ipq40xx-mdio.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/qcom,ipq40xx-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ40xx MDIO Controller Device Tree Bindings
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+allOf:
+  - $ref: "mdio.yaml#"
+
+properties:
+  compatible:
+    const: qcom,ipq40xx-mdio
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+examples:
+  - |
+    mdio@90000 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      compatible = "qcom,ipq40xx-mdio";
+      reg = <0x90000 0x64>;
+
+      ethphy0: ethernet-phy@0 {
+        reg = <0>;
+      };
+
+      ethphy1: ethernet-phy@1 {
+        reg = <1>;
+      };
+
+      ethphy2: ethernet-phy@2 {
+        reg = <2>;
+      };
+
+      ethphy3: ethernet-phy@3 {
+        reg = <3>;
+      };
+
+      ethphy4: ethernet-phy@4 {
+        reg = <4>;
+      };
+    };
-- 
2.26.0

