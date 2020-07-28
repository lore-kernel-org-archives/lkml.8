Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0813C433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B895F206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="ga1ZKfZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbgG1Ph3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730980AbgG1Ph2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:37:28 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D644C0619D5;
        Tue, 28 Jul 2020 08:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=8U8d57fTvKbnfQeL2WijppntHp3dgQ6+xk
        gunHKX9io=; b=ga1ZKfZ7/WYuxWJ/xGTZsLzyDvdKPkp1HmOrS0qSEoh/RQnoH1
        Bus1AS27HJF3mvw3W+o73c7Z0XzS3JHH/4sgQvuPIlMAhn5XCZeWoVzGSRESMUbA
        I2rd9ocAw/E/fqENN+2NNuoY3nFZIWtSFx81M4J7wjEDe8s+pIQgswis4=
Received: from xhacker (unknown [101.86.17.135])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCHj_diRCBfgxI2AA--.17695S2;
        Tue, 28 Jul 2020 23:29:40 +0800 (CST)
Date:   Tue, 28 Jul 2020 23:24:17 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: regulator: Convert mp886x to json-schema
Message-ID: <20200728232417.5272843b@xhacker>
In-Reply-To: <20200728232327.71ab3729@xhacker>
References: <20200728232327.71ab3729@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygCHj_diRCBfgxI2AA--.17695S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw18CF4xXr1kJr15Zr4Dtwb_yoW5ZFyDpF
        98CFsrCr409F1xGa1xGa4Iya15Xr1kCa4rCw1jyw1rKas8ZFn3tws0vryrZF18CrZ7JF4x
        JFZrury8tw1Iv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyYb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        W3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
        JbIYCTnIWIevJa73UjIFyTuYvjxUc_-PUUUUU
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Convert the mp886x binding to DT schema format using json-schema.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 .../devicetree/bindings/regulator/mp886x.txt  | 27 ----------
 .../bindings/regulator/mps,mp886x.yaml        | 53 +++++++++++++++++++
 2 files changed, 53 insertions(+), 27 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/mp886x.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mp886x.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mp886x.txt b/Documentation/devicetree/bindings/regulator/mp886x.txt
deleted file mode 100644
index 551867829459..000000000000
--- a/Documentation/devicetree/bindings/regulator/mp886x.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Monolithic Power Systems MP8867/MP8869 voltage regulator
-
-Required properties:
-- compatible: Must be one of the following.
-	"mps,mp8867"
-	"mps,mp8869"
-- reg: I2C slave address.
-- enable-gpios: enable gpios.
-- mps,fb-voltage-divider: An array of two integers containing the resistor
-  values R1 and R2 of the feedback voltage divider in kilo ohms.
-
-Any property defined as part of the core regulator binding, defined in
-./regulator.txt, can also be used.
-
-Example:
-
-	vcpu: regulator@62 {
-		compatible = "mps,mp8869";
-		regulator-name = "vcpu";
-		regulator-min-microvolt = <700000>;
-		regulator-max-microvolt = <850000>;
-		regulator-always-on;
-		regulator-boot-on;
-		enable-gpios = <&porta 1 GPIO_ACTIVE_LOW>;
-		mps,fb-voltage-divider = <80 240>;
-		reg = <0x62>;
-	};
diff --git a/Documentation/devicetree/bindings/regulator/mps,mp886x.yaml b/Documentation/devicetree/bindings/regulator/mps,mp886x.yaml
new file mode 100644
index 000000000000..500a7b3a59aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mps,mp886x.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mps,mp886x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Monolithic Power Systems MP8867/MP8869 voltage regulator
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - mps,mp8867
+      - mps,mp8869
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO to enable/disable the regulator.
+    maxItems: 1
+
+  mps,fb-voltage-divider:
+    description: An array of two integers containing the resistor
+      values R1 and R2 of the feedback voltage divider in kilo ohms.
+    $ref: "/schemas/types.yaml#/definitions/uint32-array"
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+  - mps,fb-voltage-divider
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        regulator@62 {
+          compatible = "mps,mp8869";
+          regulator-name = "vcpu";
+          regulator-min-microvolt = <800000>;
+          regulator-max-microvolt = <1150000>;
+          enable-gpios = <&porta 1 GPIO_ACTIVE_LOW>;
+          mps,fb-voltage-divider = <80 240>;
+          reg = <0x62>;
+        };
+    };
+
+...
-- 
2.28.0.rc0


