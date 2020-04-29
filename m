Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E13C83008
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E1B5206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="QwXmhE5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgD2LHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726763AbgD2LHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:07:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73A2C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 04:07:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x25so1561715wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 04:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aSnhROolTmuNxKQ1QNrIfCpkc60JhptC2Ev7o1MMRIs=;
        b=QwXmhE5qWDAkWjzdHbjpiTsLA+p3V43d0fbmYy8GvFDksu36JE4zXU+86t7Lxg7Fet
         dovlmBqmVxNL42ccpHeogzWqvaWR+kRxQhpCvYkUSBuk8JClKGqYGEXVdB0MM0h9d+I+
         ZifFG0zbI+ZPSzM+Uz2PgPA1NLxsXoAeu9aKrCA8NRdXDVkqzK2oRL68T+uLM9HlVBJb
         aetBsbAKSz2dTjA/8zJ2IiZlvUMXhG9IGL+Ize4Qh9EWYnMWaEh2YhkWt9sfbTpbW3rG
         PU7PZD1/09P8oLJIOqcmsGZFkSaQkbAV1ToEG3gdv1k21ZtLWwWU4WyQZqpFLyCDAR1K
         TyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSnhROolTmuNxKQ1QNrIfCpkc60JhptC2Ev7o1MMRIs=;
        b=fLm7ALXIke5nao0gEFFVrgOP4UHLbSa2x2C3gCAhTe7xejV4ytIgwmSw66SO447HrT
         TX/f2OOoOdvpSKH9opyvXCzaK0P4X0eyGBC0sFD5G8ssYFqMzlBv9p7iTs3y83piRp0K
         QAXHg+vB09nLgx8bz58it+7ayWEbkHerCTB+HhENHxdQfCXAD7hWjdQIehWyLla7DxQI
         SIKmYRjkYdBq8LpsmjvFlpBDQaShW2f2CRs5L/5Gqmx8HK+qQGaakZQXJnE8yMTWtf4q
         EfvGr13DzzP4L8egpI9GmA4TvsCIGwI2G4oyJPXBCLC7ARvNCdYwICZuYf71Uo3wQJAF
         2mDw==
X-Gm-Message-State: AGi0PubSSbYUKAgDZ3dnuIGDsI2yz9IZLHg9ySwHxhPM/bGLOaeynN2P
        AeqrEzev2kqH6hfVuylRbDs6nw==
X-Google-Smtp-Source: APiQypLmUgpJaxB5VPlSnHJSesl0RQ8e4JIIM5bsCt3hYva+UhaVRRCprLFOqSedCafGW2tkSNzoTg==
X-Received: by 2002:a7b:c3cf:: with SMTP id t15mr2731954wmj.34.1588158469477;
        Wed, 29 Apr 2020 04:07:49 -0700 (PDT)
Received: from localhost.localdomain ([2a0e:b107:830:0:47e5:c676:4796:5818])
        by smtp.googlemail.com with ESMTPSA id u7sm7679963wmg.41.2020.04.29.04.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 04:07:48 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH net-next v4 2/3] dt-bindings: add Qualcomm IPQ4019 MDIO bindings
Date:   Wed, 29 Apr 2020 13:07:26 +0200
Message-Id: <20200429110726.448625-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429110726.448625-1-robert.marko@sartura.hr>
References: <20200429110726.448625-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding document for the IPQ40xx MDIO driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
Changes from v3 to v4:
* Change compatible to IPQ4019

Changes from v2 to v3:
* Remove status from example

 .../bindings/net/qcom,ipq4019-mdio.yaml       | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml

diff --git a/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
new file mode 100644
index 000000000000..13555a89975f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/qcom,ipq4019-mdio.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/qcom,ipq4019-mdio.yaml#
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
+    const: qcom,ipq4019-mdio
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
+      compatible = "qcom,ipq4019-mdio";
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
2.26.2

