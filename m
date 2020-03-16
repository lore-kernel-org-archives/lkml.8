Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B43BC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F0F20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O+/EkEaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgCPJBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:01:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46145 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730152AbgCPJA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:00:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id c19so9546971pfo.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 02:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IGTp0aw5UViZrykS90Wdmo0NeHyVyuCEPd0W8cnwwcM=;
        b=O+/EkEaRDUC3lhE2OfWN6jtHMfQFiTbtgKD8XJcQSNYQze/KmfORZPLJYJBuM+0SqD
         KmX5afZ+gt+FovYZmGAV92dQGT0hXiH6sE7AJ12wkMCrecXmqPNLGnK6sgsvzhH4JXrY
         XuLkx3z8qobUQpxhKOJo7guJTN7Nbvn2NC31Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IGTp0aw5UViZrykS90Wdmo0NeHyVyuCEPd0W8cnwwcM=;
        b=ERKQ7yvVzxvjCNY9ZNLTwtU6TBCXb17pKNqlfrQhiKc3GoIlqR3YP5i66X6iS6A06O
         5NQivWUSfRH8VLFBhbu6S0Vz5hFRF1sCUpV7uHWtUKNSxRgO12xVdhrskIIFcVEaQyOi
         H/DknIn1A2FpKHGhzRDAH0QWfEebJq3OL4zkkRdGYcXav3T0vxr+JE9i9u4mHRCxZ1hm
         NIT8sTScxM8shl4fdFDL5FWLjyhxfpJuY/w8PlokpQTpm8Fnh+ssGzTIOBZrA6K3XNgc
         v6YF/NqodAn0IMT2KhavVzaHuR2MaHxjaC3QSdcL8eaiLEloyJGAtzIR2bahdEFwDm9j
         Knrw==
X-Gm-Message-State: ANhLgQ3XHW52ex0E38Dn9zDZevvffF095y22csyiL/7e9dy5DPsKm5Sc
        eduTrUoxB5+f5hOVphYcrdAXXXw+wOw=
X-Google-Smtp-Source: ADFU+vtLPRqHTpQ6B+vPCSr2M0cfUNwrR+7iWd4BM7L0ER24RaJ7zrbl7SD7IUIJmxTp2qFccPa4PA==
X-Received: by 2002:a63:7a02:: with SMTP id v2mr25362946pgc.13.1584349253858;
        Mon, 16 Mar 2020 02:00:53 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id d3sm65040080pfn.113.2020.03.16.02.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 02:00:53 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 1/4] dt-bindings: Add cros-ec Type C port driver
Date:   Mon, 16 Mar 2020 02:00:15 -0700
Message-Id: <20200316090021.52148-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200316090021.52148-1-pmalani@chromium.org>
References: <20200316090021.52148-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Chrome OS devices with Embedded Controllers (EC) can read and
modify Type C port state.

Add an entry in the DT Bindings documentation that lists out the logical
device and describes the relevant port information, to be used by the
corresponding driver.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v5:
- Updated License identifier.
- Updated DT example to be a full example.

Changes in v4:
- Rebased on top of usb-connector.yaml, so the connector property now
  directly references the usb-connector DT binding.

 .../bindings/chrome/google,cros-ec-typec.yaml | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml

diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
new file mode 100644
index 0000000000000..6d7396ab8beec
--- /dev/null
+++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/chrome/google,cros-ec-typec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Chrome OS EC(Embedded Controller) Type C port driver.
+
+maintainers:
+  - Benson Leung <bleung@chromium.org>
+  - Prashant Malani <pmalani@chromium.org>
+
+description:
+  Chrome OS devices have an Embedded Controller(EC) which has access to
+  Type C port state. This node is intended to allow the host to read and
+  control the Type C ports. The node for this device should be under a
+  cros-ec node like google,cros-ec-spi.
+
+properties:
+  compatible:
+    const: google,cros-ec-typec
+
+  connector:
+    $ref: /schemas/connector/usb-connector.yaml#
+
+required:
+  - compatible
+
+examples:
+  - |+
+    spi0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cros_ec: ec@0 {
+        compatible = "google,cros-ec-spi";
+        reg = <0>;
+
+        typec {
+          compatible = "google,cros-ec-typec";
+
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          connector@0 {
+            compatible = "usb-c-connector";
+            reg = <0>;
+            power-role = "dual";
+            data-role = "dual";
+            try-power-role = "source";
+          };
+        };
+      };
+    };
-- 
2.25.1.481.gfbce0eb801-goog

