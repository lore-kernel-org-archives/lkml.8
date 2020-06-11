Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D183FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A95292072F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a1MHK6W6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgFKIZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgFKIZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:25:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B26C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:25:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh7so2051138plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 01:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VrWixJX8R1433fFot6r+tW/CcLgNTOmGLsok7BHH+kg=;
        b=a1MHK6W6uUyOckqwulCRSQKaR6rgF8BvKNrcYhb49/DPn96bVqlS1Bl5hUvfhmxvck
         aEYkWIqXCM1GXijNrCS8g7b3coDMpVkOzlhaky8RWiOOC21upfn2pIqrifd5bUM4WwzA
         DI0JoArULFir3KSN6YKAJZIukJNd52HJAA8ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VrWixJX8R1433fFot6r+tW/CcLgNTOmGLsok7BHH+kg=;
        b=YWsRogOarXR9aa+PzofGH48vnApCIBXRAoM0v7KApFPLBVH5uDMeYCfp9RCn7DlYm2
         6mm/UnXY32AD5IQj1/PBFyWtAyZr5x9YjtQtCvpJQd1n42titDgsYds3UoqVLI+jITZ6
         JXtcq36ukq+yemp01KF7Ee9+avth078y3jszxVb2hO+GWLDOL/9vL1U0lIzL3piczPi+
         SFFKKlRC4UvImGXumv3pPQJwme8ZzRMwUnO3DQ9kAGRCerdaT8tWoO5dbyUQS/05QuEL
         6bObbJPJF5SS5Srkjhr1i9CDnZVehX7K3sZw07qhZXmHtoqGFBMYtN7n8VtPbH5BNoy/
         Wadg==
X-Gm-Message-State: AOAM532YySkLBwTUJFWns87wPRzinEPx+3g7NV8EXo9ZZHWKiSnez4Xy
        ACnbXvsvlb0qyJmc13On7eo0BA==
X-Google-Smtp-Source: ABdhPJzf4UqHA7VW0PtW9nxf8pLJre2QXYQCfOb96yU9u/GvS/OSzfTj0LFSu2FQqnYaUUO+X17i0g==
X-Received: by 2002:a17:90a:8d11:: with SMTP id c17mr6990504pjo.201.1591863957043;
        Thu, 11 Jun 2020 01:25:57 -0700 (PDT)
Received: from pihsun-glaptop.roam.corp.google.com (2001-b400-e256-fea4-a6c2-ff17-248d-0f67.emome-ip6.hinet.net. [2001:b400:e256:fea4:a6c2:ff17:248d:f67])
        by smtp.googlemail.com with ESMTPSA id m5sm1994749pga.3.2020.06.11.01.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 01:25:56 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org (open list:VOLTAGE AND CURRENT REGULATOR
        FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v5 1/2] dt-bindings: regulator: Add DT binding for cros-ec-regulator
Date:   Thu, 11 Jun 2020 16:25:36 +0800
Message-Id: <20200611082542.219516-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200611082542.219516-1-pihsun@chromium.org>
References: <20200611082542.219516-1-pihsun@chromium.org>
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
---
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
2.27.0.278.ge193c7cf3a9-goog

