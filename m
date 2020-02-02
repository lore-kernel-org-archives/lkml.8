Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31915C3524C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061A12080D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nt5+uO3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgBBVTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:19:03 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37451 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgBBVTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:19:02 -0500
Received: by mail-pj1-f65.google.com with SMTP id m13so5483947pjb.2;
        Sun, 02 Feb 2020 13:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dVjYnHw70XUXU3c67MvoOFQ8EAFS/KI8ArVkSbB6cxA=;
        b=nt5+uO3uvQfFH6bhVxg5TiyDngiWIuV3mpB5ejA7TYQrGPuNCusKtAdS5/smr2q+op
         KW68nkCG1kWC2mqq9EgEaJg/oe3EhIkmkz3b3RX7eWTWn+l8KlPGr2mepfeVPLAwSXCW
         ye3bt70OFCp86ly/5VTlEbxXu8l6iSHyFb/rDtB+VHIivFhAf4q095pyeFD9Eznk/L2l
         AICwMBvdPMC+3kYh5Ha9Xdlibd4Iy1Ootb5QOeJ+IJPh03RuuTKVqNpqqrcern5xm/bQ
         Ki/KKgeS2aenOOqcM7EjKSHA+ugxfZfTH40gVH69VEPJ0L+31zsbv26n4oJs6QkWon0L
         8kUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dVjYnHw70XUXU3c67MvoOFQ8EAFS/KI8ArVkSbB6cxA=;
        b=tC5KHAkV4uKQBtp1jOZ9bk3/nln49Y8PoUl2+Yb9ODvLl2OXnSfnLcHVfXEfvM2Jxi
         SEyRfOQpVIddgwSlT9i+GIs4TMT0b5801f7oV+2Gwbj7Bj49sqfGFQQd3uM0aNKscZ4a
         +OdwYGpI/aMyFV8BbsoGG8SXOypAHyp73RLepSePLU4jyl2rjWi1/WQ4/1T+6AMUstWy
         LbUwL/MQKE3z6lNj4xNuSlUBEFyAzgNWFOnbnof04rbDHVU85Bq5NYQuZ+hbhDcKhitV
         xXxbPWf95LMgdkXdEAOHF4UrlsUmGrH1YuX1UhBnm2Mov26wJ2x6bP2Zy0sIhT7SThVU
         S4RQ==
X-Gm-Message-State: APjAAAU3HYpRysxdpYS8dvlL8NbDlcWsITivJ7QUKr/GjS1+qtxI+TT0
        1vdhqhkAOcBj2eeW+AfBlj0eZbP6
X-Google-Smtp-Source: APXvYqzPWHOtI91WaVVL+3osBRU9fvO2iHBSn6UYO6hNoS4rzkD4yzEr4HhAzAzO20wyjw3+U49ivw==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr20509867plz.269.1580678341205;
        Sun, 02 Feb 2020 13:19:01 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y24sm8755639pge.72.2020.02.02.13.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:19:00 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE), Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Jeffery <andrew@aj.id.au>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM IPROC ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH 02/12] dt-bindings: arm: bcm: Convert Hurricane 2 to YAML
Date:   Sun,  2 Feb 2020 13:18:17 -0800
Message-Id: <20200202211827.27682-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202211827.27682-1-f.fainelli@gmail.com>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadcom Hurricane 2 SoC binding document for boards/SoCs to use
YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/arm/bcm/brcm,hr2.txt  | 14 ---------
 .../devicetree/bindings/arm/bcm/brcm,hr2.yaml | 30 +++++++++++++++++++
 2 files changed, 30 insertions(+), 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,hr2.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,hr2.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,hr2.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,hr2.txt
deleted file mode 100644
index a124c7fc4dcd..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,hr2.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-Broadcom Hurricane 2 device tree bindings
----------------------------------------
-
-Broadcom Hurricane 2 family of SoCs are used for switching control. These SoCs
-are based on Broadcom's iProc SoC architecture and feature a single core Cortex
-A9 ARM CPUs, DDR2/DDR3 memory, PCIe GEN-2, USB 2.0 and USB 3.0, serial and NAND
-flash and a PCIe attached integrated switching engine.
-
-Boards with Hurricane SoCs shall have the following properties:
-
-Required root node property:
-
-BCM53342
-compatible = "brcm,bcm53342", "brcm,hr2";
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,hr2.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,hr2.yaml
new file mode 100644
index 000000000000..90332ca0c74a
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,hr2.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bcm/brcm,hr2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Hurricane 2 device tree bindings
+
+description:
+  Broadcom Hurricane 2 family of SoCs are used for switching control. These SoCs
+  are based on Broadcom's iProc SoC architecture and feature a single core Cortex
+  A9 ARM CPUs, DDR2/DDR3 memory, PCIe GEN-2, USB 2.0 and USB 3.0, serial and NAND
+  flash and a PCIe attached integrated switching engine.
+
+maintainers:
+  - Florian Fainelli <f.fainelli@gmail.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: BCM53342 based boards
+        items:
+          - enum:
+              - ubnt,unifi-switch8
+          - const: brcm,bcm53342
+          - const: brcm,hr2
+
+...
-- 
2.17.1

