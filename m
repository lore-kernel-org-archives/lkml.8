Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A9AC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE36F2063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="t8g4lRjS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbgDAQvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:51:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41265 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388875AbgDAQiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:38:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so821913wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 09:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=43B7TmRxwbH0Kz6LfG5BTdU1pIGsf8HgKKgz0zV5YhQ=;
        b=t8g4lRjSFxlPhffn+KF0Ov/OJ/X7NMp1BBL1XTnFSCRAblSqCw30mm2ZCXiWToI5/u
         uQ55QeaBYfR5L8Ro9yETs+vvD2EZc4MyexeAo9U+xh4HovklHxTMo4IUQmEq9BII33W+
         JtYHbcfmo6dqCOIq42B4xFAUjDUVtSuA+walfIpUwiYy+a5rbDUxgCLqNf6Ms8IxPSFg
         7gz5vOE57n0jBIJoDROV8lC70N840KzNOxETp1MobF1bbVEDJ2Ork6pr/LsMsvsRT+OI
         ZwGZ/y9D3xDcD5hAgtc6cz+kdelAI7iLrhzMTNe7jghavldhQgy9VCOlYkRd3SdD+ffL
         DkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=43B7TmRxwbH0Kz6LfG5BTdU1pIGsf8HgKKgz0zV5YhQ=;
        b=ssHc+D1acUykmR/6eB6ipzBxtvX3hRlfXXuKTyvv37+OLm6aXpKhCc0b9BtEamaZGv
         KLMc7p57QIH7LFzsse+3eN1jWqyEtYLNst4oRs+9P8789n3T80wyJx/JCYkFcE/pYn2f
         MVAj345UAojbR/EZM3yVRAUiJd9quqodfuxpeQ6sjKUJU3KADUrhnRyXWXNbZ5OnGsa1
         0+nWRCRwqik15oJd72vtK/5NAhHxfHXEDTbUS7kaKlweXs39l1ylRsoKCPZq88GUAfpm
         LMmHFplqQubXnW2M8VHKC2pkHkYTHExrg8Rzrxts0mgLXNlyx3wUAaeFZxanfyxYyY27
         1Igw==
X-Gm-Message-State: ANhLgQ0LvEEupz/3Xgx627vh182F4Ln0GYP5uAtJOb2LMhMXvZlWvEtT
        qWH1tZbqcGnwsNY0gnU940o4/Q==
X-Google-Smtp-Source: ADFU+vsttNZ8z9NKrPfiUCeOaS/Ky/EMaV1rDxbRCMDp1ELAHbDOcyAhwSzyVU7DFhRG3mSKbgXBwg==
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr26858172wrx.228.1585759081007;
        Wed, 01 Apr 2020 09:38:01 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-209.xnet.hr. [88.207.97.209])
        by smtp.googlemail.com with ESMTPSA id t5sm3763573wrr.93.2020.04.01.09.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 09:38:00 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        John Crispin <john@phrozen.org>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH v6 2/3] dt-bindings: phy-qcom-ipq4019-usb: add binding document
Date:   Wed,  1 Apr 2020 18:35:43 +0200
Message-Id: <20200401163542.83278-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401163542.83278-1-robert.marko@sartura.hr>
References: <20200401163542.83278-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the binding documentation for the HS/SS USB PHY found
inside Qualcom Dakota SoCs.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
Changes from v5 to v6:
* Add missing include for reset defines in example
* Fix warning for missing # in #phy-cells

Changes from v4 to v5:
* Replace tabs with whitespaces
* Add maintainer property

 .../bindings/phy/qcom-usb-ipq4019-phy.yaml    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml b/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
new file mode 100644
index 000000000000..1118fe69b611
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/qcom-usb-ipq4019-phy.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcom IPQ40xx Dakota HS/SS USB PHY
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+properties:
+  compatible:
+    enum:
+      - qcom,usb-ss-ipq4019-phy
+      - qcom,usb-hs-ipq4019-phy
+
+  reg:
+    maxItems: 1
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: por_rst
+      - const: srif_rst
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - resets
+  - reset-names
+  - "#phy-cells"
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-ipq4019.h>
+
+    hsphy@a8000 {
+      #phy-cells = <0>;
+      compatible = "qcom,usb-hs-ipq4019-phy";
+      reg = <0xa8000 0x40>;
+      resets = <&gcc USB2_HSPHY_POR_ARES>,
+               <&gcc USB2_HSPHY_S_ARES>;
+      reset-names = "por_rst", "srif_rst";
+    };
-- 
2.26.0

