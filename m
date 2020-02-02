Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37799C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 04:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6522082E
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 04:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ILJVF5P9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgBBEjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 23:39:53 -0500
Received: from mail-pj1-f54.google.com ([209.85.216.54]:53713 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgBBEjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 23:39:53 -0500
Received: by mail-pj1-f54.google.com with SMTP id n96so4769964pjc.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 20:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d2Ia3DkAO43aComdEVaT18sYNG+CL/EC8bmSWjIf8dQ=;
        b=ILJVF5P94QMLDCHQ7mljRNHgji5xkNvmNP5X3RUsIMBFytffOpRPDR76CcEk/sGBOw
         XpGRuHqapqYjUqweniIlKlBH7Cg/sx6IG/IH7lEZWqWkC1GMmAaFC8Zuc38wrxi6Vxjh
         mx8RaYkzHEjoHwJM0yem9uhfM0tLenJ6M38Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d2Ia3DkAO43aComdEVaT18sYNG+CL/EC8bmSWjIf8dQ=;
        b=OXyDyGjUuPf+pEde9qZa/heG0rz6uQxqMOmbWagiziD1Nurgy+LpYGJU6HrBgqZna3
         vhZil6MJzyKFMoAdb3Ouw/SG77K+Y9wnE6H80eDmrB7S33+JlnpihqQZRz7/SrdiIRTV
         NNuryL44eYIG6uay6uPsRYbE1Fk+frv3pJ3R8B+8DbHYN0C+bVAnyG3zkvbxxzJjv+FJ
         xFYAvlL8U2uRr4oLDF/drnxfUskZKASMLRhk2h7AfpqxTukz4fL3AzVCb0mAEaJMhNXN
         vKWal7ZCpDrGN5SHOde3MiFkVqFYiyUare7Hs2ri/Wem7luxE1hEG/DPlKEGHtzRXiks
         Nbdg==
X-Gm-Message-State: APjAAAWXSGeNLfOfxXiJwS/GnKG5DBk2UZ4hM2BUngpyFXoWKxUujqii
        zCjscmkdJn8P7Ty5nOqEp5EUUw==
X-Google-Smtp-Source: APXvYqwoOY5XcIFk02jMBOYatkuYTxzbNHGKPGAPbPhX9vY2JqY1v3xm4Nr1kLOYIeGBdjMrunggDg==
X-Received: by 2002:a17:90a:d104:: with SMTP id l4mr22157849pju.60.1580618391773;
        Sat, 01 Feb 2020 20:39:51 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u11sm14526328pgh.60.2020.02.01.20.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 20:39:51 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2] dt-bindings: tpm: Convert cr50 binding to YAML
Date:   Sat,  1 Feb 2020 20:39:49 -0800
Message-Id: <20200202043949.213427-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to validate the dt binding to the implementation. Add the
interrupt property too, because that's required but nobody noticed when
the non-YAML binding was introduced.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Changes from v1:
 * Dropped spi-max-frequency as required
 * Capped spi-max-frequency at 1MHz
 * Added interrupt-parent to example to be realistic

 .../bindings/security/tpm/google,cr50.txt     | 19 -------
 .../bindings/security/tpm/google,cr50.yaml    | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
 create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.yaml

diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
deleted file mode 100644
index cd69c2efdd37..000000000000
--- a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* H1 Secure Microcontroller with Cr50 Firmware on SPI Bus.
-
-H1 Secure Microcontroller running Cr50 firmware provides several
-functions, including TPM-like functionality. It communicates over
-SPI using the FIFO protocol described in the PTP Spec, section 6.
-
-Required properties:
-- compatible: Should be "google,cr50".
-- spi-max-frequency: Maximum SPI frequency.
-
-Example:
-
-&spi0 {
-	tpm@0 {
-		compatible = "google,cr50";
-		reg = <0>;
-		spi-max-frequency = <800000>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.yaml b/Documentation/devicetree/bindings/security/tpm/google,cr50.yaml
new file mode 100644
index 000000000000..31a5b0740a7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/security/tpm/google,cr50.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/tpm/google,cr50.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: H1 Secure Microcontroller with Cr50 Firmware on SPI Bus
+
+description:
+  H1 Secure Microcontroller running Cr50 firmware provides several functions,
+  including TPM-like functionality. It communicates over SPI using the FIFO
+  protocol described in the PTP Spec, section 6.
+
+maintainers:
+  - Andrey Pronin <apronin@chromium.org>
+
+properties:
+  compatible:
+    const: google,cr50
+
+  reg: true
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+      #address-cells = <0x1>;
+      #size-cells = <0x0>;
+      tpm@0 {
+          compatible = "google,cr50";
+          reg = <0>;
+          spi-max-frequency = <1000000>;
+          interrupt-parent = <&gpio_controller>;
+          interrupts = <50 IRQ_TYPE_EDGE_RISING>;
+      };
+    };
+...
-- 
Sent by a computer, using git, on the internet

