Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A10FEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A642253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 14:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPti3YbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgAVOAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 09:00:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44074 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVOAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 09:00:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id q10so7345769wrm.11;
        Wed, 22 Jan 2020 06:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=llJtsD1yoIdDJJBrtXp9tF8w1Mo3indfYk+7VrYbE8Q=;
        b=LPti3YbVAbzC2HZff/IMU/SFTweupPZu/GOiGZN9vql4modIiuZ3/cwzVaLLSrNJiw
         dG7UEPKYxTXvjTPo3JN4jZnYd20NISOouc4ovwQbfCJ5t43jZvWIAoA09LFe8ygG7TNi
         gUHkFoi/Qu/rfCIPnfnuVItWYB4ka3OmnKcbZLRK0QrAtn0TIFABVLA6DsjyFkfa20kF
         jZx9wixTeVwQtAQ3H0VixiVKaViYqlauD2uf4wKeaQpctjPnxRcfHkznSNjsHE2FNBAz
         5qC6CIDRU+yllm53O/74+quY1OprrxTlAT/zULBFW/g3TAbtDIpVNZz8OdCJ84P41URO
         UJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=llJtsD1yoIdDJJBrtXp9tF8w1Mo3indfYk+7VrYbE8Q=;
        b=ovqfEam1d+HTsdwsU0Zm4qlzkz6NyluLq1xGlZ+MCIToZ2bScrFEoJPJKPie/+r0tZ
         B96PMorU7f4pvWWW2FFCgTJZK62nSMHwCdlO2XIylByjU/gP+NvqR9ekL9G0jzvp2JMb
         dDoVvUwbh3gmPMSqQ8BymIQreIeOhhlBXWXL5G8cOYjDNXVg7a3VrXPN38OcmUXKTmEj
         9aKsmIO2ziuPChKAalsCqTfSCVOBV0zWUucOrfubK1ndH90+2x//d/z7NYz0VDwCoGTD
         xLJhlc7O8fA+8CBg2zXgDyIlDnXJ7OoSkC0k7UmLjBGqLxm5A5oa1ZK+UtSS23nayYNk
         4oeg==
X-Gm-Message-State: APjAAAXHbasxOPXQ1Be2+o8OscXy0EsoQyur66YS6xgEbQT39dfUNZCw
        sZI9v9EGghIjcy8Nj4fMKRaN+SQBv8k=
X-Google-Smtp-Source: APXvYqyqAliVAlgsh46doxlz8/cWPyE704oyfyXYAxyPxE2HR7uLHYPdl3E1wVNaWzdYPlbj/MotEA==
X-Received: by 2002:a5d:534d:: with SMTP id t13mr11871938wrv.77.1579701618471;
        Wed, 22 Jan 2020 06:00:18 -0800 (PST)
Received: from localhost.localdomain (p5DCFF1C1.dip0.t-ipconnect.de. [93.207.241.193])
        by smtp.gmail.com with ESMTPSA id g2sm57388270wrw.76.2020.01.22.06.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 06:00:17 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        davem@davemloft.net, mchehab+samsung@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: regulator: add document bindings for mp5416
Date:   Wed, 22 Jan 2020 14:59:56 +0100
Message-Id: <20200122135958.13663-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200122135958.13663-1-sravanhome@gmail.com>
References: <20200122135958.13663-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding information for mp5416 regulator driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 .../bindings/regulator/mps,mp5416.yaml        | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mp5416.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
new file mode 100644
index 000000000000..702508e4267f
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mps,mp5416.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Monolithic Power System MP5416 PMIC
+
+maintainers:
+  - Saravanan Sekar <sravanhome@gmail.com>
+
+properties:
+  $nodename:
+    pattern: "pmic@[0-9a-f]{1,2}"
+  compatible:
+    enum:
+      - mps,mp5416
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    allOf:
+      - $ref: regulator.yaml#
+    description: |
+      list of regulators provided by this controller, must be named
+      after their hardware counterparts BUCK[1-4] and LDO[1-4]
+
+    patternProperties:
+      "^buck[1-4]$":
+        $ref: "regulator.yaml#"
+        type: object
+
+      "^ldo[1-4]$":
+        $ref: "regulator.yaml#"
+        type: object
+
+    additionalProperties: false
+  additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - regulators
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@69 {
+          compatible = "mps,mp5416";
+          reg = <0x69>;
+
+          regulators {
+
+            buck1 {
+             regulator-name = "buck1";
+             regulator-min-microvolt = <600000>;
+             regulator-max-microvolt = <2187500>;
+             regulator-min-microamp  = <3800000>;
+             regulator-max-microamp  = <6800000>;
+             regulator-boot-on;
+            };
+
+            ldo2 {
+             regulator-name = "ldo2";
+             regulator-min-microvolt = <800000>;
+             regulator-max-microvolt = <3975000>;
+            };
+         };
+       };
+     };
+...
-- 
2.17.1

