Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FABC433EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E4D1206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1QakWMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbgGVKIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbgGVKIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:08:21 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32A5C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:21 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f2so1305753wrp.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=clTx2oXPdNPvTJEV+4jvWk/yKNERwxIHyBWecVb2lTg=;
        b=M1QakWMpg23s+4cm6m+Db/tG03cOfdQxD7EV7N0lbq/uxZhBw3IB3Lha6F2u2fPQci
         TPc3EUbO9yfAd2++Z1acbQe4jfEjggi38UwHm2xPh//B3lQjHgxsYy/1evdrukIBErkz
         +H+GNEnETEMuq8En+kexcymtJzjFtIzAt1/n7/ItQCLd+qgikcl93mt7eEW0dChOMrnL
         dyvVP20PwerLa1EBzBi9voufmSL8suqV9ykoD+ft5Gv/fCCTNyu2NBcK7nClU71l/a6B
         dQ3MYsfE7DXtMZ1BGPYdvt5AdhlO8M9whzaUukhVnvexUNJbWhHfqixFSeYuO5udugqg
         xofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=clTx2oXPdNPvTJEV+4jvWk/yKNERwxIHyBWecVb2lTg=;
        b=i4CRA/PGNEP0CZ01GDbgl9WeM/9cOgLbAADwqTiqP1h5KYNqgxccgk5sW0mwH4TH/4
         KuufXmN/OyAYyifyidJWiD3GE4j/q+YRH09zgkZEFaaMwy5NPTNKC0Oe+rbhd7sstK3L
         g4gc2isl2AFMR0g4v+mlW2kYMrBBpOh8eJRfS9j56Iv+fpIHRK+qQCQ2M1WJ6DiKPD60
         dbjvymzoxXRRUOEYeiFMPNtPKNp8OEy2VeNxlEvYIXcueSCHbj6bCxCgYe8xfy1ueLAy
         ipLoS8uZMnjztKC6fLerPykJKPIBveKKD+5w9L0RdPr7IoEHl4a/RJUVO412vd1xN6BX
         EkVw==
X-Gm-Message-State: AOAM532tjT7AqExbPBSWT8b1VrTI9cVtx7r7BZj2ezzRxeMX5JRu826W
        Yr0PwO6CHFRiGsPhDrxcTM3LfsYO8Vc=
X-Google-Smtp-Source: ABdhPJzaWyVYipEo60Hf4slcAp44sIFcL4cguXlLadKz3NeRNM/VAIzSdIREf/57MQyRUaescYYF1w==
X-Received: by 2002:a5d:62cd:: with SMTP id o13mr29870230wrv.272.1595412500332;
        Wed, 22 Jul 2020 03:08:20 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t13sm17098623wru.65.2020.07.22.03.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:08:19 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/14] dt-bindings: nvmem: qfprom: Convert to yaml
Date:   Wed, 22 Jul 2020 11:07:00 +0100
Message-Id: <20200722100705.7772-10-srinivas.kandagatla@linaro.org>
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

This switches the bindings over from txt to yaml.

Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/qcom,qfprom.yaml           | 50 +++++++++++++++++++
 .../devicetree/bindings/nvmem/qfprom.txt      | 35 -------------
 2 files changed, 50 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/qfprom.txt

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
new file mode 100644
index 000000000000..39f97c1c83a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/qcom,qfprom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies Inc, QFPROM Efuse bindings
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    const: qcom,qfprom
+
+  reg:
+    items:
+      - description: The corrected region.
+
+  # Needed if any child nodes are present.
+  "#address-cells":
+    const: 1
+  "#size-cells":
+    const: 1
+
+required:
+   - compatible
+   - reg
+
+examples:
+  - |
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      efuse@784000 {
+        compatible = "qcom,qfprom";
+        reg = <0 0x00784000 0 0x8ff>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        hstx-trim-primary@1eb {
+          reg = <0x1eb 0x1>;
+          bits = <1 4>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/qfprom.txt b/Documentation/devicetree/bindings/nvmem/qfprom.txt
deleted file mode 100644
index 26fe878d5c86..000000000000
--- a/Documentation/devicetree/bindings/nvmem/qfprom.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-= Qualcomm QFPROM device tree bindings =
-
-This binding is intended to represent QFPROM which is found in most QCOM SOCs.
-
-Required properties:
-- compatible: should be "qcom,qfprom"
-- reg: Should contain registers location and length
-
-= Data cells =
-Are child nodes of qfprom, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
-Example:
-
-	qfprom: qfprom@700000 {
-		compatible 	= "qcom,qfprom";
-		reg		= <0x00700000 0x8000>;
-		...
-		/* Data cells */
-		tsens_calibration: calib@404 {
-			reg = <0x4404 0x10>;
-		};
-	};
-
-
-= Data consumers =
-Are device nodes which consume nvmem data cells.
-
-For example:
-
-	tsens {
-		...
-		nvmem-cells = <&tsens_calibration>;
-		nvmem-cell-names = "calibration";
-	};
-- 
2.21.0

