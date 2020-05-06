Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDABC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC13B2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+Efog31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgEFVKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 17:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729614AbgEFVKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:10:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3079AC061A0F;
        Wed,  6 May 2020 14:10:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id x25so4079164wmc.0;
        Wed, 06 May 2020 14:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uMNrkV2+34A5tU5bw9M2aiiNB9ppVQmACDjtc/0mJbI=;
        b=n+Efog31QV6ez/KjorI5h7hOkEwrYGV/Z4y6Xn6a6an0AVGpBvY+WBuIMwNG4AmGUV
         WOmBf0421+EEyuQXTlP+/alLSTU/ZnAwrU3zsyBuUxia17seA5y6xEY9290kLA+F32nH
         gGdwVr6WR3lpDlE4S9W0QFwk3fd5ueVZ3KIUwkhDpFy1wss91Tl8Mme0w8PZPYS0JU/+
         tjlvmjhyvEEMGSbvDh8U/FGj/4corc/JW8yJ+7zu/oGZMow+9w/7+3mMdYQkkRRVVNJf
         dQfrnm71ONxvh6bcGyPePETn2cDWhWcTxjHhBN4/iRLACBBaRH5m4BRR5JbMiU2/d+vx
         PMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uMNrkV2+34A5tU5bw9M2aiiNB9ppVQmACDjtc/0mJbI=;
        b=XmKlF0mNN3yEtJTIkBQfEBOzL+NCybvX/xKeKkzUA98V8r0Sw4Mrwi0qaGxpF8vuXy
         uE2vIIF2bpy+UKvydsx640RxuYUvmO2VCCqL6Gcs5ifv6ytJsHhr5bOT66LU+Ge4AeZL
         f+djFShw2VZoETvXEnnp03x1bvo6PqPkxlPlckJ6k1r3qGi8JT9qxj3RuxXpnfZjvZFa
         nVn3MqaqWgArHH/Q3Cj/r5QbJI1ezfaUlZSOQSDtkYcUcwWhpTXdtu8uuXfuI4EiWNKJ
         TW5IEJpG5MYaYCsbT91NRG08dPa2jP+0RheAOWKbq25g/NABMx3ZAoNJB27Qir2j1MP0
         vS7g==
X-Gm-Message-State: AGi0PuaA9p4aI2bu1SUAsexFwPLKpVPAp8R5JobuFGTR9XQwEV/YOK/u
        rg5zWItqtJi8575+3yU8lIyI3pJdKUU=
X-Google-Smtp-Source: APiQypL4m7E2xC6OA9pFcUttY9Vf1hjVi1QM/2nX2qkMTl0FqSgkCHyIQtUOthcYMrM+4gOMI+7RAg==
X-Received: by 2002:a1c:790e:: with SMTP id l14mr6297060wme.174.1588799410947;
        Wed, 06 May 2020 14:10:10 -0700 (PDT)
Received: from localhost.localdomain (abag125.neoplus.adsl.tpnet.pl. [83.6.170.125])
        by smtp.googlemail.com with ESMTPSA id b191sm5135056wmd.39.2020.05.06.14.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 14:10:10 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v4 PATCH 2/2] dt-bindings: display: Document ASUS Z00T TM5P5 NT35596 panel compatible
Date:   Wed,  6 May 2020 23:09:56 +0200
Message-Id: <20200506210957.344590-3-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506210957.344590-1-konradybcio@gmail.com>
References: <20200506210957.344590-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 .../panel/asus,z00t-tm5p5-nt35596.yaml        | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml b/Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml
new file mode 100644
index 0000000000000..083d2b9d0c69a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-nt35596.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/asus,z00t-tm5p5-nt35596.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASUS Z00T TM5P5 NT35596 5.5" 1080×1920 LCD Panel
+
+maintainers:
+  - Konrad Dybcio <konradybcio@gmail.com>
+
+description: |+
+  This panel seems to only be found in the Asus Z00T
+  smartphone and we have no straightforward way of
+  actually getting the correct model number,
+  as no schematics are released publicly.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: asus,z00t-tm5p5-n35596
+  reg: true
+  reset-gpios: true
+  vdd-supply:
+     description: core voltage supply
+  vddio-supply:
+     description: vddio supply
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            panel@0 {
+                    reg = <0>;
+
+                    compatible = "asus,z00t-tm5p5-n35596";
+
+                    vdd-supply = <&pm8916_l8>;
+                    vddio-supply = <&pm8916_l6>;
+                    reset-gpios = <&msmgpio 25 GPIO_ACTIVE_HIGH>;
+            };
+    };
-- 
2.26.2

