Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AE5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFC120786
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="Nu/KqMNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgG2FNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 01:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgG2FNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 01:13:48 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6116CC061794;
        Tue, 28 Jul 2020 22:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=cI8zJ0kgdAavF433Hh2Q0e3YeJeTp07jxV
        dG/6y8OhA=; b=Nu/KqMNOEom3hpPtYcYpphvIo2Cqn+MaB/dLAa5AegiagN4rAs
        kO28ENWmxznjcZ5aUEW/gMil+6Ld9NvaXAwLWwQ8DYEgS40TDzjv6BD7XG+9DK1/
        MwYzDyWyxBB5grYLBZnvPagUWFejYSHc1yJviuJJdbDSZSdsPapWQj9Bk=
Received: from xhacker (unknown [101.86.17.135])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygCXjUCFBSFfwOg9AA--.30602S4;
        Wed, 29 Jul 2020 13:13:44 +0800 (CST)
Date:   Wed, 29 Jul 2020 13:10:52 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 4/4] dt-bindings: regulator: Convert mp886x to
 json-schema
Message-ID: <20200729131052.39e40311@xhacker>
In-Reply-To: <20200729130839.10a9bf88@xhacker>
References: <20200729130839.10a9bf88@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygCXjUCFBSFfwOg9AA--.30602S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZw18CF4xXr1kJF4Utr1xuFg_yoW5KF4kpF
        Z8CFsrCr409F1xGa1xG34Ika15Xr1kCa4rCw1jyw1rKas8AF93trs0vryFvF18CrZ7JF47
        tFZrury8t3WIv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9jb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
        64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY
        1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
        xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
        FVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
        AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
        17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
        IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
        C2KfnxnUUI43ZEXa7IU0OVy3UUUUU==
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Convert the mp886x binding to DT schema format using json-schema.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 .../devicetree/bindings/regulator/mp886x.txt  | 31 ----------
 .../bindings/regulator/mps,mp886x.yaml        | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/mp886x.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mp886x.yaml

diff --git a/Documentation/devicetree/bindings/regulator/mp886x.txt b/Documentation/devicetree/bindings/regulator/mp886x.txt
deleted file mode 100644
index e747000cebba..000000000000
--- a/Documentation/devicetree/bindings/regulator/mp886x.txt
+++ /dev/null
@@ -1,31 +0,0 @@
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
-Optional properties:
-- mps,switch-frequency: The valid switch frequency in Hertz. Available values
-  are: 500000, 750000, 1000000, 1250000, 1500000
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
index 000000000000..991f2de7eda8
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mps,mp886x.yaml
@@ -0,0 +1,58 @@
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
+  mps,switch-frequency:
+    description: The valid switch frequency in Hertz.
+    enum: [500000, 750000, 1000000, 1250000, 1500000]
+    $ref: "/schemas/types.yaml#/definitions/uint32"
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
2.28.0.rc1


