Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4B7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1618C2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j5cilfo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgFQOwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgFQOvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:51:53 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CFDC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:51:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 35so1054358ple.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQNrRwJqZFm26JwXJp03T56X5IKX8trjl7fZDLpzVTg=;
        b=j5cilfo02OZyPiNli2fKchLTe4cDTPoKnc6RugN2HRfcGC+a6woONHl7YkwnSJvVmW
         jGfznBcaPBTz+GX2L0FQF8hCHyIOjuCCScEsqECshm/MIEi7bKc6nk/h6NjLhzRqVgvw
         NtknhjCZYdOsh1x++jO+LchBSlXayjShKJ2a4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQNrRwJqZFm26JwXJp03T56X5IKX8trjl7fZDLpzVTg=;
        b=G+bgt3zC9wsE0jg2km7p0H1bAoT0wWVOB98c/Ty4g3mO36H/mjAPlSeeBir4qVjoJe
         ODcxvjk/2NJswgawJJsvSP8L6kZQCj10f33GY1Ulj8BZzzfjo9ZbxDwhpTKhdBDJi74d
         kPCUBtm8RrET2VaVEPfTrG3YMDQ966UE/jVEgWYqrPGRQG2ziUpIaa0AUGyenhYkxpY/
         MlPdKmOwGej5IxG/r0MjRfWoinhXA1LlcFNWr3MbDBx7OQqTPZkjNMUiMVgG3VgxT8vk
         vuwUGsIcN2MF6K2aMuyTEMxfY5Vy/FbnWrYtBi0Jyj4uYTqYXarkSQr3lc2jHZYCnB5h
         ZN2A==
X-Gm-Message-State: AOAM533Wp5jK22AXnm7xdIMsrrLPKUUtSXayNABIn0EjaHfIM8da3XCx
        oTY0pTLFzNJ0/uCzoRqlh4oQMQ==
X-Google-Smtp-Source: ABdhPJzvAKe+FEC96+3+A3FgPuJXrPvNuL6kGgmiv0tWmirzC3EusqI6ZRpN3aOnv3YcKJ5GBjDL6Q==
X-Received: by 2002:a17:902:7c96:: with SMTP id y22mr6727849pll.293.1592405512013;
        Wed, 17 Jun 2020 07:51:52 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id k18sm147040pfp.208.2020.06.17.07.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 07:51:51 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     dhavalp@codeaurora.org, mturney@codeaurora.org,
        rnayak@codeaurora.org, Ravi Kumar Bokka <rbokka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, saiprakash.ranjan@codeaurora.org,
        sparate@codeaurora.org, mkurumel@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: nvmem: qfprom: Convert to yaml
Date:   Wed, 17 Jun 2020 07:51:13 -0700
Message-Id: <20200617074930.v3.1.Iea2704ec2cb40c00eca47781c310a6330ac5dd41@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200617145116.247432-1-dianders@chromium.org>
References: <20200617145116.247432-1-dianders@chromium.org>
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
---

Changes in v3:
- Split conversion to yaml into separate patch new in v3.
- Use 'const' for compatible instead of a 1-entry enum.
- Changed filename to match compatible string.
- Add #address-cells and #size-cells to list of properties.
- Fixed up example.

 .../bindings/nvmem/qcom,qfprom.yaml           | 45 +++++++++++++++++++
 .../devicetree/bindings/nvmem/qfprom.txt      | 35 ---------------
 2 files changed, 45 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/qfprom.txt

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
new file mode 100644
index 000000000000..5efa5e7c4d81
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/qcom,qfprom.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies Inc, QFPROM Efuse bindings
+
+maintainers:
+  - Ravi Kumar Bokka <rbokka@codeaurora.org>
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
+    efuse@784000 {
+      compatible = "qcom,qfprom";
+      reg = <0 0x00784000 0 0x8ff>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+
+      hstx-trim-primary@1eb {
+        reg = <0x1eb 0x1>;
+        bits = <1 4>;
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
2.27.0.290.gba653c62da-goog

