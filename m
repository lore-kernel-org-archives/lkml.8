Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05040C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FB62072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="wlXWQ6ph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgC3Qpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:45:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53504 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbgC3Qpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:45:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id b12so20692604wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 09:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mVWLIOr3nu4VRkeATbgbJ5KeY5vKIQwBYj+MAP3b5JU=;
        b=wlXWQ6ph9cl7WGo45IOnoAIi3e/MSO9oLEoRA1ui6cYxiDHYf3FsXYm9gEZbPt6PzN
         YJ2XdwUIJiJf/rcVUy2rtZ9s9ehdlTf2/Y/Nte8aPxixNX4erKQLqbKHbLZrDUXSfFpe
         ceHYovcbz6AcVFNxox7oRVx/1iokPAQ4+k2uSEq3hq3IcEMnbTwHizwipjWU+Tf6omh+
         06ARQQqKCt8KkfGSuXCSokuC3w187wFjsld78q392U4Uj2HewFETdSuVawUQYigPj1qf
         PAd3edOz0rg8d8o3w62Gui1Xom/pIRAvJf2XZTXvxtHrrP41BQrEYDt5mOdytNz80yYa
         5fIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mVWLIOr3nu4VRkeATbgbJ5KeY5vKIQwBYj+MAP3b5JU=;
        b=GJPllpLZKHBUuIV0gS1JHiBsdW8UJx/kiVTZFzU0GNpOXQluhdTGcpMo8J0hWSt7JL
         +Ndc1XFjcE/OelNxAxzuyxWrD5nCtSJ/l3/fI6UJykx6yTJCiS21vny3jjNY1A69DiUt
         6VPaaK0Q5F5G6rW9BYCGgovAR4lyhTpDAv+PfavqmZQW/PBwWAGf5Z7EBG9CmRqalWXV
         VXlPCYbiSqkXNXqoOC2j7kerhwqOv9P3MixqGNTvodrm9RAeXsftJP4W/ytu+0IO84k6
         EajOdSjfBmLAekVVU0G2PUwLaOh3xeZutgFrvMfw8FM9a54fGop9pHBbuVg+IQ8y11ih
         79wQ==
X-Gm-Message-State: ANhLgQ3oD4DUSDUYYA57/YgX2KbC9wvHRkN9Gy7P+r2poakEHceqo2kc
        WbZjylhOq8QoNDwcztrEiqc3zw==
X-Google-Smtp-Source: ADFU+vuVTlTSvqv6rHsE7jknCgVQJpj+jErMpQqAWXfcsze5yFyK8CxqxzsEo3dbRwx9EYW1+2X0Yw==
X-Received: by 2002:a7b:c343:: with SMTP id l3mr214394wmj.38.1585586745976;
        Mon, 30 Mar 2020 09:45:45 -0700 (PDT)
Received: from localhost.localdomain (dh207-96-177.xnet.hr. [88.207.96.177])
        by smtp.googlemail.com with ESMTPSA id h2sm146711wmb.16.2020.03.30.09.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 09:45:45 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        John Crispin <john@phrozen.org>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH v5 2/3] dt-bindings: phy-qcom-ipq4019-usb: add binding document
Date:   Mon, 30 Mar 2020 18:43:29 +0200
Message-Id: <20200330164328.2944505-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200330164328.2944505-1-robert.marko@sartura.hr>
References: <20200330164328.2944505-1-robert.marko@sartura.hr>
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
Changes from v4 to v5:
* Replace tabs with whitespaces
* Add maintainer property

 .../bindings/phy/qcom-usb-ipq4019-phy.yaml    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml b/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
new file mode 100644
index 000000000000..4a6b5aa83925
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom-usb-ipq4019-phy.yaml
@@ -0,0 +1,48 @@
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
+    hsphy@a8000 {
+     compatible = "qcom,usb-hs-ipq4019-phy";
+     phy-cells = <0>;
+     reg = <0xa8000 0x40>;
+     resets = <&gcc USB2_HSPHY_POR_ARES>,
+       <&gcc USB2_HSPHY_S_ARES>;
+     reset-names = "por_rst", "srif_rst";
+    };
-- 
2.26.0

