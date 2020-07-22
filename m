Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB20C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD914206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQndCQjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbgGVKI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731951AbgGVKIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:08:24 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072E6C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c80so1397033wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uGHjmL78xvZIJz6OG/invG6MWZVVGuSqNB1aBqUNcyQ=;
        b=iQndCQjZM1UzNasxrkSkMyWJuTg0Jw/tz8bhdkbykHPY28ToyCgX8VCDAKHcdJUjrg
         ZVN65NTQw3tV8i8iajPSEfHHsQg1IWlaghHMGZeI8IAtn4QxMpV5lztYaidTrepqlFCY
         /I4CZsoau3UE/qYqbtgOFPWVZ6OBtU7MLfDtAqID706Lj9cV95zzDNLcSUbHAfye0eXa
         q2V4XQQdanpq9RSfBmBEuaum53xnR0rFH4j3rQ6mcYkXSTI4CGFwl8qmW4L8Jsdhz/4p
         epxLTdAZRdJQNYAmVgRnyPSSHQmiq/0QqvozsPwNaSpwnN9e3JIBh8c9O3UcKk9UD6UP
         W4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uGHjmL78xvZIJz6OG/invG6MWZVVGuSqNB1aBqUNcyQ=;
        b=DuTJk8MzYj3NC9h2iSigarqJCq9/mzjClOXZ5/VkpZIUcLJ5g+WmEAjucdYxZfnaKf
         nGWrzcO4gPtGzocBywJdeGq68+YdxcwsuhdA2vvFZvJI1usuohxkd+y/QkrNjqiV0jnu
         Dg1W4HlNzSVtnJrzYZwatWJ1Gr69cgp5AlVuh3Tn+acWE/R54TPTczJ68L5oXpkCmuLh
         n11VYJPYK276Y68TUnW6rplNcGB8F3hgTmMzuQ23Yq2gZz/vMH0SthXZAdDAVHLzPuzU
         Hxvka1O4ZCFRoKGI4aKqq8zJww+hBmBt7074uhOoV9A0qDv3SpOtQS+BbAa+XJj/6LpF
         5cJg==
X-Gm-Message-State: AOAM530uGiTgS2tIS1sJUVm1e3ugfSayB/gHrRqncNVad1mDb3qjdtkZ
        Ku3ECtlZfzzcbG1HY+DvaHDB3Q==
X-Google-Smtp-Source: ABdhPJxue4SgVAqGd6aSykrAYsc5VyYHjD6mZBd79aqf2kA8sX7BxOAPEtW8rMD4jMckanuPOTrGXg==
X-Received: by 2002:a7b:c257:: with SMTP id b23mr1702526wmj.164.1595412501405;
        Wed, 22 Jul 2020 03:08:21 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t13sm17098623wru.65.2020.07.22.03.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:08:20 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 10/14] dt-bindings: nvmem: Add properties needed for blowing fuses
Date:   Wed, 22 Jul 2020 11:07:01 +0100
Message-Id: <20200722100705.7772-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
References: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Kumar Bokka <rbokka@codeaurora.org>

On some systems it's possible to actually blow the fuses in the qfprom
from the kernel.  Add properties to support that.

NOTE: Whether this is possible depends on the BIOS settings and
whether the kernel has permissions here, so not all boards will be
able to blow fuses in the kernel.

Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/qcom,qfprom.yaml           | 50 ++++++++++++++++++-
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 39f97c1c83a4..d10a0cf91ba7 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -17,8 +17,27 @@ properties:
     const: qcom,qfprom
 
   reg:
-    items:
-      - description: The corrected region.
+    # If the QFPROM is read-only OS image then only the corrected region
+    # needs to be provided.  If the QFPROM is writable then all 4 regions
+    # must be provided.
+    oneOf:
+      - items:
+          - description: The corrected region.
+      - items:
+          - description: The corrected region.
+          - description: The raw region.
+          - description: The config region.
+          - description: The security control region.
+
+  # Clock must be provided if QFPROM is writable from the OS image.
+  clocks:
+    maxItems: 1
+  clock-names:
+    const: core
+
+  # Supply reference must be provided if QFPROM is writable from the OS image.
+  vcc-supply:
+    description: Our power supply.
 
   # Needed if any child nodes are present.
   "#address-cells":
@@ -31,6 +50,33 @@ required:
    - reg
 
 examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc7180.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      efuse@784000 {
+        compatible = "qcom,qfprom";
+        reg = <0 0x00784000 0 0x8ff>,
+              <0 0x00780000 0 0x7a0>,
+              <0 0x00782000 0 0x100>,
+              <0 0x00786000 0 0x1fff>;
+        clocks = <&gcc GCC_SEC_CTRL_CLK_SRC>;
+        clock-names = "core";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        vcc-supply = <&vreg_l11a_1p8>;
+
+        hstx-trim-primary@25b {
+          reg = <0x25b 0x1>;
+          bits = <1 3>;
+        };
+      };
+    };
+
   - |
     soc {
       #address-cells = <2>;
-- 
2.21.0

