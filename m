Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED13FC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5710206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="noE6rzjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgFVOt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbgFVOtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:49:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76572C061797
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:49:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h10so8235373pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qfe9MWBMEBHsI86sPJ1/VzBuaNsbA6yh79jl7tZLGVc=;
        b=noE6rzjAHbCSxC7tX8HlKVHCb0CEFAczx2ArscLI20zq8bkQQhUlBfy+FIQsPwrR7x
         cvDYnY4V8vBIIR2oBf78JYpUctOIblm3YMTHupTCfVe3mRrythS+AXhyTSqSI825/MJS
         vWz4QdfQznJEJAuuCMv/kKNqX61PkjcUmooxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qfe9MWBMEBHsI86sPJ1/VzBuaNsbA6yh79jl7tZLGVc=;
        b=Ku4mJzO/1epsDC3TTDXt+owyL/3p7qOx7FWYBcNWI5uT0d96D/01GkFgc0nKg/miiE
         yVs2Q4m3akImYpBBkPWp2SB4vEX2+XTm+iClOhZgp+6EoUijTtq8l6Wbw0n/2GA+WNbe
         fWB3FqZ4SSgLq14P+LVBFFWaNnURvNDszo2mVTucxx4ymCwBJ4ZCqC9kbwjVrAH7mNuz
         3gukBukbSxUBJV9SwOiOM1DnCvVBk7cz2qMxnhO56WCYC2WJXPVAwuk48EP83vbZQRhs
         oc431/sumfpsthm5c/Qxc02mP+SOCD5ui/YBphH0w4rM67G8Nyu45kRCWJxk1fYQvdDG
         Ibmw==
X-Gm-Message-State: AOAM533oKdXZvfv5HQzapyDOMNZlZzU1riDk4Itlb/QxPmj6k1RivFz0
        nsrI3ldgY7yqze7+hQA9UY5TVg==
X-Google-Smtp-Source: ABdhPJyh7QQHMOpk1qFYqdtZsboRjcCG3J3dsWm073sUl83fa/Ubi9W1EB3RScpX3lgCm/Nz5Mhoaw==
X-Received: by 2002:aa7:95bd:: with SMTP id a29mr20613411pfk.57.1592837391001;
        Mon, 22 Jun 2020 07:49:51 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id 77sm13903018pfu.139.2020.06.22.07.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 07:49:50 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     mturney@codeaurora.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        rnayak@codeaurora.org, dhavalp@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, sparate@codeaurora.org,
        linux-arm-msm@vger.kernel.org, mkurumel@codeaurora.org,
        Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] dt-bindings: nvmem: Add properties needed for blowing fuses
Date:   Mon, 22 Jun 2020 07:49:27 -0700
Message-Id: <20200622074845.v4.2.I3b5c3bfaf5fb2d28d63f1b5ee92980900e3f8251@changeid>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200622144929.230498-1-dianders@chromium.org>
References: <20200622144929.230498-1-dianders@chromium.org>
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
---

Changes in v4:
- Clock name is "core", not "sec".
- Example under "soc" to get #address-cells and #size-cells.

Changes in v3:
- Add an extra reg range (at 0x6000 offset for SoCs checked)
- Define two options for reg: 1 item or 4 items.
- No reg-names.
- Add "clocks" and "clock-names" to list of properties.
- Clock is now "sec", not "secclk".
- Add "vcc-supply" to list of properties.
- Fixed up example.

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
2.27.0.111.gc72c7da667-goog

