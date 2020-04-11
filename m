Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C553AC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C30206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVKtwmuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgDKMZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:25:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42914 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728546AbgDKMZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:25:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id j2so5044807wrs.9;
        Sat, 11 Apr 2020 05:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PXnvbLdLrQw02Pv9aTraJTstO6BsBfshSbSvruk1AoI=;
        b=eVKtwmuP9eIdsk0DhszqFM/hq7WkqRqir5lOWmDDJZ+lZVcGXyuUuO/jOnjM8mDYM+
         SFYkcV9yi9yuUYTPhE2MftExFAECb2nT5xyY8TKHr7yD9lTPMjb9SlFwUnejhZ62EscA
         toWiRpCF6/OhwypaUSnWTJ+yLZk/kyKeRmg5ztC4/axZrd8Yhmid80PA+dDCmM3agaDM
         QTk01KBvlhT/6u15/u6/GDqWSNwWBAOGMk+R7SUs/3Ezir6yzC354SZFHsS16HbXG9e9
         X76vq9XIbqCmrPwdVP+Esd3xTNJDcxCkSGKb8ZJuVinoBP/X0GXyPmhZiWyRSzOEZV4o
         YBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PXnvbLdLrQw02Pv9aTraJTstO6BsBfshSbSvruk1AoI=;
        b=CKMxZZ8INH5cNMiLVd3BZoWJYR9UrKOOvSxTH3ycu5Zum8P5R5MiF5ihKmIOkY5w4r
         SZ+se6taE+qRyNRdFyr3YPemHAn5ZQ3sS28in1d9GPBlIpS9cjtazo7YPbofm0edFnfO
         b80wgC28iJQjJdawHgpwBp2V/aa2/5udqUuROboiUa1im9+tNMDrau0RZC7XdDTKbw2g
         vSe5m1nE5KZW6a2WjwJltcjwtIRHunwamGttzh9Z/GqYiJrc9W26SLR5MkKjfMP7c3le
         eTgcZL8TMk4OjvHshXFUI4zi/57eDTzjJBvHQLIYRCcGirRmh9eRG7xxAJdLn8afPGl7
         xing==
X-Gm-Message-State: AGi0PuaYs3/5g8+kaPzRueDdLx5eAo5si93JwyyeCmsUH2SxA/p7pDo7
        51wtV/isFmurCsN1YO5PHXGZ4cVf
X-Google-Smtp-Source: APiQypIdubht9dZYotoZNNgJZ0IsRf27uQmOuX3WrqdShZOIC5TejYPydYZrpUauBMUEpVWmYHWhbA==
X-Received: by 2002:adf:f9cc:: with SMTP id w12mr9762920wrr.148.1586607914276;
        Sat, 11 Apr 2020 05:25:14 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v19sm675565wra.57.2020.04.11.05.25.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Apr 2020 05:25:13 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] dt-bindings: sram: convert rockchip-pmu-sram bindings to yaml
Date:   Sat, 11 Apr 2020 14:25:07 +0200
Message-Id: <20200411122507.4040-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'rockchip-pmu-sram' compatible nodes
are now verified with sram.yaml, although the original
text document still exists. Merge rockchip-pmu-sram.txt
with sram.yaml by adding it as description with an example.
Make #address-cells, #size-cells and ranges optional
if there are no child nodes to prevent yaml warnings.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changes v4:
  Make some properties optional

Changes v3:
  Document the compatible

Changed v2:
  Merge with sram.yaml
---
 .../devicetree/bindings/sram/rockchip-pmu-sram.txt | 16 -------------
 Documentation/devicetree/bindings/sram/sram.yaml   | 26 +++++++++++++++++++---
 2 files changed, 23 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt

diff --git a/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt b/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
deleted file mode 100644
index 6b42fda30..000000000
--- a/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Rockchip SRAM for pmu:
-------------------------------
-
-The sram of pmu is used to store the function of resume from maskrom(the 1st
-level loader). This is a common use of the "pmu-sram" because it keeps power
-even in low power states in the system.
-
-Required node properties:
-- compatible : should be "rockchip,rk3288-pmu-sram"
-- reg : physical base address and the size of the registers window
-
-Example:
-	sram@ff720000 {
-		compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
-		reg = <0xff720000 0x1000>;
-	};
diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 7b83cc6c9..f474fee47 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -29,6 +29,7 @@ properties:
       enum:
         - mmio-sram
         - atmel,sama5d2-securam
+        - rockchip,rk3288-pmu-sram
 
   reg:
     maxItems: 1
@@ -118,9 +119,18 @@ patternProperties:
 required:
   - compatible
   - reg
-  - "#address-cells"
-  - "#size-cells"
-  - ranges
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: rockchip,rk3288-pmu-sram
+
+else:
+  required:
+    - "#address-cells"
+    - "#size-cells"
+    - ranges
 
 additionalProperties: false
 
@@ -224,6 +234,16 @@ examples:
     };
 
   - |
+    // Rockchip's rk3288 SoC uses the sram of pmu to store the function of
+    // resume from maskrom(the 1st level loader). This is a common use of
+    // the "pmu-sram" because it keeps power even in low power states
+    // in the system.
+    sram@ff720000 {
+      compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
+      reg = <0xff720000 0x1000>;
+    };
+
+  - |
     // Allwinner's A80 SoC uses part of the secure sram for hotplugging of the
     // primary core (cpu0). Once the core gets powered up it checks if a magic
     // value is set at a specific location. If it is then the BROM will jump
-- 
2.11.0

