Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7542DC8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FB8F2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="2NFtPuDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgD3JHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726877AbgD3JHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:07:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752F9C08E859
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 02:07:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so5913117wrx.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 02:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aSnhROolTmuNxKQ1QNrIfCpkc60JhptC2Ev7o1MMRIs=;
        b=2NFtPuDai2GU04crZKM1empmfPhhA0Bls4/L4/QBIxjpleOLdh4HhLB8HS2qu8LTWe
         PTryYB1/x9f2RDQCnTnTXXDUhXqeXtQhj4/3kN0tl9iOGOBXLAMWe9DmN/abE5PjLg6v
         RRi+qi6mmiywapKBX4rE2ggqBde5iCJ6UrTKbhjMjJs5Ps+bjIgwVkttddT/E1YWAnxJ
         Odbv1sZjCOx1PajkLcUeuK/Oka3YY7QlUPVr1LJAarWD7ghoRjAE2iBp3hF944f+PytA
         iSYC5OoPZpEw/iOLkUXRWpd8uGTA+AONLKX2CYK0BXkBvzXDyvCo2322CldgdrdTaIPy
         arEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aSnhROolTmuNxKQ1QNrIfCpkc60JhptC2Ev7o1MMRIs=;
        b=tGY5VzlBh3Nv6lKxL0y65n5Q9wd4BQ+NNETEQfv7IodVgTmgeCquWplVX55apgywMk
         WoHtFgMVx9kDWW83b3VDQ/L78mYPojwYkRlHYHRMVSLnb3VCvY9dxXuZ+2yrn/CNAMYo
         wrHH3UQeItbZcQ+nCQbVvs5d4rkAPF6YeNqJHbBbYQ6zLQqUyZJgkLpEw1MNKJaBo5gK
         nGNsK1Gg5AVOuKMYhf6MP0A/9iKeVWCw8jl5PdJ32p4HidCidV9eOwCd554eMH95RW1x
         5qtuvMJvSQ8rq3zGx3ufwD5lFic87aX016Reyc8FQudaciu5y5tg5Tx/osyGcVy4Brii
         NICg==
X-Gm-Message-State: AGi0Pubvinj/BAZjSmecmmivsHt7CKwiVj3xoFpNdvjbIg84/ZEGse4u
        bI7bJNLK5OGKsqopWeDMm2e2Cg==
X-Google-Smtp-Source: APiQypL+whDX5YNFdXzbe4mSiXm401XyLwWMRAoZ34VLjzYsrzmdjvMTFU4y44SUGA4hPfEVMtYeIw==
X-Received: by 2002:a5d:4b90:: with SMTP id b16mr3110846wrt.16.1588237654217;
        Thu, 30 Apr 2020 02:07:34 -0700 (PDT)
Received: from localhost.localdomain ([2a0e:b107:830:0:47e5:c676:4796:5818])
        by smtp.googlemail.com with ESMTPSA id t20sm10962025wmi.2.2020.04.30.02.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 02:07:33 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH net-next v5 2/3] dt-bindings: add Qualcomm IPQ4019 MDIO bindings
Date:   Thu, 30 Apr 2020 11:07:06 +0200
Message-Id: <20200430090707.24810-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430090707.24810-1-robert.marko@sartura.hr>
References: <20200430090707.24810-1-robert.marko@sartura.hr>
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

