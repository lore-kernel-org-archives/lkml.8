Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0BAC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652BC2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puIBDqJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgBEAHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:07:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40045 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgBEAH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:07:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so83396plp.7;
        Tue, 04 Feb 2020 16:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j/Ku8B9Qr+kQIDeYMGdjbQdZuNDZp/3dsOQZapgb5l0=;
        b=puIBDqJg+eXqX8nYBtw/bkm2+Z7h/fw+YJFBNnP6/hdde8A+TsEnMhjJtXMdE0j4Uh
         nMyFsWmqIEFYkKcRd+2ymE4OQCuuONUoD+xixXU+fhKKI30bwwXh0dkvPsQl7y+Vw0Wv
         b5zd+IqWqGI9AEpgPUXj1F4LKV3b+HPQzAzJH8fkn4NUcIxHS6Tx5FYnKPIKoeZc6mmX
         1Im+xJNFAp8ArvN/E2LXcyX6DpedyPPuImJ+bGUUU2QlHKvze7oRV/YCjvC+j+Kd3c4Y
         gIragZeNvm+5SsxBdDWuft3sj3aajxhHE+yxy+7I+z7VXOGkknBoZN9MAmVyCR+e3yLA
         6uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j/Ku8B9Qr+kQIDeYMGdjbQdZuNDZp/3dsOQZapgb5l0=;
        b=edKzEDMabuSkWUgujR7tuA7YQhMf4tAWeD4YK0+yRBBWi1ijjQiqqnvUBTVO5lrAyV
         F3V9L7fjHBVB3Qi2zAXKf0EOU4hqiogZ4Obnsm1frr7dRSo5IrJf8Btt8/3bRGbZ1q0t
         y8tSZub3IikZxx7aNRWznOc99b3YtowW1qrUAk734fXCO00h5K2hdJZuOt8t0ZibISH+
         fxnYPNyiVK3RFdI7gI2jQGRdM2+ZpYE3M/PBlmQiG/1RyyV0ThHCwmAwtKYbQ39ZMS4q
         bF+hZVx83xj6mj1bTLTtyrOgFCEnKxWTpDUjbuVv6aWs6zxG5GNqyLykLxXBQtfhFN50
         UUEQ==
X-Gm-Message-State: APjAAAWGHIIjnmn3JaUlJX8iN6uLN/vavAqNZ7XN3vGGuqJUX5/8QnGl
        fWcTl+3kaqUf/eLwcEZ5vPM=
X-Google-Smtp-Source: APXvYqwQcg6bMiHxRctNlJLi7ARBxfRZwq7QNImw2mutKJl+gsQUxTccPJQXv487JwMRS0XOEDbe0w==
X-Received: by 2002:a17:902:8bc7:: with SMTP id r7mr29014884plo.12.1580861248342;
        Tue, 04 Feb 2020 16:07:28 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id g2sm25575468pgn.59.2020.02.04.16.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:07:27 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE), Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Sugaya Taichi <sugaya.taichi@socionext.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Maxime Ripard <mripard@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        "james.tai" <james.tai@realtek.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v2 02/12] dt-bindings: arm: bcm: Convert Hurricane 2 to YAML
Date:   Tue,  4 Feb 2020 15:55:42 -0800
Message-Id: <20200204235552.7466-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200204235552.7466-1-f.fainelli@gmail.com>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadcom Hurricane 2 SoC binding document for boards/SoCs to use
YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/arm/bcm/brcm,hr2.txt  | 14 ----------
 .../devicetree/bindings/arm/bcm/brcm,hr2.yaml | 28 +++++++++++++++++++
 2 files changed, 28 insertions(+), 14 deletions(-)
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
index 000000000000..1158f49b0b83
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,hr2.yaml
@@ -0,0 +1,28 @@
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
+    items:
+      - enum:
+        - ubnt,unifi-switch8
+      - const: brcm,bcm53342
+      - const: brcm,hr2
+
+...
-- 
2.19.1

