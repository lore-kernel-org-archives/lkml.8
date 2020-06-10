Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C53C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2986520760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FhIU6nVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgFJJIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgFJJIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:08:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261F3C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:08:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k2so604820pjs.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p1mRFejFl89lPDHG+sPS3d5EYKkxaIVplPzKnLzNtEs=;
        b=FhIU6nVzTsiUQ3FntBqklKswFB24fk9s3IpiVmY1XL/9uobHQlpn3n2xs2uW/Ly3va
         EReVFW2iYbix9LRHQsZ9Cuv2GQiLSVt6BEms8u8mNk08o/TFBRQjyBG0mMqJliofggnj
         rhDdF/A3Uj41075ZlUnv2aOXtT7JfC0HcSy00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p1mRFejFl89lPDHG+sPS3d5EYKkxaIVplPzKnLzNtEs=;
        b=TcM4q+gkKa/thr3+CdWWmro97Zv8JmY6I9OmK8pLumZrKc05jomnclEcw/Lq7ml1bn
         5ivdMGpaR2A51oCyZCCR+6nojqeNDP/k/SjGKmRRmq6sV2tYlaST12KAAF1hCUqWgnfw
         UXtD3X3B+hqNhUTvOmvd4BkdwZxRTugqbUxThQeSbUMpfpA8lKnaAS2Mz7OkQ4Mv2PqX
         b2/w6k7hjVW9q2PGE9G5PnH0jnONU+itmkyhBsfwnPD/SvXv8F2HzmizkYzZL3ZqbMRg
         SYYbXEp9hSY0ZXW64nusS8PDQYosac4Dw8hh0WjvHWhgIQ28KLuQjPNENnQ3n5uyjb2Q
         R8xA==
X-Gm-Message-State: AOAM5325OqUmYDypYqYk7wMhC/VWcBKBs+XxarzuUr/RZIiJ/fNngXGI
        y39h0EE4vqWTRMTt3ORwc9a0pA==
X-Google-Smtp-Source: ABdhPJwcMb0rNI2oofIv351QLK/VCpPE+0N6bEe87aCx3bcPVSIiwoW1kokVWknDhXfgGdfSLPy2oA==
X-Received: by 2002:a17:90a:8089:: with SMTP id c9mr2180054pjn.126.1591780081651;
        Wed, 10 Jun 2020 02:08:01 -0700 (PDT)
Received: from pihsun-glaptop.lan (180-176-97-18.dynamic.kbronet.com.tw. [180.176.97.18])
        by smtp.googlemail.com with ESMTPSA id j17sm10607644pgk.66.2020.06.10.02.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 02:08:00 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: regulator: Add DT binding for cros-ec-regulator
Date:   Wed, 10 Jun 2020 17:07:39 +0800
Message-Id: <20200610090748.45908-2-pihsun@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200610090748.45908-1-pihsun@chromium.org>
References: <20200610090748.45908-1-pihsun@chromium.org>
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
Changes from v2:
* No change

Changes from v1:
* Change compatible string to google,regulator-cros-ec.
* Use reg property in device tree.
* Change license for dt binding according to checkpatch.pl.
---
 .../bindings/regulator/cros-ec-regulator.yaml | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/cros-ec-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/cros-ec-regulator.yaml b/Documentation/devicetree/bindings/regulator/cros-ec-regulator.yaml
new file mode 100644
index 000000000000..e677614dcdf9
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/cros-ec-regulator.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/cros-ec-regulator.yaml#
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
+    const: google,regulator-cros-ec
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
+    cros-ec {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      regulator@0 {
+        compatible = "regulator-cros-ec";
+        regulator-min-microvolt = <1800000>;
+        regulator-max-microvolt = <3300000>;
+        reg = <0>;
+      };
+    };
+...
-- 
2.27.0.278.ge193c7cf3a9-goog

