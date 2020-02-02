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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4FEC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A2520658
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u2r5sGNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBBVTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:19:05 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37984 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgBBVTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:19:04 -0500
Received: by mail-pj1-f68.google.com with SMTP id j17so5470584pjz.3;
        Sun, 02 Feb 2020 13:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nME4UAiyqLh/Z+MjnFvU6rmtlnJJbRyaB2eoYcoPeR8=;
        b=u2r5sGNLhsEZIkA1O36hVJdEuyLiixyE3knkt8AjtlD5EqZAJi5fN5O1dP/AJLOtm2
         1hdfQj3Gp68oojMSLET6znQvJyocBnxqc9gxIeprx09nORZibJI9Ng3CDWwaWzbPSTVy
         OXey57EMP/WwpK4K49hkFObnACgz4bq7h1lfD1BRUOHjpr+FdAeScbZTaPbY7Vcn8+aF
         rUI5ks7HG33MdJ8UzvIYmol3sGN2Z+DroyZthHgB5gJQMNsJJy0yW3pcdailzKpzGGEs
         gmYZOiv2eZRUAurNIMvZichT8JDNvbkh7FOs91qVI/Kwy9kfW60p/uqO7p51uiqIk0T2
         zJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nME4UAiyqLh/Z+MjnFvU6rmtlnJJbRyaB2eoYcoPeR8=;
        b=B8atvuYtwUOyA6VboE/oTPHIU/NHRC+0q4XydjMEyG0y90M1GDm08fIfr+iD4vjs7Q
         AohW+4tj7SSAoquGn2knPZEt1amOlfaVxA2MJPjsQEZ/AY/YvuBgo+qqbXPzV/oHXLkN
         i+JRFkv/z5Nv4VhP1ZNu3WjylxjuJkVslohy4JPwEsfO55gRJloaEnFdi8LmvPitcIUk
         ZnpWqmQyZmSlbR5kPAkpvE0iuU9a+sw9/Fl09/X+t05JCeahU8EAjn39DCqzPnyo3wdu
         47RQ7URd1nfwsKtyvjIzYSyJu+EZkbXS9rqG5ttyxy6yESm0y1PYjjt5YrGMaguz796F
         fiLg==
X-Gm-Message-State: APjAAAUkZzU+bKBAcCJie+le9dIPzYKDsJN7oBZh0kULIbFdF5B+Dztd
        30vsEKy8f1GZ575q8DqgDXgS3BQH
X-Google-Smtp-Source: APXvYqz3mAk+fb8Lm122pYlg0JTJXIatyW2WXJIFxF3SI5w/XJAdJAztUgAIr7JigfBZ72dcns9g3g==
X-Received: by 2002:a17:90a:8c0f:: with SMTP id a15mr26321514pjo.86.1580678342786;
        Sun, 02 Feb 2020 13:19:02 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y24sm8755639pge.72.2020.02.02.13.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:19:02 -0800 (PST)
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
Subject: [PATCH 03/12]  dt-bindings: arm: bcm: Convert Northstar Plus to YAML
Date:   Sun,  2 Feb 2020 13:18:18 -0800
Message-Id: <20200202211827.27682-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202211827.27682-1-f.fainelli@gmail.com>
References: <20200202211827.27682-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadcom Northstar Plus SoC binding document for boards/SoCs
to use YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/arm/bcm/brcm,nsp.txt  | 34 ----------
 .../devicetree/bindings/arm/bcm/brcm,nsp.yaml | 68 +++++++++++++++++++
 2 files changed, 68 insertions(+), 34 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp.txt
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.txt b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.txt
deleted file mode 100644
index eae53e4556be..000000000000
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-Broadcom Northstar Plus device tree bindings
---------------------------------------------
-
-Broadcom Northstar Plus family of SoCs are used for switching control
-and management applications as well as residential router/gateway
-applications. The SoC features dual core Cortex A9 ARM CPUs, integrating
-several peripheral interfaces including multiple Gigabit Ethernet PHYs,
-DDR3 memory, PCIE Gen-2, USB 2.0 and USB 3.0, serial and NAND flash,
-SATA and several other IO controllers.
-
-Boards with Northstar Plus SoCs shall have the following properties:
-
-Required root node property:
-
-BCM58522
-compatible = "brcm,bcm58522", "brcm,nsp";
-
-BCM58525
-compatible = "brcm,bcm58525", "brcm,nsp";
-
-BCM58535
-compatible = "brcm,bcm58535", "brcm,nsp";
-
-BCM58622
-compatible = "brcm,bcm58622", "brcm,nsp";
-
-BCM58623
-compatible = "brcm,bcm58623", "brcm,nsp";
-
-BCM58625
-compatible = "brcm,bcm58625", "brcm,nsp";
-
-BCM88312
-compatible = "brcm,bcm88312", "brcm,nsp";
diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
new file mode 100644
index 000000000000..d76b9b14f000
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/bcm/brcm,nsp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Northstar Plus device tree bindings
+
+description:
+  Broadcom Northstar Plus family of SoCs are used for switching control
+  and management applications as well as residential router/gateway
+  applications. The SoC features dual core Cortex A9 ARM CPUs, integrating
+  several peripheral interfaces including multiple Gigabit Ethernet PHYs,
+  DDR3 memory, PCIE Gen-2, USB 2.0 and USB 3.0, serial and NAND flash,
+  SATA and several other IO controllers.
+
+maintainers:
+  - Ray Jui <rjui@broadcom.com>
+  - Scott Branden <sbranden@broadcom.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: BCM58522 based boards
+        items:
+          - enum:
+              - brcm,bcm58522
+          - const: brcm,nsp
+
+      - description: BCM58525 based boards
+        items:
+          - enum:
+              - brcm,bcm58525
+          - const: brcm,nsp
+
+      - description: BCM58535 based boards
+        items:
+          - enum:
+              - brcm,bcm58535
+          - const: brcm,nsp
+
+      - description: BCM58622 based boards
+        items:
+          - enum:
+              - brcm,bcm58622
+          - const: brcm,nsp
+
+      - description: BCM58623 based boards
+        items:
+          - enum:
+              - brcm,bcm58623
+          - const: brcm,nsp
+
+      - description: BCM58625 based boards
+        items:
+          - enum:
+              - brcm,bcm58625
+          - const: brcm,nsp
+
+      - description: BCM88312 based boards
+        items:
+          - enum:
+              - brcm,bcm88312
+          - const: brcm,nsp
+
+...
-- 
2.17.1

