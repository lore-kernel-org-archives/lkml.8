Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899B8C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8AB2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti2FtfJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgBEAHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:07:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35246 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbgBEAHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:07:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id g6so93066plt.2;
        Tue, 04 Feb 2020 16:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xy9neKY+qvsY0GTBRTsRimyTOioxmSqME5XU6N4LU3s=;
        b=Ti2FtfJezQkJeoAyfzKhepKSCTUuIOkCYcaCB4Pl7Wn+7NIpq5ndjx8RrIbkw7P2I+
         nqufOgXEjyQ9yajE6vHccQEKXXbLfsRp52UbiDDKQ77JyYR6ZpEblAvWBvJmLstwVQgt
         Dz7VbK/l/SuhrHdsspb25jOl21o4sM2EUEf3hAqhu8yLh/KrxbYYQCdCOMrVEqJMtxhh
         usjDyE1E9KNltxDx11+0bqxaTpHNsaeywpzKkw3264WZJyJiDbjS3rUkYtXDJ7fN04/6
         m9yA3kMfa55KSnJO8U2lpus+CQVjdKKqGFLyrShq4oRjLY0Lwz8iGTciOd3wmRL7Jt0d
         /X4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xy9neKY+qvsY0GTBRTsRimyTOioxmSqME5XU6N4LU3s=;
        b=mHYfORkcj+QxReQpBPIbcMxadHkAublve32JcrZzRtJqqzoYa0YkuDvOTlbUXKH3rN
         arWPZkW9QcqoNCvu72pneyqCB6GLNwmdP58ZM6yfVMkn4h1dyhIgiQG0P0d5nwUETYJS
         0zaqI1ZPc4JM9KqrHdI4b6grD4XEzJngwpQL3Ub8A5XnoPEkIsf9Pq1C0jLK4Z9dNKce
         DsTixpQIu5ooKQEoVYaQ33E7l5SHAZ4tj5X6v4kVsqx8bDBpp37SfavaVy4qWTHqqKwe
         /d2U1KonoOkEiYGROOzzCpYbjkdiINSb1PofckGto37IM+AcuEaQep0dY6nWinOIVB+Z
         IZiQ==
X-Gm-Message-State: APjAAAUNX6v6nzBFXKH/nScD0B7cqSV9hIbiq6b23b3qDNAPZmpRce2v
        wzVJ/eU0hf5SMOxacRzpo0k=
X-Google-Smtp-Source: APXvYqyBs/noppCZUBoSmP/i2D6fgztkqlGLtnvnbKInlX4dL6XLl0QIvoeWWFC42Uzl8LEDSrHCjQ==
X-Received: by 2002:a17:902:6944:: with SMTP id k4mr18346685plt.214.1580861250019;
        Tue, 04 Feb 2020 16:07:30 -0800 (PST)
Received: from localhost.localdomain (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id g2sm25575468pgn.59.2020.02.04.16.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 16:07:29 -0800 (PST)
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
Subject: [PATCH v2 03/12] dt-bindings: arm: bcm: Convert Northstar Plus to YAML
Date:   Tue,  4 Feb 2020 15:55:43 -0800
Message-Id: <20200204235552.7466-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200204235552.7466-1-f.fainelli@gmail.com>
References: <20200204235552.7466-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Broadcom Northstar Plus SoC binding document for boards/SoCs
to use YAML. Verified with dt_binding_check and dtbs_check.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/arm/bcm/brcm,nsp.txt  | 34 ------------------
 .../devicetree/bindings/arm/bcm/brcm,nsp.yaml | 36 +++++++++++++++++++
 2 files changed, 36 insertions(+), 34 deletions(-)
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
index 000000000000..fe364cebf57f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
@@ -0,0 +1,36 @@
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
+    items:
+      - enum:
+        - brcm,bcm58522
+        - brcm,bcm58525
+        - brcm,bcm58535
+        - brcm,bcm58622
+        - brcm,bcm58623
+        - brcm,bcm58625
+        - brcm,bcm88312
+      - const: brcm,nsp
+
+...
-- 
2.19.1

