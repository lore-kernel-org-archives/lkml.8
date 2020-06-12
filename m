Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF41C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 04:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D2920792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 04:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mQ9C4Aw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgFLEFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 00:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgFLEFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 00:05:38 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3437CC03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 21:05:38 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id b5so2569424pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 21:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iNfpgONIX6TRQlY7VCVFuaZAaeCFmiBcxeh3q+Q9Emc=;
        b=mQ9C4Aw7UnLy8MGjbM2OH+sYJjoMshBz0UObVOleGhuXtYJKLHLkDe4CS64GHsAzzf
         qFBNAYjYV108HaXThdR2E1c1lUCTsjwairMoiRkIKp4PnaLs2fRPuGdM97LHIBX+jQi/
         PPQi1BwP8ENk3T37NSGb4nw6ZIrVVN3ZcpVJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iNfpgONIX6TRQlY7VCVFuaZAaeCFmiBcxeh3q+Q9Emc=;
        b=fXfLLkPidD41i7uB6qNKIVK4GAK+Y79EBcvhEj3h0pKT9Gc9nZaxk/JiOsVnNs5E9A
         Pz+iWsMmXZpHEg4dlEgFmqM/51KDdqdO+DHy3JtfLtOswCd3o1E88mrp79yLxkP6NRw+
         7ppeOYNMlZwgyHbz1hDhA1E3lb6tNHwKwYOMLa1EULeTk8rKNjU9v5RJO96/2zwCHRGl
         CxVBNp9bNeclNY6hooOQ4xClvNAwVrnMfQwwghTgKsf6y56i5UAb016x0eGbTz0NU+Ys
         8yOhiJXthRWI0mQiYiHWagfThPmkmr5kW/oqKlo/t01Bloo+/pk4oYqGYrFGc2iCRvk0
         lIvw==
X-Gm-Message-State: AOAM530m/J6FjbWcprA/EDUVS3H3bh66IYjB6MFdj/Bqg4i5x314AJgO
        t943/A6dbZI5jFrZ3hbX1kd9Kw==
X-Google-Smtp-Source: ABdhPJxxsRu3FD1Od7Fa7yYEkFAdUaJPbFEkxFnnoj3uFGxKNpxdBkkwp6nH80ZLBRxpPBPTYKEp0w==
X-Received: by 2002:a65:508c:: with SMTP id r12mr9391678pgp.233.1591934737734;
        Thu, 11 Jun 2020 21:05:37 -0700 (PDT)
Received: from pihsun-glaptop.lan (180-176-97-18.dynamic.kbronet.com.tw. [180.176.97.18])
        by smtp.googlemail.com with ESMTPSA id u7sm4686983pfu.162.2020.06.11.21.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 21:05:36 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR
        FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v6 1/3] dt-bindings: regulator: Add DT binding for cros-ec-regulator
Date:   Fri, 12 Jun 2020 12:05:18 +0800
Message-Id: <20200612040526.192878-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200612040526.192878-1-pihsun@chromium.org>
References: <20200612040526.192878-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for cros-ec-regulator, a voltage regulator
controlled by ChromeOS EC.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Changes from v5:
* No change

Changes from v4:
* Change compatible name from regulator-cros-ec to cros-ec-regulator.

Changes from v3:
* Fix dt bindings file name.
* Add full example.

Changes from v2:
* No change

Changes from v1:
* Change compatible string to google,regulator-cros-ec.
* Use reg property in device tree.
* Change license for dt binding according to checkpatch.pl.
---
 .../regulator/google,cros-ec-regulator.yaml   | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml b/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml
new file mode 100644
index 000000000000..c9453d7ce227
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/google,cros-ec-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ChromeOS EC controlled voltage regulators
+
+maintainers:
+  - Pi-Hsun Shih <pihsun@chromium.org>
+
+description:
+  Any property defined as part of the core regulator binding, defined in
+  regulator.yaml, can also be used.
+
+allOf:
+  - $ref: "regulator.yaml#"
+
+properties:
+  compatible:
+    const: google,cros-ec-regulator
+
+  reg:
+    maxItems: 1
+    description: Identifier for the voltage regulator to ChromeOS EC.
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cros_ec: ec@0 {
+            compatible = "google,cros-ec-spi";
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            regulator@0 {
+                compatible = "google,cros-ec-regulator";
+                regulator-min-microvolt = <1800000>;
+                regulator-max-microvolt = <3300000>;
+                reg = <0>;
+            };
+        };
+    };
+...
-- 
2.27.0.290.gba653c62da-goog

