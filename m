Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F57C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 04:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 849BB2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 04:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.b="tz0HO/Ks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgG2E4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 00:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgG2E4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 00:56:15 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99689C061794;
        Tue, 28 Jul 2020 21:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=ttg92uVxgoQx/AYcNi/PXgIVq6G62scVk177LNjUw2o=; b=tz0HO/Ks4LDom
        rSMivIq8HYktceERH3/DXDeBHhtGmVgRL+A64b+Kqs5onyluJtAzmLgmb9EQx0P3
        vGXm87hpPAO3uFta8B3/bDmhCXDXA90aVr2+/kXs/18ITtk6WJJy8zQUcFjv3W/4
        4/2nDkTDVd8f+CPeMc/9sA8vtfVYJA=
Received: from xhacker (unknown [101.86.17.135])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygDn71NnASFfE749AA--.30383S2;
        Wed, 29 Jul 2020 12:56:08 +0800 (CST)
Date:   Wed, 29 Jul 2020 12:53:20 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: regulator: Convert sy8824x to json-schema
Message-ID: <20200729125320.5521ed23@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygDn71NnASFfE749AA--.30383S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw15tFyDJr1UAF1DGFW7Jwb_yoW5XrWfpr
        Z5CFnrWF40kF97Wa1fG3WfJa15Zr1kAa40yr1kGw1SkFyDJF95trWYkr15Z3W8JFWxuFWI
        vFWDuryfta48X3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyYb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
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

Convert the sy8824x binding to DT schema format using json-schema.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---

Since v1
  -It seems there's something wrong with my last email, so send out a v2 with
   another email account

 .../bindings/regulator/silergy,sy8824x.yaml   | 40 +++++++++++++++++++
 .../devicetree/bindings/regulator/sy8824x.txt | 24 -----------
 2 files changed, 40 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/sy8824x.txt

diff --git a/Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml b/Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml
new file mode 100644
index 000000000000..62a476c94111
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/silergy,sy8824x.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/silergy,sy8824x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: silergy sy8824c,sy8824e,sy20276 and sy20278 PMIC
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - silergy,sy8824c
+      - silergy,sy8824e
+      - silergy,sy20276
+      - silergy,sy20278
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        regulator@60 {
+          compatible = "silergy,sy8824c";
+          regulator-min-microvolt = <800000>;
+          regulator-max-microvolt = <1150000>;
+          reg = <0x60>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/regulator/sy8824x.txt b/Documentation/devicetree/bindings/regulator/sy8824x.txt
deleted file mode 100644
index c5e95850c427..000000000000
--- a/Documentation/devicetree/bindings/regulator/sy8824x.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-SY8824C/SY8824E/SY20276 Voltage regulator
-
-Required properties:
-- compatible: Must be one of the following.
-	"silergy,sy8824c"
-	"silergy,sy8824e"
-	"silergy,sy20276"
-	"silergy,sy20278"
-- reg: I2C slave address
-
-Any property defined as part of the core regulator binding, defined in
-./regulator.txt, can also be used.
-
-Example:
-
-	vcore: regulator@00 {
-		compatible = "silergy,sy8824c";
-		reg = <0x66>;
-		regulator-name = "vcore";
-		regulator-min-microvolt = <800000>;
-		regulator-max-microvolt = <1150000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-- 
2.28.0.rc0


